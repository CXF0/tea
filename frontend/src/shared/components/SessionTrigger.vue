<script setup lang="ts">
withDefaults(defineProps<{ value: string; emptyLabel?: string }>(),{emptyLabel:'全部场次'})
defineEmits<{ click: [] }>()
</script>

<template>
  <button class="session-trigger" type="button" @click="$emit('click')">
    <view class="calendar-icon" aria-hidden="true"><i/><i/></view>
    <text>{{ value ? `${value} 场次` : emptyLabel }}</text>
    <view class="chevron" aria-hidden="true"/>
  </button>
</template>

<style scoped lang="scss">
.session-trigger{box-sizing:border-box;display:inline-flex;width:auto;height:54rpx;align-items:center;justify-content:center;gap:10rpx;margin:0;padding:0 16rpx;border:1rpx solid var(--wms-border);border-radius:14rpx;background:#fff;color:var(--wms-primary-700);font-size:21rpx;font-weight:650;line-height:1;white-space:nowrap;box-shadow:0 3rpx 10rpx rgba(24,50,48,.04)}
.session-trigger:after{border:0}.session-trigger text{display:block;line-height:1}.calendar-icon{position:relative;box-sizing:border-box;width:25rpx;height:24rpx;flex:none;border:2rpx solid currentColor;border-radius:5rpx}.calendar-icon:after{position:absolute;top:6rpx;right:0;left:0;height:2rpx;background:currentColor;content:'';opacity:.6}.calendar-icon i{position:absolute;top:-5rpx;width:3rpx;height:7rpx;border-radius:3rpx;background:currentColor}.calendar-icon i:first-child{left:5rpx}.calendar-icon i:last-child{right:5rpx}.chevron{box-sizing:border-box;width:10rpx;height:10rpx;flex:none;margin-top:-4rpx;border-right:2rpx solid currentColor;border-bottom:2rpx solid currentColor;transform:rotate(45deg)}
</style>
