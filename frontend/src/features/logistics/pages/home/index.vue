<script setup lang="ts">
import { computed, ref } from "vue";
import { onLoad, onPullDownRefresh, onShow } from "@dcloudio/uni-app";
import { logisticsApi } from "../../api/logistics.api";
import type { LogisticsShelf } from "../../models/logistics";
import SessionTrigger from "@/shared/components/SessionTrigger.vue";
import SessionDatePicker from "@/shared/components/SessionDatePicker.vue";
import WareState from "@/shared/components/WareState.vue";
import { scanner } from "@/platform/scanner";
const times = [
  { label: "全部交货时间", start: "", end: "" },
  { label: "23点半以前", start: "00:00", end: "23:30" },
  { label: "23:30-00:00", start: "23:30", end: "00:00" },
  { label: "00:00-00:30", start: "00:00", end: "00:30" },
  { label: "00:30-01:00", start: "00:30", end: "01:00" },
  { label: "01:00-01:30", start: "01:00", end: "01:30" },
  { label: "01:30-02:00", start: "01:30", end: "02:00" },
  { label: "2点以后", start: "02:00", end: "23:59" },
];
const date = ref(new Date().toISOString().slice(0, 10)),
  pageTab = ref(0),
  status = ref(-1),
  keyword = ref(""),
  rows = ref<LogisticsShelf[]>([]),
  zones = ref<string[]>([]),
  selectedZones = ref<string[]>([]),
  selectedExpress = ref<string[]>([]),
  timeIndex = ref(0),
  loading = ref(false),
  error = ref(""),
  pickerVisible = ref(false),
  zoneVisible = ref(false),
  expressVisible = ref(false),
  timeVisible = ref(false),
  expressSearch = ref(""),
  expandedExpress = ref("");
