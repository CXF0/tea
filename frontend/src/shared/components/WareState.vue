<script setup lang="ts">
defineProps<{ type: 'loading' | 'empty' | 'error' | 'forbidden'; title: string; description?: string; actionLabel?: string }>()
defineEmits<{ action: [] }>()
</script>

<template>
  <view class="state">
    <view :class="['mark', type]" />
    <text class="title">{{ title }}</text>
    <text v-if="description" class="description">{{ description }}</text>
    <button v-if="actionLabel" class="action" @click="$emit('action')">{{ actionLabel }}</button>
  </view>
</template>

<style scoped>
.state { display:flex; min-height:320rpx; padding:48rpx 24rpx; align-items:center; justify-content:center; flex-direction:column; text-align:center; }
.mark { width:64rpx; height:64rpx; margin-bottom:24rpx; border:5rpx solid var(--wms-border); border-radius:50%; }.mark.loading { border-top-color:var(--wms-action-600); }.mark.error,.mark.forbidden { border-color:#ffd5da; }
.title { font-size:30rpx; font-weight:700; }.description { max-width:520rpx; margin-top:12rpx; color:var(--wms-text-secondary); font-size:25rpx; line-height:1.6; }.action { margin-top:28rpx; width:220rpx; color:var(--wms-primary-700); font-size:27rpx; }
</style>
