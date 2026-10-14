export type RoleCode =
  | 'superAdmin' | 'siteAdmin' | 'regionalManager' | 'zoneSupervisor'
  | 'qualityInspector' | 'qualityLeader' | 'patrolInspector'
  | 'picker' | 'partTimePicker' | 'packer' | 'logisticsSpecialist' | 'driverLeader' | 'driver'
  | 'warehouseManager' | 'baseRegionLeader' | 'baseStationStaff' | 'baseAdmissionOfficer'
  | 'agriMaterialManager'

export interface RoleProfile {
  code: RoleCode
  label: string
  defaultHome: string
  defaultCapabilities: string[]
}

const home = '/workbenches/home/index'
export const roleProfiles: Record<RoleCode, RoleProfile> = {
  superAdmin: { code: 'superAdmin', label: '超级管理员', defaultHome: home, defaultCapabilities: [] },
  siteAdmin: { code: 'siteAdmin', label: '场地管理员', defaultHome: home, defaultCapabilities: [] },
  regionalManager: { code: 'regionalManager', label: '大区负责人', defaultHome: home, defaultCapabilities: [] },
  zoneSupervisor: { code: 'zoneSupervisor', label: '分区主管', defaultHome: home, defaultCapabilities: [] },
  qualityInspector: { code: 'qualityInspector', label: '质检员', defaultHome: home, defaultCapabilities: ['quality.view','quality.flower.view','quality.task.view','quality.task.submit','quality.task.video.submit','quality.scan','quality.submit','quality.itemControl','baseReturn.view','baseReturn.confirm','admission.view','admission.confirm','admission.scan','distribution.view','distribution.unfinished.view','distribution.operate','restock.view','coldStorage.view','coldStorage.registerBare','coldStorage.finishOut'] },
  qualityLeader: { code: 'qualityLeader', label: '质检负责人', defaultHome: home, defaultCapabilities: ['quality.view','quality.flower.view','quality.task.view','quality.task.submit','quality.task.video.submit','quality.scan','quality.submit','quality.itemControl','baseReturn.view','baseReturn.confirm','quality.statistics','admission.view','admission.confirm','admission.history','admission.statistics','distribution.view','distribution.unfinished.view','distribution.operate','restock.view','coldStorage.view','coldStorage.registerBare','coldStorage.finishOut','staff.manage'] },
  patrolInspector: { code: 'patrolInspector', label: '巡察员', defaultHome: home, defaultCapabilities: [] },
  picker: { code: 'picker', label: '配货员', defaultHome: home, defaultCapabilities: ['distribution.view','distribution.mine.view','distribution.operate'] },
  partTimePicker: { code: 'partTimePicker', label: '兼职配货员', defaultHome: home, defaultCapabilities: ['distribution.view','distribution.operate'] },
  packer: { code: 'packer', label: '打包员', defaultHome: home, defaultCapabilities: [] },
  logisticsSpecialist: { code: 'logisticsSpecialist', label: '物流专员', defaultHome: home, defaultCapabilities: [] },
  driverLeader: { code: 'driverLeader', label: '司机组长', defaultHome: home, defaultCapabilities: ['transport.vehicle.view','transport.dispatch.view','transport.baseFlower.view'] },
  driver: { code: 'driver', label: '司机', defaultHome: home, defaultCapabilities: ['transport.baseFlower.view'] },
  baseAdmissionOfficer: { code: 'baseAdmissionOfficer', label: '基地入场员', defaultHome: home, defaultCapabilities: ['baseManagement.view','baseStocktaking.view','admission.view','admission.confirm','admission.scan','admission.history','admission.exception'] },
  warehouseManager: { code: 'warehouseManager', label: '仓库管理员', defaultHome: home, defaultCapabilities: ['inventory.view','inventory.inbound','inventory.outbound','nfc.use'] },
  baseRegionLeader: { code: 'baseRegionLeader', label: '基地片区负责人', defaultHome: home, defaultCapabilities: [] },
  baseStationStaff: { code: 'baseStationStaff', label: '基地驻场', defaultHome: home, defaultCapabilities: [] },
  agriMaterialManager: { code: 'agriMaterialManager', label: '农资管理员', defaultHome: home, defaultCapabilities: [] },
}
