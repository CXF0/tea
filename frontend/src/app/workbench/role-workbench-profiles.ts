import type { RoleCode } from '@/app/permission/role-profiles'
import type { WorkbenchConfiguration } from './types'

// 仅作为角色初始化模板；登录后以后端返回的账户配置为准。
export const roleWorkbenchProfiles: Record<RoleCode, WorkbenchConfiguration> = {
  superAdmin: {
    workbenchCardIds: [], todoIds: ['admission-pending','quality-pending','inventory-inbound'],
    scanOperationIds: ['admission-checkin','quality-inspection','quality-video','distribution-shelf','packing-shelf','logistics-shelf','cold-storage-bare','base-return-confirm'], dataCardIds: ['site-distribution-progress','session-size-statistics','site-location-statistics','admission-overview','quality-overview','quality-supplier-admission','quality-business-statistics','quality-staff','quality-trend','inventory-overview','inventory-progress','distribution-progress','agency-distribution','contractor-distribution','arrival-volume','self-pickup'],
  },
  siteAdmin: {
    workbenchCardIds: [], todoIds: ['admission-pending','quality-pending','inventory-inbound'],
    scanOperationIds: ['admission-checkin','quality-inspection','quality-video','distribution-shelf','packing-shelf','logistics-shelf','cold-storage-bare','base-return-confirm'], dataCardIds: ['site-distribution-progress','session-size-statistics','site-location-statistics','admission-overview','quality-overview','quality-supplier-admission','quality-business-statistics','quality-staff','quality-trend','inventory-overview','inventory-progress','distribution-progress','agency-distribution','contractor-distribution','arrival-volume','self-pickup'],
  },
  regionalManager: { workbenchCardIds: ['quality-session'], todoIds: ['quality-pending'], scanOperationIds: [], dataCardIds: ['quality-overview'] },
  zoneSupervisor: { workbenchCardIds: ['quality-session'], todoIds: ['quality-pending'], scanOperationIds: ['quality-inspection'], dataCardIds: ['quality-overview'] },
  qualityInspector: {
    workbenchCardIds: ['quality-session'],
    todoIds: ['quality-pending'],
    scanOperationIds: ['admission-checkin', 'quality-inspection', 'quality-video', 'base-return-confirm'],
    dataCardIds: ['quality-overview'],
  },
  qualityLeader: {
    workbenchCardIds: ['quality-session'],
    todoIds: ['quality-pending'],
    scanOperationIds: ['quality-inspection', 'quality-video', 'base-return-confirm'],
    dataCardIds: ['quality-overview'],
  },
  patrolInspector: { workbenchCardIds: ['quality-session'], todoIds: ['quality-pending'], scanOperationIds: ['quality-inspection'], dataCardIds: ['quality-overview'] },
  picker: { workbenchCardIds: [], todoIds: [], scanOperationIds: ['distribution-shelf'], dataCardIds: [] },
  partTimePicker: { workbenchCardIds: [], todoIds: [], scanOperationIds: ['distribution-shelf'], dataCardIds: [] },
  packer: { workbenchCardIds: [], todoIds: [], scanOperationIds: ['packing-shelf'], dataCardIds: [] },
  logisticsSpecialist: { workbenchCardIds: [], todoIds: [], scanOperationIds: ['logistics-shelf'], dataCardIds: [] },
  driverLeader: { workbenchCardIds: [], todoIds: [], scanOperationIds: [], dataCardIds: [] },
  driver: { workbenchCardIds: [], todoIds: [], scanOperationIds: [], dataCardIds: [] },
  baseAdmissionOfficer: {
    workbenchCardIds: ['admission-session'],
    todoIds: ['admission-pending'],
    scanOperationIds: ['admission-checkin'],
    dataCardIds: ['admission-overview'],
  },
  warehouseManager: {
    workbenchCardIds: ['inventory-session'],
    todoIds: ['inventory-inbound'],
    scanOperationIds: ['cold-storage-bare'],
    dataCardIds: ['inventory-overview', 'inventory-progress'],
  },
  baseRegionLeader: { workbenchCardIds: ['admission-session'], todoIds: ['admission-pending'], scanOperationIds: ['admission-checkin'], dataCardIds: ['admission-overview'] },
  baseStationStaff: { workbenchCardIds: ['admission-session'], todoIds: ['admission-pending'], scanOperationIds: ['admission-checkin'], dataCardIds: [] },
  agriMaterialManager: { workbenchCardIds: [], todoIds: [], scanOperationIds: [], dataCardIds: [] },
}
