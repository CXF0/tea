-- 同一货架多供应商、多订单商品演示。每个 order_item_id 始终独立展示和操作。
UPDATE xm_bulky_supplier_enter_item
SET zone='01', shelf='001', sub_shelf_sn='1', zone_shelf='01-001-1',
    product_name=IF(supplier_id=401 AND order_num=18002,'高原红',product_name),
    rank_num=IF(supplier_id=401 AND order_num=18002,1,rank_num),
    sku_config=IF(supplier_id=401 AND order_num=18002,'成熟度:中熟,规格:20枝/扎',sku_config),
    update_time=NOW()
WHERE date='2026-09-18' AND ((supplier_id=401 AND order_num=18002) OR (supplier_id=402 AND order_num=28001));

UPDATE xm_bulky_order_item oi
JOIN xm_bulky_supplier_enter_item item ON item.order_item_id=oi.id
SET oi.zone=item.zone,oi.shelf=item.shelf,oi.sub_shelf_sn=item.sub_shelf_sn,oi.zone_shelf=item.zone_shelf,
    oi.product_name=item.product_name,oi.rank_num=item.rank_num,oi.sku_config=item.sku_config,oi.update_time=NOW()
WHERE item.date='2026-09-18' AND item.zone_shelf='01-001-1' AND item.data_status=0;
