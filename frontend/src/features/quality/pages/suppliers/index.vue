<script setup lang="ts">
import { computed, ref } from 'vue'
import { onLoad, onPullDownRefresh, onShow } from '@dcloudio/uni-app'
import { admissionApi } from '@/features/admission/api/admission.api'
import type { AdmissionRecord, AdmissionSummary } from '@/features/admission/models/admission'
import WareState from '@/shared/components/WareState.vue'
import WareStatus from '@/shared/components/WareStatus.vue'
import { sessionStore } from '@/store/session'
import SessionDatePicker from '@/shared/components/SessionDatePicker.vue'
import SessionTrigger from '@/shared/components/SessionTrigger.vue'

const session = ref(new Date().toISOString().slice(0, 10))
const status = ref<'all' | 0 | 1>('all')
const keyword = ref('')
const loading = ref(true)
const error = ref('')
const summary = ref<AdmissionSummary>({ total: 0, pending: 0, admitted: 0, late: 0, priority: 0 })
const suppliers = ref<AdmissionRecord[]>([])
const sessionPickerVisible=ref(false)
const tabs = computed(() => [{ label: '未入场', value: 0, count: summary.value.pending }, { label: '已入场', value: 1, count: summary.value.admitted }, { label: '全部', value: 'all', count: summary.value.total }])

async function load() {
  if (!sessionStore.can('quality.flower.view')) { loading.value = false; return }
  loading.value = true; error.value = ''
  try { [summary.value, suppliers.value] = await Promise.all([admissionApi.getSummary(session.value), admissionApi.getRecords(session.value, status.value === 'all' ? undefined : status.value, keyword.value)]) }
  catch (cause) { error.value = cause instanceof Error ? cause.message : '供应商列表加载失败' }
  finally { loading.value = false; uni.stopPullDownRefresh() }
}
function changeTab(value: string | number) { status.value = value === 'all' ? 'all' : Number(value) as 0 | 1; load() }
function openSupplier(record: AdmissionRecord) {
  const data = encodeURIComponent(JSON.stringify({ id: record.id, supplierName: record.supplierName, phone: record.phone, status: record.status, session: record.session }))
  uni.navigateTo({ url: `/features/quality/pages/supplier-detail/index?supplier=${data}` })
}
function toggleAdmission(record: AdmissionRecord) {
  if (!sessionStore.can('admission.confirm')) return uni.showToast({ title: '当前账户没有入场操作权限', icon: 'none' })
  const next = record.status === 1 ? 0 : 1
  uni.showModal({ title: next ? '确认入场' : '取消入场', content: next ? `确认“${record.supplierName}”已经到场？` : `确认取消“${record.supplierName}”的入场状态？`, confirmColor: next ? '#0F766E' : '#C93636', success: async ({ confirm }) => {
    if (!confirm) return
    try { await admissionApi.setStatus(record.id, next); uni.showToast({ title: next ? '已确认入场' : '已取消入场', icon: 'success' }); load() }
    catch (cause) { uni.showToast({ title: cause instanceof Error ? cause.message : '操作失败', icon: 'none' }) }
  } })
}
onLoad(query => { if (query?.date) session.value = String(query.date); load() }); onShow(load); onPullDownRefresh(load)
</script>

