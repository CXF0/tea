import { AppError } from '../../shared/errors.js'
import * as repository from '../agri-material/agri-material.repository.js'

const number = (value: unknown) => Number(value ?? 0)
const statusLabel = (value: number) => ({ 1: '待发货', 2: '待签收', 3: '已签收' }[value] || '未知')

export async function filters(date: string) {
  const result = await repository.filters(date)
  return {
    bases: result.bases.map(row => String(row.name)),
    suppliers: result.suppliers.map(row => ({ id: number(row.id), name: String(row.name) })),
  }
}

export async function deliveries(date: string, baseName: string, supplierId: number, keyword: string) {
  return (await repository.deliverySummaries(date, baseName, supplierId, keyword)).map(row => ({
    goodsId: number(row.goods_id), skuId: number(row.sku_id), image: String(row.image || ''),
    goodsName: String(row.goods_name || '未命名商品'), skuName: String(row.sku_name || ''),
    totalCount: number(row.total_count), orderCount: number(row.order_count),
  }))
}

export async function deliveryDetail(date: string, goodsId: number, skuId: number, baseName: string, supplierId: number) {
  return (await repository.deliverySuppliers(date, goodsId, skuId, baseName, supplierId)).map(row => {
    const min = number(row.min_status), max = number(row.max_status)
    return { supplierId: number(row.supplier_id), supplierName: String(row.supplier_name), purchaseCount: number(row.purchase_count), orderCount: number(row.order_count), statusLabel: min === max ? statusLabel(min) : '处理中' }
  })
}

export async function orders(date: string, orderStatus: number, keyword: string, baseName: string, supplierId: number) {
  return (await repository.listOrders(date, orderStatus, keyword, baseName, supplierId)).map(row => ({
    orderId: String(row.order_id), date: String(row.date), baseName: String(row.base_name),
    buySupplierName: String(row.buy_supplier_name), peasantSupplierName: String(row.peasant_supplier_name),
    receiverName: String(row.receive_name || ''), receiverPhone: String(row.receive_tel || ''),
    goodsCount: number(row.goods_count), itemCount: number(row.item_count), totalPrice: number(row.total_price),
    orderStatus: number(row.order_status), statusLabel: statusLabel(number(row.order_status)), createTime: row.create_time,
  }))
}

export async function detail(orderId: string) {
  const data = await repository.findOrder(orderId)
  if (!data.order) throw new AppError(404, 'AGRI_ORDER_NOT_FOUND', '农资订单不存在')
  const order = data.order
  return {
    order: { orderId: String(order.order_id), date: String(order.date), baseName: String(order.base_name), buySupplierName: String(order.buy_supplier_name), peasantSupplierName: String(order.peasant_supplier_name), receiverName: String(order.receive_name || ''), receiverPhone: String(order.receive_tel || ''), receiverAddress: String(order.receive_address || ''), buyerMemo: String(order.buyer_memo || ''), totalPrice: number(order.total_price), orderStatus: number(order.order_status), statusLabel: statusLabel(number(order.order_status)), createTime: order.create_time, shipTime: order.ship_time, shipPicture: String(order.ship_pic || ''), completeTime: order.complete_time, completePicture: String(order.complete_pic || ''), completeUserName: String(order.complete_user_name || '') },
    items: data.items.map(row => ({ id: number(row.id), image: String(row.img || ''), goodsName: String(row.goods_info || ''), skuName: String(row.sku_info || ''), quantity: number(row.num), price: number(row.price), totalPrice: number(row.total_price) })),
  }
}

export async function operate(orderId: string, operation: 'ship' | 'receive', picture: string, userId: number, userName: string) {
  if (!picture.startsWith('/uploads/agri-driver/')) throw new AppError(400, 'EVIDENCE_REQUIRED', '请先上传操作照片')
  const from = operation === 'ship' ? 1 : 2
  if (!(await repository.updateOrderStatus(orderId, from, from + 1, picture, userId, userName))) throw new AppError(409, 'ORDER_STATUS_CHANGED', '订单状态已变化，请刷新后重试')
  return detail(orderId)
}
