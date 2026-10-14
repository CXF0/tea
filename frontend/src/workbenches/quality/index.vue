<script setup lang="ts">
import { computed, ref } from 'vue'
import { onLoad, onPullDownRefresh, onShow } from '@dcloudio/uni-app'
import QualityTaskCard from '@/features/quality/components/QualityTaskCard.vue'
import type { QualitySummary, QualityTask } from '@/features/quality/models/quality'
import { qualityService } from '@/features/quality/services/quality.service'
import WareState from '@/shared/components/WareState.vue'
import { sessionStore } from '@/store/session'
import { getGrantedWorkbenchModules, type WorkbenchModule } from '@/app/permission/workbench-modules'

const session = new Date().toISOString().slice(0, 10)
const loading = ref(true)
const error = ref('')
const summary = ref<QualitySummary>({ total: 0, pending: 0, passed: 0, rejected: 0, priorityPending: 0 })
const tasks = ref<QualityTask[]>([])
const completed = computed(() => summary.value.total - summary.value.pending)
const progress = computed(() => summary.value.total ? Math.round(completed.value / summary.value.total * 100) : 0)
const grantedModules = computed(() => getGrantedWorkbenchModules(capability => sessionStore.can(capability)))
const moduleGroups = computed(() => Object.values(grantedModules.value.reduce<Record<string, { label: string; items: WorkbenchModule[] }>>((groups, module) => {
  groups[module.domain] ??= { label: module.domainLabel, items: [] }
  groups[module.domain].items.push(module)
  return groups
}, {})))
const canViewQuality = computed(() => sessionStore.can('quality.view'))

async function load() {
  if (!canViewQuality.value) { loading.value = false; return }
  loading.value = true; error.value = ''
  try { const data = await qualityService.loadWorkbench(session); summary.value = data.summary; tasks.value = data.tasks }
  catch (cause) { error.value = cause instanceof Error ? cause.message : '数据加载失败' }
  finally { loading.value = false; uni.stopPullDownRefresh() }
}

function openTasks() { uni.navigateTo({ url: '/features/quality/pages/tasks/index' }) }
function openTask(task: QualityTask) { uni.navigateTo({ url: `/features/quality/pages/tasks/index?taskId=${task.id}` }) }
function scan() {
  if (!sessionStore.can('quality.scan')) return uni.showToast({ title: '当前账户未开通扫码质检能力', icon: 'none' })
  uni.navigateTo({url:`/pages/scan/index?operation=quality-inspection&date=${encodeURIComponent(session)}`})
}

function openModule(module: WorkbenchModule) {
  if (!sessionStore.can(module.capability)) return uni.showToast({ title: '当前账户暂无此能力', icon: 'none' })
  if (module.path === 'action:quality-scan') return scan()
  uni.navigateTo({ url: module.path })
}

onLoad(load); onShow(load); onPullDownRefresh(load)
</script>

<template>
  <view class="page">
    <view class="identity">
      <view><text class="greeting">{{ sessionStore.state.userName }}</text><text class="warehouse">{{ sessionStore.state.warehouseName }}</text></view>
      <text class="role">{{ sessionStore.profile.value.label }}</text>
    </view>
    <view class="session"><text>当前场次</text><text class="session-value">{{ session }}</text></view>

    <WareState v-if="!grantedModules.length" type="forbidden" title="暂无可用工作能力" description="请联系管理员为当前账户配置能力权限" />
    <WareState v-else-if="loading" type="loading" title="正在加载质检任务" description="正在同步当前场次数据" />
    <WareState v-else-if="error" type="error" title="加载失败" :description="error" action-label="重新加载" @action="load" />
    <template v-else>
      <view v-if="canViewQuality" class="hero">
        <text class="hero-label">今日待质检</text>
        <view><text class="hero-number">{{ summary.pending }}</text><text class="hero-unit"> 项</text></view>
        <text class="hero-progress">完成进度 {{ completed }}/{{ summary.total }}</text>
        <view class="bar"><view class="bar-value" :style="{ width: `${progress}%` }" /></view>
        <button class="scan-button" @click="scan">扫码质检</button>
      </view>

      <view v-if="canViewQuality" class="metrics">
        <view><text class="metric-number">{{ summary.priorityPending }}</text><text>重点质检</text></view>
        <view><text class="metric-number success">{{ summary.passed }}</text><text>质检通过</text></view>
        <view><text class="metric-number danger">{{ summary.rejected }}</text><text>不合格</text></view>
      </view>

      <template v-if="canViewQuality">
        <view class="section-head"><text class="section-title">待办任务</text><text class="more" @click="openTasks">查看全部</text></view>
        <view v-if="tasks.length" class="task-list"><QualityTaskCard v-for="task in tasks" :key="task.id" :task="task" @select="openTask" /></view>
        <WareState v-else type="empty" title="当前场次暂无待检任务" description="下拉刷新或等待新货到场" />
      </template>

      <view class="quick-title">我的工作能力</view>
      <view v-for="group in moduleGroups" :key="group.label" class="capability-section">
        <text class="domain-title">{{ group.label }}</text>
        <view class="module-grid">
          <view v-for="module in group.items" :key="module.id" class="module-card" @click="openModule(module)">
            <image :src="module.icon" />
            <view><text class="module-title">{{ module.title }}</text><text class="module-description">{{ module.description }}</text></view>
          </view>
        </view>
      </view>
    </template>
  </view>
