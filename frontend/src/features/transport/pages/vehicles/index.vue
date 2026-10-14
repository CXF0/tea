<script setup lang="ts">
import { computed, reactive, ref } from "vue";
import { onLoad, onPullDownRefresh } from "@dcloudio/uni-app";
import WareState from "@/shared/components/WareState.vue";
import { sessionStore } from "@/store/session";
import { transportApi } from "../../api/transport.api";
import type {
  Vehicle,
  VehicleDraft,
  VehiclePage,
  VehicleType,
} from "../../models/vehicle";
const loading = ref(true),
  error = ref(""),
  keyword = ref(""),
  typeId = ref(0),
  status = ref(0),
  onlineStatus = ref<number | string>(""),
  page = ref(1),
  data = ref<VehiclePage>({
    current: 1,
    size: 10,
    total: 0,
    summary: { available: 0, tasking: 0, maintenance: 0, online: 0 },
    records: [],
  }),
  types = ref<VehicleType[]>([]),
  editor = ref(false),
  detail = ref<Vehicle | null>(null),
  editingId = ref(0),
  saving = ref(false);
const canManage = computed(() => sessionStore.can("transport.vehicle.manage"));
const draft = reactive<VehicleDraft>({
  vehicleNo: "",
  plateNo: "云A",
  typeId: 0,
  typeName: "",
  loadStandard: 0,
  fuelConsumption: 0,
  ownerUserId: 0,
  ownerName: "",
  defaultStationId: 0,
  source: 1,
  platform: "",
  drivingYears: 0,
  status: 1,
  remark: "",
  trackingDeviceNo: "",
});
async function load(reset = true) {
  loading.value = true;
  error.value = "";
  try {
    if (reset) page.value = 1;
    data.value = await transportApi.vehicles({
      page: page.value,
      size: 10,
      keyword: keyword.value.trim(),
      typeId: typeId.value,
      status: status.value,
      onlineStatus: onlineStatus.value,
    });
    if (!types.value.length) types.value = await transportApi.types();
  } catch (e) {
    error.value = e instanceof Error ? e.message : "车辆加载失败";
  } finally {
    loading.value = false;
    uni.stopPullDownRefresh();
  }
}
function selectType(e: any) {
  const x = types.value[Number(e.detail.value)];
  draft.typeId = x?.id || 0;
  draft.typeName = x?.name || "";
}
function openCreate() {
  editingId.value = 0;
  Object.assign(draft, {
    vehicleNo: "",
    plateNo: "云A",
    typeId: 0,
    typeName: "",
    loadStandard: 0,
    fuelConsumption: 0,
    ownerUserId: 0,
    ownerName: "",
    defaultStationId: 0,
    source: 1,
    platform: "",
    drivingYears: 0,
    status: 1,
    remark: "",
    trackingDeviceNo: "",
  });
  editor.value = true;
}
function openEdit(v: Vehicle) {
  editingId.value = v.id;
  Object.assign(draft, v);
  detail.value = null;
  editor.value = true;
}
async function save() {
  if (saving.value) return;
  saving.value = true;
  try {
    editingId.value
      ? await transportApi.update(editingId.value, draft)
      : await transportApi.create(draft);
    editor.value = false;
    uni.showToast({ title: "车辆已保存", icon: "success" });
    load();
  } catch (e) {
    uni.showToast({
      title: e instanceof Error ? e.message : "保存失败",
      icon: "none",
    });
  } finally {
    saving.value = false;
  }
}
async function changeStatus(v: Vehicle, s: number) {
  const names: Record<number, string> = {
    1: "恢复可用",
    2: "标记维修",
    4: "停用",
  };
  uni.showModal({
    title: names[s],
    content: `确认将 ${v.vehicleNo}（${v.plateNo}）${names[s]}吗？`,
    success: async (r) => {
      if (!r.confirm) return;
      await transportApi.status(v.id, s);
      detail.value = await transportApi.detail(v.id);
      load();
    },
  });
}
function prev() {
  if (page.value > 1) {
    page.value--;
    load(false);
  }
}
function next() {
  if (page.value * data.value.size < data.value.total) {
    page.value++;
    load(false);
  }
}
onLoad(() => load());
onPullDownRefresh(() => load());
</script>
<template>
  <view class="page"
    ><view class="summary"
      ><view
        ><b>{{ data.total }}</b
        ><text>车辆总数</text></view
      ><view
        ><b>{{ data.summary.available }}</b
        ><text>可用</text></view
      ><view
        ><b>{{ data.summary.online }}</b
        ><text>设备在线</text></view
      ><view
        ><b>{{ data.summary.maintenance }}</b
        ><text>维修中</text></view
      ></view
    ><view class="toolbar"
      ><view class="search"
        ><input
          v-model="keyword"
          placeholder="车辆编号 / 车牌 / 责任人"
          confirm-type="search"
          @confirm="load()"
        /><text @click="load()">查询</text></view
      ><button v-if="canManage" @click="openCreate">新增车辆</button></view
    ><scroll-view scroll-x class="filters"
      ><view class="filter-row"
        ><view
          :class="{ active: !typeId }"
          @click="
            typeId = 0;
            load();
          "
          >全部车型</view
        ><view
          v-for="t in types"
          :key="t.id"
          :class="{ active: typeId === t.id }"
          @click="
            typeId = t.id;
            load();
          "
          >{{ t.name }}</view
        ><view
          :class="{ active: onlineStatus === 1 }"
          @click="
            onlineStatus = onlineStatus === 1 ? '' : 1;
            load();
          "
          >设备在线</view
        ><view
          :class="{ active: status === 2 }"
          @click="
            status = status === 2 ? 0 : 2;
            load();
          "
          >维修中</view
        ></view
      ></scroll-view
    ><WareState v-if="loading" type="loading" title="正在加载车辆" /><WareState
      v-else-if="error"
      type="error"
      title="加载失败"
      :description="error"
      action-label="重试"
      @action="load()"
    /><view v-else-if="data.records.length" class="list"
      ><view
        v-for="v in data.records"
        :key="v.id"
        class="card"
        @click="detail = v"
        ><view class="head"
          ><view
            ><b>{{ v.vehicleNo }}</b
            ><strong>{{ v.plateNo }}</strong></view
          ><view class="badges"
            ><span :class="{ off: !v.onlineStatus }">{{
              v.onlineStatusStr
            }}</span
            ><span :class="['state', `s${v.status}`]">{{
              v.statusStr
            }}</span></view
          ></view
        ><view class="meta"
          ><span>{{ v.typeName }}</span
          ><span>责任人：{{ v.ownerName || "未配置" }}</span
          ><span>{{
            v.loadStandard ? `载荷 ${v.loadStandard} 框` : "载荷未配置"
          }}</span></view
        ><view class="device"
          ><text>设备 {{ v.trackingDeviceNo || "未绑定" }}</text
          ><text>{{ v.accStatus ? "ACC 开启" : "ACC 关闭" }}</text
          ><text>›</text></view
        ></view
      ><view class="pager"
        ><button :disabled="page === 1" @click="prev">上一页</button
        ><text
          >{{ page }} /
          {{ Math.max(1, Math.ceil(data.total / data.size)) }}</text
        ><button :disabled="page * data.size >= data.total" @click="next">
          下一页
        </button></view
      ></view
    ><WareState
      v-else
      type="empty"
      title="暂无车辆"
      description="当前筛选条件下没有车辆档案"
    />
    <view v-if="detail" class="mask" @click="detail = null"
      ><view class="drawer" @click.stop
        ><view class="handle" /><view class="drawer-head"
          ><view
            ><b>{{ detail.vehicleNo }} · {{ detail.plateNo }}</b
            ><small>{{ detail.typeName }}　{{ detail.statusStr }}</small></view
          ><text @click="detail = null">关闭</text></view
        ><view class="detail-grid"
          ><view
            ><small>责任人</small
            ><b>{{ detail.ownerName || "未配置" }}</b></view
          ><view
            ><small>标准载荷</small
            ><b>{{ detail.loadStandard || 0 }} 框</b></view
          ><view
            ><small>百公里油耗</small
            ><b>{{ detail.fuelConsumption || 0 }} L</b></view
          ><view
            ><small>行驶年限</small
            ><b>{{ detail.drivingYears || 0 }} 年</b></view
          ><view
            ><small>定位设备</small
            ><b>{{ detail.trackingDeviceNo || "未绑定" }}</b></view
          ><view
            ><small>设备状态</small
            ><b
              >{{ detail.onlineStatusStr }} /
              {{ detail.accStatus ? "ACC开" : "ACC关" }}</b
            ></view
          ></view
        ><text class="time"
          >ACC更新时间：{{ detail.accStatusUpdateTime || "暂无"
          }}<br />最近启动：{{ detail.lastAccOnTime || "暂无" }}</text
        ><view v-if="canManage" class="actions"
          ><button @click="openEdit(detail)">编辑</button
          ><button v-if="detail.status !== 2" @click="changeStatus(detail, 2)">
            维修</button
          ><button
            v-if="detail.status !== 4"
            class="danger"
            @click="changeStatus(detail, 4)"
          >
            停用</button
          ><button
            v-if="detail.status !== 1"
            class="primary"
            @click="changeStatus(detail, 1)"
          >
            恢复可用
          </button></view
        ></view
      ></view
    >
    <view v-if="editor" class="mask" @click="editor = false"
      ><view class="drawer form" @click.stop
        ><view class="handle" /><view class="drawer-head"
          ><b>{{ editingId ? "编辑车辆" : "新增车辆" }}</b
          ><text @click="editor = false">关闭</text></view
        ><scroll-view scroll-y class="form-scroll"
          ><label
            >车辆编号<input
              v-model="draft.vehicleNo"
              placeholder="如 48号车" /></label
          ><label
            >车牌号<input
              v-model="draft.plateNo"
              placeholder="如 云AG9449" /></label
          ><label
            >车型<picker :range="types" range-key="name" @change="selectType"
              ><view class="picker"
                >{{ draft.typeName || "请选择车型"
                }}<i /></view></picker></label
          ><view class="two"
            ><label
              >标准载荷（框）<input
                v-model.number="draft.loadStandard"
                type="number" /></label
            ><label
              >百公里油耗（L）<input
                v-model.number="draft.fuelConsumption"
                type="digit" /></label></view
          ><label
            >责任人姓名<input
              v-model="draft.ownerName"
              placeholder="请输入责任人" /></label
          ><label
            >定位设备号<input
              v-model="draft.trackingDeviceNo"
              placeholder="未安装可不填" /></label
          ><label
            >备注<input
              v-model="draft.remark"
              placeholder="选填" /></label></scroll-view
        ><button class="save" :disabled="saving" @click="save">
          {{ saving ? "保存中…" : "保存车辆" }}
        </button></view
      ></view
    ></view
  >
