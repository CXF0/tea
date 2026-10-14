<script setup lang="ts">
import { computed, reactive, ref } from 'vue'
import { onLoad, onPullDownRefresh } from '@dcloudio/uni-app'
import { qualityApi } from '@/features/quality/api/quality.api'
import type { QualityStatisticsDetail } from '@/features/quality/models/quality'
import WareState from '@/shared/components/WareState.vue'
import SessionDatePicker from '@/shared/components/SessionDatePicker.vue'
import { sessionStore } from '@/store/session'

type TabKey = 'zone' | 'staff' | 'supplier'
type IssueType = 'all' | 'downgrade' | 'shortage' | 'return' | 'exchange'

const date = ref(new Date().toISOString().slice(0, 10))
const zone = ref('')
const keyword = ref('')
const activeTab = ref<TabKey>('zone')
const issueType = ref<IssueType>('all')
const pickerVisible = ref(false)
const typeVisible = ref(false)
const loading = ref(true)
const error = ref('')
const detail = ref<QualityStatisticsDetail | null>(null)
const draft = reactive({ issueType: 'all' as IssueType })

const typeLabels: Record<IssueType, string> = {
  all: '全部类型',
  downgrade: '降级',
  shortage: '缺货',
  return: '退货',
  exchange: '换货',
}
const summary = computed(() => detail.value?.summary)
const visibleRows = computed(() => {
  if (activeTab.value === 'zone') return detail.value?.zoneRows ?? []
  if (activeTab.value === 'staff') return detail.value?.staffRows ?? []
  return detail.value?.supplierLocationRows ?? []
})

async function load() {
  if (!sessionStore.can('quality.statistics')) { loading.value = false; return }
  loading.value = true
  error.value = ''
  try {
    detail.value = await qualityApi.getStatisticsDetail(date.value, zone.value, keyword.value.trim(), issueType.value)
  } catch (cause) {
    error.value = cause instanceof Error ? cause.message : '质检详情加载失败'
  } finally {
    loading.value = false
    uni.stopPullDownRefresh()
  }
}
function chooseDate(value: string) {
  date.value = value
  pickerVisible.value = false
  load()
}
function openType() {
  draft.issueType = issueType.value
  typeVisible.value = true
}
function applyType() {
  issueType.value = draft.issueType
  typeVisible.value = false
  load()
}
function resetType() {
  draft.issueType = 'all'
}
let searchTimer: ReturnType<typeof setTimeout> | undefined
function onKeywordInput() {
  if (searchTimer) clearTimeout(searchTimer)
  searchTimer = setTimeout(load, 280)
}
onLoad((query) => {
  if (query?.date) date.value = String(query.date)
  if (query?.zone) zone.value = String(query.zone)
  load()
})
onPullDownRefresh(load)
</script>

