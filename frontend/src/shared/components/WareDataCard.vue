<script setup lang="ts">
defineProps<{ title: string; value: string | number; caption: string }>()
</script>

<template><view class="data-card"><text class="title">{{ title }}</text><text class="value">{{ value }}</text><text class="caption">{{ caption }}</text></view></template>

<style scoped>.data-card{min-height:210rpx;padding:28rpx;border-radius:var(--wms-radius-card);background:#fff;box-shadow:var(--wms-shadow-card)}.title,.value,.caption{display:block}.title{font-size:27rpx;font-weight:700}.value{margin-top:24rpx;font-size:48rpx;font-weight:800;font-variant-numeric:tabular-nums}.caption{margin-top:10rpx;color:var(--wms-text-secondary);font-size:22rpx;line-height:1.45}</style>
