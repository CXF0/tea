import { test, before, after } from 'node:test'
import assert from 'node:assert/strict'
import { mkdtempSync, rmSync, readFileSync, readdirSync } from 'node:fs'
import { tmpdir } from 'node:os'
import { join } from 'node:path'
import { execFileSync } from 'node:child_process'

const temp=mkdtempSync(join(tmpdir(),'menghua-test-'))
process.env.SQLITE_PATH=join(temp,'test.sqlite')
let app, database, headers, date
before(async()=>{
  execFileSync(process.execPath,['backend/scripts/init-sqlite.mjs'],{cwd: new URL('../../',import.meta.url),env:process.env,stdio:'pipe'})
  ;({database}=await import('../dist/database.js'))
  const {buildApp}=await import('../dist/app.js')
  app=buildApp({logger:false}); await app.ready()
  const response=await app.inject({method:'POST',url:'/api/auth/login',payload:{loginName:'admin',password:'123456'}})
  assert.equal(response.statusCode,200,response.body)
  const session=response.json().data
  headers={authorization:`Bearer ${session.token}`,'x-user-id':String(session.userId),'x-user-name':'demo-test'}
  const [[baseline]]=await database.query('SELECT date FROM xm_bulky_supplier_enter WHERE supplier_id=9401 LIMIT 1')
  date=baseline.date
})
after(async()=>{if(app)await app.close();rmSync(temp,{recursive:true,force:true})})
async function request(method,url,payload,expected=200){
 const response=await app.inject({method,url,payload,headers})
 assert.equal(response.statusCode,expected,`${method} ${url}: ${response.body}`)
 return response.json().data
}

test('SQLite health, login, bad credentials, and repeatable initialization',async()=>{
 const health=await app.inject('/api/health');assert.equal(health.statusCode,200);assert.match(health.json().database.name,/sqlite/)
 await request('POST','/api/auth/login',{loginName:'admin',password:'wrong'},401)
 const [[before]]=await database.query('SELECT COUNT(*) count FROM wms_account')
 const output=execFileSync(process.execPath,['backend/scripts/init-sqlite.mjs'],{env:process.env,stdio:'pipe'}).toString()
 assert.match(output,/existing data preserved/)
 const [[after]]=await database.query('SELECT COUNT(*) count FROM wms_account');assert.equal(after.count,before.count)
})

