<script setup lang="ts">
import { computed, ref } from "vue";
import { onLoad, onPullDownRefresh } from "@dcloudio/uni-app";
import { partLogisticsApi } from "../../api/part-logistics.api";
import type { PartLogisticsOverview } from "../../models/part-logistics";
import SessionTrigger from "@/shared/components/SessionTrigger.vue";
import SessionDatePicker from "@/shared/components/SessionDatePicker.vue";
import WareState from "@/shared/components/WareState.vue";

const date = ref(new Date().toISOString().slice(0, 10));
const overview = ref<PartLogisticsOverview>();
const keyword = ref("");
const tab = ref<"assigned" | "checked">("assigned");
const loading = ref(true);
const error = ref("");
const pickerVisible = ref(false);
const records = computed(() =>
  (tab.value === "assigned"
    ? overview.value?.assignedRecords || []
    : overview.value?.checkedRecords || []
  ).filter((row) => !keyword.value || row.userName.includes(keyword.value)),
);
const timeText = (value: string | null) => value?.slice(11, 16) || "—";

async function load() {
  loading.value = true;
  error.value = "";
  try {
    overview.value = await partLogisticsApi.overview(date.value);
  } catch (e) {
    error.value = e instanceof Error ? e.message : "加载失败";
  } finally {
    loading.value = false;
    uni.stopPullDownRefresh();
  }
}
onLoad((query) => {
  if (query?.date) date.value = String(query.date);
  load();
});
onPullDownRefresh(load);
</script>

<template>
  <view class="page">
    <view class="toolbar">
      <SessionTrigger :value="date" @click="pickerVisible = true" />
      <text>兼职物流员管理</text>
    </view>
    <view v-if="overview" class="summary">
      <view
        ><strong>{{ overview.summary.checked }}</strong
        ><text>找我签/退</text></view
      >
      <view
        ><strong>{{ overview.summary.assigned }}</strong
        ><text>分配给我</text></view
      >
      <view
        ><strong>{{ overview.summary.ended }}</strong
        ><text>已结束</text></view
      >
    </view>
    <view class="search"
      ><text>⌕</text><input v-model="keyword" placeholder="搜索人员姓名"
    /></view>
    <view class="tabs">
      <view :class="{ active: tab === 'assigned' }" @click="tab = 'assigned'">
        分配给我的兼职
      </view>
      <view :class="{ active: tab === 'checked' }" @click="tab = 'checked'">
        找我签到/退的人
      </view>
    </view>
    <WareState v-if="loading" type="loading" title="正在加载兼职工作记录" />
    <WareState
      v-else-if="error"
      type="error"
      title="加载失败"
      :description="error"
      action-label="重新加载"
      @action="load"
    />
    <view v-else-if="records.length" class="list">
      <view v-for="row in records" :key="row.id" class="record-card">
        <view class="record-head">
          <view
            ><strong>{{ row.userName }}</strong
            ><small>{{ row.date }}</small></view
          >
          <view class="status-row">
            <text :class="row.endTime ? 'ended' : 'working'">{{
              row.endTime ? "已结束" : "工作中"
            }}</text>
          </view>
        </view>
        <view class="duration"
          ><strong>{{ row.duration.toFixed(2) }}</strong> 小时</view
        >
        <view class="details">
          <text>开工 {{ timeText(row.startTime) }}</text
          ><text>收工 {{ timeText(row.endTime) }}</text>
          <text>签到处 {{ row.startCheckerName || "—" }}</text
          ><text>签退处 {{ row.endCheckerName || "—" }}</text>
        </view>
        <view class="leader">管理组长：{{ row.leaderName || "—" }}</view>
      </view>
    </view>
    <WareState
      v-else
      type="empty"
      title="暂无工作记录"
      description="当前场次没有符合条件的兼职物流员"
    />
    <SessionDatePicker
      v-model="date"
      v-model:visible="pickerVisible"
      title="选择场次"
      @confirm="load"
    />
  </view>
</template>

