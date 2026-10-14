/** Translate the limited MySQL dialect used by this application's repositories.
 * Values always remain bound parameters; this is not a general-purpose SQL parser.
 */
export function splitSql(source: string, delimiter = ';'): string[] {
  const result: string[] = []; let start = 0, depth = 0, quote = ''
  for (let i = 0; i < source.length; i++) {
    const c = source[i]
    if (quote) {
      if (c === quote && source[i + 1] === quote) { i++; continue }
      if (c === quote && source[i - 1] !== '\\') quote = ''
      continue
    }
    if (c === "'" || c === '"' || c === '`') { quote = c; continue }
    if (c === '(') depth++
    if (c === ')') depth--
    if (c === delimiter && depth === 0) { result.push(source.slice(start, i).trim()); start = i + 1 }
  }
  result.push(source.slice(start).trim())
  return result.filter(Boolean)
}

function calls(sql: string): string {
  let out = ''
  for (let i = 0; i < sql.length;) {
    if (["'", '"', '`'].includes(sql[i])) {
      const quote = sql[i]; const start = i++
      while (i < sql.length) { if (sql[i++] === quote) { if (sql[i] === quote) { i++; continue }; break } }
      out += sql.slice(start, i); continue
    }
    const match = /^[A-Za-z_][\w]*\s*\(/.exec(sql.slice(i))
    if (!match) { out += sql[i++]; continue }
    const name = match[0].slice(0, -1).trim().toUpperCase()
    const open = i + match[0].length - 1
    let end = open + 1, depth = 1, quote = ''
    for (; end < sql.length && depth; end++) {
      const c = sql[end]
      if (quote) { if (c === quote) { if (sql[end + 1] === quote) end++; else quote = '' }; continue }
      if (["'", '"', '`'].includes(c)) { quote = c; continue }
      if (c === '(') depth++; if (c === ')') depth--
    }
    const inner = calls(sql.slice(open + 1, end - 1))
    const args = splitSql(inner, ',')
    let replacement: string | undefined
    if (name === 'DATE_SUB' || name === 'DATE_ADD') {
      const interval = /^INTERVAL\s+(.+?)\s+(DAY|MONTH|HOUR|MINUTE|SECOND)$/i.exec(args[1] || '')
      if (interval) replacement = `DATETIME(${args[0]}, (${name === 'DATE_SUB' ? '-' : ''}(${interval[1]})) || ' ${interval[2].toLowerCase()}')`
    } else if (name === 'TIMESTAMPDIFF') {
      const divisor = {SECOND: 1, MINUTE: 60, HOUR: 3600, DAY: 86400}[args[0] as 'MINUTE']
      if (divisor) replacement = `CAST((JULIANDAY(${args[2]})-JULIANDAY(${args[1]}))*86400/${divisor} AS INTEGER)`
    } else if (name === 'LEFT') replacement = `SUBSTR(${args[0]},1,${args[1]})`
    else if (name === 'RIGHT') replacement = `SUBSTR(${args[0]},-(${args[1]}))`
    else if (name === 'GROUP_CONCAT') {
      const sep = /\s+SEPARATOR\s+('(?:''|[^'])*')\s*$/i.exec(inner)
      let body = sep ? inner.slice(0, sep.index) : inner
      const order = /\s+ORDER\s+BY\s+([\s\S]+)$/i.exec(body)
      if (order) body = body.slice(0, order.index)
      const distinct = /^DISTINCT\s+/i.test(body)
      const expression = body.replace(/^DISTINCT\s+/i, '')
      const orderArgs = order ? splitSql(order[1], ',').flatMap(term => [term.replace(/\s+(ASC|DESC)$/i, ''), /\s+DESC$/i.test(term) ? '1' : '0']) : []
      replacement = `WMS_GROUP_CONCAT(${[expression, sep?.[1] || "','", distinct ? '1' : '0', ...orderArgs].join(',')})`
    }
    out += replacement ?? `${sql.slice(i, open)}(${inner})`
    i = end
  }
  return out
}

