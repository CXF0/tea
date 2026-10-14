import { computed, reactive } from 'vue'
import { roleProfiles, type RoleCode } from '@/app/permission/role-profiles'
import { roleWorkbenchProfiles } from '@/app/workbench/role-workbench-profiles'

const state = reactive({
  token: '',
  userId: 0,
  userName: '',
  phone: '',
  roleName: '',
  roleCode: 'qualityInspector' as RoleCode,
  warehouseId: 0,
  warehouseName: '',
  capabilities: [] as string[],
  workbenchCardIds: [] as string[],
  todoIds: [] as string[],
  scanOperationIds: [] as string[],
  dataCardIds: [] as string[],
})

function applyAuthenticatedSession(session: {
  token?: string
  userId: number
  userName: string
  phone?: string
  roleName?: string
  roleCode: RoleCode
  warehouseId: number
  warehouseName: string
  capabilities?: string[]
  workbenchCardIds?: string[]
  todoIds?: string[]
  scanOperationIds?: string[]
  dataCardIds?: string[]
}) {
  state.token = session.token ?? state.token
  state.userId = session.userId
  state.userName = session.userName
  state.phone = session.phone ?? ''
  state.roleName = session.roleName ?? roleProfiles[session.roleCode].label
  state.roleCode = session.roleCode
  state.warehouseId = session.warehouseId
  state.warehouseName = session.warehouseName
  state.capabilities = [...(session.capabilities ?? roleProfiles[session.roleCode].defaultCapabilities)]
  const workbench = roleWorkbenchProfiles[session.roleCode]
  state.workbenchCardIds = [...(session.workbenchCardIds ?? workbench.workbenchCardIds)]
  state.todoIds = [...(session.todoIds ?? workbench.todoIds)]
  state.scanOperationIds = [...(session.scanOperationIds ?? workbench.scanOperationIds)]
  state.dataCardIds = [...(session.dataCardIds ?? workbench.dataCardIds)]
  uni.setStorageSync('wmsSession',JSON.parse(JSON.stringify(state)))
}

function restore(){const saved=uni.getStorageSync('wmsSession');if(!saved?.token)return false;applyAuthenticatedSession(saved);return true}
function logout(){
  state.token=''; state.userId=0; state.userName=''; state.phone=''; state.roleName='';
  state.warehouseId=0; state.warehouseName=''; state.capabilities=[];
  state.workbenchCardIds=[]; state.todoIds=[]; state.scanOperationIds=[]; state.dataCardIds=[];
  uni.removeStorageSync('wmsSession')
}

export const sessionStore = {
  state,
  profile: computed(() => roleProfiles[state.roleCode]),
  capabilities: computed(() => state.capabilities),
  workbenchConfiguration: computed(() => ({
    workbenchCardIds: state.workbenchCardIds,
    todoIds: state.todoIds,
    scanOperationIds: state.scanOperationIds,
    dataCardIds: state.dataCardIds,
  })),
  can(capability: string) {
    return state.capabilities.includes(capability)
  },
  canAny(capabilities: string[]) {
    return capabilities.some(capability => state.capabilities.includes(capability))
  },
  restore,
  logout,
  applyAuthenticatedSession,
}
