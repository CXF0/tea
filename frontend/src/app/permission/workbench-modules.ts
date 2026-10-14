export type WorkbenchDomain = 'quality' | 'qualityTask' | 'cartonInventory' | 'management'

export interface WorkbenchModule {
  id: string
  domain: WorkbenchDomain
  domainLabel: string
  title: string
  description: string
  capability: string
  path: string
  icon: string
  primary?: boolean
}

// 页面属于业务域，角色不拥有页面。账户只会看到其能力集合命中的模块。
export const workbenchModules: WorkbenchModule[] = [
  { id: 'quality-tasks', domain: 'qualityTask', domainLabel: '质检任务', title: '质检任务', description: '处理待检与复检任务', capability: 'quality.task.view', path: '/features/quality/pages/tasks/index', icon: '/static/icons/wms/fwms-inspection-outline.svg', primary: true },
  { id: 'quality-scan', domain: 'quality', domainLabel: '质检', title: '扫码质检', description: '扫描货位或商品标签', capability: 'quality.scan', path: 'action:quality-scan', icon: '/static/icons/wms/fwms-scan-outline.svg', primary: true },
  { id: 'quality-return', domain: 'quality', domainLabel: '质检', title: '退货确认', description: '确认不合格品退货', capability: 'quality.returnConfirm', path: '/features/quality/pages/tasks/index?type=return', icon: '/static/icons/wms/fwms-return-outline.svg' },
  { id: 'quality-statistics', domain: 'quality', domainLabel: '质检', title: '质检统计', description: '查看人员与结果汇总', capability: 'quality.statistics', path: '/features/quality/pages/statistics/index', icon: '/static/icons/wms/fwms-stocktake-outline.svg' },
  { id: 'inventory-overview', domain: 'cartonInventory', domainLabel: '纸箱管理', title: '纸箱管理', description: '查看纸箱库存与入出库进度', capability: 'inventory.view', path: '/features/carton-inventory/pages/home/index', icon: '/static/icons/wms/fwms-inventory-outline.svg' },
  { id: 'inventory-inbound', domain: 'cartonInventory', domainLabel: '纸箱管理', title: '纸箱入库', description: '登记纸箱入库', capability: 'inventory.inbound', path: '/features/carton-inventory/pages/ledger/index?kind=inbound', icon: '/static/icons/wms/fwms-inbound-outline.svg', primary: true },
  { id: 'staff-management', domain: 'management', domainLabel: '管理', title: '人员管理', description: '维护人员与作业分配', capability: 'staff.manage', path: '/features/management/pages/staff/index', icon: '/static/icons/wms/fwms-collection-outline.svg' },
]

export function getGrantedWorkbenchModules(can: (capability: string) => boolean, domains?: string[]) {
  return workbenchModules.filter(module => can(module.capability) && (!domains || domains.includes(module.domain)))
}
