<script setup lang="ts">
import { computed, ref } from "vue";
import { onLoad, onPullDownRefresh, onShow } from "@dcloudio/uni-app";
import { getDashboard, type Dashboard } from "@/api/dashboard";
import {
  domainEntries,
  resolveConfigured,
  scanOperations,
  workbenchCards,
  type DomainEntry,
  type ScanOperation,
} from "@/app/workbench/configuration-registry";
import type { QualitySummary } from "@/features/quality/models/quality";
import { qualityService } from "@/features/quality/services/quality.service";
import WareState from "@/shared/components/WareState.vue";
import AppBottomNav from "@/shared/components/AppBottomNav.vue";
import { sessionStore } from "@/store/session";
import {
  normalizeShortcutPreferences,
  sortShortcutEntries,
  type ShortcutPreferences,
} from "@/app/workbench/shortcut-preferences";

const formatDate = (date: Date) =>
  `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, "0")}-${String(date.getDate()).padStart(2, "0")}`;
const session = ref(formatDate(new Date()));
const sessionLabel = computed(() => {
  const [, month, day] = session.value.split("-").map(Number);
  return `${month}月${day}日`;
});
const loading = ref(true);
const errors = ref<string[]>([]);
const qualitySummary = ref<QualitySummary | null>(null);
const inventorySummary = ref<Dashboard | null>(null);
const shortcutPreferences = ref<ShortcutPreferences>({ order: [], attention: {} });

const cards = computed(() =>
  resolveConfigured(
    sessionStore.state.workbenchCardIds,
    workbenchCards,
    (capability) => sessionStore.can(capability),
  ),
);
const scans = computed(() =>
  resolveConfigured(
    sessionStore.state.scanOperationIds,
    scanOperations,
    (capability) => sessionStore.can(capability),
  ),
);
const allowedDomains = computed(() =>
  domainEntries.filter((entry) => sessionStore.can(entry.capability)),
);
const domains = computed(() => sortShortcutEntries(allowedDomains.value, shortcutPreferences.value));
const hasCard = (id: string) => cards.value.some((card) => card.id === id);

async function load() {
  loading.value = true;
  errors.value = [];
  const requests: Promise<void>[] = [];
  if (hasCard("quality-session")) {
    requests.push(
      qualityService
        .loadWorkbench(session.value)
        .then((data) => {
          qualitySummary.value = data.summary;
        })
        .catch((cause) => {
          errors.value.push(
            cause instanceof Error ? cause.message : "质检数据加载失败",
          );
        }),
    );
  }
  if (hasCard("inventory-session")) {
    requests.push(
      getDashboard()
        .then((data) => {
          inventorySummary.value = data;
        })
        .catch(() => {
          errors.value.push("库存数据加载失败");
        }),
    );
  }
  await Promise.all(requests);
  loading.value = false;
  uni.stopPullDownRefresh();
}

function runScan(operation: ScanOperation) {
  uni.navigateTo({ url: `/pages/scan/index?operation=${encodeURIComponent(operation.id)}&date=${encodeURIComponent(session.value)}` });
}

function chooseScanOperation() {
  if (!scans.value.length)
    return uni.showToast({ title: "当前账户未配置扫码作业", icon: "none" });
  if (scans.value.length === 1) return runScan(scans.value[0]);
  uni.showActionSheet({
    itemList: scans.value.map((operation) => operation.title),
    success: ({ tapIndex }) => runScan(scans.value[tapIndex]),
  });
}

function openDomain(entry: DomainEntry) {
  uni.navigateTo({ url: entry.path });
}
function loadShortcutPreferences() {
  shortcutPreferences.value = normalizeShortcutPreferences(sessionStore.state.userId, allowedDomains.value);
}
function openShortcutSettings() {
  uni.navigateTo({ url: "/workbenches/home/shortcut-settings" });
}

onLoad(() => { loadShortcutPreferences(); load(); });
onShow(() => { loadShortcutPreferences(); load(); });
onPullDownRefresh(load);
</script>

<template>
  <view class="page">
    <view class="identity">
      <view
        ><text class="warehouse-name">梦花仓管</text
        ><view class="account"
          ><text class="user-name">{{ sessionStore.state.userName }}</text
          ><text class="role">{{ sessionStore.state.roleName }}</text></view
        ><text class="current-session">当前场次：{{ sessionLabel }}</text
        ></view
      >
      <button
        v-if="scans.length"
        class="scan-shortcut"
        aria-label="开始扫码"
        @click="chooseScanOperation"
      >
        <image src="/static/icons/wms/fwms-scan-outline.svg" />
      </button>
    </view>
    <WareState
      v-if="!cards.length && !domains.length && !scans.length"
      type="empty"
      title="工作台暂无内容"
      description="请联系管理员配置角色工作台卡片、业务领域、待办或扫码能力"
    />
    <WareState
      v-else-if="loading"
      type="loading"
      title="正在组装工作台"
      description="正在同步已授权业务领域的数据"
    />
    <template v-else>
      <view v-if="errors.length" class="error-card"
        ><text>{{ errors.join("；") }}</text
        ><text class="retry" @click="load">重新加载</text></view
      >

      <view
        v-if="hasCard('quality-session') && qualitySummary"
        class="summary-card"
      >
        <text class="card-title">本场次任务</text>
        <view class="metric-row"
          ><view
            ><text class="metric-label">待质检</text
            ><text class="metric-number">{{
              qualitySummary.pending
            }}</text></view
          ><view
            ><text class="metric-label">重点任务</text
            ><text class="metric-number">{{
              qualitySummary.priorityPending
            }}</text></view
          ><view
            ><text class="metric-label">不合格</text
            ><text class="metric-number">{{
              qualitySummary.rejected
            }}</text></view
          ></view
        >
      </view>

      <view
        v-if="hasCard('inventory-session') && inventorySummary"
        class="summary-card"
      >
        <text class="card-title">本场次任务</text>
        <view class="metric-row"
          ><view
            ><text class="metric-label">待入库</text
            ><text class="metric-number">{{
              inventorySummary.pendingInbound
            }}</text></view
          ><view
            ><text class="metric-label">今日到场</text
            ><text class="metric-number">{{
              inventorySummary.arrivedToday
            }}</text></view
          ><view
            ><text class="metric-label">待质检</text
            ><text class="metric-number">{{
              inventorySummary.pendingQuality
            }}</text></view
          ></view
        >
      </view>

      <view v-if="domains.length" class="entry-section">
        <view class="entry-section-head"
          ><text class="section-title">快捷作业</text
          ><view class="shortcut-settings" @click.stop="openShortcutSettings"
            ><image src="/static/icons/wms/fwms-sort-outline.svg" /><text
              >自定义</text
            ></view
          ></view
        >
        <view class="entry-grid">
          <view
            v-for="entry in domains"
            :key="entry.id"
            class="entry"
            @click="openDomain(entry)"
          >
            <view
              :class="[
                'icon-surface',
                `attention-${shortcutPreferences.attention[entry.id] || 'default'}`,
              ]"
              ><image :src="entry.icon" /></view
            ><text class="entry-title">{{ entry.title }}</text>
          </view>
        </view>
      </view>

    </template>
    <AppBottomNav active="workbench" />
  </view>
