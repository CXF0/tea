<script setup lang="ts">
import { computed, ref } from 'vue'
import { onLoad, onPullDownRefresh, onShow } from '@dcloudio/uni-app'
import { admissionApi } from '../../api/admission.api'
import type { AdmissionRecord, AdmissionSummary } from '../../models/admission'
import WareState from '@/shared/components/WareState.vue'
import { sessionStore } from '@/store/session'
import SessionDatePicker from '@/shared/components/SessionDatePicker.vue'
import SessionTrigger from '@/shared/components/SessionTrigger.vue'

const session = ref(new Date().toISOString().slice(0, 10))
const activeStatus = ref<'all' | 0 | 1>('all')
const keyword = ref('')
const loading = ref(true)
const error = ref('')
const summary = ref<AdmissionSummary>({ total: 0, pending: 0, admitted: 0, late: 0, priority: 0 })
const records = ref<AdmissionRecord[]>([])
const sessionPickerVisible=ref(false)
const scannedSupplierId=ref<number>()
const scanPrompted=ref(false)
const tabs = computed(() => [{ label: '全部', value: 'all', count: summary.value.total }, { label: '未入场', value: 0, count: summary.value.pending }, { label: '已入场', value: 1, count: summary.value.admitted }])

async function load() {
  if (!sessionStore.can('admission.view')) { loading.value = false; return }
  loading.value = true; error.value = ''
  try {
    const [summaryData, recordData] = await Promise.all([admissionApi.getSummary(session.value), admissionApi.getRecords(session.value, activeStatus.value === 'all' ? undefined : activeStatus.value, keyword.value, scannedSupplierId.value)])
    summary.value = summaryData; records.value = recordData
    if (scannedSupplierId.value && !scanPrompted.value) {
      scanPrompted.value = true
      const record = recordData[0]
      if (!record) uni.showToast({ title: '当前场次未找到该供应商', icon: 'none' })
      else if (record.status === 1) uni.showToast({ title: '该供应商已经入场', icon: 'none' })
      else confirmStatus(record)
    }
  } catch (cause) { error.value = cause instanceof Error ? cause.message : '入场数据加载失败' }
  finally { loading.value = false; uni.stopPullDownRefresh() }
}

function changeTab(value: string | number) { activeStatus.value = value === 'all' ? 'all' : Number(value) as 0 | 1; load() }
function confirmStatus(record: AdmissionRecord) {
  if (!sessionStore.can('admission.confirm')) return uni.showToast({ title: '当前账户只有查看权限', icon: 'none' })
  const next = record.status === 1 ? 0 : 1
  uni.showModal({ title: next ? '确认入场' : '取消入场', content: next ? `确认“${record.supplierName}”已经到场？` : `确认取消“${record.supplierName}”的入场状态？`, confirmColor: next ? '#0F766E' : '#C93636', success: async ({ confirm }) => {
    if (!confirm) return
    try { await admissionApi.setStatus(record.id, next); uni.showToast({ title: next ? '已确认入场' : '已取消入场', icon: 'success' }); await load() }
    catch (cause) { uni.showToast({ title: cause instanceof Error ? cause.message : '操作失败', icon: 'none' }) }
  } })
}

onLoad(query => { if (query?.date) session.value = String(query.date); if(query?.supplierId)scannedSupplierId.value=Number(query.supplierId); load() })
onShow(load); onPullDownRefresh(load)
</script>

