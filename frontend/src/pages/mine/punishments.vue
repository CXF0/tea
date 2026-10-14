<script setup lang="ts">
import { computed, ref } from "vue";
import { onLoad, onPullDownRefresh } from "@dcloudio/uni-app";
import { request } from "@/shared/api/client";
import WareState from "@/shared/components/WareState.vue";

interface Punishment {
  id: number;
  type_name: string;
  punish_source: number;
  order_sn: string;
  date: string;
  zone: string;
  zone_shelf: string;
  sub_shelf_sn: string;
  punish_reason: string;
  punish_remark: string;
  punish_price: number;
  punish_status: number;
  appeal_status: number;
  appeal_count: number;
  reject_reason: string;
  appeal_content: string;
  create_time: string;
}

const tabs = [
  ["全部", ""],
  ["待确认", "0"],
  ["已确认", "1"],
  ["已撤销", "2"],
] as const;

const status = ref("");
const list = ref<Punishment[]>([]);
const loading = ref(true);
const error = ref("");
const active = ref<Punishment | null>(null);

const amount = computed(() =>
  list.value
    .filter((item) => item.punish_status === 1)
    .reduce((sum, item) => sum + Number(item.punish_price || 0), 0),
);

function statusName(value: number) {
  return ({ 0: "待确认", 1: "已确认", 2: "已撤销" } as Record<number, string>)[value] || "未知";
}

async function load() {
  loading.value = true;
  try {
    list.value = await request<Punishment[]>({ url: `/mine/punishments?status=${status.value}`, method: "GET" });
    error.value = "";
  } catch (e) {
    error.value = e instanceof Error ? e.message : "处罚记录加载失败";
  } finally {
    loading.value = false;
    uni.stopPullDownRefresh();
  }
}

function switchTab(value: string) {
  status.value = value;
  load();
}

onLoad(load);
onPullDownRefresh(load);
</script>

<template>
  <view class="page">
    <view class="summary">
      <view>
        <text>处罚记录</text>
        <b>{{ list.length }}<small>条</small></b>
      </view>
      <view>
        <text>已确认金额</text>
        <b>¥{{ amount.toFixed(2) }}</b>
      </view>
    </view>
    <view class="tabs">
      <text v-for="tab in tabs" :key="tab[1]" :class="{ active: status === tab[1] }" @click="switchTab(tab[1])">
        {{ tab[0] }}
      </text>
    </view>
    <WareState v-if="loading" type="loading" title="正在加载处罚记录" />
    <WareState
      v-else-if="error"
      type="error"
      title="处罚记录加载失败"
      :description="error"
      action-label="重新加载"
      @action="load"
    />
    <WareState v-else-if="!list.length" type="empty" title="暂无处罚记录" />
    <view v-else>
      <view v-for="item in list" :key="item.id" class="card" @click="active = item">
        <view class="card-head">
          <view>
            <b>{{ item.type_name }}</b>
            <text :class="`s${item.punish_status}`">{{ statusName(item.punish_status) }}</text>
          </view>
          <strong>¥{{ Number(item.punish_price || 0).toFixed(2) }}</strong>
        </view>
        <text class="reason">{{ item.punish_reason || "暂无处罚原因" }}</text>
        <view class="meta">
          <text>{{ item.date }}</text>
          <text>{{ item.zone_shelf || item.sub_shelf_sn || "无货位信息" }}</text>
          <text>{{ item.order_sn || "--" }}</text>
        </view>
      </view>
    </view>
    <view v-if="active" class="mask" @click="active = null">
      <view class="drawer" @click.stop>
        <view class="handle" />
        <view class="drawer-head">
          <view>
            <b>{{ active.type_name }}</b>
            <text>{{ statusName(active.punish_status) }}</text>
          </view>
          <strong>¥{{ Number(active.punish_price || 0).toFixed(2) }}</strong>
        </view>
        <view class="detail">
          <text>处罚日期</text><b>{{ active.date }}</b>
          <text>关联单号</text><b>{{ active.order_sn || "--" }}</b>
          <text>责任货位</text><b>{{ active.zone_shelf || active.sub_shelf_sn || "--" }}</b>
          <text>处罚原因</text><b>{{ active.punish_reason || "--" }}</b>
          <text>处罚备注</text><b>{{ active.punish_remark || "无" }}</b>
          <text>记录时间</text><b>{{ active.create_time }}</b>
          <text>处罚来源</text><b>{{ active.punish_source === 1 ? "系统处罚" : "人工处罚" }}</b>
          <text v-if="active.appeal_content">申诉内容</text><b v-if="active.appeal_content">{{ active.appeal_content }}</b>
        </view>
        <button @click="active = null">关闭</button>
      </view>
    </view>
  </view>
