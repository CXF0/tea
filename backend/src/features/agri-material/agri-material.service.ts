import { AppError } from "../../shared/errors.js";import * as repo from "./agri-material.repository.js";const n=(v:unknown)=>Number(v??0);const status=(v:number)=>({1:'待发货',2:'待签收',3:'已签收'}[v]||'未知');
export async function filters(date:string){const d=await repo.filters(date);return{bases:d.bases.map(x=>String(x.name)),suppliers:d.suppliers.map(x=>({id:n(x.id),name:String(x.name)}))}}
export async function orders(date:string,orderStatus:number,keyword:string,baseName:string,supplierId:number){return(await repo.listOrders(date,orderStatus,keyword,baseName,supplierId)).map(x=>({orderId:String(x.order_id),date:String(x.date),baseName:String(x.base_name),buySupplierName:String(x.buy_supplier_name),peasantSupplierName:String(x.peasant_supplier_name),receiveTel:String(x.receive_tel),goodsCount:n(x.goods_count),itemCount:n(x.item_count),totalPrice:n(x.total_price),orderStatus:n(x.order_status),statusLabel:status(n(x.order_status)),createTime:x.create_time}))}
export async function detail(orderId:string){const d=await repo.findOrder(orderId);if(!d.order)throw new AppError(404,'AGRI_ORDER_NOT_FOUND','农资订单不存在');const o=d.order;return{order:{orderId:String(o.order_id),date:String(o.date),baseName:String(o.base_name),buySupplierName:String(o.buy_supplier_name),peasantSupplierName:String(o.peasant_supplier_name),receiveName:String(o.receive_name),receiveTel:String(o.receive_tel),receiveAddress:String(o.receive_address),buyerMemo:String(o.buyer_memo),totalPrice:n(o.total_price),orderStatus:n(o.order_status),statusLabel:status(n(o.order_status)),createTime:o.create_time,shipTime:o.ship_time,completeTime:o.complete_time,completeUserName:String(o.complete_user_name||''),completePic:String(o.complete_pic||'')},items:d.items.map(x=>({id:n(x.id),image:String(x.img||''),goodsInfo:String(x.goods_info),skuInfo:String(x.sku_info),remark:String(x.remark||''),quantity:n(x.num),price:n(x.price),totalPrice:n(x.total_price)}))}}
export async function labels(date:string,supplierId:number){return(await repo.printRows(date,supplierId)).map(x=>({orderId:String(x.order_id),baseName:String(x.base_name),sessionDate:String(x.session_date),supplierId:n(x.peasant_supplier_id),supplierName:String(x.supplier_name),goodsCount:n(x.goods_count),qrContent:`nz:${x.order_id}`}))}

function formatDate(value:Date){
  const y=value.getFullYear();
  const m=String(value.getMonth()+1).padStart(2,'0');
  const d=String(value.getDate()).padStart(2,'0');
  return `${y}-${m}-${d}`;
}
function previousPeriod(mode:string,date:string){
  const d=new Date(`${date}T00:00:00`);
  if(mode==='month')d.setMonth(d.getMonth()-1);
  else d.setDate(d.getDate()-1);
  return formatDate(d);
}
function rate(current:number,previous:number){
  if(!previous)return current>0?100:0;
  return Math.round(((current-previous)/previous)*1000)/10;
}
function metric(current:number,previous:number){
  return{value:current,compareRate:rate(current,previous)};
}
export async function dashboard(date:string,modeInput:string){
  const mode=modeInput==='month'?'month':'day';
  const compareDate=previousPeriod(mode,date);
  const overview=await repo.dashboardOverview(mode,date,compareDate);
  const current=overview.current,previous=overview.previous;
  const productRows=await repo.dashboardProductSales(mode,date);
  const productTotal=productRows.reduce((sum,x)=>sum+n(x.amount),0);
  const top=productRows.slice(0,4);
  const other=productRows.slice(4).reduce((sum,x)=>({name:'其他',quantity:sum.quantity+n(x.quantity),amount:sum.amount+n(x.amount)}),{name:'其他',quantity:0,amount:0});
  const products=[...top.map(x=>({name:String(x.name),quantity:n(x.quantity),amount:n(x.amount)})),...(other.amount>0?[other]:[])].map(x=>({
    ...x,
    percent:productTotal?Math.round((x.amount/productTotal)*10000)/100:0,
  }));
  const trendRows=await repo.dashboardSalesTrend(date);
  const trendMap=new Map(trendRows.map(x=>[String(x.date),x]));
  const trend=Array.from({length:7},(_,index)=>{
    const d=new Date(`${date}T00:00:00`);
    d.setDate(d.getDate()-6+index);
    const key=formatDate(d);
    const row=trendMap.get(key);
    return{date:key,orderCount:n(row?.order_count),salesAmount:n(row?.sales_amount)};
  });
  return{
    mode,
    date,
    overview:{
      orderCount:metric(n(current.order_count),n(previous.order_count)),
      salesAmount:metric(n(current.sales_amount),n(previous.sales_amount)),
      supplierCount:metric(n(current.supplier_count),n(previous.supplier_count)),
      baseCount:metric(n(current.base_count),n(previous.base_count)),
    },
    productSales:{totalAmount:productTotal,items:products},
    salesTrend:trend,
  };
}
