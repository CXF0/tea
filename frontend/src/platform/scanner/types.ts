export type ScanOperationId =
  | 'admission-checkin'
  | 'quality-inspection'
  | 'quality-video'
  | 'distribution-shelf'
  | 'packing-shelf'
  | 'logistics-shelf'
  | 'cold-storage-bare'
  | 'base-return-confirm'

export type ScanObjectType = 'supplier' | 'flower' | 'shelf' | 'package' | 'unknown'

export interface ParsedScanCode {
  raw: string
  type: ScanObjectType
  id?: number
  value: string
}
