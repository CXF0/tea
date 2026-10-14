<script setup lang="ts">
import { ref } from 'vue'
import { onLoad, onPullDownRefresh } from '@dcloudio/uni-app'
import { workforceApi, type Inspector } from '../../api/workforce.api'
import WareState from '@/shared/components/WareState.vue'

const people = ref<Inspector[]>([])
const zones = ref<string[]>([])
const summary = ref({ total: 0, present: 0, rest: 0 })
const keyword = ref('')
const status = ref<''|0|1>('')
const areas = ref<string[]>([])
const draftAreas = ref<string[]>([])
const areaVisible = ref(false)
const statusVisible = ref(false)
const loading = ref(true)
const updatingId = ref<number>()
const error = ref('')

async function load() {
  loading.value = true
  error.value = ''
  try {
    const data = await workforceApi.attendance(keyword.value.trim(), status.value, areas.value)
    people.value = data.people
    zones.value = data.zones
    summary.value = data.summary
  } catch (cause) { error.value = cause instanceof Error ? cause.message : '加载失败' }
  finally { loading.value = false; uni.stopPullDownRefresh() }
}
function clearSearch() { keyword.value = ''; load() }
function change(person: Inspector) {
  const target = person.status === 1 ? 0 : 1
  uni.showModal({
    title: '调整假勤状态',
    content: `确认将 ${person.name}（ID ${person.userId}）设为${target ? '出勤' : '休息'}？`,
    success: async result => {
      if (!result.confirm) return
      updatingId.value = person.userId
      try {
        await workforceApi.updateAttendance(person.userId, target)
        uni.showToast({ title: `已设为${target ? '出勤' : '休息'}`, icon: 'success' })
        await load()
      } catch (cause) { uni.showToast({ title: cause instanceof Error ? cause.message : '更新失败', icon: 'none' }) }
      finally { updatingId.value = undefined }
    },
  })
}
function openAreas() { draftAreas.value = [...areas.value]; areaVisible.value = true }
function toggleArea(value: string) { draftAreas.value = draftAreas.value.includes(value) ? draftAreas.value.filter(area => area !== value) : [...draftAreas.value, value] }
function selectAllAreas() { draftAreas.value = [] }
function confirmAreas() { areas.value = [...draftAreas.value]; areaVisible.value = false; load() }
function chooseStatus(value: ''|0|1) { status.value = value; statusVisible.value = false; load() }
function openTasks(person: Inspector) {
  uni.navigateTo({ url: `/features/quality/pages/tasks/index?assigneeUserId=${person.userId}&assigneeName=${encodeURIComponent(person.name)}&attendanceStatus=${person.status}` })
}
onLoad(load)
onPullDownRefresh(load)
</script>

<template>
  <view class="page">
    <view class="summary">
      <view><b>{{ summary.total }}</b><text>质检总人数</text></view>
      <view><b>{{ summary.present }}</b><text>出勤人数</text></view>
      <view><b>{{ summary.rest }}</b><text>休息人数</text></view>
    </view>

    <view class="toolbar">
      <view class="search"><text class="search-icon">⌕</text><input v-model="keyword" placeholder="质检员姓名/ID" confirm-type="search" @confirm="load" /><text v-if="keyword" class="clear" @click="clearSearch">×</text></view>
      <view :class="['filter',{active:areas.length}]" @click="openAreas"><text>{{ areas.length ? `已选${areas.length}个分区` : '全部分区' }}</text><i /></view>
      <view :class="['filter',{active:status!==''}]" @click="statusVisible=true"><text>{{ status === '' ? '假勤状态' : status === 1 ? '出勤' : '休息' }}</text><i /></view>
    </view>

    <WareState v-if="loading" type="loading" title="正在加载质检人员" />
    <WareState v-else-if="error" type="error" title="加载失败" :description="error" action-label="重试" @action="load" />
    <view v-else-if="people.length" class="staff-table">
      <view class="table-head"><text>质检员信息</text><text>已配置分区</text><text>假勤状态</text><text>操作</text></view>
      <view v-for="person in people" :key="person.id" class="staff-row" @click="openTasks(person)">
        <view class="staff"><b>{{ person.name }}</b><small>ID：{{ person.userId }}</small></view>
        <text class="areas">{{ person.areas.length ? person.areas.map(value => `${value}区`).join('、') : '未配置' }}</text>
        <text :class="['status-tag',person.status ? 'present' : 'rest']">{{ person.status ? '出勤' : '休息' }}</text>
        <button :class="{presentAction:!person.status}" :disabled="updatingId===person.userId" @click.stop="change(person)">{{ updatingId===person.userId ? '更新中' : person.status ? '设为休息' : '设为出勤' }}</button>
      </view>
    </view>
    <WareState v-else type="empty" title="暂无质检人员" description="当前筛选条件下没有人员记录" />

    <view v-if="areaVisible" class="mask" @click="areaVisible=false"><view class="drawer" @click.stop><view class="drawer-title"><b>选择分区</b><text @click="selectAllAreas">{{ draftAreas.length ? '清空' : '全部分区' }}</text></view><scroll-view scroll-y class="option-scroll"><view class="options"><view :class="{active:!draftAreas.length}" @click="selectAllAreas">全部分区</view><view v-for="zone in zones" :key="zone" :class="{active:draftAreas.includes(zone)}" @click="toggleArea(zone)">{{ zone }}区</view></view></scroll-view><view class="drawer-actions"><button @click="areaVisible=false">取消</button><button @click="confirmAreas">确认</button></view></view></view>
    <view v-if="statusVisible" class="mask" @click="statusVisible=false"><view class="drawer status-drawer" @click.stop><view class="drawer-title"><b>选择假勤状态</b><text @click="statusVisible=false">关闭</text></view><view class="options status-options"><view :class="{active:status===''}" @click="chooseStatus('')">全部状态</view><view :class="{active:status===1}" @click="chooseStatus(1)">出勤</view><view :class="{active:status===0}" @click="chooseStatus(0)">休息</view></view></view></view>
  </view>
