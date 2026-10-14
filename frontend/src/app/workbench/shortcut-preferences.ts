import type { DomainEntry } from './configuration-registry'

export type ShortcutAttention = 'default' | 'follow' | 'high'
export interface ShortcutPreferences { order: string[]; attention: Record<string, ShortcutAttention> }

const key = (userId: number) => `workbenchShortcutPreferences:${userId}`

export function normalizeShortcutPreferences(userId: number, entries: DomainEntry[]): ShortcutPreferences {
  const saved = uni.getStorageSync(key(userId)) as Partial<ShortcutPreferences> | undefined
  const ids = entries.map(entry => entry.id)
  const savedOrder = Array.isArray(saved?.order) ? saved.order.filter(id => ids.includes(id)) : []
  const order = [...savedOrder, ...ids.filter(id => !savedOrder.includes(id))]
  const attention = Object.fromEntries(ids.map(id => [id, saved?.attention?.[id] ?? 'default'])) as Record<string, ShortcutAttention>
  return { order, attention }
}

export function saveShortcutPreferences(userId: number, value: ShortcutPreferences) { uni.setStorageSync(key(userId), value) }
export function sortShortcutEntries(entries: DomainEntry[], preference: ShortcutPreferences) {
  const entriesById = new Map(entries.map(entry => [entry.id, entry]))
  return preference.order.map(id => entriesById.get(id)).filter(Boolean) as DomainEntry[]
}