<template>
  <view class="page">
    <WareState v-if="!sessionStore.can('quality.flower.view')" type="forbidden" title="暂无花材质检权限" description="请联系管理员开通 quality.flower.view 能力" />
    <template v-else>
    <view class="heading"><SessionTrigger :value="session" @click="sessionPickerVisible=true"/><view class="head-badge">按场次供应商开展质检</view></view>
    <view class="search"><text class="search-mark">⌕</text><input v-model="keyword" confirm-type="search" placeholder="供应商名称/手机号查询" @confirm="load" /><text v-if="keyword" @click="keyword='';load()">清除</text></view>
    <view class="tabs"><view v-for="tab in tabs" :key="String(tab.value)" :class="['tab',{active:status===tab.value}]" @click="changeTab(tab.value)">{{ tab.label }}<text>({{ tab.count }})</text></view></view>
    <WareState v-if="loading" type="loading" title="正在加载供应商" />
    <WareState v-else-if="error" type="error" title="加载失败" :description="error" action-label="重试" @action="load" />
    <view v-else-if="suppliers.length" class="list">
      <view v-for="supplier in suppliers" :key="supplier.id" class="supplier" @click="openSupplier(supplier)">
        <view class="supplier-content"><view class="name-row"><text class="name">{{ supplier.supplierName }}</text><WareStatus v-if="supplier.priorityInspection" tone="warning" label="重点质检" /></view><text class="phone">{{ supplier.phone || '未留手机号' }}</text><text class="count">{{ supplier.itemCount }} 个货架条目 · {{ supplier.itemQuantity }} 扎</text></view>
        <button :class="['admission',{entered:supplier.status===1}]" @click.stop="toggleAdmission(supplier)">{{ supplier.status === 1 ? '已入场' : '确认入场' }}</button>
        <text class="chevron">›</text>
      </view>
    </view>
    <WareState v-else type="empty" title="当前场次暂无供应商" description="可切换状态、调整搜索条件或下拉刷新" />
    <SessionDatePicker v-model="session" v-model:visible="sessionPickerVisible" @confirm="load"/>
    </template>
  </view>
</template>

<style scoped lang="scss">
.page{min-height:100vh;padding:28rpx 24rpx 56rpx}.heading{display:flex;align-items:center;justify-content:space-between}.title,.subtitle{display:block}.title{font-size:40rpx;font-weight:800}.subtitle{margin-top:6rpx;color:var(--wms-text-secondary);font-size:23rpx}.date{color:var(--wms-text-secondary);font-size:24rpx}.search{display:flex;height:78rpx;align-items:center;gap:12rpx;margin-top:24rpx;padding:0 20rpx;border-radius:18rpx;background:#fff}.search-mark{color:var(--wms-text-secondary);font-size:36rpx}.search input{min-width:0;flex:1;font-size:25rpx}.search>text:last-child{color:var(--wms-primary-700);font-size:23rpx}.tabs{display:flex;height:82rpx;gap:34rpx;border-bottom:1rpx solid var(--wms-border)}.tab{position:relative;display:flex;align-items:center;gap:5rpx;color:var(--wms-text-secondary);font-size:25rpx}.tab.active{color:var(--wms-primary-700);font-weight:750}.tab.active:after{position:absolute;right:0;bottom:-1rpx;left:0;height:5rpx;border-radius:5rpx;background:var(--wms-primary-700);content:''}.list{margin-top:18rpx;overflow:hidden;border-radius:var(--wms-radius-card);background:#fff}.supplier{display:flex;min-height:146rpx;align-items:center;gap:14rpx;padding:22rpx;border-bottom:1rpx solid var(--wms-border)}.supplier:last-child{border:0}.supplier-content{min-width:0;flex:1}.name-row{display:flex;align-items:center;gap:10rpx}.name{overflow:hidden;font-size:29rpx;font-weight:750;white-space:nowrap;text-overflow:ellipsis}.phone,.count{display:block;margin-top:8rpx;color:var(--wms-text-secondary);font-size:22rpx}.phone{color:var(--wms-primary-700)}.admission{box-sizing:border-box;height:62rpx;margin:0;padding:0 15rpx;border:0;border-radius:14rpx;background:var(--wms-primary-700);color:#fff;font-size:21rpx;font-weight:700;line-height:62rpx}.admission:after{border:0}.admission.entered{background:var(--wms-surface-soft);color:var(--wms-primary-700)}.chevron{color:#9aa7a8;font-size:38rpx}
</style>
<style scoped>.heading{gap:16rpx}.heading :deep(.session-trigger){flex:none}.head-badge{overflow:hidden;min-width:0;padding:9rpx 15rpx;border-radius:999rpx;background:var(--wms-surface-soft);color:var(--wms-primary-700);font-size:22rpx;font-weight:700;white-space:nowrap;text-overflow:ellipsis}</style>
