export interface AdmissionRow {
  id: number
  supplier_id: number
  supplier_name: string
  login_tel: string
  date: string
  enter_time: string
  data_status: number
  night_enter_time: string
  night_data_status: number
  night_open: number
  is_qualify: number
  is_late: number
  quality_inspection_flag: number
  item_count: number | string
  item_quantity: number | string
}
