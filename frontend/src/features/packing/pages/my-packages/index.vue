<script setup lang="ts">
import{computed,ref}from'vue'
import{onLoad,onPullDownRefresh}from'@dcloudio/uni-app'
import{packingApi}from'../../api/packing.api'
import type{PackingPackage}from'../../models/packing'
import{sessionStore}from'@/store/session'
import WareState from '@/shared/components/WareState.vue'
import SessionTrigger from '@/shared/components/SessionTrigger.vue'
import SessionDatePicker from '@/shared/components/SessionDatePicker.vue'
const date=ref(''),rows=ref<PackingPackage[]>([]),loading=ref(true),error=ref(''),pickerVisible=ref(false),opened=ref<string[]>([])
const groups=computed(()=>{const result=new Map<string,PackingPackage[]>();for(const row of rows.value){const key=row.boxName||'未记录箱型';result.set(key,[...(result.get(key)||[]),row])}return[...result].map(([name,list])=>({name,list}))})
async function load(){loading.value=true;error.value='';try{rows.value=await packingApi.mine(date.value)}catch(e){error.value=e instanceof Error?e.message:'加载失败'}finally{loading.value=false;uni.stopPullDownRefresh()}}
function toggle(name:string){opened.value=opened.value.includes(name)?opened.value.filter(item=>item!==name):[...opened.value,name]}
onLoad(q=>{date.value=String(q?.date||new Date().toISOString().slice(0,10));load()});onPullDownRefresh(load)
</script>
<template><view class="page">
  <view class="account"><view class="identity"><view class="avatar">{{sessionStore.state.userName.slice(0,1)}}</view><strong>{{sessionStore.state.userName}}</strong></view><text>ID：{{sessionStore.state.userId}}</text></view>
  <view class="summary"><text>合计打包：<strong>{{groups.length}}</strong></text><SessionTrigger :value="date" @click="pickerVisible=true"/></view>
  <WareState v-if="loading" type="loading" title="正在加载"/>
  <WareState v-else-if="error" type="error" title="加载失败" :description="error" action-label="重新加载" @action="load"/>
  <template v-else-if="groups.length"><view class="table-head"><text>箱子型号</text><text>打包数量</text><text>展开</text></view><view class="group" v-for="group in groups" :key="group.name"><view class="group-row" @click="toggle(group.name)"><text>{{group.name}}</text><strong>{{group.list.length}}</strong><i :class="{open:opened.includes(group.name)}"/></view><view v-if="opened.includes(group.name)" class="labels"><view v-for="item in group.list" :key="item.id" class="label"><strong>{{item.shelfNo}}-{{item.serialNum}}</strong><text>{{item.status>=10?'打包完成':'设箱完成'}}</text></view></view></view></template>
  <WareState v-else type="empty" title="暂无数据" description="当前场次没有本人打包记录"/>
  <SessionDatePicker v-model="date" v-model:visible="pickerVisible" title="选择场次" @confirm="load"/>
</view></template>
<style scoped lang="scss">
.page{box-sizing:border-box;min-height:100vh;padding:24rpx;background:#fff}.account{display:flex;min-height:70rpx;align-items:center;justify-content:space-between;padding:0 16rpx;border-radius:10rpx;background:var(--wms-background)}.identity{display:flex;align-items:center;gap:14rpx}.avatar{display:flex;width:44rpx;height:44rpx;align-items:center;justify-content:center;border-radius:8rpx;background:var(--wms-surface-soft);color:var(--wms-primary-700);font-size:20rpx;font-weight:750}.account strong,.account>text{font-size:21rpx}.summary{display:flex;min-height:82rpx;align-items:center;justify-content:space-between}.summary>text{font-size:21rpx}.summary>text strong{color:var(--wms-primary-700);font-size:24rpx}.summary :deep(.session-trigger){width:auto;min-width:248rpx}.table-head,.group-row{display:grid;grid-template-columns:3fr 1.3fr .7fr;align-items:center}.table-head{min-height:58rpx;padding:0 20rpx;background:var(--wms-primary-700);color:#fff;font-size:20rpx;font-weight:700}.table-head text:last-child{text-align:right}.group{margin-top:8rpx}.group-row{min-height:68rpx;padding:0 20rpx;border-radius:8rpx;background:var(--wms-background);font-size:20rpx}.group-row strong{text-align:center}.group-row i{width:13rpx;height:13rpx;justify-self:end;border-right:3rpx solid var(--wms-text-secondary);border-bottom:3rpx solid var(--wms-text-secondary);transform:rotate(45deg);transition:transform .2s}.group-row i.open{transform:rotate(225deg)}.labels{display:grid;grid-template-columns:repeat(4,1fr);gap:12rpx;padding:14rpx 0}.label{display:flex;min-height:76rpx;align-items:center;justify-content:center;flex-direction:column;border-radius:10rpx;background:var(--wms-surface-soft);color:var(--wms-success)}.label strong{font-size:18rpx}.label text{margin-top:5rpx;font-size:16rpx}
</style>
