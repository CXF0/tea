<script setup lang="ts">
import WareStatus from '@/shared/components/WareStatus.vue'
import type { QualityTask } from '../models/quality'

defineProps<{ task: QualityTask }>()
defineEmits<{ select: [task: QualityTask] }>()
</script>

<template>
  <view class="task" @click="$emit('select', task)">
    <view class="top">
      <view class="name-row"><text class="name">{{ task.flowerName }}</text><text class="grade">{{ task.grade }}</text></view>
      <WareStatus v-if="task.priority" tone="warning" label="重点质检" />
      <WareStatus v-else :tone="task.status === 0 ? 'neutral' : task.status === 10 ? 'danger' : 'success'" :label="task.statusLabel" />
    </view>
    <view class="meta"><text>{{ task.supplierName }}</text><text>{{ task.specification }}</text></view>
    <view class="bottom"><text class="location">{{ task.location }}</text><text class="quantity">{{ task.quantity }} {{ task.unit }}</text></view>
  </view>
</template>

<style scoped>
.task { padding:28rpx; border-bottom:1rpx solid var(--wms-border); background:var(--wms-surface); }.task:last-child{border-bottom:0}.top,.bottom,.meta,.name-row{display:flex;align-items:center}.top,.bottom{justify-content:space-between}.name{font-size:31rpx;font-weight:700}.grade{margin-left:12rpx;padding:3rpx 10rpx;border-radius:8rpx;background:#eef4ff;color:var(--wms-primary-700);font-size:22rpx}.meta{gap:24rpx;margin-top:14rpx;color:var(--wms-text-secondary);font-size:24rpx}.bottom{margin-top:22rpx}.location{color:var(--wms-primary-700);font-size:27rpx;font-weight:650}.quantity{font-size:30rpx;font-weight:750}
</style>