</template>
<style scoped>
.page {
  box-sizing: border-box;
  min-height: 100vh;
  padding: 18rpx 20rpx;
  background: var(--wms-surface-page);
}
.summary {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  overflow: hidden;
  border-radius: 13rpx;
  background: #fff;
}
.summary view {
  padding: 17rpx 6rpx;
  border-right: 1rpx solid var(--wms-border);
  text-align: center;
}
.summary view:last-child {
  border: 0;
}
.summary b,
.summary text {
  display: block;
}
.summary b {
  font-size: 31rpx;
}
.summary text {
  margin-top: 3rpx;
  color: var(--wms-text-secondary);
  font-size: 17rpx;
}
.toolbar {
  display: grid;
  grid-template-columns: minmax(0, 1fr) 150rpx;
  gap: 10rpx;
  margin-top: 14rpx;
}
.search {
  display: flex;
  height: 66rpx;
  align-items: center;
  padding: 0 15rpx;
  border: 1rpx solid var(--wms-border);
  border-radius: 10rpx;
  background: #fff;
}
.search input {
  min-width: 0;
  flex: 1;
  font-size: 21rpx;
}
.search text {
  color: var(--wms-primary-700);
  font-size: 20rpx;
}
.toolbar button {
  height: 66rpx;
  margin: 0;
  padding: 0;
  border-radius: 10rpx;
  background: var(--wms-primary-700);
  color: #fff;
  font-size: 21rpx;
  line-height: 66rpx;
}
.filters {
  margin: 12rpx 0;
}
.filter-row {
  display: inline-flex;
  gap: 9rpx;
  white-space: nowrap;
}
.filter-row view {
  padding: 10rpx 15rpx;
  border: 1rpx solid var(--wms-border);
  border-radius: 9rpx;
  background: #fff;
  color: var(--wms-text-secondary);
  font-size: 19rpx;
}
.filter-row .active {
  border-color: var(--wms-primary-700);
  background: var(--wms-surface-soft);
  color: var(--wms-primary-700);
  font-weight: 700;
}
.list {
  display: flex;
  flex-direction: column;
  gap: 11rpx;
}
.card {
  padding: 18rpx;
  border: 1rpx solid var(--wms-border);
  border-radius: 13rpx;
  background: #fff;
}
.head,
.head > view,
.badges,
.meta,
.device,
.pager,
.drawer-head,
.actions {
  display: flex;
  align-items: center;
}
.head {
  justify-content: space-between;
}
.head b {
  font-size: 25rpx;
}
.head strong {
  margin-left: 10rpx;
  font-size: 22rpx;
}
.badges {
  gap: 6rpx;
}
.badges span {
  padding: 4rpx 8rpx;
  border-radius: 6rpx;
  background: var(--wms-surface-soft);
  color: var(--wms-success);
  font-size: 17rpx;
}
.badges .off {
  background: #f0f2f2;
  color: var(--wms-text-secondary);
}
.badges .s1 {
  background: #e8f6f3;
  color: #087d72;
}
.badges .s5 {
  background: #eaf2ff;
  color: #2563a8;
}
.badges .s2,
.badges .s4 {
  background: #fff0da;
  color: #9a5d00;
}
.meta {
  gap: 18rpx;
  margin-top: 13rpx;
  color: var(--wms-text-secondary);
  font-size: 19rpx;
}
.device {
  justify-content: space-between;
  margin-top: 14rpx;
  padding-top: 12rpx;
  border-top: 1rpx solid var(--wms-border);
  font-size: 18rpx;
}
.device text:last-child {
  color: var(--wms-primary-700);
  font-size: 27rpx;
}
.pager {
  justify-content: center;
  gap: 24rpx;
}
.pager button {
  margin: 0;
  font-size: 20rpx;
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
  max-height: 92vh;
  padding: 14rpx 24rpx calc(24rpx + env(safe-area-inset-bottom));
  overflow: auto;
  border-radius: 26rpx 26rpx 0 0;
  background: #fff;
}
.handle {
  width: 66rpx;
  height: 7rpx;
  margin: 0 auto 18rpx;
  border-radius: 7rpx;
  background: var(--wms-border);
}
.drawer-head {
  justify-content: space-between;
}
.drawer-head b,
.drawer-head small {
  display: block;
}
.drawer-head b {
  font-size: 28rpx;
}
.drawer-head small {
  margin-top: 5rpx;
  color: var(--wms-text-secondary);
  font-size: 19rpx;
}
.drawer-head > text {
  color: var(--wms-primary-700);
}
.detail-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 10rpx;
  margin-top: 20rpx;
}
.detail-grid view {
  padding: 15rpx;
  border-radius: 10rpx;
  background: var(--wms-surface-page);
}
.detail-grid small,
.detail-grid b {
  display: block;
}
.detail-grid small {
  color: var(--wms-text-secondary);
  font-size: 18rpx;
}
.detail-grid b {
  margin-top: 5rpx;
  font-size: 21rpx;
}
.time {
  display: block;
  margin-top: 15rpx;
  color: var(--wms-text-secondary);
  font-size: 18rpx;
  line-height: 1.6;
}
.actions {
  gap: 9rpx;
  margin-top: 18rpx;
}
.actions button {
  flex: 1;
  margin: 0;
  font-size: 20rpx;
}
.actions .primary {
  background: var(--wms-primary-700);
  color: #fff;
}
.actions .danger {
  color: var(--wms-danger);
}
.form {
  display: flex;
  overflow: hidden;
  flex-direction: column;
}
.form-scroll {
  max-height: 65vh;
}
.form label {
  display: block;
  margin-top: 16rpx;
  font-size: 20rpx;
}
.form input,
.picker {
  box-sizing: border-box;
  width: 100%;
  height: 68rpx;
  margin-top: 7rpx;
  padding: 0 14rpx;
  border: 1rpx solid var(--wms-border);
  border-radius: 9rpx;
  font-size: 21rpx;
}
.picker {
  display: flex;
  align-items: center;
  justify-content: space-between;
}
.two {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 10rpx;
}
.save {
  height: 76rpx;
  margin: 20rpx 0 0;
  background: var(--wms-primary-700);
  color: #fff;
  line-height: 76rpx;
}
</style>
