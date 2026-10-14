<script setup lang="ts">
import { ref } from 'vue'
import { onLoad, onPullDownRefresh } from '@dcloudio/uni-app'
import { qualityApi } from '../../api/quality.api'
import type { QualityOperationLog } from '../../models/quality'
import WareState from '@/shared/components/WareState.vue'

const itemId = ref(0)
const logs = ref<QualityOperationLog[]>([])
const loading = ref(true)
const error = ref('')

function formatTime(value: string) {
  return value ? value.replace('T', ' ').slice(0, 19) : '--'
}

async function load() {
  if (!itemId.value) return
  loading.value = true
  error.value = ''
  try {
    logs.value = await qualityApi.getSupplierItemLogs(itemId.value)
  } catch (exception: any) {
    error.value = exception?.message || '操作日志加载失败'
  } finally {
    loading.value = false
    uni.stopPullDownRefresh()
  }
}

onLoad((query) => {
  itemId.value = Number(query?.id || 0)
  if (itemId.value > 0) load()
  else { loading.value = false; error.value = '花材编号无效' }
})
onPullDownRefresh(load)
</script>

<template>
  <view class="page">
    <WareState v-if="loading" type="loading" title="正在加载操作日志" />
    <WareState v-else-if="error" type="error" title="加载失败" :description="error" />
    <WareState v-else-if="!logs.length" type="empty" title="暂无操作记录" description="该货架花材尚未标记质检问题" />
    <view v-else class="log-list">
      <view v-for="(log, index) in logs" :key="`${log.unit}-${log.operatedAt}-${index}`" class="log-card">
        <view class="log-head">
          <view class="unit"><text>花材扎号</text><text>{{ String(log.unit).padStart(4, '0') }}</text></view>
          <text :class="['operation-tag', { inactive: !log.active }]">{{ log.active ? log.operationLabel : '已撤销' }}</text>
        </view>
        <view class="issue"><text>{{ log.category || '质检问题' }}</text><text>{{ log.reason || '未记录原因' }}</text></view>
        <view class="meta"><text>{{ log.operatorName || '系统操作' }}</text><text>{{ formatTime(log.operatedAt) }}</text></view>
      </view>
    </view>
  </view>
</template>

<style scoped lang="scss">
.page{min-height:100vh;padding:24rpx;background:var(--wms-background)}.log-list{display:flex;flex-direction:column;gap:16rpx}.log-card{padding:26rpx;border-radius:var(--wms-radius-card);background:#fff}.log-head,.issue,.meta{display:flex;align-items:center;justify-content:space-between}.unit{display:flex;align-items:baseline;gap:14rpx}.unit text:first-child{color:var(--wms-text-secondary);font-size:21rpx}.unit text:last-child{color:var(--wms-text-primary);font-size:28rpx;font-weight:800}.operation-tag{padding:7rpx 13rpx;border-radius:9rpx;background:#ffebe8;color:#b52d2d;font-size:20rpx;font-weight:700}.operation-tag.inactive{background:#eef1f0;color:var(--wms-text-secondary)}.issue{justify-content:flex-start;gap:12rpx;margin-top:22rpx}.issue text:first-child{padding:6rpx 10rpx;border-radius:8rpx;background:var(--wms-surface-soft);color:var(--wms-primary-700);font-size:19rpx}.issue text:last-child{font-size:24rpx;font-weight:700}.meta{margin-top:20rpx;padding-top:18rpx;border-top:1rpx solid var(--wms-border);color:var(--wms-text-secondary);font-size:20rpx}
</style>
