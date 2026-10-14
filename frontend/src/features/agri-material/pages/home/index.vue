<script setup lang="ts">
import { computed, ref } from "vue";
import { onLoad, onPullDownRefresh } from "@dcloudio/uni-app";
import WareState from "@/shared/components/WareState.vue";
import WarePhoneLink from "@/shared/components/WarePhoneLink.vue";
import SessionTrigger from "@/shared/components/SessionTrigger.vue";
import SessionDatePicker from "@/shared/components/SessionDatePicker.vue";
import {
  agriMaterialApi,
  type AgriOrder,
  type AgriLabel,
} from "../../api/agri-material.api";
import { sessionStore } from "@/store/session";
const tab = ref<"orders" | "labels">("orders"),
  date = ref(new Date().toISOString().slice(0, 10)),
  status = ref(0),
  keyword = ref(""),
  baseName = ref(""),
  supplierId = ref(0),
  bases = ref<string[]>([]),
  suppliers = ref<Array<{ id: number; name: string }>>([]),
  orders = ref<AgriOrder[]>([]),
  labels = ref<AgriLabel[]>([]),
  selected = ref<string[]>([]),
  loading = ref(true),
  error = ref(""),
  datePicker = ref(false),
  filterPicker = ref<"base" | "supplier" | "">(""),
  devicePicker = ref(false),
  connected = ref(false),
  printing = ref(false);
