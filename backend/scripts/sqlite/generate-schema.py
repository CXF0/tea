"""One-time conversion of uploaded MySQL DDL; generated schema.sql is the runtime source.
Requires sqlglot 27.29.0 only when regenerating this artifact, not during app setup.
"""
from pathlib import Path
import re,sys,sqlite3
from sqlglot import parse_one,exp
root=Path(__file__).resolve().parents[3]
quote=lambda name:'"'+str(name).replace('"','""')+'"'
schemas={};indexes=[];triggers=[]
files=[root/'database/dajiantest_local.sql']+sorted((root/'database').glob('2026*.sql'))
for file in files:
    source=file.read_text(encoding='utf-8')
    for match in re.finditer(r'CREATE TABLE(?: IF NOT EXISTS)?\s+[`\w]+\s*\(',source,re.I):
        tail=source[match.start():]
        # Semicolons may occur inside comments; identify balanced table parentheses.
        i=tail.index('(')+1;depth=1;charquote=''
        while depth:
            c=tail[i]
            if charquote:
                if c==charquote:
                    if tail[i+1:i+2]==charquote:i+=1
                    else:charquote=''
                elif c=='\\':i+=1
            elif c in "'\"`":charquote=c
            elif c=='(':depth+=1
            elif c==')':depth-=1
            i+=1
        ddl=re.sub(r'\b(ASC|DESC|UNSIGNED|ZEROFILL)\b|USING\s+(BTREE|HASH)', '', tail[:i], flags=re.I)
        ddl=re.sub(r"COMMENT\s+'(?:''|\\.|[^'])*'", '', ddl, flags=re.I)
        x=parse_one(ddl,read='mysql')
        table=x.this.this.name
        if table in schemas:continue
        columns=[];constraints=[];tableindexes=[]
        auto=next((c.name for c in x.this.expressions if isinstance(c,exp.ColumnDef) and any(isinstance(k.kind,exp.AutoIncrementColumnConstraint) for k in c.constraints)),None)
        for c in x.this.expressions:
            if isinstance(c,exp.ColumnDef):
                typename=c.args['kind'].this.value.upper()
                dtype='INTEGER' if 'INT' in typename or typename in ('BOOLEAN','BIT') else 'REAL' if typename in ('FLOAT','DOUBLE','DECIMAL','UDECIMAL') else 'BLOB' if 'BLOB' in typename or 'BINARY' in typename else 'TEXT'
                kinds=[k.kind for k in c.constraints]
                if c.name==auto:definition=f'{quote(c.name)} INTEGER PRIMARY KEY AUTOINCREMENT'
                else:
                    definition=f'{quote(c.name)} {dtype}'
                    if any(isinstance(k,exp.NotNullColumnConstraint) and not k.args.get('allow_null') for k in kinds):definition+=' NOT NULL'
                    default=next((k.this for k in kinds if isinstance(k,exp.DefaultColumnConstraint)),None)
                    if default is not None:
                        d=default.sql(dialect='sqlite')
                        if d=='CURRENT_TIMESTAMP':d="(datetime('now','+8 hours'))"
                        definition+=' DEFAULT '+d
                    elif any(isinstance(k,exp.NotNullColumnConstraint) and not k.args.get('allow_null') for k in kinds):
                        # Uploaded MySQL dump used sql_mode='': omitted NOT NULL fields
                        # receive MySQL's implicit zero/empty defaults. Make them explicit.
                        definition+=' DEFAULT '+('0' if dtype in ('INTEGER','REAL') else "''")
                columns.append(definition)
                if any(isinstance(k,exp.OnUpdateColumnConstraint) for k in kinds):
                    triggers.append(f'CREATE TRIGGER IF NOT EXISTS {quote(table+"_"+c.name+"_timestamp")} AFTER UPDATE ON {quote(table)} WHEN NEW.{quote(c.name)}=OLD.{quote(c.name)} BEGIN UPDATE {quote(table)} SET {quote(c.name)}=datetime(\'now\',\'+8 hours\') WHERE rowid=NEW.rowid; END;')
            elif isinstance(c,exp.PrimaryKey):
                if not auto:constraints.append('PRIMARY KEY ('+', '.join(quote(k.name) for k in c.expressions)+')')
            elif isinstance(c,exp.UniqueColumnConstraint):
                constraints.append('UNIQUE ('+', '.join(quote(k.name) for k in c.this.expressions)+')')
            elif isinstance(c,exp.IndexColumnConstraint):
                cols=[k.this.name for k in c.expressions]
                tableindexes.append('CREATE INDEX IF NOT EXISTS '+quote(table+'_'+c.this.name)+' ON '+quote(table)+' ('+', '.join(quote(k) for k in cols)+');')
        schemas[table]=f'CREATE TABLE IF NOT EXISTS {quote(table)} (\n  '+',\n  '.join(columns+constraints)+'\n);'
        indexes+=tableindexes
out='-- Converted SQLite schema. No production records are included.\n'+'\n'.join(list(schemas.values())+indexes+triggers)+'\n'
(root/'database/sqlite/schema.sql').write_text(out)
db=sqlite3.connect(':memory:');db.executescript(out)
print(f'Generated and validated {len(schemas)} tables, {len(indexes)} indexes, {len(triggers)} timestamp triggers')
