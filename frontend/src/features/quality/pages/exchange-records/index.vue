<script setup lang="ts">
import { computed, ref } from "vue";
import { onLoad, onPullDownRefresh } from "@dcloudio/uni-app";
import WareState from "@/shared/components/WareState.vue";
import SessionDatePicker from "@/shared/components/SessionDatePicker.vue";
import SessionTrigger from "@/shared/components/SessionTrigger.vue";
import { qualityApi } from "../../api/quality.api";
import type { QualityExchangeRecord } from "../../models/quality";

const today = () => new Date().toISOString().slice(0, 10);
const date = ref(today());
const pickerVisible = ref(false);
const loading = ref(true);
const error = ref("");
const exchanges = ref<QualityExchangeRecord[]>([]);
const totals = computed(() => exchanges.value.reduce((acc, row) => {
  acc.quantity += row.quantity;
  acc.handled += row.handledQuantity;
  if (row.notifyStatus === 2) acc.answered += 1;
  return acc;
}, { quantity: 0, handled: 0, answered: 0 }));

async function load() {
  loading.value = true;
  error.value = "";
  try {
    exchanges.value = await qualityApi.getExchangeRecords(date.value);
  } catch (cause) {
    error.value = cause instanceof Error ? cause.message : "换货记录加载失败";
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
      <view class="head-badge">换货记录</view>
    </view>
    <view class="summary">
      <view><b>{{ totals.quantity }}</b><text>换货数量</text></view>
      <view><b>{{ totals.handled }}</b><text>已处理</text></view>
      <view><b>{{ totals.answered }}</b><text>已接听</text></view>
      <view><b>{{ exchanges.length }}</b><text>记录数</text></view>
    </view>
    <WareState v-if="loading" type="loading" title="正在加载换货记录" />
    <WareState v-else-if="error" type="error" title="加载失败" :description="error" action-label="重试" @action="load" />
    <WareState v-else-if="!exchanges.length" type="empty" title="暂无换货记录" description="换货标记产生后会汇总换货和电话通知状态" />
    <view v-else class="list">
      <view v-for="row in exchanges" :key="row.id" class="card">
        <view class="head"><view><b>{{ row.flowerName }}</b><small>{{ row.supplierName }}</small></view><text>{{ row.handleStatusLabel }}</text></view>
        <view class="meta"><text>{{ row.grade }} · {{ row.specification }}</text><text>{{ row.location }}</text></view>
        <view class="nums"><span><small>换货</small><b>{{ row.quantity }}</b></span><span><small>已处理</small><b>{{ row.handledQuantity }}</b></span><span><small>电话</small><b>{{ row.notifyStatusLabel }}</b></span></view>
        <small class="call">通知 {{ row.notifyCount }} 次 · {{ row.lastNotifyTime || row.callResult || "暂无电话记录" }}</small>
      </view>
    </view>
    <SessionDatePicker v-model="date" v-model:visible="pickerVisible" title="选择场次" @confirm="load" />
  </view>
</template>

<style scoped>
.page{min-height:100vh;padding:24rpx;background:var(--wms-background)}
.page-head{display:flex;align-items:center;justify-content:space-between;gap:14rpx}.head-badge{padding:9rpx 15rpx;border-radius:999rpx;background:var(--wms-surface-soft);color:var(--wms-primary-700);font-size:22rpx;font-weight:700}
.summary{display:grid;grid-template-columns:repeat(4,1fr);margin:18rpx 0;overflow:hidden;border-radius:14rpx;background:#fff}.summary view{padding:16rpx 4rpx;border-right:1rpx solid var(--wms-border);text-align:center}.summary view:last-child{border:0}.summary b,.summary text{display:block}.summary b{font-size:30rpx}.summary text{margin-top:3rpx;color:var(--wms-text-secondary);font-size:17rpx}
.list{display:flex;flex-direction:column;gap:10rpx}.card{padding:18rpx;border:1rpx solid var(--wms-border);border-radius:14rpx;background:#fff}.head,.meta{display:flex;align-items:center;justify-content:space-between;gap:12rpx}.head b,.head small{display:block}.head b{font-size:25rpx}.head small,.meta,.call{color:var(--wms-text-secondary);font-size:18rpx}.head>text{padding:5rpx 10rpx;border-radius:7rpx;background:var(--wms-surface-soft);color:var(--wms-primary-700);font-size:17rpx;font-weight:700}.meta{margin-top:10rpx}.nums{display:grid;grid-template-columns:repeat(3,1fr);gap:8rpx;margin-top:14rpx}.nums span{padding:10rpx 4rpx;border-radius:9rpx;background:var(--wms-background);text-align:center}.nums small,.nums b{display:block}.nums small{color:var(--wms-text-secondary);font-size:16rpx}.nums b{font-size:24rpx}.call{display:block;margin-top:12rpx}
</style>
