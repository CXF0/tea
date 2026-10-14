<script setup lang="ts">
import { computed, ref } from "vue";
import { onLoad } from "@dcloudio/uni-app";
import WareState from "@/shared/components/WareState.vue";
import {
  baseManagementApi,
  type PrintItem,
} from "../../api/base-management.api";
type SortMode = "default" | "name" | "shelf" | "quantity";
const supplierId = ref(0),
  date = ref(""),
  supplierName = ref(""),
  items = ref<PrintItem[]>([]),
  selected = ref<number[]>([]),
  exchangeOnly = ref(false),
  connected = ref(false),
  loading = ref(true),
  error = ref(""),
  devicePanel = ref(false),
  sortPanel = ref(false),
  printing = ref(false),
  sortMode = ref<SortMode>("default");
const sortLabels: Record<SortMode, string> = {
  default: "默认排序",
  name: "按名称排序",
  shelf: "按货架号排序",
  quantity: "按数量排序",
};
const visible = computed(() => {
  const rows = exchangeOnly.value
    ? items.value.filter((x) => x.exchange)
    : [...items.value];
  if (sortMode.value === "name")
    rows.sort((a, b) => a.name.localeCompare(b.name, "zh-CN"));
  if (sortMode.value === "shelf")
    rows.sort((a, b) => a.shelf.localeCompare(b.shelf, "zh-CN"));
  if (sortMode.value === "quantity")
    rows.sort((a, b) => b.quantity - a.quantity);
  return rows;
});
const allSelected = computed(
  () =>
    visible.value.length > 0 &&
    visible.value.every((x) => selected.value.includes(x.id)),
);
async function load() {
  loading.value = true;
  error.value = "";
  try {
    const d = await baseManagementApi.printItems(supplierId.value, date.value);
    supplierName.value = d.supplier.name;
    items.value = d.items;
    selected.value = d.items.map((x) => x.id);
  } catch (e) {
    error.value = e instanceof Error ? e.message : "待打印数据加载失败";
  } finally {
    loading.value = false;
  }
}
function toggleItem(id: number) {
  selected.value = selected.value.includes(id)
    ? selected.value.filter((x) => x !== id)
    : [...selected.value, id];
}
function toggleAll() {
  const ids = visible.value.map((x) => x.id);
  selected.value = allSelected.value
    ? selected.value.filter((x) => !ids.includes(x))
    : [...new Set([...selected.value, ...ids])];
}
function selectDevice() {
  connected.value = true;
  devicePanel.value = false;
  uni.showToast({ title: "打印机已连接", icon: "success" });
}
function startPrint() {
  if (!connected.value) {
    devicePanel.value = true;
    uni.showToast({ title: "请先连接蓝牙打印机", icon: "none" });
    return;
  }
  const count = visible.value.filter((x) =>
    selected.value.includes(x.id),
  ).length;
  if (!count) {
    uni.showToast({ title: "请至少选择一条数据", icon: "none" });
    return;
  }
  printing.value = true;
  setTimeout(() => {
    printing.value = false;
    uni.showToast({ title: `已提交 ${count} 个标签`, icon: "success" });
  }, 500);
}
function chooseSort(mode: SortMode) {
  sortMode.value = mode;
  sortPanel.value = false;
}
function openFlowerPrint() {
  uni.navigateTo({
    url: `/features/base-management/pages/supplier-stock/index?id=${supplierId.value}&date=${date.value}&mode=print`,
  });
}
onLoad((q) => {
  supplierId.value = Number(q?.id || 0);
  date.value = String(q?.date || new Date().toISOString().slice(0, 10));
  load();
});
</script>
<template>
  <view class="page">
    <view class="toolbar"
      ><button class="outline" @click="devicePanel = true">蓝牙设备</button
      ><button class="outline" @click="devicePanel = true">
        {{ connected ? "设备已连接" : "设备状态" }}</button
      ><button
        class="primary"
        :disabled="printing"
        :loading="printing"
        @click="startPrint"
      >
        开始打印</button
      ><text class="flower-link" @click="openFlowerPrint"
        >花材打印 →</text
      ></view
    >
    <view class="filter-row"
      ><view class="filter-actions"
        ><view class="check-action" @click="toggleAll"
          ><i :class="{ checked: allSelected }">{{ allSelected ? "✓" : "" }}</i
          ><text>全选</text></view
        ><button
          class="exchange-filter"
          :class="{ active: exchangeOnly }"
          @click="exchangeOnly = !exchangeOnly"
        >
          只选换货
        </button></view
      ><view class="sort-trigger" @click="sortPanel = true"
        >{{ sortLabels[sortMode] }}<i /></view
    ></view>
    <view class="supplier-tip">{{ supplierName }} · {{ date }}</view
    ><view class="table-head"
      ><text>名称</text><text>货架号</text><text>数量</text></view
    >
    <WareState
      v-if="loading"
      type="loading"
      title="正在加载待打印数据"
    /><WareState
      v-else-if="error"
      type="error"
      title="加载失败"
      :description="error"
      action-label="重试"
      @action="load"
    /><WareState
      v-else-if="!visible.length"
      type="empty"
      :title="exchangeOnly ? '暂无换货标签' : '数据为空'"
      :description="
        exchangeOnly ? '当前供应商没有需要换货的花材' : '当前场次暂无可打印花材'
      "
    />
    <view
      v-for="item in visible"
      v-else
      :key="item.id"
      class="table-row"
      :class="{ selected: selected.includes(item.id) }"
      @click="toggleItem(item.id)"
      ><view class="name-cell"
        ><i :class="{ checked: selected.includes(item.id) }">{{
          selected.includes(item.id) ? "✓" : ""
        }}</i
        ><view
          ><b
            >{{ item.name }}
            {{ ["", "A", "B", "C"][item.rank] || item.rank }}级</b
          ><small v-if="item.exchange">换货</small></view
        ></view
      ><text>#{{ item.shelf }}</text
      ><strong>{{ item.quantity }} 扎</strong></view
    >
    <view v-if="devicePanel" class="mask" @click="devicePanel = false"
      ><view class="drawer" @click.stop
        ><view class="drawer-title"
          ><b>蓝牙打印机</b><text @click="devicePanel = false">关闭</text></view
        ><view class="device-card" @click="selectDevice"
          ><view
            ><b>标签打印机</b
            ><text>{{
              connected ? "已连接，可开始打印" : "点击连接设备"
            }}</text></view
          ><i :class="{ connected }">{{
            connected ? "已连接" : "连接"
          }}</i></view
        ></view
      ></view
    >
    <view v-if="sortPanel" class="mask" @click="sortPanel = false"
      ><view class="drawer" @click.stop
        ><view class="drawer-title"
          ><b>选择排序方式</b><text @click="sortPanel = false">关闭</text></view
        ><view class="sort-options"
          ><view
            v-for="(label, mode) in sortLabels"
            :key="mode"
            :class="{ active: sortMode === mode }"
            @click="chooseSort(mode as SortMode)"
            >{{ label }}</view
          ></view
        ></view
      ></view
    >
  </view>
