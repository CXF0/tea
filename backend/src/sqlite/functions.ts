import { createHash } from 'node:crypto'
import type { DatabaseSync, SQLInputValue } from 'node:sqlite'

export function installFunctions(db: DatabaseSync) {
  let upsertId: number | null = null
  const text = (v: SQLInputValue) => v === null ? '' : String(v)
  const now = () => new Date().toLocaleString('sv-SE', { timeZone: 'Asia/Shanghai' })
  db.function('NOW', now)
  db.function('CURDATE', () => now().slice(0, 10))
  db.function('DATABASE', () => 'menghuacangguan_sqlite')
  db.function('VERSION', () => 'SQLite')
  db.function('IF', (test, yes, no) => test ? yes : no)
  db.function('CHAR_LENGTH', v => v === null ? null : [...String(v)].length)
  db.function('CONCAT', {varargs: true}, (...v) => v.some(x => x === null) ? null : v.map(text).join(''))
  db.function('CONCAT_WS', {varargs: true}, (separator, ...v) => separator === null ? null : v.filter(x => x !== null).map(text).join(text(separator)))
  db.function('GREATEST', {varargs: true}, (...v) => v.some(x => x === null) ? null : Math.max(...v.map(Number)))
  db.function('LEAST', {varargs: true}, (...v) => v.some(x => x === null) ? null : Math.min(...v.map(Number)))
  db.function('FIELD', {varargs: true}, (v, ...items) => items.findIndex(item => item === v) + 1)
  db.function('ELT', {varargs: true}, (n, ...v) => v[Number(n) - 1] ?? null)
  db.function('MOD', (a, b) => Number(a) % Number(b))
  db.function('CEIL', v => v === null ? null : Math.ceil(Number(v)))
  db.function('LAST_INSERT_ID', {varargs: true}, (...values) => {
    if (values.length) upsertId=Number(values[0])
    return upsertId ?? db.prepare('SELECT last_insert_rowid() id').get()!.id
  })
  db.function('JSON_SEARCH', (document, mode, target) => {
    if (document === null || target === null) return null
    if (mode !== 'one') throw new Error('Unsupported JSON_SEARCH mode')
    const data = JSON.parse(text(document)); const index = Array.isArray(data) ? data.indexOf(target) : -1
    return index < 0 ? null : JSON.stringify(`$[${index}]`)
  })
  db.function('FLOOR', v => v === null ? null : Math.floor(Number(v)))
  db.function('LPAD', (v, n, pad) => text(pad) ? text(v).padStart(Number(n), text(pad)).slice(0, Number(n)) : null)
  db.function('SUBSTRING_INDEX', (v, separator, count) => {
    if (v === null || separator === null || count === null) return null
    const chunks = text(v).split(text(separator)); const n = Number(count)
    return (n >= 0 ? chunks.slice(0, n) : chunks.slice(n)).join(text(separator))
  })
  db.function('SHA2', (v, bits) => v === null ? null : createHash(`sha${Number(bits)}`).update(text(v)).digest('hex'))
  db.function('DATE_FORMAT', (v, format) => {
    if (v === null || !text(v) || text(v).startsWith('0000')) return null
    const date = text(v).replace('T', ' ')
    const fields: Record<string, string> = {'%Y': date.slice(0,4), '%m': date.slice(5,7), '%d': date.slice(8,10), '%H': date.slice(11,13) || '00', '%i': date.slice(14,16) || '00', '%s': date.slice(17,19) || '00'}
    return text(format).replace(/%[YmdHis]/g, token => fields[token])
  })
  db.function('JSON_UNQUOTE', v => {
    if (v === null) return null
    try { const parsed = JSON.parse(text(v)); return typeof parsed === 'object' ? JSON.stringify(parsed) : String(parsed) } catch { return text(v) }
  })
  db.function('JSON_ARRAY_APPEND', {varargs: true}, (document, ...pairs) => {
    if (document === null) return null
    const data = JSON.parse(text(document))
    for (let i = 0; i < pairs.length; i += 2) {
      if (pairs[i] !== '$' || !Array.isArray(data)) throw new Error('Unsupported JSON_ARRAY_APPEND path')
      data.push(pairs[i + 1])
    }
    return JSON.stringify(data)
  })
  db.function('JSON_CONTAINS', (document, value) => {
    if (document === null || value === null) return null
    const parsed = JSON.parse(text(document)); const expected = JSON.parse(text(value))
    return (Array.isArray(parsed) ? parsed.some(v => JSON.stringify(v) === JSON.stringify(expected)) : JSON.stringify(parsed) === JSON.stringify(expected)) ? 1 : 0
  })
  // A custom aggregate preserves MySQL's DISTINCT + ORDER BY + SEPARATOR combination.
  type Entry = {value: string; separator: string; distinct: boolean; keys: SQLInputValue[]}
  db.aggregate<string>('WMS_GROUP_CONCAT', {
    start: '[]', varargs: true,
    step: (serialized, value, separator, distinct, ...keys) => {
      const state: Entry[] = JSON.parse(String(serialized))
      if (value !== null) state.push({value: text(value), separator: text(separator), distinct: Boolean(distinct), keys})
      return JSON.stringify(state)
    },
    result: serialized => {
      const state: Entry[] = JSON.parse(String(serialized))
      if (!state.length) return null
      state.sort((a, b) => {
        for (let i = 0; i < a.keys.length; i += 2) {
          const x = a.keys[i], y = b.keys[i]
          const cmp = x === y ? 0 : x === null ? -1 : y === null ? 1 : x! < y! ? -1 : 1
          if (cmp) return a.keys[i + 1] ? -cmp : cmp
        }
        return 0
      })
      const values = state.map(row => row.value)
      return (state[0].distinct ? [...new Set(values)] : values).join(state[0].separator)
    },
  })
  return { resetLastInsertId: () => { upsertId = null }, lastInsertId: () => upsertId }
}