</template>

<style scoped lang="scss">
.page{box-sizing:border-box;min-height:100vh;padding:18rpx 20rpx;background:var(--wms-background)}.summary{display:grid;grid-template-columns:repeat(3,1fr);gap:10rpx}.summary view{padding:16rpx 10rpx;background:#fff}.summary b,.summary text{display:block}.summary b{color:var(--wms-primary-700);font-size:32rpx}.summary text{margin-top:3rpx;color:var(--wms-primary-700);font-size:19rpx}.toolbar{display:grid;grid-template-columns:minmax(150rpx,1fr) auto auto;align-items:center;gap:10rpx;margin:14rpx 0}.search{display:flex;height:56rpx;align-items:center;padding:0 10rpx;border:1rpx solid var(--wms-border);border-radius:10rpx;background:#fff}.search-icon{color:var(--wms-text-secondary)}.search input{min-width:0;flex:1;margin-left:6rpx;font-size:18rpx}.clear{padding:8rpx;color:var(--wms-text-secondary)}.filter{display:flex;height:56rpx;align-items:center;gap:7rpx;padding:0 13rpx;border:1rpx solid var(--wms-border);border-radius:10rpx;background:#fff;color:var(--wms-text-secondary);font-size:18rpx;white-space:nowrap}.filter.active{border-color:var(--wms-primary-700);background:var(--wms-surface-soft);color:var(--wms-primary-700);font-weight:600}.filter i{width:9rpx;height:9rpx;border:0;border-right:2rpx solid currentColor;border-bottom:2rpx solid currentColor;transform:rotate(45deg) translateY(-2rpx)}.staff-table{overflow:hidden}.table-head,.staff-row{display:grid;grid-template-columns:1.2fr 1.15fr .72fr .78fr;align-items:center;gap:8rpx}.table-head{min-height:56rpx;padding:0 12rpx;background:var(--wms-primary-700);color:#fff;font-size:18rpx;font-weight:600}.staff-row{min-height:72rpx;margin-top:5rpx;padding:8rpx 12rpx;background:#fff;font-size:18rpx}.staff b,.staff small{display:block}.staff b{font-size:20rpx}.staff small{margin-top:2rpx;color:var(--wms-text-secondary);font-size:16rpx}.areas{line-height:1.35;word-break:break-all}.status-tag{justify-self:start;padding:5rpx 9rpx;border-radius:4rpx;font-size:17rpx;white-space:nowrap}.present{background:var(--wms-surface-soft);color:var(--wms-success)}.rest{background:#fde8e8;color:var(--wms-danger)}.staff-row button{min-width:0;margin:0;padding:0;border:0;background:transparent;color:var(--wms-danger);font-size:17rpx;line-height:1.3;white-space:nowrap}.staff-row button::after{border:0}.staff-row button.presentAction{color:var(--wms-primary-700)}.staff-row button[disabled]{opacity:.5}.mask{position:fixed;z-index:80;inset:0;display:flex;align-items:flex-end;background:#0007}.drawer{box-sizing:border-box;width:100%;padding:28rpx 24rpx calc(24rpx + env(safe-area-inset-bottom));border-radius:26rpx 26rpx 0 0;background:#fff}.drawer-title{display:flex;align-items:center;justify-content:space-between}.drawer-title text{color:var(--wms-primary-700)}.option-scroll{max-height:56vh}.options{display:grid;grid-template-columns:repeat(3,1fr);gap:12rpx;margin-top:22rpx}.options view{display:flex;min-height:68rpx;align-items:center;justify-content:center;border-radius:10rpx;background:var(--wms-background)}.options view.active{background:var(--wms-primary-700);color:#fff}.status-options{margin-bottom:12rpx}
.status-drawer{min-height:360rpx}.toolbar{grid-template-columns:minmax(240rpx,1fr) auto auto}.staff-row>button{justify-self:start;text-align:left}.drawer-actions{display:flex;margin-top:20rpx}.drawer-actions button{width:50%;margin:0;border-radius:0;font-size:22rpx}.drawer-actions button:last-child{background:var(--wms-primary-700);color:#fff}.drawer-actions button::after{border:0}
</style>