const canPrint = computed(() => sessionStore.can("agriMaterial.print"));
const counts = computed(() =>
  [0, 1, 2, 3].map((s) =>
    s
      ? orders.value.filter((x) => x.orderStatus === s).length
      : orders.value.length,
  ),
);
const visibleOrders = computed(() =>
  orders.value.filter(
    (x) =>
      (!status.value || x.orderStatus === status.value) &&
      (!keyword.value.trim() ||
        x.orderId.includes(keyword.value.trim()) ||
        x.buySupplierName.includes(keyword.value.trim())),
  ),
);
const shownLabels = computed(() =>
  supplierId.value
    ? labels.value.filter((x) => x.supplierId === supplierId.value)
    : labels.value,
);
const allSelected = computed(
  () =>
    shownLabels.value.length > 0 &&
    shownLabels.value.every((x) => selected.value.includes(x.orderId)),
);
async function load() {
  loading.value = true;
  error.value = "";
  try {
    const f = await agriMaterialApi.filters(date.value);
    bases.value = f.bases;
    suppliers.value = f.suppliers;
    orders.value = await agriMaterialApi.orders({
      date: date.value,
      status: 0,
      keyword: "",
      baseName: baseName.value,
      supplierId: supplierId.value,
    });
    if (canPrint.value) {
      labels.value = await agriMaterialApi.labels(date.value, supplierId.value);
      selected.value = labels.value.map((x) => x.orderId);
    }
  } catch (e) {
    error.value = e instanceof Error ? e.message : "农资数据加载失败";
  } finally {
    loading.value = false;
    uni.stopPullDownRefresh();
  }
}
async function dateChange(v: string) {
  date.value = v;
  baseName.value = "";
  supplierId.value = 0;
  await load();
}
function openOrder(x: AgriOrder) {
  uni.navigateTo({
    url: `/features/agri-material/pages/detail/index?id=${encodeURIComponent(x.orderId)}`,
  });
}
function pickBase(v: string) {
  baseName.value = v;
  filterPicker.value = "";
  load();
}
function pickSupplier(v: number) {
  supplierId.value = v;
  filterPicker.value = "";
  load();
}
function toggle(id: string) {
  selected.value = selected.value.includes(id)
    ? selected.value.filter((x) => x !== id)
    : [...selected.value, id];
}
function toggleAll() {
  const ids = shownLabels.value.map((x) => x.orderId);
  selected.value = allSelected.value
    ? selected.value.filter((x) => !ids.includes(x))
    : [...new Set([...selected.value, ...ids])];
}
function print() {
  if (!connected.value) {
    devicePicker.value = true;
    return;
  }
  const count = shownLabels.value.filter((x) =>
    selected.value.includes(x.orderId),
  ).length;
  if (!count) return uni.showToast({ title: "请选择打印订单", icon: "none" });
  printing.value = true;
  setTimeout(() => {
    printing.value = false;
    uni.showToast({ title: `已提交 ${count} 个标签`, icon: "success" });
  }, 500);
}
onLoad(load);
onPullDownRefresh(load);
</script>
<template>
  <view class="page"
    ><view class="segments"
      ><view :class="{ active: tab === 'orders' }" @click="tab = 'orders'"
        >农资订单</view
      ><view
        v-if="canPrint"
        :class="{ active: tab === 'labels' }"
        @click="tab = 'labels'"
        >标签打印</view
      ></view
    ><view class="filters"
      ><view v-if="tab === 'orders'" class="search"
        ><text>⌕</text
        ><input v-model="keyword" placeholder="供应商搜索" /></view
      ><SessionTrigger :value="date" @click="datePicker = true" /><button
        class="base-filter"
        @click="filterPicker = 'base'"
      >
        {{ baseName || "全部基地" }}<i /></button
      ><button class="supplier-filter" @click="filterPicker = 'supplier'">
        {{ suppliers.find((x) => x.id === supplierId)?.name || "全部农资商"
        }}<i /></button></view
    ><WareState
      v-if="loading"
      type="loading"
      title="正在加载农资数据"
    /><WareState
      v-else-if="error"
      type="error"
      title="加载失败"
      :description="error"
      action-label="重试"
      @action="load"
    /><template v-else-if="tab === 'orders'"
      ><view class="status-tabs"
        ><text
          v-for="(name, i) in ['全部', '待发货', '待签收', '已签收']"
          :key="name"
          :class="{ active: status === i }"
          @click="status = i"
          >{{ name }} {{ counts[i] }}</text
        ></view
      ><WareState
        v-if="!visibleOrders.length"
        type="empty"
        title="暂无农资订单"
      /><view
        v-for="x in visibleOrders"
        v-else
        :key="x.orderId"
        class="order"
        @click="openOrder(x)"
        ><view class="order-head"
          ><b>{{ x.orderId }}</b
          ><span :class="`s${x.orderStatus}`">{{ x.statusLabel }}</span></view
        ><view class="identity"
          ><i>{{ x.baseName }}</i
          ><b>{{ x.buySupplierName }}</b></view
        ><WarePhoneLink :phone="x.receiveTel" compact /><view class="order-info"
          ><text>商品 {{ x.goodsCount }} 件</text
          ><text
            >合计 <b>¥{{ x.totalPrice.toFixed(2) }}</b></text
          ></view
        ><view class="order-time"
          ><text>{{ x.createTime }}</text
          ><text>{{ x.date }} 场次</text></view
        ></view
      ></template
    ><template v-else
      ><view class="print-tools"
        ><view class="select-all" @click="toggleAll"
          ><i :class="{ checked: allSelected }">{{ allSelected ? "✓" : "" }}</i
          >全选</view
        ><text
          >共 {{ shownLabels.reduce((s, x) => s + x.goodsCount, 0) }} 件</text
        ><button @click="devicePicker = true">
          {{ connected ? "设备已连接" : "打印机状态" }}</button
        ><button class="primary" :disabled="printing" @click="print">
          开始打印
        </button></view
      ><view class="table-head"
        ><text>供应商信息</text><text>场次</text><text>订单数量</text></view
      ><WareState
        v-if="!shownLabels.length"
        type="empty"
        title="没有农资订单数据"
      /><view
        v-for="x in shownLabels"
        v-else
        :key="x.orderId"
        class="label-row"
        @click="toggle(x.orderId)"
        ><i :class="{ checked: selected.includes(x.orderId) }">{{
          selected.includes(x.orderId) ? "✓" : ""
        }}</i
        ><view
          ><b>{{ x.supplierName }}</b
          ><small>{{ x.baseName }} · {{ x.orderId }}</small></view
        ><text>{{ x.sessionDate }}</text
        ><b>{{ x.goodsCount }}</b></view
      ></template
    ><SessionDatePicker
      v-model="date"
      v-model:visible="datePicker"
      @confirm="dateChange"
    /><view v-if="filterPicker" class="mask" @click="filterPicker = ''"
      ><view class="drawer" @click.stop
        ><view class="drawer-title"
          ><b>{{ filterPicker === "base" ? "选择基地" : "选择农资供应商" }}</b
          ><text @click="filterPicker = ''">关闭</text></view
        ><view class="options" v-if="filterPicker === 'base'"
          ><view :class="{ active: !baseName }" @click="pickBase('')"
            >全部基地</view
          ><view
            v-for="x in bases"
            :key="x"
            :class="{ active: baseName === x }"
            @click="pickBase(x)"
            >{{ x }}</view
          ></view
        ><view class="options" v-else
          ><view :class="{ active: !supplierId }" @click="pickSupplier(0)"
            >全部农资商</view
          ><view
            v-for="x in suppliers"
            :key="x.id"
            :class="{ active: supplierId === x.id }"
            @click="pickSupplier(x.id)"
            >{{ x.name }}</view
          ></view
        ></view
      ></view
    ><view v-if="devicePicker" class="mask" @click="devicePicker = false"
      ><view class="drawer" @click.stop
        ><view class="drawer-title"
          ><b>蓝牙打印机</b
          ><text @click="devicePicker = false">关闭</text></view
        ><view
          class="device"
          @click="
            connected = true;
            devicePicker = false;
          "
          ><view
            ><b>标签打印机</b
            ><small>{{
              connected ? "已连接，可开始打印" : "点击连接设备"
            }}</small></view
          ><text>{{ connected ? "已连接" : "连接" }}</text></view
        ></view
      ></view
    ></view
  >
