<script setup lang="ts">
import { computed, ref } from "vue";
import { onLoad, onPullDownRefresh } from "@dcloudio/uni-app";
import WareState from "@/shared/components/WareState.vue";
import WarePhoneLink from "@/shared/components/WarePhoneLink.vue";
import SessionTrigger from "@/shared/components/SessionTrigger.vue";
import SessionDatePicker from "@/shared/components/SessionDatePicker.vue";
import { admissionApi } from "@/features/admission/api/admission.api";
import {
  baseManagementApi,
  type BaseRow,
  type BaseSupplier,
  type BaseSummary,
  type BaseZoneSummary,
} from "../../api/base-management.api";
type MainTab = "现场管理" | "基地详情";
const date = ref(new Date().toISOString().slice(0, 10)),
  tab = ref<MainTab>("现场管理"),
  status = ref(-1),
  bases = ref<BaseRow[]>([]),
  baseId = ref(0),
  summary = ref<BaseSummary>(),
  suppliers = ref<BaseSupplier[]>([]),
  keyword = ref(""),
  loading = ref(true),
  error = ref(""),
  picker = ref(false),
  basePicker = ref(false),
  zoneDrawer = ref(false),
  zoneLoading = ref(false),
  zoneError = ref(""),
  zones = ref<BaseZoneSummary[]>([]),
  activeZoneCode = ref(""),
  updating = ref<number>();
const activeBase = computed(() =>
  bases.value.find((x) => x.id === baseId.value),
);
const traded = computed(() =>
  suppliers.value.filter((x) => x.admissionId !== null),
);
const filtered = computed(() => {
  const source = tab.value === "现场管理" ? traded.value : suppliers.value;
  return source.filter(
    (x) =>
      (status.value < 0 || x.status === status.value) &&
      (!keyword.value.trim() || x.name.includes(keyword.value.trim())),
  );
});
const pending = computed(
    () => traded.value.filter((x) => x.status === 0).length,
  ),
  admitted = computed(() => traded.value.filter((x) => x.status === 1).length);
