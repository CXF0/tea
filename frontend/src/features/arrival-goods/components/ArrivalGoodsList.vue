<script setup lang="ts">
import { computed, ref } from "vue";
import { onLoad, onPullDownRefresh } from "@dcloudio/uni-app";
import WareState from "@/shared/components/WareState.vue";
import SessionDatePicker from "@/shared/components/SessionDatePicker.vue";
import SessionTrigger from "@/shared/components/SessionTrigger.vue";
import { arrivalGoodsApi, type ArrivalGoodsPage } from "../api/arrival-goods.api";

const props = defineProps<{
  type: "purchase" | "stock" | "outbound" | "selfPickup" | "unlabeled";
  badge: string;
  emptyTitle: string;
}>();

const today = () => new Date().toISOString().slice(0, 10);
const date = ref(today());
const keyword = ref("");
const pickerVisible = ref(false);
const loading = ref(true);
const error = ref("");
const pageData = ref<ArrivalGoodsPage>({
  current: 1,
  size: 30,
  total: 0,
  summary: { acquiredUnits: 0, stockUnits: 0, outboundUnits: 0, selfPickupUnits: 0, unlabeledUnits: 0 },
  records: [],
});

const mainMetric = computed(() => {
  if (props.type === "stock") return { label: "可用库存", value: pageData.value.summary.stockUnits };
  if (props.type === "outbound") return { label: "已出库", value: pageData.value.summary.outboundUnits };
  if (props.type === "selfPickup") return { label: "自提数量", value: pageData.value.summary.selfPickupUnits };
  if (props.type === "unlabeled") return { label: "无标签", value: pageData.value.summary.unlabeledUnits };
  return { label: "收购/到场", value: pageData.value.summary.acquiredUnits };
});

async function load() {
  loading.value = true;
  error.value = "";
  try {
    pageData.value = await arrivalGoodsApi.list({
      date: date.value,
      type: props.type,
      keyword: keyword.value.trim(),
      page: 1,
      size: 30,
    });
  } catch (cause) {
    error.value = cause instanceof Error ? cause.message : "到场货数据加载失败";
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
      <view class="head-badge">{{ badge }}</view>
    </view>

    <view class="summary">
      <view><b>{{ mainMetric.value }}</b><text>{{ mainMetric.label }}</text></view>
      <view><b>{{ pageData.total }}</b><text>记录数</text></view>
      <view><b>{{ pageData.summary.stockUnits }}</b><text>库存</text></view>
      <view><b>{{ pageData.summary.outboundUnits }}</b><text>出库</text></view>
    </view>

    <view class="search">
      <input v-model="keyword" placeholder="花材 / 供应商 / 货位" confirm-type="search" @confirm="load" />
      <text v-if="keyword" @click="keyword = ''; load()">清除</text>
      <text v-else @click="load">查询</text>
    </view>

    <WareState v-if="loading" type="loading" title="正在加载到场货" />
    <WareState v-else-if="error" type="error" title="加载失败" :description="error" action-label="重试" @action="load" />
    <WareState v-else-if="!pageData.records.length" type="empty" :title="emptyTitle" description="请调整场次或搜索条件后重试" />
    <view v-else class="list">
      <view v-for="row in pageData.records" :key="row.id" class="card">
        <view class="head">
          <view>
            <b>{{ row.flowerName }}</b>
            <small>{{ row.grade }} · {{ row.specification }}</small>
          </view>
          <text v-if="row.unlabeled">无标签</text>
          <text v-else-if="row.selfPickup">自提</text>
        </view>
        <view class="meta">
          <text>{{ row.supplierName }}</text>
          <text>{{ row.location }}</text>
        </view>
        <view class="nums">
          <span><small>到场</small><b>{{ row.acquiredUnits }}</b></span>
          <span><small>库存</small><b>{{ row.stockUnits }}</b></span>
          <span><small>出库</small><b>{{ row.outboundUnits }}</b></span>
          <span><small>问题</small><b>{{ row.problemUnits }}</b></span>
        </view>
      </view>
    </view>

    <SessionDatePicker v-model="date" v-model:visible="pickerVisible" title="选择场次" @confirm="load" />
  </view>
</template>

<style scoped>
.page{min-height:100vh;padding:24rpx;background:var(--wms-background)}
.page-head{display:flex;align-items:center;justify-content:space-between;gap:14rpx}
.head-badge{padding:9rpx 15rpx;border-radius:999rpx;background:var(--wms-surface-soft);color:var(--wms-primary-700);font-size:22rpx;font-weight:700;white-space:nowrap}
.summary{display:grid;grid-template-columns:repeat(4,1fr);margin-top:18rpx;overflow:hidden;border-radius:14rpx;background:#fff}
.summary view{padding:16rpx 4rpx;border-right:1rpx solid var(--wms-border);text-align:center}
.summary view:last-child{border:0}.summary b,.summary text{display:block}.summary b{font-size:30rpx}.summary text{margin-top:3rpx;color:var(--wms-text-secondary);font-size:17rpx}
.search{display:flex;height:70rpx;align-items:center;gap:12rpx;margin:14rpx 0;padding:0 18rpx;border:1rpx solid var(--wms-border);border-radius:12rpx;background:#fff}
.search input{min-width:0;flex:1;font-size:22rpx}.search text{color:var(--wms-primary-700);font-size:21rpx}
.list{display:flex;flex-direction:column;gap:10rpx}.card{padding:18rpx;border:1rpx solid var(--wms-border);border-radius:14rpx;background:#fff}
.head,.meta{display:flex;align-items:center;justify-content:space-between;gap:12rpx}.head b,.head small{display:block}.head b{font-size:25rpx}.head small{margin-top:4rpx;color:var(--wms-text-secondary);font-size:18rpx}
.head>text{padding:5rpx 10rpx;border-radius:7rpx;background:var(--wms-surface-soft);color:var(--wms-primary-700);font-size:17rpx;font-weight:700}.meta{margin-top:12rpx;color:var(--wms-text-secondary);font-size:18rpx}
.nums{display:grid;grid-template-columns:repeat(4,1fr);gap:8rpx;margin-top:14rpx}.nums span{padding:10rpx 4rpx;border-radius:9rpx;background:var(--wms-background);text-align:center}.nums small,.nums b{display:block}.nums small{color:var(--wms-text-secondary);font-size:16rpx}.nums b{font-size:24rpx}
</style>
