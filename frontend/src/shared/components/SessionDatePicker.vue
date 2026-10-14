<script setup lang="ts">
import { computed,ref,watch } from 'vue'

const props=withDefaults(defineProps<{visible:boolean;modelValue:string;allowAll?:boolean;maxDate?:string;title?:string}>(),{allowAll:false,title:'选择场次'})
const emit=defineEmits<{'update:visible':[value:boolean];'update:modelValue':[value:string];confirm:[value:string]}>()
const pad=(value:number)=>String(value).padStart(2,'0')
const format=(date:Date)=>`${date.getFullYear()}-${pad(date.getMonth()+1)}-${pad(date.getDate())}`
const parse=(value:string)=>{const matched=value.match(/^(\d{4})-(\d{2})-(\d{2})$/);return matched?new Date(Number(matched[1]),Number(matched[2])-1,Number(matched[3])):new Date()}
const maxValue=computed(()=>props.maxDate||format(new Date()))
const draft=ref(props.modelValue)
const month=ref(parse(props.modelValue))
watch(()=>props.visible,value=>{if(value){draft.value=props.modelValue;month.value=parse(props.modelValue||maxValue.value)}})
const monthLabel=computed(()=>`${month.value.getFullYear()}年${month.value.getMonth()+1}月`)
const days=computed(()=>{const year=month.value.getFullYear(),monthIndex=month.value.getMonth(),start=new Date(year,monthIndex,1),mondayIndex=(start.getDay()+6)%7;return Array.from({length:42},(_,index)=>{const date=new Date(year,monthIndex,index-mondayIndex+1),value=format(date);return{value,day:date.getDate(),current:date.getMonth()===monthIndex,disabled:value>maxValue.value}})})
function moveMonth(offset:number){month.value=new Date(month.value.getFullYear(),month.value.getMonth()+offset,1)}
function choose(value:string,disabled:boolean){if(!disabled)draft.value=value}
function close(){emit('update:visible',false)}
function submit(){emit('update:modelValue',draft.value);emit('confirm',draft.value);close()}
function chooseAll(){draft.value=''}
</script>

<template><view v-if="visible" class="calendar-mask" @click="close"><view class="calendar" @click.stop>
  <view class="calendar-head"><text class="head-side" @click="close">取消</text><strong>{{title}}</strong><text class="head-close" @click="close">×</text></view>
  <view class="month-nav"><text @click="moveMonth(-12)">«</text><text @click="moveMonth(-1)">‹</text><strong>{{monthLabel}}</strong><text @click="moveMonth(1)">›</text><text @click="moveMonth(12)">»</text></view>
  <view class="week"><text v-for="item in ['一','二','三','四','五','六','日']" :key="item">{{item}}</text></view>
  <view class="days"><view v-for="item in days" :key="item.value" :class="{muted:!item.current,disabled:item.disabled,selected:draft===item.value,today:item.value===maxValue}" @click="choose(item.value,item.disabled)">{{item.day}}</view></view>
  <view class="selected-value">{{draft||'未限定场次'}}</view>
  <view class="actions"><button v-if="allowAll" class="all" @click="chooseAll">全部场次</button><button class="confirm" @click="submit">确定</button></view>
</view></view></template>

<style scoped lang="scss">
.calendar-mask{position:fixed;z-index:120;inset:0;display:flex;align-items:flex-end;background:rgba(23,43,41,.45)}.calendar{box-sizing:border-box;width:100%;padding:24rpx 28rpx calc(28rpx + env(safe-area-inset-bottom));border-radius:32rpx 32rpx 0 0;background:#fff}.calendar-head{display:grid;grid-template-columns:90rpx 1fr 90rpx;align-items:center}.calendar-head strong{font-size:27rpx;text-align:center}.head-side{color:var(--wms-text-secondary);font-size:21rpx}.head-close{color:var(--wms-text-secondary);font-size:38rpx;text-align:right}.month-nav{display:grid;grid-template-columns:58rpx 58rpx 1fr 58rpx 58rpx;align-items:center;margin-top:18rpx}.month-nav text{display:flex;height:58rpx;align-items:center;justify-content:center;color:var(--wms-text-secondary);font-size:32rpx}.month-nav strong{font-size:28rpx;text-align:center}.week,.days{display:grid;grid-template-columns:repeat(7,1fr)}.week{margin-top:12rpx}.week text{height:58rpx;color:var(--wms-text-secondary);font-size:20rpx;line-height:58rpx;text-align:center}.days view{display:flex;height:66rpx;align-items:center;justify-content:center;border-radius:13rpx;color:var(--wms-text);font-size:22rpx}.days .muted{color:#b5bfbd}.days .disabled{color:#d4dcda}.days .today{box-shadow:inset 0 0 0 2rpx var(--wms-border)}.days .selected{background:var(--wms-primary-700);box-shadow:none;color:#fff;font-weight:750}.selected-value{height:56rpx;color:var(--wms-text-secondary);font-size:20rpx;line-height:56rpx;text-align:center}.actions{display:flex;gap:14rpx}.actions button{height:76rpx;margin:0;border:0;border-radius:16rpx;font-size:23rpx;line-height:76rpx}.actions .all{width:190rpx;background:var(--wms-surface-soft);color:var(--wms-primary-700)}.actions .confirm{flex:1;background:var(--wms-primary-700);color:#fff;font-weight:700}
</style>