test('85 list/read endpoints execute against the seeded SQLite database',async()=>{
 let count=0
 const root=new URL('../src/features/',import.meta.url)
 for(const feature of readdirSync(root,{withFileTypes:true}).filter(d=>d.isDirectory())){
  const folder=new URL(feature.name+'/',root)
  for(const file of readdirSync(folder).filter(name=>name.endsWith('.routes.ts'))){
   const source=readFileSync(new URL(file,folder),'utf8')
   const prefix='/api/'+(feature.name==='site-location'?'site-locations':feature.name)
   for(const [,path] of source.matchAll(/app\.get\(\s*['"]([^'"]+)/g)){
    if(path.includes(':') || prefix+path==='/api/base-stocktaking/suppliers')continue
    await request('GET',`${prefix}${path}?date=${date}&startDate=${date}&endDate=${date}&category=core&part=${encodeURIComponent('库房')}`)
    count++
   }
  }
 }
 assert.equal(count,85)
 const overview=await request('GET','/api/carton-inventory/overview');assert.ok(overview.stocks.length>=8)
 const records=await request('GET',`/api/admission/records?date=${date}`);assert.ok(records.length>0)
 const shelves=await request('GET',`/api/distribution/shelves?date=${date}&warehouseType=normal`);assert.ok(shelves.length>0)
})

test('admission status persists through the API',async()=>{
 const [[entry]]=await database.query('SELECT id FROM xm_bulky_supplier_enter WHERE date=? LIMIT 1',[date])
 await request('PUT',`/api/admission/records/${entry.id}/status`,{status:0})
 let [[saved]]=await database.query('SELECT data_status FROM xm_bulky_supplier_enter WHERE id=?',[entry.id]);assert.equal(saved.data_status,0)
 await request('PUT',`/api/admission/records/${entry.id}/status`,{status:1})
 ;[[saved]]=await database.query('SELECT data_status FROM xm_bulky_supplier_enter WHERE id=?',[entry.id]);assert.equal(saved.data_status,1)
})

test('inventory inbound/outbound updates stock and records traces; overselling rolls back',async()=>{
 const [[sku]]=await database.query("SELECT * FROM wms_sku_inventory WHERE part='库房' AND status=0 AND category=1 LIMIT 1")
 const payload={skuId:sku.id,part:'库房',quantity:5,reason:'SQLite test',remark:'automated demonstration'}
 await request('POST','/api/carton-inventory/inbound',payload)
 let [[stock]]=await database.query('SELECT entry_stock FROM wms_sku_inventory WHERE id=?',[sku.id]);assert.equal(Number(stock.entry_stock),Number(sku.entry_stock)+5)
 await request('POST','/api/carton-inventory/outbound',{...payload,quantity:2,recipient:'演示领用人',reasonType:1})
 ;[[stock]]=await database.query('SELECT entry_stock FROM wms_sku_inventory WHERE id=?',[sku.id]);assert.equal(Number(stock.entry_stock),Number(sku.entry_stock)+3)
 await request('POST','/api/carton-inventory/outbound',{...payload,quantity:10000000,recipient:'演示领用人'},409)
 const [[after]]=await database.query('SELECT entry_stock FROM wms_sku_inventory WHERE id=?',[sku.id]);assert.equal(after.entry_stock,stock.entry_stock)
 const traces=await request('GET',`/api/carton-inventory/traces/outbound?skuId=${sku.id}`);assert.ok(traces.some(row=>row.quantity===2))
})

test('distribution bulk UPSERT is repeatable and cancellation restores allocation',async()=>{
 const [[item]]=await database.query('SELECT id,item_num FROM xm_bulky_supplier_enter_item WHERE date=? AND data_status=0 AND prepare_item_num=0 LIMIT 1',[date])
 assert.ok(item)
 for(let n=0;n<2;n++)await request('PUT',`/api/distribution/items/${item.id}/allocation`,{units:[1,2],allocated:true})
 let [[allocated]]=await database.query('SELECT COUNT(*) count FROM xm_quality_unit_allocation WHERE enter_item_id=? AND allocated=1',[item.id]);assert.equal(allocated.count,2)
 await request('PUT',`/api/distribution/items/${item.id}/allocation`,{units:[1,2],allocated:false})
 ;[[allocated]]=await database.query('SELECT COUNT(*) count FROM xm_quality_unit_allocation WHERE enter_item_id=? AND allocated=1',[item.id]);assert.equal(allocated.count,0)
})

test('quality marking writes evidence and can be revoked',async()=>{
 const [[item]]=await database.query('SELECT id FROM xm_bulky_supplier_enter_item WHERE date=? AND data_status=0 AND not_qualify_num=0 LIMIT 1',[date])
 const [[reason]]=await database.query('SELECT id FROM xm_inspection_reason_config WHERE level=2 AND data_status=0 LIMIT 1')
 await request('PUT',`/api/quality/supplier-items/${item.id}/inspection`,{status:10,affectedUnits:[1],reasonIds:[reason.id],operation:6,evidenceMedia:[],allowDowngradeRestock:true})
 const detail=await request('GET',`/api/quality/supplier-items/${item.id}`);assert.equal(detail.unqualifiedQuantity,1);assert.equal(detail.unitMarks[0].unit,1)
 await request('PUT',`/api/quality/supplier-items/${item.id}/inspection-revoke`,{units:[1]})
 const cleared=await request('GET',`/api/quality/supplier-items/${item.id}`);assert.equal(cleared.unqualifiedQuantity,0)
})

test('cold storage completion decrements exactly once and rejects repeated completion',async()=>{
 const [[task]]=await database.query('SELECT t.*,s.remaining_bunch_num FROM xm_bulky_cold_out_task t JOIN xm_bulky_cold_stock s ON s.id=t.cold_stock_id WHERE t.task_status=10 AND t.store_type=2 AND t.data_status=0 LIMIT 1')
 assert.ok(task)
 const {finishOutTask}=await import('../dist/features/cold-storage/cold-storage.repository.js')
 const quantity=Number(task.out_bunch_num)
 const result=await finishOutTask(task.id,quantity,[],'SQLite test',{userId:Number(headers['x-user-id']),userName:'test'})
 assert.equal(result.kind,'success')
 const [[stock]]=await database.query('SELECT remaining_bunch_num FROM xm_bulky_cold_stock WHERE id=?',[task.cold_stock_id])
 assert.equal(stock.remaining_bunch_num,Math.max(0,task.remaining_bunch_num-quantity))
 assert.equal((await finishOutTask(task.id,quantity,[],'test',{userId:1,userName:'test'})).kind,'finished')
})

test('transaction ownership queues concurrent reads; rollback does not leak partial writes',async()=>{
 await database.query('CREATE TABLE _transaction_test (id INTEGER PRIMARY KEY, amount INTEGER CHECK(amount>0))')
 const c=await database.getConnection()
 try{
  await c.beginTransaction();await c.query('INSERT INTO _transaction_test VALUES (?,?)',[1,10])
  let complete=false
  const read=database.query('SELECT COUNT(*) count FROM _transaction_test').then(rows=>{complete=true;return rows})
  await new Promise(resolve=>setTimeout(resolve,20));assert.equal(complete,false)
  await assert.rejects(c.query('INSERT INTO _transaction_test VALUES (?,?)',[2,-1]))
  await c.rollback();c.release()
  const [[result]]=await read;assert.equal(result.count,0)
 }finally{c.release()}
})

test('parameter arrays, quoted question marks, grouping order, and date offsets retain semantics',async()=>{
 const [rows]=await database.query("SELECT '?' marker,id FROM wms_account WHERE id IN (?) ORDER BY id",[[1,2]])
 assert.equal(rows[0].marker,'?');assert.equal(rows.length,2)
 const [[group]]=await database.query("SELECT GROUP_CONCAT(DISTINCT display_name ORDER BY id DESC SEPARATOR '、') names FROM wms_account WHERE id IN (?)",[[1,2]])
 assert.ok(group.names.includes('、'))
 const [[date]]=await database.query("SELECT DATE_FORMAT(DATE_SUB(?,INTERVAL 1 DAY),'%Y-%m-%d') previous",['2026-10-14'])
 assert.equal(date.previous,'2026-10-13')
})
