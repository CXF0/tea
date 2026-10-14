<script setup lang="ts">
import { computed, ref } from "vue";
import { onLoad, onPullDownRefresh } from "@dcloudio/uni-app";
import WareState from "@/shared/components/WareState.vue";
import WarePhoneLink from "@/shared/components/WarePhoneLink.vue";
import SessionDatePicker from "@/shared/components/SessionDatePicker.vue";
import { baseStocktakingApi, type StocktakingBase, type StocktakingSupplier } from "../../api/base-stocktaking.api";
const date=ref(new Date().toISOString().slice(0,10)),bases=ref<StocktakingBase[]>([]),baseId=ref(0),rows=ref<StocktakingSupplier[]>([]),keyword=ref(""),loading=ref(true),error=ref(""),showDate=ref(false),showBases=ref(false);
const activeBase=computed(()=>bases.value.find(x=>x.id===baseId.value));
const visible=computed(()=>rows.value.filter(x=>!keyword.value.trim()||x.name.includes(keyword.value.trim())));
async function load(){loading.value=true;error.value="";try{bases.value=await baseStocktakingApi.bases();if(!bases.value.some(x=>x.id===baseId.value))baseId.value=bases.value[0]?.id||0;rows.value=baseId.value?await baseStocktakingApi.suppliers(baseId.value,date.value):[]}catch(e){error.value=e instanceof Error?e.message:"盘点数据加载失败"}finally{loading.value=false;uni.stopPullDownRefresh()}}
async function chooseBase(id:number){baseId.value=id;showBases.value=false;await load()}
async function chooseDate(value:string){date.value=value;await load()}
function open(row:StocktakingSupplier){uni.navigateTo({url:`/features/base-stocktaking/pages/detail/index?baseId=${baseId.value}&supplierId=${row.id}&date=${date.value}`})}
onLoad(q=>{if(q?.date)date.value=String(q.date);load()});onPullDownRefresh(load);
</script>
<template><view class="page">
  <view class="filters"><view class="search"><text>⌕</text><input v-model="keyword" placeholder="供应商名称" /></view><view class="filter-trigger base" @click="showBases=true"><text>{{activeBase?.name||'暂无基地'}}</text><i/></view><view class="filter-trigger date" @click="showDate=true"><text>{{date}}</text><i/></view></view>
  <WareState v-if="loading" type="loading" title="正在加载盘点数据"/><WareState v-else-if="error" type="error" title="加载失败" :description="error" action-label="重试" @action="load"/>
  <template v-else><view class="table-head"><text>供应商</text><text>普通花材</text><text>盘点数量</text></view><WareState v-if="!visible.length" type="empty" title="暂无供应商盘点数据"/><view v-for="row in visible" :key="row.id" class="row" @click="open(row)"><view><b>{{row.name}}</b><WarePhoneLink :phone="row.phone" compact /></view><strong>{{row.ordinaryFlowerNum}}</strong><strong>{{row.inventoryNum}}</strong></view></template>
  <SessionDatePicker v-model="date" v-model:visible="showDate" @confirm="chooseDate"/>
  <view v-if="showBases" class="mask" @click="showBases=false"><view class="drawer" @click.stop><view class="drawer-title"><b>选择基地</b><text @click="showBases=false">关闭</text></view><view class="base-grid"><view v-for="item in bases" :key="item.id" :class="{active:item.id===baseId}" @click="chooseBase(item.id)">{{item.name}}</view></view></view></view>
</view></template>
<style scoped>
.page{min-height:100vh;padding:18rpx 20rpx 40rpx;background:var(--wms-background)}.filters{display:grid;grid-template-columns:minmax(0,1.25fr) minmax(0,.9fr) minmax(0,1.05fr);align-items:center;gap:10rpx;margin-bottom:14rpx}.search,.filter-trigger{box-sizing:border-box;height:58rpx;border:1rpx solid var(--wms-border);border-radius:8rpx;background:#fff;color:var(--wms-primary-700)}.search{display:flex;min-width:0;align-items:center;gap:6rpx;padding:0 11rpx}.search input{min-width:0;flex:1;font-size:18rpx}.filter-trigger{display:flex;min-width:0;align-items:center;justify-content:center;gap:8rpx;padding:0 10rpx;font-size:18rpx;font-weight:650}.filter-trigger text{overflow:hidden;min-width:0;text-overflow:ellipsis;white-space:nowrap}.filter-trigger i{box-sizing:border-box;width:8rpx;height:8rpx;flex:none;margin-top:-4rpx;border-right:2rpx solid currentColor;border-bottom:2rpx solid currentColor;transform:rotate(45deg)}.table-head,.row{display:grid;grid-template-columns:minmax(0,1.7fr) 1fr 1fr;align-items:center}.table-head{padding:11rpx 18rpx;background:var(--wms-primary-700);color:#fff;font-size:19rpx;font-weight:700}.row{min-height:78rpx;margin-top:8rpx;padding:10rpx 18rpx;background:#fff}.row b,.row view>text{display:block}.row b{font-size:20rpx}.row view>text{margin-top:4rpx;color:var(--wms-primary-700);font-size:16rpx}.row strong{font-size:21rpx}.mask{position:fixed;z-index:80;inset:0;display:flex;align-items:flex-end;background:#0007}.drawer{width:100%;min-height:360rpx;padding:26rpx 22rpx calc(22rpx + env(safe-area-inset-bottom));border-radius:24rpx 24rpx 0 0;background:#fff}.drawer-title{display:flex;justify-content:space-between}.drawer-title text{color:var(--wms-primary-700)}.base-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:10rpx;margin-top:22rpx}.base-grid view{padding:19rpx 8rpx;background:var(--wms-background);text-align:center;font-size:18rpx}.base-grid .active{background:var(--wms-primary-700);color:#fff}
</style>
<style scoped>
.table-head{font-size:var(--wms-font-list-meta)}.row{font-size:var(--wms-font-list-body);line-height:var(--wms-line-list)}.row b{font-size:var(--wms-font-list-body);font-weight:650}.row strong{font-size:var(--wms-font-list-body);font-weight:700}
</style>
