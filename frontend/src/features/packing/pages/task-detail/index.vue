<script setup lang="ts">
import { computed, ref } from 'vue'
import { onLoad } from '@dcloudio/uni-app'
import { packingApi } from '../../api/packing.api'
import type { BoxType, PackingPackage, PackingShelfDetail } from '../../models/packing'
import WareState from '@/shared/components/WareState.vue'
import { appConfig } from '@/app/config/env'

const date=ref(''),shelfSn=ref(0),detail=ref<PackingShelfDetail>(),boxes=ref<BoxType[]>([]),selectedIndex=ref(0)
const active=ref<PackingPackage>(),boxIndex=ref(0),photos=ref<string[]>([]),loading=ref(true),saving=ref(false),uploading=ref(false)
const current=computed(()=>detail.value?.packages[selectedIndex.value])
const shelfStatus=computed(()=>detail.value?.packages.every(row=>row.status>=20)?'发货完成':detail.value?.packages.every(row=>row.status>=10)?'打包完成':'待打包')
const selectedBox=computed(()=>boxes.value[boxIndex.value])
const src=(url:string)=>url.startsWith('http')?url:`${appConfig.apiBaseUrl}${url}`
async function load(){loading.value=true;try{const [next,types]=await Promise.all([packingApi.shelf(date.value,shelfSn.value),packingApi.boxTypes()]);detail.value=next;boxes.value=types;if(selectedIndex.value>=next.packages.length)selectedIndex.value=0}finally{loading.value=false}}
function selectPackage(index:number){selectedIndex.value=index}
function begin(){const row=current.value;if(!row)return;active.value=row;photos.value=[];const index=boxes.value.findIndex(box=>box.id===row.suggestBoxId);boxIndex.value=index<0?0:index}
function choose(){uni.chooseImage({count:3-photos.value.length,sourceType:['camera','album'],success:async result=>{uploading.value=true;try{for(const path of result.tempFilePaths)photos.value.push((await packingApi.upload(path)).url)}finally{uploading.value=false}}})}
async function submit(){if(!active.value||!selectedBox.value||!photos.value.length)return;saving.value=true;try{await packingApi.complete(active.value.id,selectedBox.value,photos.value);active.value=undefined;await load();uni.showToast({title:'打包完成',icon:'success'})}finally{saving.value=false}}
onLoad(query=>{date.value=String(query?.date||'');shelfSn.value=Number(query?.shelfSn);load()})
</script>

<template><view class="page">
  <WareState v-if="loading" type="loading" title="正在加载货架包裹"/>
  <template v-else-if="detail">
    <view class="header"><view><text>货架号</text><strong>{{detail.shelfNo}}</strong></view><view class="header-status"><text>状态</text><strong>{{shelfStatus}}</strong></view></view>
    <scroll-view scroll-x class="package-tabs"><view class="tab-row"><view v-for="(row,index) in detail.packages" :key="row.id" :class="['package-tab',{active:selectedIndex===index}]" @click="selectPackage(index)"><text>{{row.serialNum}}</text><i :class="{done:row.status>=10}"/></view></view></scroll-view>
    <view v-if="current" class="detail-card">
      <view class="detail-title"><strong># {{detail.shelfNo}}-{{current.serialNum}}</strong><text :class="{done:current.status>=10}">{{current.status>=20?'发货完成':current.status>=10?'打包完成':current.status===1?'开始打包':'待打包'}}</text></view>
      <view class="rows">
        <view><text>场次</text><strong>{{current.date}}</strong></view>
        <view class="materials"><text>保温材料</text><strong>保温棉 ×{{current.cottonNum}}　保温板 ×{{current.boardNum}}　保温袋 ×{{current.bagNum}}</strong></view>
        <view><text>预计箱型</text><strong class="recommend">{{current.suggestBoxName||'未推荐箱型'}}</strong></view>
        <view><text>包裹类型</text><strong>{{current.boxName||'待打包后确认'}} <i v-if="current.boxMismatch" class="mismatch">设箱不符</i></strong></view>
        <view><text>物流名称</text><strong>{{current.expressName||'未设置'}}</strong></view>
        <view><text>地址</text><strong>{{current.receiveAddress||'未设置'}}</strong></view>
        <view><text>联系方式</text><strong>{{current.receiveName||'--'}}　{{current.receiveTel||''}}</strong></view>
        <view><text>备注</text><strong :class="{remark:current.remark}">{{current.remark||'无'}}</strong></view>
        <template v-if="current.status>=10"><view><text>打包完成时间</text><strong>{{current.packageTime||'--'}}</strong></view><view><text>打包人员</text><strong>{{current.packageUserName||'--'}}</strong></view></template>
      </view>
      <view v-if="current.status>=10" class="completed-photos"><text>完成拍照</text><view v-if="current.photos.length" class="photo-grid"><image v-for="url in current.photos" :key="url" :src="src(url)" mode="aspectFill"/></view><text v-else class="no-photo">暂无照片</text></view>
    </view>
    <view v-if="current&&current.status<10" class="footer"><button @click="begin">完成当前包裹打包</button></view>
  </template>
  <WareState v-else type="error" title="货架不存在"/>
  <view v-if="active" class="mask" @click="active=undefined"><view class="drawer" @click.stop><view class="handle"/><strong class="drawer-title">完成 {{active.serialNum}} 号包裹</strong><text class="drawer-subtitle">推荐箱型：{{active.suggestBoxName||'无'}}</text><picker :range="boxes" range-key="name" :value="boxIndex" @change="boxIndex=Number($event.detail.value)"><view class="picker">实际箱型 <strong>{{selectedBox?.name||'暂无可用箱型'}}</strong><text>选择 ›</text></view></picker><text v-if="selectedBox&&active.suggestBoxId&&selectedBox.id!==active.suggestBoxId" class="warning">实际箱型与推荐箱型不一致，请确认后提交</text><view class="photos"><view v-for="(url,index) in photos" :key="url"><image :src="src(url)" mode="aspectFill"/><text @click="photos.splice(index,1)">×</text></view><view v-if="photos.length<3" class="photo-add" @click="choose"><strong>＋</strong><text>{{uploading?'上传中':'完成照片'}}</text></view></view><button class="submit" :disabled="saving||uploading||!selectedBox||!photos.length" @click="submit">{{saving?'提交中…':'确认打包完成'}}</button></view></view>
