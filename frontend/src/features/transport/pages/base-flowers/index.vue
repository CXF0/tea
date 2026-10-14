<script setup lang="ts">
import { ref } from "vue";
import { onLoad, onPullDownRefresh } from "@dcloudio/uni-app";
import WareState from "@/shared/components/WareState.vue";
import SessionDatePicker from "@/shared/components/SessionDatePicker.vue";
import SessionTrigger from "@/shared/components/SessionTrigger.vue";
import { transportApi } from "../../api/transport.api";
import type { BaseFlowerDetailPage } from "../../models/vehicle";

const today = () => new Date().toISOString().slice(0, 10);
const roundNo = ref(today());
const keyword = ref("");
const driverName = ref("");
const pickerVisible = ref(false);
const loading = ref(true);
const error = ref("");
const data = ref<BaseFlowerDetailPage>({
  total: 0,
  summary: { flowerUnits: 0, recordUnits: 0, preparedUnits: 0, problemUnits: 0, baseCount: 0, driverCount: 0 },
  records: [],
});

async function load() {
  loading.value = true;
  error.value = "";
  try {
    data.value = await transportApi.baseFlowerDetails({
      roundNo: roundNo.value,
      keyword: keyword.value.trim(),
      driverName: driverName.value.trim(),
      baseId: 0,
    });
  } catch (cause) {
    error.value = cause instanceof Error ? cause.message : "基地花材明细加载失败";
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
      <SessionTrigger :value="roundNo" @click="pickerVisible = true" />
      <view class="head-badge">基地花材明细</view>
    </view>

    <view class="summary">
      <view><b>{{ data.summary.flowerUnits }}</b><text>花材货量</text></view>
      <view><b>{{ data.summary.recordUnits }}</b><text>盘点数量</text></view>
      <view><b>{{ data.summary.preparedUnits }}</b><text>已配货</text></view>
      <view><b>{{ data.summary.problemUnits }}</b><text>质检问题</text></view>
    </view>

    <view class="search"><input v-model="keyword" placeholder="花材 / 供应商 / 货位" confirm-type="search" @confirm="load" /><text @click="load">查询</text></view>
    <view class="driver-search"><input v-model="driverName" placeholder="按司机筛选，可留空查看全部" confirm-type="search" @confirm="load" /></view>

    <WareState v-if="loading" type="loading" title="正在加载基地花材" />
    <WareState v-else-if="error" type="error" title="加载失败" :description="error" action-label="重试" @action="load" />
    <WareState v-else-if="!data.records.length" type="empty" title="暂无基地花材明细" description="当前场次或司机条件下没有可展示数据" />
    <view v-else class="list">
      <view v-for="row in data.records" :key="`${row.dispatchId}-${row.itemId}`" class="card">
        <view class="head">
          <view><b>{{ row.baseName }}</b><small>{{ row.driverName || "未配置司机" }} · {{ row.plateNo || "未配置车辆" }}</small></view>
          <text>{{ row.location }}</text>
        </view>
        <view class="flower"><b>{{ row.flowerName }}</b><small>{{ row.grade }} · {{ row.specification }}</small></view>
        <view class="meta"><text>{{ row.supplierName }}</text><text>{{ row.dispatchNo }}</text></view>
        <view class="nums">
          <span><small>货量</small><b>{{ row.quantity }}</b></span>
          <span><small>盘点</small><b>{{ row.recordQuantity }}</b></span>
          <span><small>配货</small><b>{{ row.preparedQuantity }}</b></span>
          <span><small>问题</small><b>{{ row.problemQuantity }}</b></span>
        </view>
      </view>
    </view>
    <SessionDatePicker v-model="roundNo" v-model:visible="pickerVisible" title="选择场次" @confirm="load" />
  </view>
</template>

<style scoped>
.page{min-height:100vh;padding:20rpx;background:var(--wms-background)}
.page-head{display:flex;align-items:center;justify-content:space-between;gap:14rpx}.head-badge{padding:9rpx 15rpx;border-radius:999rpx;background:var(--wms-surface-soft);color:var(--wms-primary-700);font-size:22rpx;font-weight:700;white-space:nowrap}
.summary{display:grid;grid-template-columns:repeat(4,1fr);margin-top:14rpx;overflow:hidden;border-radius:14rpx;background:#fff}.summary view{padding:16rpx 4rpx;border-right:1rpx solid var(--wms-border);text-align:center}.summary view:last-child{border:0}.summary b,.summary text{display:block}.summary b{font-size:30rpx}.summary text{margin-top:3rpx;color:var(--wms-text-secondary);font-size:17rpx}
.search,.driver-search{box-sizing:border-box;height:64rpx;border:1rpx solid var(--wms-border);border-radius:10rpx;background:#fff;font-size:20rpx;display:flex;align-items:center;padding:0 13rpx}.search{margin-top:14rpx}.driver-search{margin:10rpx 0 14rpx}.search input,.driver-search input{min-width:0;flex:1;font-size:20rpx}.search text{color:var(--wms-primary-700)}
.list{display:flex;flex-direction:column;gap:10rpx}.card{padding:18rpx;border:1rpx solid var(--wms-border);border-radius:14rpx;background:#fff}.head,.meta{display:flex;align-items:center;justify-content:space-between;gap:12rpx}.head b,.head small,.flower b,.flower small{display:block}.head b{font-size:24rpx}.head small,.flower small,.meta{color:var(--wms-text-secondary);font-size:18rpx}.head>text{padding:5rpx 10rpx;border-radius:7rpx;background:var(--wms-surface-soft);color:var(--wms-primary-700);font-size:17rpx;font-weight:700}.flower{margin-top:14rpx}.flower b{font-size:23rpx}.meta{margin-top:8rpx}
.nums{display:grid;grid-template-columns:repeat(4,1fr);gap:8rpx;margin-top:14rpx}.nums span{padding:10rpx 4rpx;border-radius:9rpx;background:var(--wms-background);text-align:center}.nums small,.nums b{display:block}.nums small{color:var(--wms-text-secondary);font-size:16rpx}.nums b{font-size:24rpx}
</style>