<template>
  <view class="page">
    <WareState v-if="!sessionStore.can('quality.statistics')" type="forbidden" title="暂无质检统计权限" description="请联系管理员开通质检统计权限" />
    <template v-else>
      <view class="filter-row">
        <view class="date-trigger" @click="pickerVisible = true">{{ date }} 场次<i /></view>
        <view class="type-trigger" @click="openType">问题类型：{{ typeLabels[issueType] }}<i /></view>
      </view>
      <view class="search-box">
        <input v-model="keyword" placeholder="质检员 / 供应商 / 货位" confirm-type="search" @input="onKeywordInput" @confirm="load" />
      </view>

      <view class="summary-card">
        <view class="card-head">
          <b>质检问题统计</b>
          <small>场次：{{ date }}</small>
        </view>
        <view class="summary-grid">
          <view><small>降级</small><b>{{ summary?.downgradeUnits ?? 0 }}<i>扎</i></b></view>
          <view><small>缺货</small><b>{{ summary?.shortageUnits ?? 0 }}<i>扎</i></b></view>
          <view><small>退货</small><b>{{ summary?.returnUnits ?? 0 }}<i>扎</i></b></view>
          <view><small>换货</small><b>{{ summary?.exchangeUnits ?? 0 }}<i>扎</i></b></view>
        </view>
        <view class="scope-grid">
          <span><small>退货转到场</small><b>{{ summary?.returnTransferUnits ?? 0 }} 扎</b></span>
          <span><small>涉及货位</small><b>{{ summary?.involvedLocationCount ?? 0 }} 个</b></span>
          <span><small>涉及供应商</small><b>{{ summary?.involvedSupplierCount ?? 0 }} 家</b></span>
        </view>
      </view>

      <view class="tab-row">
        <text :class="{ active: activeTab === 'zone' }" @click="activeTab = 'zone'">分区质检详情</text>
        <text :class="{ active: activeTab === 'staff' }" @click="activeTab = 'staff'">人员汇总</text>
        <text :class="{ active: activeTab === 'supplier' }" @click="activeTab = 'supplier'">按供应商&货位</text>
      </view>

      <WareState v-if="loading" type="loading" title="正在加载质检详情" />
      <WareState v-else-if="error" type="error" title="加载失败" :description="error" action-label="重试" @action="load" />
      <WareState v-else-if="!visibleRows.length" type="empty" title="暂无质检问题统计" description="当前筛选条件下没有问题记录" />
      <template v-else-if="activeTab === 'zone'">
        <view class="table-head zone-head"><text>分区</text><text>换货</text><text>缺货</text><text>降级</text><text>退货转代卖</text></view>
        <view class="table-body">
          <view v-for="item in detail?.zoneRows" :key="item.zone" class="table-row zone-row">
            <text>{{ item.name }}</text>
            <b>{{ item.exchangeUnits }}</b>
            <b>{{ item.shortageUnits }}</b>
            <b>{{ item.downgradeUnits }}</b>
            <b>{{ item.resaleUnits }}</b>
          </view>
        </view>
      </template>
      <template v-else-if="activeTab === 'staff'">
        <view class="table-head staff-head"><text>质检员</text><text>降级</text><text>缺货</text><text>退货</text><text>换货</text></view>
        <view class="table-body">
          <view v-for="item in detail?.staffRows" :key="item.inspectorId + item.inspectorName" class="table-row staff-row">
            <text>{{ item.inspectorName }}</text>
            <b>{{ item.downgradeUnits }}</b>
            <b>{{ item.shortageUnits }}</b>
            <b>{{ item.returnUnits }}</b>
            <b>{{ item.exchangeUnits }}</b>
          </view>
        </view>
      </template>
      <template v-else>
        <view class="table-head supplier-head"><text>供应商&货位</text><text>花材</text><text>问题</text><text>退/换</text></view>
        <view class="table-body">
          <view v-for="item in detail?.supplierLocationRows" :key="`${item.supplierId}-${item.location}`" class="table-row supplier-row">
            <view><text>{{ item.supplierName }}</text><small>{{ item.location }}</small></view>
            <b>{{ item.flowerCount }}</b>
            <b>{{ item.issueUnits }}</b>
            <span>{{ item.returnUnits }}/{{ item.exchangeUnits }}</span>
          </view>
        </view>
      </template>

      <SessionDatePicker v-model="date" v-model:visible="pickerVisible" @confirm="chooseDate" />
      <view v-if="typeVisible" class="mask" @click="typeVisible = false">
        <view class="drawer" @click.stop>
          <view class="drawer-head"><b>问题类型</b><text @click="typeVisible = false">关闭</text></view>
          <view class="option-grid">
            <view v-for="(label, key) in typeLabels" :key="key" :class="{ active: draft.issueType === key }" @click="draft.issueType = key as IssueType">{{ label }}</view>
          </view>
          <view class="drawer-actions"><button @click="resetType">重置</button><button class="primary" @click="applyType">确定</button></view>
        </view>
      </view>
    </template>
  </view>
</template>

