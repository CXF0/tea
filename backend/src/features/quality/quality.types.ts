export type QualityStatus = 0 | 1 | 2 | 10

export interface QualityTaskRow {
  id: number
  date: string
  enter_item_id: number
  shelf_sn: number
  zoen_shelf: string
  sub_shelf_sn: string | null
  product_name: string
  rank_num: number
  sku_config: string
  item_num: number
  prepare_item_num: number
  supplier_name: string | null
  inspection_flag: number
  focus_flag: number
  big_order: number
  new_order: number
  refund_product: number
  quality_product: number
  quality_flag: number
  receive_tel: string
  status: QualityStatus
  assigned_user_id: number | null
  assigned_user_name: string | null
  remark: string
  finish_time: string | null
}

export interface SubmitInspectionCommand {
  status: Exclude<QualityStatus, 0>
  remark?: string
  reasonId?: number
  userId: number
  userName: string
}

export interface SupplierFlowerItemRow {
  id: number
  enter_id: number
  date: string
  zone_shelf: string
  order_num: number
  sub_shelf_sn: string | null
  product_name: string
  rank_num: number
  sku_config: string
  item_num: number
  is_position: number
  is_qualify: number
  not_qualify_num: number
  qualify_user_name: string | null
  update_time: string | null
  supplier_name?: string | null
  supplier_phone?: string | null
  customer_name?: string | null
  customer_phone?: string | null
  supplier_price?: string | number | null
  partner_name?: string | null
  unqualified_way?: number | null
  limit_distribution_flag?: number
  duty_flag?: number
  no_after_sale_flag?: number
  duty_remark?: string | null
  duty_media_json?: string | null
}

export interface GoodFlowerVideoItemRow {
  id: number
  enter_id: number
  date: string
  product_id: number
  product_name: string
  rank_num: number
  supplier_id: number
  supplier_name: string
  supplier_tag: string | null
  sub_shelf_sn: string | null
  zone_shelf: string | null
  order_num: number
}
