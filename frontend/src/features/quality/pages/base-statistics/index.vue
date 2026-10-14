<script setup lang="ts">
import { computed, ref } from "vue";
import { onLoad, onPullDownRefresh } from "@dcloudio/uni-app";
import WareState from "@/shared/components/WareState.vue";
import SessionDatePicker from "@/shared/components/SessionDatePicker.vue";
import SessionTrigger from "@/shared/components/SessionTrigger.vue";
import { qualityApi } from "../../api/quality.api";
import type { QualityBaseIssueStatistic } from "../../models/quality";

const today = () => new Date().toISOString().slice(0, 10);
const date = ref(today());
const pickerVisible = ref(false);
const loading = ref(true);
const error = ref("");
const bases = ref<QualityBaseIssueStatistic[]>([]);
const totals = computed(() => bases.value.reduce((acc, row) => {
  acc.downgrade += row.downgradeUnits;
  acc.return += row.returnUnits;
  acc.exchange += row.exchangeUnits;
  acc.issue += row.issueUnits;
  return acc;
}, { downgrade: 0, return: 0, exchange: 0, issue: 0 }));

async function load() {
  loading.value = true;
  error.value = "";
  try {
    bases.value = await qualityApi.getBaseIssueStatistics(date.value);
  } catch (cause) {
    error.value = cause instanceof Error ? cause.message : "基地质检统计加载失败";
  } finally {
    loading.value = false;
    uni.stopPullDownRefresh();
  }
}

onLoad(load);
onPullDownRefresh(load);
</script>

<template>
  <view class="page">
    <view class="page-head">
      <SessionTrigger :value="date" @click="pickerVisible = true" />
      <view class="head-badge">基地质检统计</view>
    </view>
    <view class="summary">
      <view><b>{{ totals.issue }}</b><text>问题合计</text></view>
      <view><b>{{ totals.downgrade }}</b><text>降级</text></view>
      <view><b>{{ totals.return }}</b><text>退货</text></view>
      <view><b>{{ totals.exchange }}</b><text>换货</text></view>
    </view>
    <WareState v-if="loading" type="loading" title="正在加载基地质检统计" />
    <WareState v-else-if="error" type="error" title="加载失败" :description="error" action-label="重试" @action="load" />
    <WareState v-else-if="!bases.length" type="empty" title="暂无基地质检统计" description="当前场次没有基地问题统计数据" />
    <view v-else class="table">
      <view class="table-head"><text>基地名</text><text>降级({{ totals.downgrade }})</text><text>退货({{ totals.return }})</text><text>换货({{ totals.exchange }})</text></view>
      <view v-for="row in bases" :key="row.baseId" class="table-row">
        <text>{{ row.baseName }}</text>
        <text>{{ row.downgradeUnits }}</text>
        <text>{{ row.returnUnits }}</text>
        <text>{{ row.exchangeUnits }}</text>
      </view>
    </view>
    <SessionDatePicker v-model="date" v-model:visible="pickerVisible" title="选择场次" @confirm="load" />
  </view>
</template>

<style scoped>
.page{min-height:100vh;padding:24rpx;background:var(--wms-background)}
.page-head{display:flex;align-items:center;justify-content:space-between;gap:14rpx}.head-badge{padding:9rpx 15rpx;border-radius:999rpx;background:var(--wms-surface-soft);color:var(--wms-primary-700);font-size:22rpx;font-weight:700}
.summary{display:grid;grid-template-columns:repeat(4,1fr);margin:18rpx 0;overflow:hidden;border-radius:14rpx;background:#fff}.summary view{padding:16rpx 4rpx;border-right:1rpx solid var(--wms-border);text-align:center}.summary view:last-child{border:0}.summary b,.summary text{display:block}.summary b{font-size:30rpx}.summary text{margin-top:3rpx;color:var(--wms-text-secondary);font-size:17rpx}
.table{overflow:hidden;border-radius:14rpx;background:#fff}.table-head,.table-row{display:grid;grid-template-columns:1.4fr 1fr 1fr 1fr;align-items:center}.table-head{background:#f1f5f4;color:var(--wms-primary-700);font-size:22rpx}.table-head text,.table-row text{padding:18rpx 16rpx;border-bottom:1rpx solid var(--wms-border)}.table-row{font-size:23rpx}.table-row text:not(:first-child),.table-head text:not(:first-child){text-align:center}
</style>