export function translateSql(sql: string): string {
  let result = calls(sql.trim().replace(/;\s*$/, ''))
  result = result.replace(/\b(NOW\(\)|CURDATE\(\))\s*([+-])\s*INTERVAL\s+(\d+)\s+(DAY|MONTH|HOUR|MINUTE|SECOND)\b/gi, (_, date, sign, value, unit) => `DATETIME(${date}, '${sign}${value} ${unit.toLowerCase()}')`)
  result = result.replace(/\s+FOR\s+UPDATE\b/gi, '')
    .replace(/\bAS\s+UNSIGNED\b/gi, 'AS INTEGER')
    .replace(/\bAS\s+CHAR\b/gi, 'AS TEXT')
    .replace(/\bINSERT\s+IGNORE\b/gi, 'INSERT OR IGNORE')
    .replace(/\bON\s+DUPLICATE\s+KEY\s+UPDATE\b/gi, 'ON CONFLICT DO UPDATE SET')

  const conflict = result.indexOf('ON CONFLICT DO UPDATE SET')
  if (conflict >= 0) result = result.slice(0, conflict) + result.slice(conflict).replace(/\bVALUES\s*\(\s*([\w`]+)\s*\)/gi, 'excluded.$1')
  // SQLite requires AS on aliases in UPDATE statements and unqualified assignment names.
  result = result.replace(/^UPDATE\s+(\w+)\s+(?!SET\b)(\w+)\s+SET\b/i, 'UPDATE $1 AS $2 SET')
  const update = /^(UPDATE\s+\w+(?:\s+AS\s+\w+)?\s+SET\s+)/i.exec(result)
  if (update) {
    let depth = 0, quote = '', end = result.length
    for (let i = update[0].length; i < result.length; i++) {
      const c = result[i]
      if (quote) { if (c === quote) { if (result[i + 1] === quote) i++; else quote = '' }; continue }
      if (["'", '"', '`'].includes(c)) { quote = c; continue }
      if (c === '(') depth++; if (c === ')') depth--
      if (!depth && /^\s+WHERE\s+/i.test(result.slice(i))) { end = i; break }
    }
    const assignments = splitSql(result.slice(update[0].length, end), ',').map(term => term.replace(/^\s*\w+\.(\w+)\s*=/, '$1='))
    result = update[0] + assignments.join(', ') + result.slice(end)
  }
  // A SELECT without WHERE before UPSERT is ambiguous to SQLite's parser.
  if (/^INSERT/i.test(result) && /\bSELECT\b/i.test(result) && /ON CONFLICT/i.test(result)) {
    const index = result.indexOf('ON CONFLICT')
    if (!/\bWHERE\b/i.test(result.slice(0, index))) result = result.slice(0, index) + ' WHERE 1 ' + result.slice(index)
  }
  return result
}

export function bindArrays(sql: string, values: unknown[]) {
  const params: (string | number | bigint | null | Uint8Array)[] = []
  let index = 0, quote = '', output = ''
  const scalar = (v: unknown) => {
    if (v === undefined || v === null) return null
    if (typeof v === 'boolean') return v ? 1 : 0
    if (v instanceof Date) return v.toISOString().slice(0, 19).replace('T', ' ')
    if (typeof v === 'string' || typeof v === 'number' || typeof v === 'bigint' || v instanceof Uint8Array) return v
    throw new TypeError('Unsupported SQLite binding')
  }
  for (let i = 0; i < sql.length; i++) {
    const c = sql[i]
    if (quote) { output += c; if (c === quote) { if (sql[i + 1] === quote) output += sql[++i]; else quote = '' }; continue }
    if (["'", '"', '`'].includes(c)) { quote = c; output += c; continue }
    if (c !== '?') { output += c; continue }
    if (index >= values.length) throw new Error('Missing SQL parameter')
    const value = values[index++]
    if (!Array.isArray(value)) { output += '?'; params.push(scalar(value)); continue }
    if (!value.length) { output += 'NULL'; continue }
    if (Array.isArray(value[0])) {
      const width = value[0].length
      if (value.some(row => !Array.isArray(row) || row.length !== width)) throw new Error('Inconsistent bulk insert width')
      output += value.map(row => { params.push(...row.map(scalar)); return `(${row.map(() => '?').join(',')})` }).join(',')
    } else { output += value.map(() => '?').join(','); params.push(...value.map(scalar)) }
  }
  if (index !== values.length) throw new Error(`SQL parameter count mismatch: ${index} placeholders, ${values.length} values`)
  return {sql: output, params}
}