<template>
  <view class="page">
    <view class="page-head"><SessionTrigger :value="session" @click="sessionPickerVisible=true"/><view class="head-badge">供应商入场</view></view>
    <WareState v-if="!sessionStore.can('admission.view')" type="forbidden" title="暂无入场管理权限" description="请联系管理员开通 admission.view 能力" />
    <template v-else>
      <view class="summary"><view><text>需入场</text><strong>{{ summary.total }}</strong></view><view><text>未入场</text><strong>{{ summary.pending }}</strong></view><view><text>已入场</text><strong>{{ summary.admitted }}</strong></view></view>
      <view class="search"><image src="/static/icons/wms/fwms-scan-outline.svg" /><input v-model="keyword" confirm-type="search" placeholder="搜索供应商名称或手机号" @confirm="load" /><text v-if="keyword" @click="keyword='';load()">清除</text></view>
      <view class="tabs"><view v-for="tab in tabs" :key="String(tab.value)" :class="['tab',{active:activeStatus===tab.value}]" @click="changeTab(tab.value)">{{ tab.label }} <text>{{ tab.count }}</text></view></view>
      <WareState v-if="loading" type="loading" title="正在加载入场记录" />
      <WareState v-else-if="error" type="error" title="加载失败" :description="error" action-label="重新加载" @action="load" />
      <view v-else-if="records.length" class="list">
        <view v-for="record in records" :key="record.id" class="record">
          <view class="record-main"><view class="name-row"><text class="name">{{ record.supplierName }}</text></view><text class="meta">{{ record.phone || '未留手机号' }} · {{ record.itemCount }} 种 · {{ record.itemQuantity }} 扎</text><view class="flags"><text v-if="record.priorityInspection">重点质检</text><text v-if="record.late" class="danger">迟到</text><text v-if="record.hasQualityIssue" class="danger">有质检异常</text></view></view>
          <button :class="['action',{entered:record.status===1}]" @click="confirmStatus(record)">{{ record.status === 1 ? '已入场' : '确认入场' }}</button>
        </view>
      </view>
      <WareState v-else type="empty" title="当前条件暂无入场记录" description="可切换状态、调整搜索词或下拉刷新" />
    </template>
    <SessionDatePicker v-model="session" v-model:visible="sessionPickerVisible" @confirm="load"/>
  </view>
</template>

<style scoped lang="scss">
.page{min-height:100vh;padding:28rpx 24rpx 56rpx}.page-head{display:flex;align-items:flex-start;justify-content:space-between}.title,.subtitle{display:block}.title{font-size:40rpx;font-weight:800}.subtitle{margin-top:8rpx;color:var(--wms-text-secondary);font-size:24rpx}.head-badge{padding:9rpx 15rpx;border-radius:999rpx;background:var(--wms-surface-soft);color:var(--wms-primary-700);font-size:22rpx;font-weight:700}.summary{display:flex;margin-top:24rpx;padding:26rpx 0;border-radius:var(--wms-radius-card);background:#fff;box-shadow:var(--wms-shadow-card)}.summary view{display:flex;flex:1;align-items:center;flex-direction:column;border-right:1rpx solid var(--wms-border)}.summary view:last-child{border:0}.summary text{color:var(--wms-text-secondary);font-size:23rpx}.summary strong{margin-top:7rpx;font-size:44rpx}.search{display:flex;height:78rpx;align-items:center;gap:14rpx;margin-top:20rpx;padding:0 20rpx;border-radius:18rpx;background:#fff}.search image{width:32rpx;height:32rpx;opacity:.65}.search input{min-width:0;flex:1;font-size:25rpx}.search text{color:var(--wms-primary-700);font-size:23rpx}.tabs{display:flex;height:82rpx;align-items:stretch;gap:34rpx;margin-top:10rpx;border-bottom:1rpx solid var(--wms-border)}.tab{position:relative;display:flex;align-items:center;gap:8rpx;color:var(--wms-text-secondary);font-size:25rpx}.tab.active{color:var(--wms-primary-700);font-weight:750}.tab.active:after{position:absolute;right:0;bottom:-1rpx;left:0;height:5rpx;border-radius:5rpx;background:var(--wms-primary-700);content:''}.list{margin-top:18rpx;overflow:hidden;border-radius:var(--wms-radius-card);background:#fff}.record{display:flex;min-height:150rpx;align-items:center;gap:18rpx;padding:24rpx;border-bottom:1rpx solid var(--wms-border)}.record:last-child{border:0}.record-main{min-width:0;flex:1}.name-row{display:flex;align-items:center;justify-content:space-between;gap:12rpx}.name{overflow:hidden;font-size:29rpx;font-weight:750;white-space:nowrap;text-overflow:ellipsis}.meta{display:block;margin-top:11rpx;color:var(--wms-text-secondary);font-size:22rpx}.flags{display:flex;gap:10rpx;margin-top:11rpx}.flags text{padding:4rpx 9rpx;border-radius:8rpx;background:var(--wms-surface-soft);color:var(--wms-primary-700);font-size:19rpx}.flags .danger{background:#fff0f0;color:var(--wms-danger)}.action{box-sizing:border-box;flex:none;height:66rpx;margin:0;padding:0 17rpx;border:0;border-radius:14rpx;background:var(--wms-primary-700);color:#fff;font-size:22rpx;font-weight:700;line-height:66rpx}.action:after{border:0}.action.entered{background:var(--wms-surface-soft);color:var(--wms-primary-700)}
</style>
<style scoped>.page-head{align-items:center}</style>
