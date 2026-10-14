<script setup lang="ts">
import { computed, ref } from 'vue'
import { onLoad, onPullDownRefresh } from '@dcloudio/uni-app'
import { workforceApi, type DistributionPerson, type DistributionZone, type DistributionZoneSummary } from '../../api/workforce.api'
import WareState from '@/shared/components/WareState.vue'

const people = ref<DistributionPerson[]>([])
const zones = ref<DistributionZone[]>([])
const zoneSummary = ref<DistributionZoneSummary[]>([])
const summary = ref({ total: 0, fullTime: 0, partTime: 0 })
const keyword = ref('')
const roleFilter = ref<'all'|'picker'|'partTimePicker'>('all')
const selected = ref<number[]>([])
const draftAreas = ref<string[]>([])
const active = ref<DistributionPerson>()
const viewOnly = ref(false)
const assigning = ref(false)
const drawer = ref(false)
const loading = ref(true)
const saving = ref(false)
const error = ref('')

const shown = computed(() => people.value.filter(person =>
  (roleFilter.value === 'all' || person.roleCode === roleFilter.value) &&
  (!keyword.value || person.name.includes(keyword.value) || person.loginName.includes(keyword.value) || String(person.userId).includes(keyword.value)),
))
const allShownSelected = computed(() => shown.value.length > 0 && shown.value.every(person => selected.value.includes(person.id)))

async function load() {
  loading.value = true
  error.value = ''
  try {
    const data = await workforceApi.distributionStaff()
    people.value = data.people
    zones.value = data.zones
    zoneSummary.value = data.zoneSummary
    summary.value = data.summary
    selected.value = []
  } catch (cause) { error.value = cause instanceof Error ? cause.message : '加载失败' }
  finally { loading.value = false; uni.stopPullDownRefresh() }
}
function toggle(id: number) { selected.value = selected.value.includes(id) ? selected.value.filter(value => value !== id) : [...selected.value, id] }
function toggleAll() { selected.value = allShownSelected.value ? selected.value.filter(id => !shown.value.some(person => person.id === id)) : [...new Set([...selected.value, ...shown.value.map(person => person.id)])] }
function openAssignment() { uni.navigateTo({ url: '/features/workforce/pages/distribution-staff/index?mode=assign' }) }
function open(person?: DistributionPerson, readonly = false) { active.value = person; viewOnly.value = readonly; draftAreas.value = person ? [...person.areas] : []; drawer.value = true }
function toggleArea(zone: string) { draftAreas.value = draftAreas.value.includes(zone) ? draftAreas.value.filter(value => value !== zone) : [...draftAreas.value, zone] }
function toggleEveryArea() { draftAreas.value = draftAreas.value.length === zones.value.length ? [] : zones.value.map(zone => zone.code) }
async function save() {
  if (!active.value && !selected.value.length) return uni.showToast({ title: '请选择配货人员', icon: 'none' })
  saving.value = true
  try {
    if (active.value) await workforceApi.updateAreas(active.value.id, draftAreas.value)
    else await workforceApi.batchUpdateAreas(selected.value, draftAreas.value)
    drawer.value = false
    uni.showToast({ title: '分区权限已更新', icon: 'success' })
    await load()
  } catch (cause) { uni.showToast({ title: cause instanceof Error ? cause.message : '保存失败', icon: 'none' }) }
  finally { saving.value = false }
}
onLoad(options => { assigning.value = options?.mode === 'assign'; load() })
onPullDownRefresh(load)
</script>