const expressOptions = computed(() => [
  ...new Set(
    rows.value.flatMap((r) => r.expressName.split("、")).filter(Boolean),
  ),
]);
const filteredExpress = computed(() =>
  expressOptions.value.filter((x) => x.includes(expressSearch.value)),
);
const displayed = computed(() =>
  rows.value.filter(
    (r) =>
      (!selectedZones.value.length || selectedZones.value.includes(r.zone)) &&
      (!selectedExpress.value.length ||
        r.expressName
          .split("、")
          .some((x) => selectedExpress.value.includes(x))) &&
      inTime(r.deliveryTime),
  ),
);
const statistics = computed(() =>
  expressOptions.value
    .map((name) => {
      const list = displayed.value.filter((r) =>
        r.expressName.split("、").includes(name),
      );
      return {
        name,
        total: list.reduce((s, r) => s + r.totalNum, 0),
        packed: list.reduce((s, r) => s + r.packedNum, 0),
        shipped: list.reduce((s, r) => s + r.shippedNum, 0),
        shelves: list,
      };
    })
    .filter((row) => row.shelves.length),
);
function inTime(v: string) {
  const t = times[timeIndex.value];
  if (!t.start) return true;
  if (t.end === "00:00" || t.start > t.end) return v >= t.start || v < t.end;
  return v >= t.start && v < t.end;
}
function shelfStateText(row: LogisticsShelf) {
  const allPacked = row.packedNum >= row.totalNum;
  const allShipped = row.shippedNum >= row.totalNum;
  if (allShipped) return "全部打包，全部完成发货";
  if (allPacked) return "全部打包，存在未发货";
  if (row.shippedNum > 0) return "存在未打包，存在已发货";
  return "存在未打包，不存在已发货";
}
async function load() {
  loading.value = true;
  error.value = "";
  try {
    [rows.value, zones.value] = await Promise.all([
      logisticsApi.shelves({
        date: date.value,
        status: status.value,
        keyword: keyword.value,
        zone: "",
      }),
      logisticsApi.zones(date.value),
    ]);
  } catch (e) {
    error.value = e instanceof Error ? e.message : "加载失败";
  } finally {
    loading.value = false;
    uni.stopPullDownRefresh();
  }
}
function toggle(list: string[], v: string) {
  const i = list.indexOf(v);
  i >= 0 ? list.splice(i, 1) : list.push(v);
}
function open(r: LogisticsShelf) {
  uni.navigateTo({
    url: `/features/logistics/pages/shelf-detail/index?date=${date.value}&shelfSn=${r.shelfSn}`,
  });
}
async function scan() {
  try { const result = await scanner.scan(); keyword.value = result.value; load(); }
  catch (e) { if (e instanceof Error && !/cancel/i.test(e.message)) uni.showToast({title:e.message,icon:'none'}); }
}
function openRecords() {
  uni.navigateTo({
    url: `/features/logistics/pages/outbound-records/index?date=${date.value}`,
  });
}
onLoad((q) => {
  if (q?.date) date.value = String(q.date);
  load();
});
onShow(load);
onPullDownRefresh(load);
</script>
<template>
  <view class="page"
    ><view class="top"
      ><SessionTrigger :value="date" @click="pickerVisible = true" /><text
        >物流发货</text
      ></view
    ><view class="nav"
      ><view class="page-tabs"
        ><text :class="{ active: pageTab === 0 }" @click="pageTab = 0"
          >货架列表</text
        ><text :class="{ active: pageTab === 1 }" @click="pageTab = 1"
          >物流统计</text
        ></view
      ><view
        ><text class="record" @click="openRecords">出库记录</text></view
      ></view
    ><view class="search"
      ><text>⌕</text
      ><input
        v-model="keyword"
        placeholder="货架号搜索"
        confirm-type="search"
        @confirm="load" /></view
    ><view class="filters"
      ><text
        :class="{ selected: selectedExpress.length }"
        @click="expressVisible = true"
        >{{
          selectedExpress.length
            ? `物流 ${selectedExpress.length}项`
            : "负责物流范围"
        }}</text
      ><text :class="{ selected: timeIndex > 0 }" @click="timeVisible = true">{{
        times[timeIndex].label
      }}</text
      ><text
        :class="{ selected: selectedZones.length }"
        @click="zoneVisible = true"
        >{{
          selectedZones.length ? `分区 ${selectedZones.length}项` : "查看分区"
        }}</text
      ></view
    ><WareState
      v-if="loading"
      type="loading"
      title="正在加载发货任务"
    /><WareState
      v-else-if="error"
      type="error"
      title="加载失败"
      :description="error"
      action-label="重新加载"
      @action="load"
    /><template v-else-if="pageTab === 0"
      ><view v-if="displayed.length" class="shelf-grid"
        ><view
          v-for="row in displayed"
          :key="row.shelfSn"
          :class="[
            'shelf',
            {
              done: row.shippedNum === row.totalNum,
              partial: row.shippedNum > 0 && row.shippedNum < row.totalNum,
            },
          ]"
          @click="open(row)"
          ><view class="shelf-head"
            ><strong>{{ row.shelfNo }}</strong
            ><view class="badges"
              ><i v-if="row.selfPickup" class="pickup">自提</i
              ><i v-else-if="row.shippedNum === row.totalNum" class="shipped"
                >已发货</i
              ><i v-else class="pending">待发货</i
              ><i v-if="row.earlyShift" class="early">早班</i></view
            ></view
          ><b>{{ row.shippedNum }} / {{ row.totalNum }} 包</b
          ><small
            >{{ row.deliveryTime || "未设时间" }} · {{ row.itemNum }} 扎</small
          ><view class="state-description">{{
            shelfStateText(row)
          }}</view></view
        ></view
      ><WareState v-else type="empty" title="暂无发货货架" /></template
    ><template v-else
      ><view v-if="statistics.length" class="stats"
        ><view class="thead"
          ><text>物流名称</text><text>已打包/总件数</text><text>已出库</text
          ><text></text></view
        ><view v-for="row in statistics" :key="row.name" class="stat-group"
          ><view
            class="tr"
            @click="
              expandedExpress = expandedExpress === row.name ? '' : row.name
            "
            ><text>{{ row.name }}</text
            ><text>{{ row.packed }}/{{ row.total }}</text
            ><text>{{ row.shipped }}</text
            ><text class="expand">{{
              expandedExpress === row.name ? "⌃" : "⌄"
            }}</text></view
          ><view v-if="expandedExpress === row.name" class="stat-shelves"
            ><view
              v-for="shelf in row.shelves"
              :key="shelf.shelfSn"
              class="stat-shelf"
              @click="open(shelf)"
              ><view class="stat-shelf-head"
                ><strong>{{ shelf.shelfNo }}</strong
                ><view class="inline-badges"
                  ><i v-if="shelf.selfPickup" class="pickup">自提</i
                  ><i
                    v-else-if="shelf.shippedNum === shelf.totalNum"
                    class="shipped"
                    >已发货</i
                  ><i v-else class="pending">待发货</i></view
                ></view
              ><text>{{ shelf.shippedNum }}/{{ shelf.totalNum }} 包</text
              ><small
                >{{ shelf.deliveryTime || "未设时间" }} ·
                {{ shelf.itemNum }} 扎</small
              ></view
            ></view
          ></view
        ></view
      ><WareState v-else type="empty" title="暂无物流统计" /></template
    ><view class="footer"><button @click="scan">▣ 扫码发货</button></view
    ><SessionDatePicker
      v-model="date"
      v-model:visible="pickerVisible"
      title="选择场次"
      @confirm="load"
    /><view v-if="expressVisible" class="mask" @click="expressVisible = false"
      ><view class="drawer" @click.stop
        ><view class="drawer-head"
          ><strong>我负责的物流范围</strong
          ><text @click="expressVisible = false">确认</text></view
        ><input
          v-model="expressSearch"
          class="drawer-search"
          placeholder="物流搜索"
        /><view class="options two"
          ><view
            v-for="x in filteredExpress"
            :key="x"
            :class="{ active: selectedExpress.includes(x) }"
            @click="toggle(selectedExpress, x)"
            >{{ x }}</view
          ></view
        ></view
      ></view
    ><view v-if="timeVisible" class="mask" @click="timeVisible = false"
      ><view class="drawer" @click.stop
        ><strong>选择时间段</strong
        ><view class="options"
          ><view
            v-for="(x, i) in times"
            :key="x.label"
            :class="{ active: timeIndex === i }"
            @click="
              timeIndex = i;
              timeVisible = false;
            "
            >{{ x.label }}</view
          ></view
        ></view
      ></view
    ><view v-if="zoneVisible" class="mask" @click="zoneVisible = false"
      ><view class="drawer" @click.stop
        ><strong>选择分区</strong
        ><view class="options"
          ><view
            v-for="x in zones"
            :key="x"
            :class="{ active: selectedZones.includes(x) }"
            @click="toggle(selectedZones, x)"
            >{{ x }}区</view
          ></view
        ><button class="confirm" @click="zoneVisible = false">
          确认
        </button></view
      ></view
    ></view
  >
