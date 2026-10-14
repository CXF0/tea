<script setup lang="ts">
defineProps<{ tone?: 'neutral' | 'success' | 'warning' | 'danger'; label: string }>()
</script>

<template><text :class="['status', tone || 'neutral']">{{ label }}</text></template>

<style scoped>
.status { display: inline-flex; padding: 6rpx 14rpx; border-radius: 999rpx; background: #eef1f5; color: #596273; font-size: 22rpx; line-height: 1.4; }
.success { background: #eaf7f0; color: var(--wms-success); }.warning { background: #fff5e3; color: #b66e00; }.danger { background: #ffedef; color: var(--wms-danger); }
</style>