</template>
<style scoped>
.page {
  min-height: 100vh;
  padding: 18rpx 20rpx 40rpx;
  background: var(--wms-background);
}
.toolbar {
  display: grid;
  grid-template-columns: 104rpx 104rpx 118rpx 1fr;
  align-items: center;
  gap: 10rpx;
}
.toolbar button {
  height: 54rpx;
  margin: 0;
  padding: 0;
  border-radius: 7rpx;
  font-size: 17rpx;
  line-height: 54rpx;
}
.toolbar button:after {
  border: 0;
}
.outline {
  border: 1rpx solid var(--wms-border) !important;
  background: #fff;
  color: var(--wms-text-primary);
}
.primary {
  background: var(--wms-primary-700);
  color: #fff;
}
.flower-link {
  justify-self: end;
  color: var(--wms-primary-700);
  font-size: 18rpx;
  white-space: nowrap;
}
.filter-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin: 17rpx 0;
}
.filter-actions {
  display: flex;
  align-items: center;
  gap: 13rpx;
}
.check-action {
  display: flex;
  align-items: center;
  gap: 7rpx;
  font-size: 19rpx;
}
.check-action i,
.name-cell > i {
  display: flex;
  width: 27rpx;
  height: 27rpx;
  box-sizing: border-box;
  align-items: center;
  justify-content: center;
  border: 1rpx solid var(--wms-border);
  border-radius: 2rpx;
  background: #fff;
  color: #fff;
  font-size: 18rpx;
  font-style: normal;
}
.check-action i.checked,
.name-cell > i.checked {
  border-color: var(--wms-primary-700);
  background: var(--wms-primary-700);
}
.exchange-filter {
  height: 48rpx;
  margin: 0;
  padding: 0 16rpx;
  border: 1rpx solid var(--wms-border);
  border-radius: 6rpx;
  background: #fff;
  font-size: 17rpx;
  line-height: 48rpx;
}
.exchange-filter:after {
  border: 0;
}
.exchange-filter.active {
  border-color: var(--wms-primary-700);
  background: var(--wms-surface-soft);
  color: var(--wms-primary-700);
}
.sort-trigger {
  display: flex;
  align-items: center;
  gap: 8rpx;
  font-size: 18rpx;
}
.sort-trigger i {
  width: 8rpx;
  height: 8rpx;
  border-right: 2rpx solid currentColor;
  border-bottom: 2rpx solid currentColor;
  transform: rotate(45deg);
}
.supplier-tip {
  margin-bottom: 9rpx;
  color: var(--wms-text-secondary);
  font-size: 16rpx;
}
.table-head,
.table-row {
  display: grid;
  grid-template-columns: 1.7fr 0.75fr 0.6fr;
  align-items: center;
  gap: 10rpx;
}
.table-head {
  padding: 14rpx 13rpx;
  background: #fff;
  font-size: 18rpx;
}
.table-row {
  margin-top: 5rpx;
  padding: 14rpx 13rpx;
  background: #fff;
  font-size: 17rpx;
}
.table-row.selected {
  box-shadow: inset 3rpx 0 var(--wms-primary-700);
}
.name-cell {
  display: flex;
  min-width: 0;
  align-items: center;
  gap: 9rpx;
}
.name-cell b,
.name-cell small {
  display: block;
}
.name-cell b {
  font-size: 18rpx;
}
.name-cell small {
  width: max-content;
  margin-top: 3rpx;
  padding: 2rpx 6rpx;
  background: #f3e8ff;
  color: #7e22ce;
  font-size: 14rpx;
}
.table-row strong {
  color: var(--wms-primary-700);
  font-size: 18rpx;
}
.mask {
  position: fixed;
  z-index: 80;
  inset: 0;
  display: flex;
  align-items: flex-end;
  background: #0007;
}
.drawer {
  width: 100%;
  padding: 25rpx 22rpx calc(22rpx + env(safe-area-inset-bottom));
  border-radius: 24rpx 24rpx 0 0;
  background: #fff;
}
.drawer-title {
  display: flex;
  align-items: center;
  justify-content: space-between;
}
.drawer-title text {
  color: var(--wms-primary-700);
}
.device-card {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-top: 20rpx;
  padding: 18rpx;
  background: var(--wms-background);
}
.device-card b,
.device-card text {
  display: block;
}
.device-card text {
  margin-top: 5rpx;
  color: var(--wms-text-secondary);
  font-size: 16rpx;
}
.device-card > i {
  color: var(--wms-primary-700);
  font-style: normal;
}
.device-card > i.connected {
  color: var(--wms-success);
}
.sort-options {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 10rpx;
  margin-top: 20rpx;
}
.sort-options view {
  padding: 18rpx;
  background: var(--wms-background);
  text-align: center;
}
.sort-options .active {
  background: var(--wms-primary-700);
  color: #fff;
}
</style>
