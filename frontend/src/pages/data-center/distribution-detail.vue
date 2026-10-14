<script setup lang="ts">
import { ref } from "vue";
import { onLoad, onPullDownRefresh } from "@dcloudio/uni-app";
import { distributionApi } from "@/features/distribution/api/distribution.api";
import SessionDatePicker from "@/shared/components/SessionDatePicker.vue";
import WareState from "@/shared/components/WareState.vue";

interface ZoneProgress {
  zone: string;
  zoneName: string;
  shelfCount: number;
  totalUnits: number;
  allocatedUnits: number;
}

const date = ref(new Date().toISOString().slice(0, 10));
const datePickerVisible = ref(false);
const loading = ref(true);
const error = ref("");
const rows = ref<ZoneProgress[]>([]);
const scope = ref<'site'|'team'>('site');

async function load() {
  loading.value = true;
  error.value = "";
  try {
    const [options, shelves, progressScope] = await Promise.all([
      distributionApi.filterOptions(date.value, "normal"),
      distributionApi.shelves(date.value, "all", "", {
        warehouseType: "normal",
        selfPickup: false,
        earlyShift: false,
        restock: false,
        zone: "",
        segments: [],
      }),
      distributionApi.summary(date.value, scope.value),
    ]);
    const allowedZones = new Set(progressScope.zones || []);
    const summary = new Map<string, ZoneProgress>();
    const zoneNames = new Map(options.map((item) => [item.zone, item.areaName || `${item.zone}区`]));
    shelves.filter((shelf) => scope.value === 'site' || allowedZones.has(String(shelf.zone).padStart(2,'0')) || allowedZones.has(String(Number(shelf.zone)))).forEach((shelf) => {
      const zone = shelf.zone || "未分区";
      const current = summary.get(zone) ?? {
        zone,
        zoneName: zoneNames.get(zone) || (zone === "未分区" ? zone : `${zone}区`),
        shelfCount: 0,
        totalUnits: 0,
        allocatedUnits: 0,
      };
      current.shelfCount += 1;
      current.totalUnits += shelf.totalUnits;
      current.allocatedUnits += shelf.allocatedUnits;
      summary.set(zone, current);
    });
    rows.value = [...summary.values()].sort(
      (a, b) => {
        const aNumber = Number.parseInt(a.zone, 10);
        const bNumber = Number.parseInt(b.zone, 10);
        if (Number.isFinite(aNumber) && Number.isFinite(bNumber) && aNumber !== bNumber) return aNumber - bNumber;
        if (Number.isFinite(aNumber) !== Number.isFinite(bNumber)) return Number.isFinite(aNumber) ? -1 : 1;
        return a.zone.localeCompare(b.zone, "zh-CN", { numeric: true });
      },
    );
  } catch (cause) {
    error.value = cause instanceof Error ? cause.message : "分区配货数据加载失败";
  } finally {
    loading.value = false;
    uni.stopPullDownRefresh();
  }
}

function chooseDate(value: string) {
  date.value = value;
  datePickerVisible.value = false;
  load();
}

onLoad((query) => {
  if (query?.date) date.value = String(query.date);
  if (query?.scope === 'team') scope.value = 'team';
  load();
});
onPullDownRefresh(load);
</script>

<template>
  <view class="page">
    <view class="date-trigger" @click="datePickerVisible = true"
      ><text>{{ date }}</text><i /></view
    >
    <WareState v-if="loading" type="loading" title="正在加载分区配货进度" />
    <WareState
      v-else-if="error"
      type="error"
      title="加载失败"
      :description="error"
      action-label="重试"
      @action="load"
    />
    <WareState
      v-else-if="!rows.length"
      type="empty"
      title="暂无分区配货数据"
      description="当前场次暂无可统计的配货货架"
    />
    <view v-else class="table">
      <view class="table-head"
        ><text>分区</text><text>货架数量</text><text>分区总扎数</text
        ><text>已配扎数</text></view
      >
      <view v-for="row in rows" :key="row.zone" class="table-row">
        <text>{{ row.zoneName }}</text>
        <b>{{ row.shelfCount }}</b>
        <b>{{ row.totalUnits }}</b>
        <b class="completed">{{ row.allocatedUnits }}</b>
      </view>
    </view>
    <SessionDatePicker
      v-model="date"
      v-model:visible="datePickerVisible"
      @confirm="chooseDate"
    />
  </view>
</template>

<style scoped lang="scss">
.page {
  min-height: 100vh;
  padding: 20rpx 0 60rpx;
  background: var(--wms-surface-page);
}
.date-trigger {
  display: flex;
  width: fit-content;
  height: 58rpx;
  align-items: center;
  gap: 12rpx;
  padding: 0 20rpx;
  color: var(--wms-text);
  font-size: 24rpx;
}
.date-trigger i {
  width: 9rpx;
  height: 9rpx;
  border-right: 2rpx solid var(--wms-text-secondary);
  border-bottom: 2rpx solid var(--wms-text-secondary);
  transform: rotate(45deg) translateY(-3rpx);
}
.table {
  margin-top: 12rpx;
}
.table-head,
.table-row {
  display: grid;
  grid-template-columns: 0.85fr 0.95fr 1fr 1fr;
  align-items: center;
  padding: 0 16rpx;
}
.table-head {
  height: 64rpx;
  background: var(--wms-primary-700);
  color: #fff;
  font-size: 22rpx;
  font-weight: 700;
}
.table-head text:not(:first-child),
.table-row b {
  text-align: center;
}
.table-row {
  min-height: 64rpx;
  margin-top: 4rpx;
  background: #fff;
  font-size: 23rpx;
}
.table-row b {
  font-size: 23rpx;
  font-variant-numeric: tabular-nums;
}
.table-row .completed {
  color: var(--wms-primary-700);
}
</style>
