<script setup lang="ts">
import { computed, ref } from "vue";
import { onLoad, onPullDownRefresh } from "@dcloudio/uni-app";
import WareState from "@/shared/components/WareState.vue";
import { siteLocationApi } from "@/features/site-location/api/site-location.api";
import type { SiteLocationDetail, SiteLocationSizeType } from "@/features/site-location/models/site-location";

const loading = ref(true);
const error = ref("");
const rows = ref<SiteLocationDetail[]>([]);
const status = ref<"all" | "enabled" | "disabled">("all");
const size = ref<"all" | SiteLocationSizeType>("all");
const statusOptions = [{ key: "all", label: "全部状态" }, { key: "enabled", label: "启用" }, { key: "disabled", label: "停用" }] as const;
const sizeOptions = [{ key: "all", label: "全部件型" }, { key: "large", label: "大件" }, { key: "regular", label: "正常件" }, { key: "small", label: "小件" }, { key: "extraSmall", label: "特小件" }] as const;
const visibleRows = computed(() => rows.value.filter((row) =>
  (status.value === "all" || row.enabled === (status.value === "enabled")) &&
  (size.value === "all" || row.sizeType === size.value),
));
const groups = computed(() => {
  const result = new Map<string, SiteLocationDetail[]>();
  for (const row of visibleRows.value) result.set(row.zoneCode, [...(result.get(row.zoneCode) || []), row]);
  return [...result.values()].map((items) => ({
    code: items[0].zoneCode,
    name: items[0].zoneName,
    enabled: items[0].enabled,
    areaKind: items[0].areaKind,
    total: items.reduce((sum, item) => sum + item.count, 0),
    items,
  }));
});

async function load() {
  loading.value = true;
  error.value = "";
  try { rows.value = (await siteLocationApi.statistics()).details; }
  catch (e) { error.value = e instanceof Error ? e.message : "货位统计加载失败"; }
  finally { loading.value = false; uni.stopPullDownRefresh(); }
}
onLoad(load);
onPullDownRefresh(load);
</script>

<template>
  <view class="page">
    <view class="filters">
      <scroll-view scroll-x class="filter-scroll"><view class="filter-row"><view v-for="item in sizeOptions" :key="item.key" :class="{ active: size === item.key }" @click="size = item.key">{{ item.label }}</view></view></scroll-view>
      <view class="status-row"><view v-for="item in statusOptions" :key="item.key" :class="{ active: status === item.key }" @click="status = item.key">{{ item.label }}</view></view>
    </view>
    <WareState v-if="loading" type="loading" title="正在加载货位统计" />
    <WareState v-else-if="error" type="error" title="加载失败" :description="error" action-label="重试" @action="load" />
    <view v-else-if="groups.length" class="zone-list">
      <view v-for="group in groups" :key="group.code" class="zone-card">
        <view class="zone-head"><view><b>{{ group.name }}</b><small>{{ group.areaKind }}</small></view><view><span :class="{ off: !group.enabled }">{{ group.enabled ? '启用' : '停用' }}</span><strong>{{ group.total }}个</strong></view></view>
        <view class="table-head"><text>分段</text><text>件型</text><text>货位区间</text><text>数量</text></view>
        <view v-for="item in group.items" :key="item.key" class="range-row"><text>{{ item.segmentName }}段</text><text>{{ item.sizeLabel }}</text><text>#{{ item.startShelf }}–#{{ item.endShelf }}</text><b>{{ item.count }}个</b></view>
      </view>
    </view>
    <WareState v-else type="empty" title="暂无对应货位" description="当前件型和启用状态下没有货位区间" />
  </view>
</template>

<style scoped>
.page{box-sizing:border-box;min-height:100vh;padding:18rpx 20rpx;background:var(--wms-surface-page)}
.filters{position:sticky;z-index:5;top:0;padding-bottom:14rpx;background:var(--wms-surface-page)}
.filter-scroll{width:100%;white-space:nowrap}.filter-row{display:inline-flex;gap:10rpx}.filter-row view,.status-row view{height:58rpx;padding:0 17rpx;border:1rpx solid var(--wms-border);border-radius:10rpx;background:#fff;color:var(--wms-text-secondary);font-size:21rpx;line-height:58rpx;white-space:nowrap}.filter-row .active,.status-row .active{border-color:var(--wms-primary-700);background:var(--wms-surface-soft);color:var(--wms-primary-700);font-weight:700}.status-row{display:grid;grid-template-columns:repeat(3,1fr);gap:10rpx;margin-top:10rpx}.status-row view{padding:0;text-align:center}.zone-list{display:flex;flex-direction:column;gap:14rpx}.zone-card{overflow:hidden;border:1rpx solid var(--wms-border);border-radius:14rpx;background:#fff}.zone-head{display:flex;align-items:center;justify-content:space-between;padding:18rpx}.zone-head>view{display:flex;align-items:center;gap:10rpx}.zone-head b{font-size:26rpx}.zone-head small{color:var(--wms-text-secondary);font-size:19rpx}.zone-head span{padding:4rpx 9rpx;border-radius:6rpx;background:var(--wms-surface-soft);color:var(--wms-success);font-size:18rpx}.zone-head span.off{background:#f0f2f2;color:var(--wms-text-secondary)}.zone-head strong{font-size:24rpx}.table-head,.range-row{display:grid;grid-template-columns:.65fr .8fr 1.65fr .55fr;align-items:center;gap:8rpx;padding:0 14rpx}.table-head{height:52rpx;background:var(--wms-primary-700);color:#fff;font-size:18rpx}.range-row{min-height:66rpx;border-bottom:1rpx solid var(--wms-border);font-size:20rpx}.range-row:last-child{border-bottom:0}.range-row text:nth-child(3){white-space:nowrap}.range-row b{text-align:right;font-size:20rpx}
</style>