</template>
<style scoped lang="scss">
.page {
  min-height: 100vh;
  padding: 24rpx 24rpx 130rpx;
}
.top,
.nav,
.page-tabs,
.search,
.filters,
.drawer-head {
  display: flex;
  align-items: center;
}
.top,
.nav,
.drawer-head {
  justify-content: space-between;
}
.top > text {
  padding: 7rpx 13rpx;
  border-radius: 999rpx;
  background: var(--wms-surface-soft);
  color: var(--wms-primary-700);
  font-size: 19rpx;
  font-weight: 700;
}
.nav {
  height: 82rpx;
  border-bottom: 1rpx solid var(--wms-border);
}
.page-tabs {
  gap: 28rpx;
  height: 100%;
}
.page-tabs text {
  display: flex;
  height: 100%;
  align-items: center;
  color: var(--wms-text-secondary);
  font-size: 21rpx;
}
.page-tabs .active {
  border-bottom: 5rpx solid var(--wms-primary-700);
  color: var(--wms-primary-700);
  font-weight: 700;
}
.record {
  color: #b88316;
  font-size: 19rpx;
}
.search {
  height: 66rpx;
  margin-top: 10rpx;
  padding-left: 16rpx;
  border-radius: 999rpx;
  background: #fff;
}
.search > text {
  color: var(--wms-text-secondary);
  font-size: 26rpx;
}
.search input {
  min-width: 0;
  flex: 1;
  padding-left: 8rpx;
  font-size: 20rpx;
}
.filters {
  display: grid;
  grid-template-columns: 1.08fr 1.2fr 0.92fr;
  gap: 10rpx;
  margin: 14rpx 0 18rpx;
}
.filters text {
  display: flex;
  min-width: 0;
  height: 62rpx;
  align-items: center;
  justify-content: center;
  padding: 0 12rpx;
  overflow: hidden;
  border: 1rpx solid var(--wms-border);
  border-radius: 12rpx;
  background: #fff;
  color: var(--wms-text-secondary);
  font-size: 17rpx;
  text-overflow: ellipsis;
  white-space: nowrap;
}
.filters text::after {
  width: 0;
  height: 0;
  margin-left: 8rpx;
  border-top: 7rpx solid var(--wms-text-secondary);
  border-right: 6rpx solid transparent;
  border-left: 6rpx solid transparent;
  content: "";
  flex: 0 0 auto;
}
.filters text.selected {
  border-color: var(--wms-primary-700);
  background: var(--wms-surface-soft);
  color: var(--wms-primary-700);
  font-weight: 700;
}
.filters text.selected::after {
  border-top-color: var(--wms-primary-700);
}
.shelf-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 14rpx;
}
.shelf {
  min-height: 142rpx;
  padding: 18rpx 20rpx;
  border-radius: 18rpx;
  background: #fff;
  color: var(--wms-text-primary);
  box-shadow: var(--wms-shadow-card);
}
.shelf strong {
  font-size: 25rpx;
  white-space: nowrap;
}
.shelf-head {
  display: flex;
  min-height: 34rpx;
  align-items: flex-start;
  justify-content: space-between;
  gap: 8rpx;
}
.badges {
  display: flex;
  align-items: flex-end;
  gap: 4rpx;
  flex-direction: column;
}
.badges i {
  padding: 3rpx 7rpx;
  border-radius: 5rpx;
  font-size: 13rpx;
  font-style: normal;
  line-height: 1.2;
  white-space: nowrap;
}
.badges .early {
  background: var(--wms-surface-soft);
  color: var(--wms-primary-700);
}
.badges .pending {
  background: #e8f1ff;
  color: #2263aa;
}
.badges .shipped {
  background: #e2f4e8;
  color: #27864c;
}
.badges .pickup {
  background: #fff0da;
  color: #a35e00;
}
.shelf > b {
  display: block;
  margin-top: 7rpx;
  font-size: 19rpx;
}
.shelf > small {
  display: block;
  margin-top: 5rpx;
  color: var(--wms-text-secondary);
  font-size: 15rpx;
}
.state-description {
  margin-top: 12rpx;
  padding-top: 10rpx;
  border-top: 1rpx dashed var(--wms-border);
  color: var(--wms-text-secondary);
  font-size: 15rpx;
  line-height: 1.35;
}
.shelf.done {
  color: var(--wms-text-primary);
}
.shelf.partial {
  color: var(--wms-text-primary);
}
.stats .thead,
.stats .tr {
  display: grid;
  grid-template-columns: 2fr 1.4fr 1fr 36rpx;
  align-items: center;
  padding: 0 18rpx;
}
.stats .thead {
  height: 58rpx;
  background: var(--wms-primary-700);
  color: #fff;
  font-size: 19rpx;
  font-weight: 700;
}
.stats .tr {
  min-height: 66rpx;
  margin-top: 5rpx;
  background: #fff;
  font-size: 19rpx;
}
.stats .tr .expand {
  color: var(--wms-primary-700);
  font-size: 25rpx;
  text-align: right;
}
.stat-shelves {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 12rpx;
  padding: 12rpx 0 18rpx;
}
.stat-shelf {
  min-width: 0;
  padding: 16rpx 18rpx;
  border-radius: 14rpx;
  background: #fff;
  box-shadow: var(--wms-shadow-card);
}
.stat-shelf-head {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 6rpx;
}
.stat-shelf-head strong {
  overflow: hidden;
  font-size: 22rpx;
  text-overflow: ellipsis;
  white-space: nowrap;
}
.inline-badges i {
  padding: 3rpx 7rpx;
  border-radius: 5rpx;
  font-size: 13rpx;
  font-style: normal;
  white-space: nowrap;
}
.inline-badges .pending {
  background: #e8f1ff;
  color: #2263aa;
}
.inline-badges .shipped {
  background: #e2f4e8;
  color: #27864c;
}
.inline-badges .pickup {
  background: #fff0da;
  color: #a35e00;
}
.stat-shelf > text,
.stat-shelf > small {
  display: block;
  margin-top: 8rpx;
}
.stat-shelf > text {
  font-size: 18rpx;
  font-weight: 700;
}
.stat-shelf > small {
  color: var(--wms-text-secondary);
  font-size: 15rpx;
}
.footer {
  position: fixed;
  right: 0;
  bottom: 0;
  left: 0;
  padding: 14rpx 40rpx calc(16rpx + env(safe-area-inset-bottom));
  background: #fff;
}
.footer button,
.confirm {
  height: 72rpx;
  border: 0;
  border-radius: 10rpx;
  background: var(--wms-primary-700);
  color: #fff;
  font-size: 22rpx;
  line-height: 72rpx;
}
.mask,
.center-mask {
  position: fixed;
  z-index: 80;
  inset: 0;
  background: rgba(22, 42, 40, 0.5);
}
.mask {
  display: flex;
  align-items: flex-end;
}
.drawer {
  box-sizing: border-box;
  width: 100%;
  max-height: 78vh;
  padding: 26rpx 22rpx calc(25rpx + env(safe-area-inset-bottom));
  overflow: auto;
  border-radius: 26rpx 26rpx 0 0;
  background: #fff;
}
.drawer-head text {
  color: var(--wms-primary-700);
}
.drawer-search {
  box-sizing: border-box;
  width: 100%;
  height: 66rpx;
  margin-top: 20rpx;
  padding: 0 14rpx;
  border: 1rpx solid var(--wms-border);
  border-radius: 8rpx;
}
.options {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 12rpx;
  margin-top: 22rpx;
}
.options.two {
  grid-template-columns: repeat(2, 1fr);
}
.options view {
  display: flex;
  min-height: 70rpx;
  align-items: center;
  justify-content: center;
  padding: 4rpx 10rpx;
  background: var(--wms-background);
  font-size: 19rpx;
  text-align: center;
}
.options .active {
  background: var(--wms-surface-soft);
  color: var(--wms-primary-700);
}
.confirm {
  width: 100%;
  margin-top: 20rpx;
}
.center-mask {
  display: flex;
  align-items: center;
  justify-content: center;
}
.guide-card {
  display: flex;
  width: 580rpx;
  padding: 28rpx;
  border-radius: 20rpx;
  background: #fff;
  flex-direction: column;
  gap: 18rpx;
}
.guide-card > text {
  display: flex;
  align-items: center;
  font-size: 19rpx;
}
.guide-card i {
  width: 28rpx;
  height: 28rpx;
  margin-right: 12rpx;
}
.guide-card .green {
  background: #ddefdc;
}
.guide-card .blue {
  background: #dbe9fa;
}
.guide-card .yellow {
  background: #fff1cf;
}
.guide-card .gray {
  background: #e8ecec;
}
.guide-card button {
  height: 66rpx;
  background: var(--wms-primary-700);
  color: #fff;
  line-height: 66rpx;
}
</style>
