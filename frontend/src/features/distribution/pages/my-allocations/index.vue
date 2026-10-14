<script setup lang="ts">
import { ref } from 'vue'
import { onLoad, onPullDownRefresh } from '@dcloudio/uni-app'
import { distributionApi } from '../../api/distribution.api'
import type { MyDistributionDashboard, MyDistributionSession } from '../../models/distribution'
import WareState from '@/shared/components/WareState.vue'
import { sessionStore } from '@/store/session'

const loading=ref(false),error=ref('')
const dashboard=ref<MyDistributionDashboard>({recentSessionUnits:0,monthlyAllocatedUnits:0,monthlyPunishmentCount:0,sessions:[]})
async function load(){if(!sessionStore.can('distribution.mine.view'))return;loading.value=true;error.value='';try{dashboard.value=await distributionApi.myAllocations()}catch(e){error.value=e instanceof Error?e.message:'我的配货加载失败'}finally{loading.value=false;uni.stopPullDownRefresh()}}
function openSession(row:MyDistributionSession){uni.redirectTo({url:`/features/distribution/pages/home/index?date=${row.date}`})}
onLoad(()=>{if(!sessionStore.can('distribution.mine.view')){uni.showToast({title:'当前账号无权查看我的配货',icon:'none'});setTimeout(()=>uni.navigateBack(),600);return}load()})
onPullDownRefresh(load)
</script>

<template><view class="page">
  <text class="section-title">配货统计</text>
  <view class="stats">
    <view><strong>{{dashboard.recentSessionUnits}}<text>扎</text></strong><small>最近一场配货</small></view>
    <view><strong>{{dashboard.monthlyAllocatedUnits}}<text>扎</text></strong><small>近一个月配货</small></view>
    <view class="danger"><strong>{{dashboard.monthlyPunishmentCount}}<text>次</text></strong><small>近一个月处罚</small></view>
  </view>

  <view class="section-head"><text class="section-title">配货明细</text><text>共 {{dashboard.sessions.length}} 个场次</text></view>
  <view class="table-head"><text>场次</text><text>配货扎数</text><text>操作</text></view>
  <WareState v-if="loading" type="loading" title="正在汇总配货记录"/>
  <WareState v-else-if="error" type="error" title="加载失败" :description="error" action-label="重新加载" @action="load"/>
  <view v-else-if="dashboard.sessions.length" class="rows"><view v-for="row in dashboard.sessions" :key="row.date" class="row">
    <view><strong>{{row.date}}</strong><small>场次</small></view>
    <strong class="units">{{row.allocatedUnits}}<text>扎</text></strong>
    <button @click="openSession(row)">查看</button>
  </view></view>
  <WareState v-else type="empty" title="暂无配货数据" description="确认配货后，会按场次汇总到这里"/>
</view></template>

<style scoped lang="scss">
.page{min-height:100vh;padding:20rpx 24rpx 60rpx}.section-title{display:block;margin-top:28rpx;font-size:27rpx;font-weight:800}.page>.section-title:first-child{margin-top:0}.stats{display:grid;grid-template-columns:repeat(3,1fr);gap:12rpx;margin-top:14rpx}.stats>view{min-width:0;padding:22rpx 14rpx;border-radius:18rpx;background:#fff;box-shadow:var(--wms-shadow-card)}.stats strong,.stats small{display:block}.stats strong{color:var(--wms-primary-700);font-size:36rpx;font-variant-numeric:tabular-nums}.stats strong text{margin-left:4rpx;font-size:19rpx}.stats small{margin-top:9rpx;color:var(--wms-text-secondary);font-size:19rpx;white-space:nowrap}.stats .danger{background:#fff0ee}.stats .danger strong{color:var(--wms-danger)}.section-head{display:flex;align-items:flex-end;justify-content:space-between}.section-head>text:last-child{color:var(--wms-text-secondary);font-size:19rpx}.table-head,.row{display:grid;grid-template-columns:1.3fr .8fr .65fr;align-items:center}.table-head{height:64rpx;margin-top:13rpx;padding:0 18rpx;border-radius:14rpx 14rpx 0 0;background:var(--wms-primary-700);color:#fff;font-size:21rpx}.table-head text:nth-child(n+2){text-align:center}.rows{overflow:hidden;border-radius:0 0 16rpx 16rpx;background:#fff}.row{min-height:92rpx;padding:0 18rpx;border-bottom:1rpx solid var(--wms-border)}.row:last-child{border:0}.row>view strong,.row>view small{display:block}.row>view strong{font-size:23rpx}.row>view small{margin-top:4rpx;color:var(--wms-text-secondary);font-size:18rpx}.units{color:var(--wms-primary-700);font-size:28rpx;text-align:center}.units text{margin-left:4rpx;font-size:18rpx}.row button{height:52rpx;margin:0;padding:0;border:1rpx solid var(--wms-primary-700);border-radius:12rpx;background:#fff;color:var(--wms-primary-700);font-size:20rpx;line-height:50rpx}.row button:after{border:0}
</style>
