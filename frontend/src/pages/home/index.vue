<script setup lang="ts">
import { computed, ref } from 'vue'
import { onLoad } from '@dcloudio/uni-app'
import { getDashboard, type Dashboard } from '@/api/dashboard'

const loading = ref(true)
const error = ref('')
const data = ref<Dashboard | null>(null)
const progress = computed(() => data.value ? Math.round(data.value.progress.completed / data.value.progress.total * 100) : 0)

async function loadDashboard() {
  loading.value = true
  error.value = ''
  try { data.value = await getDashboard() }
  catch { error.value = '数据加载失败，请检查网络后重试' }
  finally { loading.value = false }
}

function scanInbound() {
  uni.scanCode({ success: ({ result }) => uni.showToast({ title: `已识别 ${result}`, icon: 'none' }) })
}

onLoad(loadDashboard)
</script>

<template>
  <view class="page">
    <view class="identity">
      <view><text class="hello">早上好，仓管员</text><text class="session">当前场次 {{ data?.session || '--' }}</text></view>
      <text class="role">仓库管理员</text>
    </view>

    <view v-if="loading" class="state-card">正在加载今日仓库数据…</view>
    <view v-else-if="error" class="state-card error">
      <text>{{ error }}</text><button class="retry" @click="loadDashboard">重新加载</button>
    </view>
    <template v-else-if="data">
      <view class="work-card">
        <text class="work-label">今日待入库</text>
        <view><text class="work-number">{{ data.pendingInbound }}</text><text class="unit"> 件</text></view>
        <text class="work-progress">处理进度 {{ data.progress.completed }}/{{ data.progress.total }}</text>
        <view class="bar"><view class="bar-inner" :style="{ width: `${progress}%` }" /></view>
        <button class="primary" @click="scanInbound">扫码入库</button>
      </view>

      <view class="metrics">
        <view><text class="number">{{ data.stockTotal }}</text><text>库存总件数</text></view>
        <view><text class="number">{{ data.arrivedToday }}</text><text>今日到场</text></view>
        <view><text class="number warning">{{ data.pendingQuality }}</text><text>待质检</text></view>
      </view>

      <view class="section">
        <text class="section-title">快捷操作</text>
        <view class="actions">
          <view class="action" @click="scanInbound"><view class="icon scan"><i /><i /><i /><i /></view><text>扫码入库</text></view>
          <view class="action"><view class="icon">库</view><text>库存查询</text></view>
          <view class="action"><view class="icon">货</view><text>货架管理</text></view>
          <view class="action"><view class="icon">单</view><text>入库记录</text></view>
        </view>
      </view>

      <view class="notice"><text class="notice-title">待处理提醒</text><text>货架 #07-001 有 {{ data.pendingQuality }} 件鲜花等待质检，请及时跟进。</text></view>
    </template>
  </view>
</template>

<style scoped lang="scss">
.page { padding: 28rpx 24rpx 48rpx; }
.identity { display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 24rpx; }
.hello, .session { display: block; }.hello { font-size: 40rpx; font-weight: 700; }.session { margin-top: 10rpx; color: #7b8492; font-size: 24rpx; }
.role { padding: 10rpx 16rpx; border-radius: 16rpx; background: var(--wms-surface-soft); color: var(--wms-primary-700); font-size: 24rpx; }
.state-card, .work-card, .metrics, .section, .notice { border-radius: 24rpx; background: #fff; }
.state-card { padding: 48rpx 28rpx; color: #7b8492; text-align: center; }.state-card.error { color: #e34d59; }.retry { margin-top: 24rpx; width: 220rpx; font-size: 28rpx; }
.work-card { padding: 32rpx; background: var(--wms-primary-700); color: #fff; }
.work-label, .work-progress { display: block; font-size: 26rpx; opacity: .84; }.work-number { font-size: 68rpx; font-weight: 800; }.unit { font-size: 28rpx; }
.work-progress { margin-top: 16rpx; }.bar { height: 10rpx; margin: 14rpx 0 28rpx; overflow: hidden; border-radius: 10rpx; background: rgba(255,255,255,.25); }.bar-inner { height: 100%; border-radius: 10rpx; background: #fff; }
.primary { height: 92rpx; border-radius: 18rpx; background: #fff; color: var(--wms-primary-700); font-size: 32rpx; font-weight: 700; line-height: 92rpx; }
.metrics { display: flex; margin-top: 20rpx; padding: 28rpx 0; }.metrics view { display: flex; flex: 1; flex-direction: column; align-items: center; color: #7b8492; font-size: 23rpx; border-right: 1rpx solid #e8ebf0; }.metrics view:last-child { border: 0; }.number { margin-bottom: 8rpx; color: #20242c; font-size: 40rpx; font-weight: 700; }.number.warning { color: #f3a126; }
.section { margin-top: 20rpx; padding: 28rpx 24rpx; }.section-title { font-size: 32rpx; font-weight: 700; }.actions { display: grid; grid-template-columns: repeat(4, 1fr); margin-top: 26rpx; }.action { display: flex; flex-direction: column; align-items: center; gap: 14rpx; font-size: 23rpx; }.icon { display: flex; width: 80rpx; height: 80rpx; align-items: center; justify-content: center; border-radius: 20rpx; background: var(--wms-surface-soft); color: var(--wms-primary-700); font-size: 30rpx; font-weight: 700; }
.scan { position: relative; }.scan i { position: absolute; width: 18rpx; height: 18rpx; border-color: currentColor; }.scan i:nth-child(1) { left: 18rpx; top: 18rpx; border-left: 4rpx solid; border-top: 4rpx solid; }.scan i:nth-child(2) { right: 18rpx; top: 18rpx; border-right: 4rpx solid; border-top: 4rpx solid; }.scan i:nth-child(3) { left: 18rpx; bottom: 18rpx; border-left: 4rpx solid; border-bottom: 4rpx solid; }.scan i:nth-child(4) { right: 18rpx; bottom: 18rpx; border-right: 4rpx solid; border-bottom: 4rpx solid; }
.notice { margin-top: 20rpx; padding: 28rpx; color: #7b8492; font-size: 26rpx; line-height: 1.6; }.notice-title { display: block; margin-bottom: 8rpx; color: #20242c; font-size: 30rpx; font-weight: 700; }
</style>
