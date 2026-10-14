"""Prepare reusable DML from the uploaded migrations and demo seeds.
Requires sqlglot 27.29.0 only for regenerating data-statements.json.
"""
from pathlib import Path
import re,json
import sqlglot
from sqlglot import exp
root=Path(__file__).resolve().parents[3]
def split(source):
    statements=[];buffer=[];quote='';i=0
    while i<len(source):
        c=source[i]
        if quote:
            buffer.append(c)
            if c==quote:
                if source[i+1:i+2]==quote:buffer.append(source[i+1]);i+=1
                else:quote=''
            elif c=='\\' and i+1<len(source):buffer.append(source[i+1]);i+=1
        elif c in "'\"`":quote=c;buffer.append(c)
        elif source[i:i+2]=='--':
            end=source.find('\n',i);i=len(source) if end<0 else end;buffer.append('\n');continue
        elif source[i:i+2]=='/*':
            end=source.find('*/',i+2);assert end>=0;i=end+2;buffer.append(' ');continue
        elif c==';':
            s=''.join(buffer).strip()
            if s:statements.append(s)
            buffer=[]
        else:buffer.append(c)
        i+=1
    if ''.join(buffer).strip():statements.append(''.join(buffer).strip())
    return statements

def convert_join(s):
    if not re.match(r'UPDATE\b|DELETE\s+\w+\s+FROM',s,re.I):return s
    x=sqlglot.parse_one(s,read='mysql')
    joins=x.this.args.get('joins',[])
    if not joins:return s
    table=x.this.copy();table.set('joins',None)
    target=table.sql(dialect='mysql')
    alias=table.alias_or_name
    source=x.this.sql(dialect='mysql')
    where=alias+'.rowid=sqlite_target.rowid'
    if x.args.get('where'):where+=' AND ('+x.args['where'].this.sql(dialect='mysql')+')'
    if isinstance(x,exp.Update):
        assignments=[]
        for a in x.expressions:
            lhs=a.this.copy()
            if isinstance(lhs,exp.Column):lhs.set('table',None)
            assignments.append(lhs.sql(dialect='mysql')+'=(SELECT '+a.expression.sql(dialect='mysql')+' FROM '+source+' WHERE '+where+')')
        return 'UPDATE '+table.name+' AS sqlite_target SET '+','.join(assignments)+' WHERE EXISTS(SELECT 1 FROM '+source+' WHERE '+where+')'
    return 'DELETE FROM '+table.name+' AS sqlite_target WHERE EXISTS(SELECT 1 FROM '+source+' WHERE '+where+')'

priority=['20260917_add_quality_punish_config.sql','20260918_wms_auth_foundation.sql','20260918_add_cold_storage_permissions.sql','20260920_expand_wms_roles_accounts.sql','20260920_split_quality_entry_permissions.sql','20260920_permission_tree.sql']
migrations=[root/'database'/name for name in priority]+[f for f in sorted((root/'database').glob('2026*.sql')) if f.name not in priority]
for early, before in [('20260922_super_admin.sql','20260922_site_and_team_distribution_progress_cards.sql'), ('20260922_system_access_management.sql','20260922_site_and_team_distribution_progress_cards.sql')]:
    item=root/'database'/early; migrations.remove(item);migrations.insert(migrations.index(root/'database'/before),item)
files=sorted((root/'database/seeds').glob('*.sql'))+migrations
entries=[]
for file in files:
    for s in split(file.read_text()):
        if re.match(r'USE\b|CREATE\b|ALTER\b|DROP\b|PREPARE\b|EXECUTE\b|DEALLOCATE\b|START TRANSACTION|COMMIT|SET\s+(NAMES|SESSION|FOREIGN_KEY)',s,re.I):continue
        # Conditional MySQL DDL has explicit SQLite counterparts in init-sqlite.mjs.
        if re.match(r'SET\s+@(has_wms_bind_flag|add_wms_bind_flag|ddl)\b',s,re.I):continue
        entries.append({'file':file.name,'sql':convert_join(s)})
(root/'database/sqlite/data-statements.json').write_text(json.dumps(entries,ensure_ascii=False,indent=2))
print('Prepared',len(entries),'migration and demo statements')
