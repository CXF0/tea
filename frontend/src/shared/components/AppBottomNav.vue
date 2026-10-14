<script setup lang="ts">
import { onMounted, onUnmounted, ref } from "vue";
import { messagesApi } from "@/features/messages/api/messages.api";
import { sessionStore } from "@/store/session";

type NavKey = "workbench" | "data" | "messages" | "mine";

const props = defineProps<{ active: NavKey }>();
const unreadCount = ref(0);

const items: Array<{ key: NavKey; label: string; path: string; icon: string }> = [
  { key: "workbench", label: "工作台", path: "/workbenches/home/index", icon: "/static/icons/wms/fwms-workbench-outline.svg" },
  { key: "data", label: "数据中心", path: "/pages/data-center/index", icon: "/static/icons/wms/fwms-task-outline.svg" },
  { key: "messages", label: "消息", path: "/pages/messages/index", icon: "/static/icons/wms/fwms-message-outline.svg" },
  { key: "mine", label: "我的", path: "/pages/mine/index", icon: "/static/icons/wms/fwms-account-outline.svg" },
];

function navigate(key: NavKey, path: string) {
  if (key !== props.active) uni.redirectTo({ url: path });
}

async function loadUnreadCount() {
  if (!sessionStore.state.token) {
    unreadCount.value = 0;
    return;
  }
  try {
    const result = await messagesApi.unreadCount();
    unreadCount.value = Number(result.count || 0);
  } catch {
    unreadCount.value = 0;
  }
}

onMounted(() => {
  loadUnreadCount();
  uni.$on("messages:unread-change", loadUnreadCount);
});

onUnmounted(() => {
  uni.$off("messages:unread-change", loadUnreadCount);
});
</script>

<template>
  <view class="bottom-nav">
    <view
      v-for="item in items"
      :key="item.key"
      :class="{ active: active === item.key }"
      class="nav-item"
      @click="navigate(item.key, item.path)"
    >
      <view class="icon-wrap">
        <image :src="item.icon" />
        <text v-if="item.key === 'messages' && unreadCount > 0" class="badge">
          {{ unreadCount > 99 ? "99+" : unreadCount }}
        </text>
      </view>
      <text>{{ item.label }}</text>
    </view>
  </view>
</template>

<style scoped>
.bottom-nav {
  position: fixed;
  right: 0;
  bottom: 0;
  left: 0;
  z-index: 10;
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  padding: 16rpx 12rpx calc(16rpx + env(safe-area-inset-bottom));
  border-top: 1rpx solid var(--wms-border);
  background: rgba(255, 255, 255, 0.97);
}
.nav-item {
  display: flex;
  align-items: center;
  gap: 4rpx;
  flex-direction: column;
  color: #788589;
  font-size: 21rpx;
}
.icon-wrap {
  position: relative;
  width: 42rpx;
  height: 42rpx;
}
.icon-wrap image {
  width: 40rpx;
  height: 40rpx;
  opacity: 0.58;
}
.badge {
  position: absolute;
  top: -8rpx;
  right: -30rpx;
  min-width: 28rpx;
  height: 28rpx;
  padding: 0 8rpx;
  border: 3rpx solid #fff;
  border-radius: 999rpx;
  background: var(--wms-danger);
  color: #fff;
  font-size: 17rpx;
  font-weight: 800;
  line-height: 28rpx;
  text-align: center;
}
.bottom-nav .active {
  color: var(--wms-primary-700);
  font-weight: 700;
}
.bottom-nav .active image {
  opacity: 1;
  filter: brightness(0) saturate(100%) invert(36%) sepia(31%) saturate(1216%) hue-rotate(126deg) brightness(91%) contrast(94%);
}
</style>
