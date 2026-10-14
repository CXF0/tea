<script setup lang="ts">
import AppBottomNav from "@/shared/components/AppBottomNav.vue";
import { sessionStore } from "@/store/session";

const items = [
  { label: "账号与密码" },
  { label: "换绑手机号" },
  { label: "我的钱包" },
  { label: "我的处罚", path: "/pages/mine/punishments" },
];

function open(item: { label: string; path?: string }) {
  if (item.path) uni.navigateTo({ url: item.path });
}

function logout() {
  uni.showModal({
    title: "退出登录",
    content: "确定退出当前账号吗？",
    success: (result) => {
      if (!result.confirm) return;
      sessionStore.logout();
      uni.reLaunch({ url: "/pages/login/index" });
    },
  });
}
</script>

<template>
  <view class="page">
    <view class="profile">
      <view class="avatar">{{ sessionStore.state.userName.slice(0, 1) }}</view>
      <view>
        <text class="name">{{ sessionStore.state.userName }}</text>
        <text class="meta">{{ sessionStore.state.roleName }} · {{ sessionStore.state.warehouseName }}</text>
      </view>
    </view>
    <view class="menu">
      <view v-for="item in items" :key="item.label" class="menu-item" @click="open(item)">
        <text>{{ item.label }}</text>
        <text class="arrow">›</text>
      </view>
    </view>
    <button class="logout" @click="logout">退出登录</button>
    <AppBottomNav active="mine" />
  </view>
</template>

<style scoped>
.page {
  min-height: 100vh;
  padding: 34rpx 28rpx 180rpx;
  background: var(--wms-surface-page);
}
.profile {
  display: flex;
  align-items: center;
  gap: 22rpx;
  padding: 30rpx;
  border-radius: var(--wms-radius-card);
  background: #fff;
}
.avatar {
  display: flex;
  width: 90rpx;
  height: 90rpx;
  align-items: center;
  justify-content: center;
  border-radius: 50%;
  background: var(--wms-surface-soft);
  color: var(--wms-primary-700);
  font-size: 36rpx;
  font-weight: 800;
}
.name,
.meta {
  display: block;
}
.name {
  font-size: 34rpx;
  font-weight: 800;
}
.meta {
  margin-top: 8rpx;
  color: var(--wms-text-secondary);
  font-size: 23rpx;
}
.menu {
  margin-top: 24rpx;
  padding: 0 28rpx;
  border-radius: var(--wms-radius-card);
  background: #fff;
}
.menu-item {
  display: flex;
  height: 98rpx;
  align-items: center;
  justify-content: space-between;
  border-bottom: 1rpx solid var(--wms-border);
  font-size: 28rpx;
}
.menu-item:last-child {
  border: 0;
}
.arrow {
  color: var(--wms-text-secondary);
  font-size: 38rpx;
}
.logout {
  height: 92rpx;
  margin-top: 28rpx;
  border-radius: var(--wms-radius-card);
  background: #fff;
  color: var(--wms-danger);
  font-size: 28rpx;
  line-height: 92rpx;
}
</style>