</template>

<style scoped lang="scss">
.page {
  min-height: 100vh;
  padding: 34rpx 28rpx 180rpx;
}
.identity,
.account {
  display: flex;
  align-items: center;
}
.identity {
  justify-content: space-between;
}
.warehouse-name {
  display: block;
  font-size: 42rpx;
  font-weight: 800;
  letter-spacing: -1rpx;
}
.account {
  gap: 12rpx;
  margin-top: 14rpx;
}
.user-name {
  color: var(--wms-text);
  font-size: 28rpx;
  font-weight: 750;
  line-height: 1.4;
}
.role {
  padding: 7rpx 15rpx;
  border-radius: 999rpx;
  background: var(--wms-surface-soft);
  color: var(--wms-primary-700);
  font-size: 22rpx;
  font-weight: 700;
  line-height: 1.2;
}
.scan-shortcut {
  box-sizing: border-box;
  overflow: hidden;
  border: 0;
  outline: 0;
  -webkit-appearance: none;
  appearance: none;
}
.scan-shortcut::after {
  content: none;
  border: 0;
}
.scan-shortcut {
  display: flex;
  width: 76rpx;
  height: 76rpx;
  align-items: center;
  justify-content: center;
  margin: 0;
  padding: 0;
  border-radius: 50%;
  background: var(--wms-surface-soft);
  line-height: 1;
}
.scan-shortcut image {
  width: 42rpx;
  height: 42rpx;
}
.current-session {
  display: block;
  margin-top: 10rpx;
  color: var(--wms-text-secondary);
  font-size: 13px;
  line-height: 1.4;
}
.error-card,
.summary-card {
  margin-top: 20rpx;
  border-radius: var(--wms-radius-card);
  background: var(--wms-surface);
  box-shadow: var(--wms-shadow-card);
}
.error-card {
  display: flex;
  justify-content: space-between;
  padding: 24rpx;
  color: var(--wms-danger);
  font-size: 24rpx;
}
.retry {
  color: var(--wms-primary-700);
}
.summary-card {
  padding: 28rpx 30rpx;
}
.card-title,
.section-title {
  font-size: 32rpx;
  font-weight: 800;
}
.metric-row {
  display: flex;
  margin-top: 28rpx;
}
.metric-row view {
  display: flex;
  flex: 1;
  align-items: center;
  flex-direction: column;
  border-right: 1rpx solid var(--wms-border);
}
.metric-row view:last-child {
  border: 0;
}
.metric-label,
.metric-number {
  display: block;
}
.metric-label {
  color: var(--wms-text-secondary);
  font-size: 24rpx;
}
.metric-number {
  margin-top: 8rpx;
  font-size: 52rpx;
  font-weight: 800;
  font-variant-numeric: tabular-nums;
}
.entry-section {
  margin-top: 16px;
}
.entry-section-head {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 16rpx;
}
.shortcut-settings {
  display: flex;
  min-height: 52rpx;
  align-items: center;
  justify-content: center;
  gap: 8rpx;
  color: var(--wms-primary-700);
  font-size: 23rpx;
  line-height: 1;
}
.shortcut-settings image {
  display: block;
  width: 26rpx;
  height: 26rpx;
  flex: none;
}
.shortcut-settings text {
  display: block;
  line-height: 26rpx;
}
.entry-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 24rpx 10rpx;
  padding: 28rpx 18rpx;
  border-radius: var(--wms-radius-card);
  background: #fff;
  box-shadow: var(--wms-shadow-card);
}
.entry {
  display: flex;
  align-items: center;
  flex-direction: column;
  min-width: 0;
}
.icon-surface {
  display: flex;
  width: 78rpx;
  height: 78rpx;
  align-items: center;
  justify-content: center;
  border-radius: 18rpx;
  background: var(--wms-surface-soft);
}
.icon-surface.attention-follow { background: color-mix(in srgb, var(--wms-warning) 14%, white); }
.icon-surface.attention-high { background: color-mix(in srgb, var(--wms-danger) 13%, white); }
.icon-surface image {
  width: 46rpx;
  height: 46rpx;
}
.entry-title {
  max-width: 100%;
  margin-top: 12rpx;
  overflow: hidden;
  font-size: 23rpx;
  white-space: nowrap;
  text-overflow: ellipsis;
}
</style>