<template>
  <view class="page">
    <WareState v-if="loading" type="loading" title="正在加载配货人员" />
    <WareState v-else-if="error" type="error" title="加载失败" :description="error" action-label="重试" @action="load" />

    <template v-else-if="!assigning">
      <view class="summary">
        <view><b>{{ summary.total }}</b><text>人员总数</text></view>
        <view><b>{{ summary.fullTime }}</b><text>全职人数</text></view>
        <view><b>{{ summary.partTime }}</b><text>兼职人数</text></view>
      </view>
      <view class="section-head"><b>配货权限管理</b><view class="permission-entry" @click="openAssignment"><text>分配权限</text><text class="chevron">›</text></view></view>
      <view class="zone-table">
        <view class="table-head"><text>分区</text><text>可配货人数</text></view>
        <view v-for="zone in zoneSummary" :key="zone.zone" class="zone-row"><text>{{ zone.name }}</text><b>{{ zone.staffCount }}</b></view>
      </view>
      <WareState v-if="!zoneSummary.length" type="empty" title="暂无可配置分区" />
    </template>

    <template v-else>
      <view class="role-tabs">
        <text :class="{active:roleFilter==='all'}" @click="roleFilter='all'">全部 {{ summary.total }}</text>
        <text :class="{active:roleFilter==='picker'}" @click="roleFilter='picker'">配货员 {{ summary.fullTime }}</text>
        <text :class="{active:roleFilter==='partTimePicker'}" @click="roleFilter='partTimePicker'">兼职 {{ summary.partTime }}</text>
      </view>
      <view class="tools">
        <text class="selected-count">已选{{ selected.length }}人</text>
        <view class="search"><text>⌕</text><input v-model="keyword" placeholder="请输入人员姓名或账号" /></view>
        <button :disabled="!selected.length" @click="open()">批量分配</button>
      </view>
      <view class="list-head"><view class="head-select" @click="toggleAll"><view :class="['check',{checked:allShownSelected}]">{{ allShownSelected ? '✓' : '' }}</view><text>{{ allShownSelected ? '取消全选' : '全选' }}</text></view><text>分区权限</text><text>操作</text></view>
      <view v-if="shown.length" class="list">
        <view v-for="person in shown" :key="person.id" class="person-row">
          <view class="identity" @click="toggle(person.id)"><view :class="['check',{checked:selected.includes(person.id)}]">{{ selected.includes(person.id) ? '✓' : '' }}</view><view><view class="name-line"><b>{{ person.name }}</b><em>{{ person.roleName }}</em></view><small>ID {{ person.userId }}</small></view></view>
          <text :class="['area-count',{empty:!person.areas.length}]" @click="open(person,true)">{{ person.areas.length ? `${person.areas.length} 个分区 ›` : '未配置 ›' }}</text>
          <text class="assign" @click="open(person)">分配权限</text>
        </view>
      </view>
      <WareState v-else type="empty" title="暂无配货人员" />
    </template>

    <view v-if="drawer" class="mask" @click="drawer=false">
      <view class="drawer" @click.stop>
        <view class="drawer-head"><view><b>{{ viewOnly ? `${active?.name}的分区权限` : active ? `配置 ${active.name}` : '批量分配可配分区' }}</b><text>{{ viewOnly ? `共 ${draftAreas.length} 个分区` : active ? active.roleName : `已选 ${selected.length} 人` }}</text></view><text v-if="!viewOnly" class="all-area" @click="toggleEveryArea">{{ draftAreas.length===zones.length ? '清空' : '全选分区' }}</text></view>
        <scroll-view scroll-y class="zone-scroll"><view class="zones"><view v-for="zone in (viewOnly ? zones.filter(item=>draftAreas.includes(item.code)) : zones)" :key="zone.code" :class="{active:draftAreas.includes(zone.code),readonly:viewOnly}" @click="!viewOnly&&toggleArea(zone.code)">{{ zone.name }}</view></view></scroll-view>
        <view v-if="viewOnly" class="actions single"><button @click="drawer=false">关闭</button></view>
        <view v-else class="actions"><button @click="drawer=false">取消</button><button :disabled="saving" @click="save">{{ saving ? '保存中…' : '确认分配' }}</button></view>
      </view>
    </view>
  </view>
</template>

