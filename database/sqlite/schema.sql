-- Converted SQLite schema. No production records are included.
CREATE TABLE IF NOT EXISTS "audit_task" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "target_id" INTEGER NOT NULL DEFAULT 0,
  "target_type" INTEGER NOT NULL DEFAULT 0,
  "api_task_id" TEXT NOT NULL DEFAULT '',
  "media_url" TEXT DEFAULT '',
  "audit_type" INTEGER NOT NULL DEFAULT 0,
  "status" INTEGER NOT NULL DEFAULT 0,
  "result_suggestion" TEXT DEFAULT NULL,
  "result_details" TEXT,
  "created_at" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "updated_at" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "b2b_coupon_record" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "appid" TEXT NOT NULL DEFAULT '',
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "coupon_no" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "backup_express_config" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "config_id" INTEGER NOT NULL DEFAULT 0,
  "sort_config_str" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "sort_type" INTEGER NOT NULL DEFAULT 1,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("config_id")
);
CREATE TABLE IF NOT EXISTS "backup_express_config_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "config_id" INTEGER NOT NULL DEFAULT 0,
  "content" TEXT,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "bak_20260901_a105_backup_express" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "config_id" INTEGER NOT NULL DEFAULT 0,
  "sort_config_str" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "sort_type" INTEGER NOT NULL DEFAULT 1,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("config_id")
);
CREATE TABLE IF NOT EXISTS "bak_20260901_a105_city_warehouse" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL DEFAULT '',
  "app_id" TEXT NOT NULL DEFAULT '',
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "express_id" INTEGER NOT NULL DEFAULT 0,
  "region_id" INTEGER NOT NULL DEFAULT 0,
  "store_id" INTEGER NOT NULL DEFAULT 0,
  "city_store_open" INTEGER NOT NULL DEFAULT 1,
  "add_price" REAL NOT NULL DEFAULT 1.00,
  "add_price_flag" INTEGER NOT NULL DEFAULT 0,
  "distance" REAL NOT NULL DEFAULT 5.00,
  "distance_price" REAL NOT NULL DEFAULT 0.00,
  "weight_price" REAL NOT NULL DEFAULT 0.00,
  "express_add_price" REAL NOT NULL DEFAULT 0.00,
  "start_sell_weight" REAL NOT NULL DEFAULT 0.00,
  "distribution_type" INTEGER NOT NULL DEFAULT 0,
  "longitude" TEXT NOT NULL DEFAULT '',
  "latitude" TEXT NOT NULL DEFAULT '',
  "province" TEXT NOT NULL DEFAULT '',
  "city" TEXT NOT NULL DEFAULT '',
  "district" TEXT NOT NULL DEFAULT '',
  "detail" TEXT NOT NULL DEFAULT '',
  "business_address" TEXT NOT NULL DEFAULT '',
  "city_code" TEXT NOT NULL DEFAULT '',
  "adcode" TEXT NOT NULL DEFAULT '',
  "contact_name" TEXT NOT NULL DEFAULT '',
  "contact_tel" TEXT NOT NULL DEFAULT '',
  "logistics_phone" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "operate_status" INTEGER NOT NULL DEFAULT 1,
  "phone_switch" INTEGER NOT NULL DEFAULT 1,
  "flash_sale_switch" INTEGER NOT NULL DEFAULT 1,
  "cotton_switch" INTEGER NOT NULL DEFAULT 0,
  "cotton_num" INTEGER NOT NULL DEFAULT 0,
  "board_switch" INTEGER NOT NULL DEFAULT 0,
  "board_num" INTEGER NOT NULL DEFAULT 0,
  "hour_delivery_switch" INTEGER NOT NULL DEFAULT 1,
  "xmmaterials_open" INTEGER NOT NULL DEFAULT 1,
  "change_add_price_switch" INTEGER NOT NULL DEFAULT 1,
  "single_delivery_flag" INTEGER NOT NULL DEFAULT 0,
  "coupon_flag" INTEGER NOT NULL DEFAULT 1,
  "promote_flag" INTEGER NOT NULL DEFAULT 0,
  "service_fee_flag" INTEGER NOT NULL DEFAULT 0,
  "audit_status" INTEGER NOT NULL DEFAULT 0,
  "audit_name" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "delivery_type" INTEGER NOT NULL DEFAULT 0,
  "share_ratio" REAL NOT NULL DEFAULT 0.00,
  "promote_merchant_flag" INTEGER NOT NULL DEFAULT 0,
  "large_customer_pack_flag" INTEGER NOT NULL DEFAULT 0,
  "large_customer_pack_weight" REAL NOT NULL DEFAULT 10.00
);
CREATE TABLE IF NOT EXISTS "bak_20260901_a105_common" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "type" INTEGER NOT NULL DEFAULT 0,
  "type_str" TEXT NOT NULL DEFAULT '',
  "price" REAL NOT NULL DEFAULT 0.000,
  "config_str" TEXT NOT NULL DEFAULT '',
  "tips" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("type")
);
CREATE TABLE IF NOT EXISTS "bak_20260901_a105_daily_shelf" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "round_no" TEXT NOT NULL DEFAULT '',
  "order_sn" TEXT NOT NULL DEFAULT '',
  "send_no" TEXT NOT NULL DEFAULT '',
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "zone" TEXT NOT NULL DEFAULT '',
  "shelf" TEXT NOT NULL DEFAULT '',
  "zone_shelf" TEXT NOT NULL DEFAULT '',
  "sub_shelf_sn" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "bak_20260901_a105_daily_shelf_test" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "round_no" TEXT NOT NULL DEFAULT '',
  "order_sn" TEXT NOT NULL DEFAULT '',
  "send_no" TEXT NOT NULL DEFAULT '',
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "zone" TEXT NOT NULL DEFAULT '',
  "shelf" TEXT NOT NULL DEFAULT '',
  "zone_shelf" TEXT NOT NULL DEFAULT '',
  "sub_shelf_sn" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "bak_20260901_a105_logistics" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "logistics_name" TEXT NOT NULL DEFAULT '',
  "brand" TEXT NOT NULL DEFAULT '',
  "phone" TEXT NOT NULL DEFAULT '',
  "logistics_type" INTEGER NOT NULL DEFAULT 0,
  "expected_time_str" TEXT NOT NULL DEFAULT '',
  "delay_time_num" INTEGER NOT NULL DEFAULT 0,
  "is_to_shop" INTEGER NOT NULL DEFAULT 0,
  "transfer_cost" REAL NOT NULL DEFAULT 0,
  "is_separate_display" INTEGER NOT NULL DEFAULT 0,
  "is_enable" INTEGER NOT NULL DEFAULT 0,
  "rule_id" INTEGER NOT NULL DEFAULT 0,
  "first_heavy" INTEGER NOT NULL DEFAULT 0,
  "first_heavy_price" REAL NOT NULL DEFAULT 0.00,
  "charge_type" INTEGER NOT NULL DEFAULT 0,
  "continue_heavy_price" REAL NOT NULL DEFAULT 0.00,
  "is_transfer" INTEGER NOT NULL DEFAULT 0,
  "need_pick_fee" INTEGER NOT NULL DEFAULT 1,
  "small_item_recommend" INTEGER NOT NULL DEFAULT 0,
  "logistics_shift" INTEGER NOT NULL DEFAULT 0,
  "sort_num" INTEGER NOT NULL DEFAULT 0,
  "show_sort_num" INTEGER NOT NULL DEFAULT 0,
  "description" TEXT NOT NULL DEFAULT '',
  "delivery_time" TEXT NOT NULL DEFAULT '',
  "picker_phone" TEXT NOT NULL DEFAULT '',
  "need_fill_express_price" INTEGER NOT NULL DEFAULT 1,
  "need_fill_weight" INTEGER NOT NULL DEFAULT 1,
  "need_weight_photo" INTEGER NOT NULL DEFAULT 1,
  "out_flag" INTEGER NOT NULL DEFAULT 1,
  "pack_timeout_punish_flag" INTEGER NOT NULL DEFAULT 0,
  "promotion_flag" INTEGER NOT NULL DEFAULT 0,
  "promotion_start" TEXT DEFAULT NULL,
  "promotion_end" TEXT DEFAULT NULL,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "send_area" TEXT NOT NULL DEFAULT '',
  "is_invoice_marked" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "bak_20260901_a105_order" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "vip_name" TEXT NOT NULL DEFAULT '',
  "order_sn" TEXT NOT NULL DEFAULT '',
  "order_type" INTEGER NOT NULL DEFAULT 0,
  "delivery_type" INTEGER NOT NULL DEFAULT 1,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "partner_model" INTEGER NOT NULL DEFAULT 0,
  "merchant_id" TEXT NOT NULL DEFAULT '',
  "app_id" TEXT NOT NULL DEFAULT '',
  "open_id" TEXT NOT NULL DEFAULT '',
  "distribution_type" INTEGER NOT NULL DEFAULT 0,
  "is_addition" INTEGER NOT NULL DEFAULT 0,
  "platform" INTEGER NOT NULL DEFAULT 0,
  "has_third_good" INTEGER NOT NULL DEFAULT 0,
  "is_zq_settlement" INTEGER NOT NULL DEFAULT 0,
  "send_no" TEXT NOT NULL DEFAULT '',
  "round_no" TEXT NOT NULL DEFAULT '',
  "order_num" INTEGER NOT NULL DEFAULT 1,
  "total_item_num" INTEGER NOT NULL DEFAULT 0,
  "total_weight" INTEGER NOT NULL DEFAULT 0,
  "origin_total_weight" INTEGER NOT NULL DEFAULT 0,
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "sub_shelf_sn" TEXT NOT NULL DEFAULT '',
  "zone" TEXT NOT NULL DEFAULT '',
  "shelf" TEXT NOT NULL DEFAULT '',
  "zone_shelf" TEXT NOT NULL DEFAULT '',
  "express" INTEGER NOT NULL DEFAULT 0,
  "express_region" INTEGER NOT NULL DEFAULT 0,
  "real_express_id" INTEGER NOT NULL DEFAULT 0,
  "real_express_region" INTEGER NOT NULL DEFAULT 0,
  "express_time" INTEGER DEFAULT NULL,
  "express_price" REAL NOT NULL DEFAULT 0,
  "before_activity_express_price" REAL DEFAULT 0.00,
  "activity_express_name" TEXT NOT NULL DEFAULT '',
  "coupon_price" REAL NOT NULL DEFAULT 0.00,
  "origin_coupon_price" REAL NOT NULL DEFAULT 0.00,
  "platform_reduce_price" REAL NOT NULL DEFAULT 0.00,
  "origin_platform_reduce_price" REAL NOT NULL DEFAULT 0.00,
  "add_price" REAL NOT NULL DEFAULT 0.00,
  "origin_add_price" REAL NOT NULL DEFAULT 0.00,
  "warehouse_add_price" REAL NOT NULL DEFAULT 0.00,
  "origin_warehouse_add_price" REAL NOT NULL DEFAULT 0.00,
  "express_add_price" REAL NOT NULL DEFAULT 0.00,
  "origin_express_add_price" REAL NOT NULL DEFAULT 0.00,
  "ot_exp_add_price" REAL NOT NULL DEFAULT 0.00,
  "origin_ot_exp_add_price" REAL NOT NULL DEFAULT 0.00,
  "delivery_fee" REAL NOT NULL DEFAULT 0.00,
  "origin_delivery_fee" REAL NOT NULL DEFAULT 0.00,
  "modify_express_price" REAL NOT NULL DEFAULT 0.00,
  "is_change_express" INTEGER NOT NULL DEFAULT 0,
  "actual_express_price" REAL DEFAULT NULL,
  "origin_supply_price" REAL NOT NULL DEFAULT 0.00,
  "product_total_price" REAL NOT NULL DEFAULT 0,
  "origin_product_total_price" REAL NOT NULL DEFAULT 0.00,
  "service_fee" REAL NOT NULL DEFAULT 0.00,
  "origin_service_fee" REAL NOT NULL DEFAULT 0.00,
  "extra_service_fee" REAL NOT NULL DEFAULT 0.00,
  "origin_extra_service_fee" REAL NOT NULL DEFAULT 0.00,
  "vip_discount_service_fee" REAL NOT NULL DEFAULT 0.00,
  "origin_vip_discount_service_fee" REAL NOT NULL DEFAULT 0.00,
  "platform_discount" REAL NOT NULL DEFAULT 0.00,
  "origin_platform_discount" REAL NOT NULL DEFAULT 0.00,
  "subsidy_price" REAL NOT NULL DEFAULT 0.00,
  "origin_subsidy_price" REAL NOT NULL DEFAULT 0.00,
  "negate_add_price" REAL NOT NULL DEFAULT 0.00,
  "origin_negate_add_price" REAL NOT NULL DEFAULT 0.00,
  "base_service_fee" REAL NOT NULL DEFAULT 0.00,
  "origin_base_service_fee" REAL NOT NULL DEFAULT 0.00,
  "total_price" REAL NOT NULL DEFAULT 0,
  "origin_total_price" REAL NOT NULL DEFAULT 0.00,
  "origin_use_xm_coin" REAL NOT NULL DEFAULT 0.00,
  "use_xm_coin" REAL NOT NULL DEFAULT 0.00,
  "rebate_xm_coin" REAL NOT NULL DEFAULT 0.00,
  "origin_rebate_xm_coin" REAL NOT NULL DEFAULT 0.00,
  "actual_price" REAL NOT NULL DEFAULT 0.00,
  "origin_actual_price" REAL NOT NULL DEFAULT 0.00,
  "apply_price" REAL NOT NULL DEFAULT 0.00,
  "actual_refund" REAL NOT NULL DEFAULT 0.00,
  "actual_coin" REAL NOT NULL DEFAULT 0.00,
  "paid_price" REAL NOT NULL DEFAULT 0.00,
  "paid_coin" REAL NOT NULL DEFAULT 0.00,
  "pay_type" INTEGER NOT NULL DEFAULT 0,
  "pay_on_delivery" INTEGER NOT NULL DEFAULT 0,
  "receive_name" TEXT NOT NULL DEFAULT '',
  "receive_tel" TEXT NOT NULL DEFAULT '',
  "province" TEXT NOT NULL DEFAULT '',
  "city" TEXT NOT NULL DEFAULT '',
  "district" TEXT NOT NULL DEFAULT '',
  "detail" TEXT NOT NULL DEFAULT '',
  "receive_address" TEXT NOT NULL DEFAULT '',
  "nation_code" TEXT NOT NULL DEFAULT '86',
  "adcode" TEXT NOT NULL DEFAULT '',
  "buyer_memo" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "order_status" INTEGER NOT NULL DEFAULT 0,
  "after_sale_status" INTEGER NOT NULL DEFAULT 0,
  "after_sale_agree_type" INTEGER NOT NULL DEFAULT 0,
  "after_sale_count" INTEGER NOT NULL DEFAULT 0,
  "refund_status" INTEGER NOT NULL DEFAULT 0,
  "print_status" INTEGER NOT NULL DEFAULT 0,
  "wx_pay_time" TEXT DEFAULT NULL,
  "wx_pay_id" TEXT NOT NULL DEFAULT '',
  "send_time" TEXT DEFAULT NULL,
  "delay_ddl" TEXT DEFAULT NULL,
  "confirm_time" TEXT DEFAULT NULL,
  "extra_info" TEXT,
  "coupon_user_id" INTEGER NOT NULL DEFAULT 0,
  "is_comment" INTEGER NOT NULL DEFAULT 0,
  "is_open_after_sale" INTEGER NOT NULL DEFAULT 0,
  "is_deliver" INTEGER NOT NULL DEFAULT 0,
  "is_bond" INTEGER NOT NULL DEFAULT 0,
  "is_cotton" INTEGER NOT NULL DEFAULT 0,
  "flag" INTEGER NOT NULL DEFAULT 0,
  "bear_type" INTEGER NOT NULL DEFAULT 0,
  "is_bear_station_fee" INTEGER NOT NULL DEFAULT 0,
  "origin_total_station_fee" REAL NOT NULL DEFAULT 0.00,
  "total_station_fee" REAL NOT NULL DEFAULT 0.00,
  "is_presale" INTEGER NOT NULL DEFAULT 0,
  "is_sale_agency" INTEGER NOT NULL DEFAULT 0,
  "order_tag" INTEGER NOT NULL DEFAULT 0,
  "help_id" INTEGER NOT NULL DEFAULT 0,
  "pid" INTEGER NOT NULL DEFAULT 0,
  "unqualified_way" INTEGER NOT NULL DEFAULT 0,
  "assign_customer_id" INTEGER NOT NULL DEFAULT 0,
  "assign_customer_name" TEXT NOT NULL DEFAULT '',
  "ship_flag" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "partner_add_service_fee" REAL DEFAULT 0.00,
  "origin_partner_add_service_fee" REAL DEFAULT 0.00,
  UNIQUE ("order_sn")
);
CREATE TABLE IF NOT EXISTS "bak_20260901_a105_order_info" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "send_no" TEXT NOT NULL DEFAULT '',
  "api_order_sn" TEXT NOT NULL DEFAULT '',
  "has_cotton" INTEGER NOT NULL DEFAULT 0,
  "cotton_info" TEXT NOT NULL DEFAULT '',
  "promote_merchant_flag" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("order_sn")
);
CREATE TABLE IF NOT EXISTS "bak_20260901_a105_order_item" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "order_num" INTEGER NOT NULL DEFAULT 0,
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "sub_shelf_sn" TEXT NOT NULL DEFAULT '',
  "zone" TEXT NOT NULL DEFAULT '',
  "shelf" TEXT NOT NULL DEFAULT '',
  "zone_shelf" TEXT DEFAULT '',
  "order_sn" TEXT NOT NULL DEFAULT '',
  "round_no" TEXT NOT NULL DEFAULT '',
  "supplier_no" TEXT NOT NULL DEFAULT '',
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "product_name" TEXT NOT NULL DEFAULT '',
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "rank_num" INTEGER NOT NULL DEFAULT 1,
  "sku_config" TEXT NOT NULL DEFAULT '',
  "pic_url" TEXT NOT NULL DEFAULT '',
  "spec_and_num" TEXT NOT NULL DEFAULT '',
  "description" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "supply_price" REAL NOT NULL DEFAULT 0.00,
  "pay_price" REAL NOT NULL DEFAULT 0.00,
  "platform_discount_price" REAL NOT NULL DEFAULT 0.00,
  "subsidy_price" REAL NOT NULL DEFAULT 0.00,
  "coupon_pay_price" REAL NOT NULL DEFAULT 0.00,
  "total_discount_refundable" REAL NOT NULL DEFAULT 0.00,
  "origin_total_discount_refundable" REAL NOT NULL DEFAULT 0.00,
  "coupon_discount_per_bundle" REAL NOT NULL DEFAULT 0.00,
  "full_reduction_discount_per_bundle" REAL NOT NULL DEFAULT 0.00,
  "add_price" REAL NOT NULL DEFAULT 0.00,
  "total_add_price" REAL NOT NULL DEFAULT 0.00,
  "origin_total_add_price" REAL NOT NULL DEFAULT 0.00,
  "warehouse_add_price" REAL NOT NULL DEFAULT 0.00,
  "negate_add_price" REAL NOT NULL DEFAULT 0.00,
  "station_fee" REAL NOT NULL DEFAULT 0.00,
  "express_add_price" REAL NOT NULL DEFAULT 0.00,
  "item_num" INTEGER NOT NULL DEFAULT 0,
  "origin_item_num" INTEGER NOT NULL DEFAULT 0,
  "after_sale_item_num" INTEGER NOT NULL DEFAULT 0,
  "after_sale_refund" REAL NOT NULL DEFAULT 0.00,
  "bond_item_num" INTEGER NOT NULL DEFAULT 0,
  "after_sale_supplier_num" INTEGER NOT NULL DEFAULT 0,
  "actual_price" REAL NOT NULL DEFAULT 0.00,
  "origin_actual_price" REAL NOT NULL DEFAULT 0.00,
  "service_price" REAL NOT NULL DEFAULT 0.00,
  "partner_add_service_price" REAL NOT NULL DEFAULT 0.00,
  "total_partner_add_service_price" REAL NOT NULL DEFAULT 0.00,
  "total_price" REAL NOT NULL DEFAULT 0.00,
  "origin_total_price" REAL NOT NULL DEFAULT 0.00,
  "total_weight" INTEGER NOT NULL DEFAULT 0,
  "origin_total_weight" INTEGER NOT NULL DEFAULT 0,
  "is_comment" INTEGER NOT NULL DEFAULT 0,
  "after_sale_status" INTEGER NOT NULL DEFAULT 0,
  "refund_status" INTEGER NOT NULL DEFAULT 0,
  "printer_status" INTEGER NOT NULL DEFAULT 0,
  "printer_time" INTEGER DEFAULT 0,
  "is_deliver" INTEGER NOT NULL DEFAULT 0,
  "is_rebate" INTEGER NOT NULL DEFAULT 0,
  "third_good_id" INTEGER NOT NULL DEFAULT 0,
  "is_no_quality_issue" INTEGER NOT NULL DEFAULT 0,
  "is_prefer" INTEGER NOT NULL DEFAULT 0,
  "quality_flag" INTEGER NOT NULL DEFAULT 0,
  "deliver_time" TEXT DEFAULT NULL,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "bak_20260901_a105_package" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "type" INTEGER NOT NULL DEFAULT 0,
  "round_no" TEXT NOT NULL DEFAULT '',
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "province" TEXT NOT NULL DEFAULT '',
  "city" TEXT NOT NULL DEFAULT '',
  "send_no" TEXT NOT NULL DEFAULT '',
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "sub_shelf_sn" TEXT NOT NULL DEFAULT '',
  "self_take_type" INTEGER NOT NULL DEFAULT 0,
  "zone" TEXT DEFAULT '',
  "shelf" TEXT DEFAULT '',
  "zone_shelf" TEXT DEFAULT '',
  "min_shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "max_shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "serial_num" INTEGER NOT NULL DEFAULT 0,
  "package_num" INTEGER NOT NULL DEFAULT 0,
  "total_weight" REAL NOT NULL DEFAULT 0.000,
  "item_num" INTEGER NOT NULL DEFAULT 0,
  "express_id" INTEGER NOT NULL DEFAULT 0,
  "region_id" INTEGER NOT NULL DEFAULT 0,
  "origin_express_id" INTEGER NOT NULL DEFAULT 0,
  "origin_region_id" INTEGER NOT NULL DEFAULT 0,
  "express_type" INTEGER NOT NULL DEFAULT 0,
  "express_status" INTEGER NOT NULL DEFAULT 0,
  "pickup_flag" INTEGER NOT NULL DEFAULT 0,
  "pickup_time" TEXT DEFAULT NULL,
  "pickup_operator_id" INTEGER DEFAULT 0,
  "pickup_operator_name" TEXT NOT NULL DEFAULT '',
  "pickup_abnormal" INTEGER NOT NULL DEFAULT 1,
  "abnormal_reason" TEXT DEFAULT NULL,
  "report_price" REAL DEFAULT NULL,
  "waybill_price_id" INTEGER DEFAULT NULL,
  "reconcile_sub_bill_id" INTEGER NOT NULL DEFAULT 0,
  "reject_reason" TEXT DEFAULT NULL,
  "out_type" INTEGER NOT NULL DEFAULT 0,
  "express_actual_weight" REAL NOT NULL DEFAULT 0.00,
  "express_actual_price" REAL NOT NULL DEFAULT 0.00,
  "express_user_id" INTEGER NOT NULL DEFAULT 0,
  "express_user_name" TEXT NOT NULL DEFAULT '',
  "package_user_id" INTEGER NOT NULL DEFAULT 0,
  "package_user_name" TEXT NOT NULL DEFAULT '',
  "url" TEXT NOT NULL DEFAULT '',
  "ship_url" TEXT NOT NULL DEFAULT '',
  "package_time" TEXT DEFAULT NULL,
  "express_modifier_id" INTEGER NOT NULL DEFAULT 0,
  "express_modifier_name" TEXT NOT NULL DEFAULT '',
  "express_modify_time" TEXT DEFAULT NULL,
  "express_time" TEXT DEFAULT NULL,
  "package_id" INTEGER NOT NULL DEFAULT 0,
  "package_info" TEXT NOT NULL DEFAULT '',
  "suggest_pack_id" INTEGER NOT NULL DEFAULT 0,
  "suggest_pack_info" TEXT NOT NULL DEFAULT '',
  "valid_status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "bak_20260901_a105_partner_bind" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "start_sell_weight" REAL NOT NULL DEFAULT 0.00,
  "status" INTEGER NOT NULL DEFAULT 0,
  "shipping_area_initialized" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "large_customer_pack_flag" INTEGER NOT NULL DEFAULT 0,
  "large_customer_pack_weight" REAL NOT NULL DEFAULT 10.00,
  UNIQUE ("partner_id", "ware_id")
);
CREATE TABLE IF NOT EXISTS "bak_20260901_a105_purchaser" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "zq_user_id" INTEGER NOT NULL DEFAULT 0,
  "platform" INTEGER NOT NULL DEFAULT 0,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "xm_account" TEXT NOT NULL DEFAULT '',
  "xm_com_id" INTEGER NOT NULL DEFAULT 0,
  "company_direct_sale_store" INTEGER NOT NULL DEFAULT 0,
  "company_level" INTEGER NOT NULL DEFAULT 6,
  "xm_coin" REAL NOT NULL DEFAULT 0.00,
  "xm_coin_income" REAL NOT NULL DEFAULT 0.00,
  "xm_coin_expend" REAL NOT NULL DEFAULT 0.00,
  "xm_coin_give" REAL NOT NULL DEFAULT 0.00,
  "xm_coin_rebate" REAL NOT NULL DEFAULT 0.00,
  "xm_coin_paid" REAL NOT NULL DEFAULT 0.00,
  "phone_number" TEXT NOT NULL DEFAULT '',
  "password" TEXT NOT NULL DEFAULT '',
  "salt" TEXT NOT NULL DEFAULT '',
  "app_id" TEXT NOT NULL DEFAULT '',
  "open_id" TEXT NOT NULL DEFAULT '',
  "zc_open_id" TEXT NOT NULL DEFAULT '',
  "session_key" TEXT NOT NULL DEFAULT '',
  "gender" INTEGER NOT NULL DEFAULT 0,
  "province" TEXT NOT NULL DEFAULT '',
  "city" TEXT NOT NULL DEFAULT '',
  "country" TEXT NOT NULL DEFAULT '',
  "area_type" INTEGER NOT NULL DEFAULT 0,
  "auto_area_flag" INTEGER NOT NULL DEFAULT 1,
  "nickname" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "avatar_url" TEXT NOT NULL DEFAULT '',
  "pic_avatar_url" TEXT NOT NULL DEFAULT '',
  "pic_user_background_url" TEXT NOT NULL DEFAULT '',
  "pic_user_introduction" TEXT NOT NULL DEFAULT '',
  "help_id" INTEGER NOT NULL DEFAULT 0,
  "ma_help_id" INTEGER NOT NULL DEFAULT 0,
  "pid" INTEGER NOT NULL DEFAULT 0,
  "last_login_time" TEXT DEFAULT NULL,
  "last_login_ip" TEXT DEFAULT NULL,
  "class_type" INTEGER NOT NULL DEFAULT 1,
  "contact_supplier_count" INTEGER NOT NULL DEFAULT 3,
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "config_id" INTEGER NOT NULL DEFAULT 0,
  "first_buy_time" TEXT NOT NULL DEFAULT '',
  "last_buy_time" TEXT NOT NULL DEFAULT '',
  "last_second_buy_time" TEXT NOT NULL DEFAULT '',
  "buy_times" INTEGER NOT NULL DEFAULT 0,
  "ma_first_buy_time" TEXT NOT NULL DEFAULT '',
  "ma_last_buy_time" TEXT NOT NULL DEFAULT '',
  "ma_month_buy_time" INTEGER NOT NULL DEFAULT 0,
  "bb_flag" INTEGER NOT NULL DEFAULT 0,
  "month_consumption" REAL NOT NULL DEFAULT 0.00,
  "total_consumption" REAL NOT NULL DEFAULT 0.00,
  "item_num" INTEGER NOT NULL DEFAULT 0,
  "last_recall_time" TEXT DEFAULT NULL,
  "month_item_num" INTEGER NOT NULL DEFAULT 0,
  "block_flag" INTEGER NOT NULL DEFAULT 0,
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "holiday_white_flag" INTEGER NOT NULL DEFAULT 0,
  "internal_employee_flag" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT DEFAULT NULL,
  "phone_change_time" TEXT DEFAULT NULL,
  "phone_change_version" INTEGER NOT NULL DEFAULT 0,
  "express_recommend_flag" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("phone_number", "app_id")
);
CREATE TABLE IF NOT EXISTS "bak_20260901_a105_send_order" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "send_no" TEXT NOT NULL DEFAULT '',
  "round_no" TEXT NOT NULL DEFAULT '',
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "order_num" INTEGER DEFAULT 0,
  "ware_sn" INTEGER NOT NULL DEFAULT 0,
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "sub_shelf_sn" TEXT NOT NULL DEFAULT '',
  "zone" TEXT NOT NULL DEFAULT '',
  "shelf" TEXT NOT NULL DEFAULT '',
  "zone_shelf" TEXT NOT NULL DEFAULT '',
  "delivery_type" INTEGER NOT NULL DEFAULT 1,
  "distribution_type" INTEGER NOT NULL DEFAULT 0,
  "actual_total_weight" INTEGER NOT NULL DEFAULT 0,
  "expend_express_price" REAL NOT NULL DEFAULT 0.00,
  "pickup_fee" REAL NOT NULL DEFAULT 0.00,
  "express_price_flag" INTEGER NOT NULL DEFAULT 0,
  "freight_price_mode" INTEGER NOT NULL DEFAULT 0,
  "package_report_price" REAL DEFAULT NULL,
  "waybill_report_price" REAL DEFAULT NULL,
  "reconcile_sub_bill_id" INTEGER NOT NULL DEFAULT 0,
  "compensate_price" REAL NOT NULL DEFAULT 0.00,
  "expend_service_fee" REAL NOT NULL DEFAULT 0.00,
  "estimate_express_price" REAL NOT NULL DEFAULT 0.00,
  "actual_package_info" TEXT,
  "config_id" INTEGER NOT NULL DEFAULT 0,
  "express_region" INTEGER NOT NULL DEFAULT 0,
  "real_express_id" INTEGER NOT NULL DEFAULT 0,
  "real_express_region" INTEGER NOT NULL DEFAULT 0,
  "month_buy" INTEGER NOT NULL DEFAULT 0,
  "receive_name" TEXT NOT NULL DEFAULT '',
  "receive_tel" TEXT NOT NULL DEFAULT '',
  "province" TEXT NOT NULL DEFAULT '',
  "city" TEXT NOT NULL DEFAULT '',
  "district" TEXT NOT NULL DEFAULT '',
  "detail" TEXT NOT NULL DEFAULT '',
  "receive_address" TEXT NOT NULL DEFAULT '',
  "nation_code" TEXT DEFAULT NULL,
  "adcode" TEXT NOT NULL DEFAULT '',
  "longitude" TEXT NOT NULL DEFAULT '',
  "latitude" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "city_remark" TEXT NOT NULL DEFAULT '',
  "logistics_remark" TEXT NOT NULL DEFAULT '',
  "send_status" INTEGER NOT NULL DEFAULT 0,
  "logistics_status" INTEGER NOT NULL DEFAULT 0,
  "express_change_status" INTEGER NOT NULL DEFAULT 0,
  "print_status" INTEGER NOT NULL DEFAULT 0,
  "is_sale_agency" INTEGER NOT NULL DEFAULT 0,
  "new_buyer" INTEGER NOT NULL DEFAULT 0,
  "help_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "order_create_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "waybill_print_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("send_no")
);
CREATE TABLE IF NOT EXISTS "bak_20260901_a105_wms_area" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "code" TEXT NOT NULL DEFAULT '',
  "area_name" TEXT NOT NULL DEFAULT '',
  "start_shelf" INTEGER NOT NULL DEFAULT 0,
  "end_shelf" INTEGER NOT NULL DEFAULT 0,
  "ware_type" INTEGER NOT NULL DEFAULT 0,
  "sort_config" INTEGER NOT NULL DEFAULT 0,
  "sub_area" TEXT NOT NULL DEFAULT '',
  "segment_area" TEXT,
  "pack_income_config" TEXT NOT NULL DEFAULT '',
  "delivery_income" REAL NOT NULL DEFAULT 0.00,
  "standby" INTEGER NOT NULL DEFAULT 0,
  "sequence" INTEGER NOT NULL DEFAULT 1,
  "remark" TEXT NOT NULL DEFAULT '',
  "area_manager_id" INTEGER NOT NULL DEFAULT 0,
  "area_manager_name" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "status" INTEGER NOT NULL DEFAULT 1,
  UNIQUE ("code")
);
CREATE TABLE IF NOT EXISTS "bak_20260901_cd9_backup_express" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "config_id" INTEGER NOT NULL DEFAULT 0,
  "sort_config_str" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "sort_type" INTEGER NOT NULL DEFAULT 1,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("config_id")
);
CREATE TABLE IF NOT EXISTS "bak_20260901_cd9_bind" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "start_sell_weight" REAL NOT NULL DEFAULT 0.00,
  "status" INTEGER NOT NULL DEFAULT 0,
  "shipping_area_initialized" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "large_customer_pack_flag" INTEGER NOT NULL DEFAULT 0,
  "large_customer_pack_weight" REAL NOT NULL DEFAULT 10.00,
  UNIQUE ("partner_id", "ware_id")
);
CREATE TABLE IF NOT EXISTS "bak_20260901_cd9_city" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL DEFAULT '',
  "app_id" TEXT NOT NULL DEFAULT '',
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "express_id" INTEGER NOT NULL DEFAULT 0,
  "region_id" INTEGER NOT NULL DEFAULT 0,
  "store_id" INTEGER NOT NULL DEFAULT 0,
  "city_store_open" INTEGER NOT NULL DEFAULT 1,
  "add_price" REAL NOT NULL DEFAULT 1.00,
  "add_price_flag" INTEGER NOT NULL DEFAULT 0,
  "distance" REAL NOT NULL DEFAULT 5.00,
  "distance_price" REAL NOT NULL DEFAULT 0.00,
  "weight_price" REAL NOT NULL DEFAULT 0.00,
  "express_add_price" REAL NOT NULL DEFAULT 0.00,
  "start_sell_weight" REAL NOT NULL DEFAULT 0.00,
  "distribution_type" INTEGER NOT NULL DEFAULT 0,
  "longitude" TEXT NOT NULL DEFAULT '',
  "latitude" TEXT NOT NULL DEFAULT '',
  "province" TEXT NOT NULL DEFAULT '',
  "city" TEXT NOT NULL DEFAULT '',
  "district" TEXT NOT NULL DEFAULT '',
  "detail" TEXT NOT NULL DEFAULT '',
  "business_address" TEXT NOT NULL DEFAULT '',
  "city_code" TEXT NOT NULL DEFAULT '',
  "adcode" TEXT NOT NULL DEFAULT '',
  "contact_name" TEXT NOT NULL DEFAULT '',
  "contact_tel" TEXT NOT NULL DEFAULT '',
  "logistics_phone" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "operate_status" INTEGER NOT NULL DEFAULT 1,
  "phone_switch" INTEGER NOT NULL DEFAULT 1,
  "flash_sale_switch" INTEGER NOT NULL DEFAULT 1,
  "cotton_switch" INTEGER NOT NULL DEFAULT 0,
  "cotton_num" INTEGER NOT NULL DEFAULT 0,
  "board_switch" INTEGER NOT NULL DEFAULT 0,
  "board_num" INTEGER NOT NULL DEFAULT 0,
  "hour_delivery_switch" INTEGER NOT NULL DEFAULT 1,
  "xmmaterials_open" INTEGER NOT NULL DEFAULT 1,
  "change_add_price_switch" INTEGER NOT NULL DEFAULT 1,
  "single_delivery_flag" INTEGER NOT NULL DEFAULT 0,
  "coupon_flag" INTEGER NOT NULL DEFAULT 1,
  "promote_flag" INTEGER NOT NULL DEFAULT 0,
  "service_fee_flag" INTEGER NOT NULL DEFAULT 0,
  "audit_status" INTEGER NOT NULL DEFAULT 0,
  "audit_name" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "delivery_type" INTEGER NOT NULL DEFAULT 0,
  "share_ratio" REAL NOT NULL DEFAULT 0.00,
  "promote_merchant_flag" INTEGER NOT NULL DEFAULT 0,
  "large_customer_pack_flag" INTEGER NOT NULL DEFAULT 0,
  "large_customer_pack_weight" REAL NOT NULL DEFAULT 10.00
);
CREATE TABLE IF NOT EXISTS "bak_20260901_cd9_common" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "type" INTEGER NOT NULL DEFAULT 0,
  "type_str" TEXT NOT NULL DEFAULT '',
  "price" REAL NOT NULL DEFAULT 0.000,
  "config_str" TEXT NOT NULL DEFAULT '',
  "tips" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("type")
);
CREATE TABLE IF NOT EXISTS "bak_20260901_cd9_daily_shelf" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "round_no" TEXT NOT NULL DEFAULT '',
  "order_sn" TEXT NOT NULL DEFAULT '',
  "send_no" TEXT NOT NULL DEFAULT '',
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "zone" TEXT NOT NULL DEFAULT '',
  "shelf" TEXT NOT NULL DEFAULT '',
  "zone_shelf" TEXT NOT NULL DEFAULT '',
  "sub_shelf_sn" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "bak_20260901_cd9_daily_shelf_test" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "round_no" TEXT NOT NULL DEFAULT '',
  "order_sn" TEXT NOT NULL DEFAULT '',
  "send_no" TEXT NOT NULL DEFAULT '',
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "zone" TEXT NOT NULL DEFAULT '',
  "shelf" TEXT NOT NULL DEFAULT '',
  "zone_shelf" TEXT NOT NULL DEFAULT '',
  "sub_shelf_sn" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "bak_20260901_cd9_logistics" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "logistics_name" TEXT NOT NULL DEFAULT '',
  "brand" TEXT NOT NULL DEFAULT '',
  "phone" TEXT NOT NULL DEFAULT '',
  "logistics_type" INTEGER NOT NULL DEFAULT 0,
  "expected_time_str" TEXT NOT NULL DEFAULT '',
  "delay_time_num" INTEGER NOT NULL DEFAULT 0,
  "is_to_shop" INTEGER NOT NULL DEFAULT 0,
  "transfer_cost" REAL NOT NULL DEFAULT 0,
  "is_separate_display" INTEGER NOT NULL DEFAULT 0,
  "is_enable" INTEGER NOT NULL DEFAULT 0,
  "rule_id" INTEGER NOT NULL DEFAULT 0,
  "first_heavy" INTEGER NOT NULL DEFAULT 0,
  "first_heavy_price" REAL NOT NULL DEFAULT 0.00,
  "charge_type" INTEGER NOT NULL DEFAULT 0,
  "continue_heavy_price" REAL NOT NULL DEFAULT 0.00,
  "is_transfer" INTEGER NOT NULL DEFAULT 0,
  "need_pick_fee" INTEGER NOT NULL DEFAULT 1,
  "small_item_recommend" INTEGER NOT NULL DEFAULT 0,
  "logistics_shift" INTEGER NOT NULL DEFAULT 0,
  "sort_num" INTEGER NOT NULL DEFAULT 0,
  "show_sort_num" INTEGER NOT NULL DEFAULT 0,
  "description" TEXT NOT NULL DEFAULT '',
  "delivery_time" TEXT NOT NULL DEFAULT '',
  "picker_phone" TEXT NOT NULL DEFAULT '',
  "need_fill_express_price" INTEGER NOT NULL DEFAULT 1,
  "need_fill_weight" INTEGER NOT NULL DEFAULT 1,
  "need_weight_photo" INTEGER NOT NULL DEFAULT 1,
  "out_flag" INTEGER NOT NULL DEFAULT 1,
  "pack_timeout_punish_flag" INTEGER NOT NULL DEFAULT 0,
  "promotion_flag" INTEGER NOT NULL DEFAULT 0,
  "promotion_start" TEXT DEFAULT NULL,
  "promotion_end" TEXT DEFAULT NULL,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "send_area" TEXT NOT NULL DEFAULT '',
  "is_invoice_marked" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "bak_20260901_cd9_order" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "vip_name" TEXT NOT NULL DEFAULT '',
  "order_sn" TEXT NOT NULL DEFAULT '',
  "order_type" INTEGER NOT NULL DEFAULT 0,
  "delivery_type" INTEGER NOT NULL DEFAULT 1,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "partner_model" INTEGER NOT NULL DEFAULT 0,
  "merchant_id" TEXT NOT NULL DEFAULT '',
  "app_id" TEXT NOT NULL DEFAULT '',
  "open_id" TEXT NOT NULL DEFAULT '',
  "distribution_type" INTEGER NOT NULL DEFAULT 0,
  "is_addition" INTEGER NOT NULL DEFAULT 0,
  "platform" INTEGER NOT NULL DEFAULT 0,
  "has_third_good" INTEGER NOT NULL DEFAULT 0,
  "is_zq_settlement" INTEGER NOT NULL DEFAULT 0,
  "send_no" TEXT NOT NULL DEFAULT '',
  "round_no" TEXT NOT NULL DEFAULT '',
  "order_num" INTEGER NOT NULL DEFAULT 1,
  "total_item_num" INTEGER NOT NULL DEFAULT 0,
  "total_weight" INTEGER NOT NULL DEFAULT 0,
  "origin_total_weight" INTEGER NOT NULL DEFAULT 0,
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "sub_shelf_sn" TEXT NOT NULL DEFAULT '',
  "zone" TEXT NOT NULL DEFAULT '',
  "shelf" TEXT NOT NULL DEFAULT '',
  "zone_shelf" TEXT NOT NULL DEFAULT '',
  "express" INTEGER NOT NULL DEFAULT 0,
  "express_region" INTEGER NOT NULL DEFAULT 0,
  "real_express_id" INTEGER NOT NULL DEFAULT 0,
  "real_express_region" INTEGER NOT NULL DEFAULT 0,
  "express_time" INTEGER DEFAULT NULL,
  "express_price" REAL NOT NULL DEFAULT 0,
  "before_activity_express_price" REAL DEFAULT 0.00,
  "activity_express_name" TEXT NOT NULL DEFAULT '',
  "coupon_price" REAL NOT NULL DEFAULT 0.00,
  "origin_coupon_price" REAL NOT NULL DEFAULT 0.00,
  "platform_reduce_price" REAL NOT NULL DEFAULT 0.00,
  "origin_platform_reduce_price" REAL NOT NULL DEFAULT 0.00,
  "add_price" REAL NOT NULL DEFAULT 0.00,
  "origin_add_price" REAL NOT NULL DEFAULT 0.00,
  "warehouse_add_price" REAL NOT NULL DEFAULT 0.00,
  "origin_warehouse_add_price" REAL NOT NULL DEFAULT 0.00,
  "express_add_price" REAL NOT NULL DEFAULT 0.00,
  "origin_express_add_price" REAL NOT NULL DEFAULT 0.00,
  "ot_exp_add_price" REAL NOT NULL DEFAULT 0.00,
  "origin_ot_exp_add_price" REAL NOT NULL DEFAULT 0.00,
  "delivery_fee" REAL NOT NULL DEFAULT 0.00,
  "origin_delivery_fee" REAL NOT NULL DEFAULT 0.00,
  "modify_express_price" REAL NOT NULL DEFAULT 0.00,
  "is_change_express" INTEGER NOT NULL DEFAULT 0,
  "actual_express_price" REAL DEFAULT NULL,
  "origin_supply_price" REAL NOT NULL DEFAULT 0.00,
  "product_total_price" REAL NOT NULL DEFAULT 0,
  "origin_product_total_price" REAL NOT NULL DEFAULT 0.00,
  "service_fee" REAL NOT NULL DEFAULT 0.00,
  "origin_service_fee" REAL NOT NULL DEFAULT 0.00,
  "extra_service_fee" REAL NOT NULL DEFAULT 0.00,
  "origin_extra_service_fee" REAL NOT NULL DEFAULT 0.00,
  "vip_discount_service_fee" REAL NOT NULL DEFAULT 0.00,
  "origin_vip_discount_service_fee" REAL NOT NULL DEFAULT 0.00,
  "platform_discount" REAL NOT NULL DEFAULT 0.00,
  "origin_platform_discount" REAL NOT NULL DEFAULT 0.00,
  "subsidy_price" REAL NOT NULL DEFAULT 0.00,
  "origin_subsidy_price" REAL NOT NULL DEFAULT 0.00,
  "negate_add_price" REAL NOT NULL DEFAULT 0.00,
  "origin_negate_add_price" REAL NOT NULL DEFAULT 0.00,
  "base_service_fee" REAL NOT NULL DEFAULT 0.00,
  "origin_base_service_fee" REAL NOT NULL DEFAULT 0.00,
  "total_price" REAL NOT NULL DEFAULT 0,
  "origin_total_price" REAL NOT NULL DEFAULT 0.00,
  "origin_use_xm_coin" REAL NOT NULL DEFAULT 0.00,
  "use_xm_coin" REAL NOT NULL DEFAULT 0.00,
  "rebate_xm_coin" REAL NOT NULL DEFAULT 0.00,
  "origin_rebate_xm_coin" REAL NOT NULL DEFAULT 0.00,
  "actual_price" REAL NOT NULL DEFAULT 0.00,
  "origin_actual_price" REAL NOT NULL DEFAULT 0.00,
  "apply_price" REAL NOT NULL DEFAULT 0.00,
  "actual_refund" REAL NOT NULL DEFAULT 0.00,
  "actual_coin" REAL NOT NULL DEFAULT 0.00,
  "paid_price" REAL NOT NULL DEFAULT 0.00,
  "paid_coin" REAL NOT NULL DEFAULT 0.00,
  "pay_type" INTEGER NOT NULL DEFAULT 0,
  "pay_on_delivery" INTEGER NOT NULL DEFAULT 0,
  "receive_name" TEXT NOT NULL DEFAULT '',
  "receive_tel" TEXT NOT NULL DEFAULT '',
  "province" TEXT NOT NULL DEFAULT '',
  "city" TEXT NOT NULL DEFAULT '',
  "district" TEXT NOT NULL DEFAULT '',
  "detail" TEXT NOT NULL DEFAULT '',
  "receive_address" TEXT NOT NULL DEFAULT '',
  "nation_code" TEXT NOT NULL DEFAULT '86',
  "adcode" TEXT NOT NULL DEFAULT '',
  "buyer_memo" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "order_status" INTEGER NOT NULL DEFAULT 0,
  "after_sale_status" INTEGER NOT NULL DEFAULT 0,
  "after_sale_agree_type" INTEGER NOT NULL DEFAULT 0,
  "after_sale_count" INTEGER NOT NULL DEFAULT 0,
  "refund_status" INTEGER NOT NULL DEFAULT 0,
  "print_status" INTEGER NOT NULL DEFAULT 0,
  "wx_pay_time" TEXT DEFAULT NULL,
  "wx_pay_id" TEXT NOT NULL DEFAULT '',
  "send_time" TEXT DEFAULT NULL,
  "delay_ddl" TEXT DEFAULT NULL,
  "confirm_time" TEXT DEFAULT NULL,
  "extra_info" TEXT,
  "coupon_user_id" INTEGER NOT NULL DEFAULT 0,
  "is_comment" INTEGER NOT NULL DEFAULT 0,
  "is_open_after_sale" INTEGER NOT NULL DEFAULT 0,
  "is_deliver" INTEGER NOT NULL DEFAULT 0,
  "is_bond" INTEGER NOT NULL DEFAULT 0,
  "is_cotton" INTEGER NOT NULL DEFAULT 0,
  "flag" INTEGER NOT NULL DEFAULT 0,
  "bear_type" INTEGER NOT NULL DEFAULT 0,
  "is_bear_station_fee" INTEGER NOT NULL DEFAULT 0,
  "origin_total_station_fee" REAL NOT NULL DEFAULT 0.00,
  "total_station_fee" REAL NOT NULL DEFAULT 0.00,
  "is_presale" INTEGER NOT NULL DEFAULT 0,
  "is_sale_agency" INTEGER NOT NULL DEFAULT 0,
  "order_tag" INTEGER NOT NULL DEFAULT 0,
  "help_id" INTEGER NOT NULL DEFAULT 0,
  "pid" INTEGER NOT NULL DEFAULT 0,
  "unqualified_way" INTEGER NOT NULL DEFAULT 0,
  "assign_customer_id" INTEGER NOT NULL DEFAULT 0,
  "assign_customer_name" TEXT NOT NULL DEFAULT '',
  "ship_flag" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "partner_add_service_fee" REAL DEFAULT 0.00,
  "origin_partner_add_service_fee" REAL DEFAULT 0.00,
  UNIQUE ("order_sn")
);
CREATE TABLE IF NOT EXISTS "bak_20260901_cd9_order_info" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "send_no" TEXT NOT NULL DEFAULT '',
  "api_order_sn" TEXT NOT NULL DEFAULT '',
  "has_cotton" INTEGER NOT NULL DEFAULT 0,
  "cotton_info" TEXT NOT NULL DEFAULT '',
  "promote_merchant_flag" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("order_sn")
);
CREATE TABLE IF NOT EXISTS "bak_20260901_cd9_order_item" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "order_num" INTEGER NOT NULL DEFAULT 0,
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "sub_shelf_sn" TEXT NOT NULL DEFAULT '',
  "zone" TEXT NOT NULL DEFAULT '',
  "shelf" TEXT NOT NULL DEFAULT '',
  "zone_shelf" TEXT DEFAULT '',
  "order_sn" TEXT NOT NULL DEFAULT '',
  "round_no" TEXT NOT NULL DEFAULT '',
  "supplier_no" TEXT NOT NULL DEFAULT '',
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "product_name" TEXT NOT NULL DEFAULT '',
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "rank_num" INTEGER NOT NULL DEFAULT 1,
  "sku_config" TEXT NOT NULL DEFAULT '',
  "pic_url" TEXT NOT NULL DEFAULT '',
  "spec_and_num" TEXT NOT NULL DEFAULT '',
  "description" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "supply_price" REAL NOT NULL DEFAULT 0.00,
  "pay_price" REAL NOT NULL DEFAULT 0.00,
  "platform_discount_price" REAL NOT NULL DEFAULT 0.00,
  "subsidy_price" REAL NOT NULL DEFAULT 0.00,
  "coupon_pay_price" REAL NOT NULL DEFAULT 0.00,
  "total_discount_refundable" REAL NOT NULL DEFAULT 0.00,
  "origin_total_discount_refundable" REAL NOT NULL DEFAULT 0.00,
  "coupon_discount_per_bundle" REAL NOT NULL DEFAULT 0.00,
  "full_reduction_discount_per_bundle" REAL NOT NULL DEFAULT 0.00,
  "add_price" REAL NOT NULL DEFAULT 0.00,
  "total_add_price" REAL NOT NULL DEFAULT 0.00,
  "origin_total_add_price" REAL NOT NULL DEFAULT 0.00,
  "warehouse_add_price" REAL NOT NULL DEFAULT 0.00,
  "negate_add_price" REAL NOT NULL DEFAULT 0.00,
  "station_fee" REAL NOT NULL DEFAULT 0.00,
  "express_add_price" REAL NOT NULL DEFAULT 0.00,
  "item_num" INTEGER NOT NULL DEFAULT 0,
  "origin_item_num" INTEGER NOT NULL DEFAULT 0,
  "after_sale_item_num" INTEGER NOT NULL DEFAULT 0,
  "after_sale_refund" REAL NOT NULL DEFAULT 0.00,
  "bond_item_num" INTEGER NOT NULL DEFAULT 0,
  "after_sale_supplier_num" INTEGER NOT NULL DEFAULT 0,
  "actual_price" REAL NOT NULL DEFAULT 0.00,
  "origin_actual_price" REAL NOT NULL DEFAULT 0.00,
  "service_price" REAL NOT NULL DEFAULT 0.00,
  "partner_add_service_price" REAL NOT NULL DEFAULT 0.00,
  "total_partner_add_service_price" REAL NOT NULL DEFAULT 0.00,
  "total_price" REAL NOT NULL DEFAULT 0.00,
  "origin_total_price" REAL NOT NULL DEFAULT 0.00,
  "total_weight" INTEGER NOT NULL DEFAULT 0,
  "origin_total_weight" INTEGER NOT NULL DEFAULT 0,
  "is_comment" INTEGER NOT NULL DEFAULT 0,
  "after_sale_status" INTEGER NOT NULL DEFAULT 0,
  "refund_status" INTEGER NOT NULL DEFAULT 0,
  "printer_status" INTEGER NOT NULL DEFAULT 0,
  "printer_time" INTEGER DEFAULT 0,
  "is_deliver" INTEGER NOT NULL DEFAULT 0,
  "is_rebate" INTEGER NOT NULL DEFAULT 0,
  "third_good_id" INTEGER NOT NULL DEFAULT 0,
  "is_no_quality_issue" INTEGER NOT NULL DEFAULT 0,
  "is_prefer" INTEGER NOT NULL DEFAULT 0,
  "quality_flag" INTEGER NOT NULL DEFAULT 0,
  "deliver_time" TEXT DEFAULT NULL,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "bak_20260901_cd9_package" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "type" INTEGER NOT NULL DEFAULT 0,
  "round_no" TEXT NOT NULL DEFAULT '',
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "province" TEXT NOT NULL DEFAULT '',
  "city" TEXT NOT NULL DEFAULT '',
  "send_no" TEXT NOT NULL DEFAULT '',
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "sub_shelf_sn" TEXT NOT NULL DEFAULT '',
  "self_take_type" INTEGER NOT NULL DEFAULT 0,
  "zone" TEXT DEFAULT '',
  "shelf" TEXT DEFAULT '',
  "zone_shelf" TEXT DEFAULT '',
  "min_shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "max_shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "serial_num" INTEGER NOT NULL DEFAULT 0,
  "package_num" INTEGER NOT NULL DEFAULT 0,
  "total_weight" REAL NOT NULL DEFAULT 0.000,
  "item_num" INTEGER NOT NULL DEFAULT 0,
  "express_id" INTEGER NOT NULL DEFAULT 0,
  "region_id" INTEGER NOT NULL DEFAULT 0,
  "origin_express_id" INTEGER NOT NULL DEFAULT 0,
  "origin_region_id" INTEGER NOT NULL DEFAULT 0,
  "express_type" INTEGER NOT NULL DEFAULT 0,
  "express_status" INTEGER NOT NULL DEFAULT 0,
  "pickup_flag" INTEGER NOT NULL DEFAULT 0,
  "pickup_time" TEXT DEFAULT NULL,
  "pickup_operator_id" INTEGER DEFAULT 0,
  "pickup_operator_name" TEXT NOT NULL DEFAULT '',
  "pickup_abnormal" INTEGER NOT NULL DEFAULT 1,
  "abnormal_reason" TEXT DEFAULT NULL,
  "report_price" REAL DEFAULT NULL,
  "waybill_price_id" INTEGER DEFAULT NULL,
  "reconcile_sub_bill_id" INTEGER NOT NULL DEFAULT 0,
  "reject_reason" TEXT DEFAULT NULL,
  "out_type" INTEGER NOT NULL DEFAULT 0,
  "express_actual_weight" REAL NOT NULL DEFAULT 0.00,
  "express_actual_price" REAL NOT NULL DEFAULT 0.00,
  "express_user_id" INTEGER NOT NULL DEFAULT 0,
  "express_user_name" TEXT NOT NULL DEFAULT '',
  "package_user_id" INTEGER NOT NULL DEFAULT 0,
  "package_user_name" TEXT NOT NULL DEFAULT '',
  "url" TEXT NOT NULL DEFAULT '',
  "ship_url" TEXT NOT NULL DEFAULT '',
  "package_time" TEXT DEFAULT NULL,
  "express_modifier_id" INTEGER NOT NULL DEFAULT 0,
  "express_modifier_name" TEXT NOT NULL DEFAULT '',
  "express_modify_time" TEXT DEFAULT NULL,
  "express_time" TEXT DEFAULT NULL,
  "package_id" INTEGER NOT NULL DEFAULT 0,
  "package_info" TEXT NOT NULL DEFAULT '',
  "suggest_pack_id" INTEGER NOT NULL DEFAULT 0,
  "suggest_pack_info" TEXT NOT NULL DEFAULT '',
  "valid_status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "bak_20260901_cd9_purchaser" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "zq_user_id" INTEGER NOT NULL DEFAULT 0,
  "platform" INTEGER NOT NULL DEFAULT 0,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "xm_account" TEXT NOT NULL DEFAULT '',
  "xm_com_id" INTEGER NOT NULL DEFAULT 0,
  "company_direct_sale_store" INTEGER NOT NULL DEFAULT 0,
  "company_level" INTEGER NOT NULL DEFAULT 6,
  "xm_coin" REAL NOT NULL DEFAULT 0.00,
  "xm_coin_income" REAL NOT NULL DEFAULT 0.00,
  "xm_coin_expend" REAL NOT NULL DEFAULT 0.00,
  "xm_coin_give" REAL NOT NULL DEFAULT 0.00,
  "xm_coin_rebate" REAL NOT NULL DEFAULT 0.00,
  "xm_coin_paid" REAL NOT NULL DEFAULT 0.00,
  "phone_number" TEXT NOT NULL DEFAULT '',
  "password" TEXT NOT NULL DEFAULT '',
  "salt" TEXT NOT NULL DEFAULT '',
  "app_id" TEXT NOT NULL DEFAULT '',
  "open_id" TEXT NOT NULL DEFAULT '',
  "zc_open_id" TEXT NOT NULL DEFAULT '',
  "session_key" TEXT NOT NULL DEFAULT '',
  "gender" INTEGER NOT NULL DEFAULT 0,
  "province" TEXT NOT NULL DEFAULT '',
  "city" TEXT NOT NULL DEFAULT '',
  "country" TEXT NOT NULL DEFAULT '',
  "area_type" INTEGER NOT NULL DEFAULT 0,
  "auto_area_flag" INTEGER NOT NULL DEFAULT 1,
  "nickname" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "avatar_url" TEXT NOT NULL DEFAULT '',
  "pic_avatar_url" TEXT NOT NULL DEFAULT '',
  "pic_user_background_url" TEXT NOT NULL DEFAULT '',
  "pic_user_introduction" TEXT NOT NULL DEFAULT '',
  "help_id" INTEGER NOT NULL DEFAULT 0,
  "ma_help_id" INTEGER NOT NULL DEFAULT 0,
  "pid" INTEGER NOT NULL DEFAULT 0,
  "last_login_time" TEXT DEFAULT NULL,
  "last_login_ip" TEXT DEFAULT NULL,
  "class_type" INTEGER NOT NULL DEFAULT 1,
  "contact_supplier_count" INTEGER NOT NULL DEFAULT 3,
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "config_id" INTEGER NOT NULL DEFAULT 0,
  "first_buy_time" TEXT NOT NULL DEFAULT '',
  "last_buy_time" TEXT NOT NULL DEFAULT '',
  "last_second_buy_time" TEXT NOT NULL DEFAULT '',
  "buy_times" INTEGER NOT NULL DEFAULT 0,
  "ma_first_buy_time" TEXT NOT NULL DEFAULT '',
  "ma_last_buy_time" TEXT NOT NULL DEFAULT '',
  "ma_month_buy_time" INTEGER NOT NULL DEFAULT 0,
  "bb_flag" INTEGER NOT NULL DEFAULT 0,
  "month_consumption" REAL NOT NULL DEFAULT 0.00,
  "total_consumption" REAL NOT NULL DEFAULT 0.00,
  "item_num" INTEGER NOT NULL DEFAULT 0,
  "last_recall_time" TEXT DEFAULT NULL,
  "month_item_num" INTEGER NOT NULL DEFAULT 0,
  "block_flag" INTEGER NOT NULL DEFAULT 0,
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "holiday_white_flag" INTEGER NOT NULL DEFAULT 0,
  "internal_employee_flag" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT DEFAULT NULL,
  "phone_change_time" TEXT DEFAULT NULL,
  "phone_change_version" INTEGER NOT NULL DEFAULT 0,
  "express_recommend_flag" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("phone_number", "app_id")
);
CREATE TABLE IF NOT EXISTS "bak_20260901_cd9_send_order" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "send_no" TEXT NOT NULL DEFAULT '',
  "round_no" TEXT NOT NULL DEFAULT '',
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "order_num" INTEGER DEFAULT 0,
  "ware_sn" INTEGER NOT NULL DEFAULT 0,
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "sub_shelf_sn" TEXT NOT NULL DEFAULT '',
  "zone" TEXT NOT NULL DEFAULT '',
  "shelf" TEXT NOT NULL DEFAULT '',
  "zone_shelf" TEXT NOT NULL DEFAULT '',
  "delivery_type" INTEGER NOT NULL DEFAULT 1,
  "distribution_type" INTEGER NOT NULL DEFAULT 0,
  "actual_total_weight" INTEGER NOT NULL DEFAULT 0,
  "expend_express_price" REAL NOT NULL DEFAULT 0.00,
  "pickup_fee" REAL NOT NULL DEFAULT 0.00,
  "express_price_flag" INTEGER NOT NULL DEFAULT 0,
  "freight_price_mode" INTEGER NOT NULL DEFAULT 0,
  "package_report_price" REAL DEFAULT NULL,
  "waybill_report_price" REAL DEFAULT NULL,
  "reconcile_sub_bill_id" INTEGER NOT NULL DEFAULT 0,
  "compensate_price" REAL NOT NULL DEFAULT 0.00,
  "expend_service_fee" REAL NOT NULL DEFAULT 0.00,
  "estimate_express_price" REAL NOT NULL DEFAULT 0.00,
  "actual_package_info" TEXT,
  "config_id" INTEGER NOT NULL DEFAULT 0,
  "express_region" INTEGER NOT NULL DEFAULT 0,
  "real_express_id" INTEGER NOT NULL DEFAULT 0,
  "real_express_region" INTEGER NOT NULL DEFAULT 0,
  "month_buy" INTEGER NOT NULL DEFAULT 0,
  "receive_name" TEXT NOT NULL DEFAULT '',
  "receive_tel" TEXT NOT NULL DEFAULT '',
  "province" TEXT NOT NULL DEFAULT '',
  "city" TEXT NOT NULL DEFAULT '',
  "district" TEXT NOT NULL DEFAULT '',
  "detail" TEXT NOT NULL DEFAULT '',
  "receive_address" TEXT NOT NULL DEFAULT '',
  "nation_code" TEXT DEFAULT NULL,
  "adcode" TEXT NOT NULL DEFAULT '',
  "longitude" TEXT NOT NULL DEFAULT '',
  "latitude" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "city_remark" TEXT NOT NULL DEFAULT '',
  "logistics_remark" TEXT NOT NULL DEFAULT '',
  "send_status" INTEGER NOT NULL DEFAULT 0,
  "logistics_status" INTEGER NOT NULL DEFAULT 0,
  "express_change_status" INTEGER NOT NULL DEFAULT 0,
  "print_status" INTEGER NOT NULL DEFAULT 0,
  "is_sale_agency" INTEGER NOT NULL DEFAULT 0,
  "new_buyer" INTEGER NOT NULL DEFAULT 0,
  "help_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "order_create_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "waybill_print_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("send_no")
);
CREATE TABLE IF NOT EXISTS "bak_20260901_cd9_wms_area" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "code" TEXT NOT NULL DEFAULT '',
  "area_name" TEXT NOT NULL DEFAULT '',
  "start_shelf" INTEGER NOT NULL DEFAULT 0,
  "end_shelf" INTEGER NOT NULL DEFAULT 0,
  "ware_type" INTEGER NOT NULL DEFAULT 0,
  "sort_config" INTEGER NOT NULL DEFAULT 0,
  "sub_area" TEXT NOT NULL DEFAULT '',
  "segment_area" TEXT,
  "pack_income_config" TEXT NOT NULL DEFAULT '',
  "delivery_income" REAL NOT NULL DEFAULT 0.00,
  "standby" INTEGER NOT NULL DEFAULT 0,
  "sequence" INTEGER NOT NULL DEFAULT 1,
  "remark" TEXT NOT NULL DEFAULT '',
  "area_manager_id" INTEGER NOT NULL DEFAULT 0,
  "area_manager_name" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "status" INTEGER NOT NULL DEFAULT 1,
  UNIQUE ("code")
);
CREATE TABLE IF NOT EXISTS "banner_class_config" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "app_id" TEXT NOT NULL DEFAULT '',
  "type" INTEGER NOT NULL DEFAULT 1,
  "class_id" INTEGER NOT NULL DEFAULT 0,
  "content" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 1,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("app_id", "type", "class_id")
);
CREATE TABLE IF NOT EXISTS "banner_config" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "app_id" TEXT NOT NULL DEFAULT '',
  "content" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("app_id")
);
CREATE TABLE IF NOT EXISTS "blacklist_supplier" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "reason" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("partner_id", "supplier_id")
);
CREATE TABLE IF NOT EXISTS "blk_fhh_consult" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "app_id" TEXT NOT NULL DEFAULT '',
  "source" TEXT NOT NULL DEFAULT '',
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "tel" TEXT NOT NULL DEFAULT '',
  "content" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "blk_normal_wx_order" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "mch_id" TEXT NOT NULL DEFAULT '',
  "app_id" TEXT NOT NULL DEFAULT '',
  "open_id" TEXT NOT NULL DEFAULT '',
  "wx_pay_id" TEXT NOT NULL DEFAULT '',
  "item_desc" TEXT NOT NULL DEFAULT '',
  "send_no" TEXT NOT NULL DEFAULT '',
  "receive_tel" TEXT NOT NULL DEFAULT '',
  "logistics_type" INTEGER DEFAULT 3,
  "send_status" INTEGER NOT NULL DEFAULT 0,
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "blk_openid_appid_phone" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "app_id" TEXT NOT NULL DEFAULT '',
  "opne_id" TEXT NOT NULL DEFAULT '',
  "phone" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "blk_promotion_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "pid" INTEGER NOT NULL DEFAULT 0,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "nickname" TEXT NOT NULL DEFAULT '',
  "avatar_url" TEXT NOT NULL DEFAULT '',
  "phone" TEXT NOT NULL DEFAULT '',
  "money" REAL NOT NULL DEFAULT 0.00,
  "has_buy" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "blk_purchaser_extra_info" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "mt_id" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("purchaser_id")
);
CREATE TABLE IF NOT EXISTS "blk_recommend_info" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "tab_id" INTEGER NOT NULL DEFAULT 0,
  "title" TEXT NOT NULL DEFAULT '',
  "title_desc" TEXT NOT NULL DEFAULT '',
  "pic" TEXT,
  "user_num" INTEGER NOT NULL DEFAULT 0,
  "user_icon" TEXT,
  "create_time" TEXT DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "blk_recommend_tab" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "app_id" TEXT NOT NULL DEFAULT '',
  "name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "blk_saas_app" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL DEFAULT '',
  "app_id" TEXT NOT NULL DEFAULT '',
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "app_secret" TEXT NOT NULL DEFAULT '',
  "mch_id" TEXT NOT NULL DEFAULT '',
  "mch_key" TEXT NOT NULL DEFAULT '',
  "private_key_path" TEXT NOT NULL DEFAULT '',
  "private_cert_path" TEXT NOT NULL DEFAULT '',
  "key_path" TEXT NOT NULL DEFAULT '',
  "pub_key_path" TEXT NOT NULL DEFAULT '',
  "pub_key_id" TEXT NOT NULL DEFAULT '',
  "serial_no" TEXT NOT NULL DEFAULT '',
  "api_v3_key" TEXT NOT NULL DEFAULT '',
  "is_full_pub_model" INTEGER NOT NULL DEFAULT 0,
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "tl_cusid" TEXT NOT NULL DEFAULT '',
  "tl_app_id" TEXT NOT NULL DEFAULT '',
  "tl_public_key" TEXT,
  "tl_private_key" TEXT,
  "tl_notify_url" TEXT DEFAULT NULL,
  "tl_b2b_cusid" TEXT NOT NULL DEFAULT '',
  "tl_b2b_app_id" TEXT NOT NULL DEFAULT '',
  "tl_b2b_public_key" TEXT,
  "tl_b2b_private_key" TEXT,
  UNIQUE ("app_id")
);
CREATE TABLE IF NOT EXISTS "blk_wx_order_send" (
  "id" INTEGER NOT NULL DEFAULT 0,
  "order_sn" TEXT DEFAULT NULL,
  "wx_pay_id" TEXT DEFAULT NULL,
  "open_id" TEXT DEFAULT NULL,
  "send_status" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);
CREATE TABLE IF NOT EXISTS "blk_wx_pay_certificate" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "mch_id" TEXT NOT NULL DEFAULT '',
  "private_key_content" BLOB,
  "private_cert_content" BLOB,
  "p12_content" BLOB,
  "public_key_content" BLOB,
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("mch_id")
);
CREATE TABLE IF NOT EXISTS "blk_wx_pay_certificate_backup_20260718" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "app_id" TEXT NOT NULL DEFAULT '',
  "mch_id" TEXT NOT NULL DEFAULT '',
  "private_key_content" BLOB,
  "private_cert_content" BLOB,
  "p12_content" BLOB,
  "public_key_content" BLOB,
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("app_id", "mch_id")
);
CREATE TABLE IF NOT EXISTS "blk_wx_pay_certificate_mch_backup_20260718" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "mch_id" TEXT NOT NULL DEFAULT '',
  "private_key_content" BLOB,
  "private_cert_content" BLOB,
  "p12_content" BLOB,
  "public_key_content" BLOB,
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("mch_id")
);
CREATE TABLE IF NOT EXISTS "bulk_purchase_audit_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "biz_type" TEXT NOT NULL DEFAULT '',
  "biz_id" INTEGER NOT NULL DEFAULT 0,
  "biz_no" TEXT DEFAULT NULL,
  "action" TEXT NOT NULL DEFAULT '',
  "before_value" TEXT,
  "after_value" TEXT,
  "reason" TEXT DEFAULT NULL,
  "operator_id" INTEGER DEFAULT NULL,
  "operator_name" TEXT DEFAULT NULL,
  "operator_end" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT ''
);
CREATE TABLE IF NOT EXISTS "bulk_purchase_demand" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "demand_no" TEXT NOT NULL DEFAULT '',
  "theme" TEXT NOT NULL DEFAULT '',
  "publish_supplier_id" INTEGER NOT NULL DEFAULT 0,
  "publish_supplier_name" TEXT NOT NULL DEFAULT '',
  "round_no" TEXT NOT NULL DEFAULT '',
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "second_name" TEXT NOT NULL DEFAULT '',
  "spec_num" INTEGER NOT NULL DEFAULT 0,
  "spec_unit" TEXT DEFAULT NULL,
  "rank_codes" TEXT NOT NULL DEFAULT '',
  "demand_num" INTEGER NOT NULL DEFAULT 0,
  "append_num" INTEGER NOT NULL DEFAULT 0,
  "min_quote_num" INTEGER NOT NULL DEFAULT 0,
  "scope_type" INTEGER NOT NULL DEFAULT 0,
  "scope_config" TEXT DEFAULT NULL,
  "dounan_quote_end_time" TEXT NOT NULL DEFAULT '',
  "non_dounan_quote_end_time" TEXT NOT NULL DEFAULT '',
  "dounan_check_in_end_time" TEXT NOT NULL DEFAULT '',
  "non_dounan_check_in_end_time" TEXT NOT NULL DEFAULT '',
  "collect_end_time" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "terminate_type" INTEGER DEFAULT NULL,
  "close_reason" INTEGER DEFAULT NULL,
  "confirm_time" TEXT DEFAULT NULL,
  "confirm_by" INTEGER DEFAULT NULL,
  "confirm_name" TEXT DEFAULT NULL,
  "confirm_reason" TEXT DEFAULT NULL,
  "finish_type" INTEGER DEFAULT NULL,
  "finish_time" TEXT DEFAULT NULL,
  "finish_by" INTEGER DEFAULT NULL,
  "finish_name" TEXT DEFAULT NULL,
  "remark" TEXT DEFAULT NULL,
  "create_by" INTEGER DEFAULT NULL,
  "create_name" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  UNIQUE ("demand_no")
);
CREATE TABLE IF NOT EXISTS "bulk_purchase_demand_supplier" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "demand_id" INTEGER NOT NULL DEFAULT 0,
  "demand_no" TEXT NOT NULL DEFAULT '',
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "supplier_tag" TEXT DEFAULT NULL,
  "is_dounan" INTEGER NOT NULL DEFAULT 0,
  "month_sell_count" INTEGER DEFAULT NULL,
  "hit_condition" TEXT DEFAULT NULL,
  "source" INTEGER NOT NULL DEFAULT 0,
  "append_by" INTEGER DEFAULT NULL,
  "append_name" TEXT DEFAULT NULL,
  "append_reason" TEXT DEFAULT NULL,
  "append_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT '',
  UNIQUE ("demand_id", "supplier_id")
);
CREATE TABLE IF NOT EXISTS "bulk_purchase_label" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "label_code" TEXT NOT NULL DEFAULT '',
  "order_id" INTEGER NOT NULL DEFAULT 0,
  "order_no" TEXT NOT NULL DEFAULT '',
  "rank_code" INTEGER NOT NULL DEFAULT 0,
  "seq_no" INTEGER NOT NULL DEFAULT 0,
  "status" INTEGER NOT NULL DEFAULT 0,
  "scan_time" TEXT DEFAULT NULL,
  "scan_by" INTEGER DEFAULT NULL,
  "scan_name" TEXT DEFAULT NULL,
  "product_id" INTEGER DEFAULT NULL,
  "revoke_count" INTEGER NOT NULL DEFAULT 0,
  "void_time" TEXT DEFAULT NULL,
  "void_reason" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  UNIQUE ("label_code"),
  UNIQUE ("order_id", "rank_code", "seq_no")
);
CREATE TABLE IF NOT EXISTS "bulk_purchase_order" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "order_no" TEXT NOT NULL DEFAULT '',
  "shelf_code" TEXT NOT NULL DEFAULT '',
  "demand_id" INTEGER NOT NULL DEFAULT 0,
  "demand_no" TEXT NOT NULL DEFAULT '',
  "quote_id" INTEGER NOT NULL DEFAULT 0,
  "publish_supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "supplier_tag" TEXT DEFAULT NULL,
  "is_dounan" INTEGER NOT NULL DEFAULT 0,
  "round_no" TEXT NOT NULL DEFAULT '',
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "second_name" TEXT NOT NULL DEFAULT '',
  "spec_num" INTEGER NOT NULL DEFAULT 0,
  "total_supply_num" INTEGER NOT NULL DEFAULT 0,
  "confirm_num" INTEGER NOT NULL DEFAULT 0,
  "check_in_end_time" TEXT NOT NULL DEFAULT '',
  "check_in_time" TEXT DEFAULT NULL,
  "check_in_by" INTEGER DEFAULT NULL,
  "check_in_name" TEXT DEFAULT NULL,
  "plate_no" TEXT DEFAULT NULL,
  "delivery_addr" TEXT DEFAULT NULL,
  "delivery_remark" TEXT DEFAULT NULL,
  "late_flag" INTEGER NOT NULL DEFAULT 0,
  "output_end_time" TEXT NOT NULL DEFAULT '',
  "actual_num" INTEGER NOT NULL DEFAULT 0,
  "settle_num" INTEGER DEFAULT NULL,
  "settle_num_modified" INTEGER NOT NULL DEFAULT 0,
  "over_flag" INTEGER NOT NULL DEFAULT 0,
  "inventory_by" INTEGER DEFAULT NULL,
  "inventory_name" TEXT DEFAULT NULL,
  "inventory_start_time" TEXT DEFAULT NULL,
  "inventory_remark" TEXT DEFAULT NULL,
  "inventory_submit_by" INTEGER DEFAULT NULL,
  "inventory_submit_name" TEXT DEFAULT NULL,
  "inventory_submit_time" TEXT DEFAULT NULL,
  "over_exception_type" INTEGER DEFAULT NULL,
  "over_handle_remark" TEXT DEFAULT NULL,
  "over_handle_by" INTEGER DEFAULT NULL,
  "over_handle_name" TEXT DEFAULT NULL,
  "over_handle_time" TEXT DEFAULT NULL,
  "total_amount" REAL DEFAULT NULL,
  "plan_settle_time" TEXT DEFAULT NULL,
  "settle_time" TEXT DEFAULT NULL,
  "settle_flag" INTEGER NOT NULL DEFAULT 0,
  "settle_type" INTEGER DEFAULT NULL,
  "settle_remark" TEXT DEFAULT NULL,
  "settle_by" INTEGER DEFAULT NULL,
  "settle_name" TEXT DEFAULT NULL,
  "status" INTEGER NOT NULL DEFAULT 0,
  "cancel_type" INTEGER DEFAULT NULL,
  "cancel_reason" TEXT DEFAULT NULL,
  "cancel_by" INTEGER DEFAULT NULL,
  "cancel_name" TEXT DEFAULT NULL,
  "cancel_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  UNIQUE ("order_no"),
  UNIQUE ("demand_id", "supplier_id"),
  UNIQUE ("round_no", "shelf_code")
);
CREATE TABLE IF NOT EXISTS "bulk_purchase_order_rank" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "order_id" INTEGER NOT NULL DEFAULT 0,
  "order_no" TEXT NOT NULL DEFAULT '',
  "rank_code" INTEGER NOT NULL DEFAULT 0,
  "price" REAL NOT NULL DEFAULT 0,
  "plan_label_num" INTEGER NOT NULL DEFAULT 0,
  "printed_label_num" INTEGER NOT NULL DEFAULT 0,
  "scanned_label_num" INTEGER NOT NULL DEFAULT 0,
  "scanned_stem_num" INTEGER NOT NULL DEFAULT 0,
  "settle_label_num" INTEGER DEFAULT NULL,
  "settle_stem_num" INTEGER DEFAULT NULL,
  "amount" REAL DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  UNIQUE ("order_id", "rank_code")
);
CREATE TABLE IF NOT EXISTS "bulk_purchase_over_compensate" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "order_id" INTEGER NOT NULL DEFAULT 0,
  "order_no" TEXT NOT NULL DEFAULT '',
  "demand_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "occupied_supplier_id" INTEGER NOT NULL DEFAULT 0,
  "occupied_supplier_name" TEXT NOT NULL DEFAULT '',
  "occupied_order_id" INTEGER NOT NULL DEFAULT 0,
  "occupied_order_no" TEXT NOT NULL DEFAULT '',
  "rank_code" INTEGER NOT NULL DEFAULT 0,
  "occupied_num" INTEGER NOT NULL DEFAULT 0,
  "price" REAL NOT NULL DEFAULT 0,
  "compensate_type" INTEGER NOT NULL DEFAULT 0,
  "compensate_amount" REAL NOT NULL DEFAULT 0.00,
  "remark" TEXT DEFAULT NULL,
  "handler_id" INTEGER DEFAULT NULL,
  "handler_name" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT ''
);
CREATE TABLE IF NOT EXISTS "bulk_purchase_product_mapping" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "publish_supplier_id" INTEGER NOT NULL DEFAULT 0,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "rank_code" INTEGER NOT NULL DEFAULT 0,
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "source" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  UNIQUE ("publish_supplier_id", "second_id", "rank_code")
);
CREATE TABLE IF NOT EXISTS "bulk_purchase_quote" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "quote_no" TEXT NOT NULL DEFAULT '',
  "demand_id" INTEGER NOT NULL DEFAULT 0,
  "demand_no" TEXT NOT NULL DEFAULT '',
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "version" INTEGER NOT NULL DEFAULT 0,
  "total_supply_num" INTEGER NOT NULL DEFAULT 0,
  "is_current" INTEGER NOT NULL DEFAULT 1,
  "select_status" INTEGER NOT NULL DEFAULT 0,
  "submit_time" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT '',
  UNIQUE ("quote_no"),
  UNIQUE ("demand_id", "supplier_id", "version")
);
CREATE TABLE IF NOT EXISTS "bulk_purchase_quote_rank" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "quote_id" INTEGER NOT NULL DEFAULT 0,
  "demand_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "rank_code" INTEGER NOT NULL DEFAULT 0,
  "price" REAL NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  UNIQUE ("quote_id", "rank_code")
);
CREATE TABLE IF NOT EXISTS "bulk_purchase_scan_reject_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "label_code" TEXT NOT NULL DEFAULT '',
  "label_id" INTEGER DEFAULT NULL,
  "order_id" INTEGER DEFAULT NULL,
  "rank_code" INTEGER DEFAULT NULL,
  "reject_reason" INTEGER NOT NULL DEFAULT 0,
  "fail_msg" TEXT DEFAULT NULL,
  "first_scan_time" TEXT DEFAULT NULL,
  "first_scan_name" TEXT DEFAULT NULL,
  "operator_id" INTEGER DEFAULT NULL,
  "operator_name" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT ''
);
CREATE TABLE IF NOT EXISTS "bulk_purchase_white_list" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "supplier_tag" TEXT DEFAULT NULL,
  "status" INTEGER NOT NULL DEFAULT 1,
  "remark" TEXT DEFAULT NULL,
  "operator_id" INTEGER DEFAULT NULL,
  "operator_name" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  UNIQUE ("supplier_id")
);
CREATE TABLE IF NOT EXISTS "bulky_open_app" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "partner_name" TEXT NOT NULL DEFAULT '',
  "app_key" TEXT NOT NULL DEFAULT '',
  "app_secret" TEXT NOT NULL DEFAULT '',
  "enable" INTEGER NOT NULL DEFAULT 1,
  "access_token" TEXT NOT NULL DEFAULT '',
  "expire_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "callback_url" TEXT NOT NULL DEFAULT '',
  "order_callback" TEXT NOT NULL DEFAULT '',
  "try_enable" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("app_key")
);
CREATE TABLE IF NOT EXISTS "bulky_open_app_api_config" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "app_id" INTEGER NOT NULL DEFAULT 0,
  "method" TEXT NOT NULL DEFAULT '',
  "method_name" TEXT NOT NULL DEFAULT '',
  "enable" INTEGER NOT NULL DEFAULT 1,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "bulky_order_extra" (
  "id" INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY ("id")
);
CREATE TABLE IF NOT EXISTS "bulky_pay_app" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "app_id" TEXT NOT NULL DEFAULT '',
  "app_name" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 1,
  "remark" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("app_id")
);
CREATE TABLE IF NOT EXISTS "bulky_pay_app_mch_bind" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "app_id" TEXT NOT NULL DEFAULT '',
  "channel_code" TEXT NOT NULL DEFAULT '',
  "scene" TEXT NOT NULL DEFAULT '',
  "mch_no" TEXT NOT NULL DEFAULT '',
  "priority" INTEGER NOT NULL DEFAULT 0,
  "status" INTEGER NOT NULL DEFAULT 1,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("app_id", "channel_code", "scene", "mch_no")
);
CREATE TABLE IF NOT EXISTS "bulky_pay_biz_notify_config" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "app_id" TEXT NOT NULL DEFAULT '',
  "biz_type" TEXT NOT NULL DEFAULT '',
  "ingress_mode" TEXT NOT NULL DEFAULT 'DIRECT',
  "notify_url" TEXT NOT NULL DEFAULT '',
  "notify_secret" TEXT NOT NULL DEFAULT '',
  "max_retries" INTEGER NOT NULL DEFAULT 8,
  "backoff_base_ms" INTEGER NOT NULL DEFAULT 5000,
  "backoff_max_ms" INTEGER NOT NULL DEFAULT 1800000,
  "alert_enabled" INTEGER NOT NULL DEFAULT 1,
  "status" INTEGER NOT NULL DEFAULT 1,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("app_id", "biz_type")
);
CREATE TABLE IF NOT EXISTS "bulky_pay_biz_notify_task" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "out_trade_no" TEXT NOT NULL DEFAULT '',
  "event_type" TEXT NOT NULL DEFAULT '',
  "ref_no" TEXT NOT NULL DEFAULT '',
  "notify_url" TEXT NOT NULL DEFAULT '',
  "payload" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "retry_count" INTEGER NOT NULL DEFAULT 0,
  "max_retries" INTEGER NOT NULL DEFAULT 8,
  "next_retry_at" TEXT NOT NULL DEFAULT '',
  "last_error" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("out_trade_no", "event_type", "ref_no")
);
CREATE TABLE IF NOT EXISTS "bulky_pay_mch" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "mch_no" TEXT NOT NULL DEFAULT '',
  "mch_name" TEXT NOT NULL DEFAULT '',
  "channel_code" TEXT NOT NULL DEFAULT '',
  "channel_mch_id" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 1,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("mch_no")
);
CREATE TABLE IF NOT EXISTS "bulky_pay_mch_config" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "mch_no" TEXT NOT NULL DEFAULT '',
  "config_json" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("mch_no")
);
CREATE TABLE IF NOT EXISTS "bulky_pay_order" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "out_trade_no" TEXT NOT NULL DEFAULT '',
  "biz_type" TEXT NOT NULL DEFAULT '',
  "biz_order_sn" TEXT NOT NULL DEFAULT '',
  "app_id" TEXT NOT NULL DEFAULT '',
  "channel_code" TEXT NOT NULL DEFAULT '',
  "mch_no" TEXT NOT NULL DEFAULT '',
  "pay_type" INTEGER NOT NULL DEFAULT -1,
  "channel_pay_id" TEXT DEFAULT NULL,
  "amount" REAL NOT NULL DEFAULT 0,
  "refunded_amount" REAL NOT NULL DEFAULT 0.00,
  "status" INTEGER NOT NULL DEFAULT 0,
  "subject" TEXT NOT NULL DEFAULT '',
  "open_id" TEXT DEFAULT NULL,
  "client_ip" TEXT DEFAULT NULL,
  "notify_url" TEXT NOT NULL DEFAULT '',
  "expire_time" TEXT DEFAULT NULL,
  "pay_time" TEXT DEFAULT NULL,
  "channel_payload" TEXT,
  "fail_reason" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("out_trade_no")
);
CREATE TABLE IF NOT EXISTS "bulky_pay_refund" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "out_refund_no" TEXT NOT NULL DEFAULT '',
  "out_trade_no" TEXT NOT NULL DEFAULT '',
  "channel_code" TEXT NOT NULL DEFAULT '',
  "mch_no" TEXT NOT NULL DEFAULT '',
  "channel_refund_id" TEXT DEFAULT NULL,
  "refund_amount" REAL NOT NULL DEFAULT 0,
  "status" INTEGER NOT NULL DEFAULT 0,
  "reason" TEXT NOT NULL DEFAULT '',
  "refund_time" TEXT DEFAULT NULL,
  "fail_reason" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("out_refund_no")
);
CREATE TABLE IF NOT EXISTS "bulky_pay_route_rule" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "app_id" TEXT NOT NULL DEFAULT '',
  "biz_type" TEXT NOT NULL DEFAULT '',
  "channel_code" TEXT NOT NULL DEFAULT '',
  "priority" INTEGER NOT NULL DEFAULT 0,
  "status" INTEGER NOT NULL DEFAULT 1,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("app_id", "biz_type", "channel_code")
);
CREATE TABLE IF NOT EXISTS "city_order" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "app_id" TEXT NOT NULL DEFAULT '',
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "coupon_user_id" INTEGER DEFAULT 0,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "open_id" TEXT NOT NULL DEFAULT '',
  "date" TEXT NOT NULL DEFAULT '2024-01-01',
  "order_num" INTEGER NOT NULL DEFAULT 0,
  "order_status" INTEGER NOT NULL DEFAULT 0,
  "after_sale_status" INTEGER NOT NULL DEFAULT 0,
  "send_status" INTEGER NOT NULL DEFAULT 0,
  "product_price" REAL NOT NULL DEFAULT 0.00,
  "delivery_fee" REAL NOT NULL DEFAULT 0.00,
  "total_price" REAL NOT NULL DEFAULT 0.00,
  "total_weight" INTEGER NOT NULL DEFAULT 0,
  "origin_actual_price" REAL NOT NULL DEFAULT 0.00,
  "actual_price" REAL NOT NULL DEFAULT 0.00,
  "supplier_due_price" REAL NOT NULL DEFAULT 0.00,
  "supplier_settle_price" REAL NOT NULL DEFAULT 0.00,
  "pick_type" INTEGER NOT NULL DEFAULT 0,
  "buyer_memo" TEXT NOT NULL DEFAULT '',
  "receive_name" TEXT NOT NULL DEFAULT '',
  "receive_tel" TEXT NOT NULL DEFAULT '',
  "province" TEXT NOT NULL DEFAULT '',
  "city" TEXT NOT NULL DEFAULT '',
  "district" TEXT NOT NULL DEFAULT '',
  "adcode" TEXT NOT NULL DEFAULT '',
  "detail" TEXT NOT NULL DEFAULT '',
  "longitude" TEXT NOT NULL DEFAULT '',
  "latitude" TEXT NOT NULL DEFAULT '',
  "pay_id" TEXT NOT NULL DEFAULT '',
  "pay_type" INTEGER NOT NULL DEFAULT 0,
  "merchant_id" TEXT NOT NULL DEFAULT '',
  "pay_time" TEXT DEFAULT NULL,
  "send_time" TEXT DEFAULT NULL,
  "confirm_time" TEXT DEFAULT NULL,
  "cancel_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("order_sn")
);
CREATE TABLE IF NOT EXISTS "city_order_item" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "product_name" TEXT NOT NULL DEFAULT '',
  "rank_num" INTEGER NOT NULL DEFAULT 0,
  "pic_url" TEXT NOT NULL DEFAULT '',
  "spec_and_num" TEXT NOT NULL DEFAULT '',
  "pay_price" REAL DEFAULT 0.00,
  "product_price" REAL NOT NULL DEFAULT 0.00,
  "weight" INTEGER NOT NULL DEFAULT 0,
  "item_num" INTEGER NOT NULL DEFAULT 0,
  "origin_item_num" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "city_order_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "type" INTEGER NOT NULL DEFAULT 0,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "refund_id" INTEGER NOT NULL DEFAULT 0,
  "content" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "city_order_refund" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "apply_money" REAL NOT NULL DEFAULT 0.00,
  "refund_money" REAL NOT NULL DEFAULT 0.00,
  "refund_item" TEXT NOT NULL DEFAULT '',
  "after_sale_status" INTEGER NOT NULL DEFAULT 0,
  "refund_status" INTEGER NOT NULL DEFAULT 0,
  "apply_reason" TEXT NOT NULL DEFAULT '',
  "reject_reason" TEXT NOT NULL DEFAULT '',
  "wx_refund_id" TEXT NOT NULL DEFAULT '',
  "wx_refund_success_time" TEXT DEFAULT NULL,
  "pictures" TEXT,
  "videos" TEXT,
  "remark" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "agree_time" TEXT DEFAULT NULL,
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "city_order_trade_record" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "city_print_set" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "auto_print" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "city_receipt_print" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "machine_code" TEXT NOT NULL DEFAULT '',
  "msign" TEXT NOT NULL DEFAULT '',
  "access_token" TEXT DEFAULT NULL,
  "refresh_token" TEXT DEFAULT NULL,
  "expires_in" INTEGER DEFAULT NULL,
  "apply_time" INTEGER DEFAULT NULL,
  "status" INTEGER DEFAULT 1,
  "create_time" TEXT DEFAULT NULL,
  "update_time" TEXT DEFAULT NULL,
  "over_time" INTEGER DEFAULT NULL,
  "is_used" INTEGER DEFAULT NULL,
  "name" TEXT DEFAULT NULL,
  "type" INTEGER DEFAULT 1
);
CREATE TABLE IF NOT EXISTS "city_warehouse" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL DEFAULT '',
  "app_id" TEXT NOT NULL DEFAULT '',
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "express_id" INTEGER NOT NULL DEFAULT 0,
  "region_id" INTEGER NOT NULL DEFAULT 0,
  "store_id" INTEGER NOT NULL DEFAULT 0,
  "city_store_open" INTEGER NOT NULL DEFAULT 1,
  "add_price" REAL NOT NULL DEFAULT 1.00,
  "add_price_flag" INTEGER NOT NULL DEFAULT 0,
  "distance" REAL NOT NULL DEFAULT 5.00,
  "distance_price" REAL NOT NULL DEFAULT 0.00,
  "weight_price" REAL NOT NULL DEFAULT 0.00,
  "express_add_price" REAL NOT NULL DEFAULT 0.00,
  "start_sell_weight" REAL NOT NULL DEFAULT 0.00,
  "distribution_type" INTEGER NOT NULL DEFAULT 0,
  "longitude" TEXT NOT NULL DEFAULT '',
  "latitude" TEXT NOT NULL DEFAULT '',
  "province" TEXT NOT NULL DEFAULT '',
  "city" TEXT NOT NULL DEFAULT '',
  "district" TEXT NOT NULL DEFAULT '',
  "detail" TEXT NOT NULL DEFAULT '',
  "business_address" TEXT NOT NULL DEFAULT '',
  "city_code" TEXT NOT NULL DEFAULT '',
  "adcode" TEXT NOT NULL DEFAULT '',
  "contact_name" TEXT NOT NULL DEFAULT '',
  "contact_tel" TEXT NOT NULL DEFAULT '',
  "logistics_phone" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "operate_status" INTEGER NOT NULL DEFAULT 1,
  "phone_switch" INTEGER NOT NULL DEFAULT 1,
  "flash_sale_switch" INTEGER NOT NULL DEFAULT 1,
  "cotton_switch" INTEGER NOT NULL DEFAULT 0,
  "cotton_num" INTEGER NOT NULL DEFAULT 0,
  "board_switch" INTEGER NOT NULL DEFAULT 0,
  "board_num" INTEGER NOT NULL DEFAULT 0,
  "hour_delivery_switch" INTEGER NOT NULL DEFAULT 1,
  "xmmaterials_open" INTEGER NOT NULL DEFAULT 1,
  "change_add_price_switch" INTEGER NOT NULL DEFAULT 1,
  "single_delivery_flag" INTEGER NOT NULL DEFAULT 0,
  "coupon_flag" INTEGER NOT NULL DEFAULT 1,
  "promote_flag" INTEGER NOT NULL DEFAULT 0,
  "service_fee_flag" INTEGER NOT NULL DEFAULT 0,
  "remark" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "delivery_type" INTEGER NOT NULL DEFAULT 0,
  "share_ratio" REAL NOT NULL DEFAULT 0.00,
  "promote_merchant_flag" INTEGER NOT NULL DEFAULT 0,
  "large_customer_pack_flag" INTEGER NOT NULL DEFAULT 0,
  "large_customer_pack_weight" REAL NOT NULL DEFAULT 6.00,
  "logistics_unit_price" REAL DEFAULT NULL
);
CREATE TABLE IF NOT EXISTS "city_warehouse_class_banner" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "first_id" INTEGER NOT NULL DEFAULT 0,
  "content" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("ware_id", "first_id")
);
CREATE TABLE IF NOT EXISTS "city_warehouse_class_first_add_price" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "first_id" INTEGER NOT NULL DEFAULT 0,
  "rank_num" INTEGER NOT NULL DEFAULT 0,
  "add_price" REAL NOT NULL DEFAULT 0.00,
  "enable" INTEGER NOT NULL DEFAULT 1,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("first_id", "rank_num", "ware_id")
);
CREATE TABLE IF NOT EXISTS "city_warehouse_class_second_add_price" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "rank_num" INTEGER NOT NULL DEFAULT 0,
  "add_price" REAL NOT NULL DEFAULT 0.00,
  "enable" INTEGER NOT NULL DEFAULT 1,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("second_id", "rank_num", "ware_id")
);
CREATE TABLE IF NOT EXISTS "city_warehouse_copy1" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL DEFAULT '',
  "app_id" TEXT NOT NULL DEFAULT '',
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "express_id" INTEGER NOT NULL DEFAULT 0,
  "store_id" INTEGER NOT NULL DEFAULT 0,
  "city_store_open" INTEGER NOT NULL DEFAULT 1,
  "distribution_type" INTEGER NOT NULL DEFAULT 0,
  "add_price" REAL NOT NULL DEFAULT 1.00,
  "add_price_flag" INTEGER NOT NULL DEFAULT 0,
  "distance" REAL NOT NULL DEFAULT 5.00,
  "distance_price" REAL NOT NULL DEFAULT 0.00,
  "weight_price" REAL NOT NULL DEFAULT 0.00,
  "express_add_price" REAL NOT NULL DEFAULT 0.00,
  "start_sell_weight" REAL NOT NULL DEFAULT 0.00,
  "share_ratio" REAL NOT NULL DEFAULT 0,
  "longitude" TEXT NOT NULL DEFAULT '',
  "latitude" TEXT NOT NULL DEFAULT '',
  "province" TEXT NOT NULL DEFAULT '',
  "city" TEXT NOT NULL DEFAULT '',
  "district" TEXT NOT NULL DEFAULT '',
  "detail" TEXT NOT NULL DEFAULT '',
  "business_address" TEXT NOT NULL DEFAULT '',
  "city_code" TEXT NOT NULL DEFAULT '',
  "adcode" TEXT NOT NULL DEFAULT '',
  "contact_name" TEXT NOT NULL DEFAULT '',
  "contact_tel" TEXT NOT NULL DEFAULT '',
  "logistics_phone" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "operate_status" INTEGER NOT NULL DEFAULT 1,
  "phone_switch" INTEGER NOT NULL DEFAULT 1,
  "flash_sale_switch" INTEGER NOT NULL DEFAULT 1,
  "cotton_switch" INTEGER NOT NULL DEFAULT 0,
  "cotton_num" INTEGER NOT NULL DEFAULT 0,
  "board_switch" INTEGER NOT NULL DEFAULT 0,
  "board_num" INTEGER NOT NULL DEFAULT 0,
  "hour_delivery_switch" INTEGER NOT NULL DEFAULT 1,
  "xmmaterials_open" INTEGER NOT NULL DEFAULT 1,
  "change_add_price_switch" INTEGER NOT NULL DEFAULT 1,
  "single_delivery_flag" INTEGER NOT NULL DEFAULT 0,
  "coupon_flag" INTEGER NOT NULL DEFAULT 1,
  "promote_flag" INTEGER NOT NULL DEFAULT 0,
  "service_fee_flag" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "city_warehouse_data_statistics" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "yyyy_mm_dd" TEXT NOT NULL DEFAULT '',
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "all_total_price" REAL NOT NULL DEFAULT 0.00,
  "turnover" REAL NOT NULL DEFAULT 0.00,
  "supplier_due" REAL NOT NULL DEFAULT 0.00,
  "send_num" INTEGER NOT NULL DEFAULT 0,
  "order_num" INTEGER NOT NULL DEFAULT 0,
  "item_count" INTEGER NOT NULL DEFAULT 0,
  "base_item_count" INTEGER NOT NULL DEFAULT 0,
  "total_weight" REAL NOT NULL DEFAULT 0.00,
  "new_purchaser_num" INTEGER NOT NULL DEFAULT 0,
  "old_purchaser_num" INTEGER NOT NULL DEFAULT 0,
  "ware_product_add_price" REAL NOT NULL DEFAULT 0.00,
  "ware_express_add_price" REAL NOT NULL DEFAULT 0.00,
  "ware_material_add_price" REAL NOT NULL DEFAULT 0.00,
  "express_price" REAL NOT NULL DEFAULT 0.00,
  "delivery_fee" REAL NOT NULL DEFAULT 0.00,
  "service_fee" REAL NOT NULL DEFAULT 0.00,
  "refer_service_fee" REAL NOT NULL DEFAULT 0.00,
  "delta_service_fee" REAL NOT NULL DEFAULT 0.00,
  "add_price" REAL NOT NULL DEFAULT 0.00,
  "rebate_xm_coin" REAL NOT NULL DEFAULT 0.00,
  "subsidy_price" REAL NOT NULL DEFAULT 0.00,
  "cotton_money" REAL NOT NULL DEFAULT 0.00,
  "after_sale_price" REAL NOT NULL DEFAULT 0.00,
  "all_refund_express_price" REAL NOT NULL DEFAULT 0.00,
  "all_express_fill" REAL NOT NULL DEFAULT 0.00,
  "total_station_fee" REAL NOT NULL DEFAULT 0.00,
  "supplier_after_sale_price" REAL NOT NULL DEFAULT 0.00,
  "ware_after_sale_price" REAL NOT NULL DEFAULT 0.00,
  "pack_bear_price" REAL NOT NULL DEFAULT 0.00,
  "express_bear_price" REAL NOT NULL DEFAULT 0.00,
  "supplier_punish" REAL NOT NULL DEFAULT 0.00,
  "take_xm_coin" REAL NOT NULL DEFAULT 0.00,
  "take_xm_coin_return" REAL NOT NULL DEFAULT 0.00,
  "total_income" REAL NOT NULL DEFAULT 0.00,
  "vip_money" REAL NOT NULL DEFAULT 0.00,
  "vip_discount_service_fee" REAL NOT NULL DEFAULT 0.00,
  "flash_sale_discount_in" REAL NOT NULL DEFAULT 0.00,
  "flash_sale_discount_out" REAL NOT NULL DEFAULT 0.00,
  "platform_coupon_price" REAL NOT NULL DEFAULT 0.00,
  "coupon_price" REAL NOT NULL DEFAULT 0.00,
  "platform_reduce_price" REAL NOT NULL DEFAULT 0.00,
  "complain_return_money" REAL NOT NULL DEFAULT 0.00,
  "quality_price" REAL NOT NULL DEFAULT 0.00,
  "discount_express_price" REAL NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("yyyy_mm_dd", "ware_id")
);
CREATE TABLE IF NOT EXISTS "city_warehouse_express_record" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "type" INTEGER NOT NULL DEFAULT 1,
  "round_no" TEXT NOT NULL DEFAULT '',
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "send_num" INTEGER NOT NULL DEFAULT 0,
  "warehouse_add_price" REAL NOT NULL DEFAULT 0.00,
  "express_add_price" REAL NOT NULL DEFAULT 0.00,
  "service_fee" REAL NOT NULL DEFAULT 0.00,
  "platform_coupon_price" REAL NOT NULL DEFAULT 0.00,
  "coupon_price" REAL NOT NULL DEFAULT 0.00,
  "express_price" REAL NOT NULL DEFAULT 0.00,
  "status" INTEGER NOT NULL DEFAULT 0,
  "remark" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "settle_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("round_no", "ware_id", "partner_id", "type")
);
CREATE TABLE IF NOT EXISTS "city_warehouse_fhh_logistics_fee" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "receiver_supplier_id" INTEGER NOT NULL DEFAULT 0,
  "round_no" TEXT NOT NULL DEFAULT '',
  "cutoff_stage" INTEGER NOT NULL DEFAULT 0,
  "unit_price" REAL NOT NULL DEFAULT 0,
  "valid_weight_g" INTEGER NOT NULL DEFAULT 0,
  "amount" REAL NOT NULL DEFAULT 0.00,
  "settle_status" INTEGER NOT NULL DEFAULT 0,
  "settle_biz_no" TEXT NOT NULL DEFAULT '',
  "settle_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("partner_id", "ware_id", "round_no", "cutoff_stage")
);
CREATE TABLE IF NOT EXISTS "city_warehouse_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "user_type" INTEGER NOT NULL DEFAULT 0,
  "content" TEXT,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "city_warehouse_promote_fee_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "type" INTEGER NOT NULL DEFAULT 0,
  "remark" TEXT NOT NULL DEFAULT '',
  "item_num" INTEGER DEFAULT 0,
  "amount" REAL NOT NULL DEFAULT 0.00,
  "old_money" REAL NOT NULL DEFAULT 0,
  "new_money" REAL NOT NULL DEFAULT 0,
  "biz_no" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "city_warehouse_promote_income_statistics" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "statistics_start_date" TEXT NOT NULL DEFAULT '',
  "statistics_end_date" TEXT NOT NULL DEFAULT '',
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "order_item_num" INTEGER NOT NULL DEFAULT 0,
  "punish_item_num" INTEGER NOT NULL DEFAULT 0,
  "statistics_time" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("statistics_start_date", "ware_id", "partner_id")
);
CREATE TABLE IF NOT EXISTS "city_warehouse_promote_settle" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "month" TEXT NOT NULL DEFAULT '',
  "item_num" INTEGER NOT NULL DEFAULT 0,
  "unit_price" REAL NOT NULL DEFAULT 0,
  "money" REAL NOT NULL DEFAULT 0.00,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("ware_id", "month", "partner_id")
);
CREATE TABLE IF NOT EXISTS "city_warehouse_remark" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "valid_type" INTEGER NOT NULL DEFAULT 1,
  "valid_start" TEXT NOT NULL DEFAULT '',
  "valid_end" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "city_warehouse_shipping_area" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "area" TEXT,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "city_warehouse_user" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "nickname" TEXT NOT NULL DEFAULT '',
  "is_sub" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("user_id", "ware_id")
);
CREATE TABLE IF NOT EXISTS "class_second_avg_price" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "round_no" TEXT NOT NULL DEFAULT '',
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "rank_num" INTEGER NOT NULL DEFAULT 0,
  "platform" INTEGER NOT NULL DEFAULT 0,
  "item_num" INTEGER NOT NULL DEFAULT 0,
  "total_price" REAL NOT NULL DEFAULT 0.00,
  "avg_price" REAL NOT NULL DEFAULT 0.00,
  "coupon_price" REAL NOT NULL DEFAULT 0.00,
  "subsidy_price" REAL NOT NULL DEFAULT 0.00,
  "supply_price" REAL NOT NULL DEFAULT 0.00,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("round_no", "second_id", "rank_num", "platform")
);
CREATE TABLE IF NOT EXISTS "common_coupon_mail" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "coupon_no" TEXT NOT NULL DEFAULT '',
  "coupon_name" TEXT NOT NULL DEFAULT '',
  "user_type" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "community_activity" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "activity_name" TEXT NOT NULL DEFAULT '',
  "community_name" TEXT NOT NULL DEFAULT '',
  "activity_code" TEXT NOT NULL DEFAULT '',
  "link_token" TEXT NOT NULL DEFAULT '',
  "start_time" TEXT NOT NULL DEFAULT '',
  "end_time" TEXT NOT NULL DEFAULT '',
  "win_rate" INTEGER NOT NULL DEFAULT 100,
  "participant_count" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("activity_code"),
  UNIQUE ("link_token")
);
CREATE TABLE IF NOT EXISTS "community_activity_coupon_pool" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "activity_id" INTEGER NOT NULL DEFAULT 0,
  "coupon_no" TEXT NOT NULL DEFAULT '',
  "total_stock" INTEGER NOT NULL DEFAULT 0,
  "remain_stock" INTEGER NOT NULL DEFAULT 0,
  "send_count" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("activity_id", "coupon_no")
);
CREATE TABLE IF NOT EXISTS "community_activity_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "activity_id" INTEGER NOT NULL DEFAULT 0,
  "action_content" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "community_activity_record" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "activity_id" INTEGER NOT NULL DEFAULT 0,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "biz_no" TEXT NOT NULL DEFAULT '',
  "draw_status" INTEGER NOT NULL DEFAULT 0,
  "coupon_no" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("activity_id", "purchaser_id")
);
CREATE TABLE IF NOT EXISTS "customer_area_type" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "daily_shelf" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "round_no" TEXT NOT NULL DEFAULT '',
  "order_sn" TEXT NOT NULL DEFAULT '',
  "send_no" TEXT NOT NULL DEFAULT '',
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "zone" TEXT NOT NULL DEFAULT '',
  "shelf" TEXT NOT NULL DEFAULT '',
  "zone_shelf" TEXT NOT NULL DEFAULT '',
  "sub_shelf_sn" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "warehouse_config_snapshot" TEXT
);
CREATE TABLE IF NOT EXISTS "daily_shelf_test" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "round_no" TEXT NOT NULL DEFAULT '',
  "order_sn" TEXT NOT NULL DEFAULT '',
  "send_no" TEXT NOT NULL DEFAULT '',
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "zone" TEXT NOT NULL DEFAULT '',
  "shelf" TEXT NOT NULL DEFAULT '',
  "zone_shelf" TEXT NOT NULL DEFAULT '',
  "sub_shelf_sn" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "warehouse_config_snapshot" TEXT
);
CREATE TABLE IF NOT EXISTS "distributor_pickup_inventory_scan_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "date" TEXT NOT NULL DEFAULT '',
  "code_content" TEXT NOT NULL DEFAULT '',
  "enter_item_id" INTEGER NOT NULL DEFAULT 0,
  "order_item_id" INTEGER DEFAULT NULL,
  "order_sn" TEXT DEFAULT NULL,
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "sub_shelf_sn" TEXT DEFAULT NULL,
  "zone" TEXT DEFAULT NULL,
  "shelf" TEXT DEFAULT NULL,
  "zone_shelf" TEXT DEFAULT NULL,
  "supplier_id" INTEGER DEFAULT NULL,
  "partner_id" INTEGER DEFAULT NULL,
  "product_id" INTEGER DEFAULT NULL,
  "product_name" TEXT DEFAULT NULL,
  "second_id" INTEGER DEFAULT NULL,
  "rank_num" INTEGER DEFAULT NULL,
  "maturity" TEXT DEFAULT NULL,
  "user_id" INTEGER DEFAULT NULL,
  "user_name" TEXT DEFAULT NULL,
  "phone" TEXT DEFAULT NULL,
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("date", "code_content", "data_status")
);
CREATE TABLE IF NOT EXISTS "enter_item_record_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "code_content" TEXT NOT NULL DEFAULT '',
  "date" TEXT NOT NULL DEFAULT '',
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "sub_shelf_sn" TEXT NOT NULL DEFAULT '',
  "zone" TEXT NOT NULL DEFAULT '',
  "shelf" TEXT NOT NULL DEFAULT '',
  "zone_shelf" TEXT NOT NULL DEFAULT '',
  "enter_item_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "user_name" TEXT NOT NULL DEFAULT '',
  "op" INTEGER NOT NULL DEFAULT 0,
  "is_man" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "express_concat" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "express_name" TEXT NOT NULL DEFAULT '',
  "phone" TEXT NOT NULL DEFAULT '',
  "config_id_str" TEXT
);
CREATE TABLE IF NOT EXISTS "fee_config" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "platform" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "base_add_price" INTEGER NOT NULL DEFAULT 0,
  "express_price" INTEGER NOT NULL DEFAULT 0,
  "subsidy_price" INTEGER NOT NULL DEFAULT 0,
  "service_fee" INTEGER NOT NULL DEFAULT 0,
  "service_fee_mch" INTEGER NOT NULL DEFAULT 0,
  "category_add_price" INTEGER NOT NULL DEFAULT 0,
  "express_add_price" INTEGER NOT NULL DEFAULT 0,
  "delivery_fee" INTEGER NOT NULL DEFAULT 0,
  "self_take" INTEGER NOT NULL DEFAULT 0,
  "sale_agency" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("platform")
);
CREATE TABLE IF NOT EXISTS "fhh_member_level_config" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "app_id" TEXT NOT NULL DEFAULT '',
  "level" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "rate" REAL NOT NULL DEFAULT 1.00,
  "max_item_num" INTEGER NOT NULL DEFAULT 0,
  "coupon_config" TEXT,
  "extra_info" TEXT,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "fhh_member_level_history" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "item_num" INTEGER NOT NULL DEFAULT 0,
  "old_level_id" INTEGER NOT NULL DEFAULT 0,
  "old_level_name" TEXT NOT NULL DEFAULT '',
  "level_id" INTEGER NOT NULL DEFAULT 0,
  "level_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "fhh_region_order_statistics" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "round_no" TEXT NOT NULL DEFAULT '',
  "province" TEXT NOT NULL DEFAULT '',
  "city" TEXT NOT NULL DEFAULT '',
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "total_price" REAL NOT NULL DEFAULT 0.00,
  "warehouse_add_price" REAL NOT NULL DEFAULT 0.00,
  "express_add_price" REAL NOT NULL DEFAULT 0.00,
  "service_fee" REAL NOT NULL DEFAULT 0.00,
  "total_weight" INTEGER NOT NULL DEFAULT 0,
  "coupon_price" REAL NOT NULL DEFAULT 0.00,
  "ot_exp_add_price" REAL NOT NULL DEFAULT 0.00,
  "platform_reduce_price" REAL NOT NULL DEFAULT 0.00,
  "extra_service_fee" REAL NOT NULL DEFAULT 0.00,
  "send_num" INTEGER NOT NULL DEFAULT 0,
  "order_num" INTEGER NOT NULL DEFAULT 0,
  "item_num" INTEGER NOT NULL DEFAULT 0,
  "supply_price" REAL NOT NULL DEFAULT 0.00,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  UNIQUE ("round_no", "province", "city", "purchaser_id")
);
CREATE TABLE IF NOT EXISTS "flash_sale_apply" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "plan_id" INTEGER NOT NULL DEFAULT 0,
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "flash_product_id" INTEGER NOT NULL DEFAULT 0,
  "reduce_type" INTEGER NOT NULL DEFAULT 1,
  "price" REAL NOT NULL DEFAULT 0.00,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "second_name" TEXT NOT NULL DEFAULT '',
  "sku_config" TEXT NOT NULL DEFAULT '',
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "rank_num" INTEGER NOT NULL DEFAULT 0,
  "num" INTEGER NOT NULL DEFAULT 0,
  "sold_num" INTEGER NOT NULL DEFAULT 0,
  "status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "flash_sale_permission" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "reason" TEXT NOT NULL DEFAULT '',
  "review_id" INTEGER NOT NULL DEFAULT 0,
  "review_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "apply_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "review_time" TEXT DEFAULT NULL,
  UNIQUE ("supplier_id")
);
CREATE TABLE IF NOT EXISTS "flash_sale_plan" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "session_id" INTEGER NOT NULL DEFAULT 0,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "second_name" TEXT NOT NULL DEFAULT '',
  "sku_config" TEXT NOT NULL DEFAULT '',
  "rank_num" INTEGER NOT NULL DEFAULT 0,
  "plan_num" INTEGER NOT NULL DEFAULT 0,
  "current_num" INTEGER NOT NULL DEFAULT 0,
  "supplier_min_num" INTEGER NOT NULL DEFAULT 0,
  "supplier_max_num" INTEGER NOT NULL DEFAULT 0,
  "start_time" TEXT NOT NULL DEFAULT '',
  "end_time" TEXT NOT NULL DEFAULT '',
  "max_supply_price" REAL NOT NULL DEFAULT 0.00,
  "subsidy_amount" REAL NOT NULL DEFAULT 0.00,
  "limit_sale" INTEGER NOT NULL DEFAULT 1,
  "status" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "flash_sale_session" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "round_no" TEXT NOT NULL DEFAULT '',
  "round_name" TEXT NOT NULL DEFAULT '',
  "session_start_time" TEXT DEFAULT NULL,
  "session_end_time" TEXT DEFAULT NULL,
  "start_time" TEXT DEFAULT NULL,
  "end_time" TEXT DEFAULT NULL,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "gallery_visit_user_daily" (
  "stat_date" TEXT NOT NULL DEFAULT '',
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "open_count" INTEGER NOT NULL DEFAULT 0,
  "page_view_count" INTEGER NOT NULL DEFAULT 0,
  "created_at" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "updated_at" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  PRIMARY KEY ("stat_date", "user_id")
);
CREATE TABLE IF NOT EXISTS "gengxin" (
  "order_sn" TEXT,
  "supplier_id" INTEGER DEFAULT NULL
);
CREATE TABLE IF NOT EXISTS "gift_user" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "type" INTEGER NOT NULL DEFAULT 0,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "user_name" TEXT NOT NULL DEFAULT '',
  "phone" TEXT NOT NULL DEFAULT '',
  "supplier_tag" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "send_status" INTEGER NOT NULL DEFAULT 0,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "take_time" TEXT DEFAULT NULL,
  "order_time" TEXT DEFAULT NULL,
  "round_no" TEXT DEFAULT NULL,
  "send_time" TEXT DEFAULT NULL,
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("type", "user_id")
);
CREATE TABLE IF NOT EXISTS "group_tag_relation" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "group_id" INTEGER NOT NULL DEFAULT 0,
  "tag_id" INTEGER NOT NULL DEFAULT 0,
  "rank_A" INTEGER NOT NULL DEFAULT 0,
  "rank_B" INTEGER NOT NULL DEFAULT 0,
  "rank_C" INTEGER NOT NULL DEFAULT 0,
  "rank_D" INTEGER NOT NULL DEFAULT 0,
  "rank_E" INTEGER NOT NULL DEFAULT 0,
  "rank_O" INTEGER NOT NULL DEFAULT 0,
  "rank_free" INTEGER NOT NULL DEFAULT 1,
  "need_flag" INTEGER NOT NULL DEFAULT 0,
  "sort_num" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "help_change_record" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "user_phone" TEXT NOT NULL DEFAULT '',
  "old_data" TEXT NOT NULL DEFAULT '',
  "new_data" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "holiday_limit" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "round_no" TEXT NOT NULL DEFAULT '',
  "limit_num" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("round_no")
);
CREATE TABLE IF NOT EXISTS "hub_app_version" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "version_code" INTEGER NOT NULL DEFAULT 0,
  "version_name" TEXT NOT NULL DEFAULT '',
  "download_url" TEXT NOT NULL DEFAULT '',
  "force_update" INTEGER NOT NULL DEFAULT 0,
  "change_log" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 1,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("version_code")
);
CREATE TABLE IF NOT EXISTS "hub_area" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL DEFAULT '',
  "leader_id" INTEGER NOT NULL DEFAULT 0,
  "leader_name" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 1,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "hub_device" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "device_no" TEXT NOT NULL DEFAULT '',
  "imei" TEXT NOT NULL DEFAULT '',
  "sim_no" TEXT NOT NULL DEFAULT '',
  "vehicle_id" INTEGER NOT NULL DEFAULT 0,
  "auth_code" TEXT NOT NULL DEFAULT '',
  "model" TEXT NOT NULL DEFAULT '',
  "online_status" INTEGER NOT NULL DEFAULT 0,
  "acc_status" INTEGER NOT NULL DEFAULT 0,
  "acc_status_update_time" TEXT DEFAULT NULL,
  "last_acc_on_time" TEXT DEFAULT NULL,
  "last_location_time" TEXT DEFAULT NULL,
  "last_lng" REAL NOT NULL DEFAULT 0.000000,
  "last_lat" REAL NOT NULL DEFAULT 0.000000,
  "status" INTEGER NOT NULL DEFAULT 1,
  "remark" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("device_no")
);
CREATE TABLE IF NOT EXISTS "hub_device_bind_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "device_no" TEXT NOT NULL DEFAULT '',
  "from_vehicle_id" INTEGER NOT NULL DEFAULT 0,
  "to_vehicle_id" INTEGER NOT NULL DEFAULT 0,
  "op_type" INTEGER NOT NULL DEFAULT 1,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "hub_dispatch_checkin" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "dispatch_id" INTEGER NOT NULL DEFAULT 0,
  "round_no" TEXT NOT NULL DEFAULT '',
  "driver_id" INTEGER NOT NULL DEFAULT 0,
  "station_id" INTEGER NOT NULL DEFAULT 0,
  "checkin_type" INTEGER NOT NULL DEFAULT 1,
  "valid" INTEGER NOT NULL DEFAULT 1,
  "checkin_lng" REAL NOT NULL DEFAULT 0.000000,
  "checkin_lat" REAL NOT NULL DEFAULT 0.000000,
  "location_source" TEXT NOT NULL DEFAULT '',
  "accuracy" REAL NOT NULL DEFAULT 0.00,
  "signal_level" INTEGER NOT NULL DEFAULT 0,
  "offset_distance" INTEGER NOT NULL DEFAULT 0,
  "source" INTEGER NOT NULL DEFAULT 1,
  "confirm_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "offsite_depart" INTEGER NOT NULL DEFAULT 0,
  "offsite_reason" INTEGER NOT NULL DEFAULT 0,
  "offsite_reason_remark" TEXT NOT NULL DEFAULT '',
  "offsite_photos" TEXT NOT NULL DEFAULT ''
);
CREATE TABLE IF NOT EXISTS "hub_dispatch_order" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "dispatch_no" TEXT NOT NULL DEFAULT '',
  "round_no" TEXT NOT NULL DEFAULT '',
  "type" INTEGER NOT NULL DEFAULT 1,
  "vehicle_id" INTEGER NOT NULL DEFAULT 0,
  "vehicle_name" TEXT NOT NULL DEFAULT '',
  "plate_no" TEXT NOT NULL DEFAULT '',
  "driver_id" INTEGER NOT NULL DEFAULT 0,
  "driver_name" TEXT NOT NULL DEFAULT '',
  "driver_phone" TEXT NOT NULL DEFAULT '',
  "platform" TEXT NOT NULL DEFAULT '',
  "fee" REAL NOT NULL DEFAULT 0.00,
  "start_station_id" INTEGER NOT NULL DEFAULT 0,
  "start_station_name" TEXT NOT NULL DEFAULT '',
  "end_station_id" INTEGER NOT NULL DEFAULT 0,
  "end_station_name" TEXT NOT NULL DEFAULT '',
  "responsible_base_id" INTEGER NOT NULL DEFAULT 0,
  "responsible_base_name" TEXT NOT NULL DEFAULT '',
  "checkin_count" INTEGER NOT NULL DEFAULT 0,
  "status" INTEGER NOT NULL DEFAULT 1,
  "sign_status" INTEGER NOT NULL DEFAULT 0,
  "abnormal_reason" TEXT NOT NULL DEFAULT '',
  "settle_status" INTEGER NOT NULL DEFAULT 0,
  "settle_amount" REAL NOT NULL DEFAULT 0.00,
  "total_mileage" REAL NOT NULL DEFAULT 0.00,
  "total_duration" INTEGER NOT NULL DEFAULT 0,
  "dounan_depart_time" TEXT DEFAULT NULL,
  "direct_minutes" INTEGER NOT NULL DEFAULT 0,
  "support_base_flag" INTEGER NOT NULL DEFAULT 0,
  "remark" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("dispatch_no")
);
CREATE TABLE IF NOT EXISTS "hub_dispatch_template" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL DEFAULT '',
  "start_station_id" INTEGER NOT NULL DEFAULT 0,
  "start_station_name" TEXT NOT NULL DEFAULT '',
  "end_station_id" INTEGER NOT NULL DEFAULT 0,
  "end_station_name" TEXT NOT NULL DEFAULT '',
  "route_summary" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 1,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "hub_dispatch_template_assignment" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "template_id" INTEGER NOT NULL DEFAULT 0,
  "vehicle_id" INTEGER NOT NULL DEFAULT 0,
  "responsible_base_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("template_id", "vehicle_id")
);
CREATE TABLE IF NOT EXISTS "hub_driver_profile" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "driver_license_img" TEXT NOT NULL DEFAULT '',
  "id_card_front_img" TEXT NOT NULL DEFAULT '',
  "id_card_back_img" TEXT NOT NULL DEFAULT '',
  "qualification_img" TEXT NOT NULL DEFAULT '',
  "source" INTEGER NOT NULL DEFAULT 1,
  "audit_status" INTEGER NOT NULL DEFAULT 1,
  "status" INTEGER NOT NULL DEFAULT 1,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("user_id")
);
CREATE TABLE IF NOT EXISTS "hub_external_settlement" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "round_no" TEXT NOT NULL DEFAULT '',
  "car_count" INTEGER NOT NULL DEFAULT 0,
  "total_amount" REAL NOT NULL DEFAULT 0.00,
  "status" INTEGER NOT NULL DEFAULT 0,
  "audit_user_id" INTEGER NOT NULL DEFAULT 0,
  "audit_name" TEXT NOT NULL DEFAULT '',
  "audit_time" TEXT DEFAULT NULL,
  "remark" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("round_no")
);
CREATE TABLE IF NOT EXISTS "hub_permission_change_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "role_id" INTEGER NOT NULL DEFAULT 0,
  "role_name" TEXT NOT NULL DEFAULT '',
  "before_codes" TEXT NOT NULL DEFAULT '',
  "after_codes" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "hub_role_permission" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "role_id" INTEGER NOT NULL DEFAULT 0,
  "permission_code" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("role_id", "permission_code")
);
CREATE TABLE IF NOT EXISTS "hub_station" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "base_id" INTEGER NOT NULL DEFAULT 0,
  "area_id" INTEGER NOT NULL DEFAULT 0,
  "area_name" TEXT NOT NULL DEFAULT '',
  "area_leader" TEXT NOT NULL DEFAULT '',
  "contact_tel" TEXT NOT NULL DEFAULT '',
  "fence_type" INTEGER NOT NULL DEFAULT 1,
  "fence_radius" INTEGER NOT NULL DEFAULT 0,
  "fence_points" TEXT,
  "departure_time" TEXT NOT NULL DEFAULT '',
  "trip_mileage" REAL DEFAULT NULL,
  "dounan_flag" INTEGER NOT NULL DEFAULT 0,
  "avg_depart_time" TEXT NOT NULL DEFAULT '',
  "avg_depart_count" INTEGER NOT NULL DEFAULT 0,
  "direct_avg_minutes" INTEGER NOT NULL DEFAULT 0,
  "direct_count" INTEGER NOT NULL DEFAULT 0,
  "single_avg_minutes" INTEGER NOT NULL DEFAULT 0,
  "single_count" INTEGER NOT NULL DEFAULT 0,
  "multi_avg_minutes" INTEGER NOT NULL DEFAULT 0,
  "multi_count" INTEGER NOT NULL DEFAULT 0,
  "stat_calc_time" TEXT DEFAULT NULL,
  "status" INTEGER NOT NULL DEFAULT 1,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("base_id")
);
CREATE TABLE IF NOT EXISTS "hub_taxi_register" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "register_no" TEXT NOT NULL DEFAULT '',
  "reimburse_id" INTEGER NOT NULL DEFAULT 0,
  "round_no" TEXT NOT NULL DEFAULT '',
  "platform" TEXT NOT NULL DEFAULT '货拉拉',
  "plate_no" TEXT NOT NULL DEFAULT '',
  "driver_id" INTEGER NOT NULL DEFAULT 0,
  "driver_name" TEXT NOT NULL DEFAULT '',
  "driver_phone" TEXT NOT NULL DEFAULT '',
  "start_station_id" INTEGER NOT NULL DEFAULT 0,
  "start_station_name" TEXT NOT NULL DEFAULT '',
  "end_station_id" INTEGER NOT NULL DEFAULT 0,
  "end_station_name" TEXT NOT NULL DEFAULT '',
  "responsible_base_id" INTEGER NOT NULL DEFAULT 0,
  "responsible_base_name" TEXT NOT NULL DEFAULT '',
  "other_base_ids" TEXT,
  "other_base_names" TEXT,
  "fee" REAL NOT NULL DEFAULT 0.00,
  "pay_voucher_imgs" TEXT,
  "invoice_imgs" TEXT,
  "materials" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "hub_taxi_reimburse" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "reimburse_no" TEXT NOT NULL DEFAULT '',
  "round_no" TEXT NOT NULL DEFAULT '',
  "car_count" INTEGER NOT NULL DEFAULT 0,
  "total_amount" REAL NOT NULL DEFAULT 0.00,
  "status" INTEGER NOT NULL DEFAULT 3,
  "audit_user_id" INTEGER NOT NULL DEFAULT 0,
  "audit_name" TEXT NOT NULL DEFAULT '',
  "audit_time" TEXT DEFAULT NULL,
  "payment_voucher_imgs" TEXT,
  "remark" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("reimburse_no")
);
CREATE TABLE IF NOT EXISTS "hub_track_point" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "dispatch_id" INTEGER NOT NULL DEFAULT 0,
  "round_no" TEXT NOT NULL DEFAULT '',
  "vehicle_id" INTEGER NOT NULL DEFAULT 0,
  "driver_id" INTEGER NOT NULL DEFAULT 0,
  "lng" REAL NOT NULL DEFAULT 0.000000,
  "lat" REAL NOT NULL DEFAULT 0.000000,
  "speed" REAL NOT NULL DEFAULT 0.00,
  "source" INTEGER NOT NULL DEFAULT 1,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "gps_time" TEXT DEFAULT NULL
);
CREATE TABLE IF NOT EXISTS "hub_vehicle" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "vehicle_no" TEXT NOT NULL DEFAULT '',
  "plate_no" TEXT NOT NULL DEFAULT '云A',
  "type_id" INTEGER NOT NULL DEFAULT 0,
  "type_name" TEXT NOT NULL DEFAULT '',
  "load_standard" INTEGER NOT NULL DEFAULT 0,
  "fuel_consumption" REAL DEFAULT NULL,
  "owner_user_id" INTEGER NOT NULL DEFAULT 0,
  "owner_name" TEXT NOT NULL DEFAULT '',
  "default_station_id" INTEGER NOT NULL DEFAULT 0,
  "source" INTEGER NOT NULL DEFAULT 1,
  "platform" TEXT NOT NULL DEFAULT '',
  "driving_years" INTEGER NOT NULL DEFAULT 0,
  "driving_license_img" TEXT NOT NULL DEFAULT '',
  "cert_imgs" TEXT,
  "bank_holder" TEXT NOT NULL DEFAULT '',
  "bank_name" TEXT NOT NULL DEFAULT '',
  "bank_account" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 1,
  "remark" TEXT NOT NULL DEFAULT '',
  "audit_time" TEXT DEFAULT NULL,
  "audit_remark" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "hub_vehicle_type" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 1,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "hubflow_auto_signin_config" (
  "id" INTEGER NOT NULL DEFAULT 0,
  "radius_meters" INTEGER NOT NULL DEFAULT 500,
  "duration_minutes" INTEGER NOT NULL DEFAULT 3,
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  PRIMARY KEY ("id")
);
CREATE TABLE IF NOT EXISTS "hubflow_base_areas" (
  "name" TEXT NOT NULL DEFAULT '',
  "leader" TEXT NOT NULL DEFAULT '',
  "sort_no" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  PRIMARY KEY ("name")
);
CREATE TABLE IF NOT EXISTS "hubflow_dispatch_order_nodes" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "dispatch_order_id" INTEGER NOT NULL DEFAULT 0,
  "station_id" INTEGER DEFAULT NULL,
  "station_name" TEXT NOT NULL DEFAULT '',
  "sort_no" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "hubflow_dispatch_orders" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "no" TEXT NOT NULL DEFAULT '',
  "type" TEXT NOT NULL DEFAULT '内部车辆',
  "base_id" INTEGER DEFAULT NULL,
  "base_name" TEXT NOT NULL DEFAULT '',
  "trip_date" TEXT DEFAULT NULL,
  "taxi_registration_no" TEXT DEFAULT NULL,
  "start_station_id" INTEGER DEFAULT NULL,
  "start_station_name" TEXT NOT NULL DEFAULT '',
  "end_station_id" INTEGER DEFAULT NULL,
  "end_station_name" TEXT NOT NULL DEFAULT '',
  "route_name" TEXT NOT NULL DEFAULT '',
  "vehicle_id" INTEGER DEFAULT NULL,
  "vehicle_name" TEXT NOT NULL DEFAULT '',
  "driver_id" INTEGER DEFAULT NULL,
  "driver_name" TEXT NOT NULL DEFAULT '',
  "external_driver_phone" TEXT NOT NULL DEFAULT '',
  "destination" TEXT NOT NULL DEFAULT '',
  "planned_at" TEXT DEFAULT NULL,
  "mileage_km" REAL NOT NULL DEFAULT 0.00,
  "fee" TEXT NOT NULL DEFAULT '-',
  "other_base_names" TEXT NOT NULL DEFAULT '',
  "payment_voucher_url" TEXT NOT NULL DEFAULT '',
  "invoice_url" TEXT NOT NULL DEFAULT '',
  "reimburse_status" TEXT NOT NULL DEFAULT '待报销',
  "reimburse_remark" TEXT NOT NULL DEFAULT '',
  "reimburse_time" TEXT DEFAULT NULL,
  "status" TEXT NOT NULL DEFAULT '待装车',
  "remark" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("no")
);
CREATE TABLE IF NOT EXISTS "hubflow_driver_certificates" (
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "driver_license_url" TEXT NOT NULL DEFAULT '',
  "id_card_front_url" TEXT NOT NULL DEFAULT '',
  "id_card_back_url" TEXT NOT NULL DEFAULT '',
  "qualification_url" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  PRIMARY KEY ("user_id")
);
CREATE TABLE IF NOT EXISTS "hubflow_drivers" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL DEFAULT '',
  "phone" TEXT NOT NULL DEFAULT '',
  "role" TEXT NOT NULL DEFAULT '司机',
  "vehicle" TEXT NOT NULL DEFAULT '',
  "account" TEXT NOT NULL DEFAULT '',
  "status" TEXT NOT NULL DEFAULT '正常',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "hubflow_electronic_fences" (
  "station_id" INTEGER NOT NULL DEFAULT 0,
  "fence_type" TEXT NOT NULL DEFAULT 'circle',
  "radius" INTEGER NOT NULL DEFAULT 500,
  "auto_signin_radius" INTEGER NOT NULL DEFAULT 500,
  "polygon_points" TEXT,
  "longitude" TEXT NOT NULL DEFAULT '',
  "latitude" TEXT NOT NULL DEFAULT '',
  "address" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  PRIMARY KEY ("station_id")
);
CREATE TABLE IF NOT EXISTS "hubflow_external_dispatch_settlement_bills" (
  "trip_date" TEXT NOT NULL DEFAULT '',
  "status" TEXT NOT NULL DEFAULT '待结算',
  "remark" TEXT NOT NULL DEFAULT '',
  "review_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  PRIMARY KEY ("trip_date")
);
CREATE TABLE IF NOT EXISTS "hubflow_external_vehicles" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "app_user_id" INTEGER DEFAULT NULL,
  "plate_no" TEXT NOT NULL DEFAULT '',
  "driver_name" TEXT NOT NULL DEFAULT '',
  "driver_phone" TEXT NOT NULL DEFAULT '',
  "vehicle_type" TEXT NOT NULL DEFAULT '',
  "platform" TEXT NOT NULL DEFAULT '',
  "driving_license_url" TEXT NOT NULL DEFAULT '',
  "vehicle_license_url" TEXT NOT NULL DEFAULT '',
  "id_card_url" TEXT NOT NULL DEFAULT '',
  "bank_account_name" TEXT NOT NULL DEFAULT '',
  "bank_name" TEXT NOT NULL DEFAULT '',
  "bank_card_no" TEXT NOT NULL DEFAULT '',
  "status" TEXT NOT NULL DEFAULT '待审核',
  "remark" TEXT NOT NULL DEFAULT '',
  "audit_remark" TEXT NOT NULL DEFAULT '',
  "audit_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("plate_no")
);
CREATE TABLE IF NOT EXISTS "hubflow_fuel_price_config" (
  "id" INTEGER NOT NULL DEFAULT 0,
  "price_per_liter" REAL NOT NULL DEFAULT 0.00,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  PRIMARY KEY ("id")
);
CREATE TABLE IF NOT EXISTS "hubflow_permission_audit_logs" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "role_name" TEXT NOT NULL DEFAULT '',
  "before_permissions" TEXT NOT NULL DEFAULT '',
  "after_permissions" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER DEFAULT NULL,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "hubflow_role_permissions" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "role_name" TEXT NOT NULL DEFAULT '',
  "permission_code" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("role_name", "permission_code")
);
CREATE TABLE IF NOT EXISTS "hubflow_taxi_payment_accounts" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "account_name" TEXT NOT NULL DEFAULT '',
  "bank_name" TEXT NOT NULL DEFAULT '',
  "bank_card_no" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("bank_card_no")
);
CREATE TABLE IF NOT EXISTS "hubflow_taxi_reimburse_bills" (
  "trip_date" TEXT NOT NULL DEFAULT '',
  "registration_no" TEXT NOT NULL DEFAULT '',
  "payment_account_id" INTEGER DEFAULT NULL,
  "payee_name" TEXT NOT NULL DEFAULT '',
  "payee_bank_name" TEXT NOT NULL DEFAULT '',
  "payee_bank_card_no" TEXT NOT NULL DEFAULT '',
  "status" TEXT NOT NULL DEFAULT '待报销',
  "remark" TEXT NOT NULL DEFAULT '',
  "payment_voucher_url" TEXT,
  "review_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  PRIMARY KEY ("registration_no")
);
CREATE TABLE IF NOT EXISTS "hubflow_taxi_trips" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "no" TEXT NOT NULL DEFAULT '',
  "platform" TEXT NOT NULL DEFAULT '',
  "start_place" TEXT NOT NULL DEFAULT '',
  "end_place" TEXT NOT NULL DEFAULT '',
  "fee" REAL NOT NULL DEFAULT 0.00,
  "voucher_url" TEXT NOT NULL DEFAULT '',
  "status" TEXT NOT NULL DEFAULT '待报销',
  "remark" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("no")
);
CREATE TABLE IF NOT EXISTS "hubflow_track_points" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "trip_date" TEXT NOT NULL DEFAULT '',
  "dispatch_order_id" INTEGER DEFAULT NULL,
  "dispatch_no" TEXT NOT NULL DEFAULT '',
  "vehicle_id" INTEGER DEFAULT NULL,
  "plate_no" TEXT NOT NULL DEFAULT '',
  "driver_id" INTEGER DEFAULT NULL,
  "driver_name" TEXT NOT NULL DEFAULT '',
  "longitude" REAL NOT NULL DEFAULT 0,
  "latitude" REAL NOT NULL DEFAULT 0,
  "speed" REAL DEFAULT NULL,
  "direction" REAL DEFAULT NULL,
  "accuracy" REAL DEFAULT NULL,
  "located_at" TEXT NOT NULL DEFAULT '',
  "source" TEXT NOT NULL DEFAULT 'APP',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "hubflow_trip_signins" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "trip_date" TEXT NOT NULL DEFAULT '',
  "dispatch_order_id" INTEGER DEFAULT NULL,
  "dispatch_no" TEXT NOT NULL DEFAULT '',
  "vehicle_id" INTEGER DEFAULT NULL,
  "plate_no" TEXT NOT NULL DEFAULT '',
  "driver_id" INTEGER DEFAULT NULL,
  "driver_name" TEXT NOT NULL DEFAULT '',
  "node_type" TEXT NOT NULL DEFAULT '',
  "node_name" TEXT NOT NULL DEFAULT '',
  "station_id" INTEGER DEFAULT NULL,
  "station_name" TEXT NOT NULL DEFAULT '',
  "longitude" REAL DEFAULT NULL,
  "latitude" REAL DEFAULT NULL,
  "location_source" TEXT NOT NULL DEFAULT 'GPS',
  "accuracy" REAL DEFAULT NULL,
  "signal_level" TEXT NOT NULL DEFAULT '',
  "station_distance_meters" REAL DEFAULT NULL,
  "signin_source" TEXT NOT NULL DEFAULT '手动签到',
  "auto_signin_radius" INTEGER DEFAULT NULL,
  "auto_duration_minutes" INTEGER DEFAULT NULL,
  "auto_started_at" TEXT DEFAULT NULL,
  "confirmed_at" TEXT DEFAULT NULL,
  "acc" INTEGER DEFAULT NULL,
  "speed" REAL DEFAULT NULL,
  "device_online" INTEGER DEFAULT NULL,
  "address" TEXT NOT NULL DEFAULT '',
  "status" TEXT NOT NULL DEFAULT '待签到',
  "sign_time" TEXT DEFAULT NULL,
  "remark" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "hubflow_vehicle_types" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL DEFAULT '',
  "sort_no" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("name")
);
CREATE TABLE IF NOT EXISTS "hubflow_vehicles" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "vehicle_no" TEXT NOT NULL DEFAULT '',
  "plate_no" TEXT NOT NULL DEFAULT '',
  "type" TEXT NOT NULL DEFAULT '',
  "driver_id" INTEGER DEFAULT NULL,
  "driver_name" TEXT NOT NULL DEFAULT '',
  "load_frames" INTEGER DEFAULT NULL,
  "load_text" TEXT NOT NULL DEFAULT '',
  "destination_id" INTEGER DEFAULT NULL,
  "destination" TEXT NOT NULL DEFAULT '',
  "driving_years" TEXT NOT NULL DEFAULT '',
  "driving_license_url" TEXT NOT NULL DEFAULT '',
  "vehicle_license_url" TEXT NOT NULL DEFAULT '',
  "fuel_consumption" REAL NOT NULL DEFAULT 0.00,
  "tracking_device_no" TEXT NOT NULL DEFAULT '',
  "acc" INTEGER NOT NULL DEFAULT 0,
  "acc_update_time" TEXT DEFAULT NULL,
  "acc_last_on_time" TEXT DEFAULT NULL,
  "status" TEXT NOT NULL DEFAULT '空闲',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("plate_no")
);
CREATE TABLE IF NOT EXISTS "idx_city_list" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "idx" TEXT NOT NULL DEFAULT '',
  "city_name" TEXT NOT NULL DEFAULT '',
  "city_pinyin" TEXT NOT NULL DEFAULT '',
  "is_hot" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "invoicing_application" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "identification_number" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "reason" TEXT NOT NULL DEFAULT '',
  "review_id" INTEGER NOT NULL DEFAULT 0,
  "review_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "apply_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "review_time" TEXT DEFAULT NULL,
  UNIQUE ("supplier_id")
);
CREATE TABLE IF NOT EXISTS "legacy_purchaser_split" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "old_user_id" INTEGER NOT NULL DEFAULT 0,
  "bulky_user_id" INTEGER DEFAULT NULL,
  "hck_user_id" INTEGER DEFAULT NULL,
  "retained_platform" TEXT NOT NULL DEFAULT '',
  "evidence_begin_date" TEXT NOT NULL DEFAULT '',
  "paid_only" INTEGER NOT NULL DEFAULT 0,
  "bulky_order_count" INTEGER NOT NULL DEFAULT 0,
  "hck_order_count" INTEGER NOT NULL DEFAULT 0,
  "other_order_count" INTEGER NOT NULL DEFAULT 0,
  "unclassified_row_count" INTEGER NOT NULL DEFAULT 0,
  "migration_status" TEXT NOT NULL DEFAULT '',
  "affected_rows_json" TEXT,
  "error_message" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "complete_time" TEXT DEFAULT NULL,
  UNIQUE ("old_user_id")
);
CREATE TABLE IF NOT EXISTS "logistics_actual_price" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "send_no" TEXT DEFAULT NULL,
  "zone_shelf" TEXT DEFAULT NULL,
  "round_no" TEXT DEFAULT NULL,
  "carrier_id" INTEGER DEFAULT NULL,
  "quote_price" REAL DEFAULT NULL,
  "expend_express_price" REAL DEFAULT NULL,
  "diff_price" REAL DEFAULT NULL,
  "status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT DEFAULT NULL,
  "update_time" TEXT DEFAULT NULL,
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "logistics_bill_import_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "round_no" TEXT DEFAULT NULL,
  "remark" TEXT DEFAULT NULL,
  "status" INTEGER NOT NULL DEFAULT 0,
  "result" TEXT DEFAULT NULL,
  "link" TEXT DEFAULT NULL,
  "operator_id" INTEGER DEFAULT NULL,
  "operator_name" TEXT DEFAULT NULL,
  "create_time" TEXT DEFAULT NULL,
  "update_time" TEXT DEFAULT NULL,
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "logistics_carrier" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "provider_id" INTEGER NOT NULL DEFAULT 0,
  "config_id" INTEGER DEFAULT NULL,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "carrier_name" TEXT NOT NULL DEFAULT '',
  "logistics_type" INTEGER NOT NULL DEFAULT 1,
  "phone" TEXT DEFAULT NULL,
  "description" TEXT DEFAULT NULL,
  "expected_time_str" TEXT DEFAULT NULL,
  "expected_time_hours" INTEGER NOT NULL DEFAULT 0,
  "delivery_time" TEXT DEFAULT NULL,
  "sort_num" INTEGER NOT NULL DEFAULT 0,
  "is_enable" INTEGER NOT NULL DEFAULT 1,
  "create_time" TEXT DEFAULT NULL,
  "update_time" TEXT DEFAULT NULL,
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "logistics_carrier_account_bind" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "account_type" INTEGER NOT NULL DEFAULT 0,
  "account_id" INTEGER NOT NULL DEFAULT 0,
  "carrier_id" INTEGER NOT NULL DEFAULT 0,
  "provider_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "logistics_carrier_config" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "carrier_id" INTEGER NOT NULL DEFAULT 0,
  "config_id" INTEGER NOT NULL DEFAULT 0,
  "config_name" TEXT DEFAULT NULL,
  "sort_num" INTEGER NOT NULL DEFAULT 0,
  "is_enable" INTEGER NOT NULL DEFAULT 1,
  "create_time" TEXT DEFAULT NULL,
  "update_time" TEXT DEFAULT NULL,
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "logistics_carrier_region" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "provider_id" INTEGER NOT NULL DEFAULT 0,
  "carrier_id" INTEGER NOT NULL DEFAULT 0,
  "region_id" INTEGER NOT NULL DEFAULT 0,
  "adcode" TEXT NOT NULL DEFAULT '',
  "region_name" TEXT NOT NULL DEFAULT '',
  "xm_special_line" INTEGER NOT NULL DEFAULT 0,
  "picker_name" TEXT NOT NULL DEFAULT '',
  "picker_mobile" TEXT NOT NULL DEFAULT '',
  "delivery_time" TEXT NOT NULL DEFAULT '',
  "expected_time_str" TEXT NOT NULL DEFAULT '',
  "expected_time_hours" INTEGER NOT NULL DEFAULT 0,
  "description" TEXT NOT NULL DEFAULT '',
  "trans_city" TEXT NOT NULL DEFAULT '',
  "pay_on_delivery" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT DEFAULT NULL,
  "update_time" TEXT DEFAULT NULL,
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("carrier_id", "region_id")
);
CREATE TABLE IF NOT EXISTS "logistics_freight_reconcile_bill" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "bill_no" TEXT NOT NULL DEFAULT '',
  "bill_name" TEXT NOT NULL DEFAULT '',
  "round_start" TEXT NOT NULL DEFAULT '',
  "round_end" TEXT NOT NULL DEFAULT '',
  "filter_provider_id" INTEGER NOT NULL DEFAULT 0,
  "filter_carrier_id" INTEGER NOT NULL DEFAULT 0,
  "order_count" INTEGER NOT NULL DEFAULT 0,
  "package_count" INTEGER NOT NULL DEFAULT 0,
  "act_amount" REAL NOT NULL DEFAULT 0.00,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT DEFAULT NULL,
  "update_time" TEXT DEFAULT NULL,
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("bill_no")
);
CREATE TABLE IF NOT EXISTS "logistics_freight_reconcile_detail" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "total_bill_id" INTEGER NOT NULL DEFAULT 0,
  "sub_bill_id" INTEGER NOT NULL DEFAULT 0,
  "package_record_id" INTEGER NOT NULL DEFAULT 0,
  "package_id" INTEGER DEFAULT NULL,
  "send_order_id" INTEGER NOT NULL DEFAULT 0,
  "send_no" TEXT NOT NULL DEFAULT '',
  "provider_id" INTEGER NOT NULL DEFAULT 0,
  "provider_name" TEXT NOT NULL DEFAULT '',
  "carrier_id" INTEGER NOT NULL DEFAULT 0,
  "carrier_name" TEXT NOT NULL DEFAULT '',
  "config_id" INTEGER NOT NULL DEFAULT 0,
  "quote_mode" INTEGER NOT NULL DEFAULT 1,
  "waybill_price_id" INTEGER DEFAULT NULL,
  "mail_no" TEXT NOT NULL DEFAULT '',
  "round_no" TEXT DEFAULT NULL,
  "report_time" TEXT DEFAULT NULL,
  "report_operator_id" INTEGER NOT NULL DEFAULT 0,
  "report_operator_name" TEXT NOT NULL DEFAULT '',
  "package_info" TEXT NOT NULL DEFAULT '',
  "total_weight" REAL NOT NULL DEFAULT 0.000,
  "express_actual_weight" REAL NOT NULL DEFAULT 0.000,
  "report_price" REAL NOT NULL DEFAULT 0.00,
  "zone" TEXT NOT NULL DEFAULT '',
  "zone_shelf" TEXT NOT NULL DEFAULT '',
  "receive_name" TEXT NOT NULL DEFAULT '',
  "receive_tel" TEXT NOT NULL DEFAULT '',
  "receive_address" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT DEFAULT NULL,
  "update_time" TEXT DEFAULT NULL,
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "logistics_freight_reconcile_sub_bill" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "bill_no" TEXT NOT NULL DEFAULT '',
  "total_bill_id" INTEGER NOT NULL DEFAULT 0,
  "provider_id" INTEGER NOT NULL DEFAULT 0,
  "provider_name" TEXT NOT NULL DEFAULT '',
  "carrier_id" INTEGER NOT NULL DEFAULT 0,
  "carrier_name" TEXT NOT NULL DEFAULT '',
  "config_id" INTEGER NOT NULL DEFAULT 0,
  "order_count" INTEGER NOT NULL DEFAULT 0,
  "package_count" INTEGER NOT NULL DEFAULT 0,
  "act_amount" REAL NOT NULL DEFAULT 0.00,
  "original_payable_amount" REAL NOT NULL DEFAULT 0.00,
  "adjust_amount" REAL NOT NULL DEFAULT 0.00,
  "payable_amount" REAL NOT NULL DEFAULT 0.00,
  "status" INTEGER NOT NULL DEFAULT 0,
  "sync_count" INTEGER NOT NULL DEFAULT 0,
  "revoke_count" INTEGER NOT NULL DEFAULT 0,
  "confirm_operator_id" INTEGER NOT NULL DEFAULT 0,
  "confirm_operator_name" TEXT NOT NULL DEFAULT '',
  "confirm_time" TEXT DEFAULT NULL,
  "create_time" TEXT DEFAULT NULL,
  "update_time" TEXT DEFAULT NULL,
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("bill_no")
);
CREATE TABLE IF NOT EXISTS "logistics_freight_settle_operation" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "send_order_id" INTEGER NOT NULL DEFAULT 0,
  "send_no" TEXT NOT NULL DEFAULT '',
  "freight_price_mode" INTEGER NOT NULL DEFAULT 0,
  "package_price_snapshot" REAL NOT NULL DEFAULT 0.00,
  "waybill_price_snapshot" REAL NOT NULL DEFAULT 0.00,
  "suggested_price" REAL NOT NULL DEFAULT 0.00,
  "confirmed_price" REAL NOT NULL DEFAULT 0.00,
  "difference_price" REAL NOT NULL DEFAULT 0.00,
  "remark" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER DEFAULT NULL,
  "operator_name" TEXT DEFAULT NULL,
  "operation_time" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "logistics_message" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "msg_type" INTEGER NOT NULL DEFAULT 0,
  "target_type" INTEGER NOT NULL DEFAULT 0,
  "carrier_id" INTEGER NOT NULL DEFAULT 0,
  "provider_id" INTEGER NOT NULL DEFAULT 0,
  "biz_type" INTEGER NOT NULL DEFAULT 0,
  "biz_id" INTEGER NOT NULL DEFAULT 0,
  "title" TEXT NOT NULL DEFAULT '',
  "content" TEXT NOT NULL DEFAULT '',
  "creator_account_type" INTEGER NOT NULL DEFAULT 0,
  "creator_account_id" INTEGER NOT NULL DEFAULT 0,
  "creator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "logistics_message_read" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "message_id" INTEGER NOT NULL DEFAULT 0,
  "reader_type" INTEGER NOT NULL DEFAULT 0,
  "read_key" INTEGER NOT NULL DEFAULT 0,
  "read_account_type" INTEGER NOT NULL DEFAULT 0,
  "read_account_id" INTEGER NOT NULL DEFAULT 0,
  "read_name" TEXT NOT NULL DEFAULT '',
  "read_time" TEXT DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("message_id", "reader_type", "read_key")
);
CREATE TABLE IF NOT EXISTS "logistics_order" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "send_no" TEXT DEFAULT NULL,
  "order_sn" TEXT DEFAULT NULL,
  "carrier_id" INTEGER DEFAULT NULL,
  "provider_id" INTEGER DEFAULT NULL,
  "logistics_no" TEXT DEFAULT NULL,
  "mail_no" TEXT DEFAULT NULL,
  "logistics_type" INTEGER DEFAULT NULL,
  "round_no" TEXT DEFAULT NULL,
  "print_data" TEXT,
  "status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT DEFAULT NULL,
  "update_time" TEXT DEFAULT NULL,
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "logistics_package_abnormal_tag" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "tag_name" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 1,
  "sort_no" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "logistics_package_operation" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "package_id" INTEGER NOT NULL DEFAULT 0,
  "op_type" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER DEFAULT NULL,
  "operator_name" TEXT DEFAULT NULL,
  "op_time" TEXT DEFAULT NULL,
  "remark" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "logistics_package_tag_relation" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "package_id" INTEGER NOT NULL DEFAULT 0,
  "tag_id" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("package_id", "tag_id")
);
CREATE TABLE IF NOT EXISTS "logistics_pickup_fee_operation" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "request_send_order_id" INTEGER NOT NULL DEFAULT 0,
  "request_send_no" TEXT NOT NULL DEFAULT '',
  "send_order_id" INTEGER NOT NULL DEFAULT 0,
  "send_no" TEXT NOT NULL DEFAULT '',
  "round_no" TEXT NOT NULL DEFAULT '',
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "original_pickup_fee" REAL NOT NULL DEFAULT 0.00,
  "new_pickup_fee" REAL NOT NULL DEFAULT 0.00,
  "operator_id" INTEGER DEFAULT NULL,
  "operator_name" TEXT DEFAULT NULL,
  "operation_time" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "logistics_price_change_record" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "logistics_id" INTEGER NOT NULL DEFAULT 0,
  "logistics_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "content" TEXT,
  "operate_name" TEXT NOT NULL DEFAULT ''
);
CREATE TABLE IF NOT EXISTS "logistics_provider" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "provider_name" TEXT NOT NULL DEFAULT '',
  "login_account" TEXT DEFAULT NULL,
  "password" TEXT DEFAULT NULL,
  "salt" TEXT DEFAULT NULL,
  "contact" TEXT DEFAULT NULL,
  "phone" TEXT DEFAULT NULL,
  "remark" TEXT DEFAULT NULL,
  "landline" TEXT DEFAULT NULL,
  "support_logistics_types" TEXT NOT NULL DEFAULT '1,2,3',
  "access_key" TEXT DEFAULT NULL,
  "access_secret" TEXT DEFAULT NULL,
  "token" TEXT DEFAULT NULL,
  "status" INTEGER NOT NULL DEFAULT 1,
  "create_time" TEXT DEFAULT NULL,
  "update_time" TEXT DEFAULT NULL,
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("login_account")
);
CREATE TABLE IF NOT EXISTS "logistics_provider_account_bind" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "account_type" INTEGER NOT NULL DEFAULT 0,
  "account_id" INTEGER NOT NULL DEFAULT 0,
  "provider_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("account_type", "account_id", "provider_id")
);
CREATE TABLE IF NOT EXISTS "logistics_provider_checkin" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "provider_id" INTEGER NOT NULL DEFAULT 0,
  "provider_name" TEXT NOT NULL DEFAULT '',
  "round_no" TEXT NOT NULL DEFAULT '',
  "checkin_type" INTEGER NOT NULL DEFAULT 0,
  "checkin_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("provider_id", "round_no", "data_status")
);
CREATE TABLE IF NOT EXISTS "logistics_provider_config" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "provider_id" INTEGER NOT NULL DEFAULT 0,
  "config_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("config_id")
);
CREATE TABLE IF NOT EXISTS "logistics_quote" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "provider_id" INTEGER NOT NULL DEFAULT 0,
  "carrier_id" INTEGER NOT NULL DEFAULT 0,
  "start_round_no" TEXT NOT NULL DEFAULT '',
  "end_round_no" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "reason" TEXT DEFAULT NULL,
  "submit_time" TEXT DEFAULT NULL,
  "operator_account_type" INTEGER DEFAULT NULL,
  "operator_account_id" INTEGER DEFAULT NULL,
  "operator_name" TEXT DEFAULT NULL,
  "review_id" INTEGER DEFAULT NULL,
  "review_name" TEXT DEFAULT NULL,
  "review_time" TEXT DEFAULT NULL,
  "create_time" TEXT DEFAULT NULL,
  "update_time" TEXT DEFAULT NULL,
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "logistics_quote_region" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "quote_id" INTEGER NOT NULL DEFAULT 0,
  "carrier_id" INTEGER DEFAULT NULL,
  "carrier_region_id" INTEGER DEFAULT NULL,
  "status" INTEGER NOT NULL DEFAULT 3,
  "start_round_no" TEXT NOT NULL DEFAULT '',
  "end_round_no" TEXT NOT NULL DEFAULT '',
  "enable_status" INTEGER NOT NULL DEFAULT 1,
  "source" INTEGER NOT NULL DEFAULT 0,
  "submit_time" TEXT DEFAULT NULL,
  "operator_account_type" INTEGER DEFAULT NULL,
  "operator_account_id" INTEGER DEFAULT NULL,
  "operator_name" TEXT DEFAULT NULL,
  "review_id" INTEGER DEFAULT NULL,
  "review_name" TEXT DEFAULT NULL,
  "review_time" TEXT DEFAULT NULL,
  "reason" TEXT DEFAULT NULL,
  "region_id" INTEGER DEFAULT NULL,
  "adcode" TEXT DEFAULT NULL,
  "region_name" TEXT DEFAULT NULL,
  "xm_special_line" INTEGER NOT NULL DEFAULT 0,
  "charge_type" INTEGER NOT NULL DEFAULT 0,
  "price_data" TEXT,
  "activity_price_data" TEXT NOT NULL DEFAULT '',
  "multi_price_data" TEXT,
  "weight_range_data" TEXT NOT NULL DEFAULT '',
  "trunk_charge_type" INTEGER NOT NULL DEFAULT 0,
  "shop_charge_type" INTEGER NOT NULL DEFAULT 0,
  "first_heavy" REAL DEFAULT NULL,
  "first_heavy_price" REAL DEFAULT NULL,
  "delivery_time" TEXT DEFAULT NULL,
  "expected_time_str" TEXT DEFAULT NULL,
  "description" TEXT NOT NULL DEFAULT '',
  "picker_name" TEXT NOT NULL DEFAULT '',
  "picker_mobile" TEXT NOT NULL DEFAULT '',
  "trans_city" TEXT NOT NULL DEFAULT '',
  "pay_on_delivery" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT DEFAULT NULL,
  "update_time" TEXT DEFAULT NULL,
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "legacy_region_id" INTEGER DEFAULT NULL,
  UNIQUE ("legacy_region_id")
);
CREATE TABLE IF NOT EXISTS "logistics_reconcile_bill" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "bill_no" TEXT NOT NULL DEFAULT '',
  "bill_name" TEXT NOT NULL DEFAULT '',
  "round_start" TEXT NOT NULL DEFAULT '',
  "round_end" TEXT NOT NULL DEFAULT '',
  "order_count" INTEGER NOT NULL DEFAULT 0,
  "pre_amount" REAL NOT NULL DEFAULT 0.00,
  "act_amount" REAL NOT NULL DEFAULT 0.00,
  "status" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "confirm_operator_id" INTEGER NOT NULL DEFAULT 0,
  "confirm_operator_name" TEXT NOT NULL DEFAULT '',
  "confirm_time" TEXT DEFAULT NULL,
  "create_time" TEXT DEFAULT NULL,
  "update_time" TEXT DEFAULT NULL,
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("bill_no")
);
CREATE TABLE IF NOT EXISTS "logistics_reconcile_bill_item" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "bill_id" INTEGER NOT NULL DEFAULT 0,
  "item_type" INTEGER NOT NULL DEFAULT 0,
  "target_id" INTEGER NOT NULL DEFAULT 0,
  "target_name" TEXT NOT NULL DEFAULT '',
  "order_count" INTEGER NOT NULL DEFAULT 0,
  "pre_amount" REAL NOT NULL DEFAULT 0.00,
  "act_amount" REAL NOT NULL DEFAULT 0.00,
  "create_time" TEXT DEFAULT NULL,
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "logistics_route" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "mail_no" TEXT NOT NULL DEFAULT '',
  "logistics_no" TEXT DEFAULT NULL,
  "route_data" TEXT,
  "route_status" INTEGER DEFAULT NULL,
  "create_time" TEXT DEFAULT NULL,
  "update_time" TEXT DEFAULT NULL,
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "logistics_session_settlement" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "settle_no" TEXT NOT NULL DEFAULT '',
  "biz_type" INTEGER NOT NULL DEFAULT 0,
  "target_id" INTEGER NOT NULL DEFAULT 0,
  "target_name" TEXT NOT NULL DEFAULT '',
  "round_no" TEXT NOT NULL DEFAULT '',
  "op_type" INTEGER NOT NULL DEFAULT 1,
  "amount" REAL NOT NULL DEFAULT 0.00,
  "order_count" INTEGER NOT NULL DEFAULT 0,
  "remark" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "settle_operator_id" INTEGER NOT NULL DEFAULT 0,
  "settle_operator_name" TEXT NOT NULL DEFAULT '',
  "settle_time" TEXT DEFAULT NULL,
  "create_time" TEXT DEFAULT NULL,
  "update_time" TEXT DEFAULT NULL,
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("settle_no")
);
CREATE TABLE IF NOT EXISTS "logistics_settle_adjust" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "adjust_no" TEXT NOT NULL DEFAULT '',
  "source" INTEGER NOT NULL DEFAULT 0,
  "ref_id" INTEGER NOT NULL DEFAULT 0,
  "ref_no" TEXT NOT NULL DEFAULT '',
  "provider_name" TEXT NOT NULL DEFAULT '',
  "carrier_id" INTEGER NOT NULL DEFAULT 0,
  "period" TEXT NOT NULL DEFAULT '',
  "orig_amount" REAL NOT NULL DEFAULT 0.00,
  "new_amount" REAL NOT NULL DEFAULT 0.00,
  "diff_amount" REAL NOT NULL DEFAULT 0.00,
  "reason" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT DEFAULT NULL,
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("adjust_no")
);
CREATE TABLE IF NOT EXISTS "logistics_transport_package" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "task_id" INTEGER NOT NULL DEFAULT 0,
  "package_id" INTEGER NOT NULL DEFAULT 0,
  "driver_id" INTEGER NOT NULL DEFAULT 0,
  "round_no" TEXT NOT NULL DEFAULT '',
  "load_time" TEXT NOT NULL DEFAULT '',
  "load_type" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT DEFAULT NULL,
  UNIQUE ("package_id")
);
CREATE TABLE IF NOT EXISTS "logistics_transport_task" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "provider_id" INTEGER NOT NULL DEFAULT 0,
  "driver_id" INTEGER NOT NULL DEFAULT 0,
  "driver_name" TEXT DEFAULT NULL,
  "driver_phone" TEXT DEFAULT NULL,
  "round_no" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 1,
  "active_flag" INTEGER DEFAULT 1,
  "package_count" INTEGER NOT NULL DEFAULT 0,
  "depart_time" TEXT DEFAULT NULL,
  "depart_lng" REAL DEFAULT NULL,
  "depart_lat" REAL DEFAULT NULL,
  "depart_address" TEXT DEFAULT NULL,
  "arrive_time" TEXT DEFAULT NULL,
  "arrive_lng" REAL DEFAULT NULL,
  "arrive_lat" REAL DEFAULT NULL,
  "arrive_address" TEXT DEFAULT NULL,
  "arrive_type" INTEGER DEFAULT NULL,
  "arrive_operator_id" INTEGER DEFAULT NULL,
  "arrive_operator_name" TEXT DEFAULT NULL,
  "arrive_remark" TEXT DEFAULT NULL,
  "last_lng" REAL DEFAULT NULL,
  "last_lat" REAL DEFAULT NULL,
  "last_address" TEXT DEFAULT NULL,
  "last_gps_time" TEXT DEFAULT NULL,
  "create_time" TEXT DEFAULT NULL,
  "update_time" TEXT DEFAULT NULL,
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("driver_id", "active_flag")
);
CREATE TABLE IF NOT EXISTS "logistics_transport_track" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "task_id" INTEGER NOT NULL DEFAULT 0,
  "round_no" TEXT NOT NULL DEFAULT '',
  "points" TEXT,
  "point_count" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT DEFAULT NULL,
  "update_time" TEXT DEFAULT NULL,
  UNIQUE ("task_id")
);
CREATE TABLE IF NOT EXISTS "logistics_waybill_price" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "batch_no" TEXT NOT NULL DEFAULT '',
  "row_no" INTEGER NOT NULL DEFAULT 0,
  "carrier_id" INTEGER NOT NULL DEFAULT 0,
  "config_id" INTEGER DEFAULT NULL,
  "mail_no" TEXT DEFAULT NULL,
  "dedup_mail_no" TEXT DEFAULT NULL,
  "receiver_name" TEXT DEFAULT NULL,
  "receiver_phone" TEXT DEFAULT NULL,
  "destination_address" TEXT DEFAULT NULL,
  "report_price" REAL DEFAULT NULL,
  "weight" REAL DEFAULT NULL,
  "package_info" TEXT DEFAULT NULL,
  "logistics_order_id" INTEGER DEFAULT NULL,
  "logistics_no" TEXT DEFAULT NULL,
  "send_order_id" INTEGER DEFAULT NULL,
  "send_no" TEXT DEFAULT NULL,
  "match_status" INTEGER NOT NULL DEFAULT 0,
  "match_source" INTEGER NOT NULL DEFAULT 0,
  "apply_status" INTEGER NOT NULL DEFAULT 0,
  "fail_reason" TEXT DEFAULT NULL,
  "import_operator_id" INTEGER DEFAULT NULL,
  "import_operator_name" TEXT DEFAULT NULL,
  "match_operator_id" INTEGER DEFAULT NULL,
  "match_operator_name" TEXT DEFAULT NULL,
  "match_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("dedup_mail_no")
);
CREATE TABLE IF NOT EXISTS "machine_prepare_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "code_content" TEXT DEFAULT NULL,
  "date" TEXT DEFAULT NULL,
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "sub_shelf_sn" TEXT DEFAULT NULL,
  "zone" TEXT NOT NULL DEFAULT '',
  "shelf" TEXT NOT NULL DEFAULT '',
  "zone_shelf" TEXT NOT NULL DEFAULT '',
  "enter_item_id" INTEGER NOT NULL DEFAULT 0,
  "delivery_income" REAL DEFAULT NULL,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "user_name" TEXT DEFAULT NULL,
  "op" INTEGER NOT NULL DEFAULT 0,
  "op_type" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "member_coupon_record" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "level" INTEGER NOT NULL DEFAULT 0,
  "coupon_config" TEXT NOT NULL DEFAULT '',
  "round_no" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "member_exp_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "type" INTEGER NOT NULL DEFAULT 0,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "old_exp" INTEGER NOT NULL DEFAULT 0,
  "exp" INTEGER NOT NULL DEFAULT 0,
  "new_exp" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "member_level_config" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "level" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "exp" INTEGER NOT NULL DEFAULT 0,
  "coupon_config" TEXT,
  "rate" REAL NOT NULL DEFAULT 1.00,
  "image" TEXT NOT NULL DEFAULT '',
  "description" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "member_level_history" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "platform" INTEGER NOT NULL DEFAULT 1,
  "item_num" INTEGER NOT NULL DEFAULT 0,
  "old_level_id" INTEGER NOT NULL DEFAULT 0,
  "old_level_name" TEXT NOT NULL DEFAULT '',
  "level_id" INTEGER NOT NULL DEFAULT 0,
  "level_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "member_point_bill" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "type" INTEGER NOT NULL DEFAULT 0,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "old_point" INTEGER NOT NULL DEFAULT 0,
  "point" INTEGER NOT NULL DEFAULT 0,
  "new_point" INTEGER NOT NULL DEFAULT 0,
  "reason" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "membership" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "app_id" TEXT NOT NULL DEFAULT '',
  "vip_level" INTEGER NOT NULL DEFAULT 1,
  "level_time" TEXT NOT NULL DEFAULT '',
  "point" INTEGER NOT NULL DEFAULT 0,
  "exp" INTEGER NOT NULL DEFAULT 0,
  "rolling_exp_365" INTEGER DEFAULT 0,
  "protection_start_time" TEXT DEFAULT NULL,
  "protection_status" INTEGER DEFAULT 0,
  "last_level_check_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("user_id")
);
CREATE TABLE IF NOT EXISTS "merchant_apply_info" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "merchant_type" INTEGER NOT NULL DEFAULT 0,
  "merchant_id" INTEGER NOT NULL DEFAULT 0,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "merchant_name" TEXT NOT NULL DEFAULT '',
  "contact_name" TEXT NOT NULL DEFAULT '',
  "contact_tel" TEXT NOT NULL DEFAULT '',
  "email" TEXT NOT NULL DEFAULT '',
  "wechat_no" TEXT NOT NULL DEFAULT '',
  "province" TEXT NOT NULL DEFAULT '',
  "city" TEXT NOT NULL DEFAULT '',
  "district" TEXT NOT NULL DEFAULT '',
  "detail_address" TEXT NOT NULL DEFAULT '',
  "warehouse_area" TEXT NOT NULL DEFAULT '',
  "door_photo" TEXT NOT NULL DEFAULT '',
  "license_photo" TEXT NOT NULL DEFAULT '',
  "site_photos" TEXT,
  "advantage_desc" TEXT NOT NULL DEFAULT '',
  "agree_flag" INTEGER NOT NULL DEFAULT 0,
  "submit_status" INTEGER NOT NULL DEFAULT 0,
  "reject_reason" TEXT NOT NULL DEFAULT '',
  "submit_time" TEXT DEFAULT NULL,
  "audit_user_id" INTEGER NOT NULL DEFAULT 0,
  "audit_user_name" TEXT NOT NULL DEFAULT '',
  "audit_time" TEXT DEFAULT NULL,
  "pass_page_viewed_flag" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "merchant_audit_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "record_type" INTEGER NOT NULL DEFAULT 0,
  "merchant_type" INTEGER NOT NULL DEFAULT 0,
  "merchant_id" INTEGER NOT NULL DEFAULT 0,
  "merchant_name" TEXT NOT NULL DEFAULT '',
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "ware_name" TEXT NOT NULL DEFAULT '',
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "partner_name" TEXT NOT NULL DEFAULT '',
  "app_id" TEXT NOT NULL DEFAULT '',
  "business_status" INTEGER NOT NULL DEFAULT 0,
  "audit_status" INTEGER NOT NULL DEFAULT 0,
  "action" TEXT NOT NULL DEFAULT '',
  "reason" TEXT NOT NULL DEFAULT '',
  "content" TEXT NOT NULL DEFAULT '',
  "extra_json" TEXT,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "mibei_product" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "rank_num" INTEGER NOT NULL DEFAULT 0,
  "ranking" INTEGER NOT NULL DEFAULT 0,
  "price" REAL NOT NULL DEFAULT 0.00,
  "supply_price" REAL NOT NULL DEFAULT 0.00,
  "inventory" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("second_id", "rank_num", "ranking")
);
CREATE TABLE IF NOT EXISTS "mibei_product_summary" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT DEFAULT NULL,
  "total_inventory" INTEGER DEFAULT NULL,
  "seller_num" INTEGER DEFAULT NULL,
  "xm_total_inventory" INTEGER DEFAULT NULL,
  "xm_supplier_num" INTEGER DEFAULT NULL,
  "inventory_diff_ratio" REAL DEFAULT NULL,
  "supplier_diff_ratio" REAL DEFAULT NULL,
  "summary_date" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("second_id")
);
CREATE TABLE IF NOT EXISTS "partner" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL DEFAULT '',
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "app_id" TEXT NOT NULL DEFAULT '',
  "contact_name" TEXT NOT NULL DEFAULT '',
  "contact_tel" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 1,
  "service_fee_add_price_flag" INTEGER NOT NULL DEFAULT 0,
  "service_fee_add_price" REAL NOT NULL DEFAULT 0.00,
  "service_fee_merge" INTEGER NOT NULL DEFAULT 0,
  "free_shipping_flag" INTEGER NOT NULL DEFAULT 0,
  "open_flag" INTEGER NOT NULL DEFAULT 0,
  "coupon_flag" INTEGER NOT NULL DEFAULT 1,
  "coupon_use_flag" INTEGER NOT NULL DEFAULT 0,
  "add_price_flag" INTEGER NOT NULL DEFAULT 0,
  "b2b_flag" INTEGER NOT NULL DEFAULT 0,
  "promote_flag" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("app_id")
);
CREATE TABLE IF NOT EXISTS "partner_class_first_add_price" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "partner_region_id" INTEGER NOT NULL DEFAULT 0,
  "first_id" INTEGER NOT NULL DEFAULT 0,
  "rank_num" INTEGER NOT NULL DEFAULT 0,
  "add_price" REAL NOT NULL DEFAULT 0.00,
  "enable" INTEGER NOT NULL DEFAULT 1,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("first_id", "rank_num", "partner_id", "partner_region_id")
);
CREATE TABLE IF NOT EXISTS "partner_class_second" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "app_id" TEXT NOT NULL DEFAULT '',
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "pic_url" TEXT NOT NULL DEFAULT '',
  "rank_auth" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("app_id", "second_id")
);
CREATE TABLE IF NOT EXISTS "partner_class_second_add_price" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "rank_num" INTEGER NOT NULL DEFAULT 0,
  "add_price" REAL NOT NULL DEFAULT 0.00,
  "price_unit" INTEGER NOT NULL DEFAULT 0,
  "enable" INTEGER NOT NULL DEFAULT 1,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("second_id", "rank_num", "partner_id")
);
CREATE TABLE IF NOT EXISTS "partner_class_second_add_price_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "operation_no" TEXT NOT NULL DEFAULT '',
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "rank_num" INTEGER NOT NULL DEFAULT 0,
  "current_add_price" REAL NOT NULL DEFAULT 0.00,
  "change_add_price" REAL NOT NULL DEFAULT 0.00,
  "final_add_price" REAL NOT NULL DEFAULT 0.00,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("operation_no", "second_id", "rank_num")
);
CREATE TABLE IF NOT EXISTS "partner_common_class" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "second_ids" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("partner_id")
);
CREATE TABLE IF NOT EXISTS "partner_config" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "show_phone_flag" INTEGER NOT NULL DEFAULT 1,
  "contact_phone" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "menu_access_password" TEXT DEFAULT NULL,
  "menu_access_salt" TEXT DEFAULT NULL,
  "menu_access_password_version" INTEGER NOT NULL DEFAULT 0,
  "protected_menu_codes" TEXT,
  UNIQUE ("partner_id")
);
CREATE TABLE IF NOT EXISTS "partner_data_statistics" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "yyyy_mm_dd" TEXT NOT NULL DEFAULT '',
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "all_total_price" REAL NOT NULL DEFAULT 0.00,
  "turnover" REAL NOT NULL DEFAULT 0.00,
  "supplier_due" REAL NOT NULL DEFAULT 0.00,
  "service_fee" REAL NOT NULL DEFAULT 0.00,
  "refer_service_fee" REAL NOT NULL DEFAULT 0.00,
  "delta_service_fee" REAL NOT NULL DEFAULT 0.00,
  "partner_product_add_price" REAL NOT NULL DEFAULT 0.00,
  "partner_express_add_price" REAL NOT NULL DEFAULT 0.00,
  "ot_exp_add_price" REAL NOT NULL DEFAULT 0.00,
  "express_price" REAL NOT NULL DEFAULT 0.00,
  "add_price" REAL NOT NULL DEFAULT 0.00,
  "rebate_xm_coin" REAL NOT NULL DEFAULT 0.00,
  "subsidy_price" REAL NOT NULL DEFAULT 0.00,
  "cotton_money" REAL NOT NULL DEFAULT 0.00,
  "supply_price" REAL NOT NULL DEFAULT 0.00,
  "after_sale_price" REAL NOT NULL DEFAULT 0.00,
  "supplier_after_sale_price" REAL NOT NULL DEFAULT 0.00,
  "partner_after_sale_price" REAL NOT NULL DEFAULT 0.00,
  "pack_bear_price" REAL NOT NULL DEFAULT 0.00,
  "express_bear_price" REAL NOT NULL DEFAULT 0.00,
  "supplier_punish" REAL NOT NULL DEFAULT 0.00,
  "take_xm_coin" REAL NOT NULL DEFAULT 0.00,
  "take_xm_coin_return" REAL NOT NULL DEFAULT 0.00,
  "total_income" REAL NOT NULL DEFAULT 0.00,
  "all_refund_express_price" REAL NOT NULL DEFAULT 0.00,
  "all_express_fill" REAL NOT NULL DEFAULT 0.00,
  "total_station_fee" REAL NOT NULL DEFAULT 0.00,
  "purchaser_num" INTEGER NOT NULL DEFAULT 0,
  "send_num" INTEGER NOT NULL DEFAULT 0,
  "order_num" INTEGER NOT NULL DEFAULT 0,
  "item_num" INTEGER NOT NULL DEFAULT 0,
  "base_item_count" INTEGER NOT NULL DEFAULT 0,
  "total_weight" REAL NOT NULL DEFAULT 0.00,
  "flash_sale_discount_in" REAL NOT NULL DEFAULT 0.00,
  "flash_sale_discount_out" REAL NOT NULL DEFAULT 0.00,
  "platform_coupon_price" REAL NOT NULL DEFAULT 0.00,
  "coupon_price" REAL NOT NULL DEFAULT 0.00,
  "platform_reduce_price" REAL NOT NULL DEFAULT 0.00,
  "complain_return_money" REAL NOT NULL DEFAULT 0.00,
  "extra_service_fee" REAL NOT NULL DEFAULT 0.00,
  "quality_price" REAL NOT NULL DEFAULT 0.00,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("yyyy_mm_dd", "partner_id")
);
CREATE TABLE IF NOT EXISTS "partner_logistics_config" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "config_id" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "sort_num" INTEGER NOT NULL DEFAULT 0,
  "is_enable" INTEGER NOT NULL DEFAULT 1,
  "status" INTEGER NOT NULL DEFAULT 1,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "partner_logistics_region_price" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "province_id" INTEGER NOT NULL DEFAULT 0,
  "province_name" TEXT NOT NULL DEFAULT '',
  "city_id" INTEGER NOT NULL DEFAULT 0,
  "city_name" TEXT NOT NULL DEFAULT '',
  "district_id" INTEGER NOT NULL DEFAULT 0,
  "district_name" TEXT NOT NULL DEFAULT '',
  "adcode" TEXT NOT NULL DEFAULT '',
  "express_id" INTEGER NOT NULL DEFAULT 0,
  "express_add_price" REAL NOT NULL DEFAULT 0.00,
  "express_add_price_data" TEXT,
  "express_add_price_merge" INTEGER NOT NULL DEFAULT 1,
  "default_flag" INTEGER NOT NULL DEFAULT 0,
  "self_pick_flag" INTEGER NOT NULL DEFAULT 0,
  "cotton_switch" INTEGER NOT NULL DEFAULT 0,
  "region_switch" INTEGER NOT NULL DEFAULT 1,
  "cotton_num" INTEGER NOT NULL DEFAULT 0,
  "start_weight_flag" INTEGER NOT NULL DEFAULT 0,
  "start_sell_weight" REAL NOT NULL DEFAULT 6.00,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "partner_promoter" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "commission_ratio" REAL NOT NULL DEFAULT 0.000,
  "sale_flag" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "partner_supplier" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "add_price_flag" INTEGER NOT NULL DEFAULT 1,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("partner_id", "supplier_id")
);
CREATE TABLE IF NOT EXISTS "partner_template" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "app_id" TEXT NOT NULL DEFAULT '',
  "category_show_type" INTEGER NOT NULL DEFAULT 0,
  "template_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("app_id")
);
CREATE TABLE IF NOT EXISTS "partner_user" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "nickname" TEXT NOT NULL DEFAULT '',
  "is_sub" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("user_id", "partner_id")
);
CREATE TABLE IF NOT EXISTS "partner_warehouse_bind" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "start_sell_weight" REAL NOT NULL DEFAULT 0.00,
  "status" INTEGER NOT NULL DEFAULT 0,
  "shipping_area_initialized" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "large_customer_pack_flag" INTEGER NOT NULL DEFAULT 0,
  "large_customer_pack_weight" REAL NOT NULL DEFAULT 6.00,
  "merge_delivery_flag" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("partner_id", "ware_id")
);
CREATE TABLE IF NOT EXISTS "partner_warehouse_shipping_area" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "area" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "phone_black" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "phone" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("phone")
);
CREATE TABLE IF NOT EXISTS "pic_category" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "pid" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "type" INTEGER NOT NULL DEFAULT 1,
  "sort_num" INTEGER NOT NULL DEFAULT 0,
  "show_flag" INTEGER NOT NULL DEFAULT 1,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "pic_category_backup" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "pid" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "type" INTEGER NOT NULL DEFAULT 1,
  "sort_num" INTEGER NOT NULL DEFAULT 0,
  "show_flag" INTEGER NOT NULL DEFAULT 1,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "pic_config" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "views_threshold" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "pic_count_update_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "target_type" INTEGER NOT NULL DEFAULT 0,
  "target_id" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "change_description" TEXT NOT NULL DEFAULT '',
  "created_at" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "pic_florist_apply" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "nickname" TEXT NOT NULL DEFAULT '',
  "telephone" TEXT NOT NULL DEFAULT '',
  "age" INTEGER NOT NULL DEFAULT 0,
  "sex" TEXT NOT NULL DEFAULT '',
  "wx_id" TEXT NOT NULL DEFAULT '',
  "apply_status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "pic_follow" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "follower_id" INTEGER NOT NULL DEFAULT 0,
  "followed_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("follower_id", "followed_id")
);
CREATE TABLE IF NOT EXISTS "pic_follow_count" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "follow_count" INTEGER NOT NULL DEFAULT 0,
  "followed_count" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("user_id")
);
CREATE TABLE IF NOT EXISTS "pic_home_page" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "show_type" INTEGER NOT NULL DEFAULT 0,
  "router_type" INTEGER NOT NULL DEFAULT 0,
  "title" TEXT NOT NULL DEFAULT '',
  "image" TEXT NOT NULL DEFAULT '',
  "url" TEXT NOT NULL DEFAULT '',
  "sort_num" INTEGER NOT NULL DEFAULT 0,
  "show_flag" INTEGER NOT NULL DEFAULT 1,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "pic_lib" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "category_id" INTEGER NOT NULL DEFAULT 0,
  "group_id" INTEGER DEFAULT 0,
  "user_id" INTEGER DEFAULT 0,
  "title" TEXT NOT NULL DEFAULT '',
  "description" TEXT,
  "cover_url" TEXT NOT NULL DEFAULT '',
  "image_urls" TEXT NOT NULL DEFAULT '',
  "view_count" INTEGER NOT NULL DEFAULT 0,
  "collection_count" INTEGER NOT NULL DEFAULT 0,
  "comment_count" INTEGER NOT NULL DEFAULT 0,
  "like_count" INTEGER NOT NULL DEFAULT 0,
  "share_count" INTEGER NOT NULL DEFAULT 0,
  "download_count" INTEGER NOT NULL DEFAULT 0,
  "hot_flag" INTEGER NOT NULL DEFAULT 0,
  "top_flag" INTEGER NOT NULL DEFAULT 0,
  "recommend_flag" INTEGER NOT NULL DEFAULT 0,
  "notify_flag" INTEGER NOT NULL DEFAULT 1,
  "sort_num" INTEGER NOT NULL DEFAULT 1,
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "version" INTEGER NOT NULL DEFAULT 1,
  "created_at" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "updated_at" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "content_updated_at" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "status" INTEGER NOT NULL DEFAULT 1,
  "reason" TEXT NOT NULL DEFAULT '',
  "reviewer_id" INTEGER NOT NULL DEFAULT 0,
  "reviewer_name" TEXT NOT NULL DEFAULT '',
  "review_time" TEXT DEFAULT NULL
);
CREATE TABLE IF NOT EXISTS "pic_lib_category_map" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "pic_id" INTEGER NOT NULL DEFAULT 0,
  "category_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("pic_id", "category_id")
);
CREATE TABLE IF NOT EXISTS "pic_lib_category_map_backup" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "pic_id" INTEGER NOT NULL DEFAULT 0,
  "category_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("pic_id", "category_id")
);
CREATE TABLE IF NOT EXISTS "pic_lib_group" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "group_name" TEXT NOT NULL DEFAULT '',
  "group_cover" TEXT NOT NULL DEFAULT '',
  "group_sort" INTEGER NOT NULL DEFAULT 1,
  "group_show" INTEGER NOT NULL DEFAULT 1,
  "last_bind_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "pic_my_page" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "show_type" INTEGER NOT NULL DEFAULT 0,
  "router_type" INTEGER NOT NULL DEFAULT 0,
  "title" TEXT NOT NULL DEFAULT '',
  "my_comment" INTEGER NOT NULL DEFAULT 0,
  "my_follow" INTEGER NOT NULL DEFAULT 0,
  "my_like" INTEGER NOT NULL DEFAULT 0,
  "my_star" INTEGER NOT NULL DEFAULT 0,
  "image" TEXT NOT NULL DEFAULT '',
  "url" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "pic_operation_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "target_type" INTEGER NOT NULL DEFAULT 0,
  "target_id" INTEGER NOT NULL DEFAULT 0,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "user_name" TEXT NOT NULL DEFAULT '',
  "content" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "pic_review_record" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "review_type" INTEGER NOT NULL DEFAULT 0,
  "review_id" INTEGER NOT NULL DEFAULT 0,
  "review_image" TEXT NOT NULL DEFAULT '',
  "reason" TEXT NOT NULL DEFAULT '',
  "review_status" INTEGER NOT NULL DEFAULT 0,
  "reviewer_id" INTEGER NOT NULL DEFAULT 0,
  "reviewer_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "review_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "pic_search_record" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "target_type" INTEGER NOT NULL DEFAULT 0,
  "target_id" INTEGER NOT NULL DEFAULT 0,
  "context" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("user_id", "context")
);
CREATE TABLE IF NOT EXISTS "pic_user" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" TEXT NOT NULL DEFAULT '',
  "nickname" TEXT NOT NULL DEFAULT '',
  "phone_number" TEXT NOT NULL DEFAULT '',
  "avatar" TEXT NOT NULL DEFAULT '',
  "image" TEXT NOT NULL DEFAULT '',
  "background" TEXT NOT NULL DEFAULT '',
  "introduction" TEXT NOT NULL DEFAULT '',
  "lib_groups" TEXT NOT NULL DEFAULT '',
  "follows" INTEGER NOT NULL DEFAULT 0,
  "status_show" INTEGER NOT NULL DEFAULT 1,
  "status_display" INTEGER NOT NULL DEFAULT 1,
  "status" INTEGER NOT NULL DEFAULT 1,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "identity" INTEGER NOT NULL DEFAULT 1
);
CREATE TABLE IF NOT EXISTS "pic_user_information" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "recipient_id" INTEGER NOT NULL DEFAULT 0,
  "content" TEXT NOT NULL DEFAULT '',
  "sender_id" INTEGER NOT NULL DEFAULT 0,
  "target_type" INTEGER NOT NULL DEFAULT 0,
  "target_id" INTEGER NOT NULL DEFAULT 0,
  "status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "point_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "type" INTEGER NOT NULL DEFAULT 0,
  "platform" INTEGER NOT NULL DEFAULT 0,
  "point" INTEGER NOT NULL DEFAULT 0,
  "remaining_point" INTEGER NOT NULL DEFAULT 0,
  "source_type" INTEGER NOT NULL DEFAULT 0,
  "order_sn" TEXT DEFAULT NULL,
  "expire_time" TEXT NOT NULL DEFAULT '',
  "is_expired" INTEGER NOT NULL DEFAULT 0,
  "remark" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "point_mall_category" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "point_mall_exchange_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "cost_point" INTEGER DEFAULT 0,
  "left_point" INTEGER DEFAULT 0,
  "product_id" INTEGER DEFAULT 0,
  "name" TEXT DEFAULT '',
  "exchange_count" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "point_mall_order" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "platform" INTEGER NOT NULL DEFAULT 1,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "coupon_no" TEXT NOT NULL DEFAULT '',
  "name" TEXT NOT NULL DEFAULT '',
  "price" INTEGER NOT NULL DEFAULT 0,
  "pic" TEXT NOT NULL DEFAULT '',
  "num" INTEGER NOT NULL DEFAULT 0,
  "order_status" INTEGER NOT NULL DEFAULT 1,
  "express_no" TEXT NOT NULL DEFAULT '',
  "receive_name" TEXT DEFAULT '',
  "receive_address" TEXT DEFAULT '',
  "receive_tel" TEXT DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("order_sn")
);
CREATE TABLE IF NOT EXISTS "point_mall_product" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "platform" INTEGER NOT NULL DEFAULT 1,
  "category_id" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "description" TEXT NOT NULL DEFAULT '',
  "price" INTEGER NOT NULL DEFAULT 1,
  "pic" TEXT NOT NULL DEFAULT '',
  "remain_stock" INTEGER NOT NULL DEFAULT 0,
  "limit_type" INTEGER NOT NULL DEFAULT 0,
  "limit_exchange" INTEGER NOT NULL DEFAULT 0,
  "coupon_no" TEXT NOT NULL DEFAULT '',
  "product_status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "pop_search_config" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "type" INTEGER NOT NULL DEFAULT 0,
  "content" TEXT NOT NULL DEFAULT '',
  "sort_num" INTEGER NOT NULL DEFAULT 0,
  "status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "post_follow" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "follower_id" INTEGER NOT NULL DEFAULT 0,
  "followed_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("follower_id", "followed_id")
);
CREATE TABLE IF NOT EXISTS "post_lib" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "user_identity" INTEGER NOT NULL DEFAULT 2,
  "topic_id" INTEGER NOT NULL DEFAULT 0,
  "title" TEXT NOT NULL DEFAULT '',
  "description" TEXT,
  "cover_url" TEXT NOT NULL DEFAULT '',
  "image_urls" TEXT NOT NULL DEFAULT '',
  "view_count" INTEGER NOT NULL DEFAULT 0,
  "collection_count" INTEGER NOT NULL DEFAULT 0,
  "comment_count" INTEGER NOT NULL DEFAULT 0,
  "like_count" INTEGER NOT NULL DEFAULT 0,
  "share_count" INTEGER NOT NULL DEFAULT 0,
  "status" INTEGER NOT NULL DEFAULT 2,
  "top_flag" INTEGER NOT NULL DEFAULT 0,
  "hot_flag" INTEGER NOT NULL DEFAULT 0,
  "recommend_flag" INTEGER NOT NULL DEFAULT 0,
  "notify_flag" INTEGER NOT NULL DEFAULT 1,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "version" INTEGER NOT NULL DEFAULT 1,
  "created_at" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "updated_at" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "reason" TEXT DEFAULT NULL,
  "reviewer_id" INTEGER DEFAULT NULL,
  "reviewer_name" TEXT DEFAULT NULL,
  "review_time" TEXT DEFAULT NULL
);
CREATE TABLE IF NOT EXISTS "product_display_scores" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "hidden_score" REAL NOT NULL DEFAULT 0.00,
  "display_score" REAL NOT NULL DEFAULT 0.00,
  "comment_count" INTEGER NOT NULL DEFAULT 0,
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "product_punish_record" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "punish_type" INTEGER NOT NULL DEFAULT 0,
  "punish_reason" TEXT NOT NULL DEFAULT '',
  "punish_start" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "punish_end" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT ''
);
CREATE TABLE IF NOT EXISTS "province_area" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "province" TEXT NOT NULL DEFAULT '',
  "adcode" TEXT NOT NULL DEFAULT '',
  "area_type" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "fhh_area_type" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("province")
);
CREATE TABLE IF NOT EXISTS "purchase_statistics" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "round_no" TEXT NOT NULL DEFAULT '',
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "today_item_num" INTEGER NOT NULL DEFAULT 0,
  "today_subsidy_num" INTEGER NOT NULL DEFAULT 0,
  "three_item_num" INTEGER NOT NULL DEFAULT 0,
  "three_subsidy_num" INTEGER NOT NULL DEFAULT 0,
  "seven_item_num" INTEGER NOT NULL DEFAULT 0,
  "seven_subsidy_num" INTEGER NOT NULL DEFAULT 0,
  "fourteen_item_num" INTEGER NOT NULL DEFAULT 0,
  "fourteen_subsidy_num" INTEGER NOT NULL DEFAULT 0,
  "thirty_item_num" INTEGER NOT NULL DEFAULT 0,
  "thirty_subsidy_num" INTEGER NOT NULL DEFAULT 0,
  "today_user_tag" TEXT NOT NULL DEFAULT '',
  "today_user_tag_record" TEXT,
  "thirty_user_tag" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("round_no", "purchaser_id")
);
CREATE TABLE IF NOT EXISTS "purchaser_area_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "province" TEXT NOT NULL DEFAULT '',
  "city" TEXT NOT NULL DEFAULT '',
  "area_type" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "purchaser_bill" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "balance" REAL NOT NULL DEFAULT 0.00,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("purchaser_id")
);
CREATE TABLE IF NOT EXISTS "purchaser_bill_detail" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "type" INTEGER NOT NULL DEFAULT 0,
  "old_money" REAL NOT NULL DEFAULT 0.00,
  "amount" REAL NOT NULL DEFAULT 0.00,
  "new_money" REAL NOT NULL DEFAULT 0.00,
  "remark" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "purchaser_extra_info" (
  "id" INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY ("id")
);
CREATE TABLE IF NOT EXISTS "purchaser_mail" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "title" TEXT NOT NULL DEFAULT '',
  "content" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "coupon_no" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "purchaser_recall_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "recall_time" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "purchaser_use_recall_record" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "last_use_time" TEXT DEFAULT NULL,
  "last_recall_time" TEXT DEFAULT NULL,
  "app_id" TEXT NOT NULL DEFAULT '',
  UNIQUE ("purchaser_id")
);
CREATE TABLE IF NOT EXISTS "qixi_lottery_chance" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "round_no" TEXT NOT NULL DEFAULT '',
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "free_total" INTEGER NOT NULL DEFAULT 1,
  "free_used" INTEGER NOT NULL DEFAULT 0,
  "order_total" INTEGER NOT NULL DEFAULT 0,
  "order_used" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("round_no", "purchaser_id")
);
CREATE TABLE IF NOT EXISTS "qixi_lottery_prize_display" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "display_index" INTEGER NOT NULL DEFAULT 0,
  "prize_code" INTEGER NOT NULL DEFAULT 0,
  "display_name" TEXT NOT NULL DEFAULT '',
  "prize_name" TEXT NOT NULL DEFAULT '',
  "is_max" INTEGER NOT NULL DEFAULT 0,
  "prize_type" INTEGER NOT NULL DEFAULT 0,
  "point_value" INTEGER NOT NULL DEFAULT 0,
  "coupon_no" TEXT NOT NULL DEFAULT '',
  "image_url" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("display_index")
);
CREATE TABLE IF NOT EXISTS "qixi_lottery_probability" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "vip_level" INTEGER NOT NULL DEFAULT 0,
  "prize_code" INTEGER NOT NULL DEFAULT 0,
  "weight" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("vip_level", "prize_code")
);
CREATE TABLE IF NOT EXISTS "qixi_lottery_record" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "request_no" TEXT NOT NULL DEFAULT '',
  "round_no" TEXT NOT NULL DEFAULT '',
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "vip_level" INTEGER NOT NULL DEFAULT 0,
  "status" INTEGER NOT NULL DEFAULT 0,
  "original_prize_code" INTEGER NOT NULL DEFAULT 0,
  "actual_prize_code" INTEGER NOT NULL DEFAULT 0,
  "prize_name" TEXT NOT NULL DEFAULT '',
  "coupon_no" TEXT NOT NULL DEFAULT '',
  "point" INTEGER NOT NULL DEFAULT 0,
  "chance_type" INTEGER NOT NULL DEFAULT 0,
  "display_user_name" TEXT NOT NULL DEFAULT '',
  "failure_reason" TEXT NOT NULL DEFAULT '',
  "award_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("request_no")
);
CREATE TABLE IF NOT EXISTS "quick_ordering_item" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "platform" INTEGER NOT NULL DEFAULT 0,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "spec" TEXT NOT NULL DEFAULT '',
  "spec_num" INTEGER NOT NULL DEFAULT 0,
  "remain_stock" INTEGER NOT NULL DEFAULT 0,
  "preference" INTEGER NOT NULL DEFAULT 0,
  "rank_num" INTEGER NOT NULL DEFAULT 0,
  "pic_url" TEXT NOT NULL DEFAULT '',
  "avg_price" REAL NOT NULL DEFAULT 0.00,
  "num" INTEGER NOT NULL DEFAULT 0,
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "quick_ordering_list" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "platform" INTEGER NOT NULL DEFAULT 0,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "item_list_str" TEXT NOT NULL DEFAULT '',
  "total_kind" INTEGER NOT NULL DEFAULT 0,
  "total_num" INTEGER NOT NULL DEFAULT 0,
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "red_packet_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "user_tag" TEXT NOT NULL DEFAULT '',
  "amount" REAL NOT NULL DEFAULT 0.00,
  "time_period" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "refund_complain" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "pid" INTEGER NOT NULL DEFAULT 0,
  "refund_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "saas_admin" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "account_name" TEXT NOT NULL DEFAULT '',
  "account_type" INTEGER NOT NULL DEFAULT 0,
  "platform" INTEGER NOT NULL DEFAULT 1,
  "real_name" TEXT NOT NULL DEFAULT '',
  "phone" TEXT NOT NULL DEFAULT '',
  "salt" TEXT NOT NULL DEFAULT '',
  "password" TEXT NOT NULL DEFAULT '',
  "openid" TEXT NOT NULL DEFAULT '',
  "authorizer_app_id" TEXT DEFAULT '',
  "authorizer_app_name" TEXT DEFAULT '',
  "category" INTEGER NOT NULL DEFAULT 0,
  "auth_time" INTEGER DEFAULT 0,
  "xm_admin_id" INTEGER NOT NULL DEFAULT 0,
  "applyment_status" INTEGER DEFAULT 4,
  "weapp_status" INTEGER NOT NULL DEFAULT 1,
  "xm_authorization" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT DEFAULT NULL,
  "data_status" INTEGER DEFAULT 0,
  UNIQUE ("account_name"),
  UNIQUE ("phone")
);
CREATE TABLE IF NOT EXISTS "saas_app" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL DEFAULT '',
  "category" INTEGER NOT NULL DEFAULT 0,
  "admin_id" INTEGER NOT NULL DEFAULT 0,
  "app_id" TEXT NOT NULL DEFAULT '',
  "merchant_id" TEXT DEFAULT NULL,
  "channel_id" INTEGER DEFAULT 0,
  "com_id" INTEGER DEFAULT 0,
  "nickname" TEXT NOT NULL DEFAULT '',
  "template_id" INTEGER NOT NULL DEFAULT 0,
  "avatar" TEXT NOT NULL DEFAULT '',
  "phone" TEXT NOT NULL DEFAULT '',
  "wechat" TEXT NOT NULL DEFAULT '',
  "notice" TEXT NOT NULL DEFAULT '',
  "address" TEXT NOT NULL DEFAULT '',
  "is_template" INTEGER DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("template_id", "name")
);
CREATE TABLE IF NOT EXISTS "saas_app_audit" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "app_id" TEXT NOT NULL DEFAULT '',
  "name" TEXT NOT NULL DEFAULT '',
  "audit_id" TEXT NOT NULL DEFAULT '',
  "audit_status" INTEGER NOT NULL DEFAULT 0,
  "audit_result" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "update_time" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT ''
);
CREATE TABLE IF NOT EXISTS "saas_app_pay" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "app_id" TEXT DEFAULT NULL,
  "app_secret" TEXT DEFAULT NULL,
  "mch_id" TEXT DEFAULT NULL,
  "mch_key" TEXT DEFAULT NULL
);
CREATE TABLE IF NOT EXISTS "saas_bank" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "bank_code" TEXT DEFAULT '',
  "bank" TEXT NOT NULL DEFAULT ''
);
CREATE TABLE IF NOT EXISTS "saas_merchant_progress" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "admin_id" INTEGER NOT NULL DEFAULT 0,
  "shop_id" INTEGER NOT NULL DEFAULT 0,
  "app_id" TEXT NOT NULL DEFAULT '',
  "app_status" INTEGER NOT NULL DEFAULT 0,
  "is_set_signature" INTEGER NOT NULL DEFAULT 0,
  "is_set_name" INTEGER NOT NULL DEFAULT 0,
  "is_set_head_url" INTEGER NOT NULL DEFAULT 0,
  "merchant_name" TEXT NOT NULL DEFAULT '',
  "applyment_status" INTEGER NOT NULL DEFAULT 0,
  "bind_assistant" INTEGER NOT NULL DEFAULT 0,
  "app_online" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("app_id")
);
CREATE TABLE IF NOT EXISTS "saas_region" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "adcode" TEXT NOT NULL DEFAULT '',
  "area" TEXT NOT NULL DEFAULT ''
);
CREATE TABLE IF NOT EXISTS "saas_tester" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "app_id" TEXT NOT NULL DEFAULT '',
  "app_name" TEXT NOT NULL DEFAULT '',
  "wechat_id" TEXT NOT NULL DEFAULT '',
  "userstr" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "saas_user_legal_info" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "code" TEXT NOT NULL DEFAULT '',
  "code_type" INTEGER NOT NULL DEFAULT 0,
  "legal_persona_wechat" TEXT NOT NULL DEFAULT '',
  "legal_persona_name" TEXT NOT NULL DEFAULT '',
  "component_phone" TEXT DEFAULT '',
  "qualifications" TEXT,
  "data_status" INTEGER DEFAULT 0,
  "create_time" TEXT DEFAULT NULL,
  "update_time" TEXT DEFAULT NULL
);
CREATE TABLE IF NOT EXISTS "saas_user_register_info" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "admin_id" INTEGER NOT NULL DEFAULT 0,
  "info" TEXT,
  "create_time" TEXT DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "sale_agency_downgrade" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "agency_order_id" TEXT NOT NULL DEFAULT '',
  "pic_url" TEXT NOT NULL DEFAULT '',
  "item_list" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "sale_agency_item" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "agency_plan_order" TEXT NOT NULL DEFAULT '',
  "agency_order_id" TEXT NOT NULL DEFAULT '',
  "plan_item_id" INTEGER NOT NULL DEFAULT 0,
  "round_no" TEXT NOT NULL DEFAULT '',
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "sale_num" INTEGER NOT NULL DEFAULT 0,
  "sale_rank_num" INTEGER NOT NULL DEFAULT 0,
  "sale_price" REAL NOT NULL DEFAULT 0.00,
  "sku_config" TEXT NOT NULL DEFAULT '',
  "transfer_stock_num" INTEGER NOT NULL DEFAULT 0,
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "stock_num" INTEGER NOT NULL DEFAULT 0,
  "warehouse_num" INTEGER NOT NULL DEFAULT 0,
  "outbound_num" INTEGER NOT NULL DEFAULT 0,
  "refund_num" INTEGER NOT NULL DEFAULT 0,
  "loss_num" INTEGER NOT NULL DEFAULT 0,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "detail_status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "sale_agency_item_detail" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "agency_plan_order" TEXT NOT NULL DEFAULT '',
  "agency_order_id" TEXT NOT NULL DEFAULT '',
  "agency_item_id" INTEGER NOT NULL DEFAULT 0,
  "sort" INTEGER NOT NULL DEFAULT 0,
  "barcode" TEXT DEFAULT NULL,
  "origin_price" REAL NOT NULL DEFAULT 0.00,
  "origin_rank_num" INTEGER NOT NULL DEFAULT 0,
  "origin_sku_config" TEXT NOT NULL DEFAULT '',
  "onsale_rank_num" INTEGER NOT NULL DEFAULT 0,
  "onsale_sku_config" TEXT NOT NULL DEFAULT '',
  "sale_price" REAL NOT NULL DEFAULT 0.00,
  "status" INTEGER NOT NULL DEFAULT 0,
  "apply_status" INTEGER NOT NULL DEFAULT 0,
  "report_loss_id" INTEGER NOT NULL DEFAULT 0,
  "compensation_per" INTEGER NOT NULL DEFAULT 0,
  "rate_id" INTEGER NOT NULL DEFAULT 0,
  "rate_name" TEXT NOT NULL DEFAULT '',
  "inbound_id" INTEGER NOT NULL DEFAULT 0,
  "inbound_name" TEXT NOT NULL DEFAULT '',
  "inbound_time" TEXT DEFAULT NULL,
  "outbound_id" INTEGER NOT NULL DEFAULT 0,
  "outbound_name" TEXT NOT NULL DEFAULT '',
  "outbound_time" TEXT DEFAULT NULL,
  "outbound_type" INTEGER NOT NULL DEFAULT 0,
  "draw_ratio" REAL NOT NULL DEFAULT 0.000,
  "round_no" TEXT NOT NULL DEFAULT '',
  "shelf_sn" TEXT NOT NULL DEFAULT '',
  "sub_shelf_sn" TEXT NOT NULL DEFAULT '',
  "zone" TEXT NOT NULL DEFAULT '',
  "shelf" TEXT NOT NULL DEFAULT '',
  "zone_shelf" TEXT NOT NULL DEFAULT '',
  "enter_item_id" INTEGER NOT NULL DEFAULT 0,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "code_content" TEXT DEFAULT NULL,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "sale_supplier_id" INTEGER NOT NULL DEFAULT 10003,
  "supplier_name" TEXT DEFAULT NULL,
  "inspection_user_id" INTEGER NOT NULL DEFAULT 0,
  "inspection_user_name" TEXT DEFAULT NULL,
  "inspection_zone_shelf" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "sale_agency_item_detail_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "item_detail_id" INTEGER NOT NULL DEFAULT 0,
  "agency_plan_order" TEXT NOT NULL DEFAULT '',
  "agency_order_id" TEXT NOT NULL DEFAULT '',
  "op_type" INTEGER NOT NULL DEFAULT 0,
  "old_rank" INTEGER NOT NULL DEFAULT 0,
  "new_rank" INTEGER NOT NULL DEFAULT 0,
  "detail" TEXT NOT NULL DEFAULT '',
  "pic" TEXT,
  "operate_id" INTEGER NOT NULL DEFAULT 0,
  "operate_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "sale_agency_night_sale_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "operator_type" INTEGER NOT NULL DEFAULT 0,
  "night_sale_flag" INTEGER NOT NULL DEFAULT 0,
  "remark" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "sale_agency_on_sale_price" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "sku_price" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "update_online" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("second_id")
);
CREATE TABLE IF NOT EXISTS "sale_agency_order" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "agency_plan_order" TEXT NOT NULL DEFAULT '',
  "agency_order_id" TEXT NOT NULL DEFAULT '',
  "plan_item_id" INTEGER NOT NULL DEFAULT 0,
  "round_no" TEXT NOT NULL DEFAULT '',
  "type" INTEGER NOT NULL DEFAULT 0,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "status" INTEGER NOT NULL DEFAULT 0,
  "refund_status" INTEGER NOT NULL DEFAULT 0,
  "refuse_price" REAL NOT NULL DEFAULT 0.00,
  "refund_reason" TEXT DEFAULT NULL,
  "refund_url" TEXT NOT NULL DEFAULT '',
  "freight" REAL NOT NULL DEFAULT 0,
  "freight_flag" INTEGER NOT NULL DEFAULT 1,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT DEFAULT (datetime('now','+8 hours')),
  "cancel_time" TEXT DEFAULT NULL,
  "rate_time" TEXT DEFAULT NULL,
  "zone_shelf" TEXT NOT NULL DEFAULT '',
  "sub_shelf_sn" TEXT NOT NULL DEFAULT '',
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "user_name" TEXT NOT NULL DEFAULT '',
  "settle_flag" INTEGER DEFAULT NULL,
  UNIQUE ("agency_order_id")
);
CREATE TABLE IF NOT EXISTS "sale_agency_order_sku_price_record" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "agency_plan_order" TEXT NOT NULL DEFAULT '',
  "agency_order_id" TEXT NOT NULL DEFAULT '',
  "plan_item_id" INTEGER NOT NULL DEFAULT 0,
  "sku_price" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "sale_agency_permission" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "reason" TEXT NOT NULL DEFAULT '',
  "review_id" INTEGER NOT NULL DEFAULT 0,
  "review_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "apply_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "review_time" TEXT DEFAULT NULL,
  "night_sale_flag" INTEGER NOT NULL DEFAULT 1,
  "operator_type" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 1,
  "operator_name" TEXT NOT NULL DEFAULT '系统',
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("supplier_id")
);
CREATE TABLE IF NOT EXISTS "sale_agency_plan" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "round_no" TEXT NOT NULL DEFAULT '',
  "agency_plan_order" TEXT NOT NULL DEFAULT '',
  "agency_plan_no" TEXT NOT NULL DEFAULT '',
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "second_name" TEXT NOT NULL DEFAULT '',
  "release_id" INTEGER NOT NULL DEFAULT 0,
  "release_name" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "start_time" TEXT NOT NULL DEFAULT '',
  "end_time" TEXT NOT NULL DEFAULT '',
  UNIQUE ("agency_plan_order")
);
CREATE TABLE IF NOT EXISTS "sale_agency_plan_item" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "agency_plan_order" TEXT NOT NULL DEFAULT '',
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "rank_a" INTEGER NOT NULL DEFAULT 0,
  "rank_b" INTEGER NOT NULL DEFAULT 0,
  "rank_c" INTEGER NOT NULL DEFAULT 0,
  "rank_d" INTEGER NOT NULL DEFAULT 0,
  "rank_e" INTEGER NOT NULL DEFAULT 0,
  "rank_o" INTEGER NOT NULL DEFAULT 0,
  "sku_config" TEXT NOT NULL DEFAULT '',
  "num" INTEGER NOT NULL DEFAULT 0,
  "float_ratio" INTEGER NOT NULL DEFAULT 10,
  "limit_num" INTEGER NOT NULL DEFAULT 0,
  "submit_num" INTEGER NOT NULL DEFAULT 0,
  "status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "sale_agency_plan_price" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "version" TEXT NOT NULL DEFAULT '',
  "name" TEXT NOT NULL DEFAULT '',
  "price_a" REAL NOT NULL DEFAULT 0.00,
  "price_b" REAL NOT NULL DEFAULT 0.00,
  "price_c" REAL NOT NULL DEFAULT 0.00,
  "price_d" REAL NOT NULL DEFAULT 0.00,
  "price_e" REAL NOT NULL DEFAULT 0.00,
  "price_o" REAL NOT NULL DEFAULT 0.00,
  "sku_price" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("second_id")
);
CREATE TABLE IF NOT EXISTS "sale_agency_receipt" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "type" INTEGER NOT NULL DEFAULT 0,
  "rank_num" INTEGER NOT NULL DEFAULT 0,
  "sku_config" TEXT NOT NULL DEFAULT '',
  "item_num" INTEGER NOT NULL DEFAULT 0,
  "purchase_price" REAL NOT NULL DEFAULT 0.00,
  "sell_price" REAL NOT NULL DEFAULT 0.00,
  "status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "sale_agency_report_loss" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "agency_order_id" TEXT NOT NULL DEFAULT '',
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "rank_num" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "num" INTEGER NOT NULL DEFAULT 0,
  "status" INTEGER NOT NULL DEFAULT 0,
  "reason" TEXT NOT NULL DEFAULT '',
  "pic_url" TEXT NOT NULL DEFAULT '',
  "price" REAL NOT NULL DEFAULT 0.00,
  "submit_user_id" INTEGER NOT NULL DEFAULT 0,
  "submit_name" TEXT NOT NULL DEFAULT '',
  "apply_time" TEXT DEFAULT NULL,
  "apply_user_id" INTEGER NOT NULL DEFAULT 0,
  "apply_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "sale_agency_statistics" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "date" TEXT DEFAULT NULL,
  "warehouse_list" TEXT,
  "out_of_warehouse_list" TEXT,
  "ab_out_list" TEXT,
  "loss_list" TEXT
);
CREATE TABLE IF NOT EXISTS "sale_agency_stock" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "agency_plan_order" TEXT NOT NULL DEFAULT '',
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "rank_num" INTEGER NOT NULL DEFAULT 0,
  "sku_config" TEXT NOT NULL DEFAULT '',
  "in_num" INTEGER NOT NULL DEFAULT 0,
  "out_num" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "sale_inspection_item" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "enter_item_id" INTEGER NOT NULL DEFAULT 0,
  "round_no" TEXT NOT NULL DEFAULT '',
  "code_content" TEXT NOT NULL DEFAULT '',
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "sale_detail_id" INTEGER NOT NULL DEFAULT 0,
  "agency_order_id" TEXT NOT NULL DEFAULT '',
  "sale_item_id" INTEGER NOT NULL DEFAULT 0,
  "sort" INTEGER NOT NULL DEFAULT 0,
  "level" INTEGER DEFAULT NULL,
  "product_name" TEXT DEFAULT NULL,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "user_name" TEXT DEFAULT NULL,
  "zone" TEXT DEFAULT NULL,
  "zone_shelf" TEXT DEFAULT NULL,
  "sub_shelf_sn" TEXT NOT NULL DEFAULT '',
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT DEFAULT NULL,
  "date_status" INTEGER DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "sale_wms_in_order" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "in_order_sn" TEXT NOT NULL DEFAULT '',
  "in_type" INTEGER NOT NULL DEFAULT 0,
  "round_no" TEXT NOT NULL DEFAULT '',
  "relate_id" INTEGER NOT NULL DEFAULT 0,
  "pre_in_num" INTEGER NOT NULL DEFAULT 0,
  "actual_in_num" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "print_status" INTEGER NOT NULL DEFAULT 0,
  "remark" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "confirm_time" TEXT DEFAULT NULL,
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "sale_wms_in_order_item" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "in_order_sn" TEXT NOT NULL DEFAULT '',
  "in_type" INTEGER NOT NULL DEFAULT 0,
  "round_no" TEXT NOT NULL DEFAULT '',
  "relate_id" INTEGER NOT NULL DEFAULT 0,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "product_name" TEXT NOT NULL DEFAULT '',
  "rank_num" INTEGER NOT NULL DEFAULT 0,
  "sku_config" TEXT NOT NULL DEFAULT '',
  "wms_stock_id" INTEGER NOT NULL DEFAULT 0,
  "sale_supplier_id" INTEGER NOT NULL DEFAULT 0,
  "agency_item_id" INTEGER NOT NULL DEFAULT 0,
  "pre_in_num" INTEGER NOT NULL DEFAULT 0,
  "actual_in_num" INTEGER NOT NULL DEFAULT 0,
  "purchase_price" REAL NOT NULL DEFAULT 0.00,
  "total_amount" REAL NOT NULL DEFAULT 0.00,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "remark" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "confirm_time" TEXT DEFAULT NULL,
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "sale_wms_inventory_check" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "check_sn" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "start_time" TEXT DEFAULT NULL,
  "end_time" TEXT DEFAULT NULL,
  "start_user_id" INTEGER NOT NULL DEFAULT 0,
  "start_user_name" TEXT NOT NULL DEFAULT '',
  "end_user_id" INTEGER NOT NULL DEFAULT 0,
  "end_user_name" TEXT NOT NULL DEFAULT '',
  "total_sys_num" INTEGER NOT NULL DEFAULT 0,
  "total_actual_num" INTEGER NOT NULL DEFAULT 0,
  "total_diff_num" INTEGER NOT NULL DEFAULT 0,
  "remark" TEXT DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("check_sn")
);
CREATE TABLE IF NOT EXISTS "sale_wms_inventory_check_sku_diff" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "check_id" INTEGER NOT NULL DEFAULT 0,
  "check_sn" TEXT NOT NULL DEFAULT '',
  "sale_supplier_id" INTEGER NOT NULL DEFAULT 0,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "product_name" TEXT NOT NULL DEFAULT '',
  "rank_num" INTEGER NOT NULL DEFAULT 0,
  "sku_config" TEXT NOT NULL DEFAULT '',
  "system_num" INTEGER NOT NULL DEFAULT 0,
  "actual_num" INTEGER NOT NULL DEFAULT 0,
  "diff_num" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "remark" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "sale_wms_inventory_check_sku_diff_unit" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "diff_id" INTEGER NOT NULL DEFAULT 0,
  "check_id" INTEGER NOT NULL DEFAULT 0,
  "check_sn" TEXT NOT NULL DEFAULT '',
  "barcode" TEXT NOT NULL DEFAULT '',
  "diff_type" INTEGER NOT NULL DEFAULT 0,
  "sale_supplier_id" INTEGER NOT NULL DEFAULT 0,
  "second_id" INTEGER DEFAULT NULL,
  "rank_num" INTEGER DEFAULT NULL,
  "sku_config" TEXT DEFAULT NULL,
  "status" INTEGER NOT NULL DEFAULT 0,
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "sale_wms_inventory_check_unit_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "check_id" INTEGER NOT NULL DEFAULT 0,
  "check_sn" TEXT NOT NULL DEFAULT '',
  "barcode" TEXT NOT NULL DEFAULT '',
  "sys_in_stock_flag" INTEGER NOT NULL DEFAULT 0,
  "sale_supplier_id" INTEGER NOT NULL DEFAULT 0,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "product_name" TEXT NOT NULL DEFAULT '',
  "rank_num" INTEGER NOT NULL DEFAULT 0,
  "sku_config" TEXT NOT NULL DEFAULT '',
  "wms_stock_id" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "sale_wms_item_unit" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "barcode" TEXT NOT NULL DEFAULT '',
  "in_order_item_id" INTEGER NOT NULL DEFAULT 0,
  "in_order_sn" TEXT NOT NULL DEFAULT '',
  "out_order_item_id" INTEGER NOT NULL DEFAULT 0,
  "out_order_sn" TEXT NOT NULL DEFAULT '',
  "sale_supplier_id" INTEGER NOT NULL DEFAULT 0,
  "wms_stock_id" INTEGER NOT NULL DEFAULT 0,
  "enter_item_id" INTEGER NOT NULL DEFAULT 0,
  "item_detail_id" INTEGER NOT NULL DEFAULT 0,
  "owner_type" INTEGER NOT NULL DEFAULT 1,
  "round_no" TEXT NOT NULL DEFAULT '',
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "product_name" TEXT NOT NULL DEFAULT '',
  "rank_num" INTEGER NOT NULL DEFAULT 0,
  "sku_config" TEXT NOT NULL DEFAULT '',
  "purchase_price" REAL NOT NULL DEFAULT 0.00,
  "sale_price" REAL NOT NULL DEFAULT 0.00,
  "distributer_id" INTEGER NOT NULL DEFAULT 0,
  "distributer_name" TEXT NOT NULL DEFAULT '',
  "distribute_time" TEXT DEFAULT NULL,
  "packer_id" INTEGER NOT NULL DEFAULT 0,
  "packer_name" TEXT NOT NULL DEFAULT '',
  "outbound_time" TEXT DEFAULT NULL,
  "inspect_status" INTEGER NOT NULL DEFAULT 0,
  "inspect_time" TEXT DEFAULT NULL,
  "inspect_user_id" INTEGER NOT NULL DEFAULT 0,
  "inspect_user_name" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "print_status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "sale_wms_out_order" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "out_order_sn" TEXT NOT NULL DEFAULT '',
  "out_type" INTEGER NOT NULL DEFAULT 0,
  "round_no" TEXT NOT NULL DEFAULT '',
  "relate_order_sn" TEXT DEFAULT '',
  "relate_id" INTEGER NOT NULL DEFAULT 0,
  "total_apply_num" INTEGER NOT NULL DEFAULT 0,
  "total_actual_num" INTEGER NOT NULL DEFAULT 0,
  "total_refund_num" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "review_status" INTEGER NOT NULL DEFAULT 0,
  "refund_status" INTEGER NOT NULL DEFAULT 0,
  "remark" TEXT DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "confirm_time" TEXT DEFAULT NULL,
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("out_order_sn")
);
CREATE TABLE IF NOT EXISTS "sale_wms_out_order_item" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "out_order_sn" TEXT NOT NULL DEFAULT '',
  "out_type" INTEGER NOT NULL DEFAULT 0,
  "round_no" TEXT NOT NULL DEFAULT '',
  "out_order_id" INTEGER NOT NULL DEFAULT 0,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "product_name" TEXT NOT NULL DEFAULT '',
  "rank_num" INTEGER NOT NULL DEFAULT 0,
  "sku_config" TEXT NOT NULL DEFAULT '',
  "wms_stock_id" INTEGER NOT NULL DEFAULT 0,
  "relate_item_id" INTEGER NOT NULL DEFAULT 0,
  "sale_supplier_id" INTEGER NOT NULL DEFAULT 0,
  "apply_out_num" INTEGER NOT NULL DEFAULT 0,
  "actual_out_num" INTEGER NOT NULL DEFAULT 0,
  "apply_refund_num" INTEGER NOT NULL DEFAULT 0,
  "actual_refund_num" INTEGER NOT NULL DEFAULT 0,
  "cost_price" REAL NOT NULL DEFAULT 0.00,
  "sale_price" REAL NOT NULL DEFAULT 0.00,
  "relate_pictures" TEXT,
  "relate_video" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "remark" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "confirm_time" TEXT DEFAULT NULL,
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "sale_wms_refund_order" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "refund_sn" TEXT NOT NULL DEFAULT '',
  "source_out_order_sn" TEXT NOT NULL DEFAULT '',
  "refund_type" INTEGER NOT NULL DEFAULT 1,
  "round_no" TEXT NOT NULL DEFAULT '',
  "apply_user_id" INTEGER NOT NULL DEFAULT 0,
  "apply_user_name" TEXT NOT NULL DEFAULT '',
  "reason" TEXT DEFAULT '',
  "relate_pictures" TEXT NOT NULL DEFAULT '',
  "relate_video" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("refund_sn")
);
CREATE TABLE IF NOT EXISTS "sale_wms_restock_account" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "phone" TEXT NOT NULL DEFAULT '',
  "name" TEXT NOT NULL DEFAULT '',
  "area" TEXT NOT NULL DEFAULT '',
  "area_code" TEXT NOT NULL DEFAULT '',
  "region" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("purchaser_id")
);
CREATE TABLE IF NOT EXISTS "sale_wms_restock_plan" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "plan_sn" TEXT NOT NULL DEFAULT '',
  "round_no" TEXT NOT NULL DEFAULT '',
  "serial_no" INTEGER DEFAULT NULL,
  "total_need_num" INTEGER NOT NULL DEFAULT 0,
  "allocated_num" INTEGER NOT NULL DEFAULT 0,
  "prepare_num" INTEGER DEFAULT 0,
  "insufficient_variety_count" INTEGER NOT NULL DEFAULT 0,
  "insufficient_total_num" INTEGER NOT NULL DEFAULT 0,
  "status" INTEGER NOT NULL DEFAULT 1,
  "print_flag" INTEGER NOT NULL DEFAULT 0,
  "out_order_sn" TEXT DEFAULT NULL,
  "restock_strategy" INTEGER NOT NULL DEFAULT 1,
  "submitter_id" INTEGER DEFAULT NULL,
  "submitter_name" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("plan_sn")
);
CREATE TABLE IF NOT EXISTS "sale_wms_restock_plan_item" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "plan_id" INTEGER DEFAULT NULL,
  "parent_id" INTEGER DEFAULT NULL,
  "restock_type" INTEGER DEFAULT NULL,
  "round_no" TEXT NOT NULL DEFAULT '',
  "zone" TEXT NOT NULL DEFAULT '',
  "shelf" TEXT DEFAULT NULL,
  "zone_shelf" TEXT DEFAULT NULL,
  "enter_item_id" INTEGER NOT NULL DEFAULT 0,
  "order_item_id" INTEGER DEFAULT NULL,
  "order_sn" TEXT DEFAULT NULL,
  "summary_id" INTEGER DEFAULT NULL,
  "shelf_sn" INTEGER NOT NULL DEFAULT 1,
  "second_id" INTEGER DEFAULT NULL,
  "product_name" TEXT DEFAULT NULL,
  "need_rank_num" INTEGER DEFAULT NULL,
  "need_sku_config" TEXT DEFAULT NULL,
  "need_num" INTEGER NOT NULL DEFAULT 0,
  "prepare_num" INTEGER DEFAULT 0,
  "allocated_0_num" INTEGER NOT NULL DEFAULT 0,
  "allocated_0_product_id" INTEGER DEFAULT NULL,
  "out_order_item_id_0" INTEGER DEFAULT NULL,
  "allocated_1_num" INTEGER NOT NULL DEFAULT 0,
  "allocated_1_product_id" INTEGER DEFAULT NULL,
  "out_order_item_id_1" INTEGER DEFAULT NULL,
  "allocated_2_num" INTEGER NOT NULL DEFAULT 0,
  "allocated_2_product_id" INTEGER DEFAULT NULL,
  "out_order_item_id_2" INTEGER DEFAULT NULL,
  "status" INTEGER DEFAULT 0,
  "operator_id" INTEGER DEFAULT NULL,
  "operator_name" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "allocated_downgrade_num" INTEGER NOT NULL DEFAULT 0,
  "allocated_downgrade_product_id" INTEGER DEFAULT NULL,
  "out_order_item_id_downgrade" INTEGER DEFAULT NULL
);
CREATE TABLE IF NOT EXISTS "sale_wms_restock_plan_summary" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "round_no" TEXT DEFAULT NULL,
  "zone" TEXT DEFAULT NULL,
  "second_id" INTEGER DEFAULT NULL,
  "need_rank_num" INTEGER DEFAULT NULL,
  "need_sku_config" TEXT DEFAULT NULL,
  "product_name" TEXT DEFAULT NULL,
  "need_num" INTEGER DEFAULT NULL,
  "plan_id" INTEGER DEFAULT NULL,
  "status" INTEGER DEFAULT 0,
  "prepare_num" INTEGER DEFAULT 0,
  "source_supply_price" REAL DEFAULT 0.00,
  "price_gap_too_high" INTEGER DEFAULT 0,
  "allocated_0_num" INTEGER DEFAULT NULL,
  "allocated_0_product_id" INTEGER DEFAULT NULL,
  "allocated_0_supply_price" REAL DEFAULT 0.00,
  "out_order_item_id_0" INTEGER DEFAULT NULL,
  "allocated_1_num" INTEGER DEFAULT NULL,
  "allocated_1_product_id" INTEGER DEFAULT NULL,
  "allocated_1_supply_price" REAL DEFAULT 0.00,
  "out_order_item_id_1" INTEGER DEFAULT NULL,
  "allocated_2_num" INTEGER DEFAULT NULL,
  "allocated_2_product_id" INTEGER DEFAULT NULL,
  "allocated_2_supply_price" REAL DEFAULT 0.00,
  "out_order_item_id_2" INTEGER DEFAULT NULL,
  "operator_id" INTEGER DEFAULT NULL,
  "operator_name" TEXT DEFAULT NULL,
  "data_status" INTEGER DEFAULT 0,
  "create_time" TEXT DEFAULT NULL,
  "update_time" TEXT DEFAULT NULL,
  "allocated_downgrade_num" INTEGER NOT NULL DEFAULT 0,
  "allocated_downgrade_product_id" INTEGER DEFAULT NULL,
  "allocated_downgrade_supply_price" REAL DEFAULT NULL,
  "out_order_item_id_downgrade" INTEGER DEFAULT NULL
);
CREATE TABLE IF NOT EXISTS "sale_wms_restock_plan_zone" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "plan_id" INTEGER DEFAULT NULL,
  "zone" TEXT DEFAULT NULL,
  "data_status" INTEGER DEFAULT 0,
  "create_time" TEXT DEFAULT NULL,
  "update_time" TEXT DEFAULT NULL
);
CREATE TABLE IF NOT EXISTS "sale_wms_restock_relation" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "sub_account_id" INTEGER NOT NULL DEFAULT 0,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("sub_account_id")
);
CREATE TABLE IF NOT EXISTS "sale_wms_stock" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "product_name" TEXT NOT NULL DEFAULT '',
  "rank_num" INTEGER NOT NULL DEFAULT 0,
  "sku_config" TEXT NOT NULL DEFAULT '',
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "sale_supplier_id" INTEGER NOT NULL DEFAULT 0,
  "total_num" INTEGER NOT NULL DEFAULT 0,
  "current_avg_cost" REAL NOT NULL DEFAULT 0.00,
  "total_cost_amount" REAL NOT NULL DEFAULT 0.00,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "search_rank_result" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "round_no" TEXT NOT NULL DEFAULT '',
  "app_id" TEXT NOT NULL DEFAULT '',
  "type" INTEGER NOT NULL DEFAULT 0,
  "content" TEXT NOT NULL DEFAULT '',
  "rank_num" INTEGER NOT NULL DEFAULT 0,
  "search_num" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "second_average_price" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "round_no" TEXT NOT NULL DEFAULT '',
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "average_price" REAL NOT NULL DEFAULT 0.00
);
CREATE TABLE IF NOT EXISTS "second_rank_result" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "round_no" TEXT NOT NULL DEFAULT '',
  "type" INTEGER NOT NULL DEFAULT 0,
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "rank_num" INTEGER NOT NULL DEFAULT 0,
  "sale_num" INTEGER NOT NULL DEFAULT 0,
  "growth_rate" REAL NOT NULL DEFAULT 0.00
);
CREATE TABLE IF NOT EXISTS "spec_config" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "statistics_category_data" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "round_no" TEXT NOT NULL DEFAULT '',
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "rank_num" INTEGER NOT NULL DEFAULT 0,
  "first_id" INTEGER NOT NULL DEFAULT 0,
  "item_num" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("round_no", "rank_num", "second_id")
);
CREATE TABLE IF NOT EXISTS "statistics_city_data" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "round_no" TEXT NOT NULL DEFAULT '',
  "province" TEXT NOT NULL DEFAULT '',
  "city" TEXT NOT NULL DEFAULT '',
  "item_num" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("round_no", "city")
);
CREATE TABLE IF NOT EXISTS "statistics_express_data" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "round_no" TEXT NOT NULL DEFAULT '',
  "config_id" INTEGER NOT NULL DEFAULT 0,
  "item_num" INTEGER NOT NULL DEFAULT 0,
  "express_price" REAL NOT NULL DEFAULT 0.00,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("round_no", "config_id")
);
CREATE TABLE IF NOT EXISTS "statistics_supplier_data" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "round_no" TEXT NOT NULL DEFAULT '',
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "type" INTEGER NOT NULL DEFAULT 1,
  "item_num" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("round_no", "supplier_id")
);
CREATE TABLE IF NOT EXISTS "subsidy_price_city_toggle" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "city_name" TEXT NOT NULL DEFAULT '',
  "show_subsidy" INTEGER NOT NULL DEFAULT 1,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("city_name")
);
CREATE TABLE IF NOT EXISTS "subsidy_strategy" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "strategy_tag" TEXT NOT NULL DEFAULT '',
  "strategy_name" TEXT NOT NULL DEFAULT '',
  "subsidy_ratio" REAL NOT NULL DEFAULT 1.0000,
  UNIQUE ("strategy_tag")
);
CREATE TABLE IF NOT EXISTS "supplier_account_change_type" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "type" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  UNIQUE ("type")
);
CREATE TABLE IF NOT EXISTS "supplier_agency_downgrade" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "agency_order_id" TEXT NOT NULL DEFAULT '',
  "pic_url" TEXT NOT NULL DEFAULT '',
  "item_list" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "supplier_agency_item" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "agency_plan_order" TEXT NOT NULL DEFAULT '',
  "agency_order_id" TEXT NOT NULL DEFAULT '',
  "plan_item_id" INTEGER NOT NULL DEFAULT 0,
  "round_no" TEXT NOT NULL DEFAULT '',
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "sale_num" INTEGER NOT NULL DEFAULT 0,
  "sale_rank_num" INTEGER NOT NULL DEFAULT 0,
  "sale_price" REAL NOT NULL DEFAULT 0.00,
  "sku_config" TEXT NOT NULL DEFAULT '',
  "transfer_stock_num" INTEGER NOT NULL DEFAULT 0,
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "stock_num" INTEGER NOT NULL DEFAULT 0,
  "warehouse_num" INTEGER NOT NULL DEFAULT 0,
  "outbound_num" INTEGER NOT NULL DEFAULT 0,
  "refund_num" INTEGER NOT NULL DEFAULT 0,
  "loss_num" INTEGER NOT NULL DEFAULT 0,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "detail_status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "supplier_agency_item_detail" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "agency_plan_order" TEXT NOT NULL DEFAULT '',
  "agency_order_id" TEXT NOT NULL DEFAULT '',
  "agency_item_id" INTEGER NOT NULL DEFAULT 0,
  "sort" INTEGER NOT NULL DEFAULT 0,
  "origin_price" REAL NOT NULL DEFAULT 0.00,
  "origin_rank_num" INTEGER NOT NULL DEFAULT 0,
  "origin_sku_config" TEXT NOT NULL DEFAULT '',
  "onsale_rank_num" INTEGER NOT NULL DEFAULT 0,
  "onsale_sku_config" TEXT NOT NULL DEFAULT '',
  "sale_price" REAL NOT NULL DEFAULT 0.00,
  "status" INTEGER NOT NULL DEFAULT 0,
  "apply_status" INTEGER NOT NULL DEFAULT 0,
  "report_loss_id" INTEGER NOT NULL DEFAULT 0,
  "compensation_per" INTEGER NOT NULL DEFAULT 0,
  "rate_id" INTEGER NOT NULL DEFAULT 0,
  "rate_name" TEXT NOT NULL DEFAULT '',
  "inbound_id" INTEGER NOT NULL DEFAULT 0,
  "inbound_name" TEXT NOT NULL DEFAULT '',
  "inbound_time" TEXT DEFAULT NULL,
  "outbound_id" INTEGER NOT NULL DEFAULT 0,
  "outbound_name" TEXT NOT NULL DEFAULT '',
  "outbound_time" TEXT DEFAULT NULL,
  "outbound_type" INTEGER NOT NULL DEFAULT 0,
  "draw_ratio" REAL NOT NULL DEFAULT 0.000,
  "round_no" TEXT NOT NULL DEFAULT '',
  "shelf_sn" TEXT NOT NULL DEFAULT '',
  "sub_shelf_sn" TEXT NOT NULL DEFAULT '',
  "zone" TEXT DEFAULT '',
  "shelf" TEXT DEFAULT '',
  "zone_shelf" TEXT DEFAULT '',
  "enter_item_id" INTEGER NOT NULL DEFAULT 0,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "code_content" TEXT NOT NULL DEFAULT '',
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "sale_supplier_id" INTEGER NOT NULL DEFAULT 10003,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "supplier_agency_item_detail_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "item_detail_id" INTEGER NOT NULL DEFAULT 0,
  "agency_plan_order" TEXT NOT NULL DEFAULT '',
  "agency_order_id" TEXT NOT NULL DEFAULT '',
  "op_type" INTEGER NOT NULL DEFAULT 0,
  "old_rank" INTEGER NOT NULL DEFAULT 0,
  "new_rank" INTEGER NOT NULL DEFAULT 0,
  "detail" TEXT NOT NULL DEFAULT '',
  "pic" TEXT NOT NULL DEFAULT '',
  "operate_id" INTEGER NOT NULL DEFAULT 0,
  "operate_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "supplier_agency_order" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "agency_plan_order" TEXT NOT NULL DEFAULT '',
  "agency_order_id" TEXT NOT NULL DEFAULT '',
  "plan_item_id" INTEGER NOT NULL DEFAULT 0,
  "round_no" TEXT NOT NULL DEFAULT '',
  "type" INTEGER NOT NULL DEFAULT 0,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "status" INTEGER NOT NULL DEFAULT 0,
  "refund_status" INTEGER NOT NULL DEFAULT 0,
  "refuse_price" REAL NOT NULL DEFAULT 0.00,
  "refund_reason" TEXT NOT NULL DEFAULT '',
  "refund_url" TEXT NOT NULL DEFAULT '',
  "freight" REAL NOT NULL DEFAULT 0,
  "freight_flag" INTEGER NOT NULL DEFAULT 1,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT DEFAULT (datetime('now','+8 hours')),
  "cancel_time" TEXT DEFAULT NULL,
  "rate_time" TEXT DEFAULT NULL,
  "zone_shelf" TEXT NOT NULL DEFAULT '',
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "user_name" TEXT NOT NULL DEFAULT '',
  "settle_flag" INTEGER DEFAULT 0,
  UNIQUE ("agency_order_id")
);
CREATE TABLE IF NOT EXISTS "supplier_agency_permission" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "reason" TEXT NOT NULL DEFAULT '',
  "review_id" INTEGER NOT NULL DEFAULT 0,
  "review_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "apply_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "review_time" TEXT DEFAULT NULL,
  UNIQUE ("supplier_id")
);
CREATE TABLE IF NOT EXISTS "supplier_agency_plan" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "round_no" TEXT NOT NULL DEFAULT '',
  "agency_plan_order" TEXT NOT NULL DEFAULT '',
  "agency_plan_no" TEXT NOT NULL DEFAULT '',
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "second_name" TEXT NOT NULL DEFAULT '',
  "release_id" INTEGER NOT NULL DEFAULT 0,
  "release_name" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "start_time" TEXT NOT NULL DEFAULT '',
  "end_time" TEXT NOT NULL DEFAULT '',
  UNIQUE ("agency_plan_order")
);
CREATE TABLE IF NOT EXISTS "supplier_agency_plan_item" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "agency_plan_order" TEXT NOT NULL DEFAULT '',
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "rank_num" INTEGER NOT NULL DEFAULT 0,
  "sku_config" TEXT NOT NULL DEFAULT '',
  "num" INTEGER NOT NULL DEFAULT 0,
  "float_ratio" INTEGER NOT NULL DEFAULT 10,
  "limit_num" INTEGER NOT NULL DEFAULT 0,
  "submit_num" INTEGER NOT NULL DEFAULT 0,
  "status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "supplier_agency_report_loss" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "agency_order_id" TEXT NOT NULL DEFAULT '',
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "rank_num" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "num" INTEGER NOT NULL DEFAULT 0,
  "status" INTEGER NOT NULL DEFAULT 0,
  "reason" TEXT NOT NULL DEFAULT '',
  "pic_url" TEXT NOT NULL DEFAULT '',
  "price" REAL NOT NULL DEFAULT 0.00,
  "submit_user_id" INTEGER NOT NULL DEFAULT 0,
  "submit_name" TEXT NOT NULL DEFAULT '',
  "apply_time" TEXT DEFAULT NULL,
  "apply_user_id" INTEGER NOT NULL DEFAULT 0,
  "apply_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "supplier_agency_statistics" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "date" TEXT DEFAULT NULL,
  "warehouse_list" TEXT,
  "out_of_warehouse_list" TEXT,
  "ab_out_list" TEXT,
  "loss_list" TEXT
);
CREATE TABLE IF NOT EXISTS "supplier_agency_stock" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "agency_plan_order" TEXT NOT NULL DEFAULT '',
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "rank_num" INTEGER NOT NULL DEFAULT 0,
  "sku_config" TEXT NOT NULL DEFAULT '',
  "in_num" INTEGER NOT NULL DEFAULT 0,
  "out_num" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "supplier_match_replace_apply" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "start_round_no" TEXT NOT NULL DEFAULT '',
  "end_round_no" TEXT NOT NULL DEFAULT '',
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "day_flag" INTEGER NOT NULL DEFAULT 1,
  "night_flag" INTEGER NOT NULL DEFAULT 1,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "supplier_match_replace_black" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "remark" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("supplier_id")
);
CREATE TABLE IF NOT EXISTS "supplier_match_replace_detail" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "o_id" INTEGER NOT NULL DEFAULT 0,
  "round_no" TEXT NOT NULL DEFAULT '',
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "item_num" INTEGER NOT NULL DEFAULT 0,
  "single_price" REAL NOT NULL DEFAULT 0.00,
  "total_price" REAL NOT NULL DEFAULT 0.00,
  "status" INTEGER NOT NULL DEFAULT 0,
  "day_flag" INTEGER NOT NULL DEFAULT 1,
  "night_flag" INTEGER NOT NULL DEFAULT 1,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "supplier_rank_result" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "round_no" TEXT NOT NULL DEFAULT '',
  "type" INTEGER NOT NULL DEFAULT 0,
  "first_type" INTEGER NOT NULL DEFAULT 0,
  "first_id" INTEGER NOT NULL DEFAULT 0,
  "rank_num" INTEGER NOT NULL DEFAULT 0,
  "sale_num" INTEGER NOT NULL DEFAULT 0,
  "repurchase_num" INTEGER NOT NULL DEFAULT 0,
  "comment_num" INTEGER NOT NULL DEFAULT 0,
  "repurchase_rate" REAL NOT NULL DEFAULT 0.00
);
CREATE TABLE IF NOT EXISTS "sys_popup_config" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL DEFAULT '',
  "type" INTEGER NOT NULL DEFAULT 1,
  "image_url" TEXT NOT NULL DEFAULT '',
  "sort_num" INTEGER NOT NULL DEFAULT 0,
  "show_flag" INTEGER NOT NULL DEFAULT 0,
  "app_id" TEXT NOT NULL DEFAULT '',
  "pop_scene" INTEGER NOT NULL DEFAULT 0,
  "remark" TEXT NOT NULL DEFAULT '',
  "show_type" INTEGER NOT NULL DEFAULT 0,
  "style_type" INTEGER NOT NULL DEFAULT 2,
  "start_time" TEXT DEFAULT NULL,
  "end_time" TEXT DEFAULT NULL,
  "interaction_type" INTEGER NOT NULL DEFAULT 1,
  "jump_url" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "temp_dates" (
  "date" TEXT NOT NULL DEFAULT '',
  PRIMARY KEY ("date")
);
CREATE TABLE IF NOT EXISTS "temp_order" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "order_sn" TEXT NOT NULL DEFAULT '',
  UNIQUE ("order_sn")
);
CREATE TABLE IF NOT EXISTS "tl_account" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "biz_user_id" TEXT NOT NULL DEFAULT '',
  "tl_user_id" TEXT NOT NULL DEFAULT '',
  "config_id" INTEGER NOT NULL DEFAULT 0,
  "ip" TEXT NOT NULL DEFAULT '',
  "member_name" TEXT NOT NULL DEFAULT '',
  "payee_type" INTEGER NOT NULL DEFAULT 0,
  "acctid" TEXT NOT NULL DEFAULT '',
  "bank_name" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "tl_account_apply" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "biz_user_id" TEXT NOT NULL DEFAULT '',
  "tl_user_id" TEXT NOT NULL DEFAULT '',
  "ip" TEXT NOT NULL DEFAULT '',
  "card_photo" TEXT NOT NULL DEFAULT '',
  "card_photo_back" TEXT NOT NULL DEFAULT '',
  "indiv_business_flag" TEXT NOT NULL DEFAULT '',
  "member_name" TEXT NOT NULL DEFAULT '',
  "ref_name" TEXT NOT NULL DEFAULT '',
  "uni_credit" TEXT NOT NULL DEFAULT '',
  "uni_credit_begin_date" TEXT NOT NULL DEFAULT '',
  "uni_credit_end_date" TEXT NOT NULL DEFAULT '',
  "mobile" TEXT NOT NULL DEFAULT '',
  "province_value" TEXT NOT NULL DEFAULT '',
  "city_value" TEXT NOT NULL DEFAULT '',
  "region_value" TEXT NOT NULL DEFAULT '',
  "detail_area_value" TEXT NOT NULL DEFAULT '',
  "scene_no" TEXT NOT NULL DEFAULT '',
  "role_no" TEXT NOT NULL DEFAULT '',
  "profession" TEXT NOT NULL DEFAULT '',
  "acctid" TEXT NOT NULL DEFAULT '',
  "open_bank_ibps" TEXT NOT NULL DEFAULT '',
  "bank_name" TEXT NOT NULL DEFAULT '',
  "withdraw_type" TEXT NOT NULL DEFAULT '',
  "auto_withdrawal_cycle" TEXT NOT NULL DEFAULT '',
  "withdrawal_time" TEXT NOT NULL DEFAULT '',
  "balance" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "file_flag" INTEGER NOT NULL DEFAULT 0,
  "account_flag" INTEGER NOT NULL DEFAULT 0,
  "bind_card_flag" INTEGER NOT NULL DEFAULT 0,
  "auto_withdraw_flag" INTEGER NOT NULL DEFAULT 0,
  "fail_reason" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("supplier_id")
);
CREATE TABLE IF NOT EXISTS "tl_partner_account" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "biz_user_id" TEXT NOT NULL DEFAULT '',
  "tl_user_id" TEXT NOT NULL DEFAULT '',
  "member_name" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("biz_user_id")
);
CREATE TABLE IF NOT EXISTS "tl_transfer" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "record_code" TEXT NOT NULL DEFAULT '',
  "out_biz_no" TEXT NOT NULL DEFAULT '',
  "account_id" INTEGER NOT NULL DEFAULT 0,
  "biz_user_id" TEXT NOT NULL DEFAULT '',
  "tl_user_id" TEXT NOT NULL DEFAULT '',
  "owner_name" TEXT NOT NULL DEFAULT '',
  "payee_type" INTEGER NOT NULL DEFAULT 0,
  "config_id" INTEGER NOT NULL DEFAULT 0,
  "apply_money" REAL NOT NULL DEFAULT 0.00,
  "apply_status" INTEGER NOT NULL DEFAULT 0,
  "withdraw_status" INTEGER NOT NULL DEFAULT 0,
  "pic_url" TEXT,
  "reason" TEXT NOT NULL DEFAULT '',
  "ip" TEXT NOT NULL DEFAULT '',
  "check_time" TEXT DEFAULT NULL,
  "check_user_id" INTEGER NOT NULL DEFAULT 0,
  "check_user_name" TEXT NOT NULL DEFAULT '',
  "success_time" TEXT DEFAULT NULL,
  "transfer_resp" TEXT,
  "query_transfer_resp" TEXT,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("record_code")
);
CREATE TABLE IF NOT EXISTS "tmp_activity_region" (
  "region_id" INTEGER NOT NULL DEFAULT 0,
  "price_data" TEXT,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY ("region_id")
);
CREATE TABLE IF NOT EXISTS "topics" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "title" TEXT NOT NULL DEFAULT '',
  "header_image_url" TEXT NOT NULL DEFAULT '',
  "cover_url" TEXT NOT NULL DEFAULT '',
  "show_flag" INTEGER NOT NULL DEFAULT 1,
  "recommend_flag" INTEGER NOT NULL DEFAULT 0,
  "sort_num" INTEGER NOT NULL DEFAULT 0,
  "views" INTEGER NOT NULL DEFAULT 0,
  "comments" INTEGER NOT NULL DEFAULT 0,
  "likes" INTEGER NOT NULL DEFAULT 0,
  "followers" INTEGER NOT NULL DEFAULT 0,
  "created_at" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "updated_at" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "topics_comment" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "topic_id" INTEGER NOT NULL DEFAULT 0,
  "commenter_id" INTEGER NOT NULL DEFAULT 0,
  "commenter_name" TEXT NOT NULL DEFAULT '',
  "comment_content" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "topics_follow" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "follow_id" INTEGER NOT NULL DEFAULT 0,
  "topic_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("follow_id", "topic_id")
);
CREATE TABLE IF NOT EXISTS "topics_like" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "like_id" INTEGER NOT NULL DEFAULT 0,
  "topic_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "tp_ctx_carrier" (
  "code" TEXT NOT NULL DEFAULT '',
  "carrier_id" INTEGER NOT NULL DEFAULT 0,
  "config_id_orig" INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY ("code")
);
CREATE TABLE IF NOT EXISTS "tp_ctx_region" (
  "code" TEXT NOT NULL DEFAULT '',
  "region_id" INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY ("code")
);
CREATE TABLE IF NOT EXISTS "transport_station_flower_input" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "round_no" TEXT NOT NULL DEFAULT '',
  "station_id" INTEGER DEFAULT NULL,
  "station_name" TEXT NOT NULL DEFAULT '',
  "area_id" INTEGER DEFAULT NULL,
  "area_name" TEXT NOT NULL DEFAULT '',
  "first_id" INTEGER DEFAULT NULL,
  "first_class" TEXT NOT NULL DEFAULT '',
  "second_id" INTEGER DEFAULT NULL,
  "second_class" TEXT NOT NULL DEFAULT '',
  "rank_num" TEXT NOT NULL DEFAULT '',
  "qty" INTEGER NOT NULL DEFAULT 0,
  "frame_tag" TEXT NOT NULL DEFAULT '',
  "warehouse" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "untitled_table_307" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "old_money" REAL NOT NULL DEFAULT 0.00,
  "money" REAL NOT NULL DEFAULT 0.00,
  "new_money" REAL NOT NULL DEFAULT 0.00
);
CREATE TABLE IF NOT EXISTS "user_comment" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "target_id" INTEGER NOT NULL DEFAULT 0,
  "parent_id" INTEGER NOT NULL DEFAULT 0,
  "root_id" INTEGER NOT NULL DEFAULT 0,
  "target_type" INTEGER NOT NULL DEFAULT 0,
  "content" TEXT NOT NULL DEFAULT '',
  "like_count" INTEGER NOT NULL DEFAULT 0,
  "version" INTEGER NOT NULL DEFAULT 1,
  "created_at" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "updated_at" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "target_deleted" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "user_coupon_save_amount" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "user_name" TEXT NOT NULL DEFAULT '',
  "save_amount" REAL NOT NULL DEFAULT 0.00,
  UNIQUE ("user_id")
);
CREATE TABLE IF NOT EXISTS "user_down" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "target_id" INTEGER NOT NULL DEFAULT 0,
  "target_type" INTEGER NOT NULL DEFAULT 0,
  "created_at" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "user_like" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "target_id" INTEGER NOT NULL DEFAULT 0,
  "target_type" INTEGER NOT NULL DEFAULT 0,
  "created_at" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("user_id", "target_id", "target_type")
);
CREATE TABLE IF NOT EXISTS "user_share" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "target_id" INTEGER NOT NULL DEFAULT 0,
  "target_type" INTEGER NOT NULL DEFAULT 0,
  "created_at" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "user_star" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "target_id" INTEGER NOT NULL DEFAULT 0,
  "target_type" INTEGER NOT NULL DEFAULT 0,
  "created_at" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("user_id", "target_id", "target_type")
);
CREATE TABLE IF NOT EXISTS "user_view" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "target_id" INTEGER NOT NULL DEFAULT 0,
  "target_type" INTEGER NOT NULL DEFAULT 0,
  "view_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "view_date" TEXT NOT NULL DEFAULT '',
  UNIQUE ("user_id", "target_id", "target_type", "view_date")
);
CREATE TABLE IF NOT EXISTS "ware_blacklist_supplier" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "reason" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("ware_id", "supplier_id")
);
CREATE TABLE IF NOT EXISTS "ware_partner_update_record" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "content" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "warehouse_operation_logs" (
  "log_id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "zone_id" INTEGER NOT NULL DEFAULT 0,
  "op_type" TEXT DEFAULT NULL,
  "details" TEXT,
  "operator" TEXT DEFAULT NULL,
  "created_at" TEXT DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "wms_after_sale_punish_review" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "refund_id" INTEGER NOT NULL DEFAULT 0,
  "order_item_id" INTEGER NOT NULL DEFAULT 0,
  "wms_punish_id" INTEGER DEFAULT NULL,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "duty_type" INTEGER NOT NULL DEFAULT 0,
  "after_sale_handle_time" TEXT NOT NULL DEFAULT '',
  "round_no" TEXT NOT NULL DEFAULT '',
  "zone" TEXT NOT NULL DEFAULT '',
  "shelf" TEXT NOT NULL DEFAULT '',
  "zone_shelf" TEXT NOT NULL DEFAULT '',
  "area_manager_id" INTEGER NOT NULL DEFAULT 0,
  "area_manager_name" TEXT NOT NULL DEFAULT '',
  "channel" INTEGER NOT NULL DEFAULT 0,
  "channel_name" TEXT NOT NULL DEFAULT '',
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "ware_name" TEXT NOT NULL DEFAULT '',
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "partner_name" TEXT NOT NULL DEFAULT '',
  "area_type" INTEGER NOT NULL DEFAULT 0,
  "province" TEXT NOT NULL DEFAULT '',
  "city" TEXT NOT NULL DEFAULT '',
  "platform_bear_price" REAL NOT NULL DEFAULT 0.00,
  "duty_user_id" INTEGER NOT NULL DEFAULT 0,
  "duty_user_name" TEXT NOT NULL DEFAULT '',
  "duty_user_role" INTEGER NOT NULL DEFAULT 0,
  "punish_price" REAL NOT NULL DEFAULT 0.00,
  "punish_remark" TEXT NOT NULL DEFAULT '',
  "pic_url" TEXT NOT NULL DEFAULT '',
  "punish_pic_url" TEXT NOT NULL DEFAULT '',
  "review_status" INTEGER NOT NULL DEFAULT 0,
  "review_user_id" INTEGER NOT NULL DEFAULT 0,
  "review_user_name" TEXT NOT NULL DEFAULT '',
  "review_time" TEXT DEFAULT NULL,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("refund_id", "duty_type")
);
CREATE TABLE IF NOT EXISTS "wms_after_sale_punish_review_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "review_id" INTEGER NOT NULL DEFAULT 0,
  "action_content" TEXT NOT NULL DEFAULT '',
  "content" TEXT,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "wms_check_item_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "code_content" TEXT DEFAULT NULL,
  "date" TEXT DEFAULT NULL,
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "sub_shelf_sn" TEXT DEFAULT NULL,
  "zone" TEXT NOT NULL DEFAULT '',
  "shelf" TEXT NOT NULL DEFAULT '',
  "zone_shelf" TEXT NOT NULL DEFAULT '',
  "order_item_id" INTEGER NOT NULL DEFAULT 0,
  "enter_item_id" INTEGER NOT NULL DEFAULT 0,
  "plan_item_id" INTEGER DEFAULT NULL,
  "restock_seq_no" INTEGER NOT NULL DEFAULT 0,
  "need_rank_num" INTEGER NOT NULL DEFAULT 0,
  "allocated_rank_num" INTEGER NOT NULL DEFAULT 0,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "restock_supplier_id" INTEGER NOT NULL DEFAULT 0,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "user_name" TEXT NOT NULL DEFAULT '',
  "phone" TEXT DEFAULT '',
  "op" INTEGER NOT NULL DEFAULT 0,
  "sub_op" INTEGER NOT NULL DEFAULT 0,
  "cold_flag" INTEGER NOT NULL DEFAULT 0,
  "op_type" INTEGER NOT NULL DEFAULT 0,
  "confirm_status" INTEGER NOT NULL DEFAULT 0,
  "re_qualify_user_id" INTEGER NOT NULL DEFAULT 0,
  "re_qualify_user_name" TEXT NOT NULL DEFAULT '',
  "remark" TEXT DEFAULT NULL,
  "pictures" TEXT,
  "video" TEXT,
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "allow_downgrade_restock" INTEGER NOT NULL DEFAULT 0,
  "restock_prepared" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("code_content")
);
CREATE TABLE IF NOT EXISTS "wms_entry_inventory" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "part" TEXT NOT NULL DEFAULT '',
  "team_id" INTEGER NOT NULL DEFAULT 0,
  "team_name" TEXT NOT NULL DEFAULT '',
  "sku_type" INTEGER NOT NULL DEFAULT 0,
  "sku_id" INTEGER NOT NULL DEFAULT 0,
  "sku_name" TEXT NOT NULL DEFAULT '',
  "specification" TEXT NOT NULL DEFAULT '',
  "brand" TEXT NOT NULL DEFAULT '',
  "invoice_info" TEXT NOT NULL DEFAULT '',
  "reason_type" INTEGER NOT NULL DEFAULT 0,
  "source_apply_id" INTEGER DEFAULT NULL,
  "purchase_reason" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "in_inventory" INTEGER NOT NULL DEFAULT 0,
  "remain_inventory" INTEGER NOT NULL DEFAULT 0,
  "unit_name" TEXT NOT NULL DEFAULT '个',
  "device_number" INTEGER NOT NULL DEFAULT 0,
  "lease_subject" TEXT NOT NULL DEFAULT '',
  "lessor" TEXT NOT NULL DEFAULT '',
  "contract_info" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "wms_entry_inventory_trace" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "part" TEXT NOT NULL DEFAULT '',
  "team_id" INTEGER DEFAULT NULL,
  "team_name" TEXT NOT NULL DEFAULT '',
  "sku_type" INTEGER NOT NULL DEFAULT 0,
  "sku_id" INTEGER NOT NULL DEFAULT 0,
  "sku_name" TEXT NOT NULL DEFAULT '',
  "specification" TEXT NOT NULL DEFAULT '',
  "brand" TEXT NOT NULL DEFAULT '',
  "trace_class" INTEGER NOT NULL DEFAULT 0,
  "trace_sub_class" INTEGER NOT NULL DEFAULT 0,
  "quantity_change" INTEGER NOT NULL DEFAULT 0,
  "unit_name" TEXT NOT NULL DEFAULT '个',
  "recipient" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "invoice_info" TEXT NOT NULL DEFAULT '',
  "reason_type" INTEGER NOT NULL DEFAULT 0,
  "outbound_reason" INTEGER NOT NULL DEFAULT 0,
  "outbound_failed" INTEGER NOT NULL DEFAULT 0,
  "failure_message" TEXT NOT NULL DEFAULT '',
  "purchase_reason" TEXT NOT NULL DEFAULT '',
  "device_number" INTEGER NOT NULL DEFAULT 0,
  "lease_subject" TEXT NOT NULL DEFAULT '',
  "lessor" TEXT NOT NULL DEFAULT '',
  "contract_info" TEXT NOT NULL DEFAULT '',
  "shelf" TEXT NOT NULL DEFAULT '',
  "related_order" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "wms_inventory_check" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "sku_id" INTEGER NOT NULL DEFAULT 0,
  "category" INTEGER NOT NULL DEFAULT 0,
  "sku_type" INTEGER NOT NULL DEFAULT 0,
  "sku_name" TEXT NOT NULL DEFAULT '',
  "specification" TEXT NOT NULL DEFAULT '',
  "brand" TEXT NOT NULL DEFAULT '',
  "unit_name" TEXT NOT NULL DEFAULT '',
  "voucher_urls" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "wms_inventory_check_detail" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "check_id" INTEGER NOT NULL DEFAULT 0,
  "sku_id" INTEGER NOT NULL DEFAULT 0,
  "part" TEXT NOT NULL DEFAULT '',
  "team_id" INTEGER NOT NULL DEFAULT 0,
  "team_name" TEXT NOT NULL DEFAULT '',
  "period_no" INTEGER NOT NULL DEFAULT 0,
  "actual_quantity" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("sku_id", "part", "period_no")
);
CREATE TABLE IF NOT EXISTS "wms_inventory_relation" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "trace_id" INTEGER NOT NULL DEFAULT 0,
  "entry_id" INTEGER NOT NULL DEFAULT 0,
  "quantity" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "wms_material_apply" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "apply_no" TEXT NOT NULL DEFAULT '',
  "team_id" INTEGER NOT NULL DEFAULT 0,
  "team_name" TEXT NOT NULL DEFAULT '',
  "sku_id" INTEGER NOT NULL DEFAULT 0,
  "sku_name" TEXT NOT NULL DEFAULT '',
  "specification" TEXT NOT NULL DEFAULT '',
  "unit_name" TEXT NOT NULL DEFAULT '',
  "apply_quantity" INTEGER NOT NULL DEFAULT 0,
  "issued_quantity" INTEGER DEFAULT NULL,
  "voucher_info" TEXT NOT NULL DEFAULT '[]',
  "remark" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 10,
  "reject_reason" TEXT NOT NULL DEFAULT '',
  "applicant_id" INTEGER NOT NULL DEFAULT 0,
  "applicant_name" TEXT NOT NULL DEFAULT '',
  "auditor_id" INTEGER DEFAULT NULL,
  "auditor_name" TEXT NOT NULL DEFAULT '',
  "audit_time" TEXT DEFAULT NULL,
  "cancel_time" TEXT DEFAULT NULL,
  "entry_id" INTEGER DEFAULT NULL,
  "trace_id" INTEGER DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("apply_no")
);
CREATE TABLE IF NOT EXISTS "wms_operation_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "sku_id" INTEGER NOT NULL DEFAULT 0,
  "entry_id" INTEGER NOT NULL DEFAULT 0,
  "trace_id" INTEGER NOT NULL DEFAULT 0,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "user_name" TEXT NOT NULL DEFAULT '',
  "content" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "wms_prepare_record" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "date" TEXT NOT NULL DEFAULT '',
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "sub_shelf_sn" TEXT NOT NULL DEFAULT '',
  "zone" TEXT DEFAULT '',
  "shelf" TEXT DEFAULT '',
  "zone_shelf" TEXT DEFAULT '',
  "enter_item_id" INTEGER NOT NULL DEFAULT 0,
  "delivery_income" REAL NOT NULL DEFAULT 0.00,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "user_name" TEXT NOT NULL DEFAULT '',
  "op" INTEGER NOT NULL DEFAULT 0,
  "op_type" INTEGER NOT NULL DEFAULT 0,
  "num" INTEGER NOT NULL DEFAULT 0,
  "role_type" INTEGER NOT NULL DEFAULT 0,
  "remark" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "wms_punish" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "type" INTEGER NOT NULL DEFAULT 0,
  "punish_source" INTEGER NOT NULL DEFAULT 0,
  "duty_user_id" INTEGER NOT NULL DEFAULT 0,
  "duty_user_role" INTEGER NOT NULL DEFAULT 0,
  "duty_user_name" TEXT NOT NULL DEFAULT '',
  "punish_role_type" INTEGER NOT NULL DEFAULT 0,
  "area_manager_id" INTEGER NOT NULL DEFAULT 0,
  "area_manager_name" TEXT NOT NULL DEFAULT '',
  "order_sn" TEXT NOT NULL DEFAULT '',
  "date" TEXT NOT NULL DEFAULT '',
  "zone" TEXT NOT NULL DEFAULT '',
  "shelf" TEXT NOT NULL DEFAULT '',
  "zone_shelf" TEXT NOT NULL DEFAULT '',
  "sub_shelf_sn" TEXT NOT NULL DEFAULT '',
  "shelf_detail" TEXT,
  "punish_reason" TEXT NOT NULL DEFAULT '',
  "punish_remark" TEXT NOT NULL DEFAULT '',
  "punish_price" REAL NOT NULL DEFAULT 0.00,
  "punish_status" INTEGER NOT NULL DEFAULT 0,
  "pic_url" TEXT,
  "after_sale_pic_url" TEXT NOT NULL DEFAULT '',
  "appeal_status" INTEGER NOT NULL DEFAULT 0,
  "appeal_count" INTEGER NOT NULL DEFAULT 0,
  "reject_reason" TEXT NOT NULL DEFAULT '',
  "reject_pic" TEXT DEFAULT NULL,
  "appeal_pic" TEXT NOT NULL DEFAULT '',
  "appeal_content" TEXT NOT NULL DEFAULT '',
  "appeal_time" TEXT DEFAULT NULL,
  "supplier_punish_id" INTEGER NOT NULL DEFAULT 0,
  "relation_id" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "refund_id" INTEGER NOT NULL DEFAULT 0,
  "order_item_id" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "wms_sku_inventory" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "part" TEXT NOT NULL DEFAULT '',
  "category" INTEGER NOT NULL DEFAULT 0,
  "sku_type" INTEGER NOT NULL DEFAULT 0,
  "sku_name" TEXT NOT NULL DEFAULT '',
  "specification" TEXT NOT NULL DEFAULT '',
  "brand" TEXT NOT NULL DEFAULT '',
  "entry_stock" INTEGER NOT NULL DEFAULT 0,
  "unit" TEXT NOT NULL DEFAULT '',
  "status_bind" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "wms_sku_mapping" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "sku_id" INTEGER NOT NULL DEFAULT 0,
  "business_type" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("sku_id")
);
CREATE TABLE IF NOT EXISTS "wms_stock_operation_failure_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "type" INTEGER NOT NULL DEFAULT 0,
  "num" INTEGER NOT NULL DEFAULT 0,
  "part" TEXT NOT NULL DEFAULT '0',
  "wms_sku_id" INTEGER DEFAULT NULL,
  "request_json" TEXT,
  "error_msg" TEXT DEFAULT NULL,
  "remark" TEXT DEFAULT NULL,
  "operator_id" INTEGER DEFAULT NULL,
  "operator_name" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "wx_b2b_order" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "mch_id" TEXT NOT NULL DEFAULT '',
  "order_sn" TEXT NOT NULL DEFAULT '',
  "out_trade_no" TEXT NOT NULL DEFAULT '',
  "order_id" TEXT NOT NULL DEFAULT '',
  "refund_id" TEXT NOT NULL DEFAULT '',
  "out_refund_no" TEXT NOT NULL DEFAULT '',
  "refund_status" TEXT NOT NULL DEFAULT '',
  "refund_desc" TEXT NOT NULL DEFAULT '',
  "order_amount" INTEGER NOT NULL DEFAULT 0,
  "refund_amount" INTEGER NOT NULL DEFAULT 0,
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("out_trade_no", "refund_id")
);
CREATE TABLE IF NOT EXISTS "wx_b2b_order_info" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "open_id" TEXT NOT NULL DEFAULT '',
  "app_id" TEXT NOT NULL DEFAULT '',
  "mch_id" TEXT NOT NULL DEFAULT '',
  "out_trade_no" TEXT NOT NULL DEFAULT '',
  "order_sn" TEXT NOT NULL DEFAULT '',
  "order_id" TEXT NOT NULL DEFAULT '',
  "pay_time" TEXT DEFAULT NULL,
  "wxpay_transaction_id" TEXT NOT NULL DEFAULT '',
  "send_status" INTEGER NOT NULL DEFAULT 0,
  "data_status" INTEGER DEFAULT 0,
  "create_time" TEXT DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "wx_customer_group" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "contact_id" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "link" TEXT NOT NULL DEFAULT '',
  "open_kfid" TEXT NOT NULL DEFAULT '',
  "scene" TEXT NOT NULL DEFAULT '',
  "scene_link" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "area_type" INTEGER NOT NULL DEFAULT 0,
  "phone" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_base_data" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "round_no" TEXT NOT NULL DEFAULT '',
  "name" TEXT DEFAULT NULL,
  "sale" INTEGER DEFAULT 0,
  "onsale" INTEGER DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_actual_price" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "send_no" TEXT NOT NULL DEFAULT '',
  "zone_shelf" TEXT NOT NULL DEFAULT '',
  "expend_express_price" REAL NOT NULL DEFAULT 0.00,
  "status" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("send_no")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_after_sale" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "nickname" TEXT NOT NULL DEFAULT '',
  "order_sn" TEXT NOT NULL DEFAULT '',
  "pay_type" INTEGER NOT NULL DEFAULT 0,
  "type" INTEGER NOT NULL DEFAULT 0,
  "expect_amount" REAL NOT NULL DEFAULT 0.00,
  "amount" REAL NOT NULL DEFAULT 0.00,
  "pictures" TEXT,
  "videos" TEXT,
  "more_pictures" TEXT,
  "reason_type" INTEGER NOT NULL DEFAULT 0,
  "comment" TEXT NOT NULL DEFAULT '',
  "after_sale_status" INTEGER NOT NULL DEFAULT 0,
  "after_sale_agree_type" INTEGER NOT NULL DEFAULT 0,
  "refund_status" INTEGER NOT NULL DEFAULT 0,
  "remark" TEXT NOT NULL DEFAULT '',
  "wx_refund_id" TEXT NOT NULL DEFAULT '',
  "wx_refund_channel" TEXT NOT NULL DEFAULT '',
  "wx_refund_success_time" TEXT NOT NULL DEFAULT '',
  "handle_time" TEXT DEFAULT NULL,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_after_sale_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "after_sale_id" INTEGER NOT NULL DEFAULT 0,
  "user_type" INTEGER NOT NULL DEFAULT 0,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "user_name" TEXT NOT NULL DEFAULT '',
  "item_id" INTEGER NOT NULL DEFAULT 0,
  "after_sale_status" INTEGER NOT NULL DEFAULT 0,
  "content" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_after_sale_priority" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "channel" INTEGER NOT NULL DEFAULT 0,
  "priority_num" INTEGER NOT NULL DEFAULT 0,
  "levels" TEXT NOT NULL DEFAULT '',
  "sla_minutes" INTEGER DEFAULT NULL,
  "operator_id" INTEGER DEFAULT NULL,
  "operator_name" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("channel", "priority_num")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_after_sale_staff" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "channel" INTEGER NOT NULL DEFAULT 0,
  "area_type" INTEGER DEFAULT NULL,
  "staff_level" INTEGER NOT NULL DEFAULT 0,
  "handle_levels" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER DEFAULT NULL,
  "operator_name" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("user_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_agency_cart" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "is_hour_delivery" INTEGER NOT NULL DEFAULT 0,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "platform" INTEGER NOT NULL DEFAULT 0,
  "is_sale_agency" INTEGER NOT NULL DEFAULT 0,
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "product_name" TEXT NOT NULL DEFAULT '',
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT DEFAULT NULL,
  "pic_url" TEXT NOT NULL DEFAULT '',
  "in_price" REAL NOT NULL DEFAULT 0,
  "buy_count" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT DEFAULT NULL,
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_agency_order" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "vip_name" TEXT NOT NULL DEFAULT '',
  "order_sn" TEXT NOT NULL DEFAULT '',
  "order_type" INTEGER NOT NULL DEFAULT 0,
  "delivery_type" INTEGER NOT NULL DEFAULT 1,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "distribution_type" INTEGER NOT NULL DEFAULT 0,
  "is_addition" INTEGER NOT NULL DEFAULT 0,
  "platform" INTEGER NOT NULL DEFAULT 0,
  "has_third_good" INTEGER NOT NULL DEFAULT 0,
  "is_zq_settlement" INTEGER NOT NULL DEFAULT 0,
  "send_no" TEXT NOT NULL DEFAULT '',
  "round_no" TEXT NOT NULL DEFAULT '',
  "order_num" INTEGER NOT NULL DEFAULT 1,
  "total_item_num" INTEGER NOT NULL DEFAULT 0,
  "total_weight" INTEGER NOT NULL DEFAULT 0,
  "origin_total_weight" INTEGER NOT NULL DEFAULT 0,
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "sub_shelf_sn" TEXT NOT NULL DEFAULT '',
  "zone" TEXT NOT NULL DEFAULT '',
  "shelf" TEXT NOT NULL DEFAULT '',
  "zone_shelf" TEXT DEFAULT '',
  "express" INTEGER NOT NULL DEFAULT 0,
  "express_region" INTEGER NOT NULL DEFAULT 0,
  "express_time" INTEGER DEFAULT NULL,
  "express_price" REAL NOT NULL DEFAULT 0,
  "real_express_id" INTEGER NOT NULL DEFAULT 0,
  "real_express_region" INTEGER NOT NULL DEFAULT 0,
  "coupon_price" REAL NOT NULL DEFAULT 0.00,
  "origin_coupon_price" REAL NOT NULL DEFAULT 0.00,
  "add_price" REAL NOT NULL DEFAULT 0.00,
  "origin_add_price" REAL NOT NULL DEFAULT 0.00,
  "warehouse_add_price" REAL NOT NULL DEFAULT 0.00,
  "origin_warehouse_add_price" REAL NOT NULL DEFAULT 0.00,
  "express_add_price" REAL NOT NULL DEFAULT 0.00,
  "origin_express_add_price" REAL NOT NULL DEFAULT 0.00,
  "delivery_fee" REAL NOT NULL DEFAULT 0.00,
  "origin_delivery_fee" REAL NOT NULL DEFAULT 0.00,
  "modify_express_price" REAL NOT NULL DEFAULT 0.00,
  "is_change_express" INTEGER NOT NULL DEFAULT 0,
  "actual_express_price" REAL DEFAULT NULL,
  "origin_supply_price" REAL NOT NULL DEFAULT 0.00,
  "product_total_price" REAL NOT NULL DEFAULT 0,
  "origin_product_total_price" REAL NOT NULL DEFAULT 0.00,
  "service_fee" REAL NOT NULL DEFAULT 0.00,
  "origin_service_fee" REAL NOT NULL DEFAULT 0.00,
  "vip_discount_service_fee" REAL NOT NULL DEFAULT 0.00,
  "origin_vip_discount_service_fee" REAL NOT NULL DEFAULT 0.00,
  "platform_discount" REAL NOT NULL DEFAULT 0.00,
  "origin_platform_discount" REAL NOT NULL DEFAULT 0.00,
  "base_service_fee" REAL NOT NULL DEFAULT 0.00,
  "origin_base_service_fee" REAL NOT NULL DEFAULT 0.00,
  "total_price" REAL NOT NULL DEFAULT 0,
  "origin_total_price" REAL NOT NULL DEFAULT 0.00,
  "origin_use_xm_coin" REAL NOT NULL DEFAULT 0.00,
  "use_xm_coin" REAL NOT NULL DEFAULT 0.00,
  "rebate_xm_coin" REAL NOT NULL DEFAULT 0.00,
  "origin_rebate_xm_coin" REAL NOT NULL DEFAULT 0.00,
  "actual_price" REAL NOT NULL DEFAULT 0.00,
  "origin_actual_price" REAL NOT NULL DEFAULT 0.00,
  "apply_price" REAL NOT NULL DEFAULT 0.00,
  "actual_refund" REAL NOT NULL DEFAULT 0.00,
  "actual_coin" REAL NOT NULL DEFAULT 0.00,
  "paid_price" REAL NOT NULL DEFAULT 0.00,
  "paid_coin" REAL NOT NULL DEFAULT 0.00,
  "pay_type" INTEGER NOT NULL DEFAULT 0,
  "pay_on_delivery" INTEGER NOT NULL DEFAULT 0,
  "receive_name" TEXT NOT NULL DEFAULT '',
  "receive_tel" TEXT NOT NULL DEFAULT '',
  "province" TEXT NOT NULL DEFAULT '',
  "city" TEXT NOT NULL DEFAULT '',
  "district" TEXT NOT NULL DEFAULT '',
  "detail" TEXT NOT NULL DEFAULT '',
  "receive_address" TEXT NOT NULL DEFAULT '',
  "adcode" TEXT NOT NULL DEFAULT '',
  "buyer_memo" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "order_status" INTEGER NOT NULL DEFAULT 0,
  "after_sale_status" INTEGER NOT NULL DEFAULT 0,
  "return_status" INTEGER NOT NULL DEFAULT 0,
  "after_sale_agree_type" INTEGER NOT NULL DEFAULT 0,
  "after_sale_count" INTEGER NOT NULL DEFAULT 0,
  "refund_status" INTEGER NOT NULL DEFAULT 0,
  "print_status" INTEGER NOT NULL DEFAULT 0,
  "wx_pay_time" TEXT DEFAULT NULL,
  "wx_pay_id" TEXT NOT NULL DEFAULT '',
  "send_time" TEXT DEFAULT NULL,
  "confirm_time" TEXT DEFAULT NULL,
  "extra_info" TEXT,
  "coupon_user_id" INTEGER NOT NULL DEFAULT 0,
  "is_comment" INTEGER NOT NULL DEFAULT 0,
  "is_open_after_sale" INTEGER NOT NULL DEFAULT 0,
  "is_cotton" INTEGER NOT NULL DEFAULT 0,
  "flag" INTEGER NOT NULL DEFAULT 0,
  "bear_type" INTEGER NOT NULL DEFAULT 0,
  "is_bear_station_fee" INTEGER NOT NULL DEFAULT 0,
  "origin_total_station_fee" REAL NOT NULL DEFAULT 0.00,
  "total_station_fee" REAL NOT NULL DEFAULT 0.00,
  "is_presale" INTEGER NOT NULL DEFAULT 0,
  "is_sale_agency" INTEGER NOT NULL DEFAULT 0,
  "is_hour_delivery" INTEGER NOT NULL DEFAULT 0,
  "order_tag" INTEGER NOT NULL DEFAULT 0,
  "help_id" INTEGER NOT NULL DEFAULT 0,
  "unqualified_way" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "is_deliver" INTEGER DEFAULT NULL,
  "is_bond" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("order_sn")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_agency_order_cancel_record" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "record_type" INTEGER DEFAULT 0,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "refund_purchaser" REAL DEFAULT 0.00,
  "deduct_supplier" REAL DEFAULT 0.00,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_agency_order_edit" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "field" TEXT NOT NULL DEFAULT '',
  "old_data" TEXT NOT NULL DEFAULT '',
  "new_data" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT ''
);
CREATE TABLE IF NOT EXISTS "xm_bulky_agency_order_item" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "order_num" INTEGER NOT NULL DEFAULT 0,
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "sub_shelf_sn" TEXT NOT NULL DEFAULT '',
  "zone" TEXT NOT NULL DEFAULT '',
  "shelf" TEXT NOT NULL DEFAULT '',
  "zone_shelf" TEXT DEFAULT '',
  "order_sn" TEXT NOT NULL DEFAULT '',
  "round_no" TEXT NOT NULL DEFAULT '',
  "supplier_no" TEXT NOT NULL DEFAULT '',
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "product_name" TEXT NOT NULL DEFAULT '',
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "rank_num" INTEGER NOT NULL DEFAULT 1,
  "sku_config" TEXT NOT NULL DEFAULT '',
  "pic_url" TEXT NOT NULL DEFAULT '',
  "spec_and_num" TEXT NOT NULL DEFAULT '',
  "description" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "supply_price" REAL NOT NULL DEFAULT 0.00,
  "pay_price" REAL NOT NULL DEFAULT 0.00,
  "platform_discount_price" REAL NOT NULL DEFAULT 0.00,
  "coupon_pay_price" REAL NOT NULL DEFAULT 0.00,
  "add_price" REAL NOT NULL DEFAULT 0.00,
  "warehouse_add_price" REAL NOT NULL DEFAULT 0.00,
  "express_add_price" REAL NOT NULL DEFAULT 0.00,
  "item_num" INTEGER NOT NULL DEFAULT 0,
  "origin_item_num" INTEGER NOT NULL DEFAULT 0,
  "after_sale_item_num" INTEGER NOT NULL DEFAULT 0,
  "prepare_item_num" INTEGER NOT NULL DEFAULT 0,
  "after_sale_refund" REAL NOT NULL DEFAULT 0.00,
  "bond_item_num" INTEGER NOT NULL DEFAULT 0,
  "after_sale_supplier_num" INTEGER NOT NULL DEFAULT 0,
  "actual_price" REAL NOT NULL DEFAULT 0.00,
  "origin_actual_price" REAL NOT NULL DEFAULT 0.00,
  "total_price" REAL NOT NULL DEFAULT 0.00,
  "origin_total_price" REAL NOT NULL DEFAULT 0.00,
  "total_weight" INTEGER NOT NULL DEFAULT 0,
  "origin_total_weight" INTEGER NOT NULL DEFAULT 0,
  "is_comment" INTEGER NOT NULL DEFAULT 0,
  "after_sale_status" INTEGER NOT NULL DEFAULT 0,
  "refund_status" INTEGER NOT NULL DEFAULT 0,
  "printer_status" INTEGER NOT NULL DEFAULT 0,
  "printer_time" INTEGER DEFAULT 0,
  "is_deliver" INTEGER NOT NULL DEFAULT 0,
  "is_rebate" INTEGER NOT NULL DEFAULT 0,
  "third_good_id" INTEGER NOT NULL DEFAULT 0,
  "deliver_time" TEXT DEFAULT NULL,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_agency_product" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "third_good_id" INTEGER NOT NULL DEFAULT 0,
  "product_type" INTEGER NOT NULL DEFAULT 0,
  "is_sale_agency" INTEGER NOT NULL DEFAULT 0,
  "first_id" INTEGER NOT NULL DEFAULT 0,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "code" TEXT NOT NULL DEFAULT '',
  "name" TEXT NOT NULL DEFAULT '',
  "rank_num" INTEGER NOT NULL DEFAULT 1,
  "sku_config" TEXT NOT NULL DEFAULT '',
  "color" TEXT NOT NULL DEFAULT '',
  "pic_url" TEXT NOT NULL DEFAULT '',
  "detail_pic_url" TEXT NOT NULL DEFAULT '',
  "price" REAL NOT NULL DEFAULT 0.00,
  "description" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "after_sale_times" INTEGER NOT NULL DEFAULT 0,
  "sell_times" INTEGER NOT NULL DEFAULT 0,
  "today_sell_count" INTEGER NOT NULL DEFAULT 0,
  "last_sell_count" INTEGER NOT NULL DEFAULT 0,
  "month_sell_count" INTEGER NOT NULL DEFAULT 0,
  "sell_count" INTEGER NOT NULL DEFAULT 0,
  "max_stock" INTEGER NOT NULL DEFAULT 9999,
  "remain_stock" INTEGER NOT NULL DEFAULT 0,
  "offline_stock" INTEGER NOT NULL DEFAULT 0,
  "offline_switch" INTEGER NOT NULL DEFAULT 0,
  "limit_switch" INTEGER NOT NULL DEFAULT 0,
  "limit_sale" INTEGER NOT NULL DEFAULT 9999,
  "product_status" INTEGER NOT NULL DEFAULT 0,
  "freeze_reason" TEXT NOT NULL DEFAULT '',
  "is_hot" INTEGER NOT NULL DEFAULT 0,
  "on_sale_time_str" TEXT NOT NULL DEFAULT '',
  "not_sale_time_str" TEXT NOT NULL DEFAULT '',
  "is_close_auto" INTEGER NOT NULL DEFAULT 0,
  "is_rebate" INTEGER NOT NULL DEFAULT 1,
  "is_special" INTEGER NOT NULL DEFAULT 1,
  "special_sort" INTEGER NOT NULL DEFAULT 0,
  "is_seckill" INTEGER NOT NULL DEFAULT 1,
  "seckill_add_price" REAL NOT NULL DEFAULT 0.00,
  "platform_discount_price" REAL NOT NULL DEFAULT 0.00,
  "seckill_sort" INTEGER NOT NULL DEFAULT 0,
  "plan_id" INTEGER NOT NULL DEFAULT 0,
  "seckill_deadline" TEXT DEFAULT NULL,
  "is_prefer" INTEGER NOT NULL DEFAULT 0,
  "prefer_time" TEXT DEFAULT NULL,
  "prefer_end_time" TEXT DEFAULT NULL,
  "expire_time" TEXT NOT NULL DEFAULT '',
  "replenish_auto_onsale" INTEGER NOT NULL DEFAULT 0,
  "return_processing" INTEGER NOT NULL DEFAULT 0,
  "sell_prefer" INTEGER NOT NULL DEFAULT 0,
  "auto_sell_prefer" INTEGER NOT NULL DEFAULT 1,
  "seven_sell_count" INTEGER NOT NULL DEFAULT 0,
  "seven_no_lower_rank" INTEGER NOT NULL DEFAULT 0,
  "seven_no_refund" INTEGER NOT NULL DEFAULT 0,
  "seven_no_lack" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "is_presale" INTEGER NOT NULL DEFAULT 0,
  "presale_end_time" TEXT DEFAULT NULL
);
CREATE TABLE IF NOT EXISTS "xm_bulky_agency_product_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "content" TEXT,
  "user_type" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_agency_purchaser" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "zq_user_id" INTEGER NOT NULL DEFAULT 0,
  "platform" INTEGER NOT NULL DEFAULT 0,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "xm_account" TEXT NOT NULL DEFAULT '',
  "company_direct_sale_store" INTEGER NOT NULL DEFAULT 0,
  "company_level" INTEGER NOT NULL DEFAULT 6,
  "xm_coin" REAL NOT NULL DEFAULT 0.00,
  "xm_coin_income" REAL NOT NULL DEFAULT 0.00,
  "xm_coin_expend" REAL NOT NULL DEFAULT 0.00,
  "xm_coin_give" REAL NOT NULL DEFAULT 0.00,
  "xm_coin_rebate" REAL NOT NULL DEFAULT 0.00,
  "xm_coin_paid" REAL NOT NULL DEFAULT 0.00,
  "phone_number" TEXT NOT NULL DEFAULT '',
  "password" TEXT NOT NULL DEFAULT '',
  "salt" TEXT NOT NULL DEFAULT '',
  "open_id" TEXT DEFAULT NULL,
  "zc_open_id" TEXT DEFAULT '',
  "session_key" TEXT DEFAULT NULL,
  "gender" INTEGER DEFAULT NULL,
  "province" TEXT DEFAULT NULL,
  "city" TEXT DEFAULT NULL,
  "country" TEXT DEFAULT NULL,
  "nickname" TEXT DEFAULT NULL,
  "remark" TEXT NOT NULL DEFAULT '',
  "avatar_url" TEXT DEFAULT NULL,
  "help_id" INTEGER NOT NULL DEFAULT 0,
  "last_login_time" TEXT DEFAULT NULL,
  "last_login_ip" TEXT DEFAULT NULL,
  "class_type" INTEGER NOT NULL DEFAULT 1,
  "contact_supplier_count" INTEGER NOT NULL DEFAULT 3,
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "config_id" INTEGER NOT NULL DEFAULT 0,
  "first_buy_time" TEXT NOT NULL DEFAULT '',
  "last_buy_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT DEFAULT NULL
);
CREATE TABLE IF NOT EXISTS "xm_bulky_agency_purchaser_account_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "year" INTEGER NOT NULL DEFAULT 0,
  "month" INTEGER NOT NULL DEFAULT 0,
  "day" INTEGER NOT NULL DEFAULT 0,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "business_type" INTEGER NOT NULL DEFAULT 0,
  "pay_type" INTEGER NOT NULL DEFAULT 0,
  "money" REAL NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT ''
);
CREATE TABLE IF NOT EXISTS "xm_bulky_agency_purchaser_address" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "type" INTEGER DEFAULT 0,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "phone_number" TEXT NOT NULL DEFAULT '',
  "longitude" TEXT NOT NULL DEFAULT '',
  "latitude" TEXT NOT NULL DEFAULT '',
  "province" TEXT NOT NULL DEFAULT '',
  "province_code" TEXT NOT NULL DEFAULT '',
  "city" TEXT NOT NULL DEFAULT '',
  "city_code" TEXT NOT NULL DEFAULT '',
  "country" TEXT NOT NULL DEFAULT '',
  "country_code" TEXT NOT NULL DEFAULT '',
  "address_name" TEXT NOT NULL DEFAULT '',
  "address_detail" TEXT NOT NULL DEFAULT '',
  "detail" TEXT NOT NULL DEFAULT '',
  "is_default" INTEGER NOT NULL DEFAULT 0,
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT DEFAULT NULL
);
CREATE TABLE IF NOT EXISTS "xm_bulky_agency_refund" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_type" INTEGER NOT NULL DEFAULT 0,
  "refund_type" INTEGER NOT NULL DEFAULT 0,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "platform" INTEGER NOT NULL DEFAULT 0,
  "pay_type" INTEGER NOT NULL DEFAULT 0,
  "apply_status" INTEGER NOT NULL DEFAULT 0,
  "apply_money" REAL NOT NULL DEFAULT 0.00,
  "apply_product_price" REAL NOT NULL DEFAULT 0.00,
  "apply_service_fee" REAL NOT NULL DEFAULT 0.00,
  "apply_express_price" REAL NOT NULL DEFAULT 0.00,
  "apply_reason" TEXT NOT NULL DEFAULT '',
  "reason_type" INTEGER NOT NULL DEFAULT 0,
  "pictures" TEXT,
  "videos" TEXT,
  "refund_status" INTEGER NOT NULL DEFAULT 0,
  "wx_refund_id" TEXT NOT NULL DEFAULT '',
  "wx_refund_success_time" TEXT DEFAULT NULL,
  "refund_money" REAL NOT NULL DEFAULT 0.00,
  "refund_product_price" REAL NOT NULL DEFAULT 0.00,
  "refund_service_fee" REAL NOT NULL DEFAULT 0.00,
  "refund_express_price" REAL NOT NULL DEFAULT 0.00,
  "refund_coupon_price" REAL NOT NULL DEFAULT 0.00,
  "refund_vip_discount_service_fee" REAL NOT NULL DEFAULT 0.00,
  "paid_xm_coin" REAL NOT NULL DEFAULT 0.00,
  "bear_platform_discount" REAL NOT NULL DEFAULT 0.00,
  "supplier_bear_price" REAL NOT NULL DEFAULT 0.00,
  "city_warehouse_bear_price" REAL NOT NULL DEFAULT 0.00,
  "remark" TEXT NOT NULL DEFAULT '',
  "flag" INTEGER NOT NULL DEFAULT 0,
  "refund_result" TEXT NOT NULL DEFAULT '',
  "duty_reason" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_date" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_agency_refund_item" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "refund_id" INTEGER NOT NULL DEFAULT 0,
  "refund_type" INTEGER NOT NULL DEFAULT 0,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "order_item_id" INTEGER NOT NULL DEFAULT 0,
  "apply_money" REAL NOT NULL DEFAULT 0.00,
  "apply_num" INTEGER NOT NULL DEFAULT 0,
  "apply_item_sub_num" INTEGER NOT NULL DEFAULT 0,
  "apply_product_price" REAL NOT NULL DEFAULT 0.00,
  "apply_service_fee" REAL NOT NULL DEFAULT 0.00,
  "apply_express_price" REAL NOT NULL DEFAULT 0.00,
  "refund_money" REAL NOT NULL DEFAULT 0.00,
  "refund_product_price" REAL NOT NULL DEFAULT 0.00,
  "refund_service_fee" REAL NOT NULL DEFAULT 0.00,
  "refund_express_price" REAL NOT NULL DEFAULT 0.00,
  "refund_item_num" INTEGER NOT NULL DEFAULT 0,
  "paid_xm_coin" REAL NOT NULL DEFAULT 0.00,
  "supplier_bear_price" REAL NOT NULL DEFAULT 0.00,
  "city_warehouse_bear_price" REAL NOT NULL DEFAULT 0.00,
  "bear_platform_discount" REAL NOT NULL DEFAULT 0.00,
  "apply_status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("refund_id", "order_item_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_agency_refund_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "refund_id" INTEGER NOT NULL DEFAULT 0,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "user_type" INTEGER NOT NULL DEFAULT 0,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "user_name" TEXT NOT NULL DEFAULT '',
  "content" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_agency_supplier_order" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "order_num" INTEGER NOT NULL DEFAULT 1,
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "sub_shelf_sn" TEXT NOT NULL DEFAULT '',
  "is_addition" INTEGER NOT NULL DEFAULT 0,
  "receive_name" TEXT NOT NULL DEFAULT '',
  "receive_tel" TEXT NOT NULL DEFAULT '',
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "supplier_no" TEXT NOT NULL DEFAULT '',
  "delivery_no" TEXT NOT NULL DEFAULT '',
  "round_no" TEXT NOT NULL DEFAULT '',
  "supply_price" REAL NOT NULL DEFAULT 0.00,
  "origin_supply_price" REAL NOT NULL DEFAULT 0.00,
  "actual_price" REAL NOT NULL DEFAULT 0.00,
  "origin_actual_price" REAL NOT NULL DEFAULT 0.00,
  "platform_discount" REAL NOT NULL DEFAULT 0.00,
  "origin_platform_discount" REAL NOT NULL DEFAULT 0.00,
  "take_xm_coin" REAL NOT NULL DEFAULT 0.00,
  "origin_take_xm_coin" REAL NOT NULL DEFAULT 0.00,
  "take_ratio" REAL NOT NULL DEFAULT 0.000,
  "after_sale_supply_price" REAL NOT NULL DEFAULT 0.00,
  "after_sale_price" REAL NOT NULL DEFAULT 0.00,
  "paid_price" REAL NOT NULL DEFAULT 0.00,
  "paid_coin" REAL NOT NULL DEFAULT 0.00,
  "order_status" INTEGER NOT NULL DEFAULT 0,
  "wx_pay_time" TEXT DEFAULT NULL,
  "after_sale_status" INTEGER NOT NULL DEFAULT 0,
  "after_sale_agree_type" INTEGER NOT NULL DEFAULT 0,
  "refund_status" INTEGER NOT NULL DEFAULT 0,
  "sort_status" INTEGER NOT NULL DEFAULT 0,
  "delivery_status" INTEGER NOT NULL DEFAULT 0,
  "is_presale" INTEGER NOT NULL DEFAULT 0,
  "is_deliver" INTEGER NOT NULL DEFAULT 0,
  "is_bear_station_fee" INTEGER NOT NULL DEFAULT 0,
  "station_fee" REAL NOT NULL DEFAULT 0.00,
  "origin_total_station_fee" REAL NOT NULL DEFAULT 0.00,
  "total_station_fee" REAL NOT NULL DEFAULT 0.00,
  "after_sale_coin" TEXT NOT NULL DEFAULT '',
  "is_sale_agency" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "is_bond" INTEGER NOT NULL DEFAULT 0,
  "bond_price" REAL NOT NULL DEFAULT 0.00,
  "bond_paid_price" REAL NOT NULL DEFAULT 0.00,
  "zone" TEXT NOT NULL DEFAULT '',
  "shelf" TEXT NOT NULL DEFAULT '',
  "zone_shelf" TEXT DEFAULT '',
  UNIQUE ("supplier_no")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_agency_tag_product" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "tag_id" INTEGER NOT NULL DEFAULT 0,
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "template_product_id" INTEGER NOT NULL DEFAULT 0,
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_agreement" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "platform_type" INTEGER NOT NULL DEFAULT 0,
  "type" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "content" TEXT,
  "status" INTEGER NOT NULL DEFAULT 0,
  "notify_supplier" INTEGER NOT NULL DEFAULT 0,
  "last_notify_summary" TEXT DEFAULT NULL,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_agreement_update" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "agreement_id" INTEGER NOT NULL DEFAULT 0,
  "update_summary" TEXT NOT NULL DEFAULT '',
  "is_show" INTEGER NOT NULL DEFAULT 1,
  "operator_id" INTEGER DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_allocate_driver" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "user_name" TEXT NOT NULL DEFAULT '',
  "base_config" TEXT NOT NULL DEFAULT '',
  "allocate_user_id" INTEGER NOT NULL DEFAULT 0,
  "allocate_user_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT '',
  UNIQUE ("user_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_allocation_config" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "area_name" TEXT NOT NULL DEFAULT '',
  "start_shelf" INTEGER NOT NULL DEFAULT 0,
  "end_shelf" INTEGER NOT NULL DEFAULT 0,
  "dispatch_id" INTEGER NOT NULL DEFAULT 0,
  "dispatch_id_str" TEXT,
  "pack_id_str" TEXT,
  "sequence" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_api_statistics_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER DEFAULT NULL,
  "type" INTEGER NOT NULL DEFAULT 0,
  "source" INTEGER NOT NULL DEFAULT 0,
  "api_code" INTEGER NOT NULL DEFAULT 0,
  "api_str" TEXT DEFAULT NULL,
  "count" INTEGER NOT NULL DEFAULT 0,
  "date" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT ''
);
CREATE TABLE IF NOT EXISTS "xm_bulky_app" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "app_id" TEXT NOT NULL DEFAULT '',
  "name" TEXT NOT NULL DEFAULT '',
  "mch_no" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("app_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_app_template" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "template_id" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "pic_url" TEXT NOT NULL DEFAULT '',
  "vip_flag" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("template_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_auth_area_permission" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "route_name" TEXT NOT NULL DEFAULT '',
  "area_name" TEXT NOT NULL DEFAULT '',
  "area_desc" TEXT NOT NULL DEFAULT '',
  "dom_type" TEXT DEFAULT NULL,
  "default_value" INTEGER NOT NULL DEFAULT 1,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("route_name", "area_name")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_auth_operation_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "biz_type" TEXT NOT NULL DEFAULT '',
  "biz_id" TEXT NOT NULL DEFAULT '',
  "biz_name" TEXT NOT NULL DEFAULT '',
  "operation_type" TEXT NOT NULL DEFAULT '',
  "operation_desc" TEXT NOT NULL DEFAULT '',
  "before_data" TEXT,
  "after_data" TEXT,
  "result_status" INTEGER NOT NULL DEFAULT 1,
  "fail_reason" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_auth_permission" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "pid" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "perm" TEXT NOT NULL DEFAULT '',
  "can_index" INTEGER NOT NULL DEFAULT 1,
  "important_flag" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("perm")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_auth_position" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "position_name" TEXT NOT NULL DEFAULT '',
  "description" TEXT NOT NULL DEFAULT '',
  "important_flag" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_auth_position_apply" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "target_position_id" INTEGER NOT NULL DEFAULT 0,
  "target_position_name" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "apply_user_id" INTEGER NOT NULL DEFAULT 0,
  "apply_user_name" TEXT NOT NULL DEFAULT '',
  "approve_user_id" INTEGER NOT NULL DEFAULT 0,
  "approve_user_name" TEXT NOT NULL DEFAULT '',
  "reject_reason" TEXT NOT NULL DEFAULT '',
  "apply_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "approve_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_auth_position_apply_user" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "apply_id" INTEGER NOT NULL DEFAULT 0,
  "apply_type" INTEGER NOT NULL DEFAULT 0,
  "user_type" INTEGER NOT NULL DEFAULT 0,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "user_name" TEXT NOT NULL DEFAULT '',
  "nickname" TEXT NOT NULL DEFAULT '',
  "current_position_id" INTEGER DEFAULT NULL,
  "current_position_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("apply_id", "user_type", "user_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_auth_position_role" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "position_id" INTEGER NOT NULL DEFAULT 0,
  "role_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("position_id", "role_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_auth_position_role_apply" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "position_id" INTEGER NOT NULL DEFAULT 0,
  "position_name" TEXT NOT NULL DEFAULT '',
  "before_data" TEXT NOT NULL DEFAULT '',
  "after_data" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "pending_flag" INTEGER DEFAULT NULL,
  "apply_user_id" INTEGER NOT NULL DEFAULT 0,
  "apply_user_name" TEXT NOT NULL DEFAULT '',
  "approve_user_id" INTEGER NOT NULL DEFAULT 0,
  "approve_user_name" TEXT NOT NULL DEFAULT '',
  "reject_reason" TEXT NOT NULL DEFAULT '',
  "apply_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "approve_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("position_id", "pending_flag")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_auth_position_role_apply_detail" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "apply_id" INTEGER NOT NULL DEFAULT 0,
  "role_id" INTEGER NOT NULL DEFAULT 0,
  "role_name" TEXT NOT NULL DEFAULT '',
  "important_flag" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("apply_id", "role_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_auth_role" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "role_name" TEXT NOT NULL DEFAULT '',
  "description" TEXT NOT NULL DEFAULT '',
  "important_flag" INTEGER NOT NULL DEFAULT 0,
  "role_type" INTEGER NOT NULL DEFAULT 0,
  "base_flag" INTEGER NOT NULL DEFAULT 0,
  "area_flag" INTEGER NOT NULL DEFAULT 0,
  "logistics_flag" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_auth_role_area_permission" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "role_id" INTEGER NOT NULL DEFAULT 0,
  "area_permission_id" INTEGER NOT NULL DEFAULT 0,
  "enable" INTEGER NOT NULL DEFAULT 1,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("role_id", "area_permission_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_auth_role_permission" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "role_id" INTEGER NOT NULL DEFAULT 0,
  "permission_tag" TEXT NOT NULL DEFAULT '',
  "permission_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_auth_role_permission_apply" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "role_id" INTEGER NOT NULL DEFAULT 0,
  "role_name" TEXT NOT NULL DEFAULT '',
  "before_data" TEXT NOT NULL DEFAULT '',
  "after_data" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "pending_flag" INTEGER DEFAULT NULL,
  "apply_user_id" INTEGER NOT NULL DEFAULT 0,
  "apply_user_name" TEXT NOT NULL DEFAULT '',
  "approve_user_id" INTEGER NOT NULL DEFAULT 0,
  "approve_user_name" TEXT NOT NULL DEFAULT '',
  "reject_reason" TEXT NOT NULL DEFAULT '',
  "apply_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "approve_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("role_id", "pending_flag")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_auth_role_permission_apply_area" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "apply_detail_id" INTEGER NOT NULL DEFAULT 0,
  "area_permission_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("apply_detail_id", "area_permission_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_auth_role_permission_apply_detail" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "apply_id" INTEGER NOT NULL DEFAULT 0,
  "permission_id" INTEGER NOT NULL DEFAULT 0,
  "permission_name" TEXT NOT NULL DEFAULT '',
  "permission_tag" TEXT NOT NULL DEFAULT '',
  "important_flag" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("apply_id", "permission_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_auth_user_position" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_type" INTEGER NOT NULL DEFAULT 0,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "position_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("user_type", "user_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_auth_user_role" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "role_id" INTEGER NOT NULL DEFAULT 0,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "user_name" TEXT NOT NULL DEFAULT '',
  "nickname" TEXT NOT NULL DEFAULT '',
  "is_sub" INTEGER NOT NULL DEFAULT 0,
  "perm_config" TEXT,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_ban_supplier" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_id" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_bank_account" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "payee_type" INTEGER NOT NULL DEFAULT 1,
  "account_no" TEXT NOT NULL DEFAULT '',
  "owner_name" TEXT NOT NULL DEFAULT '',
  "bank_no" TEXT NOT NULL DEFAULT '',
  "bank_name" TEXT NOT NULL DEFAULT '',
  "account_bank_name" TEXT NOT NULL DEFAULT '',
  "account_bank_address" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_bank_transfer_record" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "biz_type" INTEGER NOT NULL DEFAULT 1,
  "payer_type" INTEGER NOT NULL DEFAULT 0,
  "payer_account" TEXT NOT NULL DEFAULT '',
  "payer_name" TEXT NOT NULL DEFAULT '',
  "amount" REAL NOT NULL DEFAULT 0,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "account_id" INTEGER NOT NULL DEFAULT 0,
  "payee_account" TEXT NOT NULL DEFAULT '',
  "payee_name" TEXT NOT NULL DEFAULT '',
  "payee_bank_no" TEXT NOT NULL DEFAULT '',
  "payee_bank_name" TEXT NOT NULL DEFAULT '',
  "payee_type" INTEGER NOT NULL DEFAULT 1,
  "record_code" TEXT NOT NULL DEFAULT '',
  "f_seq_no" TEXT NOT NULL DEFAULT '',
  "uni_busi_id" TEXT NOT NULL DEFAULT '',
  "i_seq_no" TEXT NOT NULL DEFAULT '',
  "serial_no" TEXT NOT NULL DEFAULT '',
  "pay_desc" TEXT NOT NULL DEFAULT '',
  "pay_site" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "status_desc" TEXT NOT NULL DEFAULT '',
  "pay_resp" TEXT,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "success_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_banner" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "app_id" TEXT NOT NULL DEFAULT '',
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "router_type" INTEGER NOT NULL DEFAULT 0,
  "title" TEXT NOT NULL DEFAULT '',
  "image" TEXT NOT NULL DEFAULT '',
  "color_code" TEXT NOT NULL DEFAULT '',
  "url" TEXT NOT NULL DEFAULT '',
  "is_show" INTEGER NOT NULL DEFAULT 0,
  "sort_num" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_base_config" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL DEFAULT '',
  "short_name" TEXT NOT NULL DEFAULT '',
  "area_id" INTEGER NOT NULL DEFAULT 0,
  "area_name" TEXT NOT NULL DEFAULT '',
  "area_leader" TEXT NOT NULL DEFAULT '',
  "contact_tel" TEXT NOT NULL DEFAULT '',
  "station_fee" REAL NOT NULL DEFAULT 0.00,
  "call_fee_standard" REAL NOT NULL DEFAULT 0.00,
  "dounan_avg_duration_minutes" INTEGER NOT NULL DEFAULT 0,
  "single_base_task_avg_duration_minutes" INTEGER NOT NULL DEFAULT 0,
  "multi_base_task_avg_duration_minutes" INTEGER NOT NULL DEFAULT 0,
  "avg_departure_time" TEXT NOT NULL DEFAULT '',
  "credit_require" REAL NOT NULL DEFAULT 0.00,
  "sequence" INTEGER NOT NULL DEFAULT 0,
  "status" INTEGER NOT NULL DEFAULT 0,
  "latest_check_time" TEXT NOT NULL DEFAULT '',
  "late_auto_punish" INTEGER NOT NULL DEFAULT 0,
  "single_punish_amount" REAL NOT NULL DEFAULT 0.00,
  "longitude" TEXT NOT NULL DEFAULT '',
  "latitude" TEXT NOT NULL DEFAULT '',
  "address" TEXT NOT NULL DEFAULT '',
  "adcode" TEXT NOT NULL DEFAULT '',
  "helper" TEXT,
  "outsource_flag" INTEGER NOT NULL DEFAULT 0,
  "outsource_user_id" INTEGER DEFAULT NULL,
  "outsource_user_name" TEXT DEFAULT NULL,
  "base_volume" INTEGER NOT NULL DEFAULT 0,
  "base_salary" REAL NOT NULL DEFAULT 0.00,
  "subsidy_unit_price" REAL NOT NULL DEFAULT 0.00,
  "outsource_income_rule_id" INTEGER DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("short_name"),
  UNIQUE ("outsource_user_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_base_outsource_income" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "round_no" TEXT NOT NULL DEFAULT '',
  "base_id" INTEGER NOT NULL DEFAULT 0,
  "base_name" TEXT DEFAULT NULL,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "income_rule_id" INTEGER DEFAULT NULL,
  "total_num" INTEGER NOT NULL DEFAULT 0,
  "base_volume" INTEGER NOT NULL DEFAULT 0,
  "subsidy_volume" INTEGER NOT NULL DEFAULT 0,
  "subsidy_unit_price" REAL NOT NULL DEFAULT 0.00,
  "base_salary" REAL NOT NULL DEFAULT 0.00,
  "session_income" REAL NOT NULL DEFAULT 0.00,
  "settle_flag" INTEGER NOT NULL DEFAULT 0,
  "settle_supplier_id" INTEGER DEFAULT 0,
  "settle_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("base_id", "round_no")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_base_outsource_income_rule" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "base_id" INTEGER NOT NULL DEFAULT 0,
  "rule_version" INTEGER NOT NULL DEFAULT 0,
  "base_salary" REAL NOT NULL DEFAULT 0.00,
  "level_config" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("base_id", "rule_version")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_burial_point" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "type" INTEGER NOT NULL DEFAULT 0,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "ip" TEXT NOT NULL DEFAULT '',
  "content" TEXT NOT NULL DEFAULT '',
  "count" INTEGER NOT NULL DEFAULT 0,
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_cart" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "product_type" INTEGER NOT NULL DEFAULT 0,
  "is_hour_delivery" INTEGER NOT NULL DEFAULT 0,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "platform" INTEGER NOT NULL DEFAULT 0,
  "is_sale_agency" INTEGER NOT NULL DEFAULT 0,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "product_name" TEXT NOT NULL DEFAULT '',
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT DEFAULT NULL,
  "pic_url" TEXT NOT NULL DEFAULT '',
  "in_price" REAL NOT NULL DEFAULT 0,
  "buy_count" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT DEFAULT NULL,
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_category" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "ware_type" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "icon" TEXT NOT NULL DEFAULT '',
  "router_type" INTEGER NOT NULL DEFAULT 2,
  "redirect" TEXT NOT NULL DEFAULT '',
  "sort_num" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT DEFAULT (datetime('now','+8 hours')),
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_channel" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL DEFAULT '',
  "channel_id" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_channel_user_info" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "channel_id" INTEGER NOT NULL DEFAULT 0,
  "open_id" TEXT NOT NULL DEFAULT '',
  "last_login_time" TEXT DEFAULT NULL,
  "last_login_ip" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("channel_id", "open_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_chat_chat_message" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "conversation_id" INTEGER NOT NULL DEFAULT 0,
  "sender_type" TEXT NOT NULL DEFAULT '',
  "sender_id" TEXT NOT NULL DEFAULT '',
  "content" TEXT,
  "msg_subtype" TEXT NOT NULL DEFAULT '',
  "extra_json" TEXT DEFAULT NULL,
  "client_msg_id" TEXT DEFAULT NULL,
  "send_time" TEXT NOT NULL DEFAULT '',
  "is_revoke" INTEGER DEFAULT 0,
  "revoke_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("sender_type", "sender_id", "client_msg_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_chat_conversation" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "con_type" INTEGER NOT NULL DEFAULT 0,
  "source_type" TEXT NOT NULL DEFAULT '',
  "msg_type" TEXT NOT NULL DEFAULT '',
  "source_id" TEXT NOT NULL DEFAULT '',
  "target_type" TEXT NOT NULL DEFAULT '',
  "target_id" TEXT NOT NULL DEFAULT '',
  "last_msg_content" TEXT DEFAULT NULL,
  "last_msg_time" TEXT DEFAULT NULL,
  "last_msg_type" TEXT DEFAULT NULL,
  UNIQUE ("source_type", "source_id", "target_type", "target_id", "con_type", "msg_type")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_chat_conversation_user" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "conversation_id" INTEGER NOT NULL DEFAULT 0,
  "user_type" TEXT NOT NULL DEFAULT '',
  "user_id" TEXT NOT NULL DEFAULT '',
  "unread_count" INTEGER DEFAULT 0,
  "target_avatar" TEXT DEFAULT NULL,
  "target_name" TEXT DEFAULT NULL,
  "top_flag" INTEGER DEFAULT 0,
  "top_time" TEXT DEFAULT NULL,
  "last_read_message_id" INTEGER DEFAULT NULL,
  "mute_flag" INTEGER DEFAULT 0,
  "delete_flag" INTEGER DEFAULT 0,
  "delete_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("conversation_id", "user_type", "user_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_chat_message_template" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "biz_type" TEXT DEFAULT NULL,
  "msg_type" TEXT NOT NULL DEFAULT '',
  "title_template" TEXT NOT NULL DEFAULT '',
  "content_template" TEXT NOT NULL DEFAULT '',
  "status" INTEGER DEFAULT 1,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "create_people" TEXT DEFAULT NULL,
  "update_people" TEXT DEFAULT NULL,
  "extra_json" TEXT DEFAULT NULL,
  "path" TEXT DEFAULT NULL,
  "btn_text" TEXT DEFAULT NULL,
  UNIQUE ("biz_type", "msg_type")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_chat_private_permission" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_type" TEXT NOT NULL DEFAULT '',
  "user_id" TEXT NOT NULL DEFAULT '',
  "name" TEXT DEFAULT NULL,
  "status" TEXT NOT NULL DEFAULT 'NORMAL',
  "mute_start_time" TEXT DEFAULT NULL,
  "mute_end_time" TEXT DEFAULT NULL,
  "reason" TEXT DEFAULT NULL,
  "operator_id" TEXT DEFAULT NULL,
  "operator_name" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("user_type", "user_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_chat_sys_message" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "msg_type" TEXT NOT NULL DEFAULT '',
  "biz_type" TEXT NOT NULL DEFAULT '',
  "biz_id" TEXT DEFAULT NULL,
  "biz_unique_key" TEXT DEFAULT NULL,
  "sender_type" TEXT NOT NULL DEFAULT '',
  "sender_id" TEXT NOT NULL DEFAULT '',
  "title" TEXT DEFAULT NULL,
  "content" TEXT NOT NULL DEFAULT '',
  "extra_json" TEXT DEFAULT NULL,
  "success_count" TEXT DEFAULT NULL,
  "revoke_status" INTEGER DEFAULT 0,
  "revoke_time" TEXT DEFAULT NULL,
  "send_time" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_chat_user_message" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_type" TEXT NOT NULL DEFAULT '',
  "user_id" TEXT NOT NULL DEFAULT '',
  "send_time" TEXT DEFAULT NULL,
  "message_id" INTEGER NOT NULL DEFAULT 0,
  "msg_type" TEXT NOT NULL DEFAULT '',
  "biz_type" TEXT NOT NULL DEFAULT '',
  "read_status" INTEGER DEFAULT 0,
  "read_time" TEXT DEFAULT NULL,
  "delete_flag" INTEGER DEFAULT 0,
  "delete_time" TEXT DEFAULT NULL,
  "revoke_flag" INTEGER DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("user_type", "user_id", "message_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_city_customer_daily_statistics" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "stat_date" TEXT NOT NULL DEFAULT '',
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "total_consumption" REAL NOT NULL DEFAULT 0.00,
  "item_num" INTEGER NOT NULL DEFAULT 0,
  "order_count" INTEGER NOT NULL DEFAULT 0,
  "purchase_count" INTEGER NOT NULL DEFAULT 0,
  "after_sale_count" INTEGER NOT NULL DEFAULT 0,
  "after_sale_amount" REAL NOT NULL DEFAULT 0.00,
  "after_sale_purchase_count" INTEGER NOT NULL DEFAULT 0,
  "after_sale_purchase_amount" REAL NOT NULL DEFAULT 0.00,
  "first_buy_time" TEXT NOT NULL DEFAULT '',
  "last_buy_time" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("stat_date", "ware_id", "purchaser_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_city_second_subsidy" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "city_id" INTEGER NOT NULL DEFAULT 0,
  "adcode" TEXT NOT NULL DEFAULT '',
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "rank_num" INTEGER NOT NULL DEFAULT 0,
  "subsidy_num" INTEGER NOT NULL DEFAULT 0,
  "subsidy_price" REAL NOT NULL DEFAULT 0.00,
  "supplier_perm" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_city_subsidy" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "province_id" INTEGER NOT NULL DEFAULT 0,
  "province_name" TEXT NOT NULL DEFAULT '',
  "city_id" INTEGER NOT NULL DEFAULT 0,
  "city_name" TEXT NOT NULL DEFAULT '',
  "adcode" TEXT NOT NULL DEFAULT '',
  "sku_num" INTEGER NOT NULL DEFAULT 0,
  "max_subsidy" REAL NOT NULL DEFAULT 0.00,
  "round_subsidy" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_city_subsidy_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "city_id" INTEGER NOT NULL DEFAULT 0,
  "content" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_city_subsidy_product" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "adcode" TEXT NOT NULL DEFAULT '',
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "rank_num" INTEGER NOT NULL DEFAULT 0,
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "subsidy_price" REAL NOT NULL DEFAULT 0.00,
  "record_key" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_class_first" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL DEFAULT '',
  "sequence" INTEGER NOT NULL DEFAULT 0,
  "sort_num" INTEGER NOT NULL DEFAULT 0,
  "tag" TEXT NOT NULL DEFAULT '',
  "tag_start_time" TEXT DEFAULT NULL,
  "tag_end_time" TEXT DEFAULT NULL,
  "notice" TEXT NOT NULL DEFAULT '',
  "guide" TEXT NOT NULL DEFAULT '',
  "class_kind" INTEGER NOT NULL DEFAULT 1,
  "class_type" INTEGER NOT NULL DEFAULT 1,
  "spec_flag" INTEGER NOT NULL DEFAULT 0,
  "sort_kind" INTEGER NOT NULL DEFAULT 1,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "group_tag_id" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_class_second" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "first_id" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "class_tag" TEXT NOT NULL DEFAULT '',
  "rank_flag" INTEGER NOT NULL DEFAULT 1,
  "relate_first_id" INTEGER NOT NULL DEFAULT 0,
  "relate_first_id_str" TEXT NOT NULL DEFAULT '',
  "pic_url" TEXT NOT NULL DEFAULT '',
  "notice" TEXT NOT NULL DEFAULT '',
  "sequence" INTEGER NOT NULL DEFAULT 0,
  "sort_num" INTEGER NOT NULL DEFAULT 0,
  "today_sell_count" INTEGER NOT NULL DEFAULT 0,
  "last_sell_count" INTEGER NOT NULL DEFAULT 0,
  "month_sell_count" INTEGER NOT NULL DEFAULT 0,
  "sell_count" INTEGER NOT NULL DEFAULT 0,
  "ka_sell_count" INTEGER NOT NULL DEFAULT 0,
  "stock" INTEGER NOT NULL DEFAULT 0,
  "spec_num" INTEGER NOT NULL DEFAULT 0,
  "spec" TEXT NOT NULL DEFAULT '',
  "pack" TEXT NOT NULL DEFAULT '',
  "color_lib_id" INTEGER NOT NULL DEFAULT 0,
  "sku_config" TEXT NOT NULL DEFAULT '',
  "rank_str" TEXT NOT NULL DEFAULT '',
  "weight" INTEGER NOT NULL DEFAULT 0,
  "volume" INTEGER NOT NULL DEFAULT 0,
  "pack_fee" REAL NOT NULL DEFAULT 0.00,
  "service_fee" REAL NOT NULL DEFAULT 0.00,
  "take_price" REAL NOT NULL DEFAULT 0.00,
  "min_price" REAL NOT NULL DEFAULT 0.00,
  "max_price" REAL NOT NULL DEFAULT 0.00,
  "credit_require" REAL NOT NULL DEFAULT 1000.00,
  "class_type" INTEGER NOT NULL DEFAULT 1,
  "guide" TEXT NOT NULL DEFAULT '',
  "is_open_price_mgr" INTEGER NOT NULL DEFAULT 0,
  "quality_flag" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_class_second1" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "first_id" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "class_tag" TEXT NOT NULL DEFAULT '',
  "rank_flag" INTEGER NOT NULL DEFAULT 1,
  "relate_first_id" INTEGER NOT NULL DEFAULT 0,
  "pic_url" TEXT NOT NULL DEFAULT '',
  "notice" TEXT NOT NULL DEFAULT '',
  "sequence" INTEGER NOT NULL DEFAULT 0,
  "sort_num" INTEGER NOT NULL DEFAULT 0,
  "today_sell_count" INTEGER NOT NULL DEFAULT 0,
  "last_sell_count" INTEGER NOT NULL DEFAULT 0,
  "month_sell_count" INTEGER NOT NULL DEFAULT 0,
  "sell_count" INTEGER NOT NULL DEFAULT 0,
  "ka_sell_count" INTEGER NOT NULL DEFAULT 0,
  "stock" INTEGER NOT NULL DEFAULT 0,
  "spec_num" INTEGER NOT NULL DEFAULT 0,
  "spec" TEXT NOT NULL DEFAULT '',
  "pack" TEXT NOT NULL DEFAULT '',
  "color_lib_id" INTEGER NOT NULL DEFAULT 0,
  "sku_config" TEXT NOT NULL DEFAULT '',
  "rank_str" TEXT NOT NULL DEFAULT '',
  "weight" INTEGER NOT NULL DEFAULT 0,
  "volume" INTEGER NOT NULL DEFAULT 0,
  "pack_fee" REAL NOT NULL DEFAULT 0.00,
  "service_fee" REAL NOT NULL DEFAULT 0.00,
  "take_price" REAL NOT NULL DEFAULT 0.00,
  "min_price" REAL NOT NULL DEFAULT 0.00,
  "max_price" REAL NOT NULL DEFAULT 0.00,
  "credit_require" REAL NOT NULL DEFAULT 1000.00,
  "class_type" INTEGER NOT NULL DEFAULT 1,
  "is_open_price_mgr" INTEGER NOT NULL DEFAULT 0,
  "quality_flag" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_class_second_rank_sku" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "rank_num" INTEGER NOT NULL DEFAULT 0,
  "weight" INTEGER NOT NULL DEFAULT 0,
  "volume" REAL NOT NULL DEFAULT 3000.00000,
  "add_price" REAL NOT NULL DEFAULT 0.00,
  "description" TEXT NOT NULL DEFAULT '',
  "avg_price" REAL DEFAULT 0.00,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("second_id", "rank_num")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_class_second_relation" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "second_alias" TEXT DEFAULT '',
  "relation_id" INTEGER NOT NULL DEFAULT 0,
  "relation_alias" TEXT DEFAULT '',
  UNIQUE ("second_id", "relation_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_class_second_sort" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "first_id" INTEGER NOT NULL DEFAULT 0,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "sort_num" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("first_id", "second_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_class_second_station_fee" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "station_fee_ratio" REAL NOT NULL DEFAULT 0.50,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("second_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_class_tag_rule" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "type" INTEGER NOT NULL DEFAULT 0,
  "class_id" INTEGER NOT NULL DEFAULT 0,
  "tag_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("class_id", "type", "tag_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_coin_detail_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "business_type" INTEGER NOT NULL DEFAULT 0,
  "xm_coin_give" REAL NOT NULL DEFAULT 0,
  "xm_coin_rebate" REAL NOT NULL DEFAULT 0,
  "xm_coin_paid" REAL NOT NULL DEFAULT 0,
  "reason" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT ''
);
CREATE TABLE IF NOT EXISTS "xm_bulky_coin_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "refund_id" INTEGER NOT NULL DEFAULT 0,
  "origin_type" INTEGER NOT NULL DEFAULT 0,
  "business_type" INTEGER NOT NULL DEFAULT 0,
  "old_money" REAL NOT NULL DEFAULT 0,
  "money" REAL NOT NULL DEFAULT 0,
  "new_money" REAL NOT NULL DEFAULT 0,
  "reason" INTEGER NOT NULL DEFAULT 0,
  "remark" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT ''
);
CREATE TABLE IF NOT EXISTS "xm_bulky_cold_contact_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "cold_stock_id" INTEGER NOT NULL DEFAULT 0,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "ship_confirm" INTEGER DEFAULT NULL,
  "next_plan_ship_date" TEXT DEFAULT NULL,
  "content" TEXT DEFAULT NULL,
  "image_urls" TEXT DEFAULT NULL,
  "operator_id" INTEGER DEFAULT NULL,
  "operator_name" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_cold_out_task" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "cold_stock_id" INTEGER NOT NULL DEFAULT 0,
  "out_type" INTEGER NOT NULL DEFAULT 0,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "store_type" INTEGER NOT NULL DEFAULT 0,
  "link_send_no" TEXT DEFAULT NULL,
  "link_purchaser_nick" TEXT DEFAULT NULL,
  "link_purchaser_mobile" TEXT DEFAULT NULL,
  "link_receive_name" TEXT DEFAULT NULL,
  "link_receive_tel" TEXT DEFAULT NULL,
  "link_receive_address" TEXT DEFAULT NULL,
  "link_shelf_sn" INTEGER DEFAULT NULL,
  "link_sub_shelf_sn" TEXT DEFAULT NULL,
  "link_zone_shelf" TEXT DEFAULT NULL,
  "out_package_num" INTEGER NOT NULL DEFAULT 0,
  "out_bunch_num" INTEGER NOT NULL DEFAULT 0,
  "finish_bunch_num" INTEGER DEFAULT NULL,
  "box_repack_flag" INTEGER NOT NULL DEFAULT 0,
  "express_id" INTEGER DEFAULT NULL,
  "express_name" TEXT DEFAULT NULL,
  "task_status" INTEGER NOT NULL DEFAULT 10,
  "out_remark" TEXT DEFAULT NULL,
  "operator_id" INTEGER DEFAULT NULL,
  "operator_name" TEXT DEFAULT NULL,
  "operator_mobile" TEXT DEFAULT NULL,
  "operate_time" TEXT DEFAULT NULL,
  "finish_user_id" INTEGER DEFAULT NULL,
  "finish_user_name" TEXT DEFAULT NULL,
  "finish_time" TEXT DEFAULT NULL,
  "finish_image_urls" TEXT DEFAULT NULL,
  "finish_remark" TEXT DEFAULT NULL,
  "cancel_user_id" INTEGER DEFAULT NULL,
  "cancel_user_name" TEXT DEFAULT NULL,
  "cancel_time" TEXT DEFAULT NULL,
  "cancel_reason" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_cold_out_task_package" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "out_task_id" INTEGER NOT NULL DEFAULT 0,
  "cold_stock_package_id" INTEGER NOT NULL DEFAULT 0,
  "express_package_id" INTEGER NOT NULL DEFAULT 0,
  "package_code" TEXT DEFAULT NULL,
  "box_repack_flag" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_cold_stock" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "purchaser_mobile" TEXT DEFAULT NULL,
  "purchaser_nick" TEXT DEFAULT NULL,
  "ware_id" INTEGER DEFAULT NULL,
  "store_type" INTEGER NOT NULL DEFAULT 0,
  "store_round_no" TEXT NOT NULL DEFAULT '',
  "location_no" TEXT DEFAULT NULL,
  "origin_send_no" TEXT DEFAULT NULL,
  "source_enter_item_id" INTEGER DEFAULT NULL,
  "image_urls" TEXT DEFAULT NULL,
  "stock_key" TEXT DEFAULT NULL,
  "package_total" INTEGER NOT NULL DEFAULT 0,
  "package_out" INTEGER NOT NULL DEFAULT 0,
  "bunch_num" INTEGER NOT NULL DEFAULT 0,
  "remaining_bunch_num" INTEGER DEFAULT NULL,
  "stock_status" INTEGER NOT NULL DEFAULT 10,
  "ship_confirm" INTEGER DEFAULT NULL,
  "plan_ship_date" TEXT DEFAULT NULL,
  "remark" TEXT DEFAULT NULL,
  "in_user_id" INTEGER DEFAULT NULL,
  "in_user_name" TEXT DEFAULT NULL,
  "in_time" TEXT DEFAULT NULL,
  "service_user_id" INTEGER DEFAULT NULL,
  "service_user_name" TEXT DEFAULT NULL,
  "abnormal_flag" INTEGER NOT NULL DEFAULT 0,
  "abnormal_remark" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("stock_key")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_cold_stock_package" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "cold_stock_id" INTEGER NOT NULL DEFAULT 0,
  "express_package_id" INTEGER NOT NULL DEFAULT 0,
  "package_code" TEXT DEFAULT NULL,
  "origin_round_no" TEXT DEFAULT NULL,
  "location_no" TEXT DEFAULT NULL,
  "pkg_status" INTEGER NOT NULL DEFAULT 10,
  "in_user_id" INTEGER DEFAULT NULL,
  "in_user_name" TEXT DEFAULT NULL,
  "in_time" TEXT DEFAULT NULL,
  "out_task_id" INTEGER DEFAULT NULL,
  "out_user_id" INTEGER DEFAULT NULL,
  "out_user_name" TEXT DEFAULT NULL,
  "out_time" TEXT DEFAULT NULL,
  "active_key" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("active_key")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_color_lib" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "color_name" TEXT NOT NULL DEFAULT '',
  "color_code" TEXT NOT NULL DEFAULT '',
  "pic_url" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_common" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "type" INTEGER NOT NULL DEFAULT 0,
  "type_str" TEXT NOT NULL DEFAULT '',
  "price" REAL NOT NULL DEFAULT 0.000,
  "config_str" TEXT NOT NULL DEFAULT '',
  "tips" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("type")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_complain" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "type" INTEGER NOT NULL DEFAULT 1,
  "platform" INTEGER NOT NULL DEFAULT 0,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "complain_type" INTEGER NOT NULL DEFAULT 1,
  "punish_link" INTEGER NOT NULL DEFAULT 0,
  "relate_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_tag" TEXT NOT NULL DEFAULT '',
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "reason" TEXT NOT NULL DEFAULT '',
  "reason_type" INTEGER NOT NULL DEFAULT 0,
  "appeal_type" INTEGER NOT NULL DEFAULT 0,
  "appeal_desc" TEXT NOT NULL DEFAULT '',
  "pictures" TEXT,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "operation_content" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 1,
  "return_money" REAL NOT NULL DEFAULT 0.00,
  "account_change_id" INTEGER NOT NULL DEFAULT 0,
  "subsidy_money" REAL NOT NULL DEFAULT 0.00,
  "subsidy_num" INTEGER NOT NULL DEFAULT 0,
  "subsidy_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "handle_time" TEXT DEFAULT NULL
);
CREATE TABLE IF NOT EXISTS "xm_bulky_contact" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "ware_type" INTEGER NOT NULL DEFAULT 0,
  "app_id" TEXT NOT NULL DEFAULT '',
  "type" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "icon" TEXT NOT NULL DEFAULT '',
  "pic_url" TEXT NOT NULL DEFAULT '',
  "qq" TEXT NOT NULL DEFAULT '',
  "phone" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "work_time" TEXT NOT NULL DEFAULT '',
  "wx_link" TEXT NOT NULL DEFAULT '',
  "link_name" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_contact_supplier_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "op" INTEGER NOT NULL DEFAULT 0,
  "times" INTEGER NOT NULL DEFAULT 0,
  "contact_date" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_coupon" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "coupon_no" TEXT NOT NULL DEFAULT '',
  "coupon_name" TEXT NOT NULL DEFAULT '',
  "description" TEXT NOT NULL DEFAULT '',
  "coupon_type" INTEGER NOT NULL DEFAULT 0,
  "discount_rate" REAL NOT NULL DEFAULT 0.00,
  "discount_max_amount" REAL NOT NULL DEFAULT 0.00,
  "coupon_price" REAL NOT NULL DEFAULT 0,
  "limit_num" INTEGER NOT NULL DEFAULT 0,
  "limit_price" REAL NOT NULL DEFAULT 0,
  "limit_type" INTEGER NOT NULL DEFAULT 0,
  "limit_count" INTEGER NOT NULL DEFAULT 1,
  "coupon_source" INTEGER NOT NULL DEFAULT 1,
  "coupon_channel" INTEGER NOT NULL DEFAULT 1,
  "biz_type" INTEGER NOT NULL DEFAULT 1,
  "ware_user_type" INTEGER NOT NULL DEFAULT 0,
  "ware_id_str" TEXT,
  "ware_name_str" TEXT,
  "ware_ratio" REAL NOT NULL DEFAULT 0.00,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "partner_name" TEXT NOT NULL DEFAULT '',
  "help_id_str" TEXT NOT NULL DEFAULT '',
  "help_name_str" TEXT NOT NULL DEFAULT '',
  "promoter_id_str" TEXT NOT NULL DEFAULT '',
  "promoter_name_str" TEXT,
  "first_id" INTEGER NOT NULL DEFAULT 0,
  "user_type" INTEGER NOT NULL DEFAULT 0,
  "stock" INTEGER NOT NULL DEFAULT 0,
  "send_count" INTEGER NOT NULL DEFAULT 0,
  "use_count" INTEGER NOT NULL DEFAULT 0,
  "get_time" TEXT NOT NULL DEFAULT '',
  "down_time" TEXT NOT NULL DEFAULT '',
  "effect_type" INTEGER NOT NULL DEFAULT 0,
  "available_flag" INTEGER NOT NULL DEFAULT 0,
  "available_area" TEXT NOT NULL DEFAULT '',
  "start_time" TEXT DEFAULT NULL,
  "end_time" TEXT DEFAULT NULL,
  "effect_period" TEXT DEFAULT '',
  "validity_days" INTEGER NOT NULL DEFAULT 0,
  "is_auto_send" INTEGER NOT NULL DEFAULT 0,
  "detail_info" TEXT NOT NULL DEFAULT '',
  "extra_info" TEXT NOT NULL DEFAULT '',
  "pop_url" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_coupon_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "coupon_id" INTEGER NOT NULL DEFAULT 0,
  "field" TEXT NOT NULL DEFAULT '',
  "old_data" TEXT NOT NULL DEFAULT '',
  "new_data" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_coupon_user" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "help_id" INTEGER NOT NULL DEFAULT 0,
  "coupon_no" TEXT NOT NULL DEFAULT '',
  "coupon_name" TEXT NOT NULL DEFAULT '',
  "description" TEXT NOT NULL DEFAULT '',
  "coupon_type" INTEGER NOT NULL DEFAULT 0,
  "coupon_price" REAL NOT NULL DEFAULT 0,
  "limit_num" INTEGER NOT NULL DEFAULT 0,
  "limit_price" REAL NOT NULL DEFAULT 0,
  "coupon_source" INTEGER NOT NULL DEFAULT 0,
  "distribute_coupon_reason" TEXT NOT NULL DEFAULT '',
  "draw_source" TEXT NOT NULL DEFAULT '',
  "coupon_channel" INTEGER NOT NULL DEFAULT 1,
  "biz_type" INTEGER NOT NULL DEFAULT 1,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "ware_ratio" REAL NOT NULL DEFAULT 0.00,
  "first_id" INTEGER NOT NULL DEFAULT 0,
  "effect_type" INTEGER NOT NULL DEFAULT 0,
  "available_flag" INTEGER NOT NULL DEFAULT 0,
  "available_area" TEXT NOT NULL DEFAULT '',
  "start_time" TEXT DEFAULT NULL,
  "end_time" TEXT DEFAULT NULL,
  "validity_days" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "coupon_status" INTEGER NOT NULL DEFAULT 0,
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "user_type" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_customer" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL DEFAULT '',
  "nickname" TEXT NOT NULL DEFAULT '',
  "description" TEXT NOT NULL DEFAULT '',
  "wx_service_url" TEXT NOT NULL DEFAULT '',
  "phone" TEXT NOT NULL DEFAULT '',
  "service_scope" TEXT NOT NULL DEFAULT '',
  "work_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "ware_type" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_daily_subsidy" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "round_no" TEXT NOT NULL DEFAULT '',
  "subsidy_price" REAL NOT NULL DEFAULT 0.00,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("round_no")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_data_statistics" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "yyyy_mm_dd" TEXT NOT NULL DEFAULT '',
  "turnover" REAL NOT NULL DEFAULT 0,
  "all_total_price" REAL NOT NULL DEFAULT 0.00,
  "all_actual_refund" REAL NOT NULL DEFAULT 0.00,
  "all_order_paid" REAL NOT NULL DEFAULT 0.00,
  "all_refund_express_price" REAL NOT NULL DEFAULT 0.00,
  "all_express_fill" REAL NOT NULL DEFAULT 0.00,
  "withdraw_service_fee" REAL NOT NULL DEFAULT 0.00,
  "all_use_xm_coin" REAL NOT NULL DEFAULT 0.00,
  "use_xm_coin" REAL NOT NULL DEFAULT 0.00,
  "platform_coin" REAL NOT NULL DEFAULT 0.00,
  "coupon_price" REAL NOT NULL DEFAULT 0.00,
  "ware_coupon_price" REAL NOT NULL DEFAULT 0.00,
  "send_num" INTEGER NOT NULL DEFAULT 0,
  "order_num" INTEGER NOT NULL DEFAULT 0,
  "item_num" INTEGER NOT NULL DEFAULT 0,
  "item_count" INTEGER NOT NULL DEFAULT 0,
  "product_kind_num" INTEGER NOT NULL DEFAULT 0,
  "product_form" TEXT,
  "supplier_due" REAL NOT NULL DEFAULT 0.00,
  "supplier_punish" REAL NOT NULL DEFAULT 0.00,
  "supplier_after_sale_price" REAL NOT NULL DEFAULT 0.00,
  "supplier_order_paid" REAL NOT NULL DEFAULT 0.00,
  "total_station_fee" REAL NOT NULL DEFAULT 0.00,
  "sa_station_fee" REAL NOT NULL DEFAULT 0.00,
  "express_price" REAL NOT NULL DEFAULT 0,
  "order_refund_express_price" REAL NOT NULL DEFAULT 0.00,
  "refund_express_price" REAL NOT NULL DEFAULT 0.00,
  "base_service_fee" REAL NOT NULL DEFAULT 0.00,
  "service_fee" REAL NOT NULL DEFAULT 0,
  "total_weight" INTEGER NOT NULL DEFAULT 0,
  "self_total_weight" INTEGER NOT NULL DEFAULT 0,
  "take_xm_coin" REAL NOT NULL DEFAULT 0,
  "take_xm_coin_return" REAL NOT NULL DEFAULT 0.00,
  "sa_take_price" REAL NOT NULL DEFAULT 0.00,
  "add_price" REAL NOT NULL DEFAULT 0.00,
  "subsidy" REAL NOT NULL DEFAULT 0.00,
  "rebate_xm_coin" REAL NOT NULL DEFAULT 0,
  "new_purchaser_num" INTEGER NOT NULL DEFAULT 0,
  "old_purchaser_num" INTEGER NOT NULL DEFAULT 0,
  "register_purchaser_num" INTEGER NOT NULL DEFAULT 0,
  "increased_supplier_num" INTEGER NOT NULL DEFAULT 0,
  "increased_supplier_form" TEXT NOT NULL DEFAULT '',
  "accumulated_supplier_num" INTEGER NOT NULL DEFAULT 0,
  "accumulated_supplier_form" TEXT NOT NULL DEFAULT '',
  "order_after_sale_num" INTEGER NOT NULL DEFAULT 0,
  "order_after_sale_purchaser" INTEGER NOT NULL DEFAULT 0,
  "order_supplier_after_sale_price" REAL NOT NULL DEFAULT 0.00,
  "order_after_sale_form" TEXT,
  "order_after_sale_rate" REAL NOT NULL DEFAULT 0.00,
  "order_after_sale_price" REAL NOT NULL DEFAULT 0.00,
  "order_after_sale_price_form" TEXT,
  "after_sale_num" INTEGER NOT NULL DEFAULT 0,
  "after_sale_purchaser" INTEGER NOT NULL DEFAULT 0,
  "after_sale_form" TEXT,
  "after_sale_price" REAL NOT NULL DEFAULT 0,
  "after_sale_price_form" TEXT,
  "ware_after_sale_num" INTEGER NOT NULL DEFAULT 0,
  "ware_after_sale_purchaser" INTEGER NOT NULL DEFAULT 0,
  "ware_after_sale_form" TEXT,
  "ware_after_sale_price" REAL NOT NULL DEFAULT 0,
  "ware_after_sale_price_form" TEXT,
  "order_paid_num" INTEGER NOT NULL DEFAULT 0,
  "order_paid_form" TEXT,
  "order_paid_price" REAL NOT NULL DEFAULT 0.00,
  "order_paid_price_form" TEXT,
  "paid_num" INTEGER NOT NULL DEFAULT 0,
  "paid_form" TEXT,
  "paid_price" REAL NOT NULL DEFAULT 0.00,
  "paid_price_form" TEXT,
  "subsidy_price" REAL NOT NULL DEFAULT 0.00,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("yyyy_mm_dd")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_data_statistics_bulky" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "yyyy_mm_dd" TEXT NOT NULL DEFAULT '',
  "all_total_price" REAL NOT NULL DEFAULT 0.00,
  "order_after_sale_price" REAL NOT NULL DEFAULT 0.00,
  "all_refund_express_price" REAL NOT NULL DEFAULT 0.00,
  "all_express_fill" REAL NOT NULL DEFAULT 0.00,
  "item_num" INTEGER NOT NULL DEFAULT 0,
  "order_num" INTEGER NOT NULL DEFAULT 0,
  "send_num" INTEGER NOT NULL DEFAULT 0,
  "use_xm_coin" REAL NOT NULL DEFAULT 0.00,
  "platform_coin" REAL NOT NULL DEFAULT 0.00,
  "all_use_xm_coin" REAL NOT NULL DEFAULT 0.00,
  "take_xm_coin" REAL NOT NULL DEFAULT 0.00,
  "take_xm_coin_return" REAL NOT NULL DEFAULT 0.00,
  "express_price" REAL NOT NULL DEFAULT 0.00,
  "service_fee" REAL NOT NULL DEFAULT 0.00,
  "add_price" REAL NOT NULL DEFAULT 0.00,
  UNIQUE ("yyyy_mm_dd")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_delivery_order" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "round_no" TEXT NOT NULL DEFAULT '',
  "round_type" INTEGER NOT NULL DEFAULT 0,
  "delivery_no" TEXT NOT NULL DEFAULT '',
  "total_prices" REAL NOT NULL DEFAULT 0.00,
  "total_nums" INTEGER NOT NULL DEFAULT 0,
  "order_status" INTEGER NOT NULL DEFAULT 0,
  "order_start_time" TEXT NOT NULL DEFAULT '',
  "order_end_time" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("delivery_no")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_delivery_order_item" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "delivery_no" TEXT NOT NULL DEFAULT '',
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "product_name" TEXT NOT NULL DEFAULT '',
  "rank_num" INTEGER NOT NULL DEFAULT 1,
  "sku_config" TEXT NOT NULL DEFAULT '',
  "pic_url" TEXT NOT NULL DEFAULT '',
  "spec_and_num" TEXT NOT NULL DEFAULT '',
  "supply_price" REAL NOT NULL DEFAULT 0.00,
  "item_num" INTEGER NOT NULL DEFAULT 0,
  "total_price" REAL NOT NULL DEFAULT 0.00,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_delivery_order_item_tmp" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "delivery_no" TEXT NOT NULL DEFAULT '',
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "product_name" TEXT NOT NULL DEFAULT '',
  "rank_num" INTEGER NOT NULL DEFAULT 1,
  "sku_config" TEXT NOT NULL DEFAULT '',
  "pic_url" TEXT NOT NULL DEFAULT '',
  "spec_and_num" TEXT NOT NULL DEFAULT '',
  "supply_price" REAL NOT NULL DEFAULT 0.00,
  "item_num" INTEGER NOT NULL DEFAULT 0,
  "total_price" REAL NOT NULL DEFAULT 0.00,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_delivery_order_tmp" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "round_no" TEXT NOT NULL DEFAULT '',
  "round_type" INTEGER NOT NULL DEFAULT 0,
  "delivery_no" TEXT NOT NULL DEFAULT '',
  "total_prices" REAL NOT NULL DEFAULT 0.00,
  "total_nums" INTEGER NOT NULL DEFAULT 0,
  "order_status" INTEGER NOT NULL DEFAULT 0,
  "order_start_time" TEXT NOT NULL DEFAULT '',
  "order_end_time" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("delivery_no")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_device" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "mac_address" TEXT NOT NULL DEFAULT '',
  "device_type" INTEGER NOT NULL DEFAULT 0,
  "device_sn" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("mac_address", "device_type"),
  UNIQUE ("device_sn", "device_type")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_employee" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "phone" TEXT NOT NULL DEFAULT '',
  "id_number" TEXT NOT NULL DEFAULT '',
  "id_card_front_photo" TEXT NOT NULL DEFAULT '',
  "id_card_back_photo" TEXT NOT NULL DEFAULT '',
  "entry_time" TEXT NOT NULL DEFAULT '',
  "out_time" TEXT NOT NULL DEFAULT '',
  "part_flag" INTEGER NOT NULL DEFAULT 0,
  "company_name" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_employee_bonus_config" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL DEFAULT '',
  "bonus" REAL NOT NULL DEFAULT 0.00,
  "num" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_employee_bonus_config_user" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "config_id" INTEGER NOT NULL DEFAULT 0,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_employee_bonus_month" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "month" TEXT NOT NULL DEFAULT '',
  "total_bonus" REAL NOT NULL DEFAULT 0.00,
  "total_num" INTEGER NOT NULL DEFAULT 0,
  "status" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_employee_bonus_month_detail" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "month" TEXT NOT NULL DEFAULT '',
  "config_id" INTEGER NOT NULL DEFAULT 0,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "bonus" REAL NOT NULL DEFAULT 0.00,
  "status" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_employee_wage" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "month" TEXT NOT NULL DEFAULT '',
  "type" INTEGER NOT NULL DEFAULT 1,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "total_income" REAL NOT NULL DEFAULT 0.00,
  "income" REAL NOT NULL DEFAULT 0.00,
  "part_log_income" REAL NOT NULL DEFAULT 0.00,
  "bonus" REAL NOT NULL DEFAULT 0.00,
  "punish" REAL NOT NULL DEFAULT 0.00,
  "taxable_income" REAL NOT NULL DEFAULT 0.00,
  "tax" REAL NOT NULL DEFAULT 0.00,
  "take_salary" REAL NOT NULL DEFAULT 0.00,
  "status" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_enter_item_info" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "enter_item_id" INTEGER NOT NULL DEFAULT 0,
  "no_after_sale_pic" TEXT NOT NULL DEFAULT '',
  "no_after_sale_remark" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "creater_id" INTEGER NOT NULL DEFAULT 0,
  "creater_name" TEXT NOT NULL DEFAULT ''
);
CREATE TABLE IF NOT EXISTS "xm_bulky_enter_item_restock_order" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "enter_item_id" INTEGER NOT NULL DEFAULT 0,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("enter_item_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_es_record" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "keyword" TEXT NOT NULL DEFAULT '',
  "second_result" TEXT,
  "supplier_result" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_exchange_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "code_content" TEXT NOT NULL DEFAULT '',
  "round_no" TEXT NOT NULL DEFAULT '',
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "enter_item_id" INTEGER NOT NULL DEFAULT 0,
  "num" INTEGER NOT NULL DEFAULT 0,
  "handle_num" INTEGER NOT NULL DEFAULT 0,
  "price" REAL NOT NULL DEFAULT 0.00,
  "sku_config" TEXT NOT NULL DEFAULT '',
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "user_name" TEXT NOT NULL DEFAULT '',
  "type" INTEGER NOT NULL DEFAULT 0,
  "handle_status" INTEGER NOT NULL DEFAULT 0,
  "status" INTEGER NOT NULL DEFAULT 0,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "product_name" TEXT NOT NULL DEFAULT '',
  "rank_num" INTEGER NOT NULL DEFAULT 0,
  "zone_shelf" TEXT NOT NULL DEFAULT '',
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "sub_shelf_sn" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_exchange_voice_call_record" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "notify_id" INTEGER NOT NULL DEFAULT 0,
  "round_no" TEXT NOT NULL DEFAULT '',
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "notify_no" INTEGER NOT NULL DEFAULT 0,
  "trigger_type" INTEGER NOT NULL DEFAULT 0,
  "task_status" INTEGER NOT NULL DEFAULT 0,
  "dispatch_time" TEXT DEFAULT NULL,
  "operator_name" TEXT DEFAULT NULL,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "tts_code" TEXT NOT NULL DEFAULT '',
  "out_id" TEXT DEFAULT NULL,
  "request_id" TEXT DEFAULT NULL,
  "call_id" TEXT DEFAULT NULL,
  "result_code" TEXT DEFAULT NULL,
  "result_text" TEXT DEFAULT NULL,
  "originate_time" TEXT DEFAULT NULL,
  "call_end_time" TEXT DEFAULT NULL,
  "duration_seconds" INTEGER DEFAULT NULL,
  "callback_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("notify_id", "notify_no"),
  UNIQUE ("out_id"),
  UNIQUE ("call_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_exchange_voice_notify" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "round_no" TEXT NOT NULL DEFAULT '',
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "call_status" INTEGER NOT NULL DEFAULT 0,
  "notify_count" INTEGER NOT NULL DEFAULT 0,
  "current_call_record_id" INTEGER DEFAULT NULL,
  "answered_call_record_id" INTEGER DEFAULT NULL,
  "last_notify_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("round_no", "supplier_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_express_bill_import_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "status" INTEGER NOT NULL DEFAULT 0,
  "result" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "link" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_express_change_apply" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "round_no" TEXT NOT NULL DEFAULT '',
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "express_refund_id" INTEGER NOT NULL DEFAULT 0,
  "status" INTEGER NOT NULL DEFAULT 0,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "send_no" TEXT NOT NULL DEFAULT '',
  "modify_all" INTEGER NOT NULL DEFAULT 0,
  "new_express_price" REAL NOT NULL DEFAULT 0.00,
  "amount" REAL NOT NULL DEFAULT 0.00,
  "refunded_amount" REAL NOT NULL DEFAULT 0.00,
  "express_id" INTEGER NOT NULL DEFAULT 0,
  "express_name" TEXT NOT NULL DEFAULT '',
  "express_region_id" INTEGER NOT NULL DEFAULT 0,
  "restore_status" INTEGER NOT NULL DEFAULT 0,
  "extra_info" TEXT,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_express_price_redress" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "business_no" TEXT NOT NULL DEFAULT '',
  "send_no" TEXT NOT NULL DEFAULT '',
  "business_type" INTEGER NOT NULL DEFAULT 0,
  "old_money" REAL NOT NULL DEFAULT 0,
  "new_money" REAL NOT NULL DEFAULT 0,
  "money" REAL NOT NULL DEFAULT 0.00,
  "pay_type" INTEGER DEFAULT NULL,
  "use_xm_coin" REAL NOT NULL DEFAULT 0.00,
  "wx_pay_id" TEXT DEFAULT NULL,
  "pay_time" TEXT DEFAULT NULL,
  "remark" TEXT DEFAULT NULL,
  "extra_info" TEXT,
  "redress_status" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER DEFAULT 0,
  "last_operator_name" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT DEFAULT NULL,
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("business_no")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_express_redress_refund" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "send_no" TEXT NOT NULL DEFAULT '',
  "settle_batch" TEXT NOT NULL DEFAULT '',
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "source_type" INTEGER NOT NULL DEFAULT 1,
  "source_id" INTEGER NOT NULL DEFAULT 0,
  "express_refund_id" INTEGER NOT NULL DEFAULT 0,
  "pay_out_trade_no" TEXT NOT NULL DEFAULT '',
  "pay_trade_no" TEXT NOT NULL DEFAULT '',
  "pay_type" INTEGER NOT NULL DEFAULT 0,
  "refund_amount" REAL NOT NULL DEFAULT 0.00,
  "out_refund_no" TEXT NOT NULL DEFAULT '',
  "refund_status" INTEGER NOT NULL DEFAULT 0,
  "fail_reason" TEXT NOT NULL DEFAULT '',
  "retry_count" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_express_refund" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "pay_type" INTEGER NOT NULL DEFAULT 0,
  "refund_type" INTEGER NOT NULL DEFAULT 0,
  "seq_no" INTEGER NOT NULL DEFAULT 1,
  "refund_express_price" REAL NOT NULL DEFAULT 0,
  "refund_status" INTEGER NOT NULL DEFAULT 0,
  "wx_refund_id" TEXT NOT NULL DEFAULT '',
  "mch_id" TEXT NOT NULL DEFAULT '',
  "old_express_id" INTEGER NOT NULL DEFAULT 0,
  "new_express_id" INTEGER NOT NULL DEFAULT 0,
  "wx_refund_channel" TEXT NOT NULL DEFAULT '',
  "wx_refund_success_time" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("order_sn", "refund_type", "seq_no")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_expressid" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "config_id" INTEGER NOT NULL DEFAULT 0,
  "express_type" INTEGER NOT NULL DEFAULT 0,
  "cp_code" TEXT NOT NULL DEFAULT '',
  "order_sn" TEXT NOT NULL DEFAULT '',
  "express_code" TEXT NOT NULL DEFAULT '',
  "receive_tel" TEXT NOT NULL DEFAULT '',
  "is_effect" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_external_distribution_contractor_account" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "contractor_user_id" INTEGER NOT NULL DEFAULT 0,
  "employee_user_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("contractor_user_id", "employee_user_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_favorite_flower" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "type" INTEGER NOT NULL DEFAULT 0,
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_favorite_supplier" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT DEFAULT NULL,
  UNIQUE ("user_id", "supplier_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_fhh_trade_funnel_event" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "event_no" TEXT NOT NULL DEFAULT '',
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "round_no" TEXT NOT NULL DEFAULT '',
  "event_type" INTEGER NOT NULL DEFAULT 0,
  "cart_action" INTEGER DEFAULT NULL,
  "cart_id" INTEGER DEFAULT NULL,
  "product_id" INTEGER DEFAULT NULL,
  "buy_count" INTEGER DEFAULT NULL,
  "order_sn" TEXT DEFAULT NULL,
  "content" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT '',
  UNIQUE ("event_no")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_financial_data" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "yyyy_mm_dd" TEXT NOT NULL DEFAULT '',
  "withdrawal_of" REAL NOT NULL DEFAULT 0,
  "balance" REAL NOT NULL DEFAULT 0,
  "deposit" REAL NOT NULL DEFAULT 0,
  "withdrawing" REAL NOT NULL DEFAULT 0,
  "withdrawal_of_other" REAL NOT NULL DEFAULT 0,
  "balance_other" REAL NOT NULL DEFAULT 0,
  "deposit_other" REAL NOT NULL DEFAULT 0,
  "withdrawing_other" REAL NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT ''
);
CREATE TABLE IF NOT EXISTS "xm_bulky_freeze" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "type" INTEGER NOT NULL DEFAULT 0,
  "biz_id" INTEGER NOT NULL DEFAULT 0,
  "frozen_until" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("type", "biz_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_freeze_operation_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "freeze_id" INTEGER NOT NULL DEFAULT 0,
  "detail_id" INTEGER DEFAULT NULL,
  "related_id" INTEGER DEFAULT NULL,
  "related_detail_id" INTEGER DEFAULT NULL,
  "action" INTEGER NOT NULL DEFAULT 0,
  "before_status" INTEGER DEFAULT NULL,
  "after_status" INTEGER DEFAULT NULL,
  "before_review_status" INTEGER DEFAULT NULL,
  "after_review_status" INTEGER DEFAULT NULL,
  "is_changed" INTEGER NOT NULL DEFAULT 0,
  "operator_type" INTEGER NOT NULL DEFAULT 1,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_freeze_record" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "source_type" INTEGER NOT NULL DEFAULT 0,
  "source_id" INTEGER DEFAULT NULL,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "reason" TEXT NOT NULL DEFAULT '',
  "operator_type" INTEGER NOT NULL DEFAULT 1,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "request_no" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("source_type", "request_no")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_freeze_record_item" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "freeze_id" INTEGER NOT NULL DEFAULT 0,
  "object_type" INTEGER NOT NULL DEFAULT 0,
  "object_id" INTEGER NOT NULL DEFAULT 0,
  "object_name" TEXT NOT NULL DEFAULT '',
  "review_status" INTEGER NOT NULL DEFAULT 1,
  "reviewer_id" INTEGER DEFAULT NULL,
  "reviewer_name" TEXT DEFAULT NULL,
  "review_time" TEXT DEFAULT NULL,
  "review_remark" TEXT DEFAULT NULL,
  "second_id" INTEGER DEFAULT NULL,
  "rank_num" INTEGER DEFAULT NULL,
  "sku_config" TEXT DEFAULT NULL,
  "pay_off_mode" INTEGER DEFAULT NULL,
  "duration" INTEGER DEFAULT NULL,
  "is_permanent" INTEGER NOT NULL DEFAULT 0,
  "time_type" INTEGER NOT NULL DEFAULT 1,
  "request_end_time" TEXT DEFAULT NULL,
  "start_time" TEXT DEFAULT NULL,
  "end_time" TEXT DEFAULT NULL,
  "finish_time" TEXT DEFAULT NULL,
  "status" INTEGER NOT NULL DEFAULT 1,
  "replace_id" INTEGER DEFAULT NULL,
  "end_reason" TEXT DEFAULT NULL,
  "end_user_id" INTEGER DEFAULT NULL,
  "end_user_name" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("freeze_id", "object_type", "object_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_freeze_stats" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "product_freeze_count" INTEGER DEFAULT 0,
  "supplier_freeze_count" INTEGER DEFAULT 0,
  "stats_date" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("supplier_id", "stats_date")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_gift" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "gift_no" INTEGER NOT NULL DEFAULT 0,
  "activity_id" INTEGER NOT NULL DEFAULT 0,
  "activity_name" TEXT NOT NULL DEFAULT '',
  "name" TEXT NOT NULL DEFAULT '',
  "pic_url" TEXT NOT NULL DEFAULT '',
  "price" REAL NOT NULL DEFAULT 0,
  "description" TEXT NOT NULL DEFAULT '',
  "stock" INTEGER NOT NULL DEFAULT 0,
  "send_count" INTEGER NOT NULL DEFAULT 0,
  "is_material" INTEGER NOT NULL DEFAULT 0,
  "head_store_ratio" INTEGER NOT NULL DEFAULT 0,
  "second_store_ratio" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("gift_no")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_gift_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "activity_id" INTEGER NOT NULL DEFAULT 0,
  "activity_name" TEXT NOT NULL DEFAULT '',
  "activity_info" TEXT NOT NULL DEFAULT '',
  "gift_no" INTEGER NOT NULL DEFAULT 0,
  "gift_name" TEXT NOT NULL DEFAULT '',
  "pic_url" TEXT NOT NULL DEFAULT '',
  "description" TEXT NOT NULL DEFAULT '',
  "is_material" INTEGER NOT NULL DEFAULT 0,
  "is_used" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_group" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_group_detail" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "group_id" INTEGER NOT NULL DEFAULT 0,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "nickname" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_help" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "type" INTEGER NOT NULL DEFAULT 1,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "com_id" INTEGER NOT NULL DEFAULT 0,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "user_name" TEXT NOT NULL DEFAULT '',
  "name" TEXT NOT NULL DEFAULT '',
  "phone" TEXT NOT NULL DEFAULT '',
  "show_phone" TEXT NOT NULL DEFAULT '',
  "wx_phone" TEXT NOT NULL DEFAULT '',
  "wx_register_url" TEXT NOT NULL DEFAULT '',
  "pic_url" TEXT NOT NULL DEFAULT '',
  "month_promotion" INTEGER NOT NULL DEFAULT 0,
  "total_promotion" INTEGER NOT NULL DEFAULT 0,
  "month_flower_money" REAL NOT NULL DEFAULT 0.00,
  "total_flower_money" REAL NOT NULL DEFAULT 0.00,
  "month_deduction" REAL NOT NULL DEFAULT 0.00,
  "total_deduction" REAL NOT NULL DEFAULT 0.00,
  "month_material_money" REAL NOT NULL DEFAULT 0.00,
  "total_material_money" REAL NOT NULL DEFAULT 0.00,
  "month_material_deduction" REAL NOT NULL DEFAULT 0.00,
  "total_material_deduction" REAL NOT NULL DEFAULT 0.00,
  "sale_flag" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("user_id", "type")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_help_customer" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "help_id" INTEGER NOT NULL DEFAULT 0,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "platform_type" INTEGER NOT NULL DEFAULT 2,
  "type" INTEGER NOT NULL DEFAULT 1,
  "customer_id" INTEGER NOT NULL DEFAULT 0,
  "expire_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "create_time" TEXT NOT NULL DEFAULT '',
  UNIQUE ("customer_id", "help_id", "platform_type"),
  UNIQUE ("customer_id", "type", "platform_type")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_help_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "help_id" INTEGER NOT NULL DEFAULT 0,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "phone" TEXT NOT NULL DEFAULT '',
  "avatar" TEXT NOT NULL DEFAULT '',
  "reason" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_help_order_detail" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "yyyy_mm_dd" TEXT NOT NULL DEFAULT '',
  "help_id" INTEGER NOT NULL DEFAULT 0,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "biz_type" INTEGER NOT NULL DEFAULT 0,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "pay_time" TEXT NOT NULL DEFAULT '',
  "customer_id" INTEGER NOT NULL DEFAULT 0,
  "flower_money_income" REAL NOT NULL DEFAULT 0.00,
  "flower_money_outcome" REAL NOT NULL DEFAULT 0.00,
  "deduct_ratio" REAL DEFAULT 0.000,
  "is_settle" INTEGER NOT NULL DEFAULT 0,
  "settle_id" INTEGER NOT NULL DEFAULT 0,
  "settle_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("yyyy_mm_dd", "order_sn")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_help_settle" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "month" TEXT NOT NULL DEFAULT '',
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "money" REAL NOT NULL DEFAULT 0.00,
  "is_count" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("month", "user_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_home_page" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "app_id" TEXT NOT NULL DEFAULT '',
  "show_type" INTEGER NOT NULL DEFAULT 0,
  "router_type" INTEGER NOT NULL DEFAULT 2,
  "title" TEXT NOT NULL DEFAULT '',
  "image" TEXT NOT NULL DEFAULT '',
  "color_code" TEXT NOT NULL DEFAULT '',
  "sort_num" INTEGER NOT NULL DEFAULT 0,
  "url" TEXT NOT NULL DEFAULT '',
  "show_flag" INTEGER NOT NULL DEFAULT 1,
  "extra_info" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_inspection" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "date" TEXT NOT NULL DEFAULT '',
  "enter_item_id" INTEGER NOT NULL DEFAULT 0,
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "zoen_shelf" TEXT NOT NULL DEFAULT '',
  "sub_shelf_sn" TEXT DEFAULT NULL,
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "product_name" TEXT NOT NULL DEFAULT '',
  "rank_num" INTEGER NOT NULL DEFAULT 0,
  "sku_config" TEXT NOT NULL DEFAULT '',
  "item_num" INTEGER NOT NULL DEFAULT 0,
  "receive_tel" TEXT NOT NULL DEFAULT '',
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT DEFAULT NULL,
  "big_order" INTEGER DEFAULT 0,
  "inspection_flag" INTEGER NOT NULL DEFAULT 0,
  "focus_flag" INTEGER NOT NULL DEFAULT 0,
  "focus_quality_mark_id" INTEGER DEFAULT NULL,
  "focus_quality_source" INTEGER NOT NULL DEFAULT 0,
  "focus_quality_status" INTEGER DEFAULT 1,
  "new_order" INTEGER DEFAULT 0,
  "new_supplier" INTEGER DEFAULT NULL,
  "old_supplier" INTEGER DEFAULT NULL,
  "refund_product" INTEGER DEFAULT NULL,
  "quality_product" INTEGER DEFAULT NULL,
  "quality_flag" INTEGER DEFAULT NULL,
  "exchange_supplier" INTEGER DEFAULT NULL,
  "status" INTEGER NOT NULL DEFAULT 0,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "user_name" TEXT DEFAULT NULL,
  "assigned_user_id" INTEGER DEFAULT NULL,
  "assigned_user_name" TEXT DEFAULT NULL,
  "assign_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "delete_time" TEXT DEFAULT NULL,
  "finish_time" TEXT DEFAULT NULL,
  "remark" TEXT NOT NULL DEFAULT '',
  "inspection_images" TEXT DEFAULT NULL
);
CREATE TABLE IF NOT EXISTS "xm_bulky_inspection_assign_snapshot" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "round_no" TEXT NOT NULL DEFAULT '',
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "user_name" TEXT NOT NULL DEFAULT '',
  "leader_flag" INTEGER NOT NULL DEFAULT 0,
  "special_area_flag" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "good_flower_video_required_num" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("round_no", "user_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_inspection_assign_user" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "user_name" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 1,
  "attendance_status" INTEGER DEFAULT 1,
  "attendance_update_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("user_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_inspection_attendance_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "assign_user_id" INTEGER NOT NULL DEFAULT 0,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "user_name" TEXT NOT NULL DEFAULT '',
  "before_status" INTEGER NOT NULL DEFAULT 0,
  "after_status" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "operation_source" INTEGER NOT NULL DEFAULT 0,
  "batch_no" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_inspection_focus_mark" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "send_no" TEXT NOT NULL DEFAULT '',
  "round_no" TEXT NOT NULL DEFAULT '',
  "shelf_sn" INTEGER DEFAULT NULL,
  "sub_shelf_sn" TEXT DEFAULT NULL,
  "zone_shelf" TEXT DEFAULT NULL,
  "status" INTEGER NOT NULL DEFAULT 1,
  "generate_status" INTEGER NOT NULL DEFAULT 0,
  "task_type" INTEGER NOT NULL DEFAULT 1,
  "source_type" INTEGER NOT NULL DEFAULT 1,
  "remark" TEXT DEFAULT NULL,
  "operator_id" INTEGER DEFAULT NULL,
  "operator_name" TEXT DEFAULT NULL,
  "mark_time" TEXT DEFAULT NULL,
  "cancel_operator_id" INTEGER DEFAULT NULL,
  "cancel_operator_name" TEXT DEFAULT NULL,
  "cancel_time" TEXT DEFAULT NULL,
  "generate_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("send_no")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_inspection_video_record" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER DEFAULT NULL,
  "date" TEXT DEFAULT NULL,
  "snapshot_id" INTEGER NOT NULL DEFAULT 0,
  "enter_item_id" INTEGER NOT NULL DEFAULT 0,
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "item_name" TEXT NOT NULL DEFAULT '',
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "supplier_tag" TEXT NOT NULL DEFAULT '',
  "sub_shelf_sn" TEXT NOT NULL DEFAULT '',
  "zone_shelf" TEXT NOT NULL DEFAULT '',
  "video_url" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "rank_num" INTEGER DEFAULT NULL,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "shelf_sn" INTEGER DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT ''
);
CREATE TABLE IF NOT EXISTS "xm_bulky_integral_mall" (
  "id" INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY ("id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_invoice_order" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "receive_tel" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("order_sn")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_invoice_quota_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "target_type" INTEGER NOT NULL DEFAULT 0,
  "target_id" INTEGER NOT NULL DEFAULT 0,
  "adjust_type" INTEGER NOT NULL DEFAULT 0,
  "adjust_amount" REAL NOT NULL DEFAULT 0,
  "before_amount" REAL NOT NULL DEFAULT 0,
  "after_amount" REAL NOT NULL DEFAULT 0,
  "reason" TEXT DEFAULT NULL,
  "operator_id" INTEGER DEFAULT NULL,
  "operator_name" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_invoice_record" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "time_period" TEXT NOT NULL DEFAULT '',
  "url" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_invoice_registration" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "registration_no" TEXT NOT NULL DEFAULT '',
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "purchaser_phone" TEXT DEFAULT NULL,
  "purchaser_name" TEXT DEFAULT NULL,
  "invoice_title_id" INTEGER DEFAULT NULL,
  "title_name" TEXT DEFAULT NULL,
  "tax_number" TEXT DEFAULT NULL,
  "total_amount" REAL NOT NULL DEFAULT 0,
  "assigned_amount" REAL NOT NULL DEFAULT 0.00,
  "remaining_amount" REAL NOT NULL DEFAULT 0,
  "status" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER DEFAULT NULL,
  "operator_name" TEXT DEFAULT NULL,
  "remark" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("registration_no")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_invoice_request" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "request_no" TEXT NOT NULL DEFAULT '',
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "purchaser_phone" TEXT DEFAULT NULL,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT DEFAULT NULL,
  "invoice_title_id" INTEGER DEFAULT NULL,
  "title_name" TEXT DEFAULT NULL,
  "tax_number" TEXT DEFAULT NULL,
  "bank_name" TEXT DEFAULT NULL,
  "bank_account" TEXT DEFAULT NULL,
  "company_address" TEXT DEFAULT NULL,
  "company_phone" TEXT DEFAULT NULL,
  "request_amount" REAL NOT NULL DEFAULT 0,
  "invoice_url" TEXT DEFAULT NULL,
  "status" INTEGER NOT NULL DEFAULT 0,
  "invoice_platform_status" INTEGER DEFAULT 0,
  "parent_id" INTEGER DEFAULT NULL,
  "registration_id" INTEGER DEFAULT NULL,
  "deadline" TEXT DEFAULT NULL,
  "upload_time" TEXT DEFAULT NULL,
  "overdue_time" TEXT DEFAULT NULL,
  "is_overdue" INTEGER NOT NULL DEFAULT 0,
  "punish_id" INTEGER DEFAULT NULL,
  "operator_id" INTEGER DEFAULT NULL,
  "operator_name" TEXT DEFAULT NULL,
  "remark" TEXT DEFAULT NULL,
  "source" INTEGER NOT NULL DEFAULT 0,
  "application_id" INTEGER DEFAULT NULL,
  "order_sns" TEXT,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "invoice_item_type" INTEGER NOT NULL DEFAULT 0,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("request_no")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_invoice_title" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "title_type" INTEGER NOT NULL DEFAULT 1,
  "title_name" TEXT NOT NULL DEFAULT '',
  "tax_number" TEXT DEFAULT NULL,
  "bank_name" TEXT DEFAULT NULL,
  "bank_account" TEXT DEFAULT NULL,
  "company_address" TEXT DEFAULT NULL,
  "company_phone" TEXT DEFAULT NULL,
  "is_default" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_invoice_upload_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "invoice_request_id" INTEGER NOT NULL DEFAULT 0,
  "request_no" TEXT NOT NULL DEFAULT '',
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "old_invoice_url" TEXT NOT NULL DEFAULT '',
  "operate_type" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER DEFAULT NULL,
  "operator_name" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_late_pay_refund" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "order_type" INTEGER NOT NULL DEFAULT 0,
  "pay_type" INTEGER NOT NULL DEFAULT 0,
  "pay_id" TEXT NOT NULL DEFAULT '',
  "out_refund_no" TEXT NOT NULL DEFAULT '',
  "refund_fee" INTEGER NOT NULL DEFAULT 0,
  "channel_refund_id" TEXT DEFAULT NULL,
  "refund_status" INTEGER NOT NULL DEFAULT 0,
  "refund_result" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("out_refund_no")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_limit_distribution_cancel_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "enter_item_id" INTEGER DEFAULT NULL,
  "order_item_id" INTEGER DEFAULT NULL,
  "round_no" TEXT DEFAULT NULL,
  "supplier_id" INTEGER DEFAULT NULL,
  "user_id" INTEGER DEFAULT NULL,
  "user_name" TEXT DEFAULT NULL,
  "create_time" TEXT DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_link_manage" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "type" INTEGER NOT NULL DEFAULT 1,
  "title" TEXT NOT NULL DEFAULT '',
  "path" TEXT NOT NULL DEFAULT '',
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "params" TEXT NOT NULL DEFAULT '{}',
  "permanent" INTEGER NOT NULL DEFAULT 0,
  "wx_link" TEXT NOT NULL DEFAULT '',
  "url" TEXT NOT NULL DEFAULT '',
  "new_wx_link" TEXT NOT NULL DEFAULT '',
  "new_url" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_login_jpush" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "regid" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "create_time" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_logistics_activity" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "active_start" TEXT NOT NULL DEFAULT '',
  "active_end" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_logistics_activity_region" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "activity_id" INTEGER NOT NULL DEFAULT 0,
  "config_id" INTEGER NOT NULL DEFAULT 0,
  "logistics_region_id" INTEGER NOT NULL DEFAULT 0,
  "logistics_type" INTEGER NOT NULL DEFAULT 0,
  "tag" TEXT NOT NULL DEFAULT '',
  "region_id" INTEGER NOT NULL DEFAULT 0,
  "region_name" TEXT NOT NULL DEFAULT '',
  "pay_on_delivery" INTEGER NOT NULL DEFAULT 0,
  "charge_type" INTEGER NOT NULL DEFAULT 0,
  "price_data" TEXT,
  "multi_price_data" TEXT,
  "morning_price" REAL NOT NULL DEFAULT 0,
  "nooning_price" REAL NOT NULL DEFAULT 0.00,
  "evening_price" REAL NOT NULL DEFAULT 0,
  "is_enable" INTEGER NOT NULL DEFAULT 1,
  "picker_name" TEXT NOT NULL DEFAULT '',
  "picker_mobile" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_logistics_config_template_mapping" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "config_id" INTEGER NOT NULL DEFAULT 0,
  "template_id" INTEGER NOT NULL DEFAULT 0,
  "print_name" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "create_user_id" INTEGER NOT NULL DEFAULT 0,
  "create_user_name" TEXT NOT NULL DEFAULT '',
  "update_user_id" INTEGER NOT NULL DEFAULT 0,
  "update_user_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_logistics_cost_config" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "logistics_name" TEXT NOT NULL DEFAULT '',
  "brand" TEXT NOT NULL DEFAULT '',
  "phone" TEXT NOT NULL DEFAULT '',
  "logistics_type" INTEGER NOT NULL DEFAULT 0,
  "expected_time_str" TEXT NOT NULL DEFAULT '',
  "expected_time_hours" INTEGER NOT NULL DEFAULT 0,
  "delay_time_num" INTEGER NOT NULL DEFAULT 0,
  "is_to_shop" INTEGER NOT NULL DEFAULT 0,
  "transfer_cost" REAL NOT NULL DEFAULT 0,
  "is_separate_display" INTEGER NOT NULL DEFAULT 0,
  "is_enable" INTEGER NOT NULL DEFAULT 0,
  "rule_id" INTEGER NOT NULL DEFAULT 0,
  "first_heavy" INTEGER NOT NULL DEFAULT 0,
  "first_heavy_price" REAL NOT NULL DEFAULT 0.00,
  "charge_type" INTEGER NOT NULL DEFAULT 0,
  "continue_heavy_price" REAL NOT NULL DEFAULT 0.00,
  "is_transfer" INTEGER NOT NULL DEFAULT 0,
  "need_pick_fee" INTEGER NOT NULL DEFAULT 1,
  "small_item_recommend" INTEGER NOT NULL DEFAULT 0,
  "logistics_shift" INTEGER NOT NULL DEFAULT 0,
  "sort_num" INTEGER NOT NULL DEFAULT 0,
  "show_sort_num" INTEGER NOT NULL DEFAULT 0,
  "description" TEXT NOT NULL DEFAULT '',
  "delivery_time" TEXT NOT NULL DEFAULT '',
  "picker_phone" TEXT NOT NULL DEFAULT '',
  "need_fill_express_price" INTEGER NOT NULL DEFAULT 1,
  "need_fill_weight" INTEGER NOT NULL DEFAULT 1,
  "need_weight_photo" INTEGER NOT NULL DEFAULT 1,
  "out_flag" INTEGER NOT NULL DEFAULT 1,
  "pack_timeout_punish_flag" INTEGER NOT NULL DEFAULT 0,
  "promotion_flag" INTEGER NOT NULL DEFAULT 0,
  "promotion_start" TEXT DEFAULT NULL,
  "promotion_end" TEXT DEFAULT NULL,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "send_area" TEXT NOT NULL DEFAULT '',
  "is_invoice_marked" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_logistics_cost_region" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "config_id" INTEGER NOT NULL DEFAULT 0,
  "region_id" INTEGER NOT NULL DEFAULT 0,
  "adcode" TEXT NOT NULL DEFAULT '',
  "region_name" TEXT NOT NULL DEFAULT '',
  "description" TEXT,
  "first_heavy" REAL NOT NULL DEFAULT 10.00,
  "first_heavy_price" REAL NOT NULL DEFAULT 30.00,
  "pay_on_delivery" INTEGER NOT NULL DEFAULT 0,
  "charge_type" INTEGER NOT NULL DEFAULT 0,
  "price_data" TEXT,
  "multi_price_data" TEXT,
  "weight_range_data" TEXT NOT NULL DEFAULT '',
  "trunk_charge_type" INTEGER NOT NULL DEFAULT 0,
  "shop_charge_type" INTEGER NOT NULL DEFAULT 0,
  "xm_special_line" INTEGER NOT NULL DEFAULT 0,
  "trans_city" TEXT NOT NULL DEFAULT '',
  "activity_price_data" TEXT,
  "continue_heavy_price" REAL NOT NULL DEFAULT 0.00,
  "morning_price" REAL NOT NULL DEFAULT 0.00,
  "nooning_price" REAL NOT NULL DEFAULT 0.00,
  "evening_price" REAL NOT NULL DEFAULT 0.00,
  "is_enable" INTEGER NOT NULL DEFAULT 1,
  "picker_name" TEXT NOT NULL DEFAULT '',
  "picker_mobile" TEXT NOT NULL DEFAULT '',
  "expected_time_str" TEXT NOT NULL DEFAULT '',
  "expected_time_hours" INTEGER NOT NULL DEFAULT 0,
  "delivery_time" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "start_round_no" TEXT NOT NULL DEFAULT '1970-01-01',
  "end_round_no" TEXT NOT NULL DEFAULT '9999-12-31'
);
CREATE TABLE IF NOT EXISTS "xm_bulky_logistics_fail_record" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "type" INTEGER NOT NULL DEFAULT 0,
  "send_no" TEXT DEFAULT NULL,
  "logistics_no" TEXT DEFAULT NULL,
  "mail_no" TEXT NOT NULL DEFAULT '',
  "reason" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_logistics_order" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "source" INTEGER NOT NULL DEFAULT 1,
  "account_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_id" INTEGER NOT NULL DEFAULT 1,
  "send_no" TEXT NOT NULL DEFAULT '',
  "logistics_type" INTEGER NOT NULL DEFAULT 0,
  "logistics_no" TEXT NOT NULL DEFAULT '',
  "logistics_num" INTEGER NOT NULL DEFAULT 1,
  "mail_no" TEXT NOT NULL DEFAULT '',
  "config_id" INTEGER NOT NULL DEFAULT 0,
  "status" INTEGER NOT NULL DEFAULT 0,
  "is_valid" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_logistics_order_detail" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "logistics_no" TEXT NOT NULL DEFAULT '',
  "service_brand" TEXT NOT NULL DEFAULT '',
  "service_code" TEXT NOT NULL DEFAULT '',
  "agent_id" TEXT NOT NULL DEFAULT '',
  "print_id" INTEGER NOT NULL DEFAULT 0,
  "cargo_Type" INTEGER NOT NULL DEFAULT 1,
  "send_info" TEXT,
  "receive_info" TEXT,
  "weight" REAL NOT NULL DEFAULT 0.00,
  "self_sn" TEXT NOT NULL DEFAULT '',
  "round_no" TEXT NOT NULL DEFAULT '',
  "item_num" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "route_code" TEXT NOT NULL DEFAULT '',
  "sortation_name" TEXT NOT NULL DEFAULT '',
  "consolidation_name" TEXT NOT NULL DEFAULT '',
  "consolidation_code" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_logistics_remind_push_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "task_id" INTEGER NOT NULL DEFAULT 0,
  "push_date" TEXT NOT NULL DEFAULT '',
  "time_point" INTEGER NOT NULL DEFAULT 0,
  "push_status" INTEGER NOT NULL DEFAULT 1,
  "push_content" TEXT,
  "error_msg" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("task_id", "push_date", "time_point")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_logistics_remind_task" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "brand_name" TEXT NOT NULL DEFAULT '',
  "selected_config_ids" TEXT NOT NULL DEFAULT '',
  "selected_logistics_names" TEXT,
  "status" INTEGER NOT NULL DEFAULT -1,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "close_operator_id" INTEGER NOT NULL DEFAULT 0,
  "close_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_logistics_template" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "template_code" TEXT NOT NULL DEFAULT '',
  "template_name" TEXT NOT NULL DEFAULT '',
  "logistics_type" INTEGER NOT NULL DEFAULT 0,
  "service_brand" TEXT NOT NULL DEFAULT '',
  "default_print_name" TEXT NOT NULL DEFAULT '',
  "service_code_rule" TEXT NOT NULL DEFAULT '',
  "kb_template_rule" TEXT NOT NULL DEFAULT '',
  "cargo_type" INTEGER NOT NULL DEFAULT 1,
  "account_id" INTEGER NOT NULL DEFAULT 0,
  "remark" TEXT NOT NULL DEFAULT '',
  "create_user_id" INTEGER NOT NULL DEFAULT 0,
  "create_user_name" TEXT NOT NULL DEFAULT '',
  "update_user_id" INTEGER NOT NULL DEFAULT 0,
  "update_user_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("template_code")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_main_account" (
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "user_name" TEXT NOT NULL DEFAULT '',
  "nickname" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY ("user_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_mall_activity_msg" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "activity_name" TEXT NOT NULL DEFAULT '',
  "begin_time" TEXT NOT NULL DEFAULT '',
  "end_time" TEXT NOT NULL DEFAULT '',
  "send_time" TEXT NOT NULL DEFAULT '',
  "content" TEXT NOT NULL DEFAULT '',
  "tips" TEXT NOT NULL DEFAULT '',
  "activity_status" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_mall_vip" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL DEFAULT '',
  "price" REAL NOT NULL DEFAULT 0.00,
  "valid_day" INTEGER NOT NULL DEFAULT 0,
  "discount" REAL NOT NULL DEFAULT 0.00,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_mall_vip_order" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "vip_id" INTEGER NOT NULL DEFAULT 0,
  "vip_name" TEXT NOT NULL DEFAULT '',
  "phone" TEXT NOT NULL DEFAULT '',
  "order_sn" TEXT NOT NULL DEFAULT '',
  "transaction_id" TEXT NOT NULL DEFAULT '',
  "pay_type" INTEGER NOT NULL DEFAULT 0,
  "pay_status" INTEGER NOT NULL DEFAULT 0,
  "refund_status" INTEGER NOT NULL DEFAULT 0,
  "refund_success_time" TEXT DEFAULT NULL,
  "money" REAL NOT NULL DEFAULT 0.00,
  "buy_time" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("order_sn")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_mall_vip_user" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "vip_name" TEXT NOT NULL DEFAULT '',
  "with_vip_days" INTEGER NOT NULL DEFAULT 0,
  "total_discount" REAL NOT NULL DEFAULT 0.00,
  "first_buy_time" TEXT DEFAULT NULL,
  "valid_date" TEXT DEFAULT NULL,
  "vip_status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_nfc" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "sn" TEXT DEFAULT NULL,
  "sn_str" TEXT DEFAULT NULL,
  "scheme" TEXT NOT NULL DEFAULT '',
  "zone_shelf" TEXT NOT NULL DEFAULT '',
  "order_num" INTEGER NOT NULL DEFAULT 0,
  "type" INTEGER DEFAULT NULL,
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_notice" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "kind" INTEGER NOT NULL DEFAULT 1,
  "type" INTEGER NOT NULL DEFAULT 0,
  "show_type" INTEGER NOT NULL DEFAULT 1,
  "platform_type" INTEGER NOT NULL DEFAULT 0,
  "app_id" TEXT NOT NULL DEFAULT '',
  "header" TEXT NOT NULL DEFAULT '',
  "header_url" TEXT,
  "header_list_url" TEXT,
  "introduction" TEXT NOT NULL DEFAULT '',
  "notice" TEXT NOT NULL DEFAULT '',
  "sort_num" INTEGER NOT NULL DEFAULT 0,
  "carousel_flag" INTEGER NOT NULL DEFAULT 0,
  "view_count" INTEGER DEFAULT NULL,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_notice_read" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "type" INTEGER NOT NULL DEFAULT 0,
  "notice_id" INTEGER NOT NULL DEFAULT 0,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "read_time" TEXT NOT NULL DEFAULT '0000-00-00 00:00:00',
  UNIQUE ("id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_onsale_price" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "first_id" INTEGER NOT NULL DEFAULT 0,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "second_name" TEXT NOT NULL DEFAULT '',
  "rank_num" INTEGER NOT NULL DEFAULT 0,
  "price" REAL NOT NULL DEFAULT 0.00,
  "update_type" INTEGER NOT NULL DEFAULT 0,
  "update_remark" TEXT NOT NULL DEFAULT '',
  "push_onsale" INTEGER NOT NULL DEFAULT 0,
  "push_remark" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT ''
);
CREATE TABLE IF NOT EXISTS "xm_bulky_onsale_statistics" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "yyyy_mm_dd" TEXT NOT NULL DEFAULT '',
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "on_sale_num" INTEGER NOT NULL DEFAULT 0,
  "on_sale_detail" TEXT NOT NULL DEFAULT '{}',
  "supplier_on_sale_detail" TEXT NOT NULL DEFAULT '',
  "first_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("second_id", "yyyy_mm_dd")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_open_access" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "app_id" TEXT NOT NULL DEFAULT '',
  "app_key" TEXT NOT NULL DEFAULT '',
  "access_token" TEXT NOT NULL DEFAULT '',
  "expire_time" INTEGER NOT NULL DEFAULT 0,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT ''
);
CREATE TABLE IF NOT EXISTS "xm_bulky_operation_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_type" INTEGER NOT NULL DEFAULT 1,
  "operation_type" INTEGER NOT NULL DEFAULT 3,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "content" TEXT,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_order" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "vip_name" TEXT NOT NULL DEFAULT '',
  "order_sn" TEXT NOT NULL DEFAULT '',
  "order_type" INTEGER NOT NULL DEFAULT 0,
  "delivery_type" INTEGER NOT NULL DEFAULT 1,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "partner_model" INTEGER NOT NULL DEFAULT 0,
  "merchant_id" TEXT NOT NULL DEFAULT '',
  "app_id" TEXT NOT NULL DEFAULT '',
  "open_id" TEXT NOT NULL DEFAULT '',
  "distribution_type" INTEGER NOT NULL DEFAULT 0,
  "is_addition" INTEGER NOT NULL DEFAULT 0,
  "platform" INTEGER NOT NULL DEFAULT 0,
  "has_third_good" INTEGER NOT NULL DEFAULT 0,
  "is_zq_settlement" INTEGER NOT NULL DEFAULT 0,
  "send_no" TEXT NOT NULL DEFAULT '',
  "round_no" TEXT NOT NULL DEFAULT '',
  "order_num" INTEGER NOT NULL DEFAULT 1,
  "total_item_num" INTEGER NOT NULL DEFAULT 0,
  "total_weight" INTEGER NOT NULL DEFAULT 0,
  "origin_total_weight" INTEGER NOT NULL DEFAULT 0,
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "sub_shelf_sn" TEXT NOT NULL DEFAULT '',
  "zone" TEXT NOT NULL DEFAULT '',
  "shelf" TEXT NOT NULL DEFAULT '',
  "zone_shelf" TEXT NOT NULL DEFAULT '',
  "express" INTEGER NOT NULL DEFAULT 0,
  "express_region" INTEGER NOT NULL DEFAULT 0,
  "express_time" INTEGER DEFAULT NULL,
  "express_price" REAL NOT NULL DEFAULT 0,
  "activity_express_name" TEXT NOT NULL DEFAULT '',
  "before_activity_express_price" REAL NOT NULL DEFAULT 0.00,
  "real_express_id" INTEGER NOT NULL DEFAULT 0,
  "real_express_region" INTEGER NOT NULL DEFAULT 0,
  "coupon_price" REAL NOT NULL DEFAULT 0.00,
  "origin_coupon_price" REAL NOT NULL DEFAULT 0.00,
  "add_price" REAL NOT NULL DEFAULT 0.00,
  "origin_add_price" REAL NOT NULL DEFAULT 0.00,
  "warehouse_add_price" REAL NOT NULL DEFAULT 0.00,
  "origin_warehouse_add_price" REAL NOT NULL DEFAULT 0.00,
  "express_add_price" REAL NOT NULL DEFAULT 0.00,
  "origin_express_add_price" REAL NOT NULL DEFAULT 0.00,
  "delivery_fee" REAL NOT NULL DEFAULT 0.00,
  "origin_delivery_fee" REAL NOT NULL DEFAULT 0.00,
  "modify_express_price" REAL NOT NULL DEFAULT 0.00,
  "is_change_express" INTEGER NOT NULL DEFAULT 0,
  "actual_express_price" REAL DEFAULT NULL,
  "origin_supply_price" REAL NOT NULL DEFAULT 0.00,
  "product_total_price" REAL NOT NULL DEFAULT 0,
  "origin_product_total_price" REAL NOT NULL DEFAULT 0.00,
  "service_fee" REAL NOT NULL DEFAULT 0.00,
  "origin_service_fee" REAL NOT NULL DEFAULT 0.00,
  "extra_service_fee" REAL NOT NULL DEFAULT 0.00,
  "origin_extra_service_fee" REAL NOT NULL DEFAULT 0.00,
  "vip_discount_service_fee" REAL NOT NULL DEFAULT 0.00,
  "origin_vip_discount_service_fee" REAL NOT NULL DEFAULT 0.00,
  "platform_discount" REAL NOT NULL DEFAULT 0.00,
  "origin_platform_discount" REAL NOT NULL DEFAULT 0.00,
  "subsidy_price" REAL NOT NULL DEFAULT 0.00,
  "origin_subsidy_price" REAL NOT NULL DEFAULT 0.00,
  "negate_add_price" REAL NOT NULL DEFAULT 0.00,
  "origin_negate_add_price" REAL NOT NULL DEFAULT 0.00,
  "base_service_fee" REAL NOT NULL DEFAULT 0.00,
  "origin_base_service_fee" REAL NOT NULL DEFAULT 0.00,
  "partner_add_service_fee" REAL NOT NULL DEFAULT 0.00,
  "origin_partner_add_service_fee" REAL NOT NULL DEFAULT 0.00,
  "total_price" REAL NOT NULL DEFAULT 0,
  "origin_total_price" REAL NOT NULL DEFAULT 0.00,
  "origin_use_xm_coin" REAL NOT NULL DEFAULT 0.00,
  "use_xm_coin" REAL NOT NULL DEFAULT 0.00,
  "rebate_xm_coin" REAL NOT NULL DEFAULT 0.00,
  "origin_rebate_xm_coin" REAL NOT NULL DEFAULT 0.00,
  "actual_price" REAL NOT NULL DEFAULT 0.00,
  "origin_actual_price" REAL NOT NULL DEFAULT 0.00,
  "ot_exp_add_price" REAL NOT NULL DEFAULT 0.00,
  "origin_ot_exp_add_price" REAL NOT NULL DEFAULT 0.00,
  "platform_reduce_price" REAL NOT NULL DEFAULT 0.00,
  "origin_platform_reduce_price" REAL NOT NULL DEFAULT 0.00,
  "apply_price" REAL NOT NULL DEFAULT 0.00,
  "actual_refund" REAL NOT NULL DEFAULT 0.00,
  "actual_coin" REAL NOT NULL DEFAULT 0.00,
  "paid_price" REAL NOT NULL DEFAULT 0.00,
  "paid_coin" REAL NOT NULL DEFAULT 0.00,
  "pay_type" INTEGER NOT NULL DEFAULT 0,
  "pay_on_delivery" INTEGER NOT NULL DEFAULT 0,
  "receive_name" TEXT NOT NULL DEFAULT '',
  "receive_tel" TEXT NOT NULL DEFAULT '',
  "nation_code" TEXT NOT NULL DEFAULT '86',
  "province" TEXT NOT NULL DEFAULT '',
  "city" TEXT NOT NULL DEFAULT '',
  "district" TEXT NOT NULL DEFAULT '',
  "detail" TEXT NOT NULL DEFAULT '',
  "receive_address" TEXT NOT NULL DEFAULT '',
  "adcode" TEXT NOT NULL DEFAULT '',
  "buyer_memo" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "order_status" INTEGER NOT NULL DEFAULT 0,
  "after_sale_status" INTEGER NOT NULL DEFAULT 0,
  "after_sale_agree_type" INTEGER NOT NULL DEFAULT 0,
  "after_sale_count" INTEGER NOT NULL DEFAULT 0,
  "refund_status" INTEGER NOT NULL DEFAULT 0,
  "print_status" INTEGER NOT NULL DEFAULT 0,
  "wx_pay_time" TEXT DEFAULT NULL,
  "wx_pay_id" TEXT NOT NULL DEFAULT '',
  "send_time" TEXT DEFAULT NULL,
  "delay_ddl" TEXT DEFAULT NULL,
  "confirm_time" TEXT DEFAULT NULL,
  "extra_info" TEXT,
  "coupon_user_id" INTEGER NOT NULL DEFAULT 0,
  "is_comment" INTEGER NOT NULL DEFAULT 0,
  "is_open_after_sale" INTEGER NOT NULL DEFAULT 0,
  "is_deliver" INTEGER NOT NULL DEFAULT 0,
  "is_bond" INTEGER NOT NULL DEFAULT 0,
  "is_cotton" INTEGER NOT NULL DEFAULT 0,
  "flag" INTEGER NOT NULL DEFAULT 0,
  "bear_type" INTEGER NOT NULL DEFAULT 0,
  "is_bear_station_fee" INTEGER NOT NULL DEFAULT 0,
  "origin_total_station_fee" REAL NOT NULL DEFAULT 0.00,
  "total_station_fee" REAL NOT NULL DEFAULT 0.00,
  "is_presale" INTEGER NOT NULL DEFAULT 0,
  "is_sale_agency" INTEGER NOT NULL DEFAULT 0,
  "order_tag" INTEGER NOT NULL DEFAULT 0,
  "help_id" INTEGER NOT NULL DEFAULT 0,
  "pid" INTEGER NOT NULL DEFAULT 0,
  "ship_flag" INTEGER NOT NULL DEFAULT 0,
  "unqualified_way" INTEGER NOT NULL DEFAULT 0,
  "assign_customer_id" INTEGER NOT NULL DEFAULT 0,
  "assign_customer_name" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("order_sn")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_order111" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "vip_name" TEXT NOT NULL DEFAULT '',
  "order_sn" TEXT NOT NULL DEFAULT '',
  "order_type" INTEGER NOT NULL DEFAULT 0,
  "delivery_type" INTEGER NOT NULL DEFAULT 1,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "partner_model" INTEGER NOT NULL DEFAULT 0,
  "merchant_id" TEXT NOT NULL DEFAULT '',
  "app_id" TEXT NOT NULL DEFAULT '',
  "open_id" TEXT NOT NULL DEFAULT '',
  "distribution_type" INTEGER NOT NULL DEFAULT 0,
  "is_addition" INTEGER NOT NULL DEFAULT 0,
  "platform" INTEGER NOT NULL DEFAULT 0,
  "has_third_good" INTEGER NOT NULL DEFAULT 0,
  "is_zq_settlement" INTEGER NOT NULL DEFAULT 0,
  "send_no" TEXT NOT NULL DEFAULT '',
  "round_no" TEXT NOT NULL DEFAULT '',
  "order_num" INTEGER NOT NULL DEFAULT 1,
  "total_item_num" INTEGER NOT NULL DEFAULT 0,
  "total_weight" INTEGER NOT NULL DEFAULT 0,
  "origin_total_weight" INTEGER NOT NULL DEFAULT 0,
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "sub_shelf_sn" TEXT NOT NULL DEFAULT '',
  "zone" TEXT NOT NULL DEFAULT '',
  "shelf" TEXT NOT NULL DEFAULT '',
  "zone_shelf" TEXT NOT NULL DEFAULT '',
  "express" INTEGER NOT NULL DEFAULT 0,
  "express_region" INTEGER NOT NULL DEFAULT 0,
  "express_time" INTEGER DEFAULT NULL,
  "express_price" REAL NOT NULL DEFAULT 0,
  "activity_express_name" TEXT NOT NULL DEFAULT '',
  "before_activity_express_price" REAL NOT NULL DEFAULT 0.00,
  "real_express_id" INTEGER NOT NULL DEFAULT 0,
  "real_express_region" INTEGER NOT NULL DEFAULT 0,
  "coupon_price" REAL NOT NULL DEFAULT 0.00,
  "origin_coupon_price" REAL NOT NULL DEFAULT 0.00,
  "add_price" REAL NOT NULL DEFAULT 0.00,
  "origin_add_price" REAL NOT NULL DEFAULT 0.00,
  "warehouse_add_price" REAL NOT NULL DEFAULT 0.00,
  "origin_warehouse_add_price" REAL NOT NULL DEFAULT 0.00,
  "express_add_price" REAL NOT NULL DEFAULT 0.00,
  "origin_express_add_price" REAL NOT NULL DEFAULT 0.00,
  "delivery_fee" REAL NOT NULL DEFAULT 0.00,
  "origin_delivery_fee" REAL NOT NULL DEFAULT 0.00,
  "modify_express_price" REAL NOT NULL DEFAULT 0.00,
  "is_change_express" INTEGER NOT NULL DEFAULT 0,
  "actual_express_price" REAL DEFAULT NULL,
  "origin_supply_price" REAL NOT NULL DEFAULT 0.00,
  "product_total_price" REAL NOT NULL DEFAULT 0,
  "origin_product_total_price" REAL NOT NULL DEFAULT 0.00,
  "service_fee" REAL NOT NULL DEFAULT 0.00,
  "origin_service_fee" REAL NOT NULL DEFAULT 0.00,
  "vip_discount_service_fee" REAL NOT NULL DEFAULT 0.00,
  "origin_vip_discount_service_fee" REAL NOT NULL DEFAULT 0.00,
  "platform_discount" REAL NOT NULL DEFAULT 0.00,
  "origin_platform_discount" REAL NOT NULL DEFAULT 0.00,
  "subsidy_price" REAL NOT NULL DEFAULT 0.00,
  "origin_subsidy_price" REAL NOT NULL DEFAULT 0.00,
  "negate_add_price" REAL NOT NULL DEFAULT 0.00,
  "origin_negate_add_price" REAL NOT NULL DEFAULT 0.00,
  "base_service_fee" REAL NOT NULL DEFAULT 0.00,
  "origin_base_service_fee" REAL NOT NULL DEFAULT 0.00,
  "total_price" REAL NOT NULL DEFAULT 0,
  "origin_total_price" REAL NOT NULL DEFAULT 0.00,
  "origin_use_xm_coin" REAL NOT NULL DEFAULT 0.00,
  "use_xm_coin" REAL NOT NULL DEFAULT 0.00,
  "rebate_xm_coin" REAL NOT NULL DEFAULT 0.00,
  "origin_rebate_xm_coin" REAL NOT NULL DEFAULT 0.00,
  "actual_price" REAL NOT NULL DEFAULT 0.00,
  "origin_actual_price" REAL NOT NULL DEFAULT 0.00,
  "ot_exp_add_price" REAL NOT NULL DEFAULT 0.00,
  "origin_ot_exp_add_price" REAL NOT NULL DEFAULT 0.00,
  "apply_price" REAL NOT NULL DEFAULT 0.00,
  "actual_refund" REAL NOT NULL DEFAULT 0.00,
  "actual_coin" REAL NOT NULL DEFAULT 0.00,
  "paid_price" REAL NOT NULL DEFAULT 0.00,
  "paid_coin" REAL NOT NULL DEFAULT 0.00,
  "pay_type" INTEGER NOT NULL DEFAULT 0,
  "pay_on_delivery" INTEGER NOT NULL DEFAULT 0,
  "receive_name" TEXT NOT NULL DEFAULT '',
  "receive_tel" TEXT NOT NULL DEFAULT '',
  "nation_code" TEXT NOT NULL DEFAULT '86',
  "province" TEXT NOT NULL DEFAULT '',
  "city" TEXT NOT NULL DEFAULT '',
  "district" TEXT NOT NULL DEFAULT '',
  "detail" TEXT NOT NULL DEFAULT '',
  "receive_address" TEXT NOT NULL DEFAULT '',
  "adcode" TEXT NOT NULL DEFAULT '',
  "buyer_memo" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "order_status" INTEGER NOT NULL DEFAULT 0,
  "after_sale_status" INTEGER NOT NULL DEFAULT 0,
  "after_sale_agree_type" INTEGER NOT NULL DEFAULT 0,
  "after_sale_count" INTEGER NOT NULL DEFAULT 0,
  "refund_status" INTEGER NOT NULL DEFAULT 0,
  "print_status" INTEGER NOT NULL DEFAULT 0,
  "wx_pay_time" TEXT DEFAULT NULL,
  "wx_pay_id" TEXT NOT NULL DEFAULT '',
  "send_time" TEXT DEFAULT NULL,
  "confirm_time" TEXT DEFAULT NULL,
  "extra_info" TEXT,
  "coupon_user_id" INTEGER NOT NULL DEFAULT 0,
  "is_comment" INTEGER NOT NULL DEFAULT 0,
  "is_open_after_sale" INTEGER NOT NULL DEFAULT 0,
  "is_deliver" INTEGER NOT NULL DEFAULT 0,
  "is_bond" INTEGER NOT NULL DEFAULT 0,
  "is_cotton" INTEGER NOT NULL DEFAULT 0,
  "flag" INTEGER NOT NULL DEFAULT 0,
  "bear_type" INTEGER NOT NULL DEFAULT 0,
  "is_bear_station_fee" INTEGER NOT NULL DEFAULT 0,
  "origin_total_station_fee" REAL NOT NULL DEFAULT 0.00,
  "total_station_fee" REAL NOT NULL DEFAULT 0.00,
  "is_presale" INTEGER NOT NULL DEFAULT 0,
  "is_sale_agency" INTEGER NOT NULL DEFAULT 0,
  "order_tag" INTEGER NOT NULL DEFAULT 0,
  "help_id" INTEGER NOT NULL DEFAULT 0,
  "pid" INTEGER NOT NULL DEFAULT 0,
  "ship_flag" INTEGER NOT NULL DEFAULT 0,
  "unqualified_way" INTEGER NOT NULL DEFAULT 0,
  "assign_customer_id" INTEGER NOT NULL DEFAULT 0,
  "assign_customer_name" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("order_sn")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_order22" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "vip_name" TEXT NOT NULL DEFAULT '',
  "order_sn" TEXT NOT NULL DEFAULT '',
  "order_type" INTEGER NOT NULL DEFAULT 0,
  "delivery_type" INTEGER NOT NULL DEFAULT 1,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "partner_model" INTEGER NOT NULL DEFAULT 0,
  "merchant_id" TEXT NOT NULL DEFAULT '',
  "app_id" TEXT NOT NULL DEFAULT '',
  "open_id" TEXT NOT NULL DEFAULT '',
  "distribution_type" INTEGER NOT NULL DEFAULT 0,
  "is_addition" INTEGER NOT NULL DEFAULT 0,
  "platform" INTEGER NOT NULL DEFAULT 0,
  "has_third_good" INTEGER NOT NULL DEFAULT 0,
  "is_zq_settlement" INTEGER NOT NULL DEFAULT 0,
  "send_no" TEXT NOT NULL DEFAULT '',
  "round_no" TEXT NOT NULL DEFAULT '',
  "order_num" INTEGER NOT NULL DEFAULT 1,
  "total_item_num" INTEGER NOT NULL DEFAULT 0,
  "total_weight" INTEGER NOT NULL DEFAULT 0,
  "origin_total_weight" INTEGER NOT NULL DEFAULT 0,
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "sub_shelf_sn" TEXT NOT NULL DEFAULT '',
  "zone" TEXT NOT NULL DEFAULT '',
  "shelf" TEXT NOT NULL DEFAULT '',
  "zone_shelf" TEXT NOT NULL DEFAULT '',
  "express" INTEGER NOT NULL DEFAULT 0,
  "express_region" INTEGER NOT NULL DEFAULT 0,
  "real_express_id" INTEGER NOT NULL DEFAULT 0,
  "real_express_region" INTEGER NOT NULL DEFAULT 0,
  "express_time" INTEGER DEFAULT NULL,
  "express_price" REAL NOT NULL DEFAULT 0,
  "before_activity_express_price" REAL DEFAULT 0.00,
  "activity_express_name" TEXT NOT NULL DEFAULT '',
  "coupon_price" REAL NOT NULL DEFAULT 0.00,
  "origin_coupon_price" REAL NOT NULL DEFAULT 0.00,
  "add_price" REAL NOT NULL DEFAULT 0.00,
  "origin_add_price" REAL NOT NULL DEFAULT 0.00,
  "warehouse_add_price" REAL NOT NULL DEFAULT 0.00,
  "origin_warehouse_add_price" REAL NOT NULL DEFAULT 0.00,
  "express_add_price" REAL NOT NULL DEFAULT 0.00,
  "origin_express_add_price" REAL NOT NULL DEFAULT 0.00,
  "ot_exp_add_price" REAL NOT NULL DEFAULT 0.00,
  "origin_ot_exp_add_price" REAL NOT NULL DEFAULT 0.00,
  "delivery_fee" REAL NOT NULL DEFAULT 0.00,
  "origin_delivery_fee" REAL NOT NULL DEFAULT 0.00,
  "modify_express_price" REAL NOT NULL DEFAULT 0.00,
  "is_change_express" INTEGER NOT NULL DEFAULT 0,
  "actual_express_price" REAL DEFAULT NULL,
  "origin_supply_price" REAL NOT NULL DEFAULT 0.00,
  "product_total_price" REAL NOT NULL DEFAULT 0,
  "origin_product_total_price" REAL NOT NULL DEFAULT 0.00,
  "service_fee" REAL NOT NULL DEFAULT 0.00,
  "origin_service_fee" REAL NOT NULL DEFAULT 0.00,
  "vip_discount_service_fee" REAL NOT NULL DEFAULT 0.00,
  "origin_vip_discount_service_fee" REAL NOT NULL DEFAULT 0.00,
  "platform_discount" REAL NOT NULL DEFAULT 0.00,
  "origin_platform_discount" REAL NOT NULL DEFAULT 0.00,
  "subsidy_price" REAL NOT NULL DEFAULT 0.00,
  "origin_subsidy_price" REAL NOT NULL DEFAULT 0.00,
  "negate_add_price" REAL NOT NULL DEFAULT 0.00,
  "origin_negate_add_price" REAL NOT NULL DEFAULT 0.00,
  "base_service_fee" REAL NOT NULL DEFAULT 0.00,
  "origin_base_service_fee" REAL NOT NULL DEFAULT 0.00,
  "total_price" REAL NOT NULL DEFAULT 0,
  "origin_total_price" REAL NOT NULL DEFAULT 0.00,
  "left_money" REAL NOT NULL DEFAULT 0.00,
  "origin_use_xm_coin" REAL NOT NULL DEFAULT 0.00,
  "use_xm_coin" REAL NOT NULL DEFAULT 0.00,
  "rebate_xm_coin" REAL NOT NULL DEFAULT 0.00,
  "origin_rebate_xm_coin" REAL NOT NULL DEFAULT 0.00,
  "actual_price" REAL NOT NULL DEFAULT 0.00,
  "origin_actual_price" REAL NOT NULL DEFAULT 0.00,
  "apply_price" REAL NOT NULL DEFAULT 0.00,
  "actual_refund" REAL NOT NULL DEFAULT 0.00,
  "actual_coin" REAL NOT NULL DEFAULT 0.00,
  "paid_price" REAL NOT NULL DEFAULT 0.00,
  "paid_coin" REAL NOT NULL DEFAULT 0.00,
  "pay_type" INTEGER NOT NULL DEFAULT 0,
  "pay_on_delivery" INTEGER NOT NULL DEFAULT 0,
  "receive_name" TEXT NOT NULL DEFAULT '',
  "receive_tel" TEXT NOT NULL DEFAULT '',
  "province" TEXT NOT NULL DEFAULT '',
  "city" TEXT NOT NULL DEFAULT '',
  "district" TEXT NOT NULL DEFAULT '',
  "detail" TEXT NOT NULL DEFAULT '',
  "receive_address" TEXT NOT NULL DEFAULT '',
  "nation_code" TEXT NOT NULL DEFAULT '86',
  "adcode" TEXT NOT NULL DEFAULT '',
  "buyer_memo" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "order_status" INTEGER NOT NULL DEFAULT 0,
  "after_sale_status" INTEGER NOT NULL DEFAULT 0,
  "after_sale_agree_type" INTEGER NOT NULL DEFAULT 0,
  "after_sale_count" INTEGER NOT NULL DEFAULT 0,
  "refund_status" INTEGER NOT NULL DEFAULT 0,
  "print_status" INTEGER NOT NULL DEFAULT 0,
  "wx_pay_time" TEXT DEFAULT NULL,
  "wx_pay_id" TEXT NOT NULL DEFAULT '',
  "send_time" TEXT DEFAULT NULL,
  "confirm_time" TEXT DEFAULT NULL,
  "extra_info" TEXT,
  "coupon_user_id" INTEGER NOT NULL DEFAULT 0,
  "is_comment" INTEGER NOT NULL DEFAULT 0,
  "is_open_after_sale" INTEGER NOT NULL DEFAULT 0,
  "is_deliver" INTEGER NOT NULL DEFAULT 0,
  "is_bond" INTEGER NOT NULL DEFAULT 0,
  "is_cotton" INTEGER NOT NULL DEFAULT 0,
  "flag" INTEGER NOT NULL DEFAULT 0,
  "bear_type" INTEGER NOT NULL DEFAULT 0,
  "is_bear_station_fee" INTEGER NOT NULL DEFAULT 0,
  "origin_total_station_fee" REAL NOT NULL DEFAULT 0.00,
  "total_station_fee" REAL NOT NULL DEFAULT 0.00,
  "is_presale" INTEGER NOT NULL DEFAULT 0,
  "is_sale_agency" INTEGER NOT NULL DEFAULT 0,
  "order_tag" INTEGER NOT NULL DEFAULT 0,
  "help_id" INTEGER NOT NULL DEFAULT 0,
  "pid" INTEGER NOT NULL DEFAULT 0,
  "unqualified_way" INTEGER NOT NULL DEFAULT 0,
  "assign_customer_id" INTEGER NOT NULL DEFAULT 0,
  "assign_customer_name" TEXT NOT NULL DEFAULT '',
  "ship_flag" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("order_sn")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_order_cancel_record" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "record_type" INTEGER DEFAULT 0,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "refund_purchaser" REAL DEFAULT 0.00,
  "deduct_supplier" REAL DEFAULT 0.00,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_order_comment" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "order_sn" TEXT NOT NULL DEFAULT '',
  "score" INTEGER NOT NULL DEFAULT 5,
  "content" TEXT NOT NULL DEFAULT '',
  "pictures" TEXT,
  "comment_time" TEXT NOT NULL DEFAULT '',
  "reply_admin_id" INTEGER NOT NULL DEFAULT 0,
  "reply_admin_name" TEXT NOT NULL DEFAULT '',
  "reply_content" TEXT NOT NULL DEFAULT '',
  "reply_pictures" TEXT,
  "reply_time" TEXT DEFAULT NULL,
  "is_show" INTEGER NOT NULL DEFAULT 1,
  UNIQUE ("order_sn")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_order_edit" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "field" TEXT NOT NULL DEFAULT '',
  "old_data" TEXT NOT NULL DEFAULT '',
  "new_data" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT ''
);
CREATE TABLE IF NOT EXISTS "xm_bulky_order_info" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "send_no" TEXT NOT NULL DEFAULT '',
  "api_order_sn" TEXT NOT NULL DEFAULT '',
  "has_cotton" INTEGER NOT NULL DEFAULT 0,
  "cotton_info" TEXT NOT NULL DEFAULT '',
  "promote_merchant_flag" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("order_sn")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_order_item" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "order_num" INTEGER NOT NULL DEFAULT 0,
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "sub_shelf_sn" TEXT NOT NULL DEFAULT '',
  "zone" TEXT NOT NULL DEFAULT '',
  "shelf" TEXT NOT NULL DEFAULT '',
  "zone_shelf" TEXT DEFAULT '',
  "order_sn" TEXT NOT NULL DEFAULT '',
  "round_no" TEXT NOT NULL DEFAULT '',
  "supplier_no" TEXT NOT NULL DEFAULT '',
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "product_name" TEXT NOT NULL DEFAULT '',
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "rank_num" INTEGER NOT NULL DEFAULT 1,
  "sku_config" TEXT NOT NULL DEFAULT '',
  "pic_url" TEXT NOT NULL DEFAULT '',
  "spec_and_num" TEXT NOT NULL DEFAULT '',
  "description" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "supply_price" REAL NOT NULL DEFAULT 0.00,
  "pay_price" REAL NOT NULL DEFAULT 0.00,
  "platform_discount_price" REAL NOT NULL DEFAULT 0.00,
  "subsidy_price" REAL NOT NULL DEFAULT 0.00,
  "coupon_pay_price" REAL NOT NULL DEFAULT 0.00,
  "total_discount_refundable" REAL NOT NULL DEFAULT 0.00,
  "origin_total_discount_refundable" REAL NOT NULL DEFAULT 0.00,
  "coupon_discount_per_bundle" REAL NOT NULL DEFAULT 0.00,
  "full_reduction_discount_per_bundle" REAL NOT NULL DEFAULT 0.00,
  "add_price" REAL NOT NULL DEFAULT 0.00,
  "total_add_price" REAL NOT NULL DEFAULT 0.00,
  "origin_total_add_price" REAL NOT NULL DEFAULT 0.00,
  "warehouse_add_price" REAL NOT NULL DEFAULT 0.00,
  "negate_add_price" REAL NOT NULL DEFAULT 0.00,
  "station_fee" REAL NOT NULL DEFAULT 0.00,
  "express_add_price" REAL NOT NULL DEFAULT 0.00,
  "item_num" INTEGER NOT NULL DEFAULT 0,
  "origin_item_num" INTEGER NOT NULL DEFAULT 0,
  "after_sale_item_num" INTEGER NOT NULL DEFAULT 0,
  "after_sale_refund" REAL NOT NULL DEFAULT 0.00,
  "bond_item_num" INTEGER NOT NULL DEFAULT 0,
  "after_sale_supplier_num" INTEGER NOT NULL DEFAULT 0,
  "actual_price" REAL NOT NULL DEFAULT 0.00,
  "origin_actual_price" REAL NOT NULL DEFAULT 0.00,
  "service_price" REAL NOT NULL DEFAULT 0.00,
  "partner_add_service_price" REAL NOT NULL DEFAULT 0.00,
  "total_partner_add_service_price" REAL NOT NULL DEFAULT 0.00,
  "total_price" REAL NOT NULL DEFAULT 0.00,
  "origin_total_price" REAL NOT NULL DEFAULT 0.00,
  "total_weight" INTEGER NOT NULL DEFAULT 0,
  "origin_total_weight" INTEGER NOT NULL DEFAULT 0,
  "is_comment" INTEGER NOT NULL DEFAULT 0,
  "after_sale_status" INTEGER NOT NULL DEFAULT 0,
  "refund_status" INTEGER NOT NULL DEFAULT 0,
  "printer_status" INTEGER NOT NULL DEFAULT 0,
  "printer_time" INTEGER DEFAULT 0,
  "is_deliver" INTEGER NOT NULL DEFAULT 0,
  "is_rebate" INTEGER NOT NULL DEFAULT 0,
  "third_good_id" INTEGER NOT NULL DEFAULT 0,
  "is_no_quality_issue" INTEGER NOT NULL DEFAULT 0,
  "is_prefer" INTEGER NOT NULL DEFAULT 0,
  "quality_flag" INTEGER NOT NULL DEFAULT 0,
  "deliver_time" TEXT DEFAULT NULL,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_order_item_comment" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "type" INTEGER NOT NULL DEFAULT 0,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "nickname" TEXT NOT NULL DEFAULT '',
  "avatar_url" TEXT DEFAULT '',
  "phone" TEXT NOT NULL DEFAULT '',
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "order_sn" TEXT NOT NULL DEFAULT '',
  "order_item_id" INTEGER DEFAULT 0,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "app_id" TEXT NOT NULL DEFAULT '',
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "score" INTEGER NOT NULL DEFAULT 5,
  "words" TEXT NOT NULL DEFAULT '',
  "content" TEXT NOT NULL DEFAULT '',
  "pictures" TEXT,
  "videos" TEXT,
  "comment_time" TEXT NOT NULL DEFAULT '',
  "reply_admin_id" INTEGER NOT NULL DEFAULT 0,
  "reply_admin_name" TEXT NOT NULL DEFAULT '',
  "reply_content" TEXT NOT NULL DEFAULT '',
  "reply_pictures" TEXT,
  "reply_time" TEXT DEFAULT NULL,
  "is_show" INTEGER NOT NULL DEFAULT 1,
  "is_show_shop" INTEGER NOT NULL DEFAULT 0,
  "is_show_product" INTEGER NOT NULL DEFAULT 0,
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_order_local" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "order_type" INTEGER NOT NULL DEFAULT 0,
  "is_addition" INTEGER NOT NULL DEFAULT 0,
  "platform" INTEGER NOT NULL DEFAULT 0,
  "send_no" TEXT NOT NULL DEFAULT '',
  "round_no" TEXT NOT NULL DEFAULT '',
  "order_num" INTEGER NOT NULL DEFAULT 1,
  "total_weight" INTEGER NOT NULL DEFAULT 0,
  "express" INTEGER NOT NULL DEFAULT 0,
  "express_region" INTEGER NOT NULL DEFAULT 0,
  "express_time" INTEGER DEFAULT NULL,
  "express_price" REAL NOT NULL DEFAULT 0,
  "add_price" REAL NOT NULL DEFAULT 0.00,
  "modify_express_price" REAL NOT NULL DEFAULT 0.00,
  "is_change_express" INTEGER NOT NULL DEFAULT 0,
  "actual_express_price" REAL DEFAULT NULL,
  "product_total_price" REAL NOT NULL DEFAULT 0,
  "service_fee" REAL NOT NULL DEFAULT 0.00,
  "base_service_fee" REAL NOT NULL DEFAULT 0.00,
  "total_price" REAL NOT NULL DEFAULT 0,
  "origin_use_xm_coin" REAL NOT NULL DEFAULT 0.00,
  "use_xm_coin" REAL NOT NULL DEFAULT 0.00,
  "rebate_xm_coin" REAL NOT NULL DEFAULT 0.00,
  "actual_price" REAL NOT NULL DEFAULT 0.00,
  "origin_actual_price" REAL NOT NULL DEFAULT 0.00,
  "apply_price" REAL NOT NULL DEFAULT 0.00,
  "actual_refund" REAL NOT NULL DEFAULT 0.00,
  "actual_coin" REAL NOT NULL DEFAULT 0.00,
  "paid_price" REAL NOT NULL DEFAULT 0.00,
  "paid_coin" REAL NOT NULL DEFAULT 0.00,
  "pay_type" INTEGER NOT NULL DEFAULT 0,
  "pay_on_delivery" INTEGER NOT NULL DEFAULT 0,
  "receive_name" TEXT NOT NULL DEFAULT '',
  "receive_tel" TEXT NOT NULL DEFAULT '',
  "receive_address" TEXT NOT NULL DEFAULT '',
  "adcode" TEXT NOT NULL DEFAULT '',
  "buyer_memo" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "order_status" INTEGER NOT NULL DEFAULT 0,
  "after_sale_status" INTEGER NOT NULL DEFAULT 0,
  "return_status" INTEGER NOT NULL DEFAULT 0,
  "after_sale_agree_type" INTEGER NOT NULL DEFAULT 0,
  "after_sale_count" INTEGER NOT NULL DEFAULT 0,
  "refund_status" INTEGER NOT NULL DEFAULT 0,
  "print_status" INTEGER NOT NULL DEFAULT 0,
  "wx_pay_time" TEXT DEFAULT NULL,
  "wx_pay_id" TEXT NOT NULL DEFAULT '',
  "send_time" TEXT DEFAULT NULL,
  "confirm_time" TEXT DEFAULT NULL,
  "extra_info" TEXT,
  "coupon_user_id" INTEGER NOT NULL DEFAULT 0,
  "is_comment" INTEGER NOT NULL DEFAULT 0,
  "is_open_after_sale" INTEGER NOT NULL DEFAULT 0,
  "is_bond" INTEGER NOT NULL DEFAULT 0,
  "is_cotton" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "is_deliver" INTEGER DEFAULT NULL,
  UNIQUE ("order_sn")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_order_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "pid" TEXT NOT NULL DEFAULT '',
  "order_sn" TEXT DEFAULT NULL,
  "wx_pay_id" TEXT DEFAULT NULL,
  "time" TEXT DEFAULT NULL,
  "type" TEXT DEFAULT NULL,
  "pay_type" TEXT DEFAULT NULL,
  "order_type" TEXT DEFAULT NULL,
  "total_price" REAL DEFAULT 0.00,
  "paid_coin" REAL DEFAULT 0.00,
  "paid_coin_new" REAL DEFAULT 0.00,
  "wechat_pay" REAL DEFAULT 0.00,
  "xm_credit" REAL DEFAULT 0.00,
  "xm_balance" REAL DEFAULT 0.00,
  "xm_wholesale" REAL DEFAULT 0.00,
  "product_price" REAL DEFAULT 0.00,
  "service_fee" REAL DEFAULT 0.00,
  "express_price" REAL DEFAULT 0.00,
  "ware_price" REAL DEFAULT 0.00,
  "supply_price" REAL DEFAULT 0.00,
  "take_ratio" REAL DEFAULT 0.00,
  UNIQUE ("pid")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_order_paid" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "reason_type" INTEGER NOT NULL DEFAULT 0,
  "paid_reason" TEXT NOT NULL DEFAULT '',
  "user_type" INTEGER NOT NULL DEFAULT 0,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "price" REAL NOT NULL DEFAULT 0,
  "xm_coin" REAL NOT NULL DEFAULT 0,
  "refund_status" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_order_reconciliation" (
  "source_channel" TEXT NOT NULL DEFAULT '',
  "source_id" INTEGER NOT NULL DEFAULT 0,
  "statement_date" TEXT NOT NULL DEFAULT '',
  "platform_name" TEXT DEFAULT NULL,
  "partner_name" TEXT DEFAULT NULL,
  "merchant_id" TEXT DEFAULT NULL,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "payment_no" TEXT DEFAULT NULL,
  "business_time" TEXT NOT NULL DEFAULT '',
  "order_type" TEXT NOT NULL DEFAULT '',
  "payment_method" TEXT DEFAULT NULL,
  "order_amount" REAL NOT NULL DEFAULT 0.00,
  "rebate_coin_amount" REAL NOT NULL DEFAULT 0.00,
  "subsidy_coin_amount" REAL NOT NULL DEFAULT 0.00,
  "online_payment_amount" REAL NOT NULL DEFAULT 0.00,
  "coupon_amount" REAL NOT NULL DEFAULT 0.00,
  "platform_reduce_amount" REAL NOT NULL DEFAULT 0.00,
  "credit_amount" REAL NOT NULL DEFAULT 0.00,
  "xunmeng_balance_amount" REAL NOT NULL DEFAULT 0.00,
  "wholesale_balance_amount" REAL NOT NULL DEFAULT 0.00,
  "distributor_balance_amount" REAL NOT NULL DEFAULT 0.00,
  "product_amount" REAL NOT NULL DEFAULT 0.00,
  "service_fee" REAL NOT NULL DEFAULT 0.00,
  "freight_amount" REAL NOT NULL DEFAULT 0.00,
  "distributor_markup_amount" REAL NOT NULL DEFAULT 0.00,
  "city_warehouse_settlement" REAL NOT NULL DEFAULT 0.00,
  "xunmeng_markup_amount" REAL NOT NULL DEFAULT 0.00,
  "item_subsidy_amount" REAL NOT NULL DEFAULT 0.00,
  "supplier_settlement" REAL NOT NULL DEFAULT 0.00,
  "commission_amount" REAL NOT NULL DEFAULT 0.00,
  "created_at" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "updated_at" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  PRIMARY KEY ("source_channel", "order_type", "source_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_order_remark_history" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "remark" TEXT,
  "remark_md5" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_pack_config" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "pack_name" TEXT NOT NULL DEFAULT '',
  "pack_weight" REAL NOT NULL DEFAULT 1.00,
  "flower_weight" REAL NOT NULL DEFAULT 1.00,
  "flower_volume" INTEGER NOT NULL DEFAULT 0,
  "pack_price" REAL NOT NULL DEFAULT 0.00,
  "labor_price" REAL NOT NULL DEFAULT 0.00,
  "logistics_price" REAL NOT NULL DEFAULT 0.00,
  "pic_url" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "sort" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_package_benefit" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "package_user_name" TEXT DEFAULT '',
  "package_user_id" INTEGER DEFAULT 0,
  "ware_id" INTEGER DEFAULT 0,
  "ware_name" TEXT DEFAULT '',
  "shelf_sn" TEXT DEFAULT NULL,
  "date" TEXT DEFAULT '',
  "total_weight" REAL DEFAULT 0.00,
  "total_price" REAL DEFAULT 0.00
);
CREATE TABLE IF NOT EXISTS "xm_bulky_package_box_modify_record" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "round_no" TEXT NOT NULL DEFAULT '',
  "send_no" TEXT NOT NULL DEFAULT '',
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "package_id" INTEGER NOT NULL DEFAULT 0,
  "origin_pack_id" INTEGER NOT NULL DEFAULT 0,
  "origin_pack_name" TEXT NOT NULL DEFAULT '',
  "target_pack_id" INTEGER NOT NULL DEFAULT 0,
  "target_pack_name" TEXT NOT NULL DEFAULT '',
  "operate_user_id" INTEGER NOT NULL DEFAULT 0,
  "operate_user_name" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_package_deadline_snapshot" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "round_no" TEXT NOT NULL DEFAULT '',
  "team_id" INTEGER NOT NULL DEFAULT 0,
  "team_name" TEXT NOT NULL DEFAULT '',
  "leader_id" INTEGER NOT NULL DEFAULT 0,
  "leader_name" TEXT NOT NULL DEFAULT '',
  "area_name_config" TEXT NOT NULL DEFAULT '',
  "zone_code_config" TEXT NOT NULL DEFAULT '',
  "shelf_count" INTEGER NOT NULL DEFAULT 0,
  "package_deadline_config" TEXT NOT NULL DEFAULT '',
  "required_complete_time" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("round_no", "team_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_package_modify_record" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "round_no" TEXT NOT NULL DEFAULT '',
  "send_no" TEXT NOT NULL DEFAULT '',
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "package_id" INTEGER NOT NULL DEFAULT 0,
  "origin_express_id" INTEGER NOT NULL DEFAULT 0,
  "origin_express_name" TEXT NOT NULL DEFAULT '',
  "target_express_id" INTEGER NOT NULL DEFAULT 0,
  "target_express_name" TEXT NOT NULL DEFAULT '',
  "operate_user_id" INTEGER NOT NULL DEFAULT 0,
  "operate_user_name" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_package_volume_compare" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "round_no" TEXT NOT NULL DEFAULT '',
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "express_id" INTEGER NOT NULL DEFAULT 0,
  "express_name" TEXT NOT NULL DEFAULT '',
  "item_num" INTEGER NOT NULL DEFAULT 0,
  "total_volume" REAL NOT NULL DEFAULT 0.00000,
  "no_volume_item_num" INTEGER NOT NULL DEFAULT 0,
  "normal_package_num" INTEGER NOT NULL DEFAULT 0,
  "normal_suggest_pack" TEXT NOT NULL DEFAULT '',
  "delete_package_num" INTEGER NOT NULL DEFAULT 0,
  "delete_suggest_pack" TEXT NOT NULL DEFAULT '',
  "actual_package_num" INTEGER NOT NULL DEFAULT 0,
  "actual_pack" TEXT NOT NULL DEFAULT '',
  "volume_package_num" INTEGER NOT NULL DEFAULT 0,
  "volume_suggest_pack" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_part_distributor_income" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "date" TEXT NOT NULL DEFAULT '',
  "num" INTEGER NOT NULL DEFAULT 0,
  "price" REAL NOT NULL DEFAULT 0.00,
  "type" INTEGER NOT NULL DEFAULT 1,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "username" TEXT NOT NULL DEFAULT '',
  "detail" TEXT NOT NULL DEFAULT '',
  "settle_flag" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("date", "user_id", "type")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_part_logistics" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "date" TEXT NOT NULL DEFAULT '',
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "user_name" TEXT NOT NULL DEFAULT '',
  "manage_id" INTEGER NOT NULL DEFAULT 0,
  "manage_name" TEXT NOT NULL DEFAULT '',
  "start_manage_id" INTEGER NOT NULL DEFAULT 0,
  "start_manage_name" TEXT NOT NULL DEFAULT '',
  "end_manage_id" INTEGER NOT NULL DEFAULT 0,
  "end_manage_name" TEXT NOT NULL DEFAULT '',
  "start_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "end_time" TEXT DEFAULT NULL,
  "price" REAL NOT NULL DEFAULT 0.00,
  "total_price" REAL NOT NULL DEFAULT 0.00,
  "duration" REAL NOT NULL DEFAULT 0.00,
  "settle_flag" INTEGER NOT NULL DEFAULT 0,
  "user_type" INTEGER NOT NULL DEFAULT 1
);
CREATE TABLE IF NOT EXISTS "xm_bulky_part_logistics_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "part_logistics_id" INTEGER NOT NULL DEFAULT 0,
  "old_start_time" TEXT NOT NULL DEFAULT '',
  "new_start_time" TEXT NOT NULL DEFAULT '',
  "old_end_time" TEXT NOT NULL DEFAULT '',
  "new_end_time" TEXT NOT NULL DEFAULT '',
  "duration" REAL NOT NULL DEFAULT 0.00,
  "content" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_pay_type" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "biz_type" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "channel_code" TEXT NOT NULL DEFAULT '',
  "mch_id" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "sort" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_phone_call" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "phone" TEXT NOT NULL DEFAULT '',
  "call_id" TEXT NOT NULL DEFAULT '',
  "duration" INTEGER NOT NULL DEFAULT 0,
  "create_time" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_phone_change_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "old_phone" TEXT NOT NULL DEFAULT '',
  "old_phone_hash" TEXT NOT NULL DEFAULT '',
  "new_phone" TEXT NOT NULL DEFAULT '',
  "operator_type" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER DEFAULT NULL,
  "operator_name" TEXT DEFAULT NULL,
  "reason" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_platform" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_platform_bind" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "session_key" TEXT DEFAULT '',
  "open_id" TEXT DEFAULT '',
  "platform" INTEGER DEFAULT 1,
  "create_time" TEXT DEFAULT NULL,
  "update_time" TEXT DEFAULT NULL,
  "data_status" INTEGER DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_platform_invoice" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "request_no" TEXT NOT NULL DEFAULT '',
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "purchaser_phone" TEXT DEFAULT NULL,
  "registration_id" INTEGER DEFAULT NULL,
  "invoice_type" INTEGER NOT NULL DEFAULT 0,
  "title_name" TEXT DEFAULT NULL,
  "tax_number" TEXT DEFAULT NULL,
  "bank_name" TEXT DEFAULT NULL,
  "bank_account" TEXT DEFAULT NULL,
  "company_address" TEXT DEFAULT NULL,
  "company_phone" TEXT DEFAULT NULL,
  "amount" REAL NOT NULL DEFAULT 0,
  "invoice_url" TEXT DEFAULT NULL,
  "status" INTEGER NOT NULL DEFAULT 0,
  "deadline" TEXT DEFAULT NULL,
  "upload_time" TEXT DEFAULT NULL,
  "operator_id" INTEGER DEFAULT NULL,
  "operator_name" TEXT DEFAULT NULL,
  "remark" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("request_no")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_price_mgr_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "rank_num" INTEGER NOT NULL DEFAULT 0,
  "old_price" REAL NOT NULL DEFAULT 0.00,
  "new_price" REAL NOT NULL DEFAULT 0.00,
  "version" TEXT NOT NULL DEFAULT '',
  "opeartor_id" INTEGER NOT NULL DEFAULT 0,
  "opeartor_name" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "is_success" INTEGER NOT NULL DEFAULT 0,
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_price_operation_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "biz_id" TEXT DEFAULT NULL,
  "biz_name" TEXT NOT NULL DEFAULT '',
  "operation_type" TEXT NOT NULL DEFAULT '',
  "operation_desc" TEXT NOT NULL DEFAULT '',
  "before_data" TEXT,
  "after_data" TEXT,
  "result_status" INTEGER NOT NULL DEFAULT 1,
  "fail_reason" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER DEFAULT NULL,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_price_rule" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_price_rule_class" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "rule_id" INTEGER NOT NULL DEFAULT 0,
  "class_level" INTEGER NOT NULL DEFAULT 0,
  "class_id" INTEGER NOT NULL DEFAULT 0,
  "first_id" INTEGER NOT NULL DEFAULT 0,
  "add_price_a" REAL NOT NULL DEFAULT 0.00,
  "add_price_b" REAL NOT NULL DEFAULT 0.00,
  "add_price_c" REAL NOT NULL DEFAULT 0.00,
  "add_price_d" REAL NOT NULL DEFAULT 0.00,
  "add_price_e" REAL NOT NULL DEFAULT 0.00,
  "add_price_o" REAL NOT NULL DEFAULT 0.00,
  "add_price_none" REAL NOT NULL DEFAULT 0.00,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("rule_id", "class_level", "class_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_price_strategy" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL DEFAULT '',
  "strategy_type" INTEGER NOT NULL DEFAULT 0,
  "rule_id" INTEGER DEFAULT NULL,
  "effect_type" INTEGER NOT NULL DEFAULT 2,
  "effect_start_time" TEXT DEFAULT NULL,
  "effect_end_time" TEXT DEFAULT NULL,
  "status" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_price_strategy_target" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "strategy_id" INTEGER NOT NULL DEFAULT 0,
  "target_type" INTEGER NOT NULL DEFAULT 0,
  "target_code" TEXT NOT NULL DEFAULT '',
  "target_name" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("strategy_id", "target_type", "target_code")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_print_config" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "supplier_id" INTEGER NOT NULL DEFAULT 1,
  "environment" INTEGER NOT NULL DEFAULT 0,
  "source" INTEGER NOT NULL DEFAULT 1,
  "name" TEXT NOT NULL DEFAULT '',
  "type" INTEGER NOT NULL DEFAULT 0,
  "info" TEXT,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_print_device" (
  "id" TEXT NOT NULL DEFAULT '',
  "pic_url" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  PRIMARY KEY ("id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_print_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "cp_code" TEXT NOT NULL DEFAULT '',
  "operation_data" TEXT,
  "operation_result" TEXT,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT ''
);
CREATE TABLE IF NOT EXISTS "xm_bulky_print_logistics" (
  "print_logistics_id" INTEGER NOT NULL DEFAULT 0,
  "servicebrand" TEXT NOT NULL DEFAULT '',
  "printemplate" TEXT DEFAULT NULL,
  "name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER DEFAULT 0,
  "source" INTEGER DEFAULT 1,
  "ids" INTEGER PRIMARY KEY AUTOINCREMENT,
  UNIQUE ("servicebrand"),
  UNIQUE ("print_logistics_id", "source")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_print_logistics_config" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "configid" INTEGER NOT NULL DEFAULT 0,
  "print_logistics_id" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT DEFAULT NULL,
  "create_time" TEXT DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER DEFAULT 0,
  UNIQUE ("configid")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_print_printers" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "source" INTEGER NOT NULL DEFAULT 1,
  "agent_id" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_print_template" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL DEFAULT '',
  "template_id" TEXT NOT NULL DEFAULT '',
  "is_show" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("template_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_product" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "third_good_id" INTEGER NOT NULL DEFAULT 0,
  "product_type" INTEGER NOT NULL DEFAULT 0,
  "first_id" INTEGER NOT NULL DEFAULT 0,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "is_sale_agency" INTEGER NOT NULL DEFAULT 0,
  "code" TEXT NOT NULL DEFAULT '',
  "name" TEXT NOT NULL DEFAULT '',
  "product_tag" TEXT NOT NULL DEFAULT '',
  "rank_num" INTEGER NOT NULL DEFAULT 1,
  "sku_config" TEXT NOT NULL DEFAULT '',
  "color" TEXT NOT NULL DEFAULT '',
  "pic_url" TEXT NOT NULL DEFAULT '',
  "price" REAL NOT NULL DEFAULT 0.0,
  "description" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "after_sale_times" INTEGER NOT NULL DEFAULT 0,
  "sell_times" INTEGER NOT NULL DEFAULT 0,
  "today_sell_count" INTEGER NOT NULL DEFAULT 0,
  "last_sell_count" INTEGER NOT NULL DEFAULT 0,
  "month_sell_count" INTEGER NOT NULL DEFAULT 0,
  "sell_count" INTEGER NOT NULL DEFAULT 0,
  "max_stock" INTEGER NOT NULL DEFAULT 9999,
  "remain_stock" INTEGER NOT NULL DEFAULT 0,
  "offline_stock" INTEGER NOT NULL DEFAULT 0,
  "offline_switch" INTEGER NOT NULL DEFAULT 0,
  "limit_switch" INTEGER NOT NULL DEFAULT 0,
  "limit_sale" INTEGER NOT NULL DEFAULT 9999,
  "night_sale_flag" INTEGER NOT NULL DEFAULT 1,
  "product_status" INTEGER NOT NULL DEFAULT 0,
  "freeze_reason" TEXT NOT NULL DEFAULT '',
  "low_flag" INTEGER NOT NULL DEFAULT 0,
  "low_level" INTEGER NOT NULL DEFAULT 0,
  "is_hot" INTEGER NOT NULL DEFAULT 0,
  "on_sale_time_str" TEXT NOT NULL DEFAULT '',
  "not_sale_time_str" TEXT NOT NULL DEFAULT '',
  "is_close_auto" INTEGER NOT NULL DEFAULT 0,
  "is_rebate" INTEGER NOT NULL DEFAULT 0,
  "is_special" INTEGER NOT NULL DEFAULT 1,
  "special_sort" INTEGER NOT NULL DEFAULT 0,
  "is_seckill" INTEGER NOT NULL DEFAULT 1,
  "seckill_add_price" REAL NOT NULL DEFAULT 0.00,
  "seckill_deadline" TEXT DEFAULT NULL,
  "seckill_sort" INTEGER NOT NULL DEFAULT 0,
  "plan_id" INTEGER NOT NULL DEFAULT 0,
  "platform_discount_price" REAL NOT NULL DEFAULT 0.00,
  "subsidy_price" REAL NOT NULL DEFAULT 0.00,
  "is_presale" INTEGER NOT NULL DEFAULT 0,
  "quasi_prefer" INTEGER NOT NULL DEFAULT 0,
  "is_prefer" INTEGER NOT NULL DEFAULT 0,
  "prefer_time" TEXT DEFAULT NULL,
  "prefer_end_time" TEXT DEFAULT NULL,
  "presale_end_time" TEXT DEFAULT NULL,
  "expire_time" TEXT NOT NULL DEFAULT '',
  "replenish_auto_onsale" INTEGER NOT NULL DEFAULT 0,
  "return_processing" INTEGER NOT NULL DEFAULT 0,
  "sell_prefer" INTEGER NOT NULL DEFAULT 0,
  "auto_sell_prefer" INTEGER NOT NULL DEFAULT 1,
  "seven_sell_count" INTEGER NOT NULL DEFAULT 0,
  "seven_no_lower_rank" INTEGER NOT NULL DEFAULT 0,
  "seven_no_refund" INTEGER NOT NULL DEFAULT 0,
  "seven_no_lack" INTEGER NOT NULL DEFAULT 0,
  "seven_no_aftersale" INTEGER NOT NULL DEFAULT 0,
  "thirty_no_aftersale" INTEGER NOT NULL DEFAULT 0,
  "quality_flag" INTEGER NOT NULL DEFAULT 0,
  "freeze_level" INTEGER NOT NULL DEFAULT 0,
  "last_block_record" TEXT,
  "show_flag" INTEGER NOT NULL DEFAULT 1,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "recommend_num" INTEGER NOT NULL DEFAULT 0,
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_product_comment_score_daily" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "score_date" TEXT NOT NULL DEFAULT '',
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "praise_count" INTEGER NOT NULL DEFAULT 0,
  "comment_num" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("product_id", "score_date")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_product_comment_stats" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "app_id" TEXT NOT NULL DEFAULT '',
  "good_comment_count" INTEGER NOT NULL DEFAULT 0,
  "comment_count" INTEGER NOT NULL DEFAULT 0,
  "stat_date" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  UNIQUE ("app_id", "product_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_product_daily_sell" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "product_name" TEXT NOT NULL DEFAULT '',
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "supplier_tag" TEXT NOT NULL DEFAULT '',
  "round_no" TEXT NOT NULL DEFAULT '',
  "sell_count" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_product_info" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "praise_count" INTEGER NOT NULL DEFAULT 0,
  "praise_ratio" REAL NOT NULL DEFAULT 0.00,
  "positive_rating_flag" INTEGER NOT NULL DEFAULT 0,
  "recent_sale_count" INTEGER NOT NULL DEFAULT 0,
  "favorite_count" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("product_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_product_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "type" INTEGER NOT NULL DEFAULT 0,
  "price" REAL NOT NULL DEFAULT 0.00,
  "stock_num" INTEGER NOT NULL DEFAULT 0,
  "source" INTEGER DEFAULT NULL,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "content" TEXT,
  "user_type" INTEGER NOT NULL DEFAULT 0,
  "freeze_day" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_product_quality_parameter" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "round_no" TEXT NOT NULL DEFAULT '',
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "rank_num" INTEGER NOT NULL DEFAULT 0,
  "source_punish_count" INTEGER NOT NULL DEFAULT 0,
  "problem_num" INTEGER NOT NULL DEFAULT 0,
  "supply_num" INTEGER NOT NULL DEFAULT 0,
  "problem_ratio" REAL NOT NULL DEFAULT 0.0000,
  "recent_effective_count" INTEGER NOT NULL DEFAULT 0,
  "upgrade_flag" INTEGER NOT NULL DEFAULT 0,
  "rule_status" INTEGER NOT NULL DEFAULT 0,
  "rule_version" TEXT NOT NULL DEFAULT '',
  "calculated_at" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("round_no", "product_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_product_quality_record" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "dn_flag" INTEGER NOT NULL DEFAULT 0,
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "round_no" TEXT NOT NULL DEFAULT '',
  "thirty_sale_flag" INTEGER NOT NULL DEFAULT 0,
  "thirty_sale_day" INTEGER NOT NULL DEFAULT 0,
  "seven_sale_flag" INTEGER NOT NULL DEFAULT 0,
  "seven_sale_day" INTEGER NOT NULL DEFAULT 0,
  "thirty_prefer_flag" INTEGER NOT NULL DEFAULT 0,
  "thirty_prefer_day" INTEGER NOT NULL DEFAULT 0,
  "thirty_quasi_prefer_day" INTEGER NOT NULL DEFAULT 0,
  "thirty_quality_quasi_prefer_day" INTEGER NOT NULL DEFAULT 0,
  "thirty_quality_prefer_day" INTEGER NOT NULL DEFAULT 0,
  "seven_prefer_flag" INTEGER NOT NULL DEFAULT 0,
  "seven_prefer_day" INTEGER NOT NULL DEFAULT 0,
  "seven_quasi_prefer_day" INTEGER NOT NULL DEFAULT 0,
  "seven_quality_quasi_prefer_day" INTEGER NOT NULL DEFAULT 0,
  "seven_quality_prefer_day" INTEGER NOT NULL DEFAULT 0,
  "three_prefer_flag" INTEGER NOT NULL DEFAULT 0,
  "three_prefer_day" INTEGER NOT NULL DEFAULT 0,
  "three_quasi_prefer_day" INTEGER NOT NULL DEFAULT 0,
  "three_quality_quasi_prefer_day" INTEGER NOT NULL DEFAULT 0,
  "three_quality_prefer_day" INTEGER NOT NULL DEFAULT 0,
  "thirty_praise_flag" INTEGER NOT NULL DEFAULT 0,
  "thirty_praise_time" INTEGER NOT NULL DEFAULT 0,
  "thirty_praise_ratio" REAL NOT NULL DEFAULT 0.000,
  "thirty_repurchase_flag" INTEGER NOT NULL DEFAULT 0,
  "thirty_repurchase_time" INTEGER NOT NULL DEFAULT 0,
  "quality_flag" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_product_repurchase_stats" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "second_id" INTEGER DEFAULT NULL,
  "repurchase_count" INTEGER NOT NULL DEFAULT 0,
  "stat_date" TEXT NOT NULL DEFAULT '',
  "created_at" TEXT DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("product_id", "stat_date")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_product_restrict_detail" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "rule_id" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("product_id", "rule_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_product_restrict_rule" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL DEFAULT '',
  "restrict_num" INTEGER NOT NULL DEFAULT 1,
  "product_num" INTEGER NOT NULL DEFAULT 0,
  "start_time" TEXT NOT NULL DEFAULT '',
  "end_time" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 1,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_product_sale_parameter" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "round_no" TEXT NOT NULL DEFAULT '',
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "seven_after_sale_price" REAL NOT NULL DEFAULT 0.00,
  "seven_refund_price" REAL NOT NULL DEFAULT 0.00,
  "seven_exchange_price" REAL NOT NULL DEFAULT 0.00,
  "seven_sale_price" REAL NOT NULL DEFAULT 0.00,
  "seven_ratio" REAL NOT NULL DEFAULT 0.0000,
  "fourteen_after_sale_price" REAL NOT NULL DEFAULT 0.00,
  "fourteen_refund_price" REAL NOT NULL DEFAULT 0.00,
  "fourteen_exchange_price" REAL NOT NULL DEFAULT 0.00,
  "fourteen_sale_price" REAL NOT NULL DEFAULT 0.00,
  "fourteen_ratio" REAL NOT NULL DEFAULT 0.0000,
  "thirty_after_sale_price" REAL NOT NULL DEFAULT 0.00,
  "thirty_refund_price" REAL NOT NULL DEFAULT 0.00,
  "thirty_exchange_price" REAL NOT NULL DEFAULT 0.00,
  "thirty_sale_price" REAL NOT NULL DEFAULT 0.00,
  "thirty_ratio" REAL NOT NULL DEFAULT 0.0000,
  "seven_num" INTEGER NOT NULL DEFAULT 0,
  "fourteen_num" INTEGER NOT NULL DEFAULT 0,
  "thirty_num" INTEGER NOT NULL DEFAULT 0,
  "seven_no_aftersale" INTEGER NOT NULL DEFAULT 0,
  "fourteen_no_aftersale" INTEGER NOT NULL DEFAULT 0,
  "thirty_no_aftersale" INTEGER NOT NULL DEFAULT 0,
  "sell_prefer" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "base_rate" REAL NOT NULL DEFAULT 0.0000,
  "smooth_rate" REAL NOT NULL DEFAULT 0.0000,
  "second_rate" REAL NOT NULL DEFAULT 0.0000,
  "recent_num" INTEGER NOT NULL DEFAULT 0,
  "recent_active_round" INTEGER NOT NULL DEFAULT 0,
  "sale_tier" INTEGER NOT NULL DEFAULT 0,
  "prefer_way" INTEGER NOT NULL DEFAULT 0,
  "seven_capped_amount" REAL NOT NULL DEFAULT 0.00,
  "seven_complain_amount" REAL NOT NULL DEFAULT 0.00,
  "fourteen_capped_amount" REAL NOT NULL DEFAULT 0.00,
  "fourteen_complain_amount" REAL NOT NULL DEFAULT 0.00,
  "thirty_capped_amount" REAL NOT NULL DEFAULT 0.00,
  "thirty_complain_amount" REAL NOT NULL DEFAULT 0.00,
  UNIQUE ("round_no", "product_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_product_sale_parameter2" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "round_no" TEXT NOT NULL DEFAULT '',
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "seven_after_sale_price" REAL NOT NULL DEFAULT 0.00,
  "seven_refund_price" REAL NOT NULL DEFAULT 0.00,
  "seven_exchange_price" REAL NOT NULL DEFAULT 0.00,
  "seven_sale_price" REAL NOT NULL DEFAULT 0.00,
  "seven_ratio" REAL NOT NULL DEFAULT 0.0000,
  "fourteen_after_sale_price" REAL NOT NULL DEFAULT 0.00,
  "fourteen_refund_price" REAL NOT NULL DEFAULT 0.00,
  "fourteen_exchange_price" REAL NOT NULL DEFAULT 0.00,
  "fourteen_sale_price" REAL NOT NULL DEFAULT 0.00,
  "fourteen_ratio" REAL NOT NULL DEFAULT 0.0000,
  "thirty_after_sale_price" REAL NOT NULL DEFAULT 0.00,
  "thirty_refund_price" REAL NOT NULL DEFAULT 0.00,
  "thirty_exchange_price" REAL NOT NULL DEFAULT 0.00,
  "thirty_sale_price" REAL NOT NULL DEFAULT 0.00,
  "thirty_ratio" REAL NOT NULL DEFAULT 0.0000,
  "seven_num" INTEGER NOT NULL DEFAULT 0,
  "fourteen_num" INTEGER NOT NULL DEFAULT 0,
  "thirty_num" INTEGER NOT NULL DEFAULT 0,
  "seven_no_aftersale" INTEGER NOT NULL DEFAULT 0,
  "fourteen_no_aftersale" INTEGER NOT NULL DEFAULT 0,
  "thirty_no_aftersale" INTEGER NOT NULL DEFAULT 0,
  "sell_prefer" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "base_rate" REAL NOT NULL DEFAULT 0.0000,
  "smooth_rate" REAL NOT NULL DEFAULT 0.0000,
  "second_rate" REAL NOT NULL DEFAULT 0.0000,
  "recent_num" INTEGER NOT NULL DEFAULT 0,
  "recent_active_round" INTEGER NOT NULL DEFAULT 0,
  "sale_tier" INTEGER NOT NULL DEFAULT 0,
  "prefer_way" INTEGER NOT NULL DEFAULT 0,
  "seven_capped_amount" REAL NOT NULL DEFAULT 0.00,
  "seven_complain_amount" REAL NOT NULL DEFAULT 0.00,
  "fourteen_capped_amount" REAL NOT NULL DEFAULT 0.00,
  "fourteen_complain_amount" REAL NOT NULL DEFAULT 0.00,
  "thirty_capped_amount" REAL NOT NULL DEFAULT 0.00,
  "thirty_complain_amount" REAL NOT NULL DEFAULT 0.00,
  UNIQUE ("round_no", "product_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_product_sell_record" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "start_date" TEXT NOT NULL DEFAULT '',
  "end_date" TEXT NOT NULL DEFAULT '',
  "after_sale_times" INTEGER NOT NULL DEFAULT 0,
  "sell_times" INTEGER NOT NULL DEFAULT 0,
  "sell_volume" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_product_subsidy" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "app_id" TEXT NOT NULL DEFAULT '',
  "config_id" INTEGER NOT NULL DEFAULT 0,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "rank_num" INTEGER NOT NULL DEFAULT 0,
  "subsidy_price" REAL NOT NULL DEFAULT 0.00,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("product_id", "app_id", "config_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_product_task" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "task_time_str" TEXT NOT NULL DEFAULT '',
  "task_type" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_product_template" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "third_good_id" INTEGER NOT NULL DEFAULT 0,
  "code" TEXT NOT NULL DEFAULT '',
  "name" TEXT NOT NULL DEFAULT '',
  "rank_num" INTEGER NOT NULL DEFAULT 1,
  "color" TEXT NOT NULL DEFAULT '',
  "pic_url" TEXT NOT NULL DEFAULT '',
  "price" REAL NOT NULL DEFAULT 0.00,
  "description" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "after_sale_times" INTEGER NOT NULL DEFAULT 0,
  "sell_times" INTEGER NOT NULL DEFAULT 0,
  "today_sell_count" INTEGER NOT NULL DEFAULT 0,
  "last_sell_count" INTEGER NOT NULL DEFAULT 0,
  "month_sell_count" INTEGER NOT NULL DEFAULT 0,
  "sell_count" INTEGER NOT NULL DEFAULT 0,
  "max_stock" INTEGER NOT NULL DEFAULT 9999,
  "remain_stock" INTEGER NOT NULL DEFAULT 0,
  "limit_sale" INTEGER NOT NULL DEFAULT 9999,
  "product_status" INTEGER NOT NULL DEFAULT 0,
  "freeze_reason" TEXT NOT NULL DEFAULT '',
  "is_hot" INTEGER NOT NULL DEFAULT 0,
  "on_sale_time_str" TEXT NOT NULL DEFAULT '',
  "not_sale_time_str" TEXT NOT NULL DEFAULT '',
  "is_close_auto" INTEGER NOT NULL DEFAULT 0,
  "is_rebate" INTEGER NOT NULL DEFAULT 1,
  "is_special" INTEGER NOT NULL DEFAULT 1,
  "special_sort" INTEGER NOT NULL DEFAULT 0,
  "is_seckill" INTEGER NOT NULL DEFAULT 1,
  "seckill_add_price" REAL NOT NULL DEFAULT 0.00,
  "seckill_deadline" TEXT DEFAULT NULL,
  "seckill_sort" INTEGER NOT NULL DEFAULT 0,
  "is_presale" INTEGER NOT NULL DEFAULT 0,
  "is_prefer" INTEGER NOT NULL DEFAULT 0,
  "prefer_time" TEXT DEFAULT NULL,
  "prefer_end_time" TEXT DEFAULT NULL,
  "presale_end_time" TEXT DEFAULT NULL,
  "expire_time" TEXT NOT NULL DEFAULT '',
  "replenish_auto_onsale" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_product_video" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "first_id" INTEGER NOT NULL DEFAULT 0,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "video_cover" TEXT NOT NULL DEFAULT '',
  "video_url" TEXT NOT NULL DEFAULT '',
  "water_url" TEXT NOT NULL DEFAULT '',
  "trans_status" INTEGER NOT NULL DEFAULT 0,
  "trans_id" TEXT NOT NULL DEFAULT '',
  "reject_reason" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 2,
  "expires_time" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_purchaser" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "zq_user_id" INTEGER NOT NULL DEFAULT 0,
  "platform" INTEGER NOT NULL DEFAULT 0,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "xm_account" TEXT NOT NULL DEFAULT '',
  "xm_com_id" INTEGER NOT NULL DEFAULT 0,
  "company_direct_sale_store" INTEGER NOT NULL DEFAULT 0,
  "company_level" INTEGER NOT NULL DEFAULT 6,
  "xm_coin" REAL NOT NULL DEFAULT 0.00,
  "xm_coin_income" REAL NOT NULL DEFAULT 0.00,
  "xm_coin_expend" REAL NOT NULL DEFAULT 0.00,
  "xm_coin_give" REAL NOT NULL DEFAULT 0.00,
  "xm_coin_rebate" REAL NOT NULL DEFAULT 0.00,
  "xm_coin_paid" REAL NOT NULL DEFAULT 0.00,
  "phone_number" TEXT NOT NULL DEFAULT '',
  "password" TEXT NOT NULL DEFAULT '',
  "salt" TEXT NOT NULL DEFAULT '',
  "app_id" TEXT NOT NULL DEFAULT '',
  "open_id" TEXT NOT NULL DEFAULT '',
  "zc_open_id" TEXT NOT NULL DEFAULT '',
  "session_key" TEXT NOT NULL DEFAULT '',
  "gender" INTEGER NOT NULL DEFAULT 0,
  "province" TEXT NOT NULL DEFAULT '',
  "city" TEXT NOT NULL DEFAULT '',
  "country" TEXT NOT NULL DEFAULT '',
  "area_type" INTEGER NOT NULL DEFAULT 0,
  "auto_area_flag" INTEGER NOT NULL DEFAULT 1,
  "nickname" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "avatar_url" TEXT NOT NULL DEFAULT '',
  "pic_avatar_url" TEXT NOT NULL DEFAULT '',
  "pic_user_background_url" TEXT NOT NULL DEFAULT '',
  "pic_user_introduction" TEXT NOT NULL DEFAULT '',
  "help_id" INTEGER NOT NULL DEFAULT 0,
  "ma_help_id" INTEGER NOT NULL DEFAULT 0,
  "pid" INTEGER NOT NULL DEFAULT 0,
  "last_login_time" TEXT DEFAULT NULL,
  "last_login_ip" TEXT DEFAULT NULL,
  "class_type" INTEGER NOT NULL DEFAULT 1,
  "contact_supplier_count" INTEGER NOT NULL DEFAULT 3,
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "config_id" INTEGER NOT NULL DEFAULT 0,
  "first_buy_time" TEXT NOT NULL DEFAULT '',
  "last_buy_time" TEXT NOT NULL DEFAULT '',
  "last_second_buy_time" TEXT NOT NULL DEFAULT '',
  "buy_times" INTEGER NOT NULL DEFAULT 0,
  "ma_first_buy_time" TEXT NOT NULL DEFAULT '',
  "ma_last_buy_time" TEXT NOT NULL DEFAULT '',
  "ma_month_buy_time" INTEGER NOT NULL DEFAULT 0,
  "bb_flag" INTEGER NOT NULL DEFAULT 0,
  "month_consumption" REAL NOT NULL DEFAULT 0.00,
  "total_consumption" REAL NOT NULL DEFAULT 0.00,
  "item_num" INTEGER NOT NULL DEFAULT 0,
  "last_recall_time" TEXT DEFAULT NULL,
  "month_item_num" INTEGER NOT NULL DEFAULT 0,
  "block_flag" INTEGER NOT NULL DEFAULT 0,
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "holiday_white_flag" INTEGER NOT NULL DEFAULT 0,
  "internal_employee_flag" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT DEFAULT NULL,
  "phone_change_time" TEXT DEFAULT NULL,
  "phone_change_version" INTEGER NOT NULL DEFAULT 0,
  "express_recommend_flag" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("phone_number", "app_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_purchaser_account_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "year" INTEGER NOT NULL DEFAULT 0,
  "month" INTEGER NOT NULL DEFAULT 0,
  "day" INTEGER NOT NULL DEFAULT 0,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "business_type" INTEGER NOT NULL DEFAULT 0,
  "pay_type" INTEGER NOT NULL DEFAULT 0,
  "xm_refund_id" INTEGER NOT NULL DEFAULT 0,
  "xm_coin" REAL NOT NULL DEFAULT 0.00,
  "paid_coin" REAL NOT NULL DEFAULT 0.00,
  "remark" TEXT NOT NULL DEFAULT '',
  "money" REAL NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT ''
);
CREATE TABLE IF NOT EXISTS "xm_bulky_purchaser_address" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "type" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "phone_number" TEXT NOT NULL DEFAULT '',
  "longitude" TEXT NOT NULL DEFAULT '',
  "latitude" TEXT NOT NULL DEFAULT '',
  "province" TEXT NOT NULL DEFAULT '',
  "province_code" TEXT NOT NULL DEFAULT '',
  "city" TEXT NOT NULL DEFAULT '',
  "city_code" TEXT NOT NULL DEFAULT '',
  "country" TEXT NOT NULL DEFAULT '',
  "country_code" TEXT NOT NULL DEFAULT '',
  "nation_code" TEXT NOT NULL DEFAULT '86',
  "address_name" TEXT NOT NULL DEFAULT '',
  "address_detail" TEXT NOT NULL DEFAULT '',
  "detail" TEXT NOT NULL DEFAULT '',
  "is_default" INTEGER NOT NULL DEFAULT 0,
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT DEFAULT NULL
);
CREATE TABLE IF NOT EXISTS "xm_bulky_purchaser_airport" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "airport_id" INTEGER NOT NULL DEFAULT 0,
  "airport_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT DEFAULT NULL,
  "update_time" TEXT DEFAULT NULL,
  "data_status" INTEGER DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_purchaser_authorize" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "token" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "expire_time" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "bind_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("purchaser_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_purchaser_bk04261133" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "zq_user_id" INTEGER NOT NULL DEFAULT 0,
  "platform" INTEGER NOT NULL DEFAULT 0,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "xm_account" TEXT NOT NULL DEFAULT '',
  "xm_com_id" INTEGER NOT NULL DEFAULT 0,
  "company_direct_sale_store" INTEGER NOT NULL DEFAULT 0,
  "company_level" INTEGER NOT NULL DEFAULT 6,
  "xm_coin" REAL NOT NULL DEFAULT 0.00,
  "xm_coin_income" REAL NOT NULL DEFAULT 0.00,
  "xm_coin_expend" REAL NOT NULL DEFAULT 0.00,
  "xm_coin_give" REAL NOT NULL DEFAULT 0.00,
  "xm_coin_rebate" REAL NOT NULL DEFAULT 0.00,
  "xm_coin_paid" REAL NOT NULL DEFAULT 0.00,
  "phone_number" TEXT NOT NULL DEFAULT '',
  "password" TEXT NOT NULL DEFAULT '',
  "salt" TEXT NOT NULL DEFAULT '',
  "app_id" TEXT NOT NULL DEFAULT '',
  "open_id" TEXT NOT NULL DEFAULT '',
  "zc_open_id" TEXT NOT NULL DEFAULT '',
  "session_key" TEXT NOT NULL DEFAULT '',
  "gender" INTEGER NOT NULL DEFAULT 0,
  "province" TEXT NOT NULL DEFAULT '',
  "city" TEXT NOT NULL DEFAULT '',
  "country" TEXT NOT NULL DEFAULT '',
  "area_type" INTEGER NOT NULL DEFAULT 0,
  "auto_area_flag" INTEGER NOT NULL DEFAULT 1,
  "nickname" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "avatar_url" TEXT NOT NULL DEFAULT '',
  "pic_avatar_url" TEXT NOT NULL DEFAULT '',
  "pic_user_background_url" TEXT NOT NULL DEFAULT '',
  "pic_user_introduction" TEXT NOT NULL DEFAULT '',
  "help_id" INTEGER NOT NULL DEFAULT 0,
  "ma_help_id" INTEGER NOT NULL DEFAULT 0,
  "pid" INTEGER NOT NULL DEFAULT 0,
  "last_login_time" TEXT DEFAULT NULL,
  "last_login_ip" TEXT DEFAULT NULL,
  "class_type" INTEGER NOT NULL DEFAULT 1,
  "contact_supplier_count" INTEGER NOT NULL DEFAULT 3,
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "config_id" INTEGER NOT NULL DEFAULT 0,
  "first_buy_time" TEXT NOT NULL DEFAULT '',
  "last_buy_time" TEXT NOT NULL DEFAULT '',
  "last_second_buy_time" TEXT NOT NULL DEFAULT '',
  "buy_times" INTEGER NOT NULL DEFAULT 0,
  "ma_first_buy_time" TEXT NOT NULL DEFAULT '',
  "ma_last_buy_time" TEXT NOT NULL DEFAULT '',
  "ma_month_buy_time" INTEGER NOT NULL DEFAULT 0,
  "item_num" INTEGER NOT NULL DEFAULT 0,
  "last_recall_time" TEXT DEFAULT NULL,
  "month_item_num" INTEGER NOT NULL DEFAULT 0,
  "block_flag" INTEGER NOT NULL DEFAULT 0,
  "bb_flag" INTEGER NOT NULL DEFAULT 0,
  "month_consumption" REAL NOT NULL DEFAULT 0.00,
  "total_consumption" REAL NOT NULL DEFAULT 0.00,
  "holiday_white_flag" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT DEFAULT NULL,
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("phone_number", "app_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_purchaser_bk06301850" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "zq_user_id" INTEGER NOT NULL DEFAULT 0,
  "platform" INTEGER NOT NULL DEFAULT 0,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "xm_account" TEXT NOT NULL DEFAULT '',
  "xm_com_id" INTEGER NOT NULL DEFAULT 0,
  "company_direct_sale_store" INTEGER NOT NULL DEFAULT 0,
  "company_level" INTEGER NOT NULL DEFAULT 6,
  "xm_coin" REAL NOT NULL DEFAULT 0.00,
  "xm_coin_income" REAL NOT NULL DEFAULT 0.00,
  "xm_coin_expend" REAL NOT NULL DEFAULT 0.00,
  "xm_coin_give" REAL NOT NULL DEFAULT 0.00,
  "xm_coin_rebate" REAL NOT NULL DEFAULT 0.00,
  "xm_coin_paid" REAL NOT NULL DEFAULT 0.00,
  "phone_number" TEXT NOT NULL DEFAULT '',
  "password" TEXT NOT NULL DEFAULT '',
  "salt" TEXT NOT NULL DEFAULT '',
  "app_id" TEXT NOT NULL DEFAULT '',
  "open_id" TEXT NOT NULL DEFAULT '',
  "zc_open_id" TEXT NOT NULL DEFAULT '',
  "session_key" TEXT NOT NULL DEFAULT '',
  "gender" INTEGER NOT NULL DEFAULT 0,
  "province" TEXT NOT NULL DEFAULT '',
  "city" TEXT NOT NULL DEFAULT '',
  "country" TEXT NOT NULL DEFAULT '',
  "area_type" INTEGER NOT NULL DEFAULT 0,
  "auto_area_flag" INTEGER NOT NULL DEFAULT 1,
  "nickname" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "avatar_url" TEXT NOT NULL DEFAULT '',
  "pic_avatar_url" TEXT NOT NULL DEFAULT '',
  "pic_user_background_url" TEXT NOT NULL DEFAULT '',
  "pic_user_introduction" TEXT NOT NULL DEFAULT '',
  "help_id" INTEGER NOT NULL DEFAULT 0,
  "ma_help_id" INTEGER NOT NULL DEFAULT 0,
  "pid" INTEGER NOT NULL DEFAULT 0,
  "last_login_time" TEXT DEFAULT NULL,
  "last_login_ip" TEXT DEFAULT NULL,
  "class_type" INTEGER NOT NULL DEFAULT 1,
  "contact_supplier_count" INTEGER NOT NULL DEFAULT 3,
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "config_id" INTEGER NOT NULL DEFAULT 0,
  "first_buy_time" TEXT NOT NULL DEFAULT '',
  "last_buy_time" TEXT NOT NULL DEFAULT '',
  "last_second_buy_time" TEXT NOT NULL DEFAULT '',
  "buy_times" INTEGER NOT NULL DEFAULT 0,
  "ma_first_buy_time" TEXT NOT NULL DEFAULT '',
  "ma_last_buy_time" TEXT NOT NULL DEFAULT '',
  "ma_month_buy_time" INTEGER NOT NULL DEFAULT 0,
  "item_num" INTEGER NOT NULL DEFAULT 0,
  "last_recall_time" TEXT DEFAULT NULL,
  "month_item_num" INTEGER NOT NULL DEFAULT 0,
  "block_flag" INTEGER NOT NULL DEFAULT 0,
  "bb_flag" INTEGER NOT NULL DEFAULT 0,
  "month_consumption" REAL NOT NULL DEFAULT 0.00,
  "total_consumption" REAL NOT NULL DEFAULT 0.00,
  "holiday_white_flag" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT DEFAULT NULL,
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("phone_number", "app_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_purchaser_contact_supplier" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "count" INTEGER NOT NULL DEFAULT 0,
  "last_date" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_purchaser_coupon_tag" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "fifteen_flag" INTEGER NOT NULL DEFAULT 0,
  "thirty_flag" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_purchaser_invoice_application" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "application_no" TEXT NOT NULL DEFAULT '',
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "invoice_title_id" INTEGER NOT NULL DEFAULT 0,
  "title_name" TEXT DEFAULT NULL,
  "tax_number" TEXT DEFAULT NULL,
  "bank_name" TEXT DEFAULT NULL,
  "bank_account" TEXT DEFAULT NULL,
  "company_address" TEXT DEFAULT NULL,
  "company_phone" TEXT DEFAULT NULL,
  "total_amount" REAL NOT NULL DEFAULT 0,
  "supplier_count" INTEGER NOT NULL DEFAULT 0,
  "order_count" INTEGER NOT NULL DEFAULT 0,
  "status" INTEGER NOT NULL DEFAULT 0,
  "deadline" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("application_no")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_purchaser_invoice_application_order" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "application_id" INTEGER NOT NULL DEFAULT 0,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT DEFAULT NULL,
  "invoiceable_amount" REAL NOT NULL DEFAULT 0,
  "create_time" TEXT DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_purchaser_invoice_quota" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "total_quota" REAL NOT NULL DEFAULT 0.00,
  "invoicing_amount" REAL NOT NULL DEFAULT 0.00,
  "invoiced_amount" REAL NOT NULL DEFAULT 0.00,
  "available_quota" REAL NOT NULL DEFAULT 0.00,
  "freight_total" REAL NOT NULL DEFAULT 0.00,
  "freight_invoiced" REAL NOT NULL DEFAULT 0.00,
  "service_fee_total" REAL NOT NULL DEFAULT 0.00,
  "service_fee_invoiced" REAL NOT NULL DEFAULT 0.00,
  "version" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("purchaser_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_purchaser_tag" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "tag_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("purchaser_id", "tag_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_quality_punish_sms_record" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "round_no" TEXT NOT NULL DEFAULT '',
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "masked_phone" TEXT NOT NULL DEFAULT '',
  "variety_count" INTEGER NOT NULL DEFAULT 0,
  "total_punish_num" INTEGER NOT NULL DEFAULT 0,
  "sms_code" TEXT NOT NULL DEFAULT '',
  "submit_status" INTEGER NOT NULL DEFAULT 0,
  "failure_reason" TEXT DEFAULT NULL,
  "platform_sms_id" TEXT DEFAULT NULL,
  "submit_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("round_no", "purchaser_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_quick_reply" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "type" INTEGER NOT NULL DEFAULT 1,
  "content" TEXT NOT NULL DEFAULT '',
  "sequence" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_receipt_application" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "receipt_no" TEXT NOT NULL DEFAULT '',
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "purchaser_phone" TEXT DEFAULT NULL,
  "invoice_title_id" INTEGER NOT NULL DEFAULT 0,
  "buyer_name" TEXT NOT NULL DEFAULT '',
  "buyer_certificate_no" TEXT DEFAULT NULL,
  "total_amount" REAL NOT NULL DEFAULT 0.00,
  "order_count" INTEGER NOT NULL DEFAULT 0,
  "item_count" INTEGER NOT NULL DEFAULT 0,
  "receipt_url" TEXT DEFAULT NULL,
  "status" INTEGER NOT NULL DEFAULT 1,
  "apply_time" TEXT NOT NULL DEFAULT '',
  "issue_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("receipt_no")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_receipt_application_item" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "receipt_id" INTEGER NOT NULL DEFAULT 0,
  "receipt_no" TEXT NOT NULL DEFAULT '',
  "order_sn" TEXT NOT NULL DEFAULT '',
  "round_no" TEXT DEFAULT NULL,
  "supplier_id" INTEGER DEFAULT NULL,
  "supplier_name" TEXT DEFAULT NULL,
  "product_name" TEXT DEFAULT NULL,
  "item_num" INTEGER NOT NULL DEFAULT 0,
  "receipt_amount" REAL NOT NULL DEFAULT 0.00,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "item_type" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_receipt_application_order" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "receipt_id" INTEGER NOT NULL DEFAULT 0,
  "receipt_no" TEXT NOT NULL DEFAULT '',
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "round_no" TEXT DEFAULT NULL,
  "receipt_amount" REAL NOT NULL DEFAULT 0.00,
  "supplier_count" INTEGER NOT NULL DEFAULT 0,
  "confirm_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("order_sn")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_receipt_operation_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "receipt_id" INTEGER NOT NULL DEFAULT 0,
  "receipt_no" TEXT NOT NULL DEFAULT '',
  "action_type" INTEGER NOT NULL DEFAULT 0,
  "operator_type" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER DEFAULT NULL,
  "operator_name" TEXT DEFAULT NULL,
  "operator_phone" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_refund" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "pid" INTEGER NOT NULL DEFAULT 0,
  "user_type" INTEGER NOT NULL DEFAULT 0,
  "refund_type" INTEGER NOT NULL DEFAULT 0,
  "month_refund_num" INTEGER NOT NULL DEFAULT 0,
  "product_name" TEXT NOT NULL DEFAULT '',
  "punish_id" INTEGER NOT NULL DEFAULT 0,
  "punish_type" INTEGER NOT NULL DEFAULT 0,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "platform" INTEGER NOT NULL DEFAULT 0,
  "pay_type" INTEGER NOT NULL DEFAULT 0,
  "partner_status" INTEGER NOT NULL DEFAULT 0,
  "partner_apply_money" REAL NOT NULL DEFAULT 0.00,
  "partner_reason" TEXT NOT NULL DEFAULT '',
  "apply_status" INTEGER NOT NULL DEFAULT 0,
  "apply_money" REAL NOT NULL DEFAULT 0.00,
  "apply_product_price" REAL NOT NULL DEFAULT 0.00,
  "apply_service_fee" REAL NOT NULL DEFAULT 0.00,
  "apply_express_price" REAL NOT NULL DEFAULT 0.00,
  "apply_reason" TEXT NOT NULL DEFAULT '',
  "reason_type" INTEGER NOT NULL DEFAULT 0,
  "pictures" TEXT,
  "videos" TEXT,
  "supplementary_desc" TEXT NOT NULL DEFAULT '',
  "supplementary_picture" TEXT NOT NULL DEFAULT '',
  "supplementary_time" TEXT NOT NULL DEFAULT '',
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_picture" TEXT NOT NULL DEFAULT '',
  "supplier_desc" TEXT NOT NULL DEFAULT '',
  "wx_pay_time" TEXT DEFAULT NULL,
  "supplementary_video" TEXT NOT NULL DEFAULT '',
  "refund_status" INTEGER NOT NULL DEFAULT 0,
  "handle_time" TEXT DEFAULT NULL,
  "handle_record" TEXT,
  "punish_pic_url" TEXT NOT NULL DEFAULT '',
  "wx_refund_id" TEXT NOT NULL DEFAULT '',
  "wx_refund_success_time" TEXT DEFAULT NULL,
  "refund_money" REAL NOT NULL DEFAULT 0.00,
  "refund_product_price" REAL NOT NULL DEFAULT 0.00,
  "refund_service_fee" REAL NOT NULL DEFAULT 0.00,
  "refund_express_price" REAL NOT NULL DEFAULT 0.00,
  "refund_coupon_price" REAL NOT NULL DEFAULT 0.00,
  "refund_coupon_discount_goods" REAL NOT NULL DEFAULT 0.00,
  "refund_platform_reduce_goods" REAL NOT NULL DEFAULT 0.00,
  "refund_extra_service_fee" REAL NOT NULL DEFAULT 0.00,
  "refund_vip_discount_service_fee" REAL NOT NULL DEFAULT 0.00,
  "paid_xm_coin" REAL NOT NULL DEFAULT 0.00,
  "bear_platform_discount" REAL NOT NULL DEFAULT 0.00,
  "supplier_should_price" REAL NOT NULL DEFAULT 0.00,
  "supplier_bear_price" REAL NOT NULL DEFAULT 0.00,
  "dao_chang_huo_supplier_id" INTEGER DEFAULT NULL,
  "dao_chang_huo_should_price" REAL NOT NULL DEFAULT 0.00,
  "dao_chang_huo_split_amount" REAL NOT NULL DEFAULT 0.00,
  "supplier_bear_ratio" REAL NOT NULL DEFAULT 1.00,
  "supplier_accord_bear_price" REAL NOT NULL DEFAULT 0.00,
  "is_prefer" INTEGER NOT NULL DEFAULT 0,
  "offline_refund_flag" INTEGER NOT NULL DEFAULT 0,
  "city_warehouse_bear_price" REAL NOT NULL DEFAULT 0.00,
  "partner_bear_price" REAL NOT NULL DEFAULT 0.00,
  "refund_add_price" REAL NOT NULL DEFAULT 0.00,
  "pack_bear_price" REAL NOT NULL DEFAULT 0.00,
  "express_bear_price" REAL NOT NULL DEFAULT 0.00,
  "remark" TEXT NOT NULL DEFAULT '',
  "flag" INTEGER NOT NULL DEFAULT 0,
  "flag_remark" TEXT NOT NULL DEFAULT '',
  "platform_picture" TEXT NOT NULL DEFAULT '',
  "assign_customer_id" INTEGER NOT NULL DEFAULT 0,
  "assign_customer_name" TEXT NOT NULL DEFAULT '',
  "assign_time" TEXT DEFAULT NULL,
  "last_assign_time" TEXT DEFAULT NULL,
  "refund_result" TEXT NOT NULL DEFAULT '',
  "duty_reason" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_date" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "apply_ot_exp_add_price" REAL NOT NULL DEFAULT 0.00,
  "refund_ot_exp_add_price" REAL NOT NULL DEFAULT 0.00,
  "refund_partner_add_price" REAL NOT NULL DEFAULT 0.00,
  "refund_partner_add_service_fee" REAL NOT NULL DEFAULT 0.00
);
CREATE TABLE IF NOT EXISTS "xm_bulky_refund_duty" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "refund_id" INTEGER NOT NULL DEFAULT 0,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "pay_time" TEXT NOT NULL DEFAULT '',
  "duty_type" INTEGER NOT NULL DEFAULT 0,
  "user_id_str" TEXT,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_refund_item" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "refund_id" INTEGER NOT NULL DEFAULT 0,
  "refund_type" INTEGER NOT NULL DEFAULT 0,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "order_item_id" INTEGER NOT NULL DEFAULT 0,
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "apply_money" REAL NOT NULL DEFAULT 0.00,
  "apply_num" INTEGER NOT NULL DEFAULT 0,
  "apply_item_sub_num" INTEGER NOT NULL DEFAULT 0,
  "apply_product_price" REAL NOT NULL DEFAULT 0.00,
  "apply_service_fee" REAL NOT NULL DEFAULT 0.00,
  "apply_express_price" REAL NOT NULL DEFAULT 0.00,
  "refund_money" REAL NOT NULL DEFAULT 0.00,
  "refund_product_price" REAL NOT NULL DEFAULT 0.00,
  "refund_service_fee" REAL NOT NULL DEFAULT 0.00,
  "refund_partner_add_service_fee" REAL NOT NULL DEFAULT 0.00,
  "refund_express_price" REAL NOT NULL DEFAULT 0.00,
  "refund_item_num" INTEGER NOT NULL DEFAULT 0,
  "paid_xm_coin" REAL NOT NULL DEFAULT 0.00,
  "supplier_bear_price" REAL NOT NULL DEFAULT 0.00,
  "dao_chang_huo_supplier_id" INTEGER DEFAULT NULL,
  "dao_chang_huo_should_price" REAL NOT NULL DEFAULT 0.00,
  "dao_chang_huo_split_amount" REAL NOT NULL DEFAULT 0.00,
  "city_warehouse_bear_price" REAL NOT NULL DEFAULT 0.00,
  "refund_add_price" REAL NOT NULL DEFAULT 0.00,
  "bear_platform_discount" REAL NOT NULL DEFAULT 0.00,
  "coupon_discount_per_bundle" REAL NOT NULL DEFAULT 0.00,
  "full_reduction_discount_per_bundle" REAL NOT NULL DEFAULT 0.00,
  "apply_status" INTEGER NOT NULL DEFAULT 0,
  "is_prefer" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("refund_id", "order_item_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_refund_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "refund_id" INTEGER NOT NULL DEFAULT 0,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "user_type" INTEGER NOT NULL DEFAULT 0,
  "platform_flag" INTEGER NOT NULL DEFAULT 0,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "user_name" TEXT NOT NULL DEFAULT '',
  "content" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_refund_picture" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "record_type" INTEGER NOT NULL DEFAULT 1,
  "pic_url" TEXT NOT NULL DEFAULT '',
  "origin_md5" TEXT NOT NULL DEFAULT '',
  "pic_md5" TEXT NOT NULL DEFAULT '',
  "normalized_md5" TEXT NOT NULL DEFAULT '',
  "phash" TEXT NOT NULL DEFAULT '',
  "dhash" TEXT NOT NULL DEFAULT '',
  "shoot_time" TEXT DEFAULT NULL,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "apply_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "order_sn" TEXT NOT NULL DEFAULT '',
  "round_no" TEXT NOT NULL DEFAULT '',
  "refund_id" INTEGER NOT NULL DEFAULT 0,
  "refund_source" INTEGER NOT NULL DEFAULT 0,
  "product_name" TEXT NOT NULL DEFAULT '',
  "duplicate_pic_id" INTEGER NOT NULL DEFAULT 0,
  "match_type" TEXT NOT NULL DEFAULT '',
  "similarity" INTEGER NOT NULL DEFAULT 0,
  "phash_similarity" INTEGER NOT NULL DEFAULT 0,
  "dhash_similarity" INTEGER NOT NULL DEFAULT 0,
  "similarity_order_sn" TEXT NOT NULL DEFAULT '',
  "similarity_refund_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_refund_statistics" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "round_no" TEXT NOT NULL DEFAULT '',
  "order_time_form" TEXT NOT NULL DEFAULT '',
  "refund_form" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_region_airport" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "province" TEXT NOT NULL DEFAULT '',
  "province_code" TEXT NOT NULL DEFAULT '',
  "city" TEXT NOT NULL DEFAULT '',
  "city_code" TEXT NOT NULL DEFAULT '',
  "airport_name" TEXT NOT NULL DEFAULT '',
  "region_code" TEXT NOT NULL DEFAULT '',
  "is_enable" INTEGER NOT NULL DEFAULT 1,
  "create_time" TEXT DEFAULT NULL
);
CREATE TABLE IF NOT EXISTS "xm_bulky_region_extra" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "type" INTEGER NOT NULL DEFAULT 0,
  "region_id" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "parent_region_id" INTEGER NOT NULL DEFAULT 0,
  "adcode" TEXT NOT NULL DEFAULT '',
  "level" TEXT NOT NULL DEFAULT '',
  "is_select" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_region_rule" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL DEFAULT '',
  "is_modify" INTEGER NOT NULL DEFAULT 1,
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_region_statistics" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "yyyy_mm_dd" TEXT NOT NULL DEFAULT '',
  "province" TEXT NOT NULL DEFAULT '',
  "city" TEXT NOT NULL DEFAULT '',
  "turnover" REAL NOT NULL DEFAULT 0.00,
  "send_num" INTEGER NOT NULL DEFAULT 0,
  "order_num" INTEGER NOT NULL DEFAULT 0,
  "item_num" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("yyyy_mm_dd", "city", "province")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_remit" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "type" INTEGER NOT NULL DEFAULT 0,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "app_id" TEXT NOT NULL DEFAULT '',
  "open_id" TEXT NOT NULL DEFAULT '',
  "mch_id" TEXT NOT NULL DEFAULT '',
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "amount" REAL NOT NULL DEFAULT 0.00,
  "apply_reason" TEXT NOT NULL DEFAULT '',
  "reject_reason" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "agree_time" TEXT DEFAULT NULL,
  "out_biz_no" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_replenish" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "apply_money" REAL NOT NULL DEFAULT 0.00,
  "apply_status" INTEGER NOT NULL DEFAULT 0,
  "file_url" TEXT NOT NULL DEFAULT '',
  "responsible_party" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "checker_id" INTEGER NOT NULL DEFAULT 0,
  "checker_name" TEXT NOT NULL DEFAULT '',
  "check_time" TEXT NOT NULL DEFAULT '',
  "flag" INTEGER NOT NULL DEFAULT 0,
  "reject_reason" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("order_sn")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_replenish_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "replenish_id" INTEGER NOT NULL DEFAULT 0,
  "content" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_restock_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "zone" TEXT NOT NULL DEFAULT '',
  "zone_name" TEXT NOT NULL DEFAULT '',
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "rank_num" INTEGER NOT NULL DEFAULT 0,
  "num" INTEGER NOT NULL DEFAULT 0,
  "user_name" TEXT NOT NULL DEFAULT '',
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "round_no" TEXT NOT NULL DEFAULT ''
);
CREATE TABLE IF NOT EXISTS "xm_bulky_restock_order" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "sub_shelf_sn" TEXT NOT NULL DEFAULT '',
  "round_no" TEXT NOT NULL DEFAULT '',
  "order_sn" TEXT NOT NULL DEFAULT '',
  "type" INTEGER NOT NULL DEFAULT 0,
  "enter_item_id" INTEGER NOT NULL DEFAULT 0,
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "item_num" INTEGER NOT NULL DEFAULT 0,
  "origin_rank_num" INTEGER NOT NULL DEFAULT 0,
  "origin_sku_config" TEXT NOT NULL DEFAULT '',
  "restock_product_id" INTEGER NOT NULL DEFAULT 0,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "restock_num" INTEGER NOT NULL DEFAULT 0,
  "restock_rank_num" INTEGER NOT NULL DEFAULT 0,
  "restock_sku_config" TEXT NOT NULL DEFAULT '',
  "outbound_num" INTEGER NOT NULL DEFAULT 0,
  "remark" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "user_name" TEXT NOT NULL DEFAULT ''
);
CREATE TABLE IF NOT EXISTS "xm_bulky_sale_limit_rule" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "first_id" INTEGER NOT NULL DEFAULT 0,
  "second_id" INTEGER DEFAULT NULL,
  "supplier_types" TEXT NOT NULL DEFAULT '',
  "base_scope_type" INTEGER NOT NULL DEFAULT 0,
  "base_ids" TEXT DEFAULT NULL,
  "white_list_enable" INTEGER NOT NULL DEFAULT 0,
  "operator" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_sale_limit_rule_white" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "rule_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_id" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_sale_statistics" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "yyyy_mm_dd" TEXT NOT NULL DEFAULT '',
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "average_price" REAL NOT NULL DEFAULT 0,
  "sale_volume" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_search_history" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "app_id" TEXT NOT NULL DEFAULT '',
  "type" INTEGER NOT NULL DEFAULT 0,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "content" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_second_confirm" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "enter_item_id" INTEGER NOT NULL DEFAULT 0,
  "punish_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "supplier_tag" TEXT NOT NULL DEFAULT '',
  "round_no" TEXT NOT NULL DEFAULT '',
  "num" INTEGER NOT NULL DEFAULT 0,
  "third_num" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_second_pic" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "image_url" TEXT,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("second_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_second_star" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_second_subsidy" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "config_id" INTEGER NOT NULL DEFAULT 0,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "rank_num" INTEGER NOT NULL DEFAULT 0,
  "subsidy_num" INTEGER NOT NULL DEFAULT 0,
  "subsidy_price" REAL NOT NULL DEFAULT 0.00,
  "subsidy_price_str" TEXT NOT NULL DEFAULT '',
  "price_difference_str" TEXT NOT NULL DEFAULT '',
  "supplier_perm" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_second_subsidy_config" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "rule_id" INTEGER NOT NULL DEFAULT 0,
  "subsidy_type" INTEGER NOT NULL DEFAULT 4,
  "status" INTEGER NOT NULL DEFAULT 1,
  "effect_type" INTEGER NOT NULL DEFAULT 1,
  "start_time" TEXT DEFAULT NULL,
  "end_time" TEXT DEFAULT NULL,
  "is_default" INTEGER NOT NULL DEFAULT 0,
  "apply_unbound" INTEGER NOT NULL DEFAULT 0,
  "limit_default" REAL NOT NULL DEFAULT 1000.00,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_second_subsidy_config_app" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "config_id" INTEGER NOT NULL DEFAULT 0,
  "app_id" TEXT NOT NULL DEFAULT '',
  "app_name" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_second_subsidy_config_city" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "config_id" INTEGER NOT NULL DEFAULT 0,
  "subsidy_type" INTEGER NOT NULL DEFAULT 1,
  "city_adcode" TEXT NOT NULL DEFAULT '',
  "city_name" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("subsidy_type", "city_adcode")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_second_subsidy_new" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "rule_id" INTEGER NOT NULL DEFAULT 0,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "rank_num" INTEGER NOT NULL DEFAULT 0,
  "subsidy_mode" INTEGER NOT NULL DEFAULT 1,
  "subsidy_num" INTEGER NOT NULL DEFAULT 0,
  "subsidy_price" REAL NOT NULL DEFAULT 0.00,
  "subsidy_price_str" TEXT NOT NULL DEFAULT '',
  "price_difference_str" TEXT NOT NULL DEFAULT '',
  "supplier_perm" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_second_subsidy_rule" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_send_order" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "send_no" TEXT NOT NULL DEFAULT '',
  "round_no" TEXT NOT NULL DEFAULT '',
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "order_num" INTEGER DEFAULT 0,
  "ware_sn" INTEGER NOT NULL DEFAULT 0,
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "sub_shelf_sn" TEXT NOT NULL DEFAULT '',
  "zone" TEXT NOT NULL DEFAULT '',
  "shelf" TEXT NOT NULL DEFAULT '',
  "zone_shelf" TEXT NOT NULL DEFAULT '',
  "delivery_type" INTEGER NOT NULL DEFAULT 1,
  "distribution_type" INTEGER NOT NULL DEFAULT 0,
  "actual_total_weight" INTEGER NOT NULL DEFAULT 0,
  "expend_express_price" REAL NOT NULL DEFAULT 0.00,
  "pickup_fee" REAL NOT NULL DEFAULT 0.00,
  "express_price_flag" INTEGER NOT NULL DEFAULT 0,
  "freight_price_mode" INTEGER NOT NULL DEFAULT 0,
  "package_report_price" REAL DEFAULT NULL,
  "waybill_report_price" REAL DEFAULT NULL,
  "reconcile_sub_bill_id" INTEGER NOT NULL DEFAULT 0,
  "compensate_price" REAL NOT NULL DEFAULT 0.00,
  "expend_service_fee" REAL NOT NULL DEFAULT 0.00,
  "estimate_express_price" REAL NOT NULL DEFAULT 0.00,
  "actual_package_info" TEXT,
  "config_id" INTEGER NOT NULL DEFAULT 0,
  "express_region" INTEGER NOT NULL DEFAULT 0,
  "real_express_id" INTEGER NOT NULL DEFAULT 0,
  "real_express_region" INTEGER NOT NULL DEFAULT 0,
  "month_buy" INTEGER NOT NULL DEFAULT 0,
  "receive_name" TEXT NOT NULL DEFAULT '',
  "receive_tel" TEXT NOT NULL DEFAULT '',
  "province" TEXT NOT NULL DEFAULT '',
  "city" TEXT NOT NULL DEFAULT '',
  "district" TEXT NOT NULL DEFAULT '',
  "detail" TEXT NOT NULL DEFAULT '',
  "receive_address" TEXT NOT NULL DEFAULT '',
  "nation_code" TEXT DEFAULT NULL,
  "adcode" TEXT NOT NULL DEFAULT '',
  "longitude" TEXT NOT NULL DEFAULT '',
  "latitude" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "city_remark" TEXT NOT NULL DEFAULT '',
  "logistics_remark" TEXT NOT NULL DEFAULT '',
  "send_status" INTEGER NOT NULL DEFAULT 0,
  "logistics_status" INTEGER NOT NULL DEFAULT 0,
  "express_change_status" INTEGER NOT NULL DEFAULT 0,
  "print_status" INTEGER NOT NULL DEFAULT 0,
  "is_sale_agency" INTEGER NOT NULL DEFAULT 0,
  "new_buyer" INTEGER NOT NULL DEFAULT 0,
  "help_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "order_create_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "waybill_print_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("send_no")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_send_order_coin_refund" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "send_no" TEXT NOT NULL DEFAULT '',
  "xm_coin" REAL NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_sf_logistics_config" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "config_id" INTEGER NOT NULL DEFAULT 0,
  "monthly_card" TEXT NOT NULL DEFAULT '',
  "password" TEXT NOT NULL DEFAULT '',
  "force_weight" REAL DEFAULT NULL,
  "inner_test_switch_key" TEXT NOT NULL DEFAULT '',
  "dynamic_rule" TEXT NOT NULL DEFAULT 'NONE',
  "remark" TEXT NOT NULL DEFAULT '',
  "create_user_id" INTEGER NOT NULL DEFAULT 0,
  "create_user_name" TEXT NOT NULL DEFAULT '',
  "update_user_id" INTEGER NOT NULL DEFAULT 0,
  "update_user_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("config_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_shelf_package_status" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "round_no" TEXT NOT NULL DEFAULT '',
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "zone" TEXT NOT NULL DEFAULT '',
  "zone_shelf" TEXT NOT NULL DEFAULT '',
  "express_id" INTEGER NOT NULL DEFAULT 0,
  "package_status" INTEGER NOT NULL DEFAULT 0,
  "complete_type" INTEGER NOT NULL DEFAULT 0,
  "box_time" TEXT DEFAULT NULL,
  "complete_time" TEXT DEFAULT NULL,
  "outbound_time" TEXT DEFAULT NULL,
  "restock_status" INTEGER NOT NULL DEFAULT 0,
  "distribution_status" INTEGER NOT NULL DEFAULT 0,
  "has_sub_shelf" INTEGER NOT NULL DEFAULT 0,
  "manual_user_id" INTEGER NOT NULL DEFAULT 0,
  "self_pickup" INTEGER NOT NULL DEFAULT 0,
  "delivery_time" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("round_no", "shelf_sn", "data_status")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_standard_price" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "first_id" INTEGER NOT NULL DEFAULT 0,
  "first_name" TEXT NOT NULL DEFAULT '',
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "second_name" TEXT NOT NULL DEFAULT '',
  "rank_num" INTEGER NOT NULL DEFAULT 0,
  "price" REAL NOT NULL DEFAULT 0.00,
  "is_update" INTEGER NOT NULL DEFAULT 0,
  "flag" INTEGER NOT NULL DEFAULT 0,
  "version" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "push_buy_price" INTEGER NOT NULL DEFAULT 0,
  "buy_price_type" INTEGER NOT NULL DEFAULT 0,
  "buy_price_num" REAL NOT NULL DEFAULT 0.00,
  "push_onsale_price" INTEGER NOT NULL DEFAULT 0,
  "onsale_price_type" INTEGER NOT NULL DEFAULT 0,
  "onsale_price_num" REAL NOT NULL DEFAULT 0.00,
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "crate_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_sub_account" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "type" INTEGER NOT NULL DEFAULT 1,
  "user_name" TEXT NOT NULL DEFAULT '',
  "pass" TEXT NOT NULL DEFAULT '',
  "salt" TEXT NOT NULL DEFAULT '',
  "sex" INTEGER NOT NULL DEFAULT 0,
  "nickname" TEXT NOT NULL DEFAULT '',
  "full_flag" INTEGER NOT NULL DEFAULT 0,
  "phone" TEXT NOT NULL DEFAULT '',
  "description" TEXT NOT NULL DEFAULT '',
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "logistics_supplier_id" INTEGER NOT NULL DEFAULT 0,
  "base_config" TEXT,
  "admin_flag" INTEGER NOT NULL DEFAULT 0,
  "job_number" TEXT NOT NULL DEFAULT '',
  "password_version" INTEGER NOT NULL DEFAULT 0,
  "smart_locker_code" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "last_login_time" TEXT DEFAULT NULL,
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "need_change_password" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_suggestion" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "type" INTEGER NOT NULL DEFAULT 6,
  "source" INTEGER DEFAULT NULL,
  "contact" TEXT NOT NULL DEFAULT '',
  "content" TEXT NOT NULL DEFAULT '',
  "app_id" TEXT NOT NULL DEFAULT '',
  "image_url" TEXT,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "is_read" INTEGER NOT NULL DEFAULT 0,
  "handle_result" INTEGER DEFAULT 0,
  "handle_message" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER DEFAULT NULL,
  "operator_name" TEXT DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_suggestion_product_snapshot" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "suggestion_id" INTEGER NOT NULL DEFAULT 0,
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "product_name" TEXT NOT NULL DEFAULT '',
  "product_image_url" TEXT,
  "product_video_url" TEXT DEFAULT NULL,
  "stem_length" TEXT DEFAULT NULL,
  "bud_size" TEXT DEFAULT NULL,
  "flower_advantage" TEXT DEFAULT NULL,
  "uniformity" TEXT DEFAULT NULL,
  "stem_thickness" TEXT DEFAULT NULL,
  "curl_edge" TEXT DEFAULT NULL,
  "tag_desc" TEXT,
  "rank_num" INTEGER DEFAULT NULL,
  "rank_name" TEXT DEFAULT NULL,
  "maturity" TEXT DEFAULT NULL,
  "product_tag" TEXT DEFAULT NULL,
  "is_prefer" INTEGER NOT NULL DEFAULT 0,
  "quality_flag" INTEGER NOT NULL DEFAULT 0,
  "is_hot" INTEGER NOT NULL DEFAULT 0,
  "is_special" INTEGER NOT NULL DEFAULT 1,
  "is_seckill" INTEGER NOT NULL DEFAULT 1,
  "is_presale" INTEGER NOT NULL DEFAULT 0,
  "seven_no_aftersale" INTEGER NOT NULL DEFAULT 0,
  "seven_no_lower_rank" INTEGER NOT NULL DEFAULT 0,
  "seven_no_refund" INTEGER NOT NULL DEFAULT 0,
  "seven_no_lack" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  UNIQUE ("suggestion_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "type" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "old_supplier_name" TEXT NOT NULL DEFAULT '',
  "comment_score" REAL DEFAULT 5,
  "supplier_images" TEXT NOT NULL DEFAULT '',
  "supplier_tag" TEXT NOT NULL DEFAULT '',
  "third_shop_id" INTEGER NOT NULL DEFAULT 0,
  "operator_type" INTEGER NOT NULL DEFAULT 0,
  "item_type" INTEGER NOT NULL DEFAULT 1,
  "is_quality" INTEGER NOT NULL DEFAULT 0,
  "quality_sort" INTEGER NOT NULL DEFAULT 0,
  "take_xm_coin_ratio" REAL NOT NULL DEFAULT 0.000,
  "auto_ratio" INTEGER NOT NULL DEFAULT 1,
  "agency_ratio_flag" INTEGER NOT NULL DEFAULT 0,
  "owner_name" TEXT NOT NULL DEFAULT '',
  "owner_tel" TEXT NOT NULL DEFAULT '',
  "avatar" TEXT NOT NULL DEFAULT '',
  "avatar_audit_status" INTEGER NOT NULL DEFAULT 0,
  "avatar_audit_image_url" TEXT NOT NULL DEFAULT '',
  "avatar_audit_trace_id" TEXT NOT NULL DEFAULT '',
  "province_code" TEXT NOT NULL DEFAULT '',
  "province" TEXT NOT NULL DEFAULT '',
  "city_code" TEXT NOT NULL DEFAULT '',
  "city" TEXT NOT NULL DEFAULT '',
  "county_code" TEXT NOT NULL DEFAULT '',
  "country" TEXT NOT NULL DEFAULT '',
  "address_detail" TEXT NOT NULL DEFAULT '',
  "introduction" TEXT NOT NULL DEFAULT '',
  "prove_type" INTEGER NOT NULL DEFAULT 0,
  "real_name" TEXT NOT NULL DEFAULT '',
  "card_no" TEXT NOT NULL DEFAULT '',
  "card_photo" TEXT NOT NULL DEFAULT '',
  "card_photo_back" TEXT NOT NULL DEFAULT '',
  "company_photo" TEXT NOT NULL DEFAULT '',
  "company_name" TEXT NOT NULL DEFAULT '',
  "company_code" TEXT NOT NULL DEFAULT '',
  "wx_open_id" TEXT NOT NULL DEFAULT '',
  "wx_union_id" TEXT NOT NULL DEFAULT '',
  "session_key" TEXT NOT NULL DEFAULT '',
  "login_tel" TEXT NOT NULL DEFAULT '',
  "password" TEXT NOT NULL DEFAULT '',
  "salt" TEXT NOT NULL DEFAULT '',
  "secondary_password" TEXT NOT NULL DEFAULT '',
  "secondary_salt" TEXT NOT NULL DEFAULT '',
  "credit" INTEGER NOT NULL DEFAULT 100,
  "credit_require" REAL NOT NULL DEFAULT 0.00,
  "auto_credit_require" INTEGER NOT NULL DEFAULT 1,
  "account_money" REAL NOT NULL DEFAULT 0.00,
  "credit_money" REAL NOT NULL DEFAULT 0.00,
  "credit_standard" INTEGER NOT NULL DEFAULT 0,
  "wait_money" REAL NOT NULL DEFAULT 0.00,
  "apply_money" REAL NOT NULL DEFAULT 0.00,
  "block_money" REAL NOT NULL DEFAULT 0.00,
  "is_block" INTEGER NOT NULL DEFAULT 0,
  "block_desc" TEXT NOT NULL DEFAULT '',
  "last_block_record" TEXT,
  "withdraw_block" INTEGER NOT NULL DEFAULT 0,
  "freeze_level" INTEGER NOT NULL DEFAULT 0,
  "withdraw_remark" TEXT NOT NULL DEFAULT '',
  "is_open_rank_e" INTEGER NOT NULL DEFAULT 0,
  "after_sale_times" INTEGER NOT NULL DEFAULT 0,
  "sell_times" INTEGER NOT NULL DEFAULT 0,
  "sell_volume" INTEGER NOT NULL DEFAULT 0,
  "is_bear_station_fee" INTEGER NOT NULL DEFAULT 0,
  "station_fee" REAL NOT NULL DEFAULT 0.70,
  "help_id" INTEGER NOT NULL DEFAULT 0,
  "check_round" TEXT DEFAULT NULL,
  "check_time" TEXT DEFAULT NULL,
  "check_reason" TEXT NOT NULL DEFAULT '',
  "default_entry" INTEGER NOT NULL DEFAULT 0,
  "month_sell_count" INTEGER NOT NULL DEFAULT 0,
  "pay_off_mode" INTEGER NOT NULL DEFAULT 0,
  "partner_flag" INTEGER NOT NULL DEFAULT 0,
  "invoice_flag" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "location" TEXT NOT NULL DEFAULT '',
  "bear_num" INTEGER NOT NULL DEFAULT 0,
  "bear_price" REAL NOT NULL DEFAULT 0.00,
  "rename_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "verify_phone" TEXT NOT NULL DEFAULT '',
  "verify_card_no" INTEGER NOT NULL DEFAULT 0,
  "hand_card_url" TEXT NOT NULL DEFAULT '',
  "verify_card_url" INTEGER NOT NULL DEFAULT 0,
  "verify_card_num" REAL NOT NULL DEFAULT 0.0000000000,
  "license_status" INTEGER NOT NULL DEFAULT 0,
  "own_product_status" INTEGER NOT NULL DEFAULT 0,
  "ip" TEXT NOT NULL DEFAULT '',
  "sign_time" TEXT NOT NULL DEFAULT '',
  "expiration_time" TEXT NOT NULL DEFAULT '',
  "biz_user_id" TEXT NOT NULL DEFAULT '',
  "tl_user_id" TEXT NOT NULL DEFAULT '',
  "acctid" TEXT NOT NULL DEFAULT '',
  "promote_fee_balance" REAL NOT NULL DEFAULT 0.00,
  UNIQUE ("login_tel", "item_type")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier111" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "type" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "old_supplier_name" TEXT NOT NULL DEFAULT '',
  "comment_score" REAL DEFAULT 5,
  "supplier_images" TEXT NOT NULL DEFAULT '',
  "supplier_tag" TEXT NOT NULL DEFAULT '',
  "third_shop_id" INTEGER NOT NULL DEFAULT 0,
  "operator_type" INTEGER NOT NULL DEFAULT 0,
  "item_type" INTEGER NOT NULL DEFAULT 1,
  "is_quality" INTEGER NOT NULL DEFAULT 0,
  "quality_sort" INTEGER NOT NULL DEFAULT 0,
  "take_xm_coin_ratio" REAL NOT NULL DEFAULT 0.000,
  "auto_ratio" INTEGER NOT NULL DEFAULT 1,
  "agency_ratio_flag" INTEGER NOT NULL DEFAULT 0,
  "owner_name" TEXT NOT NULL DEFAULT '',
  "owner_tel" TEXT NOT NULL DEFAULT '',
  "avatar" TEXT NOT NULL DEFAULT '',
  "avatar_audit_status" INTEGER NOT NULL DEFAULT 0,
  "avatar_audit_image_url" TEXT NOT NULL DEFAULT '',
  "avatar_audit_trace_id" TEXT NOT NULL DEFAULT '',
  "province_code" TEXT NOT NULL DEFAULT '',
  "province" TEXT NOT NULL DEFAULT '',
  "city_code" TEXT NOT NULL DEFAULT '',
  "city" TEXT NOT NULL DEFAULT '',
  "county_code" TEXT NOT NULL DEFAULT '',
  "country" TEXT NOT NULL DEFAULT '',
  "address_detail" TEXT NOT NULL DEFAULT '',
  "introduction" TEXT NOT NULL DEFAULT '',
  "prove_type" INTEGER NOT NULL DEFAULT 0,
  "real_name" TEXT NOT NULL DEFAULT '',
  "card_no" TEXT NOT NULL DEFAULT '',
  "card_photo" TEXT NOT NULL DEFAULT '',
  "card_photo_back" TEXT NOT NULL DEFAULT '',
  "company_photo" TEXT NOT NULL DEFAULT '',
  "company_name" TEXT NOT NULL DEFAULT '',
  "company_code" TEXT NOT NULL DEFAULT '',
  "wx_open_id" TEXT NOT NULL DEFAULT '',
  "wx_union_id" TEXT NOT NULL DEFAULT '',
  "session_key" TEXT NOT NULL DEFAULT '',
  "login_tel" TEXT NOT NULL DEFAULT '',
  "password" TEXT NOT NULL DEFAULT '',
  "salt" TEXT NOT NULL DEFAULT '',
  "secondary_password" TEXT NOT NULL DEFAULT '',
  "secondary_salt" TEXT NOT NULL DEFAULT '',
  "credit" INTEGER NOT NULL DEFAULT 100,
  "credit_require" REAL NOT NULL DEFAULT 0.00,
  "auto_credit_require" INTEGER NOT NULL DEFAULT 1,
  "account_money" REAL NOT NULL DEFAULT 0.00,
  "credit_money" REAL NOT NULL DEFAULT 0.00,
  "credit_standard" INTEGER NOT NULL DEFAULT 0,
  "wait_money" REAL NOT NULL DEFAULT 0.00,
  "apply_money" REAL NOT NULL DEFAULT 0.00,
  "block_money" REAL NOT NULL DEFAULT 0.00,
  "is_block" INTEGER NOT NULL DEFAULT 0,
  "block_desc" TEXT NOT NULL DEFAULT '',
  "last_block_record" TEXT,
  "withdraw_block" INTEGER NOT NULL DEFAULT 0,
  "freeze_level" INTEGER NOT NULL DEFAULT 0,
  "withdraw_remark" TEXT NOT NULL DEFAULT '',
  "is_open_rank_e" INTEGER NOT NULL DEFAULT 0,
  "after_sale_times" INTEGER NOT NULL DEFAULT 0,
  "sell_times" INTEGER NOT NULL DEFAULT 0,
  "sell_volume" INTEGER NOT NULL DEFAULT 0,
  "is_bear_station_fee" INTEGER NOT NULL DEFAULT 0,
  "station_fee" REAL NOT NULL DEFAULT 0.70,
  "help_id" INTEGER NOT NULL DEFAULT 0,
  "check_round" TEXT DEFAULT NULL,
  "check_time" TEXT DEFAULT NULL,
  "check_reason" TEXT NOT NULL DEFAULT '',
  "default_entry" INTEGER NOT NULL DEFAULT 0,
  "month_sell_count" INTEGER NOT NULL DEFAULT 0,
  "pay_off_mode" INTEGER NOT NULL DEFAULT 0,
  "partner_flag" INTEGER NOT NULL DEFAULT 0,
  "invoice_flag" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "location" TEXT NOT NULL DEFAULT '',
  "bear_num" INTEGER NOT NULL DEFAULT 0,
  "bear_price" REAL NOT NULL DEFAULT 0.00,
  "rename_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "verify_phone" TEXT NOT NULL DEFAULT '',
  "verify_card_no" INTEGER NOT NULL DEFAULT 0,
  "hand_card_url" TEXT NOT NULL DEFAULT '',
  "verify_card_url" INTEGER NOT NULL DEFAULT 0,
  "verify_card_num" REAL NOT NULL DEFAULT 0.0000000000,
  "license_status" INTEGER NOT NULL DEFAULT 0,
  "own_product_status" INTEGER NOT NULL DEFAULT 0,
  "ip" TEXT NOT NULL DEFAULT '',
  "sign_time" TEXT NOT NULL DEFAULT '',
  "expiration_time" TEXT NOT NULL DEFAULT '',
  "biz_user_id" TEXT NOT NULL DEFAULT '',
  "tl_user_id" TEXT NOT NULL DEFAULT '',
  "acctid" TEXT NOT NULL DEFAULT '',
  "promote_fee_balance" REAL NOT NULL DEFAULT 0.00,
  UNIQUE ("login_tel", "item_type")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier1_copy1" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "type" INTEGER NOT NULL DEFAULT 0,
  "own_product_status" INTEGER DEFAULT NULL,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "old_supplier_name" TEXT NOT NULL DEFAULT '',
  "supplier_images" TEXT NOT NULL DEFAULT '',
  "supplier_tag" TEXT NOT NULL DEFAULT '',
  "third_shop_id" INTEGER NOT NULL DEFAULT 0,
  "operator_type" INTEGER NOT NULL DEFAULT 0,
  "item_type" INTEGER NOT NULL DEFAULT 1,
  "is_quality" INTEGER NOT NULL DEFAULT 0,
  "quality_sort" INTEGER NOT NULL DEFAULT 0,
  "take_xm_coin_ratio" REAL NOT NULL DEFAULT 0.000,
  "auto_ratio" INTEGER NOT NULL DEFAULT 1,
  "agency_ratio_flag" INTEGER NOT NULL DEFAULT 0,
  "owner_name" TEXT NOT NULL DEFAULT '',
  "owner_tel" TEXT NOT NULL DEFAULT '',
  "avatar" TEXT NOT NULL DEFAULT '',
  "province_code" TEXT NOT NULL DEFAULT '',
  "province" TEXT NOT NULL DEFAULT '',
  "city_code" TEXT NOT NULL DEFAULT '',
  "city" TEXT NOT NULL DEFAULT '',
  "county_code" TEXT NOT NULL DEFAULT '',
  "country" TEXT NOT NULL DEFAULT '',
  "address_detail" TEXT NOT NULL DEFAULT '',
  "introduction" TEXT NOT NULL DEFAULT '',
  "prove_type" INTEGER NOT NULL DEFAULT 0,
  "real_name" TEXT NOT NULL DEFAULT '',
  "card_no" TEXT NOT NULL DEFAULT '',
  "card_photo" TEXT NOT NULL DEFAULT '',
  "card_photo_back" TEXT NOT NULL DEFAULT '',
  "company_photo" TEXT NOT NULL DEFAULT '',
  "company_name" TEXT NOT NULL DEFAULT '',
  "company_code" TEXT NOT NULL DEFAULT '',
  "wx_open_id" TEXT NOT NULL DEFAULT '',
  "wx_union_id" TEXT NOT NULL DEFAULT '',
  "session_key" TEXT NOT NULL DEFAULT '',
  "login_tel" TEXT NOT NULL DEFAULT '',
  "password" TEXT NOT NULL DEFAULT '',
  "salt" TEXT NOT NULL DEFAULT '',
  "secondary_password" TEXT NOT NULL DEFAULT '',
  "secondary_salt" TEXT NOT NULL DEFAULT '',
  "credit" INTEGER NOT NULL DEFAULT 100,
  "credit_require" REAL NOT NULL DEFAULT 0.00,
  "account_money" REAL NOT NULL DEFAULT 0.00,
  "credit_money" REAL NOT NULL DEFAULT 0.00,
  "credit_standard" INTEGER NOT NULL DEFAULT 0,
  "wait_money" REAL NOT NULL DEFAULT 0.00,
  "apply_money" REAL NOT NULL DEFAULT 0.00,
  "block_money" REAL NOT NULL DEFAULT 0.00,
  "is_block" INTEGER NOT NULL DEFAULT 0,
  "block_desc" TEXT NOT NULL DEFAULT '',
  "last_block_record" TEXT,
  "withdraw_block" INTEGER NOT NULL DEFAULT 0,
  "freeze_level" INTEGER NOT NULL DEFAULT 0,
  "withdraw_remark" TEXT NOT NULL DEFAULT '',
  "is_open_rank_e" INTEGER NOT NULL DEFAULT 0,
  "after_sale_times" INTEGER NOT NULL DEFAULT 0,
  "sell_times" INTEGER NOT NULL DEFAULT 0,
  "sell_volume" INTEGER NOT NULL DEFAULT 0,
  "is_bear_station_fee" INTEGER NOT NULL DEFAULT 0,
  "station_fee" REAL NOT NULL DEFAULT 0.70,
  "help_id" INTEGER NOT NULL DEFAULT 0,
  "check_round" TEXT DEFAULT NULL,
  "check_time" TEXT DEFAULT NULL,
  "check_reason" TEXT NOT NULL DEFAULT '',
  "default_entry" INTEGER NOT NULL DEFAULT 0,
  "month_sell_count" INTEGER NOT NULL DEFAULT 0,
  "pay_off_mode" INTEGER NOT NULL DEFAULT 0,
  "partner_flag" INTEGER NOT NULL DEFAULT 0,
  "invoice_flag" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "location" TEXT NOT NULL DEFAULT '',
  "bear_num" INTEGER NOT NULL DEFAULT 0,
  "bear_price" REAL NOT NULL DEFAULT 0.00,
  "rename_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "verify_phone" TEXT NOT NULL DEFAULT '',
  "verify_card_no" INTEGER NOT NULL DEFAULT 0,
  "hand_card_url" TEXT NOT NULL DEFAULT '',
  "verify_card_url" INTEGER NOT NULL DEFAULT 0,
  "verify_card_num" REAL NOT NULL DEFAULT 0.0000000000,
  "license_status" INTEGER NOT NULL DEFAULT 0,
  "ip" TEXT NOT NULL DEFAULT '',
  "sign_time" TEXT NOT NULL DEFAULT '',
  "expiration_time" TEXT NOT NULL DEFAULT '',
  "comment_score" REAL NOT NULL DEFAULT 4.80,
  "biz_user_id" TEXT NOT NULL DEFAULT '',
  "tl_user_id" TEXT NOT NULL DEFAULT '',
  "acctid" TEXT NOT NULL DEFAULT '',
  UNIQUE ("login_tel", "item_type")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier2" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "type" INTEGER NOT NULL DEFAULT 0,
  "own_product_status" INTEGER DEFAULT NULL,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "old_supplier_name" TEXT NOT NULL DEFAULT '',
  "supplier_images" TEXT NOT NULL DEFAULT '',
  "supplier_tag" TEXT NOT NULL DEFAULT '',
  "third_shop_id" INTEGER NOT NULL DEFAULT 0,
  "operator_type" INTEGER NOT NULL DEFAULT 0,
  "item_type" INTEGER NOT NULL DEFAULT 1,
  "is_quality" INTEGER NOT NULL DEFAULT 0,
  "quality_sort" INTEGER NOT NULL DEFAULT 0,
  "take_xm_coin_ratio" REAL NOT NULL DEFAULT 0.000,
  "auto_ratio" INTEGER NOT NULL DEFAULT 1,
  "agency_ratio_flag" INTEGER NOT NULL DEFAULT 0,
  "owner_name" TEXT NOT NULL DEFAULT '',
  "owner_tel" TEXT NOT NULL DEFAULT '',
  "avatar" TEXT NOT NULL DEFAULT '',
  "avatar_audit_status" INTEGER NOT NULL DEFAULT 0,
  "province_code" TEXT NOT NULL DEFAULT '',
  "province" TEXT NOT NULL DEFAULT '',
  "city_code" TEXT NOT NULL DEFAULT '',
  "city" TEXT NOT NULL DEFAULT '',
  "county_code" TEXT NOT NULL DEFAULT '',
  "country" TEXT NOT NULL DEFAULT '',
  "address_detail" TEXT NOT NULL DEFAULT '',
  "introduction" TEXT NOT NULL DEFAULT '',
  "prove_type" INTEGER NOT NULL DEFAULT 0,
  "real_name" TEXT NOT NULL DEFAULT '',
  "card_no" TEXT NOT NULL DEFAULT '',
  "card_photo" TEXT NOT NULL DEFAULT '',
  "card_photo_back" TEXT NOT NULL DEFAULT '',
  "company_photo" TEXT NOT NULL DEFAULT '',
  "company_name" TEXT NOT NULL DEFAULT '',
  "company_code" TEXT NOT NULL DEFAULT '',
  "wx_open_id" TEXT NOT NULL DEFAULT '',
  "wx_union_id" TEXT NOT NULL DEFAULT '',
  "session_key" TEXT NOT NULL DEFAULT '',
  "login_tel" TEXT NOT NULL DEFAULT '',
  "password" TEXT NOT NULL DEFAULT '',
  "salt" TEXT NOT NULL DEFAULT '',
  "secondary_password" TEXT NOT NULL DEFAULT '',
  "secondary_salt" TEXT NOT NULL DEFAULT '',
  "credit" INTEGER NOT NULL DEFAULT 100,
  "credit_require" REAL NOT NULL DEFAULT 0.00,
  "auto_credit_require" INTEGER NOT NULL DEFAULT 1,
  "account_money" REAL NOT NULL DEFAULT 0.00,
  "credit_money" REAL NOT NULL DEFAULT 0.00,
  "credit_standard" INTEGER NOT NULL DEFAULT 0,
  "wait_money" REAL NOT NULL DEFAULT 0.00,
  "apply_money" REAL NOT NULL DEFAULT 0.00,
  "block_money" REAL NOT NULL DEFAULT 0.00,
  "is_block" INTEGER NOT NULL DEFAULT 0,
  "block_desc" TEXT NOT NULL DEFAULT '',
  "last_block_record" TEXT,
  "withdraw_block" INTEGER NOT NULL DEFAULT 0,
  "freeze_level" INTEGER NOT NULL DEFAULT 0,
  "withdraw_remark" TEXT NOT NULL DEFAULT '',
  "is_open_rank_e" INTEGER NOT NULL DEFAULT 0,
  "after_sale_times" INTEGER NOT NULL DEFAULT 0,
  "sell_times" INTEGER NOT NULL DEFAULT 0,
  "sell_volume" INTEGER NOT NULL DEFAULT 0,
  "is_bear_station_fee" INTEGER NOT NULL DEFAULT 0,
  "station_fee" REAL NOT NULL DEFAULT 0.70,
  "help_id" INTEGER NOT NULL DEFAULT 0,
  "check_round" TEXT DEFAULT NULL,
  "check_time" TEXT DEFAULT NULL,
  "check_reason" TEXT NOT NULL DEFAULT '',
  "default_entry" INTEGER NOT NULL DEFAULT 0,
  "month_sell_count" INTEGER NOT NULL DEFAULT 0,
  "pay_off_mode" INTEGER NOT NULL DEFAULT 0,
  "partner_flag" INTEGER NOT NULL DEFAULT 0,
  "invoice_flag" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "location" TEXT NOT NULL DEFAULT '',
  "bear_num" INTEGER NOT NULL DEFAULT 0,
  "bear_price" REAL NOT NULL DEFAULT 0.00,
  "rename_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "verify_phone" TEXT NOT NULL DEFAULT '',
  "verify_card_no" INTEGER NOT NULL DEFAULT 0,
  "hand_card_url" TEXT NOT NULL DEFAULT '',
  "verify_card_url" INTEGER NOT NULL DEFAULT 0,
  "verify_card_num" REAL NOT NULL DEFAULT 0.0000000000,
  "license_status" INTEGER NOT NULL DEFAULT 0,
  "ip" TEXT NOT NULL DEFAULT '',
  "sign_time" TEXT NOT NULL DEFAULT '',
  "expiration_time" TEXT NOT NULL DEFAULT '',
  "comment_score" REAL NOT NULL DEFAULT 4.80,
  "biz_user_id" TEXT NOT NULL DEFAULT '',
  "tl_user_id" TEXT NOT NULL DEFAULT '',
  "acctid" TEXT NOT NULL DEFAULT '',
  "promote_fee_balance" REAL NOT NULL DEFAULT 0.00,
  UNIQUE ("login_tel", "item_type")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_account" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "supplier_id" INTEGER DEFAULT NULL,
  "owner_name" TEXT DEFAULT NULL,
  "account_type" INTEGER DEFAULT 0,
  "payee_type" INTEGER NOT NULL DEFAULT 1,
  "account_no" TEXT DEFAULT NULL,
  "ali_pay_url" TEXT NOT NULL DEFAULT '',
  "bank_no" TEXT NOT NULL DEFAULT '',
  "bank_name" TEXT NOT NULL DEFAULT '',
  "account_bank_name" TEXT DEFAULT NULL,
  "account_bank_no" TEXT NOT NULL DEFAULT '',
  "account_bank_address" TEXT DEFAULT NULL,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "phone" TEXT NOT NULL DEFAULT '',
  "card_no" TEXT NOT NULL DEFAULT '',
  "verify_account_no" INTEGER NOT NULL DEFAULT 0,
  "promote_fee_flag" INTEGER NOT NULL DEFAULT 0,
  "biz_user_id" TEXT NOT NULL DEFAULT ''
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_account_change" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "type" INTEGER NOT NULL DEFAULT 0,
  "refund_id" INTEGER NOT NULL DEFAULT 0,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "round_no" TEXT NOT NULL DEFAULT '',
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "sub_shelf_sn" TEXT NOT NULL DEFAULT '',
  "zone" TEXT DEFAULT '',
  "shelf" TEXT DEFAULT '',
  "zone_shelf" TEXT DEFAULT '',
  "weight" REAL NOT NULL DEFAULT 0,
  "old_money" REAL NOT NULL DEFAULT 0.00,
  "money" REAL NOT NULL DEFAULT 0.00,
  "new_money" REAL NOT NULL DEFAULT 0.00,
  "refund_money" REAL NOT NULL DEFAULT 0.00,
  "rebate_money" REAL NOT NULL DEFAULT 0.00,
  "remark" TEXT,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_account_change_yhj" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "type" INTEGER NOT NULL DEFAULT 0,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "round_no" TEXT NOT NULL DEFAULT '',
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "sub_shelf_sn" TEXT NOT NULL DEFAULT '',
  "zone" TEXT DEFAULT '',
  "shelf" TEXT DEFAULT '',
  "zone_shelf" TEXT DEFAULT '',
  "weight" REAL NOT NULL DEFAULT 0,
  "old_money" REAL NOT NULL DEFAULT 0.00,
  "money" REAL NOT NULL DEFAULT 0.00,
  "new_money" REAL NOT NULL DEFAULT 0.00,
  "refund_money" REAL NOT NULL DEFAULT 0.00,
  "rebate_money" REAL NOT NULL DEFAULT 0.00,
  "remark" TEXT,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_account_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "supplier_id" INTEGER DEFAULT NULL,
  "supplier_name" TEXT DEFAULT NULL,
  "purchaser_id" INTEGER DEFAULT NULL,
  "order_sn" TEXT DEFAULT NULL,
  "order_item_id" INTEGER DEFAULT NULL,
  "old_money" REAL DEFAULT NULL,
  "money" REAL DEFAULT NULL,
  "new_money" REAL DEFAULT NULL,
  "create_time" TEXT DEFAULT NULL
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_address" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "base_id" INTEGER NOT NULL DEFAULT 0,
  "base_name" TEXT NOT NULL DEFAULT '0',
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "owner_name" TEXT NOT NULL DEFAULT '',
  "owner_tel" TEXT NOT NULL DEFAULT '',
  "province_code" TEXT NOT NULL DEFAULT '',
  "province" TEXT NOT NULL DEFAULT '',
  "city_code" TEXT NOT NULL DEFAULT '',
  "city" TEXT NOT NULL DEFAULT '',
  "county_code" TEXT NOT NULL DEFAULT '',
  "country" TEXT NOT NULL DEFAULT '',
  "address_detail" TEXT NOT NULL DEFAULT '',
  "location" TEXT DEFAULT '0',
  "default_address" INTEGER NOT NULL DEFAULT 1,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_after_sale_rate" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "after_sale_percent" REAL NOT NULL DEFAULT 0.00,
  "calculate_time" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("supplier_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_agreement_agree" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "agreement_update_id" INTEGER NOT NULL DEFAULT 0,
  "agreement_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "agree_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("agreement_update_id", "supplier_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_app" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "app_id" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("supplier_id", "app_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_back" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "type" INTEGER NOT NULL DEFAULT 0,
  "own_product_status" INTEGER DEFAULT NULL,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "old_supplier_name" TEXT NOT NULL DEFAULT '',
  "supplier_images" TEXT NOT NULL DEFAULT '',
  "supplier_tag" TEXT NOT NULL DEFAULT '',
  "third_shop_id" INTEGER NOT NULL DEFAULT 0,
  "operator_type" INTEGER NOT NULL DEFAULT 0,
  "item_type" INTEGER NOT NULL DEFAULT 1,
  "is_quality" INTEGER NOT NULL DEFAULT 0,
  "quality_sort" INTEGER NOT NULL DEFAULT 0,
  "take_xm_coin_ratio" REAL NOT NULL DEFAULT 0.000,
  "auto_ratio" INTEGER NOT NULL DEFAULT 1,
  "agency_ratio_flag" INTEGER NOT NULL DEFAULT 0,
  "owner_name" TEXT NOT NULL DEFAULT '',
  "owner_tel" TEXT NOT NULL DEFAULT '',
  "avatar" TEXT NOT NULL DEFAULT '',
  "province_code" TEXT NOT NULL DEFAULT '',
  "province" TEXT NOT NULL DEFAULT '',
  "city_code" TEXT NOT NULL DEFAULT '',
  "city" TEXT NOT NULL DEFAULT '',
  "county_code" TEXT NOT NULL DEFAULT '',
  "country" TEXT NOT NULL DEFAULT '',
  "address_detail" TEXT NOT NULL DEFAULT '',
  "introduction" TEXT NOT NULL DEFAULT '',
  "prove_type" INTEGER NOT NULL DEFAULT 0,
  "real_name" TEXT NOT NULL DEFAULT '',
  "card_no" TEXT NOT NULL DEFAULT '',
  "card_photo" TEXT NOT NULL DEFAULT '',
  "card_photo_back" TEXT NOT NULL DEFAULT '',
  "company_photo" TEXT NOT NULL DEFAULT '',
  "company_name" TEXT NOT NULL DEFAULT '',
  "company_code" TEXT NOT NULL DEFAULT '',
  "wx_open_id" TEXT NOT NULL DEFAULT '',
  "wx_union_id" TEXT NOT NULL DEFAULT '',
  "session_key" TEXT NOT NULL DEFAULT '',
  "login_tel" TEXT NOT NULL DEFAULT '',
  "password" TEXT NOT NULL DEFAULT '',
  "salt" TEXT NOT NULL DEFAULT '',
  "secondary_password" TEXT NOT NULL DEFAULT '',
  "secondary_salt" TEXT NOT NULL DEFAULT '',
  "credit" INTEGER NOT NULL DEFAULT 100,
  "credit_require" REAL NOT NULL DEFAULT 0.00,
  "account_money" REAL NOT NULL DEFAULT 0.00,
  "credit_money" REAL NOT NULL DEFAULT 0.00,
  "credit_standard" INTEGER NOT NULL DEFAULT 0,
  "wait_money" REAL NOT NULL DEFAULT 0.00,
  "apply_money" REAL NOT NULL DEFAULT 0.00,
  "block_money" REAL NOT NULL DEFAULT 0.00,
  "is_block" INTEGER NOT NULL DEFAULT 0,
  "block_desc" TEXT NOT NULL DEFAULT '',
  "last_block_record" TEXT,
  "withdraw_block" INTEGER NOT NULL DEFAULT 0,
  "freeze_level" INTEGER NOT NULL DEFAULT 0,
  "withdraw_remark" TEXT NOT NULL DEFAULT '',
  "is_open_rank_e" INTEGER NOT NULL DEFAULT 0,
  "after_sale_times" INTEGER NOT NULL DEFAULT 0,
  "sell_times" INTEGER NOT NULL DEFAULT 0,
  "sell_volume" INTEGER NOT NULL DEFAULT 0,
  "is_bear_station_fee" INTEGER NOT NULL DEFAULT 0,
  "station_fee" REAL NOT NULL DEFAULT 0.70,
  "help_id" INTEGER NOT NULL DEFAULT 0,
  "check_round" TEXT DEFAULT NULL,
  "check_time" TEXT DEFAULT NULL,
  "check_reason" TEXT NOT NULL DEFAULT '',
  "default_entry" INTEGER NOT NULL DEFAULT 0,
  "month_sell_count" INTEGER NOT NULL DEFAULT 0,
  "pay_off_mode" INTEGER NOT NULL DEFAULT 0,
  "partner_flag" INTEGER NOT NULL DEFAULT 0,
  "invoice_flag" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "location" TEXT NOT NULL DEFAULT '',
  "bear_num" INTEGER NOT NULL DEFAULT 0,
  "bear_price" REAL NOT NULL DEFAULT 0.00,
  "rename_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "verify_phone" TEXT NOT NULL DEFAULT '',
  "verify_card_no" INTEGER NOT NULL DEFAULT 0,
  "hand_card_url" TEXT NOT NULL DEFAULT '',
  "verify_card_url" INTEGER NOT NULL DEFAULT 0,
  "verify_card_num" REAL NOT NULL DEFAULT 0.0000000000,
  "license_status" INTEGER NOT NULL DEFAULT 0,
  "ip" TEXT NOT NULL DEFAULT '',
  "sign_time" TEXT NOT NULL DEFAULT '',
  "expiration_time" TEXT NOT NULL DEFAULT '',
  "comment_score" REAL NOT NULL DEFAULT 4.80,
  "biz_user_id" TEXT NOT NULL DEFAULT '',
  "tl_user_id" TEXT NOT NULL DEFAULT '',
  "acctid" TEXT NOT NULL DEFAULT '',
  UNIQUE ("login_tel", "item_type")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_balance_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "account_money" REAL NOT NULL DEFAULT 0.00,
  "credit_money" REAL NOT NULL DEFAULT 0.00,
  "create_time" TEXT NOT NULL DEFAULT ''
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_bill_assist" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "tenant_name" TEXT NOT NULL DEFAULT '',
  "tax_no" TEXT NOT NULL DEFAULT '',
  "digit_account" TEXT NOT NULL DEFAULT '',
  "user_account" TEXT NOT NULL DEFAULT '',
  "bank_name" TEXT NOT NULL DEFAULT '',
  "bank_no" TEXT NOT NULL DEFAULT '',
  "tax_rate" TEXT NOT NULL DEFAULT '',
  "bai_wang_end_time" TEXT DEFAULT NULL,
  "end_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("supplier_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_bill_assist_order" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "order_no" TEXT NOT NULL DEFAULT '',
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "tenant_name" TEXT NOT NULL DEFAULT '',
  "tax_no" TEXT NOT NULL DEFAULT '',
  "digit_account" TEXT NOT NULL DEFAULT '',
  "user_account" TEXT NOT NULL DEFAULT '',
  "bank_name" TEXT NOT NULL DEFAULT '',
  "bank_no" TEXT NOT NULL DEFAULT '',
  "tax_rate" TEXT NOT NULL DEFAULT '',
  "bai_wang_end_time" TEXT DEFAULT NULL,
  "start_time" TEXT DEFAULT NULL,
  "end_time" TEXT DEFAULT NULL,
  "order_amount" REAL NOT NULL DEFAULT 0.00,
  "order_status" INTEGER NOT NULL DEFAULT 0,
  "pay_type" INTEGER DEFAULT NULL,
  "mch_id" TEXT NOT NULL DEFAULT '',
  "wx_transaction_id" TEXT NOT NULL DEFAULT '',
  "pay_time" TEXT DEFAULT NULL,
  "remark" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("order_no")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_bill_settlement" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "round_no" TEXT NOT NULL DEFAULT '',
  "round_type" INTEGER NOT NULL DEFAULT 0,
  "order_status" INTEGER DEFAULT NULL,
  "service_price" REAL DEFAULT NULL,
  "origin_service_price" REAL DEFAULT 0.00,
  "supplier_price" REAL DEFAULT NULL,
  "qualify_price" REAL DEFAULT NULL,
  "total_supplier_price" REAL DEFAULT NULL,
  "station_fee" REAL DEFAULT NULL,
  "product_num" INTEGER DEFAULT NULL,
  "purchase_num" INTEGER DEFAULT NULL,
  "item_num" INTEGER DEFAULT NULL,
  "is_replace_match" INTEGER DEFAULT NULL,
  "late_punish_price" REAL DEFAULT NULL,
  "late_price" REAL DEFAULT NULL,
  "stock_out_num" INTEGER DEFAULT NULL,
  "demote_num" INTEGER DEFAULT NULL,
  "after_sale" INTEGER DEFAULT NULL,
  "return_num" INTEGER DEFAULT NULL,
  "status" INTEGER DEFAULT NULL,
  "order_sn_list" TEXT,
  "order_sn_list_all" TEXT,
  "create_time" TEXT DEFAULT NULL,
  "update_time" TEXT DEFAULT NULL,
  "data_status" INTEGER DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_black_list" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "purchaser_name" TEXT NOT NULL DEFAULT '',
  "phone" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("supplier_id", "purchaser_id", "phone")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_black_list_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "pid" INTEGER NOT NULL DEFAULT 0,
  "operation_type" INTEGER NOT NULL DEFAULT 0,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "purchaser_name" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_class_second" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "rank_auth" TEXT NOT NULL DEFAULT '[]',
  "fes_limit_flag" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_class_second_apply" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "rank_auth" TEXT NOT NULL DEFAULT '[]',
  "approved_rank_auth" TEXT NOT NULL DEFAULT '[]',
  "status" INTEGER NOT NULL DEFAULT 0,
  "active_flag" INTEGER DEFAULT 1,
  "audit_user_id" INTEGER DEFAULT NULL,
  "audit_user_name" TEXT DEFAULT NULL,
  "audit_remark" TEXT DEFAULT NULL,
  "audit_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("supplier_id", "second_id", "active_flag")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_class_second_auth_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT DEFAULT NULL,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "second_name" TEXT DEFAULT NULL,
  "second_pic_url" TEXT DEFAULT NULL,
  "before_rank_auth" TEXT DEFAULT '[]',
  "after_rank_auth" TEXT DEFAULT '[]',
  "operation_type" INTEGER NOT NULL DEFAULT 0,
  "cancel_auth_type" INTEGER DEFAULT NULL,
  "operator_id" INTEGER DEFAULT NULL,
  "operator_name" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_comment" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "purchaser_name" TEXT NOT NULL DEFAULT '',
  "phone" TEXT NOT NULL DEFAULT '',
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "score" INTEGER NOT NULL DEFAULT 1,
  "content" TEXT NOT NULL DEFAULT '',
  "picture" TEXT NOT NULL DEFAULT '',
  "reply_content" TEXT NOT NULL DEFAULT '',
  "reply_picture" TEXT,
  "reply_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_comment_score_daily" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "score_date" TEXT NOT NULL DEFAULT '',
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "total_score" REAL NOT NULL DEFAULT 0.0000,
  "total_num" INTEGER NOT NULL DEFAULT 0,
  "praise_count" INTEGER NOT NULL DEFAULT 0,
  "comment_num" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("supplier_id", "score_date")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_enter" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "type" INTEGER DEFAULT 1,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "login_tel" TEXT NOT NULL DEFAULT '',
  "date" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "enter_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "night_enter_time" TEXT NOT NULL DEFAULT '',
  "night_data_status" INTEGER NOT NULL DEFAULT 0,
  "night_open" INTEGER NOT NULL DEFAULT 0,
  "is_qualify" INTEGER NOT NULL DEFAULT 0,
  "is_late" INTEGER DEFAULT 0,
  "night_is_late" INTEGER NOT NULL DEFAULT 0,
  "is_force_flag" INTEGER NOT NULL DEFAULT 0,
  "quality_inspection_flag" INTEGER NOT NULL DEFAULT 0,
  "distribution_overtime" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT DEFAULT NULL,
  "update_time" TEXT DEFAULT NULL
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_enter_item" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "enter_id" INTEGER NOT NULL DEFAULT 0,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "order_num" INTEGER NOT NULL DEFAULT 1,
  "sub_shelf_sn" TEXT DEFAULT NULL,
  "zone" TEXT DEFAULT NULL,
  "shelf" TEXT DEFAULT NULL,
  "zone_shelf" TEXT DEFAULT NULL,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "jump_num" INTEGER NOT NULL DEFAULT 0,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "date" TEXT NOT NULL DEFAULT '',
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "order_item_id" INTEGER NOT NULL DEFAULT 0,
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "product_name" TEXT NOT NULL DEFAULT '',
  "rank_num" INTEGER NOT NULL DEFAULT 1,
  "sku_config" TEXT NOT NULL DEFAULT '',
  "item_num" INTEGER NOT NULL DEFAULT 0,
  "order_item_num" INTEGER NOT NULL DEFAULT 0,
  "order_item_weight" INTEGER NOT NULL DEFAULT 0,
  "is_position" INTEGER NOT NULL DEFAULT 0,
  "is_qualify" INTEGER NOT NULL DEFAULT 0,
  "not_qualify_num" INTEGER NOT NULL DEFAULT 0,
  "refund_num" INTEGER NOT NULL DEFAULT 0,
  "lower_rank_num" INTEGER NOT NULL DEFAULT 0,
  "lower_rank_level" INTEGER NOT NULL DEFAULT 0,
  "qualify_user_id" INTEGER NOT NULL DEFAULT 0,
  "qualify_user_name" TEXT NOT NULL DEFAULT '',
  "prepare_user_id" INTEGER NOT NULL DEFAULT 0,
  "prepare_user_name" TEXT NOT NULL DEFAULT '',
  "prepare_time" TEXT DEFAULT NULL,
  "record_num" INTEGER NOT NULL DEFAULT 0,
  "handle_record_num" INTEGER NOT NULL DEFAULT 0,
  "prepare_item_num" INTEGER NOT NULL DEFAULT 0,
  "re_qualify_user_id" INTEGER NOT NULL DEFAULT 0,
  "re_qualify_user_name" TEXT NOT NULL DEFAULT '',
  "is_confirm_refund_num" INTEGER NOT NULL DEFAULT 0,
  "is_confirm_lower_rank_num" INTEGER NOT NULL DEFAULT 0,
  "is_confirm_lack_item_num" INTEGER NOT NULL DEFAULT 0,
  "is_re_qualify_user_confirm" INTEGER NOT NULL DEFAULT 0,
  "lack_item_num" INTEGER NOT NULL DEFAULT 0,
  "manual_lack_item_num" INTEGER NOT NULL DEFAULT 0,
  "restock_item_num" INTEGER NOT NULL DEFAULT 0,
  "refund_status" INTEGER NOT NULL DEFAULT 0,
  "limit_distribution_flag" INTEGER NOT NULL DEFAULT 0,
  "qualify_process_status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "lack_replenish_num" INTEGER NOT NULL DEFAULT 0,
  "lack_num" INTEGER NOT NULL DEFAULT 0,
  "already_restock_num" INTEGER NOT NULL DEFAULT 0,
  "return_num" INTEGER NOT NULL DEFAULT 0,
  "focus_flag" INTEGER NOT NULL DEFAULT 0,
  "quality_inspection_flag" INTEGER NOT NULL DEFAULT 0,
  "return_replenish_num" INTEGER DEFAULT NULL,
  "wms_restock_num" INTEGER NOT NULL DEFAULT 0,
  "duty_flag" INTEGER NOT NULL DEFAULT 0,
  "duty_pic" TEXT NOT NULL DEFAULT '',
  "duty_remark" TEXT NOT NULL DEFAULT '',
  "print_num" INTEGER NOT NULL DEFAULT 0,
  "no_after_sale_flag" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("order_sn", "product_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_enter_item_back" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "enter_id" INTEGER NOT NULL DEFAULT 0,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "order_num" INTEGER NOT NULL DEFAULT 1,
  "sub_shelf_sn" TEXT NOT NULL DEFAULT '',
  "zone" TEXT NOT NULL DEFAULT '',
  "shelf" TEXT NOT NULL DEFAULT '',
  "zone_shelf" TEXT NOT NULL DEFAULT '',
  "order_sn" TEXT NOT NULL DEFAULT '',
  "date" TEXT NOT NULL DEFAULT '',
  "platform" INTEGER NOT NULL DEFAULT 0,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "order_item_id" INTEGER NOT NULL DEFAULT 0,
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "product_name" TEXT NOT NULL DEFAULT '',
  "rank_num" INTEGER NOT NULL DEFAULT 1,
  "sku_config" TEXT NOT NULL DEFAULT '',
  "item_num" INTEGER NOT NULL DEFAULT 0,
  "order_item_num" INTEGER NOT NULL DEFAULT 0,
  "order_item_weight" INTEGER NOT NULL DEFAULT 0,
  "is_position" INTEGER NOT NULL DEFAULT 0,
  "is_qualify" INTEGER NOT NULL DEFAULT 0,
  "not_qualify_num" INTEGER NOT NULL DEFAULT 0,
  "refund_num" INTEGER NOT NULL DEFAULT 0,
  "lower_rank_num" INTEGER NOT NULL DEFAULT 0,
  "lower_rank_level" INTEGER NOT NULL DEFAULT 0,
  "qualify_user_id" INTEGER NOT NULL DEFAULT 0,
  "qualify_user_name" TEXT NOT NULL DEFAULT '',
  "prepare_user_id" INTEGER NOT NULL DEFAULT 0,
  "prepare_user_name" TEXT NOT NULL DEFAULT '',
  "prepare_item_num" INTEGER NOT NULL DEFAULT 0,
  "re_qualify_user_id" INTEGER NOT NULL DEFAULT 0,
  "re_qualify_user_name" TEXT NOT NULL DEFAULT '',
  "is_confirm_refund_num" INTEGER NOT NULL DEFAULT 0,
  "is_confirm_lower_rank_num" INTEGER NOT NULL DEFAULT 0,
  "is_confirm_lack_item_num" INTEGER NOT NULL DEFAULT 0,
  "is_re_qualify_user_confirm" INTEGER NOT NULL DEFAULT 0,
  "lack_item_num" INTEGER NOT NULL DEFAULT 0,
  "manual_lack_item_num" INTEGER NOT NULL DEFAULT 0000000000,
  "restock_item_num" INTEGER NOT NULL DEFAULT 0,
  "refund_status" INTEGER NOT NULL DEFAULT 0,
  "refund_money" REAL NOT NULL DEFAULT 0.00,
  "lower_money" REAL NOT NULL DEFAULT 0.00,
  "lack_money" REAL NOT NULL DEFAULT 0.00,
  "limit_distribution_flag" INTEGER NOT NULL DEFAULT 0,
  "qualify_process_status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "lack_replenish_num" INTEGER NOT NULL DEFAULT 0,
  "lack_num" INTEGER NOT NULL DEFAULT 0,
  "return_num" INTEGER NOT NULL DEFAULT 0,
  "return_replenish_num" INTEGER NOT NULL DEFAULT 0,
  "wms_restock_num" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("order_sn", "product_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_enter_item_copy2" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "enter_id" INTEGER NOT NULL DEFAULT 0,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "order_num" INTEGER NOT NULL DEFAULT 1,
  "sub_shelf_sn" TEXT NOT NULL DEFAULT '',
  "zone" TEXT NOT NULL DEFAULT '',
  "shelf" TEXT NOT NULL DEFAULT '',
  "zone_shelf" TEXT NOT NULL DEFAULT '',
  "order_sn" TEXT NOT NULL DEFAULT '',
  "date" TEXT NOT NULL DEFAULT '',
  "platform" INTEGER NOT NULL DEFAULT 0,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "order_item_id" INTEGER NOT NULL DEFAULT 0,
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "product_name" TEXT NOT NULL DEFAULT '',
  "rank_num" INTEGER NOT NULL DEFAULT 1,
  "sku_config" TEXT NOT NULL DEFAULT '',
  "item_num" INTEGER NOT NULL DEFAULT 0,
  "order_item_num" INTEGER NOT NULL DEFAULT 0,
  "order_item_weight" INTEGER NOT NULL DEFAULT 0,
  "is_position" INTEGER NOT NULL DEFAULT 0,
  "is_qualify" INTEGER NOT NULL DEFAULT 0,
  "not_qualify_num" INTEGER NOT NULL DEFAULT 0,
  "refund_num" INTEGER NOT NULL DEFAULT 0,
  "lower_rank_num" INTEGER NOT NULL DEFAULT 0,
  "lower_rank_level" INTEGER NOT NULL DEFAULT 0,
  "qualify_user_id" INTEGER NOT NULL DEFAULT 0,
  "qualify_user_name" TEXT NOT NULL DEFAULT '',
  "prepare_user_id" INTEGER NOT NULL DEFAULT 0,
  "prepare_user_name" TEXT NOT NULL DEFAULT '',
  "prepare_item_num" INTEGER NOT NULL DEFAULT 0,
  "re_qualify_user_id" INTEGER NOT NULL DEFAULT 0,
  "re_qualify_user_name" TEXT NOT NULL DEFAULT '',
  "is_confirm_refund_num" INTEGER NOT NULL DEFAULT 0,
  "is_confirm_lower_rank_num" INTEGER NOT NULL DEFAULT 0,
  "is_confirm_lack_item_num" INTEGER NOT NULL DEFAULT 0,
  "is_re_qualify_user_confirm" INTEGER NOT NULL DEFAULT 0,
  "lack_item_num" INTEGER NOT NULL DEFAULT 0,
  "manual_lack_item_num" INTEGER NOT NULL DEFAULT 0000000000,
  "restock_item_num" INTEGER NOT NULL DEFAULT 0,
  "refund_status" INTEGER NOT NULL DEFAULT 0,
  "refund_money" REAL NOT NULL DEFAULT 0.00,
  "lower_money" REAL NOT NULL DEFAULT 0.00,
  "lack_money" REAL NOT NULL DEFAULT 0.00,
  "limit_distribution_flag" INTEGER NOT NULL DEFAULT 0,
  "qualify_process_status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "lack_replenish_num" INTEGER NOT NULL DEFAULT 0,
  "lack_num" INTEGER NOT NULL DEFAULT 0,
  "return_num" INTEGER NOT NULL DEFAULT 0,
  "return_replenish_num" INTEGER NOT NULL DEFAULT 0,
  "wms_restock_num" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("order_sn", "product_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_enter_package" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "date" TEXT NOT NULL DEFAULT '',
  "order_num" INTEGER NOT NULL DEFAULT 1,
  "zone" TEXT NOT NULL DEFAULT '',
  "shelf" TEXT NOT NULL DEFAULT '',
  "zone_shelf" TEXT NOT NULL DEFAULT '',
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "package_user_id" INTEGER NOT NULL DEFAULT 0,
  "package_user_name" TEXT NOT NULL DEFAULT '',
  "package_num" TEXT NOT NULL DEFAULT '',
  "real_package_num" TEXT NOT NULL DEFAULT '',
  "package_status" INTEGER NOT NULL DEFAULT 0,
  "package_write_status" INTEGER DEFAULT NULL,
  "package_type" INTEGER NOT NULL DEFAULT 0,
  "package_time" TEXT DEFAULT NULL,
  "biz_user_id" INTEGER NOT NULL DEFAULT 0,
  "biz_user_name" TEXT NOT NULL DEFAULT '',
  "biz_status" INTEGER NOT NULL DEFAULT 0,
  "express_id" INTEGER NOT NULL DEFAULT 0,
  "express_weight" REAL NOT NULL DEFAULT 0.00,
  "express_price" REAL NOT NULL DEFAULT 0.00,
  "express_actual_weight" REAL NOT NULL DEFAULT 0.00,
  "express_status" INTEGER DEFAULT NULL,
  "express_actual_price" REAL NOT NULL DEFAULT 0.00,
  "remark" TEXT NOT NULL DEFAULT '',
  "url" TEXT,
  "packager_income_status" INTEGER NOT NULL DEFAULT 0,
  "limit_flag" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_experience_score" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "total_score" REAL NOT NULL DEFAULT 100.00,
  "base_sale_score" REAL NOT NULL DEFAULT 20.00,
  "product_score" REAL NOT NULL DEFAULT 40.00,
  "delivery_score" REAL NOT NULL DEFAULT 40.00,
  "is_display" INTEGER NOT NULL DEFAULT 1,
  "score_date" TEXT NOT NULL DEFAULT '1970-01-01',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("supplier_id", "score_date")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_info" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "register_no" TEXT NOT NULL DEFAULT '',
  "license_name" TEXT NOT NULL DEFAULT '',
  "license_url" TEXT NOT NULL DEFAULT '',
  "license_legal_name" TEXT NOT NULL DEFAULT '',
  "license_expire_date" TEXT DEFAULT NULL,
  "license_reject_reason" TEXT NOT NULL DEFAULT '',
  "own_product_images" TEXT,
  "own_product_reject_reason" TEXT NOT NULL DEFAULT '',
  "month_sales_count" INTEGER NOT NULL DEFAULT 0,
  "qualify_flag" INTEGER NOT NULL DEFAULT 0,
  "top_rank_round_no" TEXT NOT NULL DEFAULT '',
  "top_rank_num" INTEGER NOT NULL DEFAULT 0,
  "top_rank_first_type" INTEGER NOT NULL DEFAULT 0,
  "top_rank_first_id" INTEGER NOT NULL DEFAULT 0,
  "top_rank_category_name" TEXT NOT NULL DEFAULT '',
  "top_rank_type" INTEGER NOT NULL DEFAULT 0,
  "shop_repurchase_count" INTEGER NOT NULL DEFAULT 0,
  "shop_praise_count" INTEGER NOT NULL DEFAULT 0,
  "shop_praise_ratio" REAL NOT NULL DEFAULT 0.00,
  "favorite_supplier_count" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "tag_update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "invoice_punish_flag" INTEGER NOT NULL DEFAULT 0,
  "invoice_record_flag" INTEGER NOT NULL DEFAULT 0,
  "license_record_flag" INTEGER NOT NULL DEFAULT 0,
  "invoice_punish_record_flag" INTEGER NOT NULL DEFAULT 0,
  "freeze_count" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("supplier_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_invoice_quota" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "total_quota" REAL NOT NULL DEFAULT 0.00,
  "invoicing_amount" REAL NOT NULL DEFAULT 0.00,
  "invoiced_amount" REAL NOT NULL DEFAULT 0.00,
  "overdue_amount" REAL NOT NULL DEFAULT 0.00,
  "available_quota" REAL NOT NULL DEFAULT 0.00,
  "version" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("supplier_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_invoice_set" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "tenant_name" TEXT NOT NULL DEFAULT '',
  "tax_no" TEXT NOT NULL DEFAULT '',
  "digit_account" TEXT NOT NULL DEFAULT '',
  "bank_name" TEXT NOT NULL DEFAULT '',
  "bank_no" TEXT NOT NULL DEFAULT '',
  "good_flag" INTEGER NOT NULL DEFAULT 0,
  "tax_rate" TEXT NOT NULL DEFAULT '0.01',
  "bai_wang_end_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "end_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "bai_wang_login_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("supplier_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_type" INTEGER NOT NULL DEFAULT 0,
  "type" INTEGER NOT NULL DEFAULT 0,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "content" TEXT,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_operation_money_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "supplier_id" INTEGER DEFAULT NULL,
  "supplier_name" TEXT DEFAULT NULL,
  "type" INTEGER NOT NULL DEFAULT 0,
  "pay_reason" TEXT NOT NULL DEFAULT '',
  "pay_way" TEXT NOT NULL DEFAULT '',
  "old_money" REAL NOT NULL DEFAULT 0.00,
  "money" REAL NOT NULL DEFAULT 0.00,
  "new_money" REAL NOT NULL DEFAULT 0.00,
  "money_desc" TEXT NOT NULL DEFAULT '',
  "trade_no" TEXT NOT NULL DEFAULT '',
  "wx_pay_id" TEXT NOT NULL DEFAULT '',
  "wx_pay_time" TEXT DEFAULT NULL,
  "receipt_url" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT DEFAULT NULL,
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_order" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "order_num" INTEGER NOT NULL DEFAULT 1,
  "order_tag" INTEGER NOT NULL DEFAULT 0,
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "sub_shelf_sn" TEXT DEFAULT NULL,
  "is_addition" INTEGER NOT NULL DEFAULT 0,
  "receive_name" TEXT NOT NULL DEFAULT '',
  "receive_tel" TEXT NOT NULL DEFAULT '',
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "supplier_no" TEXT NOT NULL DEFAULT '',
  "delivery_no" TEXT NOT NULL DEFAULT '',
  "round_no" TEXT NOT NULL DEFAULT '',
  "supply_price" REAL NOT NULL DEFAULT 0.00,
  "origin_supply_price" REAL NOT NULL DEFAULT 0.00,
  "actual_price" REAL DEFAULT NULL,
  "origin_actual_price" REAL NOT NULL DEFAULT 0.00,
  "platform_discount" REAL NOT NULL DEFAULT 0.00,
  "origin_platform_discount" REAL NOT NULL DEFAULT 0.00,
  "take_xm_coin" REAL DEFAULT NULL,
  "origin_take_xm_coin" REAL NOT NULL DEFAULT 0.00,
  "take_ratio" REAL NOT NULL DEFAULT 0.000,
  "after_sale_supply_price" REAL NOT NULL DEFAULT 0.00,
  "after_sale_price" REAL NOT NULL DEFAULT 0.00,
  "paid_price" REAL NOT NULL DEFAULT 0.00,
  "paid_coin" REAL DEFAULT NULL,
  "order_status" INTEGER NOT NULL DEFAULT 0,
  "wx_pay_time" TEXT DEFAULT NULL,
  "after_sale_status" INTEGER NOT NULL DEFAULT 0,
  "after_sale_agree_type" INTEGER NOT NULL DEFAULT 0,
  "refund_status" INTEGER NOT NULL DEFAULT 0,
  "sort_status" INTEGER NOT NULL DEFAULT 0,
  "delivery_status" INTEGER NOT NULL DEFAULT 0,
  "is_presale" INTEGER NOT NULL DEFAULT 0,
  "is_deliver" INTEGER NOT NULL DEFAULT 0,
  "is_bear_station_fee" INTEGER NOT NULL DEFAULT 0,
  "station_fee" REAL NOT NULL DEFAULT 0.00,
  "origin_total_station_fee" REAL NOT NULL DEFAULT 0.00,
  "total_station_fee" REAL NOT NULL DEFAULT 0.00,
  "after_sale_coin" TEXT NOT NULL DEFAULT '',
  "is_sale_agency" INTEGER NOT NULL DEFAULT 0,
  "is_invoice_marked" INTEGER NOT NULL DEFAULT 0,
  "supplier_quota_added" INTEGER NOT NULL DEFAULT 0,
  "purchaser_quota_added" INTEGER NOT NULL DEFAULT 0,
  "settle_flag" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "is_bond" INTEGER NOT NULL DEFAULT 0,
  "bond_price" REAL NOT NULL DEFAULT 0.00,
  "bond_paid_price" REAL NOT NULL DEFAULT 0.00,
  "zone" TEXT DEFAULT NULL,
  "shelf" TEXT DEFAULT NULL,
  "zone_shelf" TEXT DEFAULT '',
  UNIQUE ("supplier_no")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_order_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "pid" TEXT NOT NULL DEFAULT '',
  "order_sn" TEXT DEFAULT NULL,
  "time" TEXT DEFAULT NULL,
  "type" TEXT DEFAULT NULL,
  "operator_type" TEXT DEFAULT NULL,
  "supplier_id" INTEGER DEFAULT NULL,
  "supplier_name" TEXT DEFAULT NULL,
  "supply_price" REAL DEFAULT NULL,
  "take_ratio" REAL DEFAULT NULL,
  UNIQUE ("pid")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_order_record" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "order_sn" TEXT DEFAULT '',
  "pay_time" TEXT DEFAULT NULL,
  "record_type" INTEGER NOT NULL DEFAULT 0,
  "supplier_type" INTEGER NOT NULL DEFAULT 0,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "supplier_get" REAL NOT NULL DEFAULT 0.00,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_order_tmp" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "order_num" INTEGER NOT NULL DEFAULT 1,
  "order_tag" INTEGER NOT NULL DEFAULT 0,
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "sub_shelf_sn" TEXT NOT NULL DEFAULT '',
  "zone" TEXT NOT NULL DEFAULT '',
  "shelf" TEXT NOT NULL DEFAULT '',
  "zone_shelf" TEXT NOT NULL DEFAULT '',
  "is_addition" INTEGER NOT NULL DEFAULT 0,
  "receive_name" TEXT NOT NULL DEFAULT '',
  "receive_tel" TEXT NOT NULL DEFAULT '',
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "supplier_no" TEXT NOT NULL DEFAULT '',
  "delivery_no" TEXT NOT NULL DEFAULT '',
  "round_no" TEXT NOT NULL DEFAULT '',
  "supply_price" REAL NOT NULL DEFAULT 0.00,
  "origin_supply_price" REAL NOT NULL DEFAULT 0.00,
  "actual_price" REAL NOT NULL DEFAULT 0.00,
  "origin_actual_price" REAL NOT NULL DEFAULT 0.00,
  "platform_discount" REAL NOT NULL DEFAULT 0.00,
  "origin_platform_discount" REAL NOT NULL DEFAULT 0.00,
  "take_xm_coin" REAL NOT NULL DEFAULT 0.00,
  "origin_take_xm_coin" REAL NOT NULL DEFAULT 0.00,
  "take_ratio" REAL NOT NULL DEFAULT 0.000,
  "after_sale_supply_price" REAL NOT NULL DEFAULT 0.00,
  "after_sale_price" REAL NOT NULL DEFAULT 0.00,
  "paid_price" REAL NOT NULL DEFAULT 0.00,
  "paid_coin" REAL NOT NULL DEFAULT 0.00,
  "bond_price" REAL NOT NULL DEFAULT 0.00,
  "bond_paid_price" REAL NOT NULL DEFAULT 0.00,
  "after_sale_coin" REAL NOT NULL DEFAULT 0.00,
  "order_status" INTEGER NOT NULL DEFAULT 0,
  "wx_pay_time" TEXT DEFAULT NULL,
  "after_sale_status" INTEGER NOT NULL DEFAULT 0,
  "after_sale_agree_type" INTEGER NOT NULL DEFAULT 0,
  "refund_status" INTEGER NOT NULL DEFAULT 0,
  "sort_status" INTEGER NOT NULL DEFAULT 0,
  "delivery_status" INTEGER NOT NULL DEFAULT 0,
  "is_presale" INTEGER NOT NULL DEFAULT 0,
  "is_deliver" INTEGER NOT NULL DEFAULT 0,
  "is_bear_station_fee" INTEGER NOT NULL DEFAULT 0,
  "station_fee" REAL NOT NULL DEFAULT 0.00,
  "origin_total_station_fee" REAL NOT NULL DEFAULT 0.00,
  "total_station_fee" REAL NOT NULL DEFAULT 0.00,
  "is_bond" INTEGER NOT NULL DEFAULT 0,
  "is_sale_agency" INTEGER NOT NULL DEFAULT 0,
  "is_invoice_marked" INTEGER NOT NULL DEFAULT 0,
  "supplier_quota_added" INTEGER NOT NULL DEFAULT 0,
  "purchaser_quota_added" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("supplier_no")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_punish" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "pid" INTEGER NOT NULL DEFAULT 0,
  "round_no" TEXT NOT NULL DEFAULT '',
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "sub_shelf_sn" TEXT DEFAULT '',
  "zone" TEXT NOT NULL DEFAULT '',
  "shelf" TEXT NOT NULL DEFAULT '',
  "zone_shelf" TEXT NOT NULL DEFAULT '',
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "punish_type" INTEGER NOT NULL DEFAULT 0,
  "punish_kind" INTEGER NOT NULL DEFAULT 0,
  "punish_link" INTEGER NOT NULL DEFAULT 0,
  "account_change_id" INTEGER NOT NULL DEFAULT 0,
  "money_log_id" INTEGER NOT NULL DEFAULT 0,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "order_item_id" INTEGER NOT NULL DEFAULT 0,
  "enter_item_id" INTEGER DEFAULT NULL,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "punish_proportion" INTEGER NOT NULL DEFAULT 0,
  "punish_num" INTEGER NOT NULL DEFAULT 0,
  "punish_price" REAL NOT NULL DEFAULT 0,
  "pic_url" TEXT NOT NULL DEFAULT '',
  "compensate_flag" INTEGER NOT NULL DEFAULT 0,
  "compensate_price" REAL DEFAULT 0.00,
  "compensate_service_fee" REAL NOT NULL DEFAULT 0.00,
  "compensate_coin" REAL NOT NULL DEFAULT 0.00,
  "settle_flag" INTEGER DEFAULT NULL,
  "settle_price" REAL DEFAULT NULL,
  "refund_result" TEXT NOT NULL DEFAULT '',
  "refund_id" INTEGER NOT NULL DEFAULT 0,
  "remark" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "handle_status" INTEGER DEFAULT NULL,
  "handle_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_recharge" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "recharge_type" INTEGER NOT NULL DEFAULT 1,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "recharge_amount" REAL NOT NULL DEFAULT 0.00,
  "image_url" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "review_status" INTEGER NOT NULL DEFAULT 0,
  "reviewer_id" INTEGER NOT NULL DEFAULT 0,
  "reviewer_name" TEXT NOT NULL DEFAULT '',
  "review_time" TEXT DEFAULT NULL,
  "review_remark" TEXT NOT NULL DEFAULT '',
  "review_image_url" TEXT NOT NULL DEFAULT '',
  "account_change_id" INTEGER NOT NULL DEFAULT 0,
  "apply_id" INTEGER NOT NULL DEFAULT 0,
  "out_trade_no" TEXT NOT NULL DEFAULT '',
  "create_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_recharge_apply" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "out_trade_no" TEXT NOT NULL DEFAULT '',
  "trade_no" TEXT NOT NULL DEFAULT '',
  "qrcode" TEXT NOT NULL DEFAULT '',
  "money" REAL NOT NULL DEFAULT 0.00,
  "status" INTEGER NOT NULL DEFAULT 0,
  "trade_ip" TEXT NOT NULL DEFAULT '',
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "payee_ent_id" TEXT NOT NULL DEFAULT '',
  "payee_ent_name" TEXT NOT NULL DEFAULT '',
  "payer_id" TEXT NOT NULL DEFAULT '',
  "payer_bank_sname" TEXT NOT NULL DEFAULT '',
  "payer_acct_last" TEXT NOT NULL DEFAULT '',
  "payer_acct_type" TEXT NOT NULL DEFAULT '',
  "payer_bank_type" TEXT NOT NULL DEFAULT '',
  "payer_ent_name" TEXT NOT NULL DEFAULT '',
  "pay_status" TEXT NOT NULL DEFAULT '',
  "memo" TEXT NOT NULL DEFAULT '',
  "attachment" TEXT NOT NULL DEFAULT '',
  "pay_time" TEXT DEFAULT NULL,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("out_trade_no")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_reconciliation" (
  "source_channel" TEXT NOT NULL DEFAULT '',
  "source_id" INTEGER NOT NULL DEFAULT 0,
  "statement_date" TEXT NOT NULL DEFAULT '',
  "partner_name" TEXT DEFAULT NULL,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "business_time" TEXT NOT NULL DEFAULT '',
  "order_type" TEXT NOT NULL DEFAULT '',
  "supplier_type" TEXT DEFAULT NULL,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT DEFAULT NULL,
  "supplier_settlement" REAL NOT NULL DEFAULT 0.00,
  "commission_amount" REAL NOT NULL DEFAULT 0.00,
  "created_at" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "updated_at" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  PRIMARY KEY ("source_channel", "source_id", "order_type")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_reg" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "reg_id" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("reg_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_repurchase_stats" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "repurchase_count" INTEGER NOT NULL DEFAULT 0,
  "stat_date" TEXT NOT NULL DEFAULT '',
  "created_at" TEXT DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("supplier_id", "stat_date")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_score_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "score_type" INTEGER NOT NULL DEFAULT 1,
  "score_change" REAL NOT NULL DEFAULT 0.00,
  "score_dimension" INTEGER NOT NULL DEFAULT 0,
  "score_item" TEXT NOT NULL DEFAULT '',
  "score_reason" TEXT NOT NULL DEFAULT '',
  "source_type" INTEGER NOT NULL DEFAULT 0,
  "source_id" INTEGER NOT NULL DEFAULT 0,
  "score_date" TEXT NOT NULL DEFAULT '1970-01-01',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_second_sale_stat" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "last_sale_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("supplier_id", "second_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_sell_record" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "start_date" TEXT NOT NULL DEFAULT '',
  "end_date" TEXT NOT NULL DEFAULT '',
  "after_sale_times" INTEGER NOT NULL DEFAULT 0,
  "sell_times" INTEGER NOT NULL DEFAULT 0,
  "sell_volume" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_settlement_record" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "settle_date" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("order_sn")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_sub" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL DEFAULT '',
  "phone" TEXT NOT NULL DEFAULT '',
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_subsidy" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_type" INTEGER NOT NULL DEFAULT 1,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "type" INTEGER NOT NULL DEFAULT 0,
  "money" REAL NOT NULL DEFAULT 0.00,
  "subsidy_ratio" REAL NOT NULL DEFAULT 0.000,
  "invoice_value" REAL NOT NULL DEFAULT 0.00,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "file_url" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "account_change_id" INTEGER NOT NULL DEFAULT 0,
  "cancel_change_id" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "agree_time" TEXT DEFAULT NULL,
  "cancel_time" TEXT DEFAULT NULL,
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_tag" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "tag_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("supplier_id", "tag_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_take_ratio_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "month_sell_count" INTEGER NOT NULL DEFAULT 0,
  "take_ratio" REAL NOT NULL DEFAULT 0.000,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_temp" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "type" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "old_supplier_name" TEXT NOT NULL DEFAULT '',
  "comment_score" REAL DEFAULT NULL,
  "supplier_images" TEXT NOT NULL DEFAULT '',
  "supplier_tag" TEXT NOT NULL DEFAULT '',
  "third_shop_id" INTEGER NOT NULL DEFAULT 0,
  "operator_type" INTEGER NOT NULL DEFAULT 0,
  "item_type" INTEGER NOT NULL DEFAULT 1,
  "is_quality" INTEGER NOT NULL DEFAULT 0,
  "quality_sort" INTEGER NOT NULL DEFAULT 0,
  "take_xm_coin_ratio" REAL NOT NULL DEFAULT 0.000,
  "auto_ratio" INTEGER NOT NULL DEFAULT 1,
  "agency_ratio_flag" INTEGER NOT NULL DEFAULT 0,
  "owner_name" TEXT NOT NULL DEFAULT '',
  "owner_tel" TEXT NOT NULL DEFAULT '',
  "avatar" TEXT NOT NULL DEFAULT '',
  "province_code" TEXT NOT NULL DEFAULT '',
  "province" TEXT NOT NULL DEFAULT '',
  "city_code" TEXT NOT NULL DEFAULT '',
  "city" TEXT NOT NULL DEFAULT '',
  "county_code" TEXT NOT NULL DEFAULT '',
  "country" TEXT NOT NULL DEFAULT '',
  "address_detail" TEXT NOT NULL DEFAULT '',
  "introduction" TEXT NOT NULL DEFAULT '',
  "prove_type" INTEGER NOT NULL DEFAULT 0,
  "real_name" TEXT NOT NULL DEFAULT '',
  "card_no" TEXT NOT NULL DEFAULT '',
  "card_photo" TEXT NOT NULL DEFAULT '',
  "card_photo_back" TEXT NOT NULL DEFAULT '',
  "company_photo" TEXT NOT NULL DEFAULT '',
  "company_name" TEXT NOT NULL DEFAULT '',
  "company_code" TEXT NOT NULL DEFAULT '',
  "wx_open_id" TEXT NOT NULL DEFAULT '',
  "wx_union_id" TEXT NOT NULL DEFAULT '',
  "session_key" TEXT NOT NULL DEFAULT '',
  "login_tel" TEXT NOT NULL DEFAULT '',
  "password" TEXT NOT NULL DEFAULT '',
  "salt" TEXT NOT NULL DEFAULT '',
  "secondary_password" TEXT NOT NULL DEFAULT '',
  "secondary_salt" TEXT NOT NULL DEFAULT '',
  "credit" INTEGER NOT NULL DEFAULT 100,
  "credit_require" REAL NOT NULL DEFAULT 0.00,
  "account_money" REAL NOT NULL DEFAULT 0.00,
  "credit_money" REAL NOT NULL DEFAULT 0.00,
  "credit_standard" INTEGER NOT NULL DEFAULT 0,
  "wait_money" REAL NOT NULL DEFAULT 0.00,
  "apply_money" REAL NOT NULL DEFAULT 0.00,
  "block_money" REAL NOT NULL DEFAULT 0.00,
  "is_block" INTEGER NOT NULL DEFAULT 0,
  "block_desc" TEXT NOT NULL DEFAULT '',
  "last_block_record" TEXT,
  "withdraw_block" INTEGER NOT NULL DEFAULT 0,
  "freeze_level" INTEGER NOT NULL DEFAULT 0,
  "withdraw_remark" TEXT NOT NULL DEFAULT '',
  "is_open_rank_e" INTEGER NOT NULL DEFAULT 0,
  "after_sale_times" INTEGER NOT NULL DEFAULT 0,
  "sell_times" INTEGER NOT NULL DEFAULT 0,
  "sell_volume" INTEGER NOT NULL DEFAULT 0,
  "is_bear_station_fee" INTEGER NOT NULL DEFAULT 0,
  "station_fee" REAL NOT NULL DEFAULT 0.70,
  "help_id" INTEGER NOT NULL DEFAULT 0,
  "check_round" TEXT DEFAULT NULL,
  "check_time" TEXT DEFAULT NULL,
  "check_reason" TEXT NOT NULL DEFAULT '',
  "default_entry" INTEGER NOT NULL DEFAULT 0,
  "month_sell_count" INTEGER NOT NULL DEFAULT 0,
  "pay_off_mode" INTEGER NOT NULL DEFAULT 0,
  "partner_flag" INTEGER NOT NULL DEFAULT 0,
  "invoice_flag" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "location" TEXT NOT NULL DEFAULT '',
  "bear_num" INTEGER NOT NULL DEFAULT 0,
  "bear_price" REAL NOT NULL DEFAULT 0.00,
  "rename_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "verify_phone" TEXT NOT NULL DEFAULT '',
  "verify_card_no" INTEGER NOT NULL DEFAULT 0,
  "hand_card_url" TEXT NOT NULL DEFAULT '',
  "verify_card_url" INTEGER NOT NULL DEFAULT 0,
  "verify_card_num" REAL NOT NULL DEFAULT 0.0000000000,
  "license_status" INTEGER NOT NULL DEFAULT 0,
  "own_product_status" INTEGER NOT NULL DEFAULT 0,
  "ip" TEXT NOT NULL DEFAULT '',
  "sign_time" TEXT NOT NULL DEFAULT '',
  "expiration_time" TEXT NOT NULL DEFAULT '',
  "biz_user_id" TEXT NOT NULL DEFAULT '',
  "tl_user_id" TEXT NOT NULL DEFAULT '',
  "acctid" TEXT NOT NULL DEFAULT '',
  "avatar_audit_status" INTEGER NOT NULL DEFAULT 0,
  "avatar_audit_image_url" TEXT DEFAULT NULL,
  "avatar_audit_trace_id" TEXT DEFAULT NULL,
  UNIQUE ("login_tel", "item_type")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_supplier_withdrawal" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "record_code" TEXT NOT NULL DEFAULT '',
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "account_id" INTEGER NOT NULL DEFAULT 0,
  "purpose" INTEGER NOT NULL DEFAULT 1,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "distribute_id" INTEGER NOT NULL DEFAULT 0,
  "biz_type" INTEGER NOT NULL DEFAULT 0,
  "apply_money" REAL NOT NULL DEFAULT 0.00,
  "service_fee" REAL NOT NULL DEFAULT 0.00,
  "apply_status" INTEGER NOT NULL DEFAULT 0,
  "withdraw_status" INTEGER NOT NULL DEFAULT 0,
  "withdraw_type" INTEGER NOT NULL DEFAULT 0,
  "channel_code" TEXT NOT NULL DEFAULT '',
  "out_biz_no" TEXT NOT NULL DEFAULT '',
  "is_unusual" INTEGER NOT NULL DEFAULT 0,
  "pic_url" TEXT,
  "wx_payment_no" TEXT NOT NULL DEFAULT '',
  "payment_time" TEXT DEFAULT NULL,
  "customer_id" INTEGER NOT NULL DEFAULT 0,
  "customer_name" TEXT NOT NULL DEFAULT '0',
  "reject_reason" TEXT NOT NULL DEFAULT '',
  "device_type" INTEGER NOT NULL DEFAULT 0,
  "ip" TEXT NOT NULL DEFAULT '',
  "apply_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "promote_fee_flag" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("record_code")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_tag" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "first_id" INTEGER NOT NULL DEFAULT 0,
  "parent_id" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "is_multi" INTEGER NOT NULL DEFAULT 0,
  "need_flag" INTEGER NOT NULL DEFAULT 0,
  "image_url" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "can_modify" INTEGER NOT NULL DEFAULT 1,
  "sequence" INTEGER NOT NULL DEFAULT 0,
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "status" INTEGER NOT NULL DEFAULT 1,
  "tag_type" INTEGER NOT NULL DEFAULT 0,
  "max_count" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_tag_product" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "tag_id" INTEGER NOT NULL DEFAULT 0,
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "template_product_id" INTEGER NOT NULL DEFAULT 0,
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_tag_second_rank" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "rank_num" INTEGER NOT NULL DEFAULT 0,
  "tag_id" INTEGER NOT NULL DEFAULT 0,
  "type" INTEGER NOT NULL DEFAULT 1,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT DEFAULT NULL,
  "operator_id" INTEGER DEFAULT NULL,
  "operator_name" TEXT DEFAULT NULL,
  UNIQUE ("second_id", "rank_num", "tag_id", "type")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_tally_income_record" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "code_content" TEXT NOT NULL DEFAULT '',
  "date" TEXT NOT NULL DEFAULT '',
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "user_name" TEXT DEFAULT NULL,
  "price" REAL NOT NULL DEFAULT 0.05,
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("code_content")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_team" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "type" INTEGER NOT NULL DEFAULT 1,
  "name" TEXT NOT NULL DEFAULT '',
  "role_id" INTEGER NOT NULL DEFAULT 0,
  "perm_config" TEXT,
  "package_deadline_config" TEXT,
  "people_num" INTEGER NOT NULL DEFAULT 0,
  "leader_id" INTEGER NOT NULL DEFAULT 0,
  "leader_name" TEXT NOT NULL DEFAULT '',
  "charge_base" TEXT NOT NULL DEFAULT '[]',
  "remark" TEXT NOT NULL DEFAULT '',
  "active_flag" INTEGER NOT NULL DEFAULT 1,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_team_user" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "user_name" TEXT NOT NULL DEFAULT '',
  "is_sub" INTEGER NOT NULL DEFAULT 0,
  "team_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("team_id", "user_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_team_user_snapshot" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "round_no" TEXT NOT NULL DEFAULT '',
  "team_id" INTEGER NOT NULL DEFAULT 0,
  "team_type" INTEGER NOT NULL DEFAULT 0,
  "team_name" TEXT NOT NULL DEFAULT '',
  "team_role_id" INTEGER NOT NULL DEFAULT 0,
  "team_perm_config" TEXT,
  "team_charge_base" TEXT NOT NULL DEFAULT '[]',
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "user_name" TEXT NOT NULL DEFAULT '',
  "is_sub" INTEGER NOT NULL DEFAULT 1,
  "leader_flag" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("round_no", "team_id", "user_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_telemarket" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "phone" TEXT NOT NULL DEFAULT '',
  "type" INTEGER NOT NULL DEFAULT 0,
  "last_type" INTEGER NOT NULL DEFAULT 0,
  "status" INTEGER NOT NULL DEFAULT 0,
  "call_status" INTEGER NOT NULL DEFAULT 0,
  "call_time" INTEGER NOT NULL DEFAULT 0,
  "source" INTEGER NOT NULL DEFAULT 0,
  "customer_service" INTEGER NOT NULL DEFAULT 0,
  "allocation_time" INTEGER NOT NULL DEFAULT 0,
  "register_time" INTEGER NOT NULL DEFAULT 0,
  "buy_time" INTEGER NOT NULL DEFAULT 0,
  "remark" TEXT NOT NULL DEFAULT '',
  "invalid_time" INTEGER NOT NULL DEFAULT 0,
  "create_time" INTEGER NOT NULL DEFAULT 0,
  "update_time" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("phone")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_telemarket_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "phone" TEXT NOT NULL DEFAULT '',
  "user" INTEGER NOT NULL DEFAULT 0,
  "user_name" TEXT NOT NULL DEFAULT '',
  "operate_type" INTEGER NOT NULL DEFAULT 0,
  "old_content" TEXT NOT NULL DEFAULT '',
  "new_content" TEXT NOT NULL DEFAULT '',
  "create_time" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_template" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "template_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_third_purchaser" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "third_user_id" INTEGER NOT NULL DEFAULT 0,
  "type" INTEGER NOT NULL DEFAULT 1,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("third_user_id", "type")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_third_shelf" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "round_no" TEXT NOT NULL DEFAULT '',
  "order_sn" TEXT NOT NULL DEFAULT '',
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "third_shelf" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("order_sn")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_trade_period" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "type" INTEGER NOT NULL DEFAULT 0,
  "open_time" TEXT NOT NULL DEFAULT '02:00:00',
  "close_time" TEXT NOT NULL DEFAULT '20:00:00',
  "refund_time" TEXT NOT NULL DEFAULT '18:00:00',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_transfer_record" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "purchaser_id" INTEGER NOT NULL DEFAULT 0,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "refund_id" INTEGER NOT NULL DEFAULT 0,
  "amount" REAL NOT NULL DEFAULT 0.00,
  "status" INTEGER NOT NULL DEFAULT 0,
  "transfer_no" TEXT NOT NULL DEFAULT '',
  "file_url" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_user_tag" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "type" INTEGER NOT NULL DEFAULT 1,
  "tag_category" TEXT NOT NULL DEFAULT '',
  "name" TEXT NOT NULL DEFAULT ''
);
CREATE TABLE IF NOT EXISTS "xm_bulky_virtual_account" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "type" INTEGER NOT NULL DEFAULT 0,
  "can_pay" INTEGER NOT NULL DEFAULT 1,
  "name" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "account_money" REAL NOT NULL DEFAULT 0.00,
  "freeze_money" REAL NOT NULL DEFAULT 0.00,
  "is_enable" INTEGER NOT NULL DEFAULT 0,
  "version" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_virtual_apply" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "record_code" TEXT NOT NULL DEFAULT '',
  "virtual_account_id" INTEGER NOT NULL DEFAULT 0,
  "money_account_id" INTEGER NOT NULL DEFAULT 0,
  "spend_type" INTEGER NOT NULL DEFAULT 0,
  "apply_money" REAL NOT NULL DEFAULT 0,
  "apply_user_id" INTEGER NOT NULL DEFAULT 0,
  "apply_user_name" TEXT NOT NULL DEFAULT '',
  "apply_remark" TEXT NOT NULL DEFAULT '',
  "agree_user_id" INTEGER NOT NULL DEFAULT 0,
  "agree_user_name" TEXT NOT NULL DEFAULT '',
  "agree_time" TEXT DEFAULT NULL,
  "apply_status" INTEGER NOT NULL DEFAULT 0,
  "remark" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("record_code")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_virtual_apply_file" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "virtual_apply_id" INTEGER NOT NULL DEFAULT 0,
  "file_url" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_virtual_apply_item" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "virtual_apply_id" INTEGER NOT NULL DEFAULT 0,
  "first_id" INTEGER NOT NULL DEFAULT 0,
  "first_name" TEXT NOT NULL DEFAULT '',
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "second_name" TEXT NOT NULL DEFAULT '',
  "pic_url" TEXT NOT NULL DEFAULT '',
  "rank_num" INTEGER NOT NULL DEFAULT 0,
  "spec_and_num" TEXT NOT NULL DEFAULT '',
  "unit_price" REAL NOT NULL DEFAULT 0,
  "item_num" INTEGER NOT NULL DEFAULT 0,
  "total_price" REAL NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_virtual_bill" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "virtual_account_id" INTEGER NOT NULL DEFAULT 0,
  "virtual_account_name" TEXT NOT NULL DEFAULT '',
  "virtual_apply_id" INTEGER NOT NULL DEFAULT 0,
  "spend_type" INTEGER NOT NULL DEFAULT 0,
  "business_type" INTEGER NOT NULL DEFAULT 0,
  "old_money" REAL NOT NULL DEFAULT 0,
  "money" REAL NOT NULL DEFAULT 0,
  "new_money" REAL NOT NULL DEFAULT 0,
  "remark" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT ''
);
CREATE TABLE IF NOT EXISTS "xm_bulky_virtual_money_account" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "virtual_account_id" INTEGER NOT NULL DEFAULT 0,
  "account_type" INTEGER NOT NULL DEFAULT 0,
  "payee_type" INTEGER NOT NULL DEFAULT 1,
  "account_no" TEXT NOT NULL DEFAULT '',
  "owner_name" TEXT NOT NULL DEFAULT '',
  "ali_pay_url" TEXT NOT NULL DEFAULT '',
  "bank_no" TEXT NOT NULL DEFAULT '',
  "bank_name" TEXT NOT NULL DEFAULT '',
  "account_bank_name" TEXT NOT NULL DEFAULT '',
  "account_bank_address" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_virtual_operation_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "virtual_apply_id" INTEGER NOT NULL DEFAULT 0,
  "content" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT ''
);
CREATE TABLE IF NOT EXISTS "xm_bulky_ware_pre_income" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "date" TEXT NOT NULL DEFAULT '',
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "ware_name" TEXT NOT NULL DEFAULT '',
  "total_weight" REAL NOT NULL DEFAULT 0.00,
  "total_item_num" INTEGER NOT NULL DEFAULT 1,
  "package_pre_income" REAL NOT NULL DEFAULT 0.00,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("date", "ware_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_warm_config" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "type" INTEGER NOT NULL DEFAULT 1,
  "min_temper" INTEGER NOT NULL DEFAULT 0,
  "max_temper" INTEGER NOT NULL DEFAULT 0,
  "warm_num" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_wecom_kf_binding" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "corp_id" TEXT NOT NULL DEFAULT '',
  "agent_id" INTEGER NOT NULL DEFAULT 1000011,
  "channel" TEXT NOT NULL DEFAULT 'bulky',
  "scene" TEXT DEFAULT NULL,
  "scene_param" TEXT DEFAULT NULL,
  "external_user_id" TEXT NOT NULL DEFAULT '',
  "user_type" TEXT NOT NULL DEFAULT '',
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "last_enter_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("corp_id", "agent_id", "external_user_id")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_withdraw_biz" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL DEFAULT '',
  "pay_com_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_withdraw_distribute" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL DEFAULT '',
  "money" REAL NOT NULL DEFAULT 0,
  "withdraw_num" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT ''
);
CREATE TABLE IF NOT EXISTS "xm_bulky_wms_area" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "code" TEXT NOT NULL DEFAULT '',
  "area_name" TEXT NOT NULL DEFAULT '',
  "start_shelf" INTEGER NOT NULL DEFAULT 0,
  "end_shelf" INTEGER NOT NULL DEFAULT 0,
  "ware_type" INTEGER NOT NULL DEFAULT 0,
  "sort_config" INTEGER NOT NULL DEFAULT 0,
  "sub_area" TEXT NOT NULL DEFAULT '',
  "segment_area" TEXT,
  "pack_income_config" TEXT NOT NULL DEFAULT '',
  "delivery_income" REAL NOT NULL DEFAULT 0.00,
  "standby" INTEGER NOT NULL DEFAULT 0,
  "sequence" INTEGER NOT NULL DEFAULT 1,
  "remark" TEXT NOT NULL DEFAULT '',
  "area_manager_id" INTEGER NOT NULL DEFAULT 0,
  "area_manager_name" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "status" INTEGER NOT NULL DEFAULT 1,
  UNIQUE ("code")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_wms_area_snapshot" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "round_no" TEXT NOT NULL DEFAULT '',
  "area_id" INTEGER NOT NULL DEFAULT 0,
  "code" TEXT NOT NULL DEFAULT '',
  "area_name" TEXT NOT NULL DEFAULT '',
  "start_shelf" INTEGER NOT NULL DEFAULT 0,
  "end_shelf" INTEGER NOT NULL DEFAULT 0,
  "ware_type" INTEGER NOT NULL DEFAULT 0,
  "sort_config" INTEGER NOT NULL DEFAULT 0,
  "sub_area" TEXT NOT NULL DEFAULT '',
  "segment_area" TEXT,
  "pack_income_config" TEXT NOT NULL DEFAULT '',
  "delivery_income" REAL NOT NULL DEFAULT 0.00,
  "standby" INTEGER NOT NULL DEFAULT 0,
  "sequence" INTEGER NOT NULL DEFAULT 1,
  "remark" TEXT NOT NULL DEFAULT '',
  "area_manager_id" INTEGER NOT NULL DEFAULT 0,
  "area_manager_name" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 1,
  "snapshot_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("round_no", "area_id"),
  UNIQUE ("round_no", "code")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_wms_express_package" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "type" INTEGER NOT NULL DEFAULT 0,
  "round_no" TEXT NOT NULL DEFAULT '',
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "partner_id" INTEGER NOT NULL DEFAULT 0,
  "province" TEXT NOT NULL DEFAULT '',
  "city" TEXT NOT NULL DEFAULT '',
  "send_no" TEXT NOT NULL DEFAULT '',
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "sub_shelf_sn" TEXT NOT NULL DEFAULT '',
  "self_take_type" INTEGER NOT NULL DEFAULT 0,
  "zone" TEXT DEFAULT '',
  "shelf" TEXT DEFAULT '',
  "zone_shelf" TEXT DEFAULT '',
  "min_shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "max_shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "serial_num" INTEGER NOT NULL DEFAULT 0,
  "package_num" INTEGER NOT NULL DEFAULT 0,
  "total_weight" REAL NOT NULL DEFAULT 0.000,
  "item_num" INTEGER NOT NULL DEFAULT 0,
  "express_id" INTEGER NOT NULL DEFAULT 0,
  "region_id" INTEGER NOT NULL DEFAULT 0,
  "origin_express_id" INTEGER NOT NULL DEFAULT 0,
  "origin_region_id" INTEGER NOT NULL DEFAULT 0,
  "express_type" INTEGER NOT NULL DEFAULT 0,
  "express_status" INTEGER NOT NULL DEFAULT 0,
  "pickup_flag" INTEGER NOT NULL DEFAULT 0,
  "pickup_time" TEXT DEFAULT NULL,
  "pickup_operator_id" INTEGER DEFAULT 0,
  "pickup_operator_name" TEXT NOT NULL DEFAULT '',
  "pickup_abnormal" INTEGER NOT NULL DEFAULT 1,
  "abnormal_reason" TEXT DEFAULT NULL,
  "report_price" REAL DEFAULT NULL,
  "waybill_price_id" INTEGER DEFAULT NULL,
  "reconcile_sub_bill_id" INTEGER NOT NULL DEFAULT 0,
  "reject_reason" TEXT DEFAULT NULL,
  "out_type" INTEGER NOT NULL DEFAULT 0,
  "express_actual_weight" REAL NOT NULL DEFAULT 0.00,
  "express_actual_price" REAL NOT NULL DEFAULT 0.00,
  "express_user_id" INTEGER NOT NULL DEFAULT 0,
  "express_user_name" TEXT NOT NULL DEFAULT '',
  "package_user_id" INTEGER NOT NULL DEFAULT 0,
  "package_user_name" TEXT NOT NULL DEFAULT '',
  "url" TEXT NOT NULL DEFAULT '',
  "ship_url" TEXT NOT NULL DEFAULT '',
  "package_time" TEXT DEFAULT NULL,
  "express_modifier_id" INTEGER NOT NULL DEFAULT 0,
  "express_modifier_name" TEXT NOT NULL DEFAULT '',
  "express_modify_time" TEXT DEFAULT NULL,
  "express_time" TEXT DEFAULT NULL,
  "package_id" INTEGER NOT NULL DEFAULT 0,
  "package_info" TEXT NOT NULL DEFAULT '',
  "suggest_pack_id" INTEGER NOT NULL DEFAULT 0,
  "suggest_pack_info" TEXT NOT NULL DEFAULT '',
  "valid_status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_bulky_wms_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "ware_id" INTEGER NOT NULL DEFAULT 0,
  "round_no" TEXT NOT NULL DEFAULT '',
  "shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "sub_shelf_sn" TEXT NOT NULL DEFAULT '',
  "zone" TEXT DEFAULT '',
  "shelf" TEXT DEFAULT '',
  "zone_shelf" TEXT DEFAULT '',
  "enter_item_id" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "phone" TEXT NOT NULL DEFAULT '',
  "role_name" TEXT NOT NULL DEFAULT '',
  "content" TEXT NOT NULL DEFAULT '',
  "op_num" INTEGER NOT NULL DEFAULT 0,
  "delivery_income" REAL NOT NULL DEFAULT 0.00,
  "lower_rank_level" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "pictures" TEXT NOT NULL DEFAULT '',
  "video" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_wms_pre_income" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "date" TEXT NOT NULL DEFAULT '',
  "zone" TEXT NOT NULL DEFAULT '',
  "min_shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "max_shelf_sn" INTEGER NOT NULL DEFAULT 0,
  "shelf_num" INTEGER NOT NULL DEFAULT 0,
  "total_weight" REAL NOT NULL DEFAULT 0.00,
  "total_item_num" INTEGER NOT NULL DEFAULT 1,
  "prepare_pre_income" REAL NOT NULL DEFAULT 0.00,
  "package_pre_income" REAL NOT NULL DEFAULT 0.00,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("date", "zone")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_wms_prepare_op" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "enter_item_id" INTEGER NOT NULL DEFAULT 0,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "date" TEXT NOT NULL DEFAULT '',
  "num" INTEGER NOT NULL DEFAULT 0,
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_bulky_xmpay_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "xm_account" TEXT NOT NULL DEFAULT '',
  "order_sn" TEXT NOT NULL DEFAULT '',
  "money" REAL NOT NULL DEFAULT 0,
  "business_type" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT ''
);
CREATE TABLE IF NOT EXISTS "xm_bulky_yhsd_fee_refund_retry" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "order_id" INTEGER NOT NULL DEFAULT 0,
  "order_sn" TEXT NOT NULL DEFAULT '',
  "send_no" TEXT NOT NULL DEFAULT '',
  "round_no" TEXT NOT NULL DEFAULT '',
  "amount" REAL NOT NULL DEFAULT 0,
  "status" INTEGER NOT NULL DEFAULT 0,
  "retry_count" INTEGER NOT NULL DEFAULT 0,
  "next_retry_time" TEXT NOT NULL DEFAULT '',
  "lock_until" TEXT DEFAULT NULL,
  "last_error" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("order_sn")
);
CREATE TABLE IF NOT EXISTS "xm_bulky_zq_product" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "zq_product_id" INTEGER NOT NULL DEFAULT 0,
  "zq_second_id" INTEGER NOT NULL DEFAULT 0,
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_chat_account" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL DEFAULT '',
  "avatar" TEXT NOT NULL DEFAULT '',
  "auto_reply" TEXT NOT NULL DEFAULT '',
  "online_status" INTEGER NOT NULL DEFAULT 1,
  "status" INTEGER NOT NULL DEFAULT 1,
  "create_time" INTEGER NOT NULL DEFAULT 0,
  "update_time" INTEGER NOT NULL DEFAULT 0,
  "last_active_time" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_chat_account_user" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "chat_account_id" INTEGER NOT NULL DEFAULT 0,
  "type" INTEGER NOT NULL DEFAULT 1,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "role" INTEGER NOT NULL DEFAULT 0,
  "status" INTEGER NOT NULL DEFAULT 1,
  "update_time" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("type", "user_id")
);
CREATE TABLE IF NOT EXISTS "xm_chat_conversation" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_chat_message" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "conv_id" INTEGER NOT NULL DEFAULT 0,
  "msg_id" TEXT NOT NULL DEFAULT '',
  "sender_id" INTEGER NOT NULL DEFAULT 0,
  "msg_type" INTEGER NOT NULL DEFAULT 0,
  "content" TEXT NOT NULL DEFAULT '',
  "is_auto_reply" INTEGER NOT NULL DEFAULT 0,
  "status" INTEGER NOT NULL DEFAULT 1,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("msg_id")
);
CREATE TABLE IF NOT EXISTS "xm_chat_quick_reply" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "msg_type" INTEGER NOT NULL DEFAULT 0,
  "content" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 1,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_chat_user_conversation" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "chat_id" INTEGER NOT NULL DEFAULT 0,
  "conv_id" INTEGER NOT NULL DEFAULT 0,
  "type" INTEGER NOT NULL DEFAULT 1,
  "latest_read_msgid" INTEGER NOT NULL DEFAULT 0,
  "latest_msgid" INTEGER NOT NULL DEFAULT 0,
  "unread" INTEGER NOT NULL DEFAULT 0,
  "status" INTEGER NOT NULL DEFAULT 1,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("user_id", "chat_id", "type"),
  UNIQUE ("conv_id", "user_id")
);
CREATE TABLE IF NOT EXISTS "xm_ckgl_operate_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "role_name" TEXT NOT NULL DEFAULT '',
  "num" INTEGER NOT NULL DEFAULT 0,
  "lower_level_num" INTEGER NOT NULL DEFAULT 0,
  "refund_num" INTEGER NOT NULL DEFAULT 0,
  "is_confirm" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_group_tag" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "group_tag" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "enable_status" INTEGER NOT NULL DEFAULT 1,
  "remark" TEXT DEFAULT NULL,
  "group_type" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_help_operate_record" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "biz_type" INTEGER NOT NULL DEFAULT 0,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "user_type" INTEGER NOT NULL DEFAULT 0,
  "operate_type" INTEGER NOT NULL DEFAULT 0,
  "old_help_id" INTEGER NOT NULL DEFAULT 0,
  "new_help_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_inspection_reason_config" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "parent_id" INTEGER NOT NULL DEFAULT 0,
  "reason_name" TEXT NOT NULL DEFAULT '',
  "level" INTEGER NOT NULL DEFAULT 1,
  "sequence" INTEGER NOT NULL DEFAULT 0,
  "create_user_id" INTEGER NOT NULL DEFAULT 0,
  "create_user_name" TEXT NOT NULL DEFAULT '',
  "update_user_id" INTEGER NOT NULL DEFAULT 0,
  "update_user_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_inspection_reason_record" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "date" TEXT NOT NULL DEFAULT '',
  "enter_item_id" INTEGER NOT NULL DEFAULT 0,
  "order_item_id" INTEGER NOT NULL DEFAULT 0,
  "code_content" TEXT NOT NULL DEFAULT '',
  "op" INTEGER NOT NULL DEFAULT 0,
  "reason_id" INTEGER NOT NULL DEFAULT 0,
  "reason_name" TEXT NOT NULL DEFAULT '',
  "parent_reason_id" INTEGER NOT NULL DEFAULT 0,
  "parent_reason_name" TEXT NOT NULL DEFAULT '',
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "user_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_inspection_recommend" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "product_id" INTEGER NOT NULL DEFAULT 0,
  "enter_item_id" INTEGER NOT NULL DEFAULT 0,
  "round_no" TEXT NOT NULL DEFAULT '',
  "item_name" TEXT NOT NULL DEFAULT '',
  "rank_num" INTEGER NOT NULL DEFAULT 0,
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "supplier_name" TEXT NOT NULL DEFAULT '',
  "supplier_tag" TEXT NOT NULL DEFAULT '',
  "defect" TEXT NOT NULL DEFAULT '',
  "recommend_num" INTEGER NOT NULL DEFAULT 0,
  "total_recommend_num" INTEGER NOT NULL DEFAULT 0,
  "reason" TEXT NOT NULL DEFAULT '',
  "url" TEXT,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "operation_id" INTEGER NOT NULL DEFAULT 0,
  "operation_name" TEXT NOT NULL DEFAULT '',
  "review_operation_id" INTEGER NOT NULL DEFAULT 0,
  "review_operation_name" TEXT NOT NULL DEFAULT '',
  "review_time" TEXT DEFAULT NULL,
  "review_info" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_inspection_relation" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "sub_account_id" INTEGER NOT NULL DEFAULT 0,
  "area_code" TEXT DEFAULT '',
  "date_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_logistics_account_config" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL DEFAULT '',
  "supplier_id" INTEGER NOT NULL DEFAULT 0,
  "source" INTEGER NOT NULL DEFAULT 1,
  "logistics_type" INTEGER NOT NULL DEFAULT 0,
  "info" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_payment_user_config" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER NOT NULL DEFAULT 0,
  "nickname" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_peasant_account_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "order_id" TEXT NOT NULL DEFAULT '',
  "buy_id" INTEGER NOT NULL DEFAULT 0,
  "money" REAL NOT NULL DEFAULT 0.00,
  "business_type" INTEGER NOT NULL DEFAULT 0,
  "pay_type" INTEGER NOT NULL DEFAULT 1,
  "xm_refund_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_peasant_cart" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "buy_supplier_id" INTEGER NOT NULL DEFAULT 0,
  "sku_id" INTEGER NOT NULL DEFAULT 0,
  "temp_price" REAL NOT NULL DEFAULT 0.00,
  "sku_num" INTEGER NOT NULL DEFAULT 0,
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_peasant_class_first" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL DEFAULT '',
  "icon" TEXT NOT NULL DEFAULT '',
  "sell_status" INTEGER DEFAULT 1,
  "sort" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_peasant_class_second" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "first_id" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "icon" TEXT NOT NULL DEFAULT '',
  "sell_status" INTEGER DEFAULT 1,
  "sort" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_peasant_order" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "buy_supplier_id" INTEGER NOT NULL DEFAULT 0,
  "base_name" TEXT NOT NULL DEFAULT '',
  "peasant_supplier_id" INTEGER NOT NULL DEFAULT 0,
  "date" TEXT NOT NULL DEFAULT '',
  "order_id" TEXT NOT NULL DEFAULT '',
  "order_price" REAL NOT NULL DEFAULT 0.00,
  "total_price" REAL NOT NULL DEFAULT 0.00,
  "origin_total_price" REAL NOT NULL DEFAULT 0.00,
  "wx_price" REAL NOT NULL DEFAULT 0.00,
  "flower_price_balance" REAL NOT NULL DEFAULT 0.00,
  "pay_type" INTEGER NOT NULL DEFAULT 0,
  "take_ratio" REAL DEFAULT 0.000,
  "open_id" TEXT NOT NULL DEFAULT '',
  "mch_id" TEXT NOT NULL DEFAULT '',
  "out_trade_no" TEXT NOT NULL DEFAULT '',
  "receive_name" TEXT NOT NULL DEFAULT '',
  "receive_tel" TEXT NOT NULL DEFAULT '',
  "receive_address" TEXT NOT NULL DEFAULT '',
  "buyer_memo" TEXT NOT NULL DEFAULT '',
  "order_status" INTEGER NOT NULL DEFAULT 0,
  "after_sale_status" INTEGER NOT NULL DEFAULT 0,
  "refund_status" INTEGER NOT NULL DEFAULT 0,
  "pay_time" TEXT DEFAULT NULL,
  "ship_time" TEXT DEFAULT NULL,
  "ship_pic" TEXT NOT NULL DEFAULT '',
  "complete_time" TEXT DEFAULT NULL,
  "complete_pic" TEXT NOT NULL DEFAULT '',
  "complete_user_id" INTEGER NOT NULL DEFAULT 0,
  "complete_user_name" TEXT NOT NULL DEFAULT '',
  "wx_pay_id" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  "settle_flag" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("order_id")
);
CREATE TABLE IF NOT EXISTS "xm_peasant_order_item" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "buy_supplier_id" INTEGER NOT NULL DEFAULT 0,
  "peasant_supplier_id" INTEGER NOT NULL DEFAULT 0,
  "order_id" TEXT NOT NULL DEFAULT '',
  "goods_id" INTEGER NOT NULL DEFAULT 0,
  "sku_id" INTEGER NOT NULL DEFAULT 0,
  "img" TEXT NOT NULL DEFAULT '',
  "goods_info" TEXT NOT NULL DEFAULT '',
  "sku_info" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "take_ratio" REAL NOT NULL DEFAULT 0.000,
  "price" REAL NOT NULL DEFAULT 0.00,
  "total_price" REAL NOT NULL DEFAULT 0.00,
  "origin_total_price" REAL NOT NULL DEFAULT 0.00,
  "num" INTEGER NOT NULL DEFAULT 0,
  "origin_num" INTEGER NOT NULL DEFAULT 0,
  "order_status" INTEGER NOT NULL DEFAULT 0,
  "after_sale_status" INTEGER NOT NULL DEFAULT 0,
  "refund_status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_peasant_product" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "peasant_supplier_id" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "description" TEXT NOT NULL DEFAULT '',
  "goods_img" TEXT NOT NULL DEFAULT '',
  "images" TEXT NOT NULL DEFAULT '',
  "sort" INTEGER NOT NULL DEFAULT 0,
  "sell_count" INTEGER NOT NULL DEFAULT 0,
  "stock" INTEGER NOT NULL DEFAULT 9999,
  "min_price" REAL NOT NULL DEFAULT 0.00,
  "dn_min_price" REAL NOT NULL DEFAULT 0.00,
  "sell_status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_peasant_product_sku" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "goods_id" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "img" TEXT NOT NULL DEFAULT '',
  "price" REAL NOT NULL DEFAULT 0.00,
  "dn_price" REAL NOT NULL DEFAULT 0.00,
  "weight" INTEGER NOT NULL DEFAULT 0,
  "min_num" INTEGER NOT NULL DEFAULT 0,
  "max_num" INTEGER NOT NULL DEFAULT 9999,
  "stock" INTEGER NOT NULL DEFAULT 0,
  "sort" INTEGER NOT NULL DEFAULT 0,
  "sell_count" INTEGER NOT NULL DEFAULT 0,
  "sell_status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_peasant_refund" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "order_id" TEXT NOT NULL DEFAULT '',
  "buy_supplier_id" INTEGER NOT NULL DEFAULT 0,
  "reason" TEXT NOT NULL DEFAULT '',
  "reason_type" INTEGER NOT NULL DEFAULT 0,
  "images" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "total_price" REAL NOT NULL DEFAULT 0.00,
  "refund_price" REAL NOT NULL DEFAULT 0.00,
  "type" INTEGER NOT NULL DEFAULT 0,
  "good_state" INTEGER NOT NULL DEFAULT 0,
  "wx_refund_id" TEXT NOT NULL DEFAULT '',
  "reject_reason" TEXT NOT NULL DEFAULT '',
  "return_flag" INTEGER NOT NULL DEFAULT 0,
  "success_time" TEXT DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_peasant_refund_item" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "peasant_refund_id" INTEGER NOT NULL DEFAULT 0,
  "peasant_supplier_id" INTEGER NOT NULL DEFAULT 0,
  "order_id" TEXT NOT NULL DEFAULT '',
  "order_item_id" INTEGER NOT NULL DEFAULT 0,
  "goods_id" INTEGER NOT NULL DEFAULT 0,
  "sku_id" INTEGER NOT NULL DEFAULT 0,
  "sku_price" REAL NOT NULL DEFAULT 0.00,
  "sku_num" INTEGER NOT NULL DEFAULT 0,
  "total_price" REAL NOT NULL DEFAULT 0.00,
  "status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_peasant_sub_account_supplier_rel" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "sub_account_id" INTEGER NOT NULL DEFAULT 0,
  "peasant_supplier_id" INTEGER NOT NULL DEFAULT 0,
  "last_operator_id" INTEGER DEFAULT NULL,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("sub_account_id", "peasant_supplier_id")
);
CREATE TABLE IF NOT EXISTS "xm_peasant_supplier_refund_log" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "peasant_refund_id" INTEGER NOT NULL DEFAULT 0,
  "peasant_refund_item_id" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "content" TEXT,
  "remark" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours'))
);
CREATE TABLE IF NOT EXISTS "xm_quality_check_config" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "category_name" TEXT NOT NULL DEFAULT '',
  "description_json" TEXT,
  "sort_num" INTEGER NOT NULL DEFAULT 0,
  "operation_id" INTEGER DEFAULT 0,
  "operation_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "xm_sale_agency_statistics" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "round_no" TEXT NOT NULL DEFAULT '',
  "sale_num" INTEGER NOT NULL DEFAULT 0,
  "amount" REAL NOT NULL DEFAULT 0.00,
  "sale_daytime_num" INTEGER NOT NULL DEFAULT 0,
  "daytime_amount" REAL NOT NULL DEFAULT 0.00,
  "sale_night_num" INTEGER NOT NULL DEFAULT 0,
  "night_amount" REAL NOT NULL DEFAULT 0.00,
  "sale_operator_num" INTEGER NOT NULL DEFAULT 0,
  "operator_amount" REAL NOT NULL DEFAULT 0.00,
  "sale_external_num" INTEGER NOT NULL DEFAULT 0,
  "external_amount" REAL NOT NULL DEFAULT 0.00,
  "receive_num" INTEGER NOT NULL DEFAULT 0,
  "receive_amount" REAL NOT NULL DEFAULT 0.00,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("round_no")
);
CREATE TABLE IF NOT EXISTS "xm_zcpf_supplier" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "type" INTEGER NOT NULL DEFAULT 0,
  "nickname" TEXT NOT NULL DEFAULT '',
  "avatar" TEXT NOT NULL DEFAULT '',
  "phone" TEXT NOT NULL DEFAULT '',
  "address" TEXT NOT NULL DEFAULT '',
  "introduction" TEXT NOT NULL DEFAULT '',
  "prove_type" INTEGER NOT NULL DEFAULT 0,
  "real_name" TEXT NOT NULL DEFAULT '',
  "card_no" TEXT NOT NULL DEFAULT '',
  "card_photo" TEXT NOT NULL DEFAULT '',
  "card_photo_back" TEXT NOT NULL DEFAULT '',
  "company_photo" TEXT NOT NULL DEFAULT '',
  "company_name" TEXT NOT NULL DEFAULT '',
  "company_code" TEXT NOT NULL DEFAULT '',
  "password" TEXT NOT NULL DEFAULT '',
  "salt" TEXT NOT NULL DEFAULT '',
  "account_money" REAL NOT NULL DEFAULT 0.00,
  "credit_money" REAL NOT NULL DEFAULT 0.00,
  "wait_money" REAL NOT NULL DEFAULT 0.00,
  "apply_money" REAL NOT NULL DEFAULT 0.00,
  "block_money" REAL NOT NULL DEFAULT 0.00,
  "last_operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT '',
  "update_time" TEXT NOT NULL DEFAULT '',
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "zq_category" (
  "id" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY ("id")
);
CREATE TABLE IF NOT EXISTS "zq_good" (
  "id" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "price" REAL NOT NULL DEFAULT 0.00,
  "stock" INTEGER NOT NULL DEFAULT 0,
  "weight" REAL NOT NULL DEFAULT 0.00,
  "thumb" TEXT NOT NULL DEFAULT '',
  "color_name" TEXT NOT NULL DEFAULT '',
  "level_id" INTEGER NOT NULL DEFAULT 0,
  "level_name" TEXT NOT NULL DEFAULT '',
  "spec_unit" TEXT NOT NULL DEFAULT '',
  "zq_shop_id" INTEGER NOT NULL DEFAULT 0,
  "zq_shop_name" TEXT NOT NULL DEFAULT '',
  "zq_status" INTEGER NOT NULL DEFAULT 0,
  "zq_pid" INTEGER NOT NULL DEFAULT 0,
  "zq_cate_id" INTEGER NOT NULL DEFAULT 0,
  "zq_cate_name" TEXT NOT NULL DEFAULT '',
  "attr_address" TEXT NOT NULL DEFAULT '',
  "attr_length" TEXT NOT NULL DEFAULT '',
  "attr_flaw" TEXT NOT NULL DEFAULT '',
  "attr_advantage" TEXT NOT NULL DEFAULT '',
  "attr_maturity" TEXT NOT NULL DEFAULT '',
  "is_self_operate" INTEGER NOT NULL DEFAULT 0,
  "shop_tag" TEXT NOT NULL DEFAULT '',
  "sync_flag" INTEGER NOT NULL DEFAULT 1,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY ("id")
);
CREATE TABLE IF NOT EXISTS "zq_good_basic" (
  "id" INTEGER NOT NULL DEFAULT 0,
  "name" TEXT NOT NULL DEFAULT '',
  "thumb" TEXT NOT NULL DEFAULT '',
  "category_id" INTEGER NOT NULL DEFAULT 0,
  "category_name" TEXT NOT NULL DEFAULT '',
  "second_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY ("id")
);
CREATE TABLE IF NOT EXISTS "zq_order" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "order_id" TEXT NOT NULL DEFAULT '',
  "user_id" TEXT NOT NULL DEFAULT '',
  "remark" TEXT NOT NULL DEFAULT '',
  "is_must_successful" INTEGER NOT NULL DEFAULT 0,
  "user_name" TEXT NOT NULL DEFAULT '',
  "mobile" TEXT NOT NULL DEFAULT '',
  "province" TEXT NOT NULL DEFAULT '',
  "city" TEXT NOT NULL DEFAULT '',
  "area" TEXT NOT NULL DEFAULT '',
  "address" TEXT NOT NULL DEFAULT '',
  "message" TEXT NOT NULL DEFAULT '',
  "logistics_name" TEXT NOT NULL DEFAULT '',
  "position_number" TEXT NOT NULL DEFAULT '',
  "order_status" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("order_id")
);
CREATE TABLE IF NOT EXISTS "zq_order_item" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "order_id" TEXT NOT NULL DEFAULT '',
  "name" TEXT NOT NULL DEFAULT '',
  "origin_item_num" INTEGER NOT NULL DEFAULT 0,
  "item_num" INTEGER NOT NULL DEFAULT 0,
  "price" REAL NOT NULL DEFAULT 0.00,
  "total_price" REAL NOT NULL DEFAULT 0.00,
  "weight" REAL NOT NULL DEFAULT 0.00,
  "total_weight" REAL NOT NULL DEFAULT 0.00,
  "thumb" TEXT NOT NULL DEFAULT '[]',
  "level_name" TEXT NOT NULL DEFAULT '',
  "spec_unit" TEXT NOT NULL DEFAULT '',
  "zq_shop_id" INTEGER NOT NULL DEFAULT 0,
  "zq_shop_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "zq_shop" (
  "id" INTEGER NOT NULL DEFAULT 0,
  "shop_name" TEXT NOT NULL DEFAULT '',
  "shop_mobile" TEXT NOT NULL DEFAULT '',
  "area_id" INTEGER NOT NULL DEFAULT 0,
  "area_name" TEXT NOT NULL DEFAULT '',
  "address" TEXT NOT NULL DEFAULT '',
  "is_xm" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY ("id")
);
CREATE TABLE IF NOT EXISTS "xm_quality_punish_config" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "operation" INTEGER NOT NULL DEFAULT 0,
  "operation_name" TEXT NOT NULL DEFAULT '',
  "punish_percent" REAL NOT NULL DEFAULT 0,
  "description" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "data_status" INTEGER NOT NULL DEFAULT 0,
  UNIQUE ("operation")
);
CREATE TABLE IF NOT EXISTS "xm_quality_unit_allocation" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "enter_item_id" INTEGER NOT NULL DEFAULT 0,
  "unit_no" INTEGER NOT NULL DEFAULT 0,
  "allocated" INTEGER NOT NULL DEFAULT 0,
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "operator_name" TEXT NOT NULL DEFAULT '',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("enter_item_id", "unit_no")
);
CREATE TABLE IF NOT EXISTS "wms_permission" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "code" TEXT NOT NULL DEFAULT '',
  "name" TEXT NOT NULL DEFAULT '',
  "domain_code" TEXT NOT NULL DEFAULT '',
  "description" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 1,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("code")
);
CREATE TABLE IF NOT EXISTS "wms_permission_group" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "code" TEXT NOT NULL DEFAULT '',
  "name" TEXT NOT NULL DEFAULT '',
  "description" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 1,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("code")
);
CREATE TABLE IF NOT EXISTS "wms_permission_group_item" (
  "group_id" INTEGER NOT NULL DEFAULT 0,
  "permission_id" INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY ("group_id", "permission_id")
);
CREATE TABLE IF NOT EXISTS "wms_role" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "code" TEXT NOT NULL DEFAULT '',
  "name" TEXT NOT NULL DEFAULT '',
  "description" TEXT NOT NULL DEFAULT '',
  "status" INTEGER NOT NULL DEFAULT 1,
  "workbench_cards_json" TEXT NOT NULL DEFAULT '[]',
  "todo_ids_json" TEXT NOT NULL DEFAULT '[]',
  "scan_operations_json" TEXT NOT NULL DEFAULT '[]',
  "data_cards_json" TEXT NOT NULL DEFAULT '[]',
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("code")
);
CREATE TABLE IF NOT EXISTS "wms_role_permission_group" (
  "role_id" INTEGER NOT NULL DEFAULT 0,
  "group_id" INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY ("role_id", "group_id")
);
CREATE TABLE IF NOT EXISTS "wms_account" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "login_name" TEXT NOT NULL DEFAULT '',
  "phone" TEXT NOT NULL DEFAULT '',
  "display_name" TEXT NOT NULL DEFAULT '',
  "password_salt" TEXT NOT NULL DEFAULT '',
  "password_hash" TEXT NOT NULL DEFAULT '',
  "role_id" INTEGER NOT NULL DEFAULT 0,
  "warehouse_id" INTEGER NOT NULL DEFAULT 1,
  "warehouse_name" TEXT NOT NULL DEFAULT '梦花仓管',
  "status" INTEGER NOT NULL DEFAULT 1,
  "last_login_time" TEXT,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("login_name"),
  UNIQUE ("phone")
);
CREATE TABLE IF NOT EXISTS "wms_business_domain" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "code" TEXT NOT NULL DEFAULT '',
  "name" TEXT NOT NULL DEFAULT '',
  "description" TEXT NOT NULL DEFAULT '',
  "view_permission_code" TEXT NOT NULL DEFAULT '',
  "icon" TEXT NOT NULL DEFAULT '',
  "entry_path" TEXT NOT NULL DEFAULT '',
  "sort_order" INTEGER NOT NULL DEFAULT 0,
  "status" INTEGER NOT NULL DEFAULT 1,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  UNIQUE ("code")
);
CREATE TABLE IF NOT EXISTS "wms_account_base_permission" (
  "account_id" INTEGER NOT NULL DEFAULT 0,
  "base_tag_id" INTEGER NOT NULL DEFAULT 0,
  "sort_order" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  PRIMARY KEY ("account_id", "base_tag_id")
);
CREATE TABLE IF NOT EXISTS "wms_account_source_identity" (
  "account_id" INTEGER NOT NULL DEFAULT 0,
  "source_system" TEXT NOT NULL DEFAULT '',
  "source_user_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  PRIMARY KEY ("account_id", "source_system"),
  UNIQUE ("source_system", "source_user_id")
);
CREATE TABLE IF NOT EXISTS "wms_account_distribution_area" (
  "account_id" INTEGER NOT NULL DEFAULT 0,
  "zone_code" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  PRIMARY KEY ("account_id", "zone_code")
);
CREATE TABLE IF NOT EXISTS "wms_account_inspection_area" (
  "account_id" INTEGER NOT NULL DEFAULT 0,
  "zone_code" TEXT NOT NULL DEFAULT '',
  "operator_id" INTEGER NOT NULL DEFAULT 0,
  "create_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  "update_time" TEXT NOT NULL DEFAULT (datetime('now','+8 hours')),
  PRIMARY KEY ("account_id", "zone_code")
);
CREATE INDEX IF NOT EXISTS "audit_task_uk_api_task_id" ON "audit_task" ("api_task_id");
CREATE INDEX IF NOT EXISTS "audit_task_idx_target_status" ON "audit_task" ("target_id", "target_type", "status");
CREATE INDEX IF NOT EXISTS "b2b_coupon_record_idx_purchaser_id" ON "b2b_coupon_record" ("purchaser_id");
CREATE INDEX IF NOT EXISTS "backup_express_config_log_idx_ctime" ON "backup_express_config_log" ("create_time");
CREATE INDEX IF NOT EXISTS "backup_express_config_log_idx_cid" ON "backup_express_config_log" ("config_id");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_city_warehouse_idx_sid" ON "bak_20260901_a105_city_warehouse" ("supplier_id");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_city_warehouse_idx_appid" ON "bak_20260901_a105_city_warehouse" ("app_id");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_daily_shelf_idx_roundno" ON "bak_20260901_a105_daily_shelf" ("round_no");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_daily_shelf_idx_ordersn" ON "bak_20260901_a105_daily_shelf" ("order_sn");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_daily_shelf_idx_round_zone_shelf_sn" ON "bak_20260901_a105_daily_shelf" ("round_no", "zone", "shelf_sn");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_daily_shelf_test_idx_roundno" ON "bak_20260901_a105_daily_shelf_test" ("round_no");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_daily_shelf_test_idx_ordersn" ON "bak_20260901_a105_daily_shelf_test" ("order_sn");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_logistics_idx_name" ON "bak_20260901_a105_logistics" ("logistics_name");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_order_idx_send_no" ON "bak_20260901_a105_order" ("send_no");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_order_idx_create_time" ON "bak_20260901_a105_order" ("create_time");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_order_idx_purchaserid_wareid" ON "bak_20260901_a105_order" ("purchaser_id", "ware_id");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_order_idx_roundno_paytime_ordersn" ON "bak_20260901_a105_order" ("round_no", "wx_pay_time", "order_sn");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_order_idx_tel_ordersn_wareid" ON "bak_20260901_a105_order" ("receive_tel", "order_sn", "ware_id");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_order_idx_is_sale_agency" ON "bak_20260901_a105_order" ("is_sale_agency");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_order_idx_wxpaytime_ordersn" ON "bak_20260901_a105_order" ("wx_pay_time", "order_sn");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_order_idx_zone_shelf" ON "bak_20260901_a105_order" ("zone_shelf");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_order_idx_wareid_ptime_ostatus" ON "bak_20260901_a105_order" ("ware_id", "wx_pay_time", "order_status");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_order_idx_partnerid_ordersn" ON "bak_20260901_a105_order" ("partner_id", "order_sn");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_order_idx_helpid_roundno_status" ON "bak_20260901_a105_order" ("help_id", "round_no", "order_status");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_order_idx_codex_ml_partner_status_round" ON "bak_20260901_a105_order" ("partner_id", "order_status", "round_no", "purchaser_id", "total_item_num");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_order_idx_partner_round_status_order_sn" ON "bak_20260901_a105_order" ("partner_id", "round_no", "order_status", "order_sn");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_order_info_idx_sendno" ON "bak_20260901_a105_order_info" ("send_no");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_order_item_idx_order_sn" ON "bak_20260901_a105_order_item" ("order_sn");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_order_item_idx_supplier_id" ON "bak_20260901_a105_order_item" ("supplier_id");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_order_item_idx_create_time" ON "bak_20260901_a105_order_item" ("create_time");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_order_item_idx_roundno" ON "bak_20260901_a105_order_item" ("round_no");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_order_item_idx_sid_rno_osn" ON "bak_20260901_a105_order_item" ("supplier_id", "round_no", "order_sn");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_order_item_idx_round_product_user" ON "bak_20260901_a105_order_item" ("round_no", "product_id", "purchaser_id");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_package_idx_sendno_type" ON "bak_20260901_a105_package" ("send_no", "type");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_package_idx_round_pickup" ON "bak_20260901_a105_package" ("round_no", "pickup_flag", "express_status");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_package_idx_round_ware_pickup" ON "bak_20260901_a105_package" ("round_no", "ware_id", "pickup_flag");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_package_idx_express_round_pickup" ON "bak_20260901_a105_package" ("express_id", "round_no", "pickup_flag");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_package_idx_package_waybill_price_id" ON "bak_20260901_a105_package" ("waybill_price_id");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_package_idx_package_send_outbound_quote" ON "bak_20260901_a105_package" ("send_no", "express_status", "valid_status", "data_status", "report_price", "waybill_price_id");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_package_idx_round_send_ware_serial" ON "bak_20260901_a105_package" ("round_no", "send_no", "ware_id", "serial_num");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_package_idx_package_reconcile_sub_bill" ON "bak_20260901_a105_package" ("reconcile_sub_bill_id", "pickup_flag", "data_status");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_purchaser_idx_xm_account" ON "bak_20260901_a105_purchaser" ("xm_account");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_purchaser_idx_helpid" ON "bak_20260901_a105_purchaser" ("help_id");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_purchaser_idx_ctime" ON "bak_20260901_a105_purchaser" ("create_time");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_purchaser_idx_appid_ctime" ON "bak_20260901_a105_purchaser" ("app_id", "create_time");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_purchaser_idx_ftime" ON "bak_20260901_a105_purchaser" ("first_buy_time");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_send_order_idx_create_time" ON "bak_20260901_a105_send_order" ("create_time");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_send_order_idx_roundno_wareid_shelfsn" ON "bak_20260901_a105_send_order" ("round_no", "ware_id", "shelf_sn");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_send_order_idx_purchaserid_roundno" ON "bak_20260901_a105_send_order" ("purchaser_id", "round_no");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_send_order_idx_receivetel_roundno" ON "bak_20260901_a105_send_order" ("receive_tel", "round_no");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_send_order_idx_roundno_help_id_status" ON "bak_20260901_a105_send_order" ("round_no", "help_id", "new_buyer", "send_status");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_send_order_idx_zone_shelf" ON "bak_20260901_a105_send_order" ("zone_shelf");
CREATE INDEX IF NOT EXISTS "bak_20260901_a105_send_order_idx_reconcile_sub_bill" ON "bak_20260901_a105_send_order" ("reconcile_sub_bill_id");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_city_idx_sid" ON "bak_20260901_cd9_city" ("supplier_id");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_city_idx_appid" ON "bak_20260901_cd9_city" ("app_id");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_daily_shelf_idx_roundno" ON "bak_20260901_cd9_daily_shelf" ("round_no");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_daily_shelf_idx_ordersn" ON "bak_20260901_cd9_daily_shelf" ("order_sn");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_daily_shelf_idx_round_zone_shelf_sn" ON "bak_20260901_cd9_daily_shelf" ("round_no", "zone", "shelf_sn");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_daily_shelf_test_idx_roundno" ON "bak_20260901_cd9_daily_shelf_test" ("round_no");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_daily_shelf_test_idx_ordersn" ON "bak_20260901_cd9_daily_shelf_test" ("order_sn");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_logistics_idx_name" ON "bak_20260901_cd9_logistics" ("logistics_name");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_order_idx_send_no" ON "bak_20260901_cd9_order" ("send_no");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_order_idx_create_time" ON "bak_20260901_cd9_order" ("create_time");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_order_idx_purchaserid_wareid" ON "bak_20260901_cd9_order" ("purchaser_id", "ware_id");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_order_idx_roundno_paytime_ordersn" ON "bak_20260901_cd9_order" ("round_no", "wx_pay_time", "order_sn");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_order_idx_tel_ordersn_wareid" ON "bak_20260901_cd9_order" ("receive_tel", "order_sn", "ware_id");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_order_idx_is_sale_agency" ON "bak_20260901_cd9_order" ("is_sale_agency");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_order_idx_wxpaytime_ordersn" ON "bak_20260901_cd9_order" ("wx_pay_time", "order_sn");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_order_idx_zone_shelf" ON "bak_20260901_cd9_order" ("zone_shelf");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_order_idx_wareid_ptime_ostatus" ON "bak_20260901_cd9_order" ("ware_id", "wx_pay_time", "order_status");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_order_idx_partnerid_ordersn" ON "bak_20260901_cd9_order" ("partner_id", "order_sn");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_order_idx_helpid_roundno_status" ON "bak_20260901_cd9_order" ("help_id", "round_no", "order_status");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_order_idx_codex_ml_partner_status_round" ON "bak_20260901_cd9_order" ("partner_id", "order_status", "round_no", "purchaser_id", "total_item_num");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_order_idx_partner_round_status_order_sn" ON "bak_20260901_cd9_order" ("partner_id", "round_no", "order_status", "order_sn");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_order_info_idx_sendno" ON "bak_20260901_cd9_order_info" ("send_no");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_order_item_idx_order_sn" ON "bak_20260901_cd9_order_item" ("order_sn");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_order_item_idx_supplier_id" ON "bak_20260901_cd9_order_item" ("supplier_id");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_order_item_idx_create_time" ON "bak_20260901_cd9_order_item" ("create_time");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_order_item_idx_roundno" ON "bak_20260901_cd9_order_item" ("round_no");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_order_item_idx_sid_rno_osn" ON "bak_20260901_cd9_order_item" ("supplier_id", "round_no", "order_sn");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_order_item_idx_round_product_user" ON "bak_20260901_cd9_order_item" ("round_no", "product_id", "purchaser_id");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_package_idx_sendno_type" ON "bak_20260901_cd9_package" ("send_no", "type");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_package_idx_round_pickup" ON "bak_20260901_cd9_package" ("round_no", "pickup_flag", "express_status");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_package_idx_round_ware_pickup" ON "bak_20260901_cd9_package" ("round_no", "ware_id", "pickup_flag");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_package_idx_express_round_pickup" ON "bak_20260901_cd9_package" ("express_id", "round_no", "pickup_flag");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_package_idx_package_waybill_price_id" ON "bak_20260901_cd9_package" ("waybill_price_id");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_package_idx_package_send_outbound_quote" ON "bak_20260901_cd9_package" ("send_no", "express_status", "valid_status", "data_status", "report_price", "waybill_price_id");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_package_idx_round_send_ware_serial" ON "bak_20260901_cd9_package" ("round_no", "send_no", "ware_id", "serial_num");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_package_idx_package_reconcile_sub_bill" ON "bak_20260901_cd9_package" ("reconcile_sub_bill_id", "pickup_flag", "data_status");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_purchaser_idx_xm_account" ON "bak_20260901_cd9_purchaser" ("xm_account");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_purchaser_idx_helpid" ON "bak_20260901_cd9_purchaser" ("help_id");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_purchaser_idx_ctime" ON "bak_20260901_cd9_purchaser" ("create_time");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_purchaser_idx_appid_ctime" ON "bak_20260901_cd9_purchaser" ("app_id", "create_time");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_purchaser_idx_ftime" ON "bak_20260901_cd9_purchaser" ("first_buy_time");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_send_order_idx_create_time" ON "bak_20260901_cd9_send_order" ("create_time");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_send_order_idx_roundno_wareid_shelfsn" ON "bak_20260901_cd9_send_order" ("round_no", "ware_id", "shelf_sn");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_send_order_idx_purchaserid_roundno" ON "bak_20260901_cd9_send_order" ("purchaser_id", "round_no");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_send_order_idx_receivetel_roundno" ON "bak_20260901_cd9_send_order" ("receive_tel", "round_no");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_send_order_idx_roundno_help_id_status" ON "bak_20260901_cd9_send_order" ("round_no", "help_id", "new_buyer", "send_status");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_send_order_idx_zone_shelf" ON "bak_20260901_cd9_send_order" ("zone_shelf");
CREATE INDEX IF NOT EXISTS "bak_20260901_cd9_send_order_idx_reconcile_sub_bill" ON "bak_20260901_cd9_send_order" ("reconcile_sub_bill_id");
CREATE INDEX IF NOT EXISTS "blacklist_supplier_idx_supplier_id" ON "blacklist_supplier" ("supplier_id");
CREATE INDEX IF NOT EXISTS "blk_normal_wx_order_idx_create_time" ON "blk_normal_wx_order" ("create_time");
CREATE INDEX IF NOT EXISTS "blk_normal_wx_order_idx_wxpayid" ON "blk_normal_wx_order" ("wx_pay_id");
CREATE INDEX IF NOT EXISTS "blk_normal_wx_order_idx_ordersn" ON "blk_normal_wx_order" ("order_sn");
CREATE INDEX IF NOT EXISTS "blk_promotion_log_idx_user_id" ON "blk_promotion_log" ("user_id");
CREATE INDEX IF NOT EXISTS "blk_promotion_log_idx_pid_userid" ON "blk_promotion_log" ("pid", "user_id");
CREATE INDEX IF NOT EXISTS "blk_recommend_info_idx_tabid" ON "blk_recommend_info" ("tab_id");
CREATE INDEX IF NOT EXISTS "bulk_purchase_audit_log_idx_biz" ON "bulk_purchase_audit_log" ("biz_type", "biz_id");
CREATE INDEX IF NOT EXISTS "bulk_purchase_demand_idx_status_round" ON "bulk_purchase_demand" ("status", "round_no");
CREATE INDEX IF NOT EXISTS "bulk_purchase_demand_idx_status_collect_end" ON "bulk_purchase_demand" ("status", "collect_end_time");
CREATE INDEX IF NOT EXISTS "bulk_purchase_demand_idx_second" ON "bulk_purchase_demand" ("second_id");
CREATE INDEX IF NOT EXISTS "bulk_purchase_demand_supplier_idx_supplier" ON "bulk_purchase_demand_supplier" ("supplier_id");
CREATE INDEX IF NOT EXISTS "bulk_purchase_label_idx_order_status" ON "bulk_purchase_label" ("order_id", "status");
CREATE INDEX IF NOT EXISTS "bulk_purchase_order_idx_supplier_status" ON "bulk_purchase_order" ("supplier_id", "status");
CREATE INDEX IF NOT EXISTS "bulk_purchase_order_idx_status_output_end" ON "bulk_purchase_order" ("status", "output_end_time");
CREATE INDEX IF NOT EXISTS "bulk_purchase_order_idx_status_settle" ON "bulk_purchase_order" ("status", "plan_settle_time");
CREATE INDEX IF NOT EXISTS "bulk_purchase_order_idx_round" ON "bulk_purchase_order" ("round_no");
CREATE INDEX IF NOT EXISTS "bulk_purchase_over_compensate_idx_order" ON "bulk_purchase_over_compensate" ("order_id");
CREATE INDEX IF NOT EXISTS "bulk_purchase_over_compensate_idx_occupied" ON "bulk_purchase_over_compensate" ("occupied_supplier_id");
CREATE INDEX IF NOT EXISTS "bulk_purchase_over_compensate_idx_demand" ON "bulk_purchase_over_compensate" ("demand_id");
CREATE INDEX IF NOT EXISTS "bulk_purchase_quote_idx_demand_current" ON "bulk_purchase_quote" ("demand_id", "is_current");
CREATE INDEX IF NOT EXISTS "bulk_purchase_quote_rank_idx_demand_supplier" ON "bulk_purchase_quote_rank" ("demand_id", "supplier_id");
CREATE INDEX IF NOT EXISTS "bulk_purchase_scan_reject_log_idx_order" ON "bulk_purchase_scan_reject_log" ("order_id");
CREATE INDEX IF NOT EXISTS "bulk_purchase_scan_reject_log_idx_label" ON "bulk_purchase_scan_reject_log" ("label_code");
CREATE INDEX IF NOT EXISTS "bulk_purchase_white_list_idx_status" ON "bulk_purchase_white_list" ("status");
CREATE INDEX IF NOT EXISTS "bulky_pay_app_mch_bind_idx_lookup" ON "bulky_pay_app_mch_bind" ("app_id", "channel_code", "scene", "status", "priority");
CREATE INDEX IF NOT EXISTS "bulky_pay_biz_notify_task_idx_dispatch" ON "bulky_pay_biz_notify_task" ("status", "next_retry_at");
CREATE INDEX IF NOT EXISTS "bulky_pay_mch_idx_channel" ON "bulky_pay_mch" ("channel_code", "status");
CREATE INDEX IF NOT EXISTS "bulky_pay_order_idx_biz_order" ON "bulky_pay_order" ("biz_type", "biz_order_sn");
CREATE INDEX IF NOT EXISTS "bulky_pay_order_idx_channel_pay_id" ON "bulky_pay_order" ("channel_pay_id");
CREATE INDEX IF NOT EXISTS "bulky_pay_order_idx_status_expire" ON "bulky_pay_order" ("status", "expire_time");
CREATE INDEX IF NOT EXISTS "bulky_pay_refund_idx_out_trade_no" ON "bulky_pay_refund" ("out_trade_no");
CREATE INDEX IF NOT EXISTS "bulky_pay_route_rule_idx_lookup" ON "bulky_pay_route_rule" ("app_id", "biz_type", "status", "priority");
CREATE INDEX IF NOT EXISTS "city_order_idx_ctime" ON "city_order" ("create_time");
CREATE INDEX IF NOT EXISTS "city_order_idx_date_wareid" ON "city_order" ("date", "ware_id");
CREATE INDEX IF NOT EXISTS "city_order_idx_paytime" ON "city_order" ("pay_time");
CREATE INDEX IF NOT EXISTS "city_order_idx_pid" ON "city_order" ("purchaser_id");
CREATE INDEX IF NOT EXISTS "city_order_item_idx_ordersn" ON "city_order_item" ("order_sn");
CREATE INDEX IF NOT EXISTS "city_order_log_idx_ordersn_type" ON "city_order_log" ("order_sn", "type");
CREATE INDEX IF NOT EXISTS "city_order_refund_idx_ordersn" ON "city_order_refund" ("order_sn");
CREATE INDEX IF NOT EXISTS "city_order_refund_idx_agreetime" ON "city_order_refund" ("agree_time");
CREATE INDEX IF NOT EXISTS "city_receipt_print_idx_ware_id" ON "city_receipt_print" ("ware_id");
CREATE INDEX IF NOT EXISTS "city_warehouse_idx_sid" ON "city_warehouse" ("supplier_id");
CREATE INDEX IF NOT EXISTS "city_warehouse_idx_appid" ON "city_warehouse" ("app_id");
CREATE INDEX IF NOT EXISTS "city_warehouse_class_first_add_price_idx_wareid" ON "city_warehouse_class_first_add_price" ("ware_id");
CREATE INDEX IF NOT EXISTS "city_warehouse_class_second_add_price_idx_wareid" ON "city_warehouse_class_second_add_price" ("ware_id");
CREATE INDEX IF NOT EXISTS "city_warehouse_express_record_idx_settletime" ON "city_warehouse_express_record" ("settle_time");
CREATE INDEX IF NOT EXISTS "city_warehouse_express_record_idx_wareidtypestatus" ON "city_warehouse_express_record" ("ware_id", "type", "status");
CREATE INDEX IF NOT EXISTS "city_warehouse_fhh_logistics_fee_idx_round_settle" ON "city_warehouse_fhh_logistics_fee" ("round_no", "settle_status");
CREATE INDEX IF NOT EXISTS "city_warehouse_log_idx_wareid_ctime" ON "city_warehouse_log" ("ware_id", "create_time");
CREATE INDEX IF NOT EXISTS "city_warehouse_promote_fee_log_idx_supplier_time" ON "city_warehouse_promote_fee_log" ("supplier_id", "create_time");
CREATE INDEX IF NOT EXISTS "city_warehouse_promote_fee_log_idx_ware_time" ON "city_warehouse_promote_fee_log" ("ware_id", "create_time");
CREATE INDEX IF NOT EXISTS "city_warehouse_promote_fee_log_idx_ctime" ON "city_warehouse_promote_fee_log" ("create_time");
CREATE INDEX IF NOT EXISTS "city_warehouse_promote_settle_idx_ware_id" ON "city_warehouse_promote_settle" ("ware_id");
CREATE INDEX IF NOT EXISTS "city_warehouse_promote_settle_idx_month" ON "city_warehouse_promote_settle" ("month");
CREATE INDEX IF NOT EXISTS "city_warehouse_remark_idx_wareid" ON "city_warehouse_remark" ("ware_id");
CREATE INDEX IF NOT EXISTS "city_warehouse_shipping_area_idx_wareid" ON "city_warehouse_shipping_area" ("ware_id");
CREATE INDEX IF NOT EXISTS "city_warehouse_user_idx_wareid" ON "city_warehouse_user" ("ware_id");
CREATE INDEX IF NOT EXISTS "community_activity_idx_ctime" ON "community_activity" ("create_time");
CREATE INDEX IF NOT EXISTS "community_activity_idx_end_time_data_status" ON "community_activity" ("end_time", "data_status");
CREATE INDEX IF NOT EXISTS "community_activity_log_idx_activity_time" ON "community_activity_log" ("activity_id", "create_time");
CREATE INDEX IF NOT EXISTS "community_activity_record_idx_biz_no" ON "community_activity_record" ("biz_no");
CREATE INDEX IF NOT EXISTS "daily_shelf_idx_roundno" ON "daily_shelf" ("round_no");
CREATE INDEX IF NOT EXISTS "daily_shelf_idx_ordersn" ON "daily_shelf" ("order_sn");
CREATE INDEX IF NOT EXISTS "daily_shelf_idx_round_zone_shelf_sn" ON "daily_shelf" ("round_no", "zone", "shelf_sn");
CREATE INDEX IF NOT EXISTS "daily_shelf_test_idx_roundno" ON "daily_shelf_test" ("round_no");
CREATE INDEX IF NOT EXISTS "daily_shelf_test_idx_ordersn" ON "daily_shelf_test" ("order_sn");
CREATE INDEX IF NOT EXISTS "distributor_pickup_inventory_scan_log_idx_date_shelf_status" ON "distributor_pickup_inventory_scan_log" ("date", "shelf_sn", "data_status");
CREATE INDEX IF NOT EXISTS "distributor_pickup_inventory_scan_log_idx_enter_item" ON "distributor_pickup_inventory_scan_log" ("enter_item_id");
CREATE INDEX IF NOT EXISTS "enter_item_record_log_idx_code_content" ON "enter_item_record_log" ("code_content");
CREATE INDEX IF NOT EXISTS "enter_item_record_log_idx_date" ON "enter_item_record_log" ("date");
CREATE INDEX IF NOT EXISTS "enter_item_record_log_idx_enterItem" ON "enter_item_record_log" ("enter_item_id");
CREATE INDEX IF NOT EXISTS "fhh_member_level_history_idx_pid" ON "fhh_member_level_history" ("purchaser_id");
CREATE INDEX IF NOT EXISTS "flash_sale_apply_idx_planid_num_status" ON "flash_sale_apply" ("plan_id", "num", "status");
CREATE INDEX IF NOT EXISTS "flash_sale_permission_idx_applytime" ON "flash_sale_permission" ("apply_time");
CREATE INDEX IF NOT EXISTS "flash_sale_plan_idx_secondid" ON "flash_sale_plan" ("second_id");
CREATE INDEX IF NOT EXISTS "flash_sale_plan_idx_endtime" ON "flash_sale_plan" ("end_time");
CREATE INDEX IF NOT EXISTS "flash_sale_session_idx_roundno" ON "flash_sale_session" ("round_no");
CREATE INDEX IF NOT EXISTS "gift_user_idx_ordersn" ON "gift_user" ("order_sn");
CREATE INDEX IF NOT EXISTS "group_tag_relation_idx_groupid_tagid" ON "group_tag_relation" ("group_id", "tag_id");
CREATE INDEX IF NOT EXISTS "hub_device_idx_vehicle_id" ON "hub_device" ("vehicle_id");
CREATE INDEX IF NOT EXISTS "hub_device_bind_log_idx_device_no" ON "hub_device_bind_log" ("device_no");
CREATE INDEX IF NOT EXISTS "hub_device_bind_log_idx_to_vehicle_id" ON "hub_device_bind_log" ("to_vehicle_id");
CREATE INDEX IF NOT EXISTS "hub_dispatch_checkin_idx_dispatch_id" ON "hub_dispatch_checkin" ("dispatch_id");
CREATE INDEX IF NOT EXISTS "hub_dispatch_order_idx_vehicle_id" ON "hub_dispatch_order" ("vehicle_id");
CREATE INDEX IF NOT EXISTS "hub_dispatch_order_idx_driver_id" ON "hub_dispatch_order" ("driver_id");
CREATE INDEX IF NOT EXISTS "hub_dispatch_order_idx_round_no" ON "hub_dispatch_order" ("round_no");
CREATE INDEX IF NOT EXISTS "hub_dispatch_order_idx_plate_round" ON "hub_dispatch_order" ("plate_no", "round_no");
CREATE INDEX IF NOT EXISTS "hub_dispatch_order_idx_status_responsible" ON "hub_dispatch_order" ("status", "responsible_base_id");
CREATE INDEX IF NOT EXISTS "hub_permission_change_log_idx_role_time" ON "hub_permission_change_log" ("role_id", "create_time");
CREATE INDEX IF NOT EXISTS "hub_station_idx_area_id" ON "hub_station" ("area_id");
CREATE INDEX IF NOT EXISTS "hub_taxi_register_idx_reimburse_id" ON "hub_taxi_register" ("reimburse_id");
CREATE INDEX IF NOT EXISTS "hub_taxi_register_idx_round_no" ON "hub_taxi_register" ("round_no");
CREATE INDEX IF NOT EXISTS "hub_taxi_reimburse_idx_round_no" ON "hub_taxi_reimburse" ("round_no");
CREATE INDEX IF NOT EXISTS "hub_track_point_idx_dispatch_create" ON "hub_track_point" ("dispatch_id", "create_time");
CREATE INDEX IF NOT EXISTS "hub_vehicle_idx_plate_no" ON "hub_vehicle" ("plate_no");
CREATE INDEX IF NOT EXISTS "hubflow_dispatch_order_nodes_idx_dispatch_order" ON "hubflow_dispatch_order_nodes" ("dispatch_order_id", "sort_no");
CREATE INDEX IF NOT EXISTS "hubflow_dispatch_order_nodes_idx_order_nodes_order_sort_station" ON "hubflow_dispatch_order_nodes" ("dispatch_order_id", "sort_no", "station_id");
CREATE INDEX IF NOT EXISTS "hubflow_dispatch_orders_idx_orders_status_type_start" ON "hubflow_dispatch_orders" ("status", "type", "start_station_id", "trip_date");
CREATE INDEX IF NOT EXISTS "hubflow_dispatch_orders_idx_taxi_registration_no" ON "hubflow_dispatch_orders" ("taxi_registration_no");
CREATE INDEX IF NOT EXISTS "hubflow_drivers_idx_phone" ON "hubflow_drivers" ("phone");
CREATE INDEX IF NOT EXISTS "hubflow_external_dispatch_settlement_bills_idx_status" ON "hubflow_external_dispatch_settlement_bills" ("status");
CREATE INDEX IF NOT EXISTS "hubflow_external_vehicles_idx_driver_phone" ON "hubflow_external_vehicles" ("driver_phone");
CREATE INDEX IF NOT EXISTS "hubflow_external_vehicles_idx_status" ON "hubflow_external_vehicles" ("status");
CREATE INDEX IF NOT EXISTS "hubflow_permission_audit_logs_idx_role_time" ON "hubflow_permission_audit_logs" ("role_name", "create_time");
CREATE INDEX IF NOT EXISTS "hubflow_role_permissions_idx_permission_code" ON "hubflow_role_permissions" ("permission_code");
CREATE INDEX IF NOT EXISTS "hubflow_taxi_reimburse_bills_idx_status" ON "hubflow_taxi_reimburse_bills" ("status");
CREATE INDEX IF NOT EXISTS "hubflow_track_points_idx_track_vehicle_time" ON "hubflow_track_points" ("trip_date", "plate_no", "located_at");
CREATE INDEX IF NOT EXISTS "hubflow_track_points_idx_track_dispatch_time" ON "hubflow_track_points" ("trip_date", "dispatch_no", "located_at");
CREATE INDEX IF NOT EXISTS "hubflow_track_points_idx_track_driver_time" ON "hubflow_track_points" ("trip_date", "driver_id", "located_at");
CREATE INDEX IF NOT EXISTS "hubflow_trip_signins_idx_trip_vehicle" ON "hubflow_trip_signins" ("trip_date", "plate_no");
CREATE INDEX IF NOT EXISTS "hubflow_trip_signins_idx_trip_dispatch" ON "hubflow_trip_signins" ("trip_date", "dispatch_no");
CREATE INDEX IF NOT EXISTS "hubflow_trip_signins_idx_trip_driver" ON "hubflow_trip_signins" ("trip_date", "driver_id");
CREATE INDEX IF NOT EXISTS "hubflow_trip_signins_idx_trip_node" ON "hubflow_trip_signins" ("trip_date", "node_type");
CREATE INDEX IF NOT EXISTS "hubflow_trip_signins_idx_signins_order_node_status_time" ON "hubflow_trip_signins" ("dispatch_order_id", "node_type", "status", "sign_time");
CREATE INDEX IF NOT EXISTS "invoicing_application_idx_applytime" ON "invoicing_application" ("apply_time");
CREATE INDEX IF NOT EXISTS "legacy_purchaser_split_idx_legacy_purchaser_split_bulky_user" ON "legacy_purchaser_split" ("bulky_user_id");
CREATE INDEX IF NOT EXISTS "legacy_purchaser_split_idx_legacy_purchaser_split_hck_user" ON "legacy_purchaser_split" ("hck_user_id");
CREATE INDEX IF NOT EXISTS "legacy_purchaser_split_idx_legacy_purchaser_split_status" ON "legacy_purchaser_split" ("migration_status");
CREATE INDEX IF NOT EXISTS "logistics_actual_price_idx_send_no" ON "logistics_actual_price" ("send_no");
CREATE INDEX IF NOT EXISTS "logistics_actual_price_idx_round" ON "logistics_actual_price" ("round_no");
CREATE INDEX IF NOT EXISTS "logistics_carrier_idx_provider" ON "logistics_carrier" ("provider_id");
CREATE INDEX IF NOT EXISTS "logistics_carrier_account_bind_idx_account" ON "logistics_carrier_account_bind" ("account_type", "account_id", "data_status");
CREATE INDEX IF NOT EXISTS "logistics_carrier_account_bind_uk_account_carrier" ON "logistics_carrier_account_bind" ("account_type", "account_id", "carrier_id");
CREATE INDEX IF NOT EXISTS "logistics_carrier_config_idx_carrier" ON "logistics_carrier_config" ("carrier_id");
CREATE INDEX IF NOT EXISTS "logistics_carrier_config_idx_config" ON "logistics_carrier_config" ("config_id");
CREATE INDEX IF NOT EXISTS "logistics_carrier_region_idx_carrier" ON "logistics_carrier_region" ("carrier_id", "data_status");
CREATE INDEX IF NOT EXISTS "logistics_carrier_region_idx_region_special_line" ON "logistics_carrier_region" ("region_id", "data_status", "xm_special_line");
CREATE INDEX IF NOT EXISTS "logistics_freight_reconcile_bill_idx_bill_name" ON "logistics_freight_reconcile_bill" ("bill_name");
CREATE INDEX IF NOT EXISTS "logistics_freight_reconcile_detail_idx_sub_bill" ON "logistics_freight_reconcile_detail" ("sub_bill_id", "data_status");
CREATE INDEX IF NOT EXISTS "logistics_freight_reconcile_detail_idx_total_bill" ON "logistics_freight_reconcile_detail" ("total_bill_id", "data_status");
CREATE INDEX IF NOT EXISTS "logistics_freight_reconcile_detail_idx_package_record" ON "logistics_freight_reconcile_detail" ("package_record_id", "data_status");
CREATE INDEX IF NOT EXISTS "logistics_freight_reconcile_sub_bill_idx_total_bill" ON "logistics_freight_reconcile_sub_bill" ("total_bill_id", "data_status");
CREATE INDEX IF NOT EXISTS "logistics_freight_reconcile_sub_bill_idx_carrier" ON "logistics_freight_reconcile_sub_bill" ("carrier_id", "status", "data_status");
CREATE INDEX IF NOT EXISTS "logistics_freight_settle_operation_idx_freight_settle_send" ON "logistics_freight_settle_operation" ("send_order_id", "operation_time");
CREATE INDEX IF NOT EXISTS "logistics_message_idx_carrier" ON "logistics_message" ("carrier_id", "data_status", "id");
CREATE INDEX IF NOT EXISTS "logistics_message_idx_target" ON "logistics_message" ("target_type", "data_status", "id");
CREATE INDEX IF NOT EXISTS "logistics_message_idx_create_time" ON "logistics_message" ("create_time");
CREATE INDEX IF NOT EXISTS "logistics_message_read_idx_reader" ON "logistics_message_read" ("reader_type", "read_key");
CREATE INDEX IF NOT EXISTS "logistics_order_idx_send_no" ON "logistics_order" ("send_no");
CREATE INDEX IF NOT EXISTS "logistics_order_idx_mail_no" ON "logistics_order" ("mail_no");
CREATE INDEX IF NOT EXISTS "logistics_package_abnormal_tag_idx_tag_status" ON "logistics_package_abnormal_tag" ("status", "data_status", "sort_no");
CREATE INDEX IF NOT EXISTS "logistics_package_operation_idx_package_op" ON "logistics_package_operation" ("package_id", "op_type", "data_status");
CREATE INDEX IF NOT EXISTS "logistics_package_operation_idx_operator" ON "logistics_package_operation" ("operator_id", "op_type");
CREATE INDEX IF NOT EXISTS "logistics_package_tag_relation_idx_tag_id" ON "logistics_package_tag_relation" ("tag_id");
CREATE INDEX IF NOT EXISTS "logistics_pickup_fee_operation_idx_pickup_fee_send_order" ON "logistics_pickup_fee_operation" ("send_order_id", "operation_time");
CREATE INDEX IF NOT EXISTS "logistics_pickup_fee_operation_idx_pickup_fee_operator" ON "logistics_pickup_fee_operation" ("operator_id", "operation_time");
CREATE INDEX IF NOT EXISTS "logistics_provider_idx_access_key" ON "logistics_provider" ("access_key");
CREATE INDEX IF NOT EXISTS "logistics_provider_account_bind_idx_account" ON "logistics_provider_account_bind" ("account_type", "account_id", "data_status");
CREATE INDEX IF NOT EXISTS "logistics_provider_checkin_idx_round_status" ON "logistics_provider_checkin" ("round_no", "data_status");
CREATE INDEX IF NOT EXISTS "logistics_provider_config_idx_provider_data_status" ON "logistics_provider_config" ("provider_id", "data_status");
CREATE INDEX IF NOT EXISTS "logistics_quote_idx_carrier_status" ON "logistics_quote" ("carrier_id", "status");
CREATE INDEX IF NOT EXISTS "logistics_quote_idx_provider" ON "logistics_quote" ("provider_id");
CREATE INDEX IF NOT EXISTS "logistics_quote_idx_round" ON "logistics_quote" ("start_round_no", "end_round_no");
CREATE INDEX IF NOT EXISTS "logistics_quote_region_idx_quote" ON "logistics_quote_region" ("quote_id");
CREATE INDEX IF NOT EXISTS "logistics_quote_region_idx_carrier_region_status" ON "logistics_quote_region" ("carrier_id", "region_id", "status", "data_status");
CREATE INDEX IF NOT EXISTS "logistics_quote_region_idx_carrier_effective" ON "logistics_quote_region" ("carrier_id", "status", "enable_status", "data_status");
CREATE INDEX IF NOT EXISTS "logistics_reconcile_bill_idx_bill_name" ON "logistics_reconcile_bill" ("bill_name");
CREATE INDEX IF NOT EXISTS "logistics_reconcile_bill_item_idx_bill_id" ON "logistics_reconcile_bill_item" ("bill_id");
CREATE INDEX IF NOT EXISTS "logistics_route_idx_mail_no" ON "logistics_route" ("mail_no");
CREATE INDEX IF NOT EXISTS "logistics_session_settlement_idx_round_no" ON "logistics_session_settlement" ("round_no");
CREATE INDEX IF NOT EXISTS "logistics_session_settlement_idx_target" ON "logistics_session_settlement" ("biz_type", "target_id");
CREATE INDEX IF NOT EXISTS "logistics_settle_adjust_idx_ref_no" ON "logistics_settle_adjust" ("ref_no");
CREATE INDEX IF NOT EXISTS "logistics_settle_adjust_idx_source" ON "logistics_settle_adjust" ("source");
CREATE INDEX IF NOT EXISTS "logistics_settle_adjust_idx_carrier_status" ON "logistics_settle_adjust" ("carrier_id", "data_status");
CREATE INDEX IF NOT EXISTS "logistics_transport_package_idx_task" ON "logistics_transport_package" ("task_id");
CREATE INDEX IF NOT EXISTS "logistics_transport_task_idx_round_provider" ON "logistics_transport_task" ("round_no", "provider_id");
CREATE INDEX IF NOT EXISTS "logistics_transport_task_idx_driver_round" ON "logistics_transport_task" ("driver_id", "round_no");
CREATE INDEX IF NOT EXISTS "logistics_waybill_price_idx_waybill_batch" ON "logistics_waybill_price" ("batch_no", "row_no");
CREATE INDEX IF NOT EXISTS "logistics_waybill_price_idx_waybill_carrier_status" ON "logistics_waybill_price" ("carrier_id", "match_status", "data_status");
CREATE INDEX IF NOT EXISTS "logistics_waybill_price_idx_waybill_send_no" ON "logistics_waybill_price" ("send_no", "apply_status", "data_status");
CREATE INDEX IF NOT EXISTS "machine_prepare_log_idx_code_content" ON "machine_prepare_log" ("code_content");
CREATE INDEX IF NOT EXISTS "machine_prepare_log_idx_date_userid" ON "machine_prepare_log" ("date", "user_id");
CREATE INDEX IF NOT EXISTS "machine_prepare_log_idx_enteritemid" ON "machine_prepare_log" ("enter_item_id");
CREATE INDEX IF NOT EXISTS "machine_prepare_log_idx_supplierid_shelfsn" ON "machine_prepare_log" ("supplier_id", "shelf_sn");
CREATE INDEX IF NOT EXISTS "member_coupon_record_idx_roundno" ON "member_coupon_record" ("round_no");
CREATE INDEX IF NOT EXISTS "member_coupon_record_idx_pid_roundno" ON "member_coupon_record" ("purchaser_id", "round_no");
CREATE INDEX IF NOT EXISTS "member_exp_log_idx_ctime" ON "member_exp_log" ("create_time");
CREATE INDEX IF NOT EXISTS "member_exp_log_idx_uid_order_sn_type" ON "member_exp_log" ("purchaser_id", "order_sn", "type");
CREATE INDEX IF NOT EXISTS "member_exp_log_idx_purchaser_type_time_exp" ON "member_exp_log" ("purchaser_id", "type", "create_time", "exp");
CREATE INDEX IF NOT EXISTS "member_level_history_idx_pid_ctime" ON "member_level_history" ("purchaser_id", "create_time");
CREATE INDEX IF NOT EXISTS "member_level_history_idx_ctime" ON "member_level_history" ("create_time");
CREATE INDEX IF NOT EXISTS "member_point_bill_idx_pid_ctime" ON "member_point_bill" ("purchaser_id", "create_time");
CREATE INDEX IF NOT EXISTS "membership_idx_membership_protection_status" ON "membership" ("protection_status");
CREATE INDEX IF NOT EXISTS "membership_idx_membership_last_check_time" ON "membership" ("last_level_check_time");
CREATE INDEX IF NOT EXISTS "membership_idx_appid_level" ON "membership" ("app_id", "vip_level");
CREATE INDEX IF NOT EXISTS "membership_idx_vip_level_user_id" ON "membership" ("vip_level", "user_id");
CREATE INDEX IF NOT EXISTS "membership_idx_app_id_id" ON "membership" ("app_id", "id");
CREATE INDEX IF NOT EXISTS "merchant_apply_info_idx_merchant_type_id" ON "merchant_apply_info" ("merchant_type", "merchant_id");
CREATE INDEX IF NOT EXISTS "merchant_apply_info_idx_ware_id" ON "merchant_apply_info" ("ware_id");
CREATE INDEX IF NOT EXISTS "merchant_apply_info_idx_partner_id" ON "merchant_apply_info" ("partner_id");
CREATE INDEX IF NOT EXISTS "merchant_audit_log_idx_partner_action_time" ON "merchant_audit_log" ("partner_id", "action", "create_time");
CREATE INDEX IF NOT EXISTS "merchant_audit_log_idx_ware_action_time" ON "merchant_audit_log" ("ware_id", "action", "create_time");
CREATE INDEX IF NOT EXISTS "partner_class_first_add_price_idx_pid" ON "partner_class_first_add_price" ("partner_id");
CREATE INDEX IF NOT EXISTS "partner_class_second_add_price_idx_partnerid" ON "partner_class_second_add_price" ("partner_id");
CREATE INDEX IF NOT EXISTS "partner_class_second_add_price_log_idx_partner_second_operation_id" ON "partner_class_second_add_price_log" ("partner_id", "second_id", "operation_no", "id");
CREATE INDEX IF NOT EXISTS "partner_logistics_config_idx_pid_cid" ON "partner_logistics_config" ("partner_id", "config_id");
CREATE INDEX IF NOT EXISTS "partner_logistics_region_price_idx_c_e" ON "partner_logistics_region_price" ("city_id", "express_id");
CREATE INDEX IF NOT EXISTS "partner_promoter_idx_partnerid" ON "partner_promoter" ("partner_id");
CREATE INDEX IF NOT EXISTS "partner_warehouse_shipping_area_idx_pid_wid_status" ON "partner_warehouse_shipping_area" ("partner_id", "ware_id", "data_status");
CREATE INDEX IF NOT EXISTS "pic_category_idx_pid" ON "pic_category" ("pid");
CREATE INDEX IF NOT EXISTS "pic_category_backup_idx_pid" ON "pic_category_backup" ("pid");
CREATE INDEX IF NOT EXISTS "pic_count_update_log_idx_target" ON "pic_count_update_log" ("target_id", "target_type");
CREATE INDEX IF NOT EXISTS "pic_count_update_log_idx_operator" ON "pic_count_update_log" ("operator_id");
CREATE INDEX IF NOT EXISTS "pic_lib_idx_userid" ON "pic_lib" ("user_id");
CREATE INDEX IF NOT EXISTS "pic_lib_idx_groupid" ON "pic_lib" ("group_id");
CREATE INDEX IF NOT EXISTS "pic_lib_idx_cid" ON "pic_lib" ("category_id");
CREATE INDEX IF NOT EXISTS "pic_lib_category_map_idx_category_id" ON "pic_lib_category_map" ("category_id");
CREATE INDEX IF NOT EXISTS "pic_lib_category_map_backup_idx_category_id" ON "pic_lib_category_map_backup" ("category_id");
CREATE INDEX IF NOT EXISTS "pic_lib_group_idx_last_bind_time" ON "pic_lib_group" ("last_bind_time");
CREATE INDEX IF NOT EXISTS "pic_operation_log_idx_target" ON "pic_operation_log" ("target_id", "target_type");
CREATE INDEX IF NOT EXISTS "pic_user_information_idx_recipient_time" ON "pic_user_information" ("recipient_id", "create_time");
CREATE INDEX IF NOT EXISTS "point_log_idx_user_expire" ON "point_log" ("user_id", "is_expired", "expire_time");
CREATE INDEX IF NOT EXISTS "point_mall_product_idx_cateid" ON "point_mall_product" ("category_id");
CREATE INDEX IF NOT EXISTS "post_follow_idx_fid_fedid" ON "post_follow" ("followed_id", "follower_id");
CREATE INDEX IF NOT EXISTS "post_lib_idx_userid" ON "post_lib" ("user_id");
CREATE INDEX IF NOT EXISTS "post_lib_idx_topic" ON "post_lib" ("topic_id");
CREATE INDEX IF NOT EXISTS "post_lib_idx_status_created_view" ON "post_lib" ("status", "created_at", "view_count");
CREATE INDEX IF NOT EXISTS "product_punish_record_idx_product_id_time" ON "product_punish_record" ("product_id", "punish_start");
CREATE INDEX IF NOT EXISTS "purchaser_area_log_idx_pid" ON "purchaser_area_log" ("purchaser_id");
CREATE INDEX IF NOT EXISTS "purchaser_bill_detail_idx_pid" ON "purchaser_bill_detail" ("purchaser_id");
CREATE INDEX IF NOT EXISTS "purchaser_bill_detail_idx_ordersn" ON "purchaser_bill_detail" ("order_sn");
CREATE INDEX IF NOT EXISTS "purchaser_bill_detail_idx_ctime_pid" ON "purchaser_bill_detail" ("create_time", "purchaser_id");
CREATE INDEX IF NOT EXISTS "purchaser_mail_idx_pid_ctime" ON "purchaser_mail" ("purchaser_id", "create_time");
CREATE INDEX IF NOT EXISTS "purchaser_mail_idx_con_pid" ON "purchaser_mail" ("coupon_no", "purchaser_id");
CREATE INDEX IF NOT EXISTS "purchaser_recall_log_idx_pid" ON "purchaser_recall_log" ("purchaser_id");
CREATE INDEX IF NOT EXISTS "purchaser_recall_log_idx_recalltime_pid" ON "purchaser_recall_log" ("recall_time", "purchaser_id");
CREATE INDEX IF NOT EXISTS "purchaser_use_recall_record_idx_app_id" ON "purchaser_use_recall_record" ("app_id");
CREATE INDEX IF NOT EXISTS "qixi_lottery_chance_idx_purchaser_round" ON "qixi_lottery_chance" ("purchaser_id", "round_no");
CREATE INDEX IF NOT EXISTS "qixi_lottery_prize_display_idx_prize_draw_status" ON "qixi_lottery_prize_display" ("prize_code");
CREATE INDEX IF NOT EXISTS "qixi_lottery_record_idx_pid" ON "qixi_lottery_record" ("purchaser_id");
CREATE INDEX IF NOT EXISTS "qixi_lottery_record_idx_roundno" ON "qixi_lottery_record" ("round_no");
CREATE INDEX IF NOT EXISTS "quick_ordering_item_idx_second_id_rank" ON "quick_ordering_item" ("second_id", "rank_num");
CREATE INDEX IF NOT EXISTS "quick_ordering_item_idx_purchaser_id" ON "quick_ordering_item" ("purchaser_id");
CREATE INDEX IF NOT EXISTS "quick_ordering_list_idx_purchaser_id" ON "quick_ordering_list" ("purchaser_id");
CREATE INDEX IF NOT EXISTS "red_packet_log_idx_userid" ON "red_packet_log" ("user_id");
CREATE INDEX IF NOT EXISTS "refund_complain_idx_pid" ON "refund_complain" ("pid");
CREATE INDEX IF NOT EXISTS "saas_admin_idx_xm_authorization" ON "saas_admin" ("xm_authorization");
CREATE INDEX IF NOT EXISTS "saas_app_audit_idx_app_id_audit_type" ON "saas_app_audit" ("app_id", "audit_status");
CREATE INDEX IF NOT EXISTS "saas_bank_idx_bank" ON "saas_bank" ("bank");
CREATE INDEX IF NOT EXISTS "saas_merchant_progress_idx_admin_id" ON "saas_merchant_progress" ("admin_id");
CREATE INDEX IF NOT EXISTS "saas_user_register_info_idx_admin_id" ON "saas_user_register_info" ("admin_id");
CREATE INDEX IF NOT EXISTS "sale_agency_downgrade_idx_agencyOrderId" ON "sale_agency_downgrade" ("agency_order_id", "status");
CREATE INDEX IF NOT EXISTS "sale_agency_item_idx_order" ON "sale_agency_item" ("agency_order_id");
CREATE INDEX IF NOT EXISTS "sale_agency_item_idx_plan_second" ON "sale_agency_item" ("agency_plan_order", "second_id");
CREATE INDEX IF NOT EXISTS "sale_agency_item_idx_rno_sid" ON "sale_agency_item" ("round_no", "supplier_id");
CREATE INDEX IF NOT EXISTS "sale_agency_item_detail_idx_orderid" ON "sale_agency_item_detail" ("agency_order_id");
CREATE INDEX IF NOT EXISTS "sale_agency_item_detail_idx_ordersn" ON "sale_agency_item_detail" ("order_sn");
CREATE INDEX IF NOT EXISTS "sale_agency_item_detail_idx_createtime_secondid_status" ON "sale_agency_item_detail" ("create_time", "second_id", "status");
CREATE INDEX IF NOT EXISTS "sale_agency_item_detail_idx_enteritemId" ON "sale_agency_item_detail" ("enter_item_id");
CREATE INDEX IF NOT EXISTS "sale_agency_item_detail_idx_itemId" ON "sale_agency_item_detail" ("agency_item_id");
CREATE INDEX IF NOT EXISTS "sale_agency_item_detail_log_idx_detailid_optype" ON "sale_agency_item_detail_log" ("item_detail_id", "op_type");
CREATE INDEX IF NOT EXISTS "sale_agency_night_sale_log_idx_supplier_id_create_time" ON "sale_agency_night_sale_log" ("supplier_id", "create_time");
CREATE INDEX IF NOT EXISTS "sale_agency_night_sale_log_idx_create_time" ON "sale_agency_night_sale_log" ("create_time");
CREATE INDEX IF NOT EXISTS "sale_agency_order_idx_roundNo" ON "sale_agency_order" ("round_no");
CREATE INDEX IF NOT EXISTS "sale_agency_order_idx_supplierId_status_creatTime" ON "sale_agency_order" ("supplier_id", "status", "create_time");
CREATE INDEX IF NOT EXISTS "sale_agency_order_sku_price_record_idx_orderid" ON "sale_agency_order_sku_price_record" ("agency_order_id");
CREATE INDEX IF NOT EXISTS "sale_agency_permission_idx_applytime" ON "sale_agency_permission" ("apply_time");
CREATE INDEX IF NOT EXISTS "sale_agency_plan_idx_roundno_secondid" ON "sale_agency_plan" ("round_no", "second_id");
CREATE INDEX IF NOT EXISTS "sale_agency_plan_item_idx_order_status" ON "sale_agency_plan_item" ("agency_plan_order", "status");
CREATE INDEX IF NOT EXISTS "sale_agency_report_loss_idx_orderid" ON "sale_agency_report_loss" ("agency_order_id");
CREATE INDEX IF NOT EXISTS "sale_agency_report_loss_idx_ctime" ON "sale_agency_report_loss" ("create_time");
CREATE INDEX IF NOT EXISTS "sale_agency_stock_idx_ctime_status" ON "sale_agency_stock" ("create_time", "status");
CREATE INDEX IF NOT EXISTS "sale_inspection_item_idx_enterItemId" ON "sale_inspection_item" ("enter_item_id");
CREATE INDEX IF NOT EXISTS "sale_inspection_item_idx_roundNo" ON "sale_inspection_item" ("round_no");
CREATE INDEX IF NOT EXISTS "sale_inspection_item_idx_itemId" ON "sale_inspection_item" ("sale_item_id");
CREATE INDEX IF NOT EXISTS "sale_wms_in_order_idx_sn" ON "sale_wms_in_order" ("in_order_sn");
CREATE INDEX IF NOT EXISTS "sale_wms_in_order_item_idx_sn" ON "sale_wms_in_order_item" ("in_order_sn");
CREATE INDEX IF NOT EXISTS "sale_wms_inventory_check_sku_diff_unit_idx_diff_id" ON "sale_wms_inventory_check_sku_diff_unit" ("diff_id");
CREATE INDEX IF NOT EXISTS "sale_wms_inventory_check_sku_diff_unit_idx_check_sn" ON "sale_wms_inventory_check_sku_diff_unit" ("check_sn");
CREATE INDEX IF NOT EXISTS "sale_wms_inventory_check_sku_diff_unit_idx_check_id" ON "sale_wms_inventory_check_sku_diff_unit" ("check_id");
CREATE INDEX IF NOT EXISTS "sale_wms_inventory_check_sku_diff_unit_idx_barcode" ON "sale_wms_inventory_check_sku_diff_unit" ("barcode");
CREATE INDEX IF NOT EXISTS "sale_wms_inventory_check_unit_log_idx_check_barcode" ON "sale_wms_inventory_check_unit_log" ("check_id", "barcode");
CREATE INDEX IF NOT EXISTS "sale_wms_item_unit_idx_out_item" ON "sale_wms_item_unit" ("out_order_item_id");
CREATE INDEX IF NOT EXISTS "sale_wms_item_unit_idx_in_item" ON "sale_wms_item_unit" ("in_order_item_id");
CREATE INDEX IF NOT EXISTS "sale_wms_out_order_idx_relate_sn" ON "sale_wms_out_order" ("relate_order_sn");
CREATE INDEX IF NOT EXISTS "sale_wms_out_order_item_idx_sn" ON "sale_wms_out_order_item" ("out_order_sn");
CREATE INDEX IF NOT EXISTS "sale_wms_restock_plan_idx_out_order_sn" ON "sale_wms_restock_plan" ("out_order_sn");
CREATE INDEX IF NOT EXISTS "sale_wms_restock_plan_item_idx_plan_id" ON "sale_wms_restock_plan_item" ("plan_id");
CREATE INDEX IF NOT EXISTS "sale_wms_restock_plan_item_idx_enter_item_id" ON "sale_wms_restock_plan_item" ("enter_item_id");
CREATE INDEX IF NOT EXISTS "sale_wms_restock_plan_item_idx_plan_second_rank" ON "sale_wms_restock_plan_item" ("plan_id", "second_id", "need_rank_num", "status");
CREATE INDEX IF NOT EXISTS "sale_wms_restock_plan_summary_idx_round_no" ON "sale_wms_restock_plan_summary" ("round_no");
CREATE INDEX IF NOT EXISTS "sale_wms_restock_plan_summary_idx_zone" ON "sale_wms_restock_plan_summary" ("zone");
CREATE INDEX IF NOT EXISTS "sale_wms_restock_plan_summary_idx_plan_id" ON "sale_wms_restock_plan_summary" ("plan_id");
CREATE INDEX IF NOT EXISTS "sale_wms_restock_plan_summary_idx_status" ON "sale_wms_restock_plan_summary" ("status");
CREATE INDEX IF NOT EXISTS "sale_wms_restock_plan_zone_idx_plan_id" ON "sale_wms_restock_plan_zone" ("plan_id");
CREATE INDEX IF NOT EXISTS "sale_wms_restock_plan_zone_idx_zone" ON "sale_wms_restock_plan_zone" ("zone");
CREATE INDEX IF NOT EXISTS "sale_wms_restock_relation_idx_purchase_id" ON "sale_wms_restock_relation" ("purchaser_id");
CREATE INDEX IF NOT EXISTS "sale_wms_stock_uk_sku" ON "sale_wms_stock" ("second_id", "rank_num", "sale_supplier_id");
CREATE INDEX IF NOT EXISTS "search_rank_result_idx_roundNo_appId" ON "search_rank_result" ("round_no", "app_id");
CREATE INDEX IF NOT EXISTS "second_average_price_idx_secondId_data" ON "second_average_price" ("round_no", "second_id");
CREATE INDEX IF NOT EXISTS "second_rank_result_idx_date_type" ON "second_rank_result" ("round_no", "type");
CREATE INDEX IF NOT EXISTS "statistics_category_data_idx_roundno_firstid" ON "statistics_category_data" ("round_no", "first_id");
CREATE INDEX IF NOT EXISTS "statistics_city_data_idx_roundno_province" ON "statistics_city_data" ("round_no", "province");
CREATE INDEX IF NOT EXISTS "supplier_agency_downgrade_idx_agencyOrderId" ON "supplier_agency_downgrade" ("agency_order_id", "status");
CREATE INDEX IF NOT EXISTS "supplier_agency_item_idx_order" ON "supplier_agency_item" ("agency_order_id");
CREATE INDEX IF NOT EXISTS "supplier_agency_item_idx_plan_second" ON "supplier_agency_item" ("agency_plan_order", "second_id");
CREATE INDEX IF NOT EXISTS "supplier_agency_item_detail_idx_orderid" ON "supplier_agency_item_detail" ("agency_order_id");
CREATE INDEX IF NOT EXISTS "supplier_agency_item_detail_idx_ordersn" ON "supplier_agency_item_detail" ("order_sn");
CREATE INDEX IF NOT EXISTS "supplier_agency_item_detail_log_idx_detailid_optype" ON "supplier_agency_item_detail_log" ("item_detail_id", "op_type");
CREATE INDEX IF NOT EXISTS "supplier_agency_permission_idx_applytime" ON "supplier_agency_permission" ("apply_time");
CREATE INDEX IF NOT EXISTS "supplier_agency_plan_idx_roundno_secondid" ON "supplier_agency_plan" ("round_no", "second_id");
CREATE INDEX IF NOT EXISTS "supplier_agency_plan_item_idx_order_status" ON "supplier_agency_plan_item" ("agency_plan_order", "status");
CREATE INDEX IF NOT EXISTS "supplier_agency_report_loss_idx_orderid" ON "supplier_agency_report_loss" ("agency_order_id");
CREATE INDEX IF NOT EXISTS "supplier_agency_report_loss_idx_ctime" ON "supplier_agency_report_loss" ("create_time");
CREATE INDEX IF NOT EXISTS "supplier_agency_stock_idx_ctime_status" ON "supplier_agency_stock" ("create_time", "status");
CREATE INDEX IF NOT EXISTS "supplier_match_replace_apply_idx_supplierid" ON "supplier_match_replace_apply" ("supplier_id");
CREATE INDEX IF NOT EXISTS "supplier_match_replace_apply_idx_start_end_status_dataStatus_supplierId" ON "supplier_match_replace_apply" ("start_round_no", "end_round_no", "supplier_id", "status", "data_status");
CREATE INDEX IF NOT EXISTS "supplier_match_replace_detail_idx_oid" ON "supplier_match_replace_detail" ("o_id");
CREATE INDEX IF NOT EXISTS "supplier_match_replace_detail_idx_roundno_supplierid_status" ON "supplier_match_replace_detail" ("round_no", "supplier_id", "data_status");
CREATE INDEX IF NOT EXISTS "supplier_rank_result_idx_rounNo_supId" ON "supplier_rank_result" ("round_no", "supplier_id");
CREATE INDEX IF NOT EXISTS "sys_popup_config_idx_appid" ON "sys_popup_config" ("app_id");
CREATE INDEX IF NOT EXISTS "tl_account_idx_bizuserid" ON "tl_account" ("biz_user_id");
CREATE INDEX IF NOT EXISTS "tl_transfer_idx_ctime" ON "tl_transfer" ("create_time");
CREATE INDEX IF NOT EXISTS "topics_idx_title" ON "topics" ("title");
CREATE INDEX IF NOT EXISTS "topics_idx_userid" ON "topics" ("user_id");
CREATE INDEX IF NOT EXISTS "topics_comment_idx_topicid" ON "topics_comment" ("topic_id");
CREATE INDEX IF NOT EXISTS "topics_like_uk_likeid_topicid" ON "topics_like" ("like_id", "topic_id");
CREATE INDEX IF NOT EXISTS "transport_station_flower_input_idx_round_station" ON "transport_station_flower_input" ("round_no", "station_id");
CREATE INDEX IF NOT EXISTS "transport_station_flower_input_idx_round_station_area" ON "transport_station_flower_input" ("round_no", "station_name", "area_id");
CREATE INDEX IF NOT EXISTS "user_comment_idx_user_id" ON "user_comment" ("user_id");
CREATE INDEX IF NOT EXISTS "user_comment_idx_parent_id" ON "user_comment" ("parent_id");
CREATE INDEX IF NOT EXISTS "user_comment_idx_rootid" ON "user_comment" ("root_id");
CREATE INDEX IF NOT EXISTS "user_comment_idx_target_type_id_deleted" ON "user_comment" ("target_type", "target_id", "target_deleted");
CREATE INDEX IF NOT EXISTS "user_down_idx_target" ON "user_down" ("target_id", "target_type");
CREATE INDEX IF NOT EXISTS "user_like_idx_target" ON "user_like" ("target_id", "target_type");
CREATE INDEX IF NOT EXISTS "user_share_idx_target" ON "user_share" ("target_id", "target_type");
CREATE INDEX IF NOT EXISTS "user_star_idx_target" ON "user_star" ("target_id", "target_type");
CREATE INDEX IF NOT EXISTS "ware_blacklist_supplier_idx_supplier_id" ON "ware_blacklist_supplier" ("supplier_id");
CREATE INDEX IF NOT EXISTS "wms_after_sale_punish_review_log_idx_review_time" ON "wms_after_sale_punish_review_log" ("review_id", "create_time", "id");
CREATE INDEX IF NOT EXISTS "wms_check_item_log_idx_oid" ON "wms_check_item_log" ("order_item_id");
CREATE INDEX IF NOT EXISTS "wms_check_item_log_idx_data_op_supplier" ON "wms_check_item_log" ("date", "op", "supplier_id");
CREATE INDEX IF NOT EXISTS "wms_check_item_log_idx_eid" ON "wms_check_item_log" ("enter_item_id");
CREATE INDEX IF NOT EXISTS "wms_check_item_log_idx_enter_item_id" ON "wms_check_item_log" ("enter_item_id");
CREATE INDEX IF NOT EXISTS "wms_check_item_log_idx_plan_item_id" ON "wms_check_item_log" ("plan_item_id");
CREATE INDEX IF NOT EXISTS "wms_check_item_log_idx_data_user_op" ON "wms_check_item_log" ("date", "op", "user_id");
CREATE INDEX IF NOT EXISTS "wms_entry_inventory_idx_skuid_remaining" ON "wms_entry_inventory" ("sku_id", "remain_inventory");
CREATE INDEX IF NOT EXISTS "wms_entry_inventory_idx_sku_team_remain" ON "wms_entry_inventory" ("sku_id", "team_id", "remain_inventory");
CREATE INDEX IF NOT EXISTS "wms_entry_inventory_idx_team_status_sku" ON "wms_entry_inventory" ("team_id", "data_status", "sku_id");
CREATE INDEX IF NOT EXISTS "wms_entry_inventory_idx_source_apply" ON "wms_entry_inventory" ("source_apply_id");
CREATE INDEX IF NOT EXISTS "wms_entry_inventory_trace_idx_class_sku" ON "wms_entry_inventory_trace" ("trace_class", "sku_id");
CREATE INDEX IF NOT EXISTS "wms_entry_inventory_trace_idx_team_failed_time" ON "wms_entry_inventory_trace" ("team_id", "outbound_failed", "create_time");
CREATE INDEX IF NOT EXISTS "wms_entry_inventory_trace_idx_sku_team_time" ON "wms_entry_inventory_trace" ("sku_id", "team_id", "create_time");
CREATE INDEX IF NOT EXISTS "wms_inventory_check_idx_sku_time" ON "wms_inventory_check" ("sku_id", "create_time");
CREATE INDEX IF NOT EXISTS "wms_inventory_check_idx_category_spec_time" ON "wms_inventory_check" ("category", "specification", "create_time");
CREATE INDEX IF NOT EXISTS "wms_inventory_check_detail_idx_check_id" ON "wms_inventory_check_detail" ("check_id");
CREATE INDEX IF NOT EXISTS "wms_inventory_check_detail_idx_sku_part_period" ON "wms_inventory_check_detail" ("sku_id", "part", "period_no");
CREATE INDEX IF NOT EXISTS "wms_inventory_check_detail_idx_sku_team_period" ON "wms_inventory_check_detail" ("sku_id", "team_id", "period_no");
CREATE INDEX IF NOT EXISTS "wms_inventory_relation_idx_trace_id" ON "wms_inventory_relation" ("trace_id");
CREATE INDEX IF NOT EXISTS "wms_inventory_relation_idx_entry_id" ON "wms_inventory_relation" ("entry_id");
CREATE INDEX IF NOT EXISTS "wms_material_apply_idx_status_id" ON "wms_material_apply" ("status", "id");
CREATE INDEX IF NOT EXISTS "wms_material_apply_idx_team_status_id" ON "wms_material_apply" ("team_id", "status", "id");
CREATE INDEX IF NOT EXISTS "wms_material_apply_idx_applicant_id" ON "wms_material_apply" ("applicant_id", "id");
CREATE INDEX IF NOT EXISTS "wms_operation_log_idx_entryId" ON "wms_operation_log" ("entry_id");
CREATE INDEX IF NOT EXISTS "wms_operation_log_idx_traceid_createtime" ON "wms_operation_log" ("trace_id", "create_time");
CREATE INDEX IF NOT EXISTS "wms_prepare_record_idx_date_user_op" ON "wms_prepare_record" ("date", "user_id", "op");
CREATE INDEX IF NOT EXISTS "wms_prepare_record_idx_enter_item_id" ON "wms_prepare_record" ("enter_item_id");
CREATE INDEX IF NOT EXISTS "wms_prepare_record_idx_role_type" ON "wms_prepare_record" ("role_type");
CREATE INDEX IF NOT EXISTS "wms_punish_idx_user_time" ON "wms_punish" ("create_time", "duty_user_id");
CREATE INDEX IF NOT EXISTS "wms_punish_idx_ordersn_userid" ON "wms_punish" ("order_sn", "duty_user_id");
CREATE INDEX IF NOT EXISTS "wms_punish_idx_date" ON "wms_punish" ("date");
CREATE INDEX IF NOT EXISTS "wms_punish_idx_refund_id" ON "wms_punish" ("refund_id");
CREATE INDEX IF NOT EXISTS "wms_punish_idx_inspection_punish_dedup" ON "wms_punish" ("type", "duty_user_id", "date", "zone_shelf", "sub_shelf_sn", "punish_status", "data_status");
CREATE INDEX IF NOT EXISTS "wms_sku_mapping_idx_pid_type" ON "wms_sku_mapping" ("product_id", "business_type");
CREATE INDEX IF NOT EXISTS "wms_stock_operation_failure_log_idx_type" ON "wms_stock_operation_failure_log" ("type");
CREATE INDEX IF NOT EXISTS "wms_stock_operation_failure_log_idx_sku_id" ON "wms_stock_operation_failure_log" ("wms_sku_id");
CREATE INDEX IF NOT EXISTS "wx_b2b_order_idx_ctime" ON "wx_b2b_order" ("create_time");
CREATE INDEX IF NOT EXISTS "wx_b2b_order_idx_refundid" ON "wx_b2b_order" ("refund_id");
CREATE INDEX IF NOT EXISTS "wx_b2b_order_idx_uid" ON "wx_b2b_order" ("user_id");
CREATE INDEX IF NOT EXISTS "wx_b2b_order_info_idx_userid_mchid_ordersn" ON "wx_b2b_order_info" ("user_id", "mch_id", "order_sn");
CREATE INDEX IF NOT EXISTS "wx_b2b_order_info_idx_ordersn_mchid_status" ON "wx_b2b_order_info" ("order_sn", "mch_id", "data_status");
CREATE INDEX IF NOT EXISTS "wx_b2b_order_info_idx_wxid" ON "wx_b2b_order_info" ("wxpay_transaction_id");
CREATE INDEX IF NOT EXISTS "wx_b2b_order_info_idx_ctime" ON "wx_b2b_order_info" ("create_time");
CREATE INDEX IF NOT EXISTS "wx_b2b_order_info_idx_outordersn_mchid_status" ON "wx_b2b_order_info" ("out_trade_no", "mch_id", "data_status");
CREATE INDEX IF NOT EXISTS "wx_customer_group_idx_cid" ON "wx_customer_group" ("contact_id");
CREATE INDEX IF NOT EXISTS "wx_customer_group_idx_contact_area_status" ON "wx_customer_group" ("contact_id", "area_type", "status", "data_status");
CREATE INDEX IF NOT EXISTS "xm_base_data_round_no" ON "xm_base_data" ("round_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_after_sale_idx_order_sn" ON "xm_bulky_after_sale" ("order_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_after_sale_idx_uptime" ON "xm_bulky_after_sale" ("update_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_after_sale_log_idx_after_sale_id" ON "xm_bulky_after_sale_log" ("after_sale_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_agency_cart_idx_user_id" ON "xm_bulky_agency_cart" ("user_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_agency_order_idx_send_no" ON "xm_bulky_agency_order" ("send_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_agency_order_idx_round_no" ON "xm_bulky_agency_order" ("round_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_agency_order_idx_purchaserid_wareid" ON "xm_bulky_agency_order" ("purchaser_id", "ware_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_agency_order_idx_wxpaytime_ordersn" ON "xm_bulky_agency_order" ("wx_pay_time", "order_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_agency_order_edit_idx_order_sn" ON "xm_bulky_agency_order_edit" ("order_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_agency_order_item_idx_order_sn" ON "xm_bulky_agency_order_item" ("order_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_agency_order_item_idx_supplier_id" ON "xm_bulky_agency_order_item" ("supplier_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_agency_order_item_idx_create_time" ON "xm_bulky_agency_order_item" ("create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_agency_order_item_idx_roundno" ON "xm_bulky_agency_order_item" ("round_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_agency_product_idx_second_id" ON "xm_bulky_agency_product" ("second_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_agency_product_idx_rank_num" ON "xm_bulky_agency_product" ("rank_num");
CREATE INDEX IF NOT EXISTS "xm_bulky_agency_product_idx_thirdgoodid" ON "xm_bulky_agency_product" ("third_good_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_agency_product_idx_supplierid_firstid" ON "xm_bulky_agency_product" ("supplier_id", "first_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_agency_product_idx_planid_sid" ON "xm_bulky_agency_product" ("plan_id", "supplier_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_agency_product_log_idx_createtime_supplierid_productid" ON "xm_bulky_agency_product_log" ("create_time", "supplier_id", "product_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_agency_purchaser_idx_phone_number" ON "xm_bulky_agency_purchaser" ("phone_number");
CREATE INDEX IF NOT EXISTS "xm_bulky_agency_purchaser_idx_xm_account" ON "xm_bulky_agency_purchaser" ("xm_account");
CREATE INDEX IF NOT EXISTS "xm_bulky_agency_purchaser_idx_helpid" ON "xm_bulky_agency_purchaser" ("help_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_agency_purchaser_account_log_idx_purchaser_id" ON "xm_bulky_agency_purchaser_account_log" ("purchaser_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_agency_purchaser_address_idx_user_id" ON "xm_bulky_agency_purchaser_address" ("user_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_agency_refund_idx_createtime_purchaserid" ON "xm_bulky_agency_refund" ("create_time", "purchaser_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_agency_refund_idx_wareid_datastatus" ON "xm_bulky_agency_refund" ("ware_id", "data_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_agency_refund_idx_ordersn_status" ON "xm_bulky_agency_refund" ("order_sn", "data_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_agency_refund_idx_cdate_pid" ON "xm_bulky_agency_refund" ("create_date", "purchaser_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_agency_refund_item_idx_order_item_id" ON "xm_bulky_agency_refund_item" ("order_item_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_agency_refund_item_idx_createtime" ON "xm_bulky_agency_refund_item" ("create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_agency_supplier_order_idx_wx_pay_time" ON "xm_bulky_agency_supplier_order" ("wx_pay_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_agency_supplier_order_idx_order_sn_union" ON "xm_bulky_agency_supplier_order" ("order_sn", "supplier_id", "data_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_agency_tag_product_idx_second_id" ON "xm_bulky_agency_tag_product" ("second_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_agreement_idx_ptype_type" ON "xm_bulky_agreement" ("platform_type", "type");
CREATE INDEX IF NOT EXISTS "xm_bulky_agreement_update_idx_agreement_id" ON "xm_bulky_agreement_update" ("agreement_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_agreement_update_idx_show_data_status_id" ON "xm_bulky_agreement_update" ("is_show", "data_status", "id");
CREATE INDEX IF NOT EXISTS "xm_bulky_allocate_driver_idx_allocate_user" ON "xm_bulky_allocate_driver" ("allocate_user_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_api_statistics_log_idx_userId_type_source_apiCode_date" ON "xm_bulky_api_statistics_log" ("user_id", "type", "source", "api_code", "date");
CREATE INDEX IF NOT EXISTS "xm_bulky_auth_area_permission_idx_route_status" ON "xm_bulky_auth_area_permission" ("route_name", "data_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_auth_operation_log_idx_biz_time" ON "xm_bulky_auth_operation_log" ("biz_type", "biz_id", "create_time", "id");
CREATE INDEX IF NOT EXISTS "xm_bulky_auth_operation_log_idx_operator_time" ON "xm_bulky_auth_operation_log" ("operator_id", "create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_auth_operation_log_idx_operation_time" ON "xm_bulky_auth_operation_log" ("operation_type", "create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_auth_position_idx_position_name_status" ON "xm_bulky_auth_position" ("position_name", "data_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_auth_position_idx_important_status" ON "xm_bulky_auth_position" ("important_flag", "data_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_auth_position_apply_idx_status_apply_time" ON "xm_bulky_auth_position_apply" ("status", "apply_time", "id");
CREATE INDEX IF NOT EXISTS "xm_bulky_auth_position_apply_idx_target_position_status" ON "xm_bulky_auth_position_apply" ("target_position_id", "status");
CREATE INDEX IF NOT EXISTS "xm_bulky_auth_position_role_idx_role_status" ON "xm_bulky_auth_position_role" ("role_id", "data_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_auth_position_role_apply_idx_status_apply_time" ON "xm_bulky_auth_position_role_apply" ("status", "apply_time", "id");
CREATE INDEX IF NOT EXISTS "xm_bulky_auth_position_role_apply_idx_apply_user_time" ON "xm_bulky_auth_position_role_apply" ("apply_user_id", "apply_time", "id");
CREATE INDEX IF NOT EXISTS "xm_bulky_auth_role_area_permission_idx_role_status_enable" ON "xm_bulky_auth_role_area_permission" ("role_id", "data_status", "enable");
CREATE INDEX IF NOT EXISTS "xm_bulky_auth_role_area_permission_idx_area_permission_status" ON "xm_bulky_auth_role_area_permission" ("area_permission_id", "data_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_auth_role_permission_apply_idx_status_apply_time" ON "xm_bulky_auth_role_permission_apply" ("status", "apply_time", "id");
CREATE INDEX IF NOT EXISTS "xm_bulky_auth_role_permission_apply_idx_apply_user_time" ON "xm_bulky_auth_role_permission_apply" ("apply_user_id", "apply_time", "id");
CREATE INDEX IF NOT EXISTS "xm_bulky_auth_role_permission_apply_area_idx_area_permission" ON "xm_bulky_auth_role_permission_apply_area" ("area_permission_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_auth_user_position_idx_position_status" ON "xm_bulky_auth_user_position" ("position_id", "data_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_auth_user_role_idx_userId_roleId" ON "xm_bulky_auth_user_role" ("user_id", "role_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_auth_user_role_idx_role_id" ON "xm_bulky_auth_user_role" ("role_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_ban_supplier_idx_user_id" ON "xm_bulky_ban_supplier" ("user_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_bank_account_idx_account_no" ON "xm_bulky_bank_account" ("account_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_bank_transfer_record_idx_payee_bank_no" ON "xm_bulky_bank_transfer_record" ("payee_bank_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_bank_transfer_record_idx_record_code" ON "xm_bulky_bank_transfer_record" ("record_code");
CREATE INDEX IF NOT EXISTS "xm_bulky_bank_transfer_record_idx_i_seq_no" ON "xm_bulky_bank_transfer_record" ("i_seq_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_bank_transfer_record_idx_ctime_status" ON "xm_bulky_bank_transfer_record" ("create_time", "status");
CREATE INDEX IF NOT EXISTS "xm_bulky_bank_transfer_record_idx_status_time" ON "xm_bulky_bank_transfer_record" ("status", "data_status", "create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_base_config_idx_area_id" ON "xm_bulky_base_config" ("area_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_base_outsource_income_idx_user_round" ON "xm_bulky_base_outsource_income" ("user_id", "round_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_base_outsource_income_idx_settle_round" ON "xm_bulky_base_outsource_income" ("settle_flag", "round_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_base_outsource_income_idx_income_rule_id" ON "xm_bulky_base_outsource_income" ("income_rule_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_burial_point_idx_pid_type" ON "xm_bulky_burial_point" ("purchaser_id", "type");
CREATE INDEX IF NOT EXISTS "xm_bulky_cart_idx_user_id" ON "xm_bulky_cart" ("user_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_chat_chat_message_idx_conv_time" ON "xm_bulky_chat_chat_message" ("conversation_id", "send_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_chat_chat_message_idx_sender_in_conv" ON "xm_bulky_chat_chat_message" ("conversation_id", "sender_type", "sender_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_chat_conversation_idx_target" ON "xm_bulky_chat_conversation" ("target_id", "msg_type", "target_type", "con_type");
CREATE INDEX IF NOT EXISTS "xm_bulky_chat_conversation_user_idx_user_conv" ON "xm_bulky_chat_conversation_user" ("user_type", "user_id", "conversation_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_chat_message_template_idx_msg" ON "xm_bulky_chat_message_template" ("msg_type");
CREATE INDEX IF NOT EXISTS "xm_bulky_chat_private_permission_idx_status" ON "xm_bulky_chat_private_permission" ("status");
CREATE INDEX IF NOT EXISTS "xm_bulky_chat_private_permission_idx_mute_end_time" ON "xm_bulky_chat_private_permission" ("mute_end_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_chat_sys_message_idx_biz" ON "xm_bulky_chat_sys_message" ("biz_type", "biz_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_chat_sys_message_idx_type" ON "xm_bulky_chat_sys_message" ("msg_type");
CREATE INDEX IF NOT EXISTS "xm_bulky_chat_sys_message_idx_send_time" ON "xm_bulky_chat_sys_message" ("send_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_chat_sys_message_idx_revoke" ON "xm_bulky_chat_sys_message" ("revoke_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_chat_sys_message_idx_sender" ON "xm_bulky_chat_sys_message" ("sender_type", "sender_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_chat_user_message_idx_user_read" ON "xm_bulky_chat_user_message" ("user_id", "read_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_chat_user_message_idx_user_time" ON "xm_bulky_chat_user_message" ("user_id", "create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_chat_user_message_idx_user_msg_full" ON "xm_bulky_chat_user_message" ("user_id", "user_type", "msg_type", "read_status", "send_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_chat_user_message_idx_message_id" ON "xm_bulky_chat_user_message" ("message_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_chat_user_message_idx_userid_msgtype_usertype_deleteflag_sendtime" ON "xm_bulky_chat_user_message" ("user_id", "msg_type", "user_type", "delete_flag", "send_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_chat_user_message_idx_cleanup_send_time_id" ON "xm_bulky_chat_user_message" ("send_time", "id");
CREATE INDEX IF NOT EXISTS "xm_bulky_city_customer_daily_statistics_idx_ware_purchaser_date" ON "xm_bulky_city_customer_daily_statistics" ("ware_id", "purchaser_id", "stat_date");
CREATE INDEX IF NOT EXISTS "xm_bulky_city_second_subsidy_idx_cityid_secondid" ON "xm_bulky_city_second_subsidy" ("city_id", "second_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_city_subsidy_idx_cityid" ON "xm_bulky_city_subsidy" ("city_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_city_subsidy_log_idx_cityid" ON "xm_bulky_city_subsidy_log" ("city_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_city_subsidy_product_idx_adcode_secondid" ON "xm_bulky_city_subsidy_product" ("adcode", "second_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_city_subsidy_product_uk_adcode_pid" ON "xm_bulky_city_subsidy_product" ("adcode", "product_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_class_first_idx_sequence" ON "xm_bulky_class_first" ("sequence");
CREATE INDEX IF NOT EXISTS "xm_bulky_class_first_idx_sortnum" ON "xm_bulky_class_first" ("sort_num");
CREATE INDEX IF NOT EXISTS "xm_bulky_class_second_idx_first_id" ON "xm_bulky_class_second" ("first_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_class_second_idx_name_datastatus" ON "xm_bulky_class_second" ("name", "data_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_class_second1_idx_first_id" ON "xm_bulky_class_second1" ("first_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_class_second1_idx_name_datastatus" ON "xm_bulky_class_second1" ("name", "data_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_class_second_rank_sku_idx_second_id" ON "xm_bulky_class_second_rank_sku" ("second_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_class_second_sort_idx_second_id" ON "xm_bulky_class_second_sort" ("second_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_coin_detail_log_idx_order_sn" ON "xm_bulky_coin_detail_log" ("order_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_coin_log_idx_order_sn" ON "xm_bulky_coin_log" ("order_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_coin_log_idx_ctime_btype_reason" ON "xm_bulky_coin_log" ("create_time", "business_type", "reason");
CREATE INDEX IF NOT EXISTS "xm_bulky_cold_contact_log_idx_cold_stock_id" ON "xm_bulky_cold_contact_log" ("cold_stock_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_cold_contact_log_idx_purchaser_id" ON "xm_bulky_cold_contact_log" ("purchaser_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_cold_out_task_idx_cold_stock_id" ON "xm_bulky_cold_out_task" ("cold_stock_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_cold_out_task_idx_link_send_no" ON "xm_bulky_cold_out_task" ("link_send_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_cold_out_task_idx_task_status" ON "xm_bulky_cold_out_task" ("task_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_cold_out_task_package_idx_out_task_id" ON "xm_bulky_cold_out_task_package" ("out_task_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_cold_out_task_package_idx_express_package_id" ON "xm_bulky_cold_out_task_package" ("express_package_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_cold_stock_idx_purchaser" ON "xm_bulky_cold_stock" ("purchaser_id", "data_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_cold_stock_idx_purchaser_mobile" ON "xm_bulky_cold_stock" ("purchaser_mobile");
CREATE INDEX IF NOT EXISTS "xm_bulky_cold_stock_idx_stock_status" ON "xm_bulky_cold_stock" ("stock_status", "data_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_cold_stock_idx_store_round_no" ON "xm_bulky_cold_stock" ("store_round_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_cold_stock_idx_origin_send_no" ON "xm_bulky_cold_stock" ("origin_send_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_cold_stock_package_idx_express_package_id" ON "xm_bulky_cold_stock_package" ("express_package_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_cold_stock_package_idx_package_code" ON "xm_bulky_cold_stock_package" ("package_code");
CREATE INDEX IF NOT EXISTS "xm_bulky_cold_stock_package_idx_stock_package" ON "xm_bulky_cold_stock_package" ("cold_stock_id", "express_package_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_complain_idx_userid" ON "xm_bulky_complain" ("user_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_complain_idx_cptype_ctime" ON "xm_bulky_complain" ("complain_type", "create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_complain_idx_handletime" ON "xm_bulky_complain" ("handle_time", "partner_id", "ware_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_complain_idx_rid_ctype" ON "xm_bulky_complain" ("relate_id", "complain_type");
CREATE INDEX IF NOT EXISTS "xm_bulky_contact_supplier_log_idx_user_supplier_id_op" ON "xm_bulky_contact_supplier_log" ("user_id", "supplier_id", "op");
CREATE INDEX IF NOT EXISTS "xm_bulky_coupon_idx_partnerid" ON "xm_bulky_coupon" ("partner_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_coupon_uk_coupon_no" ON "xm_bulky_coupon" ("coupon_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_coupon_log_idx_couponid" ON "xm_bulky_coupon_log" ("coupon_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_coupon_user_idx_purchaser_id" ON "xm_bulky_coupon_user" ("purchaser_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_coupon_user_idx_coupon_no" ON "xm_bulky_coupon_user" ("coupon_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_coupon_user_idx_update_time" ON "xm_bulky_coupon_user" ("update_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_coupon_user_idx_utime_cstatus_cprice_wratio" ON "xm_bulky_coupon_user" ("update_time", "coupon_status", "coupon_price", "ware_ratio");
CREATE INDEX IF NOT EXISTS "xm_bulky_delivery_order_idx_supplier_id" ON "xm_bulky_delivery_order" ("supplier_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_delivery_order_idx_roundNo" ON "xm_bulky_delivery_order" ("round_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_delivery_order_idx_utime" ON "xm_bulky_delivery_order" ("update_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_delivery_order_item_idx_delivery_no" ON "xm_bulky_delivery_order_item" ("delivery_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_delivery_order_item_tmp_idx_delivery_no" ON "xm_bulky_delivery_order_item_tmp" ("delivery_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_delivery_order_tmp_idx_supplier_id" ON "xm_bulky_delivery_order_tmp" ("supplier_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_delivery_order_tmp_idx_utime" ON "xm_bulky_delivery_order_tmp" ("update_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_delivery_order_tmp_idx_roundNo" ON "xm_bulky_delivery_order_tmp" ("round_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_employee_idx_uid" ON "xm_bulky_employee" ("user_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_employee_bonus_config_user_idx_cid" ON "xm_bulky_employee_bonus_config_user" ("config_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_employee_bonus_month_idx_month" ON "xm_bulky_employee_bonus_month" ("month");
CREATE INDEX IF NOT EXISTS "xm_bulky_employee_bonus_month_detail_idx_month" ON "xm_bulky_employee_bonus_month_detail" ("month");
CREATE INDEX IF NOT EXISTS "xm_bulky_employee_wage_idx_month" ON "xm_bulky_employee_wage" ("month");
CREATE INDEX IF NOT EXISTS "xm_bulky_enter_item_info_idx_enter_item_id" ON "xm_bulky_enter_item_info" ("enter_item_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_exchange_log_idx_content" ON "xm_bulky_exchange_log" ("code_content", "status");
CREATE INDEX IF NOT EXISTS "xm_bulky_exchange_log_idx_roundno_product" ON "xm_bulky_exchange_log" ("round_no", "product_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_exchange_log_idx_enterItem" ON "xm_bulky_exchange_log" ("enter_item_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_exchange_voice_call_record_idx_pending_task" ON "xm_bulky_exchange_voice_call_record" ("task_status", "id");
CREATE INDEX IF NOT EXISTS "xm_bulky_exchange_voice_call_record_idx_notify_history" ON "xm_bulky_exchange_voice_call_record" ("notify_id", "id");
CREATE INDEX IF NOT EXISTS "xm_bulky_exchange_voice_call_record_idx_round_supplier" ON "xm_bulky_exchange_voice_call_record" ("round_no", "supplier_id", "id");
CREATE INDEX IF NOT EXISTS "xm_bulky_exchange_voice_notify_idx_round_status" ON "xm_bulky_exchange_voice_notify" ("round_no", "call_status", "notify_count");
CREATE INDEX IF NOT EXISTS "xm_bulky_express_change_apply_idx_ordersn" ON "xm_bulky_express_change_apply" ("order_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_express_change_apply_idx_pid" ON "xm_bulky_express_change_apply" ("purchaser_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_express_change_apply_idx_sendno" ON "xm_bulky_express_change_apply" ("send_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_express_price_redress_idx_send_no" ON "xm_bulky_express_price_redress" ("send_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_express_redress_refund_idx_order_sn" ON "xm_bulky_express_redress_refund" ("order_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_express_refund_idx_updatetime" ON "xm_bulky_express_refund" ("update_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_express_refund_idx_purchaserid_refundstatus_refundtype" ON "xm_bulky_express_refund" ("purchaser_id", "refund_status", "refund_type");
CREATE INDEX IF NOT EXISTS "xm_bulky_express_refund_idx_refund_status" ON "xm_bulky_express_refund" ("refund_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_expressid_idx_order_sn" ON "xm_bulky_expressid" ("order_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_expressid_idx_express_code" ON "xm_bulky_expressid" ("express_code");
CREATE INDEX IF NOT EXISTS "xm_bulky_external_distribution_contractor_account_idx_contractor_status" ON "xm_bulky_external_distribution_contractor_account" ("contractor_user_id", "data_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_external_distribution_contractor_account_idx_employee_user_id" ON "xm_bulky_external_distribution_contractor_account" ("employee_user_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_favorite_flower_idx_user_id" ON "xm_bulky_favorite_flower" ("user_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_fhh_trade_funnel_event_idx_round_user_type" ON "xm_bulky_fhh_trade_funnel_event" ("round_no", "purchaser_id", "event_type");
CREATE INDEX IF NOT EXISTS "xm_bulky_fhh_trade_funnel_event_idx_order_type" ON "xm_bulky_fhh_trade_funnel_event" ("order_sn", "event_type");
CREATE INDEX IF NOT EXISTS "xm_bulky_fhh_trade_funnel_event_idx_create_time" ON "xm_bulky_fhh_trade_funnel_event" ("create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_financial_data_idx_yyyy_mm_dd" ON "xm_bulky_financial_data" ("yyyy_mm_dd");
CREATE INDEX IF NOT EXISTS "xm_bulky_freeze_operation_log_idx_freeze_time" ON "xm_bulky_freeze_operation_log" ("freeze_id", "create_time", "id");
CREATE INDEX IF NOT EXISTS "xm_bulky_freeze_operation_log_idx_detail_time" ON "xm_bulky_freeze_operation_log" ("detail_id", "create_time", "id");
CREATE INDEX IF NOT EXISTS "xm_bulky_freeze_operation_log_idx_related_detail" ON "xm_bulky_freeze_operation_log" ("related_detail_id", "id");
CREATE INDEX IF NOT EXISTS "xm_bulky_freeze_record_idx_supplier_time" ON "xm_bulky_freeze_record" ("supplier_id", "create_time", "id");
CREATE INDEX IF NOT EXISTS "xm_bulky_freeze_record_idx_source_id" ON "xm_bulky_freeze_record" ("source_type", "source_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_freeze_record_item_idx_review_time" ON "xm_bulky_freeze_record_item" ("review_status", "create_time", "id");
CREATE INDEX IF NOT EXISTS "xm_bulky_freeze_record_item_idx_expire" ON "xm_bulky_freeze_record_item" ("status", "is_permanent", "end_time", "id");
CREATE INDEX IF NOT EXISTS "xm_bulky_freeze_record_item_idx_replace_id" ON "xm_bulky_freeze_record_item" ("replace_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_freeze_record_item_idx_object_status" ON "xm_bulky_freeze_record_item" ("object_type", "object_id", "status", "id");
CREATE INDEX IF NOT EXISTS "xm_bulky_freeze_stats_idx_stats_date" ON "xm_bulky_freeze_stats" ("stats_date");
CREATE INDEX IF NOT EXISTS "xm_bulky_help_customer_idx_ctime_helpid" ON "xm_bulky_help_customer" ("create_time", "help_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_help_log_idx_help_id" ON "xm_bulky_help_log" ("help_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_help_order_detail_idx_ordersn" ON "xm_bulky_help_order_detail" ("order_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_help_order_detail_idx_userid_date" ON "xm_bulky_help_order_detail" ("user_id", "yyyy_mm_dd");
CREATE INDEX IF NOT EXISTS "xm_bulky_help_order_detail_idx_paytime" ON "xm_bulky_help_order_detail" ("pay_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_help_order_detail_idx_helpid_yyyymmdd" ON "xm_bulky_help_order_detail" ("help_id", "yyyy_mm_dd");
CREATE INDEX IF NOT EXISTS "xm_bulky_home_page_idx_appid_showtype" ON "xm_bulky_home_page" ("app_id", "show_type");
CREATE INDEX IF NOT EXISTS "xm_bulky_inspection_idx_date_assigned_status" ON "xm_bulky_inspection" ("date", "assigned_user_id", "status");
CREATE INDEX IF NOT EXISTS "xm_bulky_inspection_idx_date_shelf_sub_shelf" ON "xm_bulky_inspection" ("date", "shelf_sn", "sub_shelf_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_inspection_idx_focus_quality_mark_id" ON "xm_bulky_inspection" ("focus_quality_mark_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_inspection_idx_focus_quality_shelf" ON "xm_bulky_inspection" ("date", "shelf_sn", "sub_shelf_sn", "focus_quality_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_inspection_assign_snapshot_idx_round_leader" ON "xm_bulky_inspection_assign_snapshot" ("round_no", "leader_flag");
CREATE INDEX IF NOT EXISTS "xm_bulky_inspection_assign_user_idx_status_user" ON "xm_bulky_inspection_assign_user" ("status", "user_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_inspection_assign_user_idx_status_attendance_status" ON "xm_bulky_inspection_assign_user" ("status", "attendance_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_inspection_attendance_log_idx_user_time" ON "xm_bulky_inspection_attendance_log" ("user_id", "create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_inspection_attendance_log_idx_batch_no" ON "xm_bulky_inspection_attendance_log" ("batch_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_inspection_focus_mark_idx_round_status_generate" ON "xm_bulky_inspection_focus_mark" ("round_no", "status", "generate_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_inspection_focus_mark_idx_shelf" ON "xm_bulky_inspection_focus_mark" ("round_no", "shelf_sn", "sub_shelf_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_inspection_video_record_idx_snapshot_id" ON "xm_bulky_inspection_video_record" ("snapshot_id", "id");
CREATE INDEX IF NOT EXISTS "xm_bulky_invoice_order_idx_pid_tel_ordersn" ON "xm_bulky_invoice_order" ("purchaser_id", "receive_tel", "order_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_invoice_quota_log_idx_target" ON "xm_bulky_invoice_quota_log" ("target_type", "target_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_invoice_quota_log_idx_create_time" ON "xm_bulky_invoice_quota_log" ("create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_invoice_record_idx_purchaserid" ON "xm_bulky_invoice_record" ("purchaser_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_invoice_registration_idx_purchaser_id" ON "xm_bulky_invoice_registration" ("purchaser_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_invoice_registration_idx_status" ON "xm_bulky_invoice_registration" ("status");
CREATE INDEX IF NOT EXISTS "xm_bulky_invoice_registration_idx_create_time" ON "xm_bulky_invoice_registration" ("create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_invoice_request_idx_purchaser_id" ON "xm_bulky_invoice_request" ("purchaser_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_invoice_request_idx_supplier_id" ON "xm_bulky_invoice_request" ("supplier_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_invoice_request_idx_status" ON "xm_bulky_invoice_request" ("status");
CREATE INDEX IF NOT EXISTS "xm_bulky_invoice_request_idx_deadline" ON "xm_bulky_invoice_request" ("deadline");
CREATE INDEX IF NOT EXISTS "xm_bulky_invoice_request_idx_registration_id" ON "xm_bulky_invoice_request" ("registration_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_invoice_request_idx_parent_id" ON "xm_bulky_invoice_request" ("parent_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_invoice_request_idx_create_time" ON "xm_bulky_invoice_request" ("create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_invoice_request_idx_application_id" ON "xm_bulky_invoice_request" ("application_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_invoice_title_idx_purchaser_id" ON "xm_bulky_invoice_title" ("purchaser_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_invoice_title_idx_data_status" ON "xm_bulky_invoice_title" ("data_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_invoice_upload_log_idx_invoice_request_id" ON "xm_bulky_invoice_upload_log" ("invoice_request_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_invoice_upload_log_idx_supplier_id" ON "xm_bulky_invoice_upload_log" ("supplier_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_late_pay_refund_idx_order_sn" ON "xm_bulky_late_pay_refund" ("order_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_limit_distribution_cancel_log_idx_enter_item_id" ON "xm_bulky_limit_distribution_cancel_log" ("enter_item_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_limit_distribution_cancel_log_idx_order_item_id" ON "xm_bulky_limit_distribution_cancel_log" ("order_item_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_limit_distribution_cancel_log_idx_supplier_id" ON "xm_bulky_limit_distribution_cancel_log" ("supplier_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_login_jpush_create_time" ON "xm_bulky_login_jpush" ("create_time", "status");
CREATE INDEX IF NOT EXISTS "xm_bulky_logistics_activity_region_idx_activityid" ON "xm_bulky_logistics_activity_region" ("activity_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_logistics_config_template_mapping_idx_template_id" ON "xm_bulky_logistics_config_template_mapping" ("template_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_logistics_config_template_mapping_idx_data_status" ON "xm_bulky_logistics_config_template_mapping" ("data_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_logistics_config_template_mapping_uk_config_id" ON "xm_bulky_logistics_config_template_mapping" ("config_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_logistics_cost_config_idx_name" ON "xm_bulky_logistics_cost_config" ("logistics_name");
CREATE INDEX IF NOT EXISTS "xm_bulky_logistics_cost_region_idx_config_id" ON "xm_bulky_logistics_cost_region" ("config_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_logistics_cost_region_idx_adcode_data_status" ON "xm_bulky_logistics_cost_region" ("adcode", "data_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_logistics_cost_region_idx_config_effective" ON "xm_bulky_logistics_cost_region" ("config_id", "is_enable", "data_status", "start_round_no", "end_round_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_logistics_fail_record_idx_send_no" ON "xm_bulky_logistics_fail_record" ("send_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_logistics_fail_record_idx_logistics_no" ON "xm_bulky_logistics_fail_record" ("logistics_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_logistics_fail_record_idx_type" ON "xm_bulky_logistics_fail_record" ("type");
CREATE INDEX IF NOT EXISTS "xm_bulky_logistics_fail_record_idx_create_time" ON "xm_bulky_logistics_fail_record" ("create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_logistics_order_idx_logisticsno" ON "xm_bulky_logistics_order" ("logistics_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_logistics_order_idx_sendno_mailno" ON "xm_bulky_logistics_order" ("send_no", "mail_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_logistics_order_idx_mailno" ON "xm_bulky_logistics_order" ("mail_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_logistics_order_idx_logistics_mail_config" ON "xm_bulky_logistics_order" ("mail_no", "config_id", "status", "data_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_logistics_order_detail_idx_logisticsno" ON "xm_bulky_logistics_order_detail" ("logistics_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_logistics_remind_push_log_idx_push_date" ON "xm_bulky_logistics_remind_push_log" ("push_date");
CREATE INDEX IF NOT EXISTS "xm_bulky_logistics_remind_task_idx_status_data" ON "xm_bulky_logistics_remind_task" ("status", "data_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_logistics_remind_task_idx_create_time" ON "xm_bulky_logistics_remind_task" ("create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_logistics_template_idx_data_status" ON "xm_bulky_logistics_template" ("data_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_main_account_idx_name_status" ON "xm_bulky_main_account" ("nickname", "data_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_mall_vip_order_idx_buytime" ON "xm_bulky_mall_vip_order" ("buy_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_mall_vip_order_idx_wareid" ON "xm_bulky_mall_vip_order" ("ware_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_mall_vip_order_idx_purchaserid" ON "xm_bulky_mall_vip_order" ("purchaser_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_mall_vip_user_idx_purchaserid" ON "xm_bulky_mall_vip_user" ("purchaser_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_mall_vip_user_idx_wareid" ON "xm_bulky_mall_vip_user" ("ware_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_nfc_idx_sn" ON "xm_bulky_nfc" ("sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_notice_idx_appid_sortnum" ON "xm_bulky_notice" ("app_id", "sort_num");
CREATE INDEX IF NOT EXISTS "xm_bulky_notice_read_notice_id" ON "xm_bulky_notice_read" ("notice_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_onsale_statistics_idx_ctime" ON "xm_bulky_onsale_statistics" ("create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_open_access_idx_app_id" ON "xm_bulky_open_access" ("app_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_operation_log_idx_operation_type" ON "xm_bulky_operation_log" ("operation_type");
CREATE INDEX IF NOT EXISTS "xm_bulky_operation_log_idx_createtime_userid_usertype" ON "xm_bulky_operation_log" ("create_time", "operator_id", "user_type");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_idx_send_no" ON "xm_bulky_order" ("send_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_idx_create_time" ON "xm_bulky_order" ("create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_idx_roundno_paytime_ordersn" ON "xm_bulky_order" ("round_no", "wx_pay_time", "order_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_idx_tel_ordersn_wareid" ON "xm_bulky_order" ("receive_tel", "order_sn", "ware_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_idx_is_sale_agency" ON "xm_bulky_order" ("is_sale_agency");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_idx_wxpaytime_ordersn" ON "xm_bulky_order" ("wx_pay_time", "order_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_idx_zone_shelf" ON "xm_bulky_order" ("zone_shelf");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_idx_wareid_ptime_ostatus" ON "xm_bulky_order" ("ware_id", "wx_pay_time", "order_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_idx_partnerid_ordersn" ON "xm_bulky_order" ("partner_id", "order_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_idx_helpid_roundno_status" ON "xm_bulky_order" ("help_id", "round_no", "order_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_idx_ordersn_wxpaytime" ON "xm_bulky_order" ("order_sn", "wx_pay_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_idx_roundno_wareid_sendno" ON "xm_bulky_order" ("round_no", "ware_id", "send_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_idx_ostatus_rno_osn" ON "xm_bulky_order" ("order_status", "round_no", "order_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_idx_shelfsn_wxpaytime_orderstatus" ON "xm_bulky_order" ("shelf_sn", "wx_pay_time", "order_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_idx_receivename" ON "xm_bulky_order" ("receive_name");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_idx_puid_wid_pid_os" ON "xm_bulky_order" ("purchaser_id", "ware_id", "partner_id", "order_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_idx_wxpaytime_orderstatus" ON "xm_bulky_order" ("wx_pay_time", "order_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_idx_wxpaytime_receiveaddress_orderstatus" ON "xm_bulky_order" ("wx_pay_time", "receive_address", "order_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_idx_ordersn_roundno_orderstatus" ON "xm_bulky_order" ("order_sn", "round_no", "order_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_idx_rno_ostatus_createtime_or" ON "xm_bulky_order" ("round_no", "order_status", "create_time", "order_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_idx_tel_paytime_ostatus" ON "xm_bulky_order" ("receive_tel", "wx_pay_time", "order_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_order111_idx_send_no" ON "xm_bulky_order111" ("send_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_order111_idx_create_time" ON "xm_bulky_order111" ("create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_order111_idx_roundno_paytime_ordersn" ON "xm_bulky_order111" ("round_no", "wx_pay_time", "order_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_order111_idx_tel_ordersn_wareid" ON "xm_bulky_order111" ("receive_tel", "order_sn", "ware_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_order111_idx_is_sale_agency" ON "xm_bulky_order111" ("is_sale_agency");
CREATE INDEX IF NOT EXISTS "xm_bulky_order111_idx_wxpaytime_ordersn" ON "xm_bulky_order111" ("wx_pay_time", "order_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_order111_idx_zone_shelf" ON "xm_bulky_order111" ("zone_shelf");
CREATE INDEX IF NOT EXISTS "xm_bulky_order111_idx_wareid_ptime_ostatus" ON "xm_bulky_order111" ("ware_id", "wx_pay_time", "order_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_order111_idx_ordersn_wxpaytime" ON "xm_bulky_order111" ("order_sn", "wx_pay_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_order111_idx_roundno_wareid_sendno" ON "xm_bulky_order111" ("round_no", "ware_id", "send_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_order111_idx_partnerid_ordersn" ON "xm_bulky_order111" ("partner_id", "order_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_order111_idx_ostatus_rno_osn" ON "xm_bulky_order111" ("order_status", "round_no", "order_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_order111_idx_shelfsn_wxpaytime_orderstatus" ON "xm_bulky_order111" ("shelf_sn", "wx_pay_time", "order_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_order111_idx_receivename" ON "xm_bulky_order111" ("receive_name");
CREATE INDEX IF NOT EXISTS "xm_bulky_order111_idx_helpid_roundno_status" ON "xm_bulky_order111" ("help_id", "round_no", "order_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_order111_idx_puid_wid_pid_os" ON "xm_bulky_order111" ("purchaser_id", "ware_id", "partner_id", "order_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_order111_idx_wxpaytime_orderstatus" ON "xm_bulky_order111" ("wx_pay_time", "order_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_order111_idx_wxpaytime_receiveaddress_orderstatus" ON "xm_bulky_order111" ("wx_pay_time", "receive_address", "order_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_order111_idx_ordersn_roundno_orderstatus" ON "xm_bulky_order111" ("order_sn", "round_no", "order_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_order111_idx_rno_ostatus_createtime_or" ON "xm_bulky_order111" ("round_no", "order_status", "create_time", "order_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_order22_idx_send_no" ON "xm_bulky_order22" ("send_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_order22_idx_create_time" ON "xm_bulky_order22" ("create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_order22_idx_purchaserid_wareid" ON "xm_bulky_order22" ("purchaser_id", "ware_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_order22_idx_roundno_paytime_ordersn" ON "xm_bulky_order22" ("round_no", "wx_pay_time", "order_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_order22_idx_tel_ordersn_wareid" ON "xm_bulky_order22" ("receive_tel", "order_sn", "ware_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_order22_idx_is_sale_agency" ON "xm_bulky_order22" ("is_sale_agency");
CREATE INDEX IF NOT EXISTS "xm_bulky_order22_idx_wxpaytime_ordersn" ON "xm_bulky_order22" ("wx_pay_time", "order_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_order22_idx_zone_shelf" ON "xm_bulky_order22" ("zone_shelf");
CREATE INDEX IF NOT EXISTS "xm_bulky_order22_idx_wareid_ptime_ostatus" ON "xm_bulky_order22" ("ware_id", "wx_pay_time", "order_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_order22_idx_partnerid_ordersn" ON "xm_bulky_order22" ("partner_id", "order_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_order22_idx_helpid_roundno_status" ON "xm_bulky_order22" ("help_id", "round_no", "order_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_comment_idx_purchaser_id" ON "xm_bulky_order_comment" ("purchaser_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_edit_idx_ordersn" ON "xm_bulky_order_edit" ("order_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_edit_idx_field_ordersn" ON "xm_bulky_order_edit" ("field", "order_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_info_idx_sendno" ON "xm_bulky_order_info" ("send_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_item_idx_order_sn" ON "xm_bulky_order_item" ("order_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_item_idx_supplier_id" ON "xm_bulky_order_item" ("supplier_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_item_idx_create_time" ON "xm_bulky_order_item" ("create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_item_idx_roundno" ON "xm_bulky_order_item" ("round_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_item_idx_sid_rno_osn" ON "xm_bulky_order_item" ("supplier_id", "round_no", "order_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_item_idx_round_product_user" ON "xm_bulky_order_item" ("round_no", "product_id", "purchaser_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_item_comment_idx_order_sn" ON "xm_bulky_order_item_comment" ("order_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_item_comment_idx_cmtime" ON "xm_bulky_order_item_comment" ("comment_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_item_comment_idx_productid_isshow_commenttime" ON "xm_bulky_order_item_comment" ("product_id", "is_show", "comment_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_item_comment_idx_supplierid_type_commenttime" ON "xm_bulky_order_item_comment" ("supplier_id", "type", "comment_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_item_comment_idx_app_status_show_type_time_product" ON "xm_bulky_order_item_comment" ("app_id", "data_status", "is_show", "type", "comment_time", "product_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_item_comment_idx_supplierid_isshow_commenttime" ON "xm_bulky_order_item_comment" ("supplier_id", "is_show", "comment_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_item_comment_idx_pr_ty_ct_dt" ON "xm_bulky_order_item_comment" ("purchaser_id", "type", "comment_time", "data_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_item_comment_idx_purchaserid_commenttime" ON "xm_bulky_order_item_comment" ("purchaser_id", "comment_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_local_idx_purchaser_id" ON "xm_bulky_order_local" ("purchaser_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_local_idx_send_no" ON "xm_bulky_order_local" ("send_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_local_idx_wx_pay_time" ON "xm_bulky_order_local" ("wx_pay_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_log_idx_order_sn" ON "xm_bulky_order_log" ("order_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_log_idx_time" ON "xm_bulky_order_log" ("time");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_paid_idx_order_sn" ON "xm_bulky_order_paid" ("order_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_reconciliation_idx_payment_no" ON "xm_bulky_order_reconciliation" ("payment_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_reconciliation_idx_business_time" ON "xm_bulky_order_reconciliation" ("business_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_reconciliation_idx_order_sn" ON "xm_bulky_order_reconciliation" ("order_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_reconciliation_idx_statement_date" ON "xm_bulky_order_reconciliation" ("statement_date");
CREATE INDEX IF NOT EXISTS "xm_bulky_order_remark_history_idx_purchaser_id" ON "xm_bulky_order_remark_history" ("purchaser_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_package_box_modify_record_idx_round_shelf" ON "xm_bulky_package_box_modify_record" ("round_no", "shelf_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_package_box_modify_record_idx_package_id" ON "xm_bulky_package_box_modify_record" ("package_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_package_box_modify_record_idx_operate_user_id" ON "xm_bulky_package_box_modify_record" ("operate_user_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_package_deadline_snapshot_idx_round_leader_update" ON "xm_bulky_package_deadline_snapshot" ("round_no", "leader_id", "update_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_package_modify_record_idx_round_shelf" ON "xm_bulky_package_modify_record" ("round_no", "shelf_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_package_modify_record_idx_package_id" ON "xm_bulky_package_modify_record" ("package_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_package_modify_record_idx_operate_user_id" ON "xm_bulky_package_modify_record" ("operate_user_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_package_modify_record_idx_sendno" ON "xm_bulky_package_modify_record" ("send_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_package_volume_compare_idx_round_shelf" ON "xm_bulky_package_volume_compare" ("round_no", "shelf_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_part_logistics_idx_date" ON "xm_bulky_part_logistics" ("date");
CREATE INDEX IF NOT EXISTS "xm_bulky_part_logistics_idx_startTime" ON "xm_bulky_part_logistics" ("start_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_part_logistics_log_idx_pid" ON "xm_bulky_part_logistics_log" ("part_logistics_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_phone_change_log_idx_phone_change_purchaser_time" ON "xm_bulky_phone_change_log" ("purchaser_id", "create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_phone_change_log_idx_phone_change_old_phone_hash" ON "xm_bulky_phone_change_log" ("old_phone_hash");
CREATE INDEX IF NOT EXISTS "xm_bulky_phone_change_log_idx_phone_change_operator_time" ON "xm_bulky_phone_change_log" ("operator_type", "operator_id", "create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_platform_bind_idx_purchaser_id" ON "xm_bulky_platform_bind" ("purchaser_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_platform_bind_idx_open_id" ON "xm_bulky_platform_bind" ("open_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_platform_invoice_idx_purchaser_id" ON "xm_bulky_platform_invoice" ("purchaser_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_platform_invoice_idx_invoice_type" ON "xm_bulky_platform_invoice" ("invoice_type");
CREATE INDEX IF NOT EXISTS "xm_bulky_platform_invoice_idx_status" ON "xm_bulky_platform_invoice" ("status");
CREATE INDEX IF NOT EXISTS "xm_bulky_platform_invoice_idx_create_time" ON "xm_bulky_platform_invoice" ("create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_price_mgr_log_idx_second_id_rank_num" ON "xm_bulky_price_mgr_log" ("second_id", "rank_num");
CREATE INDEX IF NOT EXISTS "xm_bulky_price_operation_log_idx_operator_time" ON "xm_bulky_price_operation_log" ("operator_id", "create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_price_operation_log_idx_create_time" ON "xm_bulky_price_operation_log" ("create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_price_rule_idx_name" ON "xm_bulky_price_rule" ("name");
CREATE INDEX IF NOT EXISTS "xm_bulky_price_rule_idx_data_status" ON "xm_bulky_price_rule" ("data_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_price_strategy_idx_type_status" ON "xm_bulky_price_strategy" ("strategy_type", "status", "data_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_price_strategy_idx_rule_id" ON "xm_bulky_price_strategy" ("rule_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_price_strategy_target_idx_target" ON "xm_bulky_price_strategy_target" ("target_type", "target_code");
CREATE INDEX IF NOT EXISTS "xm_bulky_print_logistics_config_idx_print_logistics_id" ON "xm_bulky_print_logistics_config" ("print_logistics_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_product_idx_rank_num" ON "xm_bulky_product" ("rank_num");
CREATE INDEX IF NOT EXISTS "xm_bulky_product_idx_supplierid_firstid" ON "xm_bulky_product" ("supplier_id", "first_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_product_idx_quflag" ON "xm_bulky_product" ("quality_flag");
CREATE INDEX IF NOT EXISTS "xm_bulky_product_idx_product_status" ON "xm_bulky_product" ("product_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_product_idx_prefer" ON "xm_bulky_product" ("is_prefer", "sell_prefer");
CREATE INDEX IF NOT EXISTS "xm_bulky_product_idx_sid_ps_ds_pt_expt" ON "xm_bulky_product" ("second_id", "product_status", "data_status", "product_type", "expire_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_product_idx_supplierid_createtime_secondid" ON "xm_bulky_product" ("supplier_id", "create_time", "second_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_product_idx_createtime_status_supplierid" ON "xm_bulky_product" ("create_time", "product_status", "supplier_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_product_idx_supplier_status_data_expire_stock_show" ON "xm_bulky_product" ("supplier_id", "product_status", "data_status", "expire_time", "remain_stock", "sell_count", "show_flag");
CREATE INDEX IF NOT EXISTS "xm_bulky_product_comment_score_daily_idx_date" ON "xm_bulky_product_comment_score_daily" ("score_date");
CREATE INDEX IF NOT EXISTS "xm_bulky_product_daily_sell_idx_round_no" ON "xm_bulky_product_daily_sell" ("round_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_product_daily_sell_idx_supplier_id" ON "xm_bulky_product_daily_sell" ("supplier_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_product_daily_sell_idx_supplier_tag" ON "xm_bulky_product_daily_sell" ("supplier_tag");
CREATE INDEX IF NOT EXISTS "xm_bulky_product_info_idx_utime" ON "xm_bulky_product_info" ("update_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_product_info_idx_positive_rating_product" ON "xm_bulky_product_info" ("positive_rating_flag", "product_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_product_log_idx_createtime_supplierid_productid" ON "xm_bulky_product_log" ("create_time", "supplier_id", "product_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_product_log_idx_type_supplier_time" ON "xm_bulky_product_log" ("type", "supplier_id", "create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_product_log_idx_productid_supplierid" ON "xm_bulky_product_log" ("product_id", "supplier_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_product_log_idx_supplierid" ON "xm_bulky_product_log" ("supplier_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_product_quality_parameter_idx_supplier_round" ON "xm_bulky_product_quality_parameter" ("supplier_id", "round_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_product_quality_parameter_idx_product_round" ON "xm_bulky_product_quality_parameter" ("product_id", "round_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_product_quality_record_uk_roundno_pid" ON "xm_bulky_product_quality_record" ("round_no", "product_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_product_repurchase_stats_idx_stat_second_repurchase_product" ON "xm_bulky_product_repurchase_stats" ("stat_date", "second_id", "repurchase_count", "product_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_product_sale_parameter_idx_pid" ON "xm_bulky_product_sale_parameter" ("product_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_product_sale_parameter2_idx_pid" ON "xm_bulky_product_sale_parameter2" ("product_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_product_sell_record_idx_product_id" ON "xm_bulky_product_sell_record" ("product_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_product_sell_record_idx_date" ON "xm_bulky_product_sell_record" ("start_date");
CREATE INDEX IF NOT EXISTS "xm_bulky_product_subsidy_idx_config_second_rank" ON "xm_bulky_product_subsidy" ("config_id", "second_id", "rank_num");
CREATE INDEX IF NOT EXISTS "xm_bulky_product_subsidy_idx_second_rank" ON "xm_bulky_product_subsidy" ("second_id", "rank_num");
CREATE INDEX IF NOT EXISTS "xm_bulky_product_subsidy_idx_app_id" ON "xm_bulky_product_subsidy" ("app_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_product_subsidy_idx_config_id" ON "xm_bulky_product_subsidy" ("config_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_product_task_idx_product_id" ON "xm_bulky_product_task" ("product_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_product_task_idx_task_time_str" ON "xm_bulky_product_task" ("task_time_str");
CREATE INDEX IF NOT EXISTS "xm_bulky_product_template_idx_second_id" ON "xm_bulky_product_template" ("second_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_product_template_idx_rank_num" ON "xm_bulky_product_template" ("rank_num");
CREATE INDEX IF NOT EXISTS "xm_bulky_product_video_idx_utime" ON "xm_bulky_product_video" ("update_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_product_video_idx_second_status_exp_product" ON "xm_bulky_product_video" ("second_id", "status", "expires_time", "product_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_product_video_idx_supplier_status_exp_product" ON "xm_bulky_product_video" ("supplier_id", "status", "expires_time", "product_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_product_video_idx_product_id" ON "xm_bulky_product_video" ("product_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_product_video_idx_status_expirestime" ON "xm_bulky_product_video" ("status", "expires_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_purchaser_idx_xm_account" ON "xm_bulky_purchaser" ("xm_account");
CREATE INDEX IF NOT EXISTS "xm_bulky_purchaser_idx_helpid" ON "xm_bulky_purchaser" ("help_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_purchaser_idx_ctime" ON "xm_bulky_purchaser" ("create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_purchaser_idx_appid_ctime" ON "xm_bulky_purchaser" ("app_id", "create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_purchaser_idx_ftime" ON "xm_bulky_purchaser" ("first_buy_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_purchaser_account_log_idx_purchaser_id" ON "xm_bulky_purchaser_account_log" ("purchaser_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_purchaser_address_idx_user_id" ON "xm_bulky_purchaser_address" ("user_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_purchaser_authorize_idx_purchaser_id_token" ON "xm_bulky_purchaser_authorize" ("purchaser_id", "token");
CREATE INDEX IF NOT EXISTS "xm_bulky_purchaser_bk04261133_idx_open_id" ON "xm_bulky_purchaser_bk04261133" ("open_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_purchaser_bk04261133_idx_xm_account" ON "xm_bulky_purchaser_bk04261133" ("xm_account");
CREATE INDEX IF NOT EXISTS "xm_bulky_purchaser_bk04261133_idx_helpid" ON "xm_bulky_purchaser_bk04261133" ("help_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_purchaser_bk04261133_idx_ctime" ON "xm_bulky_purchaser_bk04261133" ("create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_purchaser_bk04261133_idx_mamonth_buy" ON "xm_bulky_purchaser_bk04261133" ("ma_month_buy_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_purchaser_bk04261133_idx_appid_ctime" ON "xm_bulky_purchaser_bk04261133" ("app_id", "create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_purchaser_bk06301850_idx_open_id" ON "xm_bulky_purchaser_bk06301850" ("open_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_purchaser_bk06301850_idx_xm_account" ON "xm_bulky_purchaser_bk06301850" ("xm_account");
CREATE INDEX IF NOT EXISTS "xm_bulky_purchaser_bk06301850_idx_helpid" ON "xm_bulky_purchaser_bk06301850" ("help_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_purchaser_bk06301850_idx_ctime" ON "xm_bulky_purchaser_bk06301850" ("create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_purchaser_bk06301850_idx_mamonth_buy" ON "xm_bulky_purchaser_bk06301850" ("ma_month_buy_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_purchaser_bk06301850_idx_appid_ctime" ON "xm_bulky_purchaser_bk06301850" ("app_id", "create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_purchaser_bk06301850_idx_ftime_app_hid" ON "xm_bulky_purchaser_bk06301850" ("first_buy_time", "app_id", "help_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_purchaser_contact_supplier_idx_user_supplier_id" ON "xm_bulky_purchaser_contact_supplier" ("user_id", "supplier_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_purchaser_invoice_application_idx_purchaser_id" ON "xm_bulky_purchaser_invoice_application" ("purchaser_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_purchaser_invoice_application_idx_status" ON "xm_bulky_purchaser_invoice_application" ("status");
CREATE INDEX IF NOT EXISTS "xm_bulky_purchaser_invoice_application_idx_create_time" ON "xm_bulky_purchaser_invoice_application" ("create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_purchaser_invoice_application_order_idx_application_id" ON "xm_bulky_purchaser_invoice_application_order" ("application_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_purchaser_invoice_application_order_idx_order_sn" ON "xm_bulky_purchaser_invoice_application_order" ("order_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_purchaser_tag_idx_tagid" ON "xm_bulky_purchaser_tag" ("tag_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_quality_punish_sms_record_idx_submit_status_create_time" ON "xm_bulky_quality_punish_sms_record" ("submit_status", "create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_receipt_application_idx_purchaser_id" ON "xm_bulky_receipt_application" ("purchaser_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_receipt_application_idx_purchaser_phone" ON "xm_bulky_receipt_application" ("purchaser_phone");
CREATE INDEX IF NOT EXISTS "xm_bulky_receipt_application_idx_apply_time" ON "xm_bulky_receipt_application" ("apply_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_receipt_application_idx_status" ON "xm_bulky_receipt_application" ("status");
CREATE INDEX IF NOT EXISTS "xm_bulky_receipt_application_item_idx_receipt_id" ON "xm_bulky_receipt_application_item" ("receipt_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_receipt_application_item_idx_order_sn" ON "xm_bulky_receipt_application_item" ("order_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_receipt_application_item_idx_supplier_id" ON "xm_bulky_receipt_application_item" ("supplier_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_receipt_application_order_idx_receipt_id" ON "xm_bulky_receipt_application_order" ("receipt_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_receipt_application_order_idx_purchaser_id" ON "xm_bulky_receipt_application_order" ("purchaser_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_receipt_operation_log_idx_receipt_id" ON "xm_bulky_receipt_operation_log" ("receipt_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_receipt_operation_log_idx_receipt_no" ON "xm_bulky_receipt_operation_log" ("receipt_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_receipt_operation_log_idx_create_time" ON "xm_bulky_receipt_operation_log" ("create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_refund_idx_createtime_purchaserid" ON "xm_bulky_refund" ("create_time", "purchaser_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_refund_idx_wareid_datastatus" ON "xm_bulky_refund" ("ware_id", "data_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_refund_idx_ordersn_status" ON "xm_bulky_refund" ("order_sn", "data_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_refund_idx_cdate_pid" ON "xm_bulky_refund" ("create_date", "purchaser_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_refund_idx_pid_status_ctime" ON "xm_bulky_refund" ("partner_id", "data_status", "create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_refund_idx_wxpaytime" ON "xm_bulky_refund" ("wx_pay_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_refund_idx_handle_astatus_rtype_reason_bear" ON "xm_bulky_refund" ("handle_time", "apply_status", "refund_type", "reason_type", "supplier_bear_price");
CREATE INDEX IF NOT EXISTS "xm_bulky_refund_idx_status_handle_supplier" ON "xm_bulky_refund" ("refund_status", "data_status", "handle_time", "supplier_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_refund_duty_idx_refundid" ON "xm_bulky_refund_duty" ("refund_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_refund_duty_idx_createtime" ON "xm_bulky_refund_duty" ("create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_refund_item_idx_order_item_id" ON "xm_bulky_refund_item" ("order_item_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_refund_item_idx_createtime" ON "xm_bulky_refund_item" ("create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_refund_log_idx_rid" ON "xm_bulky_refund_log" ("refund_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_refund_log_idx_ordersn" ON "xm_bulky_refund_log" ("order_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_refund_picture_idx_pic_url" ON "xm_bulky_refund_picture" ("pic_url", "data_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_refund_picture_idx_refund" ON "xm_bulky_refund_picture" ("record_type", "refund_source", "refund_id", "data_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_refund_picture_idx_user_md5_time" ON "xm_bulky_refund_picture" ("record_type", "purchaser_id", "pic_md5", "apply_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_refund_picture_idx_similar_result" ON "xm_bulky_refund_picture" ("record_type", "purchaser_id", "apply_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_refund_picture_idx_user_product_time" ON "xm_bulky_refund_picture" ("record_type", "purchaser_id", "product_name", "data_status", "apply_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_refund_statistics_round_no" ON "xm_bulky_refund_statistics" ("round_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_region_extra_idx_adcode" ON "xm_bulky_region_extra" ("adcode");
CREATE INDEX IF NOT EXISTS "xm_bulky_region_extra_idx_type_parent_id" ON "xm_bulky_region_extra" ("type", "parent_region_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_remit_idx_ordersn" ON "xm_bulky_remit" ("order_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_replenish_log_idx_replenishid" ON "xm_bulky_replenish_log" ("replenish_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_restock_log_idx_round" ON "xm_bulky_restock_log" ("round_no", "zone");
CREATE INDEX IF NOT EXISTS "xm_bulky_restock_order_idx_roundNo" ON "xm_bulky_restock_order" ("round_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_sale_limit_rule_idx_second_id" ON "xm_bulky_sale_limit_rule" ("second_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_sale_limit_rule_idx_first_id_status" ON "xm_bulky_sale_limit_rule" ("first_id", "data_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_sale_limit_rule_white_idx_rule_id" ON "xm_bulky_sale_limit_rule_white" ("rule_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_sale_limit_rule_white_idx_supplier_id" ON "xm_bulky_sale_limit_rule_white" ("supplier_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_sale_statistics_idx_yyyy_mm_dd" ON "xm_bulky_sale_statistics" ("yyyy_mm_dd");
CREATE INDEX IF NOT EXISTS "xm_bulky_search_history_idx_content" ON "xm_bulky_search_history" ("content");
CREATE INDEX IF NOT EXISTS "xm_bulky_search_history_idx_search_rank_stat" ON "xm_bulky_search_history" ("app_id", "type", "create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_second_confirm_idx_punish" ON "xm_bulky_second_confirm" ("punish_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_second_confirm_idx_eid" ON "xm_bulky_second_confirm" ("enter_item_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_second_star_idx_purchaser_id" ON "xm_bulky_second_star" ("purchaser_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_second_subsidy_idx_secondid_ranknum" ON "xm_bulky_second_subsidy" ("second_id", "rank_num");
CREATE INDEX IF NOT EXISTS "xm_bulky_second_subsidy_idx_config_second_rank" ON "xm_bulky_second_subsidy" ("config_id", "second_id", "rank_num");
CREATE INDEX IF NOT EXISTS "xm_bulky_second_subsidy_config_idx_status" ON "xm_bulky_second_subsidy_config" ("status", "data_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_second_subsidy_config_idx_subsidy_type" ON "xm_bulky_second_subsidy_config" ("subsidy_type", "data_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_second_subsidy_config_app_idx_config_id" ON "xm_bulky_second_subsidy_config_app" ("config_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_second_subsidy_config_app_idx_appid_alive" ON "xm_bulky_second_subsidy_config_app" ("app_id", "data_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_second_subsidy_config_city_idx_config_id" ON "xm_bulky_second_subsidy_config_city" ("config_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_second_subsidy_new_idx_secondid_ranknum" ON "xm_bulky_second_subsidy_new" ("second_id", "rank_num");
CREATE INDEX IF NOT EXISTS "xm_bulky_second_subsidy_rule_idx_name_data_status" ON "xm_bulky_second_subsidy_rule" ("name", "data_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_send_order_idx_create_time" ON "xm_bulky_send_order" ("create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_send_order_idx_roundno_wareid_shelfsn" ON "xm_bulky_send_order" ("round_no", "ware_id", "shelf_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_send_order_idx_purchaserid_roundno" ON "xm_bulky_send_order" ("purchaser_id", "round_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_send_order_idx_receivetel_roundno" ON "xm_bulky_send_order" ("receive_tel", "round_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_send_order_idx_roundno_help_id_status" ON "xm_bulky_send_order" ("round_no", "help_id", "new_buyer", "send_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_send_order_idx_zone_shelf" ON "xm_bulky_send_order" ("zone_shelf");
CREATE INDEX IF NOT EXISTS "xm_bulky_send_order_idx_reconcile_sub_bill" ON "xm_bulky_send_order" ("reconcile_sub_bill_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_send_order_coin_refund_idx_send_no" ON "xm_bulky_send_order_coin_refund" ("send_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_sf_logistics_config_idx_data_status" ON "xm_bulky_sf_logistics_config" ("data_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_shelf_package_status_idx_shelf_sn" ON "xm_bulky_shelf_package_status" ("shelf_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_standard_price_idx_second_id" ON "xm_bulky_standard_price" ("second_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_standard_price_idx_rank_num" ON "xm_bulky_standard_price" ("rank_num");
CREATE INDEX IF NOT EXISTS "xm_bulky_sub_account_idx_user_name" ON "xm_bulky_sub_account" ("user_name");
CREATE INDEX IF NOT EXISTS "xm_bulky_sub_account_idx_sid" ON "xm_bulky_sub_account" ("supplier_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_sub_account_idx_jobnumber" ON "xm_bulky_sub_account" ("job_number");
CREATE INDEX IF NOT EXISTS "xm_bulky_sub_account_idx_phone" ON "xm_bulky_sub_account" ("phone");
CREATE INDEX IF NOT EXISTS "xm_bulky_suggestion_idx_type" ON "xm_bulky_suggestion" ("type");
CREATE INDEX IF NOT EXISTS "xm_bulky_suggestion_idx_user_id" ON "xm_bulky_suggestion" ("user_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_suggestion_idx_cTime_source" ON "xm_bulky_suggestion" ("create_time", "source");
CREATE INDEX IF NOT EXISTS "xm_bulky_suggestion_product_snapshot_idx_product_id" ON "xm_bulky_suggestion_product_snapshot" ("product_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_idx_wx_open_id" ON "xm_bulky_supplier" ("wx_open_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_idx_thirdshopid" ON "xm_bulky_supplier" ("third_shop_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier111_idx_wx_open_id" ON "xm_bulky_supplier111" ("wx_open_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier111_idx_thirdshopid" ON "xm_bulky_supplier111" ("third_shop_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier1_copy1_idx_wx_open_id" ON "xm_bulky_supplier1_copy1" ("wx_open_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier1_copy1_idx_thirdshopid" ON "xm_bulky_supplier1_copy1" ("third_shop_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier2_idx_wx_open_id" ON "xm_bulky_supplier2" ("wx_open_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier2_idx_thirdshopid" ON "xm_bulky_supplier2" ("third_shop_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_account_idx_supplier_id" ON "xm_bulky_supplier_account" ("supplier_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_account_idx_account_no" ON "xm_bulky_supplier_account" ("account_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_account_change_idx_type" ON "xm_bulky_supplier_account_change" ("type");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_account_change_idx_createtime_supplierid" ON "xm_bulky_supplier_account_change" ("create_time", "supplier_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_account_change_idx_ordersn_supplierid" ON "xm_bulky_supplier_account_change" ("order_sn", "supplier_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_account_change_idx_supplierid_ctime_type" ON "xm_bulky_supplier_account_change" ("supplier_id", "create_time", "type");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_account_change_idx_supplierid_ctime" ON "xm_bulky_supplier_account_change" ("supplier_id", "create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_account_change_yhj_idx_supplier_id" ON "xm_bulky_supplier_account_change_yhj" ("supplier_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_account_change_yhj_idx_type" ON "xm_bulky_supplier_account_change_yhj" ("type");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_account_change_yhj_idx_createtime_supplierid" ON "xm_bulky_supplier_account_change_yhj" ("create_time", "supplier_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_account_change_yhj_idx_ordersn_supplierid" ON "xm_bulky_supplier_account_change_yhj" ("order_sn", "supplier_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_account_change_yhj_idx_roundno_type_sid_money" ON "xm_bulky_supplier_account_change_yhj" ("round_no", "type", "supplier_id", "money");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_account_log_idx_order_sn" ON "xm_bulky_supplier_account_log" ("order_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_address_idx_supplierId_dataStatus_createTime" ON "xm_bulky_supplier_address" ("supplier_id", "create_time", "data_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_address_idx_supplierId_dataStatus_Default" ON "xm_bulky_supplier_address" ("supplier_id", "default_address", "data_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_after_sale_rate_idx_calculate_time" ON "xm_bulky_supplier_after_sale_rate" ("calculate_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_agreement_agree_idx_supplier_data_status_update" ON "xm_bulky_supplier_agreement_agree" ("supplier_id", "data_status", "agreement_update_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_agreement_agree_idx_agreement_id" ON "xm_bulky_supplier_agreement_agree" ("agreement_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_back_idx_wx_open_id" ON "xm_bulky_supplier_back" ("wx_open_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_back_idx_thirdshopid" ON "xm_bulky_supplier_back" ("third_shop_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_balance_log_idx_id_time" ON "xm_bulky_supplier_balance_log" ("supplier_id", "create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_balance_log_idx_time_sid" ON "xm_bulky_supplier_balance_log" ("create_time", "supplier_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_bill_assist_order_idx_supplier_status" ON "xm_bulky_supplier_bill_assist_order" ("supplier_id", "order_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_bill_settlement_idx_supplier_round" ON "xm_bulky_supplier_bill_settlement" ("supplier_id", "round_no", "round_type");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_bill_settlement_idx_round" ON "xm_bulky_supplier_bill_settlement" ("round_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_class_second_idx_supplier_id" ON "xm_bulky_supplier_class_second" ("supplier_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_class_second_idx_second_id" ON "xm_bulky_supplier_class_second" ("second_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_class_second_idx_recycle_auth" ON "xm_bulky_supplier_class_second" ("data_status", "update_time", "supplier_id", "second_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_class_second_apply_idx_status_data_create" ON "xm_bulky_supplier_class_second_apply" ("status", "data_status", "create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_class_second_apply_idx_second_id" ON "xm_bulky_supplier_class_second_apply" ("second_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_class_second_auth_log_idx_time" ON "xm_bulky_supplier_class_second_auth_log" ("data_status", "create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_class_second_auth_log_idx_supplier_time" ON "xm_bulky_supplier_class_second_auth_log" ("data_status", "supplier_id", "create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_class_second_auth_log_idx_second_time" ON "xm_bulky_supplier_class_second_auth_log" ("data_status", "second_id", "create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_class_second_auth_log_idx_operation_time" ON "xm_bulky_supplier_class_second_auth_log" ("data_status", "operation_type", "create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_class_second_auth_log_idx_cancel_auth_time" ON "xm_bulky_supplier_class_second_auth_log" ("data_status", "cancel_auth_type", "create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_class_second_auth_log_idx_supplier_second_operation_time" ON "xm_bulky_supplier_class_second_auth_log" ("data_status", "supplier_id", "second_id", "operation_type", "create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_comment_score_daily_idx_score_date" ON "xm_bulky_supplier_comment_score_daily" ("score_date");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_enter_idx_supplier_id" ON "xm_bulky_supplier_enter" ("supplier_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_enter_idx_date" ON "xm_bulky_supplier_enter" ("date");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_enter_idx_data_status" ON "xm_bulky_supplier_enter" ("data_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_enter_item_idx_enter_id" ON "xm_bulky_supplier_enter_item" ("enter_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_enter_item_idx_supplierid_date" ON "xm_bulky_supplier_enter_item" ("supplier_id", "date");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_enter_item_idx_orderitemid" ON "xm_bulky_supplier_enter_item" ("order_item_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_enter_item_idx_date_ordernum" ON "xm_bulky_supplier_enter_item" ("date", "order_num");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_enter_item_idx_date_zone" ON "xm_bulky_supplier_enter_item" ("date", "zone");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_enter_item_idx_date_zoneshelf" ON "xm_bulky_supplier_enter_item" ("date", "zone_shelf");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_enter_item_idx_producti_date" ON "xm_bulky_supplier_enter_item" ("product_id", "date");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_enter_item_back_idx_order_num" ON "xm_bulky_supplier_enter_item_back" ("order_num");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_enter_item_back_idx_enter_id" ON "xm_bulky_supplier_enter_item_back" ("enter_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_enter_item_back_idx_date" ON "xm_bulky_supplier_enter_item_back" ("date");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_enter_item_back_idx_supplierid_date" ON "xm_bulky_supplier_enter_item_back" ("supplier_id", "date");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_enter_item_copy2_idx_order_num" ON "xm_bulky_supplier_enter_item_copy2" ("order_num");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_enter_item_copy2_idx_enter_id" ON "xm_bulky_supplier_enter_item_copy2" ("enter_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_enter_item_copy2_idx_date" ON "xm_bulky_supplier_enter_item_copy2" ("date");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_enter_item_copy2_idx_supplierid_date" ON "xm_bulky_supplier_enter_item_copy2" ("supplier_id", "date");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_enter_package_idx_order_num" ON "xm_bulky_supplier_enter_package" ("order_num");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_enter_package_idx_date" ON "xm_bulky_supplier_enter_package" ("date");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_experience_score_idx_score_date" ON "xm_bulky_supplier_experience_score" ("score_date");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_experience_score_idx_is_display" ON "xm_bulky_supplier_experience_score" ("is_display");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_info_idx_tagtime" ON "xm_bulky_supplier_info" ("tag_update_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_info_idx_regno" ON "xm_bulky_supplier_info" ("register_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_log_idx_supplierid_type" ON "xm_bulky_supplier_log" ("supplier_id", "type");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_log_idx_ctime" ON "xm_bulky_supplier_log" ("create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_operation_money_log_idx_supplier_id" ON "xm_bulky_supplier_operation_money_log" ("supplier_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_operation_money_log_idx_tradeno" ON "xm_bulky_supplier_operation_money_log" ("trade_no");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_order_idx_ptime_sid_ostatus_sprice" ON "xm_bulky_supplier_order" ("wx_pay_time", "supplier_id", "order_status", "supply_price");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_order_idx_round_supplier_status" ON "xm_bulky_supplier_order" ("round_no", "supplier_id", "order_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_order_idx_is_invoice_marked" ON "xm_bulky_supplier_order" ("is_invoice_marked", "supplier_id", "wx_pay_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_order_idx_supplier_quota_added" ON "xm_bulky_supplier_order" ("supplier_quota_added", "supplier_id", "wx_pay_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_order_idx_purchaser_quota_added" ON "xm_bulky_supplier_order" ("purchaser_quota_added", "order_status", "create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_order_idx_ordersn_supplierid" ON "xm_bulky_supplier_order" ("order_sn", "supplier_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_order_idx_sid_ostatus_ptime_sprice" ON "xm_bulky_supplier_order" ("supplier_id", "order_status", "wx_pay_time", "supply_price");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_order_idx_zone_shelf" ON "xm_bulky_supplier_order" ("zone_shelf");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_order_idx_status_round_station_fee" ON "xm_bulky_supplier_order" ("order_status", "round_no", "total_station_fee");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_order_log_idx_order_sn" ON "xm_bulky_supplier_order_log" ("order_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_order_log_idx_time" ON "xm_bulky_supplier_order_log" ("time");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_order_tmp_idx_ptime_sid_ostatus_sprice" ON "xm_bulky_supplier_order_tmp" ("wx_pay_time", "supplier_id", "order_status", "supply_price");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_order_tmp_idx_ordersn_supplierid" ON "xm_bulky_supplier_order_tmp" ("order_sn", "supplier_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_order_tmp_idx_zone_shelf" ON "xm_bulky_supplier_order_tmp" ("zone_shelf");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_order_tmp_idx_sid_ostatus_ptime_sprice" ON "xm_bulky_supplier_order_tmp" ("supplier_id", "order_status", "wx_pay_time", "supply_price");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_order_tmp_idx_round_supplier_status" ON "xm_bulky_supplier_order_tmp" ("round_no", "supplier_id", "order_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_order_tmp_idx_is_invoice_marked" ON "xm_bulky_supplier_order_tmp" ("is_invoice_marked", "supplier_id", "wx_pay_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_order_tmp_idx_supplier_quota_added" ON "xm_bulky_supplier_order_tmp" ("supplier_quota_added", "supplier_id", "wx_pay_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_order_tmp_idx_purchaser_quota_added" ON "xm_bulky_supplier_order_tmp" ("purchaser_quota_added", "order_status", "create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_punish_idx_order_sn" ON "xm_bulky_supplier_punish" ("order_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_punish_idx_orderitemid" ON "xm_bulky_supplier_punish" ("order_item_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_punish_idx_roundno_plink" ON "xm_bulky_supplier_punish" ("round_no", "punish_link");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_punish_idx_supplierid" ON "xm_bulky_supplier_punish" ("supplier_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_punish_idx_ctime_hstatus_plink" ON "xm_bulky_supplier_punish" ("create_time", "handle_status", "punish_link");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_recharge_idx_supplier_id" ON "xm_bulky_supplier_recharge" ("supplier_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_recharge_idx_partner_status" ON "xm_bulky_supplier_recharge" ("partner_id", "status");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_recharge_idx_status_review" ON "xm_bulky_supplier_recharge" ("status", "review_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_recharge_apply_idx_ctime" ON "xm_bulky_supplier_recharge_apply" ("create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_recharge_apply_idx_status" ON "xm_bulky_supplier_recharge_apply" ("status");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_reconciliation_idx_business_time" ON "xm_bulky_supplier_reconciliation" ("business_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_reconciliation_idx_order_sn" ON "xm_bulky_supplier_reconciliation" ("order_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_reconciliation_idx_statement_date" ON "xm_bulky_supplier_reconciliation" ("statement_date");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_reg_idx_supplier_id" ON "xm_bulky_supplier_reg" ("supplier_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_repurchase_stats_idx_stat_repurchase_supplier" ON "xm_bulky_supplier_repurchase_stats" ("stat_date", "repurchase_count", "supplier_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_score_log_idx_score_date" ON "xm_bulky_supplier_score_log" ("score_date");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_score_log_idx_score_type" ON "xm_bulky_supplier_score_log" ("score_type");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_score_log_idx_score_dimension" ON "xm_bulky_supplier_score_log" ("score_dimension");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_score_log_idx_source" ON "xm_bulky_supplier_score_log" ("source_type", "source_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_score_log_idx_data_status" ON "xm_bulky_supplier_score_log" ("data_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_score_log_idx_supplier_score_date_type" ON "xm_bulky_supplier_score_log" ("supplier_id", "score_date", "score_type", "score_dimension");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_second_sale_stat_idx_last_sale_time" ON "xm_bulky_supplier_second_sale_stat" ("last_sale_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_sell_record_idx_supplier_id" ON "xm_bulky_supplier_sell_record" ("supplier_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_sell_record_idx_date" ON "xm_bulky_supplier_sell_record" ("start_date");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_settlement_record_idx_settle_date" ON "xm_bulky_supplier_settlement_record" ("settle_date");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_sub_idx_phone" ON "xm_bulky_supplier_sub" ("phone");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_sub_idx_supplier_id" ON "xm_bulky_supplier_sub" ("supplier_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_subsidy_idx_ordersn" ON "xm_bulky_supplier_subsidy" ("order_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_subsidy_idx_supplierid" ON "xm_bulky_supplier_subsidy" ("supplier_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_subsidy_idx_ctime" ON "xm_bulky_supplier_subsidy" ("create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_tag_idx_tagid" ON "xm_bulky_supplier_tag" ("tag_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_take_ratio_log_idx_createtime_supplierid" ON "xm_bulky_supplier_take_ratio_log" ("create_time", "supplier_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_temp_idx_wx_open_id" ON "xm_bulky_supplier_temp" ("wx_open_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_temp_idx_thirdshopid" ON "xm_bulky_supplier_temp" ("third_shop_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_withdrawal_idx_apply_status" ON "xm_bulky_supplier_withdrawal" ("apply_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_withdrawal_idx_distribution_id" ON "xm_bulky_supplier_withdrawal" ("distribute_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_withdrawal_idx_ctime_supplierid" ON "xm_bulky_supplier_withdrawal" ("create_time", "supplier_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_withdrawal_idx_supplierid_wstatus_applymoney" ON "xm_bulky_supplier_withdrawal" ("supplier_id", "withdraw_status", "apply_money");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_withdrawal_idx_wtype_wstatus" ON "xm_bulky_supplier_withdrawal" ("withdraw_type", "withdraw_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_withdrawal_idx_ds_name_account_supplier" ON "xm_bulky_supplier_withdrawal" ("data_status", "supplier_name", "account_id", "supplier_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_withdrawal_idx_ds_account_supplier" ON "xm_bulky_supplier_withdrawal" ("data_status", "account_id", "supplier_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_supplier_withdrawal_idx_ds_supplier_account" ON "xm_bulky_supplier_withdrawal" ("data_status", "supplier_id", "account_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_tag_idx_parent_id" ON "xm_bulky_tag" ("parent_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_tag_product_idx_second_id" ON "xm_bulky_tag_product" ("second_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_tag_product_idx_productid" ON "xm_bulky_tag_product" ("product_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_tag_product_idx_tagid_status_product" ON "xm_bulky_tag_product" ("tag_id", "data_status", "product_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_tag_second_rank_idx_type_secondid" ON "xm_bulky_tag_second_rank" ("type", "second_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_tally_income_record_idx_date_user" ON "xm_bulky_tally_income_record" ("date", "user_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_team_user_idx_user_id" ON "xm_bulky_team_user" ("user_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_team_user_snapshot_idx_round_type_leader" ON "xm_bulky_team_user_snapshot" ("round_no", "team_type", "leader_flag");
CREATE INDEX IF NOT EXISTS "xm_bulky_telemarket_log_phone" ON "xm_bulky_telemarket_log" ("phone");
CREATE INDEX IF NOT EXISTS "xm_bulky_transfer_record_idx_ordersn" ON "xm_bulky_transfer_record" ("order_sn");
CREATE INDEX IF NOT EXISTS "xm_bulky_transfer_record_idx_refundid_datastatus" ON "xm_bulky_transfer_record" ("refund_id", "data_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_virtual_apply_file_idx_virtual_apply_id" ON "xm_bulky_virtual_apply_file" ("virtual_apply_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_virtual_apply_item_idx_virtual_apply_id" ON "xm_bulky_virtual_apply_item" ("virtual_apply_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_virtual_bill_idx_virtual_account_id" ON "xm_bulky_virtual_bill" ("virtual_account_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_virtual_money_account_idx_virtual_account_id" ON "xm_bulky_virtual_money_account" ("virtual_account_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_virtual_operation_log_idx_virtual_apply_id" ON "xm_bulky_virtual_operation_log" ("virtual_apply_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_wecom_kf_binding_idx_user_type_user_id" ON "xm_bulky_wecom_kf_binding" ("user_type", "user_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_withdraw_distribute_idx_ctime" ON "xm_bulky_withdraw_distribute" ("create_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_wms_area_snapshot_idx_round_code_status" ON "xm_bulky_wms_area_snapshot" ("round_no", "code", "status");
CREATE INDEX IF NOT EXISTS "xm_bulky_wms_express_package_idx_sendno_type" ON "xm_bulky_wms_express_package" ("send_no", "type");
CREATE INDEX IF NOT EXISTS "xm_bulky_wms_express_package_idx_round_pickup" ON "xm_bulky_wms_express_package" ("round_no", "pickup_flag", "express_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_wms_express_package_idx_round_ware_pickup" ON "xm_bulky_wms_express_package" ("round_no", "ware_id", "pickup_flag");
CREATE INDEX IF NOT EXISTS "xm_bulky_wms_express_package_idx_express_round_pickup" ON "xm_bulky_wms_express_package" ("express_id", "round_no", "pickup_flag");
CREATE INDEX IF NOT EXISTS "xm_bulky_wms_express_package_idx_package_waybill_price_id" ON "xm_bulky_wms_express_package" ("waybill_price_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_wms_express_package_idx_package_send_outbound_quote" ON "xm_bulky_wms_express_package" ("send_no", "express_status", "valid_status", "data_status", "report_price", "waybill_price_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_wms_express_package_idx_round_send_ware_serial" ON "xm_bulky_wms_express_package" ("round_no", "send_no", "ware_id", "serial_num");
CREATE INDEX IF NOT EXISTS "xm_bulky_wms_express_package_idx_package_reconcile_sub_bill" ON "xm_bulky_wms_express_package" ("reconcile_sub_bill_id", "pickup_flag", "data_status");
CREATE INDEX IF NOT EXISTS "xm_bulky_wms_log_idx_enteritemid" ON "xm_bulky_wms_log" ("enter_item_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_wms_prepare_op_idx_date" ON "xm_bulky_wms_prepare_op" ("date");
CREATE INDEX IF NOT EXISTS "xm_bulky_wms_prepare_op_idx_enter_item_id" ON "xm_bulky_wms_prepare_op" ("enter_item_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_wms_prepare_op_idx_user_id" ON "xm_bulky_wms_prepare_op" ("user_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_yhsd_fee_refund_retry_idx_status_next_retry" ON "xm_bulky_yhsd_fee_refund_retry" ("status", "next_retry_time");
CREATE INDEX IF NOT EXISTS "xm_bulky_zq_product_idx_zq_product_id" ON "xm_bulky_zq_product" ("zq_product_id");
CREATE INDEX IF NOT EXISTS "xm_bulky_zq_product_idx_product_id" ON "xm_bulky_zq_product" ("product_id");
CREATE INDEX IF NOT EXISTS "xm_chat_account_user_idx_account" ON "xm_chat_account_user" ("chat_account_id");
CREATE INDEX IF NOT EXISTS "xm_chat_account_user_idx_userid" ON "xm_chat_account_user" ("user_id");
CREATE INDEX IF NOT EXISTS "xm_chat_message_idx_conv_time" ON "xm_chat_message" ("conv_id", "create_time");
CREATE INDEX IF NOT EXISTS "xm_chat_quick_reply_idx_userid_status" ON "xm_chat_quick_reply" ("user_id", "status");
CREATE INDEX IF NOT EXISTS "xm_inspection_reason_config_idx_parent_status" ON "xm_inspection_reason_config" ("parent_id", "data_status");
CREATE INDEX IF NOT EXISTS "xm_inspection_reason_config_idx_level_status" ON "xm_inspection_reason_config" ("level", "data_status");
CREATE INDEX IF NOT EXISTS "xm_inspection_reason_config_idx_sequence" ON "xm_inspection_reason_config" ("sequence", "id");
CREATE INDEX IF NOT EXISTS "xm_inspection_reason_record_idx_enter_code_status" ON "xm_inspection_reason_record" ("date", "enter_item_id", "code_content", "data_status");
CREATE INDEX IF NOT EXISTS "xm_inspection_reason_record_idx_reason_status" ON "xm_inspection_reason_record" ("reason_id", "data_status");
CREATE INDEX IF NOT EXISTS "xm_inspection_reason_record_idx_op_status" ON "xm_inspection_reason_record" ("op", "data_status");
CREATE INDEX IF NOT EXISTS "xm_inspection_recommend_idx_roundNo_suuplierId_enterItem" ON "xm_inspection_recommend" ("round_no", "operation_id", "enter_item_id");
CREATE INDEX IF NOT EXISTS "xm_inspection_recommend_idx_roundNo_product" ON "xm_inspection_recommend" ("round_no", "product_id");
CREATE INDEX IF NOT EXISTS "xm_peasant_account_log_idx_orderId" ON "xm_peasant_account_log" ("order_id");
CREATE INDEX IF NOT EXISTS "xm_peasant_cart_idx_skuId_supplierId_dataStatus" ON "xm_peasant_cart" ("buy_supplier_id", "sku_id", "data_status");
CREATE INDEX IF NOT EXISTS "xm_peasant_order_idx_data_baseanme" ON "xm_peasant_order" ("base_name", "date", "order_status");
CREATE INDEX IF NOT EXISTS "xm_peasant_order_idx_buyid_status_time" ON "xm_peasant_order" ("buy_supplier_id", "order_status", "create_time");
CREATE INDEX IF NOT EXISTS "xm_peasant_order_item_idx_orderid" ON "xm_peasant_order_item" ("order_id");
CREATE INDEX IF NOT EXISTS "xm_peasant_product_idx_secondId_name_sell_data_status" ON "xm_peasant_product" ("second_id", "name", "sell_status", "data_status");
CREATE INDEX IF NOT EXISTS "xm_peasant_product_sku_idx_goodIds_sell_data_status" ON "xm_peasant_product_sku" ("goods_id", "sell_status", "data_status");
CREATE INDEX IF NOT EXISTS "xm_peasant_refund_idx_orderid" ON "xm_peasant_refund" ("order_id");
CREATE INDEX IF NOT EXISTS "xm_peasant_refund_idx_time" ON "xm_peasant_refund" ("create_time");
CREATE INDEX IF NOT EXISTS "xm_peasant_refund_item_idx_refundid" ON "xm_peasant_refund_item" ("peasant_refund_id");
CREATE INDEX IF NOT EXISTS "xm_peasant_sub_account_supplier_rel_idx_peasant_supplier_id" ON "xm_peasant_sub_account_supplier_rel" ("peasant_supplier_id");
CREATE INDEX IF NOT EXISTS "xm_peasant_supplier_refund_log_idx_refund_id" ON "xm_peasant_supplier_refund_log" ("peasant_refund_id");
CREATE INDEX IF NOT EXISTS "xm_quality_check_config_idx_category_name" ON "xm_quality_check_config" ("category_name");
CREATE INDEX IF NOT EXISTS "xm_quality_check_config_idx_status_sort_num" ON "xm_quality_check_config" ("data_status", "sort_num");
CREATE INDEX IF NOT EXISTS "xm_zcpf_supplier_idx_data_status" ON "xm_zcpf_supplier" ("data_status");
CREATE INDEX IF NOT EXISTS "zq_good_idx_zqpid" ON "zq_good" ("zq_pid");
CREATE INDEX IF NOT EXISTS "zq_order_item_idx_orderid" ON "zq_order_item" ("order_id");
CREATE INDEX IF NOT EXISTS "wms_account_idx_account_role" ON "wms_account" ("role_id");
CREATE INDEX IF NOT EXISTS "wms_business_domain_idx_domain_view_permission" ON "wms_business_domain" ("view_permission_code");
CREATE INDEX IF NOT EXISTS "wms_account_base_permission_idx_account_sort" ON "wms_account_base_permission" ("account_id", "sort_order");
CREATE INDEX IF NOT EXISTS "wms_account_distribution_area_idx_distribution_area_zone" ON "wms_account_distribution_area" ("zone_code");
CREATE INDEX IF NOT EXISTS "wms_account_inspection_area_idx_inspection_area_zone" ON "wms_account_inspection_area" ("zone_code");
CREATE TRIGGER IF NOT EXISTS "audit_task_updated_at_timestamp" AFTER UPDATE ON "audit_task" WHEN NEW."updated_at"=OLD."updated_at" BEGIN UPDATE "audit_task" SET "updated_at"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "backup_express_config_update_time_timestamp" AFTER UPDATE ON "backup_express_config" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "backup_express_config" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "bak_20260901_a105_backup_express_update_time_timestamp" AFTER UPDATE ON "bak_20260901_a105_backup_express" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "bak_20260901_a105_backup_express" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "bak_20260901_a105_city_warehouse_update_time_timestamp" AFTER UPDATE ON "bak_20260901_a105_city_warehouse" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "bak_20260901_a105_city_warehouse" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "bak_20260901_a105_common_update_time_timestamp" AFTER UPDATE ON "bak_20260901_a105_common" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "bak_20260901_a105_common" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "bak_20260901_a105_daily_shelf_update_time_timestamp" AFTER UPDATE ON "bak_20260901_a105_daily_shelf" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "bak_20260901_a105_daily_shelf" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "bak_20260901_a105_daily_shelf_test_update_time_timestamp" AFTER UPDATE ON "bak_20260901_a105_daily_shelf_test" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "bak_20260901_a105_daily_shelf_test" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "bak_20260901_a105_order_info_update_time_timestamp" AFTER UPDATE ON "bak_20260901_a105_order_info" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "bak_20260901_a105_order_info" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "bak_20260901_a105_package_update_time_timestamp" AFTER UPDATE ON "bak_20260901_a105_package" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "bak_20260901_a105_package" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "bak_20260901_a105_partner_bind_update_time_timestamp" AFTER UPDATE ON "bak_20260901_a105_partner_bind" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "bak_20260901_a105_partner_bind" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "bak_20260901_a105_wms_area_update_time_timestamp" AFTER UPDATE ON "bak_20260901_a105_wms_area" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "bak_20260901_a105_wms_area" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "bak_20260901_cd9_backup_express_update_time_timestamp" AFTER UPDATE ON "bak_20260901_cd9_backup_express" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "bak_20260901_cd9_backup_express" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "bak_20260901_cd9_bind_update_time_timestamp" AFTER UPDATE ON "bak_20260901_cd9_bind" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "bak_20260901_cd9_bind" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "bak_20260901_cd9_city_update_time_timestamp" AFTER UPDATE ON "bak_20260901_cd9_city" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "bak_20260901_cd9_city" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "bak_20260901_cd9_common_update_time_timestamp" AFTER UPDATE ON "bak_20260901_cd9_common" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "bak_20260901_cd9_common" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "bak_20260901_cd9_daily_shelf_update_time_timestamp" AFTER UPDATE ON "bak_20260901_cd9_daily_shelf" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "bak_20260901_cd9_daily_shelf" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "bak_20260901_cd9_daily_shelf_test_update_time_timestamp" AFTER UPDATE ON "bak_20260901_cd9_daily_shelf_test" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "bak_20260901_cd9_daily_shelf_test" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "bak_20260901_cd9_order_info_update_time_timestamp" AFTER UPDATE ON "bak_20260901_cd9_order_info" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "bak_20260901_cd9_order_info" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "bak_20260901_cd9_package_update_time_timestamp" AFTER UPDATE ON "bak_20260901_cd9_package" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "bak_20260901_cd9_package" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "bak_20260901_cd9_wms_area_update_time_timestamp" AFTER UPDATE ON "bak_20260901_cd9_wms_area" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "bak_20260901_cd9_wms_area" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "banner_class_config_update_time_timestamp" AFTER UPDATE ON "banner_class_config" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "banner_class_config" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "banner_config_update_time_timestamp" AFTER UPDATE ON "banner_config" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "banner_config" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "blk_normal_wx_order_update_time_timestamp" AFTER UPDATE ON "blk_normal_wx_order" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "blk_normal_wx_order" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "blk_purchaser_extra_info_update_time_timestamp" AFTER UPDATE ON "blk_purchaser_extra_info" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "blk_purchaser_extra_info" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "blk_recommend_info_update_time_timestamp" AFTER UPDATE ON "blk_recommend_info" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "blk_recommend_info" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "blk_recommend_tab_update_time_timestamp" AFTER UPDATE ON "blk_recommend_tab" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "blk_recommend_tab" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "blk_saas_app_update_time_timestamp" AFTER UPDATE ON "blk_saas_app" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "blk_saas_app" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "blk_wx_pay_certificate_update_time_timestamp" AFTER UPDATE ON "blk_wx_pay_certificate" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "blk_wx_pay_certificate" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "blk_wx_pay_certificate_backup_20260718_update_time_timestamp" AFTER UPDATE ON "blk_wx_pay_certificate_backup_20260718" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "blk_wx_pay_certificate_backup_20260718" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "blk_wx_pay_certificate_mch_backup_20260718_update_time_timestamp" AFTER UPDATE ON "blk_wx_pay_certificate_mch_backup_20260718" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "blk_wx_pay_certificate_mch_backup_20260718" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "bulky_open_app_update_time_timestamp" AFTER UPDATE ON "bulky_open_app" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "bulky_open_app" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "bulky_open_app_api_config_update_time_timestamp" AFTER UPDATE ON "bulky_open_app_api_config" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "bulky_open_app_api_config" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "bulky_pay_app_update_time_timestamp" AFTER UPDATE ON "bulky_pay_app" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "bulky_pay_app" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "bulky_pay_app_mch_bind_update_time_timestamp" AFTER UPDATE ON "bulky_pay_app_mch_bind" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "bulky_pay_app_mch_bind" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "bulky_pay_biz_notify_config_update_time_timestamp" AFTER UPDATE ON "bulky_pay_biz_notify_config" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "bulky_pay_biz_notify_config" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "bulky_pay_biz_notify_task_update_time_timestamp" AFTER UPDATE ON "bulky_pay_biz_notify_task" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "bulky_pay_biz_notify_task" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "bulky_pay_mch_update_time_timestamp" AFTER UPDATE ON "bulky_pay_mch" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "bulky_pay_mch" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "bulky_pay_mch_config_update_time_timestamp" AFTER UPDATE ON "bulky_pay_mch_config" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "bulky_pay_mch_config" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "bulky_pay_order_update_time_timestamp" AFTER UPDATE ON "bulky_pay_order" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "bulky_pay_order" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "bulky_pay_refund_update_time_timestamp" AFTER UPDATE ON "bulky_pay_refund" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "bulky_pay_refund" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "bulky_pay_route_rule_update_time_timestamp" AFTER UPDATE ON "bulky_pay_route_rule" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "bulky_pay_route_rule" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "city_order_update_time_timestamp" AFTER UPDATE ON "city_order" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "city_order" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "city_order_item_update_time_timestamp" AFTER UPDATE ON "city_order_item" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "city_order_item" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "city_order_refund_update_time_timestamp" AFTER UPDATE ON "city_order_refund" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "city_order_refund" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "city_order_trade_record_update_time_timestamp" AFTER UPDATE ON "city_order_trade_record" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "city_order_trade_record" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "city_warehouse_update_time_timestamp" AFTER UPDATE ON "city_warehouse" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "city_warehouse" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "city_warehouse_class_banner_update_time_timestamp" AFTER UPDATE ON "city_warehouse_class_banner" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "city_warehouse_class_banner" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "city_warehouse_class_first_add_price_update_time_timestamp" AFTER UPDATE ON "city_warehouse_class_first_add_price" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "city_warehouse_class_first_add_price" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "city_warehouse_class_second_add_price_update_time_timestamp" AFTER UPDATE ON "city_warehouse_class_second_add_price" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "city_warehouse_class_second_add_price" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "city_warehouse_copy1_update_time_timestamp" AFTER UPDATE ON "city_warehouse_copy1" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "city_warehouse_copy1" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "city_warehouse_data_statistics_update_time_timestamp" AFTER UPDATE ON "city_warehouse_data_statistics" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "city_warehouse_data_statistics" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "city_warehouse_express_record_update_time_timestamp" AFTER UPDATE ON "city_warehouse_express_record" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "city_warehouse_express_record" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "city_warehouse_fhh_logistics_fee_update_time_timestamp" AFTER UPDATE ON "city_warehouse_fhh_logistics_fee" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "city_warehouse_fhh_logistics_fee" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "city_warehouse_promote_income_statistics_update_time_timestamp" AFTER UPDATE ON "city_warehouse_promote_income_statistics" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "city_warehouse_promote_income_statistics" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "city_warehouse_remark_update_time_timestamp" AFTER UPDATE ON "city_warehouse_remark" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "city_warehouse_remark" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "city_warehouse_shipping_area_update_time_timestamp" AFTER UPDATE ON "city_warehouse_shipping_area" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "city_warehouse_shipping_area" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "class_second_avg_price_update_time_timestamp" AFTER UPDATE ON "class_second_avg_price" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "class_second_avg_price" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "community_activity_update_time_timestamp" AFTER UPDATE ON "community_activity" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "community_activity" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "community_activity_coupon_pool_update_time_timestamp" AFTER UPDATE ON "community_activity_coupon_pool" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "community_activity_coupon_pool" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "customer_area_type_update_time_timestamp" AFTER UPDATE ON "customer_area_type" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "customer_area_type" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "daily_shelf_update_time_timestamp" AFTER UPDATE ON "daily_shelf" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "daily_shelf" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "daily_shelf_test_update_time_timestamp" AFTER UPDATE ON "daily_shelf_test" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "daily_shelf_test" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "fee_config_update_time_timestamp" AFTER UPDATE ON "fee_config" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "fee_config" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "fhh_member_level_config_update_time_timestamp" AFTER UPDATE ON "fhh_member_level_config" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "fhh_member_level_config" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "flash_sale_apply_update_time_timestamp" AFTER UPDATE ON "flash_sale_apply" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "flash_sale_apply" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "flash_sale_plan_update_time_timestamp" AFTER UPDATE ON "flash_sale_plan" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "flash_sale_plan" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "flash_sale_session_update_time_timestamp" AFTER UPDATE ON "flash_sale_session" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "flash_sale_session" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "gallery_visit_user_daily_updated_at_timestamp" AFTER UPDATE ON "gallery_visit_user_daily" WHEN NEW."updated_at"=OLD."updated_at" BEGIN UPDATE "gallery_visit_user_daily" SET "updated_at"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "gift_user_update_time_timestamp" AFTER UPDATE ON "gift_user" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "gift_user" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "group_tag_relation_update_time_timestamp" AFTER UPDATE ON "group_tag_relation" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "group_tag_relation" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "holiday_limit_update_time_timestamp" AFTER UPDATE ON "holiday_limit" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "holiday_limit" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "hub_app_version_update_time_timestamp" AFTER UPDATE ON "hub_app_version" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "hub_app_version" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "hub_area_update_time_timestamp" AFTER UPDATE ON "hub_area" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "hub_area" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "hub_device_update_time_timestamp" AFTER UPDATE ON "hub_device" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "hub_device" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "hub_dispatch_order_update_time_timestamp" AFTER UPDATE ON "hub_dispatch_order" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "hub_dispatch_order" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "hub_dispatch_template_update_time_timestamp" AFTER UPDATE ON "hub_dispatch_template" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "hub_dispatch_template" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "hub_dispatch_template_assignment_update_time_timestamp" AFTER UPDATE ON "hub_dispatch_template_assignment" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "hub_dispatch_template_assignment" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "hub_driver_profile_update_time_timestamp" AFTER UPDATE ON "hub_driver_profile" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "hub_driver_profile" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "hub_external_settlement_update_time_timestamp" AFTER UPDATE ON "hub_external_settlement" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "hub_external_settlement" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "hub_role_permission_update_time_timestamp" AFTER UPDATE ON "hub_role_permission" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "hub_role_permission" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "hub_station_update_time_timestamp" AFTER UPDATE ON "hub_station" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "hub_station" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "hub_taxi_register_update_time_timestamp" AFTER UPDATE ON "hub_taxi_register" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "hub_taxi_register" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "hub_taxi_reimburse_update_time_timestamp" AFTER UPDATE ON "hub_taxi_reimburse" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "hub_taxi_reimburse" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "hub_vehicle_update_time_timestamp" AFTER UPDATE ON "hub_vehicle" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "hub_vehicle" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "hub_vehicle_type_update_time_timestamp" AFTER UPDATE ON "hub_vehicle_type" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "hub_vehicle_type" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "hubflow_auto_signin_config_update_time_timestamp" AFTER UPDATE ON "hubflow_auto_signin_config" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "hubflow_auto_signin_config" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "hubflow_base_areas_update_time_timestamp" AFTER UPDATE ON "hubflow_base_areas" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "hubflow_base_areas" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "hubflow_dispatch_order_nodes_update_time_timestamp" AFTER UPDATE ON "hubflow_dispatch_order_nodes" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "hubflow_dispatch_order_nodes" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "hubflow_dispatch_orders_update_time_timestamp" AFTER UPDATE ON "hubflow_dispatch_orders" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "hubflow_dispatch_orders" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "hubflow_driver_certificates_update_time_timestamp" AFTER UPDATE ON "hubflow_driver_certificates" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "hubflow_driver_certificates" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "hubflow_drivers_update_time_timestamp" AFTER UPDATE ON "hubflow_drivers" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "hubflow_drivers" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "hubflow_electronic_fences_update_time_timestamp" AFTER UPDATE ON "hubflow_electronic_fences" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "hubflow_electronic_fences" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "hubflow_external_dispatch_settlement_bills_update_time_timestamp" AFTER UPDATE ON "hubflow_external_dispatch_settlement_bills" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "hubflow_external_dispatch_settlement_bills" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "hubflow_external_vehicles_update_time_timestamp" AFTER UPDATE ON "hubflow_external_vehicles" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "hubflow_external_vehicles" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "hubflow_fuel_price_config_update_time_timestamp" AFTER UPDATE ON "hubflow_fuel_price_config" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "hubflow_fuel_price_config" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "hubflow_role_permissions_update_time_timestamp" AFTER UPDATE ON "hubflow_role_permissions" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "hubflow_role_permissions" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "hubflow_taxi_payment_accounts_update_time_timestamp" AFTER UPDATE ON "hubflow_taxi_payment_accounts" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "hubflow_taxi_payment_accounts" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "hubflow_taxi_reimburse_bills_update_time_timestamp" AFTER UPDATE ON "hubflow_taxi_reimburse_bills" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "hubflow_taxi_reimburse_bills" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "hubflow_taxi_trips_update_time_timestamp" AFTER UPDATE ON "hubflow_taxi_trips" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "hubflow_taxi_trips" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "hubflow_trip_signins_update_time_timestamp" AFTER UPDATE ON "hubflow_trip_signins" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "hubflow_trip_signins" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "hubflow_vehicle_types_update_time_timestamp" AFTER UPDATE ON "hubflow_vehicle_types" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "hubflow_vehicle_types" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "hubflow_vehicles_update_time_timestamp" AFTER UPDATE ON "hubflow_vehicles" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "hubflow_vehicles" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "legacy_purchaser_split_update_time_timestamp" AFTER UPDATE ON "legacy_purchaser_split" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "legacy_purchaser_split" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "logistics_carrier_account_bind_update_time_timestamp" AFTER UPDATE ON "logistics_carrier_account_bind" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "logistics_carrier_account_bind" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "logistics_freight_settle_operation_update_time_timestamp" AFTER UPDATE ON "logistics_freight_settle_operation" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "logistics_freight_settle_operation" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "logistics_message_update_time_timestamp" AFTER UPDATE ON "logistics_message" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "logistics_message" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "logistics_package_abnormal_tag_update_time_timestamp" AFTER UPDATE ON "logistics_package_abnormal_tag" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "logistics_package_abnormal_tag" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "logistics_package_operation_update_time_timestamp" AFTER UPDATE ON "logistics_package_operation" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "logistics_package_operation" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "logistics_provider_account_bind_update_time_timestamp" AFTER UPDATE ON "logistics_provider_account_bind" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "logistics_provider_account_bind" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "logistics_provider_checkin_update_time_timestamp" AFTER UPDATE ON "logistics_provider_checkin" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "logistics_provider_checkin" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "logistics_provider_config_update_time_timestamp" AFTER UPDATE ON "logistics_provider_config" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "logistics_provider_config" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "logistics_waybill_price_update_time_timestamp" AFTER UPDATE ON "logistics_waybill_price" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "logistics_waybill_price" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "member_level_config_update_time_timestamp" AFTER UPDATE ON "member_level_config" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "member_level_config" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "membership_update_time_timestamp" AFTER UPDATE ON "membership" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "membership" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "merchant_apply_info_update_time_timestamp" AFTER UPDATE ON "merchant_apply_info" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "merchant_apply_info" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "mibei_product_update_time_timestamp" AFTER UPDATE ON "mibei_product" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "mibei_product" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "mibei_product_summary_update_time_timestamp" AFTER UPDATE ON "mibei_product_summary" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "mibei_product_summary" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "partner_update_time_timestamp" AFTER UPDATE ON "partner" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "partner" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "partner_class_first_add_price_update_time_timestamp" AFTER UPDATE ON "partner_class_first_add_price" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "partner_class_first_add_price" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "partner_class_second_update_time_timestamp" AFTER UPDATE ON "partner_class_second" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "partner_class_second" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "partner_class_second_add_price_update_time_timestamp" AFTER UPDATE ON "partner_class_second_add_price" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "partner_class_second_add_price" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "partner_common_class_update_time_timestamp" AFTER UPDATE ON "partner_common_class" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "partner_common_class" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "partner_config_update_time_timestamp" AFTER UPDATE ON "partner_config" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "partner_config" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "partner_data_statistics_update_time_timestamp" AFTER UPDATE ON "partner_data_statistics" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "partner_data_statistics" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "partner_logistics_config_update_time_timestamp" AFTER UPDATE ON "partner_logistics_config" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "partner_logistics_config" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "partner_logistics_region_price_update_time_timestamp" AFTER UPDATE ON "partner_logistics_region_price" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "partner_logistics_region_price" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "partner_promoter_update_time_timestamp" AFTER UPDATE ON "partner_promoter" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "partner_promoter" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "partner_template_update_time_timestamp" AFTER UPDATE ON "partner_template" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "partner_template" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "partner_warehouse_bind_update_time_timestamp" AFTER UPDATE ON "partner_warehouse_bind" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "partner_warehouse_bind" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "partner_warehouse_shipping_area_update_time_timestamp" AFTER UPDATE ON "partner_warehouse_shipping_area" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "partner_warehouse_shipping_area" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "pic_category_update_time_timestamp" AFTER UPDATE ON "pic_category" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "pic_category" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "pic_category_backup_update_time_timestamp" AFTER UPDATE ON "pic_category_backup" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "pic_category_backup" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "pic_florist_apply_update_time_timestamp" AFTER UPDATE ON "pic_florist_apply" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "pic_florist_apply" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "pic_follow_update_time_timestamp" AFTER UPDATE ON "pic_follow" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "pic_follow" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "pic_follow_count_update_time_timestamp" AFTER UPDATE ON "pic_follow_count" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "pic_follow_count" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "pic_home_page_update_time_timestamp" AFTER UPDATE ON "pic_home_page" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "pic_home_page" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "pic_lib_updated_at_timestamp" AFTER UPDATE ON "pic_lib" WHEN NEW."updated_at"=OLD."updated_at" BEGIN UPDATE "pic_lib" SET "updated_at"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "pic_lib_category_map_update_time_timestamp" AFTER UPDATE ON "pic_lib_category_map" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "pic_lib_category_map" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "pic_lib_category_map_backup_update_time_timestamp" AFTER UPDATE ON "pic_lib_category_map_backup" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "pic_lib_category_map_backup" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "pic_lib_group_update_time_timestamp" AFTER UPDATE ON "pic_lib_group" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "pic_lib_group" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "pic_my_page_update_time_timestamp" AFTER UPDATE ON "pic_my_page" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "pic_my_page" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "pic_search_record_update_time_timestamp" AFTER UPDATE ON "pic_search_record" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "pic_search_record" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "pic_user_update_time_timestamp" AFTER UPDATE ON "pic_user" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "pic_user" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "pic_user_information_create_time_timestamp" AFTER UPDATE ON "pic_user_information" WHEN NEW."create_time"=OLD."create_time" BEGIN UPDATE "pic_user_information" SET "create_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "point_log_update_time_timestamp" AFTER UPDATE ON "point_log" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "point_log" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "point_mall_category_update_time_timestamp" AFTER UPDATE ON "point_mall_category" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "point_mall_category" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "point_mall_order_update_time_timestamp" AFTER UPDATE ON "point_mall_order" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "point_mall_order" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "point_mall_product_update_time_timestamp" AFTER UPDATE ON "point_mall_product" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "point_mall_product" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "post_follow_create_time_timestamp" AFTER UPDATE ON "post_follow" WHEN NEW."create_time"=OLD."create_time" BEGIN UPDATE "post_follow" SET "create_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "post_lib_updated_at_timestamp" AFTER UPDATE ON "post_lib" WHEN NEW."updated_at"=OLD."updated_at" BEGIN UPDATE "post_lib" SET "updated_at"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "product_display_scores_update_time_timestamp" AFTER UPDATE ON "product_display_scores" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "product_display_scores" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "province_area_update_time_timestamp" AFTER UPDATE ON "province_area" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "province_area" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "purchase_statistics_update_time_timestamp" AFTER UPDATE ON "purchase_statistics" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "purchase_statistics" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "purchaser_bill_update_time_timestamp" AFTER UPDATE ON "purchaser_bill" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "purchaser_bill" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "purchaser_mail_update_time_timestamp" AFTER UPDATE ON "purchaser_mail" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "purchaser_mail" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "qixi_lottery_chance_update_time_timestamp" AFTER UPDATE ON "qixi_lottery_chance" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "qixi_lottery_chance" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "qixi_lottery_prize_display_update_time_timestamp" AFTER UPDATE ON "qixi_lottery_prize_display" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "qixi_lottery_prize_display" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "qixi_lottery_probability_update_time_timestamp" AFTER UPDATE ON "qixi_lottery_probability" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "qixi_lottery_probability" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "qixi_lottery_record_update_time_timestamp" AFTER UPDATE ON "qixi_lottery_record" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "qixi_lottery_record" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "quick_ordering_item_update_time_timestamp" AFTER UPDATE ON "quick_ordering_item" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "quick_ordering_item" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "quick_ordering_list_update_time_timestamp" AFTER UPDATE ON "quick_ordering_list" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "quick_ordering_list" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "saas_app_update_time_timestamp" AFTER UPDATE ON "saas_app" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "saas_app" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "saas_merchant_progress_update_time_timestamp" AFTER UPDATE ON "saas_merchant_progress" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "saas_merchant_progress" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "saas_tester_update_time_timestamp" AFTER UPDATE ON "saas_tester" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "saas_tester" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "saas_user_register_info_update_time_timestamp" AFTER UPDATE ON "saas_user_register_info" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "saas_user_register_info" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "sale_agency_item_update_time_timestamp" AFTER UPDATE ON "sale_agency_item" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "sale_agency_item" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "sale_agency_on_sale_price_update_time_timestamp" AFTER UPDATE ON "sale_agency_on_sale_price" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "sale_agency_on_sale_price" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "sale_agency_plan_price_update_time_timestamp" AFTER UPDATE ON "sale_agency_plan_price" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "sale_agency_plan_price" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "sale_agency_receipt_update_time_timestamp" AFTER UPDATE ON "sale_agency_receipt" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "sale_agency_receipt" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "sale_wms_restock_plan_update_time_timestamp" AFTER UPDATE ON "sale_wms_restock_plan" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "sale_wms_restock_plan" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "sale_wms_restock_plan_item_update_time_timestamp" AFTER UPDATE ON "sale_wms_restock_plan_item" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "sale_wms_restock_plan_item" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "spec_config_update_time_timestamp" AFTER UPDATE ON "spec_config" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "spec_config" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "statistics_category_data_update_time_timestamp" AFTER UPDATE ON "statistics_category_data" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "statistics_category_data" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "statistics_city_data_update_time_timestamp" AFTER UPDATE ON "statistics_city_data" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "statistics_city_data" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "statistics_express_data_update_time_timestamp" AFTER UPDATE ON "statistics_express_data" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "statistics_express_data" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "statistics_supplier_data_update_time_timestamp" AFTER UPDATE ON "statistics_supplier_data" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "statistics_supplier_data" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "subsidy_price_city_toggle_update_time_timestamp" AFTER UPDATE ON "subsidy_price_city_toggle" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "subsidy_price_city_toggle" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "supplier_agency_item_update_time_timestamp" AFTER UPDATE ON "supplier_agency_item" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "supplier_agency_item" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "supplier_match_replace_apply_update_time_timestamp" AFTER UPDATE ON "supplier_match_replace_apply" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "supplier_match_replace_apply" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "supplier_match_replace_black_update_time_timestamp" AFTER UPDATE ON "supplier_match_replace_black" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "supplier_match_replace_black" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "supplier_match_replace_detail_update_time_timestamp" AFTER UPDATE ON "supplier_match_replace_detail" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "supplier_match_replace_detail" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "sys_popup_config_update_time_timestamp" AFTER UPDATE ON "sys_popup_config" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "sys_popup_config" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "tl_account_update_time_timestamp" AFTER UPDATE ON "tl_account" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "tl_account" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "tl_account_apply_update_time_timestamp" AFTER UPDATE ON "tl_account_apply" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "tl_account_apply" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "tl_partner_account_update_time_timestamp" AFTER UPDATE ON "tl_partner_account" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "tl_partner_account" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "tl_transfer_update_time_timestamp" AFTER UPDATE ON "tl_transfer" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "tl_transfer" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "tmp_activity_region_update_time_timestamp" AFTER UPDATE ON "tmp_activity_region" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "tmp_activity_region" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "topics_updated_at_timestamp" AFTER UPDATE ON "topics" WHEN NEW."updated_at"=OLD."updated_at" BEGIN UPDATE "topics" SET "updated_at"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "topics_comment_update_time_timestamp" AFTER UPDATE ON "topics_comment" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "topics_comment" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "transport_station_flower_input_update_time_timestamp" AFTER UPDATE ON "transport_station_flower_input" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "transport_station_flower_input" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "user_comment_updated_at_timestamp" AFTER UPDATE ON "user_comment" WHEN NEW."updated_at"=OLD."updated_at" BEGIN UPDATE "user_comment" SET "updated_at"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "wms_after_sale_punish_review_update_time_timestamp" AFTER UPDATE ON "wms_after_sale_punish_review" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "wms_after_sale_punish_review" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "wms_check_item_log_update_time_timestamp" AFTER UPDATE ON "wms_check_item_log" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "wms_check_item_log" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "wms_entry_inventory_update_time_timestamp" AFTER UPDATE ON "wms_entry_inventory" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "wms_entry_inventory" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "wms_entry_inventory_trace_update_time_timestamp" AFTER UPDATE ON "wms_entry_inventory_trace" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "wms_entry_inventory_trace" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "wms_material_apply_update_time_timestamp" AFTER UPDATE ON "wms_material_apply" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "wms_material_apply" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "wms_punish_update_time_timestamp" AFTER UPDATE ON "wms_punish" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "wms_punish" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "wms_sku_inventory_update_time_timestamp" AFTER UPDATE ON "wms_sku_inventory" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "wms_sku_inventory" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "wms_sku_mapping_update_time_timestamp" AFTER UPDATE ON "wms_sku_mapping" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "wms_sku_mapping" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "wx_b2b_order_update_time_timestamp" AFTER UPDATE ON "wx_b2b_order" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "wx_b2b_order" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "wx_b2b_order_info_update_time_timestamp" AFTER UPDATE ON "wx_b2b_order_info" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "wx_b2b_order_info" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "wx_customer_group_update_time_timestamp" AFTER UPDATE ON "wx_customer_group" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "wx_customer_group" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_actual_price_update_time_timestamp" AFTER UPDATE ON "xm_bulky_actual_price" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_actual_price" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_after_sale_priority_update_time_timestamp" AFTER UPDATE ON "xm_bulky_after_sale_priority" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_after_sale_priority" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_after_sale_staff_update_time_timestamp" AFTER UPDATE ON "xm_bulky_after_sale_staff" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_after_sale_staff" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_agency_refund_update_time_timestamp" AFTER UPDATE ON "xm_bulky_agency_refund" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_agency_refund" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_agency_refund_item_update_time_timestamp" AFTER UPDATE ON "xm_bulky_agency_refund_item" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_agency_refund_item" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_agreement_update_time_timestamp" AFTER UPDATE ON "xm_bulky_agreement" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_agreement" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_agreement_update_update_time_timestamp" AFTER UPDATE ON "xm_bulky_agreement_update" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_agreement_update" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_allocation_config_update_time_timestamp" AFTER UPDATE ON "xm_bulky_allocation_config" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_allocation_config" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_app_update_time_timestamp" AFTER UPDATE ON "xm_bulky_app" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_app" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_app_template_update_time_timestamp" AFTER UPDATE ON "xm_bulky_app_template" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_app_template" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_auth_area_permission_update_time_timestamp" AFTER UPDATE ON "xm_bulky_auth_area_permission" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_auth_area_permission" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_auth_position_update_time_timestamp" AFTER UPDATE ON "xm_bulky_auth_position" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_auth_position" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_auth_position_apply_update_time_timestamp" AFTER UPDATE ON "xm_bulky_auth_position_apply" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_auth_position_apply" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_auth_position_apply_user_update_time_timestamp" AFTER UPDATE ON "xm_bulky_auth_position_apply_user" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_auth_position_apply_user" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_auth_position_role_update_time_timestamp" AFTER UPDATE ON "xm_bulky_auth_position_role" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_auth_position_role" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_auth_position_role_apply_update_time_timestamp" AFTER UPDATE ON "xm_bulky_auth_position_role_apply" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_auth_position_role_apply" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_auth_role_area_permission_update_time_timestamp" AFTER UPDATE ON "xm_bulky_auth_role_area_permission" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_auth_role_area_permission" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_auth_role_permission_apply_update_time_timestamp" AFTER UPDATE ON "xm_bulky_auth_role_permission_apply" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_auth_role_permission_apply" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_auth_user_position_update_time_timestamp" AFTER UPDATE ON "xm_bulky_auth_user_position" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_auth_user_position" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_base_config_update_time_timestamp" AFTER UPDATE ON "xm_bulky_base_config" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_base_config" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_base_outsource_income_update_time_timestamp" AFTER UPDATE ON "xm_bulky_base_outsource_income" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_base_outsource_income" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_burial_point_update_time_timestamp" AFTER UPDATE ON "xm_bulky_burial_point" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_burial_point" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_category_update_time_timestamp" AFTER UPDATE ON "xm_bulky_category" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_category" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_channel_user_info_update_time_timestamp" AFTER UPDATE ON "xm_bulky_channel_user_info" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_channel_user_info" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_chat_message_template_update_time_timestamp" AFTER UPDATE ON "xm_bulky_chat_message_template" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_chat_message_template" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_chat_private_permission_update_time_timestamp" AFTER UPDATE ON "xm_bulky_chat_private_permission" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_chat_private_permission" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_city_customer_daily_statistics_update_time_timestamp" AFTER UPDATE ON "xm_bulky_city_customer_daily_statistics" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_city_customer_daily_statistics" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_city_second_subsidy_update_time_timestamp" AFTER UPDATE ON "xm_bulky_city_second_subsidy" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_city_second_subsidy" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_city_subsidy_update_time_timestamp" AFTER UPDATE ON "xm_bulky_city_subsidy" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_city_subsidy" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_city_subsidy_product_update_time_timestamp" AFTER UPDATE ON "xm_bulky_city_subsidy_product" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_city_subsidy_product" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_class_second_rank_sku_update_time_timestamp" AFTER UPDATE ON "xm_bulky_class_second_rank_sku" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_class_second_rank_sku" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_class_second_sort_update_time_timestamp" AFTER UPDATE ON "xm_bulky_class_second_sort" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_class_second_sort" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_class_second_station_fee_update_time_timestamp" AFTER UPDATE ON "xm_bulky_class_second_station_fee" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_class_second_station_fee" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_cold_contact_log_update_time_timestamp" AFTER UPDATE ON "xm_bulky_cold_contact_log" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_cold_contact_log" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_cold_out_task_update_time_timestamp" AFTER UPDATE ON "xm_bulky_cold_out_task" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_cold_out_task" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_cold_out_task_package_update_time_timestamp" AFTER UPDATE ON "xm_bulky_cold_out_task_package" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_cold_out_task_package" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_cold_stock_update_time_timestamp" AFTER UPDATE ON "xm_bulky_cold_stock" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_cold_stock" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_cold_stock_package_update_time_timestamp" AFTER UPDATE ON "xm_bulky_cold_stock_package" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_cold_stock_package" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_common_update_time_timestamp" AFTER UPDATE ON "xm_bulky_common" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_common" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_complain_update_time_timestamp" AFTER UPDATE ON "xm_bulky_complain" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_complain" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_contact_supplier_log_update_time_timestamp" AFTER UPDATE ON "xm_bulky_contact_supplier_log" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_contact_supplier_log" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_daily_subsidy_update_time_timestamp" AFTER UPDATE ON "xm_bulky_daily_subsidy" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_daily_subsidy" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_device_update_time_timestamp" AFTER UPDATE ON "xm_bulky_device" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_device" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_employee_update_time_timestamp" AFTER UPDATE ON "xm_bulky_employee" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_employee" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_employee_bonus_config_update_time_timestamp" AFTER UPDATE ON "xm_bulky_employee_bonus_config" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_employee_bonus_config" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_employee_bonus_config_user_update_time_timestamp" AFTER UPDATE ON "xm_bulky_employee_bonus_config_user" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_employee_bonus_config_user" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_employee_bonus_month_update_time_timestamp" AFTER UPDATE ON "xm_bulky_employee_bonus_month" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_employee_bonus_month" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_employee_bonus_month_detail_update_time_timestamp" AFTER UPDATE ON "xm_bulky_employee_bonus_month_detail" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_employee_bonus_month_detail" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_employee_wage_update_time_timestamp" AFTER UPDATE ON "xm_bulky_employee_wage" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_employee_wage" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_enter_item_restock_order_update_time_timestamp" AFTER UPDATE ON "xm_bulky_enter_item_restock_order" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_enter_item_restock_order" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_exchange_voice_call_record_update_time_timestamp" AFTER UPDATE ON "xm_bulky_exchange_voice_call_record" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_exchange_voice_call_record" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_exchange_voice_notify_update_time_timestamp" AFTER UPDATE ON "xm_bulky_exchange_voice_notify" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_exchange_voice_notify" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_express_bill_import_log_update_time_timestamp" AFTER UPDATE ON "xm_bulky_express_bill_import_log" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_express_bill_import_log" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_express_change_apply_update_time_timestamp" AFTER UPDATE ON "xm_bulky_express_change_apply" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_express_change_apply" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_express_redress_refund_update_time_timestamp" AFTER UPDATE ON "xm_bulky_express_redress_refund" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_express_redress_refund" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_external_distribution_contractor_account_update_time_timestamp" AFTER UPDATE ON "xm_bulky_external_distribution_contractor_account" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_external_distribution_contractor_account" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_favorite_flower_update_time_timestamp" AFTER UPDATE ON "xm_bulky_favorite_flower" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_favorite_flower" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_freeze_record_update_time_timestamp" AFTER UPDATE ON "xm_bulky_freeze_record" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_freeze_record" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_freeze_record_item_update_time_timestamp" AFTER UPDATE ON "xm_bulky_freeze_record_item" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_freeze_record_item" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_freeze_stats_update_time_timestamp" AFTER UPDATE ON "xm_bulky_freeze_stats" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_freeze_stats" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_group_update_time_timestamp" AFTER UPDATE ON "xm_bulky_group" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_group" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_help_update_time_timestamp" AFTER UPDATE ON "xm_bulky_help" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_help" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_help_order_detail_update_time_timestamp" AFTER UPDATE ON "xm_bulky_help_order_detail" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_help_order_detail" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_help_settle_update_time_timestamp" AFTER UPDATE ON "xm_bulky_help_settle" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_help_settle" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_home_page_update_time_timestamp" AFTER UPDATE ON "xm_bulky_home_page" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_home_page" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_inspection_assign_user_update_time_timestamp" AFTER UPDATE ON "xm_bulky_inspection_assign_user" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_inspection_assign_user" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_inspection_focus_mark_update_time_timestamp" AFTER UPDATE ON "xm_bulky_inspection_focus_mark" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_inspection_focus_mark" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_invoice_registration_update_time_timestamp" AFTER UPDATE ON "xm_bulky_invoice_registration" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_invoice_registration" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_invoice_request_update_time_timestamp" AFTER UPDATE ON "xm_bulky_invoice_request" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_invoice_request" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_invoice_title_update_time_timestamp" AFTER UPDATE ON "xm_bulky_invoice_title" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_invoice_title" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_late_pay_refund_update_time_timestamp" AFTER UPDATE ON "xm_bulky_late_pay_refund" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_late_pay_refund" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_link_manage_update_time_timestamp" AFTER UPDATE ON "xm_bulky_link_manage" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_link_manage" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_logistics_activity_update_time_timestamp" AFTER UPDATE ON "xm_bulky_logistics_activity" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_logistics_activity" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_logistics_activity_region_update_time_timestamp" AFTER UPDATE ON "xm_bulky_logistics_activity_region" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_logistics_activity_region" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_logistics_config_template_mapping_update_time_timestamp" AFTER UPDATE ON "xm_bulky_logistics_config_template_mapping" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_logistics_config_template_mapping" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_logistics_remind_push_log_update_time_timestamp" AFTER UPDATE ON "xm_bulky_logistics_remind_push_log" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_logistics_remind_push_log" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_logistics_remind_task_update_time_timestamp" AFTER UPDATE ON "xm_bulky_logistics_remind_task" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_logistics_remind_task" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_logistics_template_update_time_timestamp" AFTER UPDATE ON "xm_bulky_logistics_template" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_logistics_template" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_main_account_update_time_timestamp" AFTER UPDATE ON "xm_bulky_main_account" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_main_account" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_mall_activity_msg_update_time_timestamp" AFTER UPDATE ON "xm_bulky_mall_activity_msg" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_mall_activity_msg" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_mall_vip_update_time_timestamp" AFTER UPDATE ON "xm_bulky_mall_vip" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_mall_vip" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_mall_vip_order_update_time_timestamp" AFTER UPDATE ON "xm_bulky_mall_vip_order" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_mall_vip_order" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_mall_vip_user_update_time_timestamp" AFTER UPDATE ON "xm_bulky_mall_vip_user" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_mall_vip_user" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_onsale_statistics_update_time_timestamp" AFTER UPDATE ON "xm_bulky_onsale_statistics" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_onsale_statistics" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_order_info_update_time_timestamp" AFTER UPDATE ON "xm_bulky_order_info" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_order_info" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_order_reconciliation_updated_at_timestamp" AFTER UPDATE ON "xm_bulky_order_reconciliation" WHEN NEW."updated_at"=OLD."updated_at" BEGIN UPDATE "xm_bulky_order_reconciliation" SET "updated_at"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_order_remark_history_update_time_timestamp" AFTER UPDATE ON "xm_bulky_order_remark_history" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_order_remark_history" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_package_deadline_snapshot_update_time_timestamp" AFTER UPDATE ON "xm_bulky_package_deadline_snapshot" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_package_deadline_snapshot" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_package_volume_compare_update_time_timestamp" AFTER UPDATE ON "xm_bulky_package_volume_compare" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_package_volume_compare" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_pay_type_update_time_timestamp" AFTER UPDATE ON "xm_bulky_pay_type" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_pay_type" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_platform_bind_update_time_timestamp" AFTER UPDATE ON "xm_bulky_platform_bind" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_platform_bind" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_platform_invoice_update_time_timestamp" AFTER UPDATE ON "xm_bulky_platform_invoice" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_platform_invoice" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_price_mgr_log_update_time_timestamp" AFTER UPDATE ON "xm_bulky_price_mgr_log" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_price_mgr_log" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_price_rule_update_time_timestamp" AFTER UPDATE ON "xm_bulky_price_rule" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_price_rule" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_price_rule_class_update_time_timestamp" AFTER UPDATE ON "xm_bulky_price_rule_class" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_price_rule_class" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_price_strategy_update_time_timestamp" AFTER UPDATE ON "xm_bulky_price_strategy" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_price_strategy" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_price_strategy_target_update_time_timestamp" AFTER UPDATE ON "xm_bulky_price_strategy_target" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_price_strategy_target" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_print_config_update_time_timestamp" AFTER UPDATE ON "xm_bulky_print_config" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_print_config" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_print_device_update_time_timestamp" AFTER UPDATE ON "xm_bulky_print_device" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_print_device" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_print_logistics_update_time_timestamp" AFTER UPDATE ON "xm_bulky_print_logistics" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_print_logistics" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_print_logistics_config_update_time_timestamp" AFTER UPDATE ON "xm_bulky_print_logistics_config" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_print_logistics_config" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_print_template_update_time_timestamp" AFTER UPDATE ON "xm_bulky_print_template" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_print_template" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_product_update_time_timestamp" AFTER UPDATE ON "xm_bulky_product" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_product" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_product_comment_score_daily_update_time_timestamp" AFTER UPDATE ON "xm_bulky_product_comment_score_daily" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_product_comment_score_daily" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_product_info_update_time_timestamp" AFTER UPDATE ON "xm_bulky_product_info" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_product_info" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_product_quality_parameter_update_time_timestamp" AFTER UPDATE ON "xm_bulky_product_quality_parameter" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_product_quality_parameter" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_product_quality_record_update_time_timestamp" AFTER UPDATE ON "xm_bulky_product_quality_record" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_product_quality_record" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_product_restrict_detail_update_time_timestamp" AFTER UPDATE ON "xm_bulky_product_restrict_detail" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_product_restrict_detail" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_product_restrict_rule_update_time_timestamp" AFTER UPDATE ON "xm_bulky_product_restrict_rule" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_product_restrict_rule" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_product_sale_parameter_update_time_timestamp" AFTER UPDATE ON "xm_bulky_product_sale_parameter" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_product_sale_parameter" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_product_sale_parameter2_update_time_timestamp" AFTER UPDATE ON "xm_bulky_product_sale_parameter2" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_product_sale_parameter2" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_product_subsidy_update_time_timestamp" AFTER UPDATE ON "xm_bulky_product_subsidy" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_product_subsidy" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_product_video_update_time_timestamp" AFTER UPDATE ON "xm_bulky_product_video" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_product_video" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_purchaser_contact_supplier_update_time_timestamp" AFTER UPDATE ON "xm_bulky_purchaser_contact_supplier" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_purchaser_contact_supplier" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_purchaser_coupon_tag_update_time_timestamp" AFTER UPDATE ON "xm_bulky_purchaser_coupon_tag" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_purchaser_coupon_tag" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_purchaser_invoice_application_update_time_timestamp" AFTER UPDATE ON "xm_bulky_purchaser_invoice_application" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_purchaser_invoice_application" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_purchaser_invoice_quota_update_time_timestamp" AFTER UPDATE ON "xm_bulky_purchaser_invoice_quota" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_purchaser_invoice_quota" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_quality_punish_sms_record_update_time_timestamp" AFTER UPDATE ON "xm_bulky_quality_punish_sms_record" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_quality_punish_sms_record" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_quick_reply_update_time_timestamp" AFTER UPDATE ON "xm_bulky_quick_reply" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_quick_reply" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_receipt_application_update_time_timestamp" AFTER UPDATE ON "xm_bulky_receipt_application" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_receipt_application" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_receipt_application_item_update_time_timestamp" AFTER UPDATE ON "xm_bulky_receipt_application_item" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_receipt_application_item" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_receipt_application_order_update_time_timestamp" AFTER UPDATE ON "xm_bulky_receipt_application_order" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_receipt_application_order" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_refund_update_time_timestamp" AFTER UPDATE ON "xm_bulky_refund" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_refund" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_refund_duty_update_time_timestamp" AFTER UPDATE ON "xm_bulky_refund_duty" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_refund_duty" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_refund_item_update_time_timestamp" AFTER UPDATE ON "xm_bulky_refund_item" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_refund_item" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_refund_picture_update_time_timestamp" AFTER UPDATE ON "xm_bulky_refund_picture" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_refund_picture" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_remit_update_time_timestamp" AFTER UPDATE ON "xm_bulky_remit" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_remit" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_replenish_update_time_timestamp" AFTER UPDATE ON "xm_bulky_replenish" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_replenish" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_sale_limit_rule_update_time_timestamp" AFTER UPDATE ON "xm_bulky_sale_limit_rule" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_sale_limit_rule" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_second_subsidy_update_time_timestamp" AFTER UPDATE ON "xm_bulky_second_subsidy" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_second_subsidy" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_second_subsidy_config_update_time_timestamp" AFTER UPDATE ON "xm_bulky_second_subsidy_config" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_second_subsidy_config" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_second_subsidy_config_app_update_time_timestamp" AFTER UPDATE ON "xm_bulky_second_subsidy_config_app" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_second_subsidy_config_app" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_second_subsidy_config_city_update_time_timestamp" AFTER UPDATE ON "xm_bulky_second_subsidy_config_city" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_second_subsidy_config_city" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_second_subsidy_new_update_time_timestamp" AFTER UPDATE ON "xm_bulky_second_subsidy_new" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_second_subsidy_new" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_second_subsidy_rule_update_time_timestamp" AFTER UPDATE ON "xm_bulky_second_subsidy_rule" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_second_subsidy_rule" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_sf_logistics_config_update_time_timestamp" AFTER UPDATE ON "xm_bulky_sf_logistics_config" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_sf_logistics_config" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_shelf_package_status_update_time_timestamp" AFTER UPDATE ON "xm_bulky_shelf_package_status" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_shelf_package_status" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_standard_price_update_time_timestamp" AFTER UPDATE ON "xm_bulky_standard_price" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_standard_price" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_supplier_after_sale_rate_update_time_timestamp" AFTER UPDATE ON "xm_bulky_supplier_after_sale_rate" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_supplier_after_sale_rate" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_supplier_agreement_agree_update_time_timestamp" AFTER UPDATE ON "xm_bulky_supplier_agreement_agree" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_supplier_agreement_agree" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_supplier_bill_assist_order_update_time_timestamp" AFTER UPDATE ON "xm_bulky_supplier_bill_assist_order" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_supplier_bill_assist_order" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_supplier_class_second_update_time_timestamp" AFTER UPDATE ON "xm_bulky_supplier_class_second" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_supplier_class_second" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_supplier_class_second_apply_update_time_timestamp" AFTER UPDATE ON "xm_bulky_supplier_class_second_apply" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_supplier_class_second_apply" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_supplier_comment_update_time_timestamp" AFTER UPDATE ON "xm_bulky_supplier_comment" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_supplier_comment" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_supplier_comment_score_daily_update_time_timestamp" AFTER UPDATE ON "xm_bulky_supplier_comment_score_daily" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_supplier_comment_score_daily" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_supplier_experience_score_update_time_timestamp" AFTER UPDATE ON "xm_bulky_supplier_experience_score" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_supplier_experience_score" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_supplier_info_update_time_timestamp" AFTER UPDATE ON "xm_bulky_supplier_info" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_supplier_info" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_supplier_invoice_quota_update_time_timestamp" AFTER UPDATE ON "xm_bulky_supplier_invoice_quota" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_supplier_invoice_quota" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_supplier_invoice_set_update_time_timestamp" AFTER UPDATE ON "xm_bulky_supplier_invoice_set" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_supplier_invoice_set" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_supplier_order_record_update_time_timestamp" AFTER UPDATE ON "xm_bulky_supplier_order_record" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_supplier_order_record" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_supplier_punish_update_time_timestamp" AFTER UPDATE ON "xm_bulky_supplier_punish" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_supplier_punish" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_supplier_recharge_apply_update_time_timestamp" AFTER UPDATE ON "xm_bulky_supplier_recharge_apply" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_supplier_recharge_apply" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_supplier_reconciliation_updated_at_timestamp" AFTER UPDATE ON "xm_bulky_supplier_reconciliation" WHEN NEW."updated_at"=OLD."updated_at" BEGIN UPDATE "xm_bulky_supplier_reconciliation" SET "updated_at"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_supplier_reg_update_time_timestamp" AFTER UPDATE ON "xm_bulky_supplier_reg" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_supplier_reg" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_supplier_score_log_update_time_timestamp" AFTER UPDATE ON "xm_bulky_supplier_score_log" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_supplier_score_log" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_supplier_second_sale_stat_update_time_timestamp" AFTER UPDATE ON "xm_bulky_supplier_second_sale_stat" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_supplier_second_sale_stat" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_supplier_sub_update_time_timestamp" AFTER UPDATE ON "xm_bulky_supplier_sub" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_supplier_sub" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_supplier_subsidy_update_time_timestamp" AFTER UPDATE ON "xm_bulky_supplier_subsidy" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_supplier_subsidy" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_team_update_time_timestamp" AFTER UPDATE ON "xm_bulky_team" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_team" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_team_user_update_time_timestamp" AFTER UPDATE ON "xm_bulky_team_user" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_team_user" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_third_shelf_update_time_timestamp" AFTER UPDATE ON "xm_bulky_third_shelf" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_third_shelf" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_transfer_record_update_time_timestamp" AFTER UPDATE ON "xm_bulky_transfer_record" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_transfer_record" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_wecom_kf_binding_update_time_timestamp" AFTER UPDATE ON "xm_bulky_wecom_kf_binding" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_wecom_kf_binding" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_withdraw_biz_update_time_timestamp" AFTER UPDATE ON "xm_bulky_withdraw_biz" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_withdraw_biz" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_wms_area_update_time_timestamp" AFTER UPDATE ON "xm_bulky_wms_area" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_wms_area" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_wms_express_package_update_time_timestamp" AFTER UPDATE ON "xm_bulky_wms_express_package" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_wms_express_package" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_wms_prepare_op_update_time_timestamp" AFTER UPDATE ON "xm_bulky_wms_prepare_op" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_wms_prepare_op" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_bulky_yhsd_fee_refund_retry_update_time_timestamp" AFTER UPDATE ON "xm_bulky_yhsd_fee_refund_retry" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_bulky_yhsd_fee_refund_retry" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_chat_quick_reply_update_time_timestamp" AFTER UPDATE ON "xm_chat_quick_reply" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_chat_quick_reply" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_chat_user_conversation_update_time_timestamp" AFTER UPDATE ON "xm_chat_user_conversation" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_chat_user_conversation" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_ckgl_operate_log_update_time_timestamp" AFTER UPDATE ON "xm_ckgl_operate_log" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_ckgl_operate_log" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_inspection_reason_config_update_time_timestamp" AFTER UPDATE ON "xm_inspection_reason_config" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_inspection_reason_config" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_inspection_reason_record_update_time_timestamp" AFTER UPDATE ON "xm_inspection_reason_record" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_inspection_reason_record" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_inspection_recommend_review_time_timestamp" AFTER UPDATE ON "xm_inspection_recommend" WHEN NEW."review_time"=OLD."review_time" BEGIN UPDATE "xm_inspection_recommend" SET "review_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_logistics_account_config_update_time_timestamp" AFTER UPDATE ON "xm_logistics_account_config" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_logistics_account_config" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_peasant_cart_update_time_timestamp" AFTER UPDATE ON "xm_peasant_cart" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_peasant_cart" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_peasant_class_first_update_time_timestamp" AFTER UPDATE ON "xm_peasant_class_first" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_peasant_class_first" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_peasant_class_second_update_time_timestamp" AFTER UPDATE ON "xm_peasant_class_second" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_peasant_class_second" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_peasant_order_update_time_timestamp" AFTER UPDATE ON "xm_peasant_order" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_peasant_order" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_peasant_order_item_update_time_timestamp" AFTER UPDATE ON "xm_peasant_order_item" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_peasant_order_item" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_peasant_product_update_time_timestamp" AFTER UPDATE ON "xm_peasant_product" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_peasant_product" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_peasant_product_sku_update_time_timestamp" AFTER UPDATE ON "xm_peasant_product_sku" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_peasant_product_sku" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_peasant_refund_update_time_timestamp" AFTER UPDATE ON "xm_peasant_refund" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_peasant_refund" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_peasant_refund_item_update_time_timestamp" AFTER UPDATE ON "xm_peasant_refund_item" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_peasant_refund_item" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_peasant_sub_account_supplier_rel_update_time_timestamp" AFTER UPDATE ON "xm_peasant_sub_account_supplier_rel" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_peasant_sub_account_supplier_rel" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_quality_check_config_update_time_timestamp" AFTER UPDATE ON "xm_quality_check_config" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_quality_check_config" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "zq_category_update_time_timestamp" AFTER UPDATE ON "zq_category" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "zq_category" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "zq_good_update_time_timestamp" AFTER UPDATE ON "zq_good" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "zq_good" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "zq_good_basic_update_time_timestamp" AFTER UPDATE ON "zq_good_basic" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "zq_good_basic" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "zq_order_update_time_timestamp" AFTER UPDATE ON "zq_order" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "zq_order" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "zq_order_item_update_time_timestamp" AFTER UPDATE ON "zq_order_item" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "zq_order_item" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "zq_shop_update_time_timestamp" AFTER UPDATE ON "zq_shop" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "zq_shop" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_quality_punish_config_update_time_timestamp" AFTER UPDATE ON "xm_quality_punish_config" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_quality_punish_config" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "xm_quality_unit_allocation_update_time_timestamp" AFTER UPDATE ON "xm_quality_unit_allocation" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "xm_quality_unit_allocation" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "wms_role_update_time_timestamp" AFTER UPDATE ON "wms_role" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "wms_role" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "wms_account_update_time_timestamp" AFTER UPDATE ON "wms_account" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "wms_account" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "wms_business_domain_update_time_timestamp" AFTER UPDATE ON "wms_business_domain" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "wms_business_domain" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "wms_account_distribution_area_update_time_timestamp" AFTER UPDATE ON "wms_account_distribution_area" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "wms_account_distribution_area" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
CREATE TRIGGER IF NOT EXISTS "wms_account_inspection_area_update_time_timestamp" AFTER UPDATE ON "wms_account_inspection_area" WHEN NEW."update_time"=OLD."update_time" BEGIN UPDATE "wms_account_inspection_area" SET "update_time"=datetime('now','+8 hours') WHERE rowid=NEW.rowid; END;