</template>
<style scoped>
.page {
  min-height: 100vh;
  padding: 18rpx 20rpx 40rpx;
  background: var(--wms-background);
}
.segments {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 6rpx;
  padding: 6rpx;
  border: 1rpx solid var(--wms-border);
  border-radius: 12rpx;
  background: #fff;
}
.segments view {
  height: 58rpx;
  border-radius: 8rpx;
  color: var(--wms-text-secondary);
  font-size: 22rpx;
  line-height: 58rpx;
  text-align: center;
}
.segments .active {
  background: var(--wms-primary-700);
  color: #fff;
  font-weight: 700;
}
.filters {
  display: flex;
  align-items: center;
  justify-content: flex-start;
  gap: 7rpx;
  margin: 12rpx 0;
}
.filters .base-filter {
  margin-left: auto;
}
.search {
  display: flex;
  align-items: center;
  min-width: 0;
  height: 56rpx;
  width: 170rpx;
  flex: 0 1 170rpx;
  padding: 0 10rpx;
  border: 1rpx solid var(--wms-border);
  border-radius: 8rpx;
  background: #fff;
}
.filters :deep(.session-trigger) {
  flex: none;
  width: auto;
  max-width: none;
  padding: 0 10rpx;
  font-size: 17rpx;
  white-space: nowrap;
}
.filters :deep(.session-trigger .calendar-icon) {
  width: 21rpx;
  height: 20rpx;
}
.search input {
  min-width: 0;
  flex: 1;
  font-size: 18rpx;
}
.filters button {
  display: flex;
  align-items: center;
  gap: 5rpx;
  max-width: 132rpx;
  height: 56rpx;
  margin: 0;
  padding: 0 9rpx;
  border: 1rpx solid var(--wms-border);
  border-radius: 8rpx;
  background: #fff;
  color: var(--wms-primary-700);
  font-size: 17rpx;
  line-height: 56rpx;
  overflow: hidden;
  white-space: nowrap;
}
.filters button:after {
  border: 0;
}
.filters i {
  width: 7rpx;
  height: 7rpx;
  border-right: 2rpx solid;
  border-bottom: 2rpx solid;
  transform: rotate(45deg);
}
.status-tabs {
  display: flex;
  border-bottom: 1rpx solid var(--wms-border);
}
.status-tabs text {
  flex: 1;
  padding: 13rpx 2rpx;
  font-size: 17rpx;
  text-align: center;
}
.status-tabs .active {
  border-bottom: 3rpx solid var(--wms-primary-700);
  color: var(--wms-primary-700);
  font-weight: 700;
}
.order {
  margin-top: 8rpx;
  padding: 15rpx;
  background: #fff;
}
.order-head,
.identity,
.order-info,
.order-time {
  display: flex;
  align-items: center;
  justify-content: space-between;
}
.order-head b {
  font-size: 21rpx;
}
.order-head span {
  padding: 3rpx 7rpx;
  border-radius: 5rpx;
  font-size: 16rpx;
}
.s1 {
  background: #f0f2f2;
}
.s2 {
  background: #fff1da;
  color: #9b5c00;
}
.s3 {
  background: var(--wms-surface-soft);
  color: var(--wms-success);
}
.identity {
  justify-content: flex-start;
  gap: 8rpx;
  margin: 9rpx 0;
}
.identity i {
  padding: 3rpx 6rpx;
  background: var(--wms-primary-700);
  color: #fff;
  font-size: 15rpx;
  font-style: normal;
}
.identity b {
  font-size: 21rpx;
}
.order-info,
.order-time {
  margin-top: 9rpx;
  font-size: 18rpx;
}
.order-info b {
  color: var(--wms-danger);
}
.order-time {
  padding-top: 9rpx;
  border-top: 1rpx dashed var(--wms-border);
  color: var(--wms-text-secondary);
  font-size: 16rpx;
}
.print-tools {
  display: flex;
  align-items: center;
  gap: 8rpx;
  margin-bottom: 10rpx;
  font-size: 17rpx;
}
.print-tools > text {
  margin-left: auto;
}
.print-tools button {
  height: 50rpx;
  margin: 0;
  padding: 0 10rpx;
  border: 1rpx solid var(--wms-border);
  border-radius: 7rpx;
  background: #fff;
  font-size: 16rpx;
  line-height: 50rpx;
}
.print-tools button:after {
  border: 0;
}
.print-tools .primary {
  border-color: var(--wms-primary-700);
  background: var(--wms-primary-700);
  color: #fff;
}
.select-all {
  display: flex;
  align-items: center;
  gap: 5rpx;
}
.select-all i,
.label-row > i {
  display: flex;
  width: 27rpx;
  height: 27rpx;
  box-sizing: border-box;
  align-items: center;
  justify-content: center;
  border: 1rpx solid var(--wms-border);
  border-radius: 2rpx;
  color: #fff;
  font-style: normal;
}
.select-all i.checked,
.label-row > i.checked {
  border-color: var(--wms-primary-700);
  background: var(--wms-primary-700);
}
.table-head,
.label-row {
  display: grid;
  grid-template-columns: minmax(0, 1.5fr) 108rpx 75rpx;
  align-items: center;
  gap: 7rpx;
}
.table-head {
  padding: 12rpx;
  background: var(--wms-primary-700);
  color: #fff;
  font-size: 18rpx;
}
.label-row {
  grid-template-columns: 30rpx minmax(0, 1.5fr) 108rpx 75rpx;
  margin-top: 5rpx;
  padding: 12rpx;
  background: #fff;
  font-size: 18rpx;
}
.label-row small {
  display: block;
  margin-top: 3rpx;
  color: var(--wms-text-secondary);
  font-size: 16rpx;
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
  box-sizing: border-box;
  width: 100%;
  min-height: 48vh;
  padding: 25rpx 22rpx calc(22rpx + env(safe-area-inset-bottom));
  border-radius: 24rpx 24rpx 0 0;
  background: #fff;
}
.drawer-title {
  display: flex;
  justify-content: space-between;
}
.drawer-title text {
  color: var(--wms-primary-700);
}
.options {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 9rpx;
  margin-top: 18rpx;
}
.options view {
  padding: 17rpx 5rpx;
  background: var(--wms-background);
  font-size: 18rpx;
  text-align: center;
}
.options .active {
  background: var(--wms-primary-700);
  color: #fff;
}
.device {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-top: 20rpx;
  padding: 18rpx;
  background: var(--wms-background);
}
.device b,
.device small {
  display: block;
}
.device small {
  margin-top: 5rpx;
  color: var(--wms-text-secondary);
}
.device > text {
  color: var(--wms-primary-700);
}
</style>