</view></template>

<style scoped lang="scss">
.page{min-height:100vh;padding:24rpx 24rpx 160rpx}.header{display:flex;align-items:center;justify-content:space-between;padding:22rpx;border-radius:20rpx;background:#fff}.header>view{display:flex;align-items:center;gap:14rpx}.header text{color:var(--wms-text-secondary);font-size:20rpx}.header strong{font-size:29rpx}.header-status strong{color:var(--wms-primary-700);font-size:24rpx}.package-tabs{margin:16rpx 0}.tab-row{display:flex;gap:12rpx;width:max-content;padding:2rpx}.package-tab{display:flex;min-width:72rpx;height:70rpx;align-items:center;justify-content:center;flex-direction:column;border:1rpx solid var(--wms-border);border-radius:12rpx;background:#fff}.package-tab text{font-size:23rpx}.package-tab i{width:10rpx;height:10rpx;margin-top:5rpx;border-radius:50%;background:var(--wms-warning)}.package-tab i.done{background:var(--wms-success)}.package-tab.active{border-color:var(--wms-primary-700);background:var(--wms-primary-700);color:#fff}.package-tab.active i{box-shadow:0 0 0 3rpx rgba(255,255,255,.8)}.detail-card{padding:24rpx;border-radius:22rpx;background:#fff;box-shadow:var(--wms-shadow-card)}.detail-title{display:flex;align-items:center;justify-content:space-between;padding-bottom:20rpx;border-bottom:1rpx solid var(--wms-border)}.detail-title strong{color:var(--wms-primary-700);font-size:29rpx}.detail-title text{padding:6rpx 11rpx;border-radius:8rpx;background:#fff1d9;color:#9b5c00;font-size:18rpx}.detail-title text.done{background:#e6f5ef;color:var(--wms-success)}.rows{padding-top:8rpx}.rows>view{display:grid;grid-template-columns:150rpx 1fr;min-height:68rpx;align-items:center}.rows text{color:var(--wms-text-secondary);font-size:20rpx}.rows strong{font-size:21rpx;font-weight:600}.rows .recommend{color:var(--wms-danger)}.completed-photos{margin-top:16rpx;padding-top:20rpx;border-top:1rpx solid var(--wms-border)}.completed-photos>text{font-size:21rpx;font-weight:700}.photo-grid{display:flex;gap:12rpx;margin-top:14rpx}.photo-grid image{width:140rpx;height:140rpx;border-radius:14rpx}.completed-photos .no-photo{display:block;margin-top:14rpx;color:var(--wms-text-secondary);font-size:18rpx;font-weight:400}.footer{position:fixed;right:0;bottom:0;left:0;padding:16rpx 24rpx calc(18rpx + env(safe-area-inset-bottom));border-top:1rpx solid var(--wms-border);background:#fff}.footer button,.submit{height:82rpx;border:0;border-radius:16rpx;background:var(--wms-primary-700);color:#fff;font-size:24rpx;font-weight:700;line-height:82rpx}.mask{position:fixed;z-index:50;inset:0;display:flex;align-items:flex-end;background:rgba(22,42,40,.45)}.drawer{box-sizing:border-box;width:100%;padding:15rpx 26rpx calc(28rpx + env(safe-area-inset-bottom));border-radius:30rpx 30rpx 0 0;background:#fff}.handle{width:70rpx;height:7rpx;margin:0 auto 22rpx;border-radius:5rpx;background:var(--wms-border)}.drawer-title,.drawer-subtitle{display:block}.drawer-title{font-size:29rpx}.drawer-subtitle{margin-top:8rpx;color:var(--wms-text-secondary);font-size:19rpx}.picker{display:flex;align-items:center;margin-top:23rpx;padding:21rpx;border-radius:15rpx;background:var(--wms-background);font-size:20rpx}.picker strong{flex:1;margin-left:18rpx}.picker text{color:var(--wms-primary-700)}.warning{display:block;margin-top:10rpx;color:#a35e00;font-size:17rpx}.photos{display:flex;gap:12rpx;margin-top:20rpx}.photos>view{position:relative;width:138rpx;height:138rpx;overflow:hidden;border-radius:14rpx}.photos image{width:100%;height:100%}.photos>view>text{position:absolute;top:5rpx;right:5rpx;display:flex;width:34rpx;height:34rpx;align-items:center;justify-content:center;border-radius:50%;background:#263c39;color:#fff}.photos .photo-add{display:flex;align-items:center;justify-content:center;flex-direction:column;background:var(--wms-background);color:var(--wms-primary-700)}.photo-add strong{font-size:36rpx}.photo-add text{position:static;width:auto;height:auto;background:none;color:var(--wms-text-secondary);font-size:16rpx}.submit{width:100%;margin-top:24rpx}.submit[disabled]{opacity:.45}
.mismatch{display:inline-flex;align-items:center;margin-left:10rpx;padding:4rpx 10rpx;border:1rpx solid #f2b8b8;border-radius:7rpx;background:#fde8e8;color:var(--wms-danger);font-size:16rpx;font-style:normal;font-weight:700;line-height:1.35;vertical-align:middle}
</style>
