<script setup lang="ts">
import { ref } from "vue";
import { onLoad, onPullDownRefresh } from "@dcloudio/uni-app";
import WareState from "@/shared/components/WareState.vue";
import SessionTrigger from "@/shared/components/SessionTrigger.vue";
import SessionDatePicker from "@/shared/components/SessionDatePicker.vue";
import { bulkPurchaseApi, type BulkDemand } from "../../api/bulk-purchase.api";

const date = ref(new Date().toISOString().slice(0, 10));
const status = ref(-1);
const keyword = ref("");
const rows = ref<BulkDemand[]>([]);
const loading = ref(true);
const error = ref("");
const datePicker = ref(false);
const statuses = [[-1,"全部状态"],[0,"草稿"],[1,"报价中"],[2,"待定采"],[3,"已确认"],[4,"已完成"],[5,"已关闭"]] as const;
const statusName = (value:number) => statuses.find(item => item[0] === value)?.[1] || "未知";
const formatNumber = (value:number) => Number(value || 0).toLocaleString("zh-CN");

async function load() {
  loading.value = true;
  error.value = "";
  try { rows.value = await bulkPurchaseApi.demands({ roundNo: date.value, status: status.value, keyword: keyword.value.trim() }); }
  catch (reason) { error.value = reason instanceof Error ? reason.message : "集采需求加载失败"; }
  finally { loading.value = false; uni.stopPullDownRefresh(); }
}
function openDetail(id:number) { uni.navigateTo({ url: `/features/bulk-purchase/pages/demands/detail?id=${id}` }); }
onLoad(load);
onPullDownRefresh(load);
</script>

<template>
  <view class="page">
    <view class="filters">
      <input v-model="keyword" placeholder="需求名称或花材" @confirm="load" />
      <SessionTrigger :value="date" @click="datePicker = true" />
      <picker :range="statuses.map(item => item[1])" @change="status=statuses[Number($event.detail.value)][0];load()">
        <view class="status-trigger">{{ statusName(status) }}<i /></view>
      </picker>
    </view>
    <WareState v-if="loading" type="loading" title="正在加载集采需求" />
    <WareState v-else-if="error" type="error" title="集采需求加载失败" :description="error" action-label="重试" @action="load" />
    <WareState v-else-if="!rows.length" type="empty" title="暂无集采需求" description="当前场次没有符合条件的集采需求" />
    <view v-else class="list">
      <view v-for="item in rows" :key="item.id" class="card" @click="openDetail(item.id)">
        <view class="head">
          <view><b>{{ item.theme }}</b><text>{{ item.demandNo }}</text></view>
          <view class="head-right"><span :class="`s${item.status}`">{{ statusName(item.status) }}</span><i /></view>
        </view>
        <view class="product"><strong>{{ item.secondName }}</strong><text>{{ item.specNum }}{{ item.specUnit || '枝' }}/扎 · {{ item.rankCodes || '未分级' }}</text></view>
        <view class="metrics">
          <view><text>需求数量</text><b>{{ formatNumber(item.demandNum + item.appendNum) }}<small>枝</small></b></view>
          <view><text>报价供应商</text><b>{{ item.quoteCount }}<small>家</small></b></view>
          <view><text>供货单</text><b>{{ item.orderCount }}<small>单</small></b></view>
        </view>
        <view class="meta"><text>采购主体</text><b>{{ item.publishSupplierName }}</b><text>场次</text><b>{{ item.roundNo }}</b><text>报价截止</text><b>{{ item.dounanQuoteEndTime || item.nonDounanQuoteEndTime || '—' }}</b></view>
      </view>
    </view>
    <SessionDatePicker :visible="datePicker" :model-value="date" @close="datePicker=false" @confirm="date=$event;datePicker=false;load()" />
  </view>
</template>

<style scoped>
.page{min-height:100vh;padding:18rpx;background:var(--wms-background)}.filters{display:grid;grid-template-columns:minmax(0,1fr) 210rpx 150rpx;gap:9rpx;margin-bottom:14rpx}.filters input,.status-trigger{box-sizing:border-box;height:62rpx;padding:0 13rpx;border:1rpx solid var(--wms-border);border-radius:8rpx;background:#fff;font-size:19rpx}.filters input{min-width:0}.status-trigger{display:flex;align-items:center;justify-content:space-between;color:var(--wms-primary-700)}.status-trigger i{width:9rpx;height:9rpx;border-right:2rpx solid;border-bottom:2rpx solid;transform:rotate(45deg) translateY(-3rpx)}.list{display:flex;flex-direction:column;gap:12rpx}.card{padding:19rpx;border-radius:14rpx;background:#fff;box-shadow:0 3rpx 10rpx rgba(28,59,52,.04)}.head,.product,.head-right{display:flex;align-items:center;justify-content:space-between}.head b,.head text{display:block}.head b{font-size:25rpx}.head text{margin-top:4rpx;color:var(--wms-text-secondary);font-size:18rpx}.head span{padding:5rpx 10rpx;border-radius:7rpx;background:var(--wms-surface-soft);color:var(--wms-primary-700);font-size:18rpx}.head .s0,.head .s5{background:#eef1f0;color:var(--wms-text-secondary)}.head .s1,.head .s2{background:#fff3dd;color:var(--wms-warning)}.head-right{gap:12rpx}.head-right i{width:10rpx;height:10rpx;border-top:2rpx solid var(--wms-text-secondary);border-right:2rpx solid var(--wms-text-secondary);transform:rotate(45deg)}.product{margin-top:15rpx;padding-top:13rpx;border-top:1rpx solid var(--wms-border)}.product strong{font-size:22rpx}.product text{color:var(--wms-text-secondary);font-size:18rpx}.metrics{display:grid;grid-template-columns:repeat(3,1fr);margin-top:14rpx;padding:14rpx 0;background:var(--wms-surface-page)}.metrics view{text-align:center;border-right:1rpx solid var(--wms-border)}.metrics view:last-child{border:0}.metrics text,.metrics b{display:block}.metrics text{color:var(--wms-text-secondary);font-size:18rpx}.metrics b{margin-top:4rpx;font-size:25rpx}.metrics small{margin-left:3rpx;font-size:16rpx}.meta{display:grid;grid-template-columns:130rpx 1fr;gap:9rpx;margin-top:14rpx;font-size:18rpx}.meta text{color:var(--wms-text-secondary)}.meta b{text-align:right;font-weight:500}
</style>