</template>

<style scoped>
.page {
  min-height: 100vh;
  padding: 22rpx;
  background: var(--wms-surface-page);
}
.summary {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 12rpx;
}
.summary > view {
  padding: 22rpx;
  border-radius: 14rpx;
  background: #fff;
}
.summary text,
.summary b {
  display: block;
}
.summary text {
  color: var(--wms-text-secondary);
  font-size: 20rpx;
}
.summary b {
  margin-top: 8rpx;
  font-size: 34rpx;
}
.summary small {
  display: inline;
  margin-left: 4rpx;
  font-size: 18rpx;
}
.tabs {
  display: flex;
  justify-content: space-around;
  margin: 18rpx -22rpx;
  border-bottom: 1rpx solid var(--wms-border);
  background: #fff;
}
.tabs text {
  padding: 16rpx 6rpx;
  font-size: 20rpx;
}
.tabs .active {
  border-bottom: 4rpx solid var(--wms-primary-700);
  color: var(--wms-primary-700);
  font-weight: 700;
}
.card {
  margin-bottom: 12rpx;
  padding: 20rpx;
  border-radius: 14rpx;
  background: #fff;
}
.card-head,
.card-head > view,
.meta,
.drawer-head {
  display: flex;
  align-items: center;
}
.card-head,
.meta,
.drawer-head {
  justify-content: space-between;
}
.card-head > view {
  gap: 10rpx;
}
.card-head b {
  font-size: 23rpx;
}
.card-head text {
  padding: 3rpx 8rpx;
  border-radius: 5rpx;
  background: #fff3d9;
  color: var(--wms-warning);
  font-size: 17rpx;
}
.card-head .s1 {
  background: var(--wms-surface-soft);
  color: var(--wms-success);
}
.card-head .s2 {
  background: #f0f2f2;
  color: var(--wms-text-secondary);
}
.card-head strong {
  color: var(--wms-danger);
  font-size: 27rpx;
}
.reason {
  display: block;
  margin-top: 14rpx;
  font-size: 21rpx;
}
.meta {
  margin-top: 14rpx;
  color: var(--wms-text-secondary);
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
  box-sizing: border-box;
  position: relative;
  min-height: 58vh;
  width: 100%;
  padding: 14rpx 24rpx calc(124rpx + env(safe-area-inset-bottom));
  border-radius: 24rpx 24rpx 0 0;
  background: #fff;
}
.handle {
  width: 68rpx;
  height: 7rpx;
  margin: 0 auto 22rpx;
  border-radius: 7rpx;
  background: var(--wms-border);
}
.drawer-head b,
.drawer-head text {
  display: block;
}
.drawer-head b {
  font-size: 27rpx;
}
.drawer-head text {
  margin-top: 4rpx;
  color: var(--wms-text-secondary);
  font-size: 19rpx;
}
.drawer-head strong {
  color: var(--wms-danger);
  font-size: 34rpx;
}
.detail {
  display: grid;
  grid-template-columns: 145rpx 1fr;
  gap: 16rpx;
  margin-top: 28rpx;
  font-size: 20rpx;
}
.detail text {
  color: var(--wms-text-secondary);
}
.detail b {
  text-align: right;
}
.drawer button {
  position: absolute;
  right: 24rpx;
  bottom: 24rpx;
  left: 24rpx;
  width: calc(100% - 48rpx);
  margin: 0;
  border-radius: 8rpx;
  background: var(--wms-primary-700);
  color: #fff;
  font-size: 22rpx;
}
</style>