<style scoped lang="scss">
.page{min-height:100vh;padding:18rpx 24rpx 48rpx;background:var(--wms-surface-page);box-sizing:border-box}
.filter-row{display:grid;grid-template-columns:1fr 1.18fr;gap:12rpx}.date-trigger,.type-trigger{display:flex;height:58rpx;align-items:center;justify-content:space-between;padding:0 16rpx;border:1rpx solid var(--wms-border);border-radius:8rpx;background:#fff;color:var(--wms-primary-700);font-size:22rpx}.date-trigger i,.type-trigger i{width:8rpx;height:8rpx;border-right:2rpx solid currentColor;border-bottom:2rpx solid currentColor;transform:translateY(-2rpx) rotate(45deg)}
.search-box{margin-top:12rpx}.search-box input{height:62rpx;padding:0 18rpx;border:1rpx solid var(--wms-border);border-radius:8rpx;background:#fff;font-size:24rpx;box-sizing:border-box}
.summary-card{margin-top:16rpx;padding:20rpx;border:1rpx solid var(--wms-border);border-radius:var(--wms-radius-card);background:#fff;box-shadow:var(--wms-shadow-card)}.card-head{display:flex;align-items:center;justify-content:space-between}.card-head b{font-size:27rpx}.card-head small{color:var(--wms-text-secondary);font-size:21rpx}
.summary-grid{display:grid;grid-template-columns:repeat(4,minmax(0,1fr));gap:10rpx;margin-top:18rpx}.summary-grid view{padding:15rpx 8rpx;border-radius:11rpx;background:var(--wms-surface-soft);text-align:center}.summary-grid small,.summary-grid b{display:block}.summary-grid b{margin-top:4rpx;color:var(--wms-primary-700);font-size:30rpx;white-space:nowrap}.summary-grid i{margin-left:3rpx;font-size:18rpx;font-style:normal;font-weight:500}
.scope-grid{display:grid;grid-template-columns:repeat(3,minmax(0,1fr));gap:10rpx;margin-top:14rpx;padding-top:14rpx;border-top:1rpx solid var(--wms-border)}.scope-grid span{min-width:0}.scope-grid small,.scope-grid b{display:block}.scope-grid small{color:var(--wms-text-secondary);font-size:20rpx}.scope-grid b{margin-top:4rpx;font-size:22rpx;white-space:nowrap}
.tab-row{display:flex;gap:26rpx;margin-top:18rpx;padding:0 2rpx;border-bottom:1rpx solid var(--wms-border)}.tab-row text{position:relative;padding:0 0 13rpx;color:var(--wms-text-secondary);font-size:24rpx}.tab-row text.active{color:var(--wms-primary-700);font-weight:700}.tab-row text.active:after{content:"";position:absolute;right:0;bottom:-1rpx;left:0;height:4rpx;border-radius:3rpx;background:var(--wms-primary-700)}
.table-head,.table-row{display:grid;align-items:center}.zone-head,.zone-row{grid-template-columns:1fr .7fr .7fr .7fr 1fr}.staff-head,.staff-row{grid-template-columns:1.3fr repeat(4,.65fr)}.supplier-head,.supplier-row{grid-template-columns:1.65fr .55fr .55fr .7fr}.table-head{height:58rpx;margin-top:14rpx;padding:0 14rpx;border-radius:9rpx 9rpx 0 0;background:var(--wms-primary-700);color:#fff;font-size:21rpx;font-weight:700}.table-head text{text-align:center}.table-head text:first-child{text-align:left}.table-row{min-height:58rpx;padding:0 14rpx;border-bottom:5rpx solid #fff;background:rgba(224,242,237,.7);font-size:22rpx}.table-row:nth-child(even){background:#fff}.table-row text{font-weight:650}.table-row b,.table-row span{text-align:center;font-size:22rpx;font-weight:650}.supplier-row view{min-width:0}.supplier-row view text,.supplier-row view small{display:block;overflow:hidden;text-overflow:ellipsis;white-space:nowrap}.supplier-row view small{margin-top:3rpx;color:var(--wms-text-secondary);font-size:19rpx}
.mask{position:fixed;z-index:40;inset:0;background:rgba(23,43,41,.28);display:flex;align-items:flex-end}.drawer{width:100%;padding:24rpx 24rpx calc(24rpx + env(safe-area-inset-bottom));border-radius:22rpx 22rpx 0 0;background:#fff;box-sizing:border-box}.drawer-head{display:flex;align-items:center;justify-content:space-between}.drawer-head b{font-size:28rpx}.drawer-head text{color:var(--wms-primary-700);font-size:23rpx}.option-grid{display:grid;grid-template-columns:repeat(3,minmax(0,1fr));gap:12rpx;margin-top:24rpx}.option-grid view{display:flex;height:76rpx;align-items:center;justify-content:center;border:1rpx solid var(--wms-border);border-radius:9rpx;background:#fff;font-size:24rpx}.option-grid view.active{border-color:var(--wms-primary-700);background:var(--wms-surface-soft);color:var(--wms-primary-700);font-weight:700}.drawer-actions{display:flex;justify-content:center;gap:120rpx;margin-top:28rpx}.drawer-actions button{width:112rpx;height:64rpx;margin:0;border:1rpx solid var(--wms-border);border-radius:8rpx;background:#fff;font-size:24rpx;line-height:64rpx}.drawer-actions button:after{border:0}.drawer-actions .primary{border-color:var(--wms-primary-700);background:var(--wms-primary-700);color:#fff}
</style>
