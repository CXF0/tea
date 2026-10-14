<script setup lang="ts">
import { computed, ref } from "vue";
import { onLoad, onPullDownRefresh } from "@dcloudio/uni-app";
import { logisticsApi, type LogisticsDashboard } from "../../api/logistics.api";
import SessionTrigger from "@/shared/components/SessionTrigger.vue";
import SessionDatePicker from "@/shared/components/SessionDatePicker.vue";
import WareState from "@/shared/components/WareState.vue";

const date = ref(new Date().toISOString().slice(0, 10));
const dashboard = ref<LogisticsDashboard | null>(null);
const loading = ref(false);
const error = ref("");
const datePicker = ref(false);
const expressFilter = ref("全部物流");
const filterVisible = ref(false);

const expressOptions = computed(() => [
  "全部物流",
  ...(dashboard.value?.collectionProgress.types.map((item) => item.expressName) ?? []),
]);
const rows = computed(() => {
  const list = dashboard.value?.collectionProgress.types ?? [];
  if (expressFilter.value === "全部物流") return list;
  return list.filter((item) => item.expressName === expressFilter.value);
});

async function load() {
  loading.value = true;
  error.value = "";
  try {
    dashboard.value = await logisticsApi.dashboard(date.value);
    if (!expressOptions.value.includes(expressFilter.value)) expressFilter.value = "全部物流";
  } catch (e) {
    error.value = e instanceof Error ? e.message : "加载失败";
  } finally {
    loading.value = false;
    uni.stopPullDownRefresh();
  }
}
function selectExpress(value: string) {
  expressFilter.value = value;
  filterVisible.value = false;
}
onLoad((query) => {
  if (query?.date) date.value = String(query.date);
  void load();
});
onPullDownRefresh(load);
</script>

<template>
  <view class="page">
    <view class="toolbar">
      <view class="filter-trigger" @click="filterVisible = true">{{ expressFilter }}<i /></view>
      <SessionTrigger :value="date" @click="datePicker = true" />
    </view>
    <WareState v-if="loading" type="loading" title="正在加载揽收进度" />
    <WareState v-else-if="error" type="error" title="加载失败" :description="error" action-label="重新加载" @action="load" />
    <view v-else-if="rows.length" class="progress-list">
      <view v-for="item in rows" :key="item.expressType" class="progress-card">
        <view class="progress-head"><b>{{ item.expressName }}</b><strong>{{ item.rate }}%</strong></view>
        <view class="bar"><i :style="{ width: `${item.rate}%` }" /></view>
        <view class="numbers">
          <view><b>{{ item.pendingPackages }}</b><small>待揽收</small></view>
          <view><b>{{ item.pickedPackages }}</b><small>已揽收</small></view>
          <view><b>{{ item.totalPackages }}</b><small>总包裹</small></view>
        </view>
      </view>
    </view>
    <WareState v-else type="empty" title="暂无物流揽收数据" />

    <SessionDatePicker
      v-model="date"
      v-model:visible="datePicker"
      title="选择场次"
      @confirm="load"
    />
    <view v-if="filterVisible" class="mask" @click="filterVisible = false">
      <view class="drawer" @click.stop>
        <view class="drawer-head"><b>选择物流</b><text @click="filterVisible = false">关闭</text></view>
        <view class="options">
          <view
            v-for="item in expressOptions"
            :key="item"
            :class="{ active: expressFilter === item }"
            @click="selectExpress(item)"
          >{{ item }}</view>
        </view>
      </view>
    </view>
  </view>
</template>

<style scoped lang="scss">
.page {
  min-height: 100vh;
  padding: 20rpx 24rpx 50rpx;
  background: var(--wms-surface-page);
}
.toolbar {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 18rpx;
}
.filter-trigger {
  display: inline-flex;
  height: 58rpx;
  align-items: center;
  gap: 8rpx;
  padding: 0 18rpx;
  border: 1rpx solid var(--wms-border);
  border-radius: 8rpx;
  background: #fff;
  color: var(--wms-text-main);
  font-size: 23rpx;
}
.filter-trigger i {
  width: 10rpx;
  height: 10rpx;
  border-right: 2rpx solid var(--wms-text-secondary);
  border-bottom: 2rpx solid var(--wms-text-secondary);
  transform: rotate(45deg) translateY(-3rpx);
}
.progress-list {
  display: grid;
  gap: 16rpx;
}
.progress-card {
  padding: 24rpx;
  border-radius: var(--wms-radius-card);
  background: #fff;
  box-shadow: var(--wms-shadow-card);
}
.progress-head,
.numbers {
  display: flex;
  align-items: center;
  justify-content: space-between;
}
.progress-head b {
  min-width: 0;
  overflow: hidden;
  font-size: 29rpx;
  text-overflow: ellipsis;
  white-space: nowrap;
}
.progress-head strong {
  color: var(--wms-primary-700);
  font-size: 27rpx;
}
.bar {
  height: 16rpx;
  margin: 18rpx 0 22rpx;
  overflow: hidden;
  border-radius: 999rpx;
  background: var(--wms-surface-soft);
}
.bar i {
  display: block;
  height: 100%;
  border-radius: inherit;
  background: var(--wms-primary-700);
}
.numbers view {
  flex: 1;
  text-align: center;
}
.numbers b,
.numbers small {
  display: block;
}
.numbers b {
  color: var(--wms-text-main);
  font-size: 30rpx;
  font-variant-numeric: tabular-nums;
}
.numbers small {
  margin-top: 8rpx;
  color: var(--wms-text-secondary);
  font-size: 21rpx;
}
.mask {
  position: fixed;
  z-index: 80;
  inset: 0;
  display: flex;
  align-items: flex-end;
  background: rgba(22, 42, 40, 0.5);
}
.drawer {
  box-sizing: border-box;
  width: 100%;
  max-height: 70vh;
  padding: 28rpx 24rpx calc(28rpx + env(safe-area-inset-bottom));
  overflow: auto;
  border-radius: 26rpx 26rpx 0 0;
  background: #fff;
}
.drawer-head {
  display: flex;
  align-items: center;
  justify-content: space-between;
}
.drawer-head text {
  color: var(--wms-primary-700);
  font-size: 24rpx;
}
.options {
  display: grid;
  grid-template-columns: repeat(2, minmax(0, 1fr));
  gap: 12rpx;
  margin-top: 24rpx;
}
.options view {
  display: flex;
  min-height: 72rpx;
  align-items: center;
  justify-content: center;
  padding: 6rpx 12rpx;
  border: 1rpx solid var(--wms-border);
  border-radius: 10rpx;
  background: #fff;
  font-size: 22rpx;
  text-align: center;
}
.options .active {
  border-color: var(--wms-primary-700);
  background: var(--wms-surface-soft);
  color: var(--wms-primary-700);
  font-weight: 700;
}
</style>
