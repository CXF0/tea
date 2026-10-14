<script setup lang="ts">
import WareState from '@/shared/components/WareState.vue'
import { sessionStore } from '@/store/session'
</script>

<template>
  <view class="page">
    <WareState v-if="!sessionStore.can('staff.manage')" type="forbidden" title="暂无人员管理权限" description="请联系管理员为当前账户开通 staff.manage 能力" />
    <template v-else>
      <view class="heading"><text class="title">人员管理</text><text class="caption">人员能力与作业分配</text></view>
      <WareState type="empty" title="暂无人员数据" description="人员接口接入后将在这里按能力展示可管理人员" />
    </template>
  </view>
</template>

<style scoped>.page{padding:28rpx 24rpx}.heading{padding:28rpx;border-radius:24rpx;background:#fff}.title,.caption{display:block}.title{font-size:36rpx;font-weight:750}.caption{margin-top:10rpx;color:var(--wms-text-secondary);font-size:24rpx}</style>
