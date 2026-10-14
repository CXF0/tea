<script setup lang="ts">
import { computed, ref } from "vue";
import { onLoad, onPullDownRefresh } from "@dcloudio/uni-app";
import WareState from "@/shared/components/WareState.vue";
import SessionTrigger from "@/shared/components/SessionTrigger.vue";
import SessionDatePicker from "@/shared/components/SessionDatePicker.vue";
import { baseReturnApi, type ReturnBase, type SupplierReturn } from "../../api/base-return.api";

const date = ref(new Date().toISOString().slice(0, 10));
const bases = ref<ReturnBase[]>([]), rows = ref<SupplierReturn[]>([]);
const baseId = ref(0), keyword = ref(""), loading = ref(true), error = ref("");
const datePicker = ref(false), basePicker = ref(false);
const visible = computed(() => rows.value.filter((row) => !keyword.value.trim() || row.supplierName.includes(keyword.value.trim())));
const activeBase = computed(() => bases.value.find((base) => base.id === baseId.value));
const totals = computed(() => rows.value.reduce((sum, row) => ({ refund: sum.refund + row.refundNum, confirmed: sum.confirmed + row.confirmNum }), { refund: 0, confirmed: 0 }));

async function load() {
  loading.value = true; error.value = "";
  try {
    if (!bases.value.length) bases.value = await baseReturnApi.bases();
    rows.value = await baseReturnApi.suppliers(date.value, baseId.value || undefined);
  } catch (e) { error.value = e instanceof Error ? e.message : "基地退货数据加载失败"; }
  finally { loading.value = false; uni.stopPullDownRefresh(); }
}
async function chooseBase(id: number) { baseId.value = id; basePicker.value = false; await load(); }
async function chooseDate(value: string) { date.value = value; await load(); }
function scan() { uni.navigateTo({ url: "/features/base-return/pages/scan/index" }); }
onLoad((query) => { if (query?.date) date.value = String(query.date); load(); });
onPullDownRefresh(load);
</script>

<template>
  <view class="page">
    <view class="tools">
      <view class="search"><text>⌕</text><input v-model="keyword" placeholder="供应商名称" /></view>
      <button class="scan" @click="scan"><i class="scan-icon" />扫码确认</button>
    </view>
    <view class="filters">
      <button @click="basePicker = true">{{ activeBase?.name || "全部基地" }}<i /></button>
      <SessionTrigger :value="date" @click="datePicker = true" />
    </view>
    <view class="summary"><text>退货 <b>{{ totals.refund }}</b>扎</text><text>已确认 <b>{{ totals.confirmed }}</b>扎</text><text>待确认 <b>{{ Math.max(0, totals.refund - totals.confirmed) }}</b>扎</text></view>
    <view class="table-head"><text>供应商</text><text>退货数</text><text>确认数</text><text>状态</text></view>
    <WareState v-if="loading" type="loading" title="正在加载基地退货" />
    <WareState v-else-if="error" type="error" title="加载失败" :description="error" action-label="重试" @action="load" />
    <WareState v-else-if="!visible.length" type="empty" title="暂无退货确认数据" />
    <view v-else class="table-body">
      <view v-for="row in visible" :key="`${row.baseId}-${row.supplierId}`" class="table-row">
        <view><b>{{ row.supplierName }}</b><small>{{ row.baseName }}</small></view>
        <b>{{ row.refundNum }}</b><b>{{ row.confirmNum }}</b><text :class="row.status">{{ row.statusLabel }}</text>
      </view>
    </view>
    <SessionDatePicker v-model="date" v-model:visible="datePicker" @confirm="chooseDate" />
    <view v-if="basePicker" class="mask" @click="basePicker = false"><view class="drawer" @click.stop>
      <view class="drawer-title"><b>选择基地</b><text @click="basePicker = false">关闭</text></view>
      <view class="base-grid"><view :class="{ active: baseId === 0 }" @click="chooseBase(0)">全部基地</view><view v-for="base in bases" :key="base.id" :class="{ active: baseId === base.id }" @click="chooseBase(base.id)">{{ base.name }}</view></view>
    </view></view>
  </view>
</template>

<style scoped>
.page{min-height:100vh;padding:20rpx;background:var(--wms-background)}
.tools,.filters{display:flex;align-items:center;gap:10rpx}.search{display:flex;align-items:center;gap:7rpx;min-width:0;height:60rpx;flex:1;padding:0 13rpx;border:1rpx solid var(--wms-border);border-radius:8rpx;background:#fff}.search input{min-width:0;flex:1;font-size:20rpx}.scan{display:flex;align-items:center;justify-content:center;gap:8rpx;width:142rpx;height:60rpx;margin:0;padding:0;border:0;border-radius:8rpx;background:var(--wms-primary-700);color:#fff;font-size:19rpx;line-height:60rpx}.scan:after{border:0}.scan-icon{width:25rpx;height:25rpx;background:#fff;mask:url('/static/icons/wms/fwms-scan-outline.svg') center/contain no-repeat;-webkit-mask:url('/static/icons/wms/fwms-scan-outline.svg') center/contain no-repeat}
.filters{justify-content:space-between;margin-top:12rpx}.filters>button{display:flex;align-items:center;gap:10rpx;min-width:190rpx;height:58rpx;margin:0;padding:0 14rpx;border:1rpx solid var(--wms-border);border-radius:8rpx;background:#fff;color:var(--wms-primary-700);font-size:19rpx;line-height:58rpx}.filters>button:after{border:0}.filters i{width:8rpx;height:8rpx;margin-left:auto;border-right:2rpx solid currentColor;border-bottom:2rpx solid currentColor;transform:rotate(45deg)}
.summary{display:grid;grid-template-columns:repeat(3,1fr);gap:8rpx;margin:14rpx 0}.summary text{padding:13rpx 5rpx;background:#fff;color:var(--wms-text-secondary);font-size:17rpx;text-align:center}.summary b{color:var(--wms-primary-700);font-size:25rpx}
.table-head,.table-row{display:grid;grid-template-columns:minmax(0,1.5fr) 66rpx 66rpx 80rpx;gap:7rpx;align-items:center}.table-head{padding:12rpx;background:var(--wms-primary-700);color:#fff;font-size:18rpx}.table-row{min-height:66rpx;margin-top:6rpx;padding:10rpx 12rpx;background:#fff;font-size:20rpx}.table-row>view b,.table-row small{display:block}.table-row small{margin-top:3rpx;color:var(--wms-text-secondary);font-size:16rpx}.table-row>text{font-size:18rpx;font-weight:700}.pending{color:var(--wms-danger)}.partial{color:var(--wms-warning)}.confirmed{color:var(--wms-success)}
.mask{position:fixed;z-index:80;inset:0;display:flex;align-items:flex-end;background:#0007}.drawer{box-sizing:border-box;width:100%;min-height:46vh;padding:26rpx 22rpx calc(22rpx + env(safe-area-inset-bottom));border-radius:24rpx 24rpx 0 0;background:#fff}.drawer-title{display:flex;justify-content:space-between}.drawer-title text{color:var(--wms-primary-700)}.base-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:10rpx;margin-top:20rpx}.base-grid view{padding:18rpx 6rpx;background:var(--wms-background);font-size:19rpx;text-align:center}.base-grid .active{background:var(--wms-primary-700);color:#fff}
</style>