<style scoped lang="scss">
.page {
  min-height: 100vh;
  padding: 24rpx;
}
.toolbar,
.search,
.tabs,
.record-head,
.record-head > view,
.status-row,
.drawer-head,
.drawer-actions {
  display: flex;
  align-items: center;
}
.toolbar,
.record-head,
.drawer-head {
  justify-content: space-between;
}
.toolbar > text {
  color: var(--wms-primary-700);
  font-size: 20rpx;
  font-weight: 700;
}
.summary {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  margin-top: 18rpx;
  padding: 22rpx 0;
  border-radius: 20rpx;
  background: #fff;
  box-shadow: var(--wms-shadow-card);
}
.summary view {
  text-align: center;
  border-right: 1rpx solid var(--wms-border);
}
.summary view:last-child {
  border: 0;
}
.summary strong,
.summary text {
  display: block;
}
.summary strong {
  color: var(--wms-primary-700);
  font-size: 34rpx;
}
.summary text {
  margin-top: 5rpx;
  color: var(--wms-text-secondary);
  font-size: 17rpx;
}
.search {
  height: 68rpx;
  margin-top: 16rpx;
  padding: 0 16rpx;
  border: 1rpx solid var(--wms-border);
  border-radius: 12rpx;
  background: #fff;
}
.search text {
  color: var(--wms-text-secondary);
  font-size: 25rpx;
}
.search input {
  flex: 1;
  min-width: 0;
  padding-left: 8rpx;
  font-size: 19rpx;
}
.tabs {
  height: 76rpx;
  gap: 24rpx;
}
.tabs > view {
  display: flex;
  height: 100%;
  align-items: center;
  color: var(--wms-text-secondary);
  font-size: 19rpx;
}
.tabs > view.active {
  border-bottom: 4rpx solid var(--wms-primary-700);
  color: var(--wms-primary-700);
  font-weight: 700;
}
.tabs button {
  height: 56rpx;
  margin: 0 0 0 auto;
  padding: 0 16rpx;
  border-radius: 10rpx;
  background: var(--wms-primary-700);
  color: #fff;
  font-size: 17rpx;
  line-height: 56rpx;
}
.tabs button[disabled] {
  opacity: 0.45;
}
.list {
  display: flex;
  flex-direction: column;
  gap: 12rpx;
}
.record-card {
  padding: 20rpx;
  border: 1rpx solid transparent;
  border-radius: 18rpx;
  background: #fff;
  box-shadow: var(--wms-shadow-card);
}
.record-card.selected {
  border-color: var(--wms-primary-700);
  background: var(--wms-surface-soft);
}
.record-card.disabled {
  opacity: 0.78;
}
.record-head > view:first-child {
  gap: 12rpx;
}
.record-head strong {
  font-size: 23rpx;
}
.record-head small {
  color: var(--wms-text-secondary);
  font-size: 16rpx;
}
.status-row {
  gap: 6rpx;
}
.status-row text {
  padding: 4rpx 8rpx;
  border-radius: 6rpx;
  font-size: 14rpx;
}
.status-row .assigned,
.status-row .working {
  background: var(--wms-surface-soft);
  color: var(--wms-success);
}
.status-row .unassigned,
.status-row .ended {
  background: #fff0da;
  color: #a35e00;
}
.duration {
  margin-top: 16rpx;
  color: var(--wms-text-secondary);
  font-size: 17rpx;
}
.duration strong {
  color: var(--wms-text-primary);
  font-size: 26rpx;
}
.details {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 8rpx 16rpx;
  margin-top: 14rpx;
  padding-top: 14rpx;
  border-top: 1rpx dashed var(--wms-border);
  color: var(--wms-text-secondary);
  font-size: 16rpx;
}
.leader {
  margin-top: 12rpx;
  color: var(--wms-primary-700);
  font-size: 17rpx;
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
  max-height: 76vh;
  padding: 28rpx 22rpx calc(24rpx + env(safe-area-inset-bottom));
  border-radius: 26rpx 26rpx 0 0;
  background: #fff;
}
.drawer-head text {
  color: var(--wms-text-secondary);
  font-size: 17rpx;
}
.leader-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 12rpx;
  margin-top: 22rpx;
}
.leader-grid view {
  display: flex;
  min-height: 72rpx;
  align-items: center;
  justify-content: center;
  border-radius: 10rpx;
  background: var(--wms-background);
  font-size: 18rpx;
}
.leader-grid view.active {
  background: var(--wms-primary-700);
  color: #fff;
}
.drawer-actions {
  margin-top: 24rpx;
}
.drawer-actions button {
  width: 50%;
  height: 72rpx;
  margin: 0;
  border-radius: 0;
  background: var(--wms-background);
  font-size: 20rpx;
  line-height: 72rpx;
}
.drawer-actions button:last-child {
  background: var(--wms-primary-700);
  color: #fff;
}
</style>
