<script setup lang="ts">
import { computed } from 'vue'
import type { ColdStorageItem, ColdStorageMode } from '../models/cold-storage'
const props=defineProps<{item:ColdStorageItem;mode:ColdStorageMode;allowFinish?:boolean}>()
defineEmits<{finish:[item:ColdStorageItem]}>()
const storeTypeText=computed(()=>props.item.storeType===2?'裸花暂存':'包裹暂存')
const quantityText=computed(()=>props.item.storeType===2?`${props.mode==='current'?(props.item.remainingBunchNum||props.item.bunchNum):(props.item.finishBunchNum||props.item.outBunchNum)} 扎`:`${props.mode==='current'?Math.max(props.item.packageTotal-props.item.packageOut,0):props.item.outPackageNum} 件`)
const statusText=computed(()=>props.mode==='pending'?'待出库':props.mode==='done'?'已出库':'暂存中')
const outTypeText=computed(()=>props.item.outType===1?'关联发货单':props.item.outType===2?'直接出库':props.item.outType===3?'转代卖':'—')
const operationTime=computed(()=>String(props.mode==='done'?props.item.finishTime:props.mode==='pending'?props.item.operateTime:props.item.inTime).slice(0,16).replace('T',' ')||'—')
const call=()=>props.item.purchaserMobile&&uni.makePhoneCall({phoneNumber:props.item.purchaserMobile})
</script>
<template><view class="storage-card">
  <view class="card-head"><view><strong>{{item.purchaserNick||'未命名客户'}}</strong><text :class="['type',item.storeType===2?'bare':'package']">{{storeTypeText}}</text></view><text :class="['status',mode]">{{statusText}}</text></view>
  <view class="info"><view><text>客户手机号</text><strong class="phone" @click="call">{{item.purchaserMobile||'—'}}</strong></view><view><text>暂存货位</text><strong>{{item.locationNo||'—'}}</strong></view><view><text>暂存场次</text><strong>{{item.storeRoundNo||'—'}}</strong></view><view><text>{{item.storeType===2?'裸花数量':'包裹数量'}}</text><strong class="quantity">{{quantityText}}</strong></view><template v-if="mode!=='current'"><view><text>出库方式</text><strong>{{outTypeText}}</strong></view><view v-if="item.outType===1"><text>目标货架</text><strong>{{item.todayShelfNo||'—'}}</strong></view></template></view>
  <view v-if="item.remark" class="remark"><text>备注</text><strong>{{item.remark}}</strong></view>
  <view class="footer"><view><text>{{mode==='done'?'出库人':'入库人'}}：{{mode==='done'?(item.finishUserName||'—'):(item.inUserName||'—')}}</text><text>{{operationTime}}</text></view><button v-if="mode==='pending'&&item.taskStatus===10&&allowFinish" @click="$emit('finish',item)">确认出库</button></view>
</view></template>
<style scoped lang="scss">
.storage-card{padding:24rpx;border-radius:22rpx;background:#fff;box-shadow:var(--wms-shadow-card)}.card-head,.card-head>view,.footer,.footer>view{display:flex;align-items:center}.card-head{justify-content:space-between}.card-head strong{font-size:28rpx}.type,.status{margin-left:12rpx;padding:6rpx 11rpx;border-radius:9rpx;font-size:19rpx;font-weight:700}.type.package{background:#e5f7ee;color:var(--wms-success)}.type.bare{background:#f0eaff;color:#7047bb}.status{margin:0}.status.pending{background:#fff1da;color:#a86200}.status.done{background:var(--wms-surface-soft);color:var(--wms-success)}.status.current{background:#e9f2ff;color:#3169a8}.info{display:grid;grid-template-columns:1fr 1fr;gap:18rpx 24rpx;margin-top:22rpx}.info text,.info strong{display:block}.info text{color:var(--wms-text-secondary);font-size:19rpx}.info strong{margin-top:6rpx;font-size:22rpx}.info .phone{color:#3169a8}.info .quantity{color:var(--wms-primary-700);font-size:25rpx}.remark{display:flex;gap:14rpx;margin-top:20rpx;padding:14rpx;border-radius:12rpx;background:var(--wms-page);font-size:20rpx}.remark text{color:var(--wms-text-secondary)}.remark strong{font-weight:500}.footer{justify-content:space-between;margin-top:22rpx;padding-top:17rpx;border-top:1rpx solid var(--wms-border)}.footer>view{align-items:flex-start;flex-direction:column;gap:6rpx;color:var(--wms-text-secondary);font-size:18rpx}.footer button{height:62rpx;margin:0;padding:0 22rpx;border:0;border-radius:13rpx;background:var(--wms-primary-700);color:#fff;font-size:21rpx;line-height:62rpx}
</style>