</template>

<style scoped lang="scss">
.page{padding:28rpx 24rpx 56rpx}.identity,.session,.section-head{display:flex;align-items:center;justify-content:space-between}.greeting{display:block;font-size:40rpx;font-weight:750}.warehouse{display:block;margin-top:8rpx;color:var(--wms-text-secondary);font-size:24rpx}.role{padding:10rpx 16rpx;border-radius:999rpx;background:#eaf2ff;color:var(--wms-primary-700);font-size:24rpx}.session{margin:24rpx 0;color:var(--wms-text-secondary);font-size:24rpx}.session-value{color:var(--wms-text);font-weight:650}.hero{padding:32rpx;border-radius:var(--wms-radius-card);background:linear-gradient(135deg,var(--wms-primary-900),var(--wms-primary-700));color:#fff}.hero-label,.hero-progress{display:block;font-size:25rpx;opacity:.86}.hero-number{font-size:70rpx;font-weight:800}.hero-unit{font-size:27rpx}.hero-progress{margin-top:12rpx}.bar{height:8rpx;margin:14rpx 0 28rpx;overflow:hidden;border-radius:8rpx;background:rgba(255,255,255,.24)}.bar-value{height:100%;border-radius:8rpx;background:#fff}.scan-button{height:92rpx;border-radius:var(--wms-radius-control);background:#fff;color:var(--wms-primary-900);font-size:31rpx;font-weight:750;line-height:92rpx}.metrics{display:flex;margin-top:20rpx;padding:28rpx 0;border-radius:var(--wms-radius-card);background:#fff}.metrics view{display:flex;flex:1;align-items:center;flex-direction:column;border-right:1rpx solid var(--wms-border);color:var(--wms-text-secondary);font-size:23rpx}.metrics view:last-child{border:0}.metric-number{margin-bottom:6rpx;color:var(--wms-text);font-size:39rpx;font-weight:750}.success{color:var(--wms-success)}.danger{color:var(--wms-danger)}.section-head{margin:34rpx 4rpx 18rpx}.section-title,.quick-title{font-size:32rpx;font-weight:750}.more{color:var(--wms-primary-700);font-size:25rpx}.task-list{overflow:hidden;border-radius:var(--wms-radius-card)}.quick-title{margin:34rpx 4rpx 18rpx}.capability-section{margin-top:18rpx}.domain-title{display:block;margin:0 4rpx 12rpx;color:var(--wms-text-secondary);font-size:24rpx;font-weight:650}.module-grid{display:grid;grid-template-columns:repeat(2,1fr);gap:16rpx}.module-card{display:flex;min-height:112rpx;align-items:center;gap:18rpx;padding:22rpx;border-radius:var(--wms-radius-card);background:#fff}.module-card image{width:48rpx;height:48rpx;flex:none}.module-title,.module-description{display:block}.module-title{color:var(--wms-text);font-size:27rpx;font-weight:700}.module-description{margin-top:6rpx;color:var(--wms-text-secondary);font-size:21rpx;line-height:1.35}
</style>