<style scoped lang="scss">
.page{box-sizing:border-box;min-height:100vh;padding:24rpx;background:var(--wms-background)}.summary{display:grid;grid-template-columns:repeat(3,1fr);gap:14rpx;margin:12rpx 0 26rpx}.summary view{padding:18rpx 8rpx;border-radius:12rpx;background:#fff;text-align:center}.summary b,.summary text{display:block}.summary b{color:var(--wms-primary-700);font-size:34rpx}.summary text{margin-top:4rpx;color:var(--wms-text-secondary);font-size:22rpx}.section-head{display:flex;align-items:center;justify-content:space-between;margin-bottom:14rpx}.section-head b{font-size:28rpx}.section-head text,.assign,.all-area{color:var(--wms-primary-700)}.zone-table{overflow:hidden;border-radius:14rpx;background:#fff}.table-head,.zone-row{display:grid;grid-template-columns:1fr 1fr;align-items:center;padding:15rpx 28rpx}.table-head{background:var(--wms-primary-700);color:#fff}.zone-row{margin-top:4rpx;background:#f6f8f7}.zone-row b{text-align:center}.role-tabs{display:flex;gap:10rpx;margin:12rpx 0}.role-tabs text{padding:12rpx 18rpx;border-radius:999rpx;background:#fff;color:var(--wms-text-secondary);font-size:22rpx}.role-tabs text.active{background:var(--wms-surface-soft);color:var(--wms-primary-700);font-weight:700}.tools{display:grid;grid-template-columns:100rpx minmax(0,1fr) 142rpx;align-items:center;gap:10rpx;margin:14rpx 0}.selected-count{font-size:20rpx;white-space:nowrap}.search{display:flex;height:66rpx;align-items:center;padding:0 14rpx;border:1rpx solid var(--wms-border);border-radius:10rpx;background:#fff}.search input{min-width:0;flex:1;margin-left:8rpx;font-size:20rpx}.tools button{width:142rpx;height:66rpx;margin:0;padding:0;border-radius:10rpx;background:var(--wms-primary-700);color:#fff;font-size:21rpx;line-height:66rpx}.tools button[disabled]{opacity:.45}.list-head,.person-row{display:grid;grid-template-columns:1.05fr 1.6fr 92rpx;gap:12rpx}.list-head{align-items:center;padding:14rpx 18rpx;background:var(--wms-primary-700);color:#fff}.select-all{overflow:visible;color:#fff;font-size:20rpx;white-space:nowrap}.person-row{align-items:start;padding:22rpx 10rpx;border-bottom:1rpx solid var(--wms-border);background:#fff}.identity{display:flex;min-width:0;align-items:center;gap:10rpx}.identity b,.identity small{display:block}.identity em{display:inline-block;margin:5rpx 0;padding:2rpx 7rpx;border:1rpx solid var(--wms-primary-700);color:var(--wms-primary-700);font-size:18rpx;font-style:normal}.identity small{color:var(--wms-text-secondary);font-size:17rpx}.check{display:flex;width:28rpx;height:28rpx;flex:none;align-items:center;justify-content:center;border:2rpx solid var(--wms-primary-700);border-radius:50%;color:#fff}.check.checked{background:var(--wms-primary-700)}.areas{font-size:20rpx;line-height:1.5;word-break:break-all}.assign{padding-top:4rpx;font-size:20rpx}.mask{position:fixed;z-index:80;inset:0;display:flex;align-items:flex-end;background:#0007}.drawer{box-sizing:border-box;width:100%;padding:28rpx 24rpx calc(24rpx + env(safe-area-inset-bottom));border-radius:26rpx 26rpx 0 0;background:#fff}.drawer-head{display:flex;align-items:center;justify-content:space-between}.drawer-head b,.drawer-head text{display:block}.drawer-head>view>text{margin-top:5rpx;color:var(--wms-text-secondary);font-size:21rpx}.zone-scroll{max-height:52vh}.zones{display:grid;grid-template-columns:repeat(3,1fr);gap:12rpx;margin:24rpx 0}.zones view{display:flex;min-height:68rpx;align-items:center;justify-content:center;border-radius:10rpx;background:var(--wms-background)}.zones view.active{background:var(--wms-primary-700);color:#fff}.actions{display:flex}.actions button{width:50%;margin:0}.actions button:last-child{background:var(--wms-primary-700);color:#fff}
.table-head,.list-head{font-size:20rpx;font-weight:600;line-height:1.35}.select-all{font-size:inherit;font-weight:inherit}
.list-head,.person-row{grid-template-columns:1.55fr .95fr 92rpx}.person-row{align-items:center;padding-top:14rpx;padding-bottom:14rpx}.name-line{display:flex;align-items:center;gap:8rpx}.identity em{margin:0}.identity small{margin-top:5rpx}.area-count{align-self:center;color:var(--wms-primary-700);font-size:20rpx;font-weight:600}.area-count.empty{color:var(--wms-text-secondary)}.zones .readonly{background:var(--wms-surface-soft);color:var(--wms-primary-700)}.actions.single button{width:100%;background:var(--wms-primary-700);color:#fff}
.check{border-radius:6rpx}.head-select{display:flex;align-items:center;gap:8rpx;white-space:nowrap}.head-select .check{border-color:#fff}.head-select .check.checked{background:#fff;color:var(--wms-primary-700)}
.identity b{font-size:21rpx}
.list-head{padding-left:10rpx}
.permission-entry{display:flex;min-height:52rpx;align-items:center;gap:8rpx;padding:0 16rpx;border:1rpx solid var(--wms-border);border-radius:999rpx;background:var(--wms-surface-soft);color:var(--wms-primary-700);font-size:21rpx;font-weight:600}.permission-entry .chevron{font-size:30rpx;line-height:1;transform:translateY(-1rpx)}
</style>