async function load() {
  loading.value = true;
  error.value = "";
  try {
    bases.value = await baseManagementApi.bases(date.value);
    if (!bases.value.some((x) => x.id === baseId.value))
      baseId.value = bases.value[0]?.id || 0;
    if (baseId.value) {
      const d = await baseManagementApi.base(baseId.value, date.value);
      summary.value = d.summary;
      suppliers.value = d.suppliers;
    } else {
      summary.value = undefined;
      suppliers.value = [];
    }
  } catch (e) {
    error.value = e instanceof Error ? e.message : "基地管理数据加载失败";
  } finally {
    loading.value = false;
    uni.stopPullDownRefresh();
  }
}
async function chooseBase(id: number) {
  baseId.value = id;
  basePicker.value = false;
  status.value = -1;
  keyword.value = "";
  await load();
}
async function changeDate(v: string) {
  date.value = v;
  await load();
}
async function openZones() {
  zoneDrawer.value = true;
  zoneLoading.value = true;
  zoneError.value = "";
  activeZoneCode.value = "";
  try {
    const data = await baseManagementApi.zones(baseId.value, date.value);
    zones.value = data.zones;
  } catch (e) {
    zoneError.value = e instanceof Error ? e.message : "分区数据加载失败";
  } finally {
    zoneLoading.value = false;
  }
}
async function toggleAdmission(row: BaseSupplier) {
  if (!row.admissionId) return;
  const target = row.status === 1 ? 0 : 1;
  uni.showModal({
    title: target ? "确认进场" : "取消进场",
    content: `确认将${row.name}设为${target ? "已进场" : "未进场"}吗？`,
    success: async (r) => {
      if (!r.confirm) return;
      updating.value = row.id;
      try {
        await admissionApi.setStatus(row.admissionId!, target as 0 | 1);
        await load();
        uni.showToast({ title: "状态已更新", icon: "success" });
      } catch (e) {
        uni.showToast({
          title: e instanceof Error ? e.message : "更新失败",
          icon: "none",
        });
      } finally {
        updating.value = undefined;
      }
    },
  });
}
function helpPrint(row: BaseSupplier) {
  uni.navigateTo({
    url: `/features/base-management/pages/label-print/index?id=${row.id}&date=${date.value}`,
  });
}
function openSupplier(row: BaseSupplier) {
  uni.navigateTo({
    url: `/features/base-management/pages/supplier-stock/index?id=${row.id}&date=${date.value}`,
  });
}
onLoad((q) => {
  if (q?.date) date.value = String(q.date);
  load();
});
onPullDownRefresh(load);
</script>
<template>
  <view class="page"
    ><view class="context"
      ><SessionTrigger :value="date" @click="picker = true" /><view
        class="base-trigger"
        @click="basePicker = true"
        >{{ activeBase?.name || "暂无基地" }}<i /></view></view
    ><view class="main-tabs"
      ><view
        :class="{ active: tab === '现场管理' }"
        @click="
          tab = '现场管理';
          status = -1;
        "
        >现场管理</view
      ><view
        :class="{ active: tab === '基地详情' }"
        @click="
          tab = '基地详情';
          status = -1;
        "
        >基地详情</view
      ></view
    ><WareState
      v-if="loading"
      type="loading"
      title="正在加载基地管理"
    /><WareState
      v-else-if="error"
      type="error"
      title="加载失败"
      :description="error"
      action-label="重试"
      @action="load"
    /><WareState
      v-else-if="!activeBase"
      type="empty"
      title="暂无可管理基地"
      description="请先给当前账号配置基地权限"
    /><template v-else>
      <template v-if="tab === '现场管理'"
        ><view class="overview"
          ><view
            ><b>{{ traded.length }}</b
            ><text>今日交易</text></view
          ><view
            ><b>{{ pending }}</b
            ><text>未进场</text></view
          ><view
            ><b>{{ admitted }}</b
            ><text>已进场</text></view
          ><view
            ><b>{{ activeBase.inboundNum }}</b
            ><text>花材/扎</text></view
          ></view
        ><view class="status-line"><view class="status-tabs"
          ><text :class="{ active: status === -1 }" @click="status = -1"
            >全部 {{ traded.length }}</text
          ><text :class="{ active: status === 0 }" @click="status = 0"
            >未进场 {{ pending }}</text
          ><text :class="{ active: status === 1 }" @click="status = 1"
            >已进场 {{ admitted }}</text
          ></view><button class="zone-entry" @click="openZones">查看分区</button></view
        ><view class="search"
          ><text>⌕</text
          ><input v-model="keyword" placeholder="供应商名称" /></view
        ><WareState
          v-if="!filtered.length"
          type="empty"
          title="暂无今日交易供应商"
        /><view v-else class="site-list"
          ><view
            v-for="x in filtered"
            :key="x.id"
            class="site-row"
            @click="openSupplier(x)"
            ><view class="identity"
              ><b>{{ x.name }}</b
              ><WarePhoneLink :phone="x.phone" compact
              /><small>普通 {{ x.inboundNum }}扎 · 代卖 0扎</small></view
            ><button
              :class="x.status === 1 ? 'entered' : 'pending'"
              :disabled="updating === x.id"
              @click.stop="toggleAdmission(x)"
            >
              {{ x.status === 1 ? "已进场" : "未进场" }}</button
            ><button class="print" @click.stop="helpPrint(x)">
              帮打标签
            </button></view
          ></view
        ></template
      >
      <template v-else-if="summary"
        ><view class="base-title"
          ><b>{{ summary.name }}</b
          ><text>今日统计</text></view
        ><view class="detail-stats"
          ><view
            ><b>{{ summary.supplierCount }}</b
            ><text>在售商户</text></view
          ><view
            ><b>{{ summary.productCount }}</b
            ><text>在售品种</text></view
          ><view
            ><b>{{ summary.stockNum }}</b
            ><text>库存扎数</text></view
          ><view
            ><b>{{ summary.inboundNum }}</b
            ><text>普通销量</text></view
          ><view
            ><b>{{ summary.allocatedNum }}</b
            ><text>已配扎数</text></view
          ><view><b>0</b><text>代卖销量</text></view
          ><view
            ><b>{{ summary.admittedCount }}</b
            ><text>今日进场</text></view
          ><view
            ><b>{{ summary.inboundNum }}</b
            ><text>今日上架</text></view
          ></view
        ><view class="detail-tools"
          ><b>供应商统计</b
          ><view class="search"
            ><input v-model="keyword" placeholder="供应商名称" /></view></view
        ><view class="supplier-cards"
          ><view
            v-for="x in filtered"
            :key="x.id"
            class="supplier-card"
            @click="openSupplier(x)"
            ><view class="supplier-head"
              ><view
                ><i>{{ summary.name }}</i
                ><b>{{ x.name }}</b></view
              ><WarePhoneLink :phone="x.phone" compact
              /></view
            ><view class="supplier-metrics"
              ><view
                ><text>普通销量</text><b>{{ x.inboundNum }}</b></view
              ><view
                ><text>今日订单</text><b>{{ x.productCount }}</b></view
              ><view><text>代卖销量</text><b>0</b></view
              ><view
                ><text>库存扎数</text><b>{{ x.stockNum }}</b></view
              ><view
                ><text>已配扎数</text><b>{{ x.allocatedNum }}</b></view
              ><view
                ><text>今日上架</text><b>{{ x.inboundNum }}</b></view
              ></view
            ></view
          ></view
        ></template
      ></template
    >
    <SessionDatePicker
      v-model="date"
      v-model:visible="picker"
      @confirm="changeDate"
    />
    <view v-if="zoneDrawer" class="mask" @click="zoneDrawer = false">
      <view class="drawer zone-drawer" @click.stop>
        <view class="drawer-title">
          <view><b>今日花材分区</b><small>{{ activeBase?.name }} · {{ date }}</small></view>
          <text @click="zoneDrawer = false">关闭</text>
        </view>
        <WareState v-if="zoneLoading" type="loading" title="正在加载分区" />
        <WareState v-else-if="zoneError" type="error" title="加载失败" :description="zoneError" action-label="重试" @action="openZones" />
        <WareState v-else-if="!zones.length" type="empty" title="今日暂无已分区花材" description="花材分配分区后将在这里展示" />
        <scroll-view v-else scroll-y class="zone-scroll">
          <view class="zone-options">
            <view v-for="zone in zones" :key="zone.code || 'unassigned'" :class="{ active: activeZoneCode === zone.code }" @click="activeZoneCode = activeZoneCode === zone.code ? '' : zone.code">
              <b>{{ zone.name }}</b><text>{{ zone.frameCount }}扎</text>
            </view>
          </view>
          <view v-for="zone in zones" v-show="activeZoneCode === zone.code" :key="`detail-${zone.code}`" class="zone-detail">
            <view class="zone-summary"><b>{{ zone.name }}</b><text>{{ zone.varietyCount }}种花材 · {{ zone.frameCount }}扎</text></view>
            <view class="zone-table-head"><text>花材/等级</text><text>供应商</text><text>数量</text></view>
            <view v-for="(item,index) in zone.items" :key="`${item.productId}-${item.rank}-${item.supplierName}-${index}`" class="zone-item">
              <text>{{ item.productName }} {{ ['', 'A', 'B', 'C', 'D', 'E'][item.rank] || '' }}级</text><text>{{ item.supplierName }}</text><b>{{ item.frameCount }}扎</b>
            </view>
          </view>
          <view v-if="!activeZoneCode" class="zone-tip">点击分区查看对应花材明细</view>
        </scroll-view>
      </view>
    </view>
    <view v-if="basePicker" class="mask" @click="basePicker = false"
      ><view class="drawer" @click.stop
        ><view class="drawer-title"
          ><b>选择基地</b><text @click="basePicker = false">关闭</text></view
        ><scroll-view scroll-y class="base-scroll"
          ><view class="base-options"
            ><view
              v-for="x in bases"
              :key="x.id"
              :class="{ active: x.id === baseId }"
              @click="chooseBase(x.id)"
              >{{ x.name }}</view
            ></view
          ></scroll-view
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
.context {
  display: flex;
  align-items: center;
  justify-content: space-between;
}
.base-trigger {
  display: flex;
  align-items: center;
  gap: 10rpx;
  color: var(--wms-primary-700);
  font-size: 21rpx;
  font-weight: 700;
}
.base-trigger i {
  width: 8rpx;
  height: 8rpx;
  border-right: 2rpx solid currentColor;
  border-bottom: 2rpx solid currentColor;
  transform: rotate(45deg);
}
.main-tabs {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 6rpx;
  margin: 15rpx 0;
  padding: 6rpx;
  border: 1rpx solid var(--wms-border);
  border-radius: 12rpx;
  background: #fff;
}
.main-tabs view {
  height: 62rpx;
  border-radius: 8rpx;
  color: var(--wms-text-secondary);
  font-size: 23rpx;
  line-height: 62rpx;
  text-align: center;
}
.main-tabs .active {
  background: var(--wms-primary-700);
  color: #fff;
  font-weight: 700;
}
.overview {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 8rpx;
}
.overview view {
  padding: 14rpx 4rpx;
  background: #fff;
  text-align: center;
}
.overview b,
.overview text {
  display: block;
}
.overview b {
  color: var(--wms-primary-700);
  font-size: 29rpx;
}
.overview text {
  font-size: 17rpx;
}
.status-tabs {
  display: flex;
  min-width: 0;
  flex: 1;
  border-bottom: 1rpx solid var(--wms-border);
}
.status-line {
  display: flex;
  align-items: stretch;
  gap: 8rpx;
  margin-top: 14rpx;
  border-bottom: 1rpx solid var(--wms-border);
}
.zone-entry {
  width: 104rpx;
  height: 54rpx;
  margin: 0;
  padding: 0;
  border: 1rpx solid var(--wms-border);
  border-radius: 7rpx;
  background: #fff;
  color: var(--wms-primary-700);
  font-size: 18rpx;
  line-height: 52rpx;
}
.zone-entry:after { border: 0; }
.status-tabs text {
  padding: 15rpx 22rpx;
  font-size: 19rpx;
}
.status-tabs .active {
  color: var(--wms-primary-700);
  font-weight: 700;
  border-bottom: 3rpx solid var(--wms-primary-700);
}
.search {
  display: flex;
  height: 56rpx;
  align-items: center;
  gap: 7rpx;
  padding: 0 12rpx;
  border: 1rpx solid var(--wms-border);
  border-radius: 9rpx;
  background: #fff;
}
.search input {
  min-width: 0;
  flex: 1;
  font-size: 18rpx;
}
.status-line + .search {
  margin-top: 12rpx;
}
.site-list {
  margin-top: 10rpx;
}
.site-row {
  display: grid;
  grid-template-columns: minmax(0, 1fr) 82rpx 102rpx;
  align-items: center;
  gap: 9rpx;
  margin-top: 6rpx;
  padding: 13rpx 12rpx;
  background: #fff;
}
.identity b,
.identity small {
  display: block;
}
.identity b {
  font-size: 20rpx;
}
.identity > text {
  display: block;
  margin-top: 3rpx;
  color: var(--wms-primary-700);
  font-size: 16rpx;
}
.identity small {
  margin-top: 5rpx;
  color: var(--wms-text-secondary);
  font-size: 16rpx;
}
.site-row button {
  height: 52rpx;
  margin: 0;
  padding: 0;
  border: 0;
  border-radius: 6rpx;
  font-size: 16rpx;
  line-height: 52rpx;
}
.site-row button:after {
  border: 0;
}
.site-row .entered {
  background: var(--wms-surface-soft);
  color: var(--wms-success);
}
.site-row .pending {
  background: #fde8e8;
  color: var(--wms-danger);
}
.site-row .print {
  background: var(--wms-primary-700);
  color: #fff;
}
.base-title {
  display: flex;
  align-items: end;
  justify-content: space-between;
}
.base-title b {
  color: var(--wms-primary-700);
  font-size: 31rpx;
}
.base-title text {
  font-size: 20rpx;
  font-weight: 700;
}
.detail-stats {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 10rpx;
  margin-top: 12rpx;
}
.detail-stats view {
  padding: 13rpx 6rpx;
  background: var(--wms-surface-soft);
  color: var(--wms-primary-700);
}
.detail-stats b,
.detail-stats text {
  display: block;
}
.detail-stats b {
  font-size: 26rpx;
}
.detail-stats text {
  margin-top: 3rpx;
  font-size: 16rpx;
}
.detail-tools {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin: 18rpx 0 10rpx;
}
.detail-tools > b {
  font-size: 24rpx;
}
.detail-tools .search {
  width: 270rpx;
}
.supplier-cards {
  display: flex;
  flex-direction: column;
  gap: 10rpx;
}
.supplier-card {
  padding: 17rpx;
  background: #fff;
  border-radius: 12rpx;
}
.supplier-head {
  display: flex;
  align-items: center;
  justify-content: space-between;
}
.supplier-head > view {
  display: flex;
  align-items: center;
  gap: 8rpx;
}
.supplier-head i {
  padding: 3rpx 7rpx;
  border-radius: 4rpx;
  background: var(--wms-primary-700);
  color: #fff;
  font-size: 14rpx;
  font-style: normal;
}
.supplier-head b {
  font-size: 21rpx;
}
.supplier-head > text {
  color: var(--wms-primary-700);
  font-size: 16rpx;
}
.supplier-metrics {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 12rpx;
  margin-top: 15rpx;
}
.supplier-metrics view {
  text-align: center;
}
.supplier-metrics text,
.supplier-metrics b {
  display: block;
}
.supplier-metrics text {
  color: var(--wms-text-secondary);
  font-size: 15rpx;
}
.supplier-metrics b {
  margin-top: 5rpx;
  color: var(--wms-danger);
  font-size: 22rpx;
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
  padding: 26rpx 22rpx calc(22rpx + env(safe-area-inset-bottom));
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
.base-scroll {
  max-height: 60vh;
}
.base-options {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 10rpx;
  margin-top: 20rpx;
}
.base-options view {
  padding: 18rpx 6rpx;
  background: var(--wms-background);
  text-align: center;
  font-size: 18rpx;
}
.base-options .active {
  background: var(--wms-primary-700);
  color: #fff;
}
.drawer-title > view b,
.drawer-title > view small { display: block; }
.drawer-title > view small {
  margin-top: 5rpx;
  color: var(--wms-text-secondary);
  font-size: 18rpx;
}
.zone-drawer { min-height: 52vh; }
.zone-scroll { max-height: 66vh; }
.zone-options {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 10rpx;
  margin-top: 20rpx;
}
.zone-options > view {
  padding: 14rpx 6rpx;
  border: 1rpx solid var(--wms-border);
  background: #fff;
  text-align: center;
}
.zone-options b,.zone-options text { display: block; }
.zone-options b { font-size: 22rpx; }
.zone-options text { margin-top: 4rpx; color: var(--wms-text-secondary); font-size: 18rpx; }
.zone-options > .active { border-color: var(--wms-primary-700); background: var(--wms-surface-soft); color: var(--wms-primary-700); }
.zone-detail { margin-top: 18rpx; }
.zone-summary { display: flex; align-items: center; justify-content: space-between; margin-bottom: 9rpx; }
.zone-summary text { color: var(--wms-text-secondary); font-size: 19rpx; }
.zone-table-head,.zone-item { display: grid; grid-template-columns: minmax(0,1.3fr) minmax(0,1fr) 64rpx; gap: 8rpx; align-items: center; }
.zone-table-head { padding: 10rpx 12rpx; background: var(--wms-primary-700); color: #fff; font-size: 18rpx; }
.zone-item { padding: 12rpx; border-bottom: 1rpx solid var(--wms-border); background: #fff; font-size: 20rpx; }
.zone-item text { overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
.zone-item b { text-align: left; }
.zone-tip { padding: 34rpx 0 12rpx; color: var(--wms-text-secondary); font-size: 19rpx; text-align: center; }
</style>
