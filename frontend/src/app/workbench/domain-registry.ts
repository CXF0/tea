import type { BusinessDomainCode } from './types'

export interface DomainDefinition<T extends string> {
  code: T
  label: string
  description: string
}

export const businessDomains: DomainDefinition<BusinessDomainCode>[] = [
  { code: 'systemAccount', label: '系统账户', description: '本系统登录账户与角色归属' },
  { code: 'accessControl', label: '角色权限', description: '角色、权限组及领域权限树' },
  { code: 'baseManagement', label: '基地管理', description: '基地、供应商与场次库存' },
  { code: 'admission', label: '入场', description: '基地入场、签到与到场状态' },
  { code: 'collection', label: '集货', description: '收货、集货与装车准备' },
  { code: 'transport', label: '运输', description: '车辆、司机、线路与在途状态' },
  { code: 'arrivalGoods', label: '到场货', description: '收购、库存、出库、自提与无标签花材' },
  { code: 'quality', label: '质检', description: '初检、复检、退换货确认' },
  { code: 'qualityBaseStatistics', label: '基地质检统计', description: '基地问题统计、换货记录与电话通知' },
  { code: 'qualityTask', label: '质检任务', description: '派发任务、自行货位检查与好花视频' },
  { code: 'distribution', label: '配货', description: '分区配货、货架操作与换货' },
  { code: 'restock', label: '补货', description: '补货计划、数量与进度' },
  { code: 'packing', label: '打包', description: '打包任务、复核与包材' },
  { code: 'inventory', label: '库存', description: '入库、出库、库存与物资' },
  { code: 'coldStorage', label: '冷库', description: '暂存、临期与出库管理' },
  { code: 'logistics', label: '物流发货', description: '发货、揽收、拍照与分配' },
  { code: 'consignment', label: '代卖', description: '收购、定级、上架与订单' },
  { code: 'agriMaterial', label: '农资', description: '商品、订单、供应商与标签' },
  { code: 'agriDelivery', label: '农资送货单', description: '按商品汇总农资送货数量与供应商明细' },
  { code: 'agriDriverOrder', label: '农资订单', description: '农资订单发货、签收与凭证记录' },
  { code: 'management', label: '管理', description: '人员、权限、统计与日志' },
]
