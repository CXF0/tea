<script setup lang="ts">
import { computed, ref } from "vue";
import { onLoad, onPullDownRefresh } from "@dcloudio/uni-app";
import AppBottomNav from "@/shared/components/AppBottomNav.vue";
import WareState from "@/shared/components/WareState.vue";
import { messagesApi, type MessageItem } from "@/features/messages/api/messages.api";

type ReadFilter = "all" | "unread" | "read";

const messages = ref<MessageItem[]>([]);
const loading = ref(true);
const error = ref("");
const readFilter = ref<ReadFilter>("all");

const filterTabs: Array<{ label: string; value: ReadFilter }> = [
  { label: "全部", value: "all" },
  { label: "未读", value: "unread" },
  { label: "已读", value: "read" },
];

const unreadTotal = computed(() => messages.value.filter((item) => !item.isRead).length);
const filteredMessages = computed(() => {
  if (readFilter.value === "unread") return messages.value.filter((item) => !item.isRead);
  if (readFilter.value === "read") return messages.value.filter((item) => item.isRead);
  return messages.value;
});

function messageClass(type: number) {
  if (type === 22) return "cancel";
  if (type === 23) return "success";
  return "warn";
}

async function load() {
  loading.value = true;
  error.value = "";
  try {
    messages.value = await messagesApi.list();
  } catch (e) {
    error.value = e instanceof Error ? e.message : "消息加载失败";
  } finally {
    loading.value = false;
    uni.stopPullDownRefresh();
  }
}

async function markAsRead(item: MessageItem) {
  if (item.isRead) return;
  item.isRead = true;
  try {
    await messagesApi.markRead(item.id);
    uni.$emit("messages:unread-change");
  } catch {
    item.isRead = false;
    uni.showToast({ title: "标记已读失败", icon: "none" });
  }
}

async function openMessage(item: MessageItem) {
  await markAsRead(item);
  uni.showModal({
    title: item.title,
    content: item.content,
    showCancel: item.bizType === 21,
    cancelText: "知道了",
    confirmText: item.bizType === 21 ? "查看处罚" : "知道了",
    success: (result) => {
      if (item.bizType === 21 && result.confirm) {
        uni.navigateTo({ url: "/pages/mine/punishments" });
      }
    },
  });
}

onLoad(load);
onPullDownRefresh(load);
</script>

<template>
  <view class="page">
    <view class="head">
      <view>
        <text class="title">消息中心</text>
        <text class="caption">点击未读消息后自动变为已读</text>
      </view>
      <text v-if="unreadTotal > 0" class="unread-count">{{ unreadTotal }} 条未读</text>
    </view>

    <view class="tabs">
      <text
        v-for="tab in filterTabs"
        :key="tab.value"
        :class="{ active: readFilter === tab.value }"
        @click="readFilter = tab.value"
      >
        {{ tab.label }}
      </text>
    </view>

    <WareState v-if="loading" type="loading" title="正在加载消息" />
    <WareState
      v-else-if="error"
      type="error"
      title="消息加载失败"
      :description="error"
      action-label="重新加载"
      @action="load"
    />
    <view v-else-if="filteredMessages.length" class="message-list">
      <view
        v-for="item in filteredMessages"
        :key="item.id"
        :class="['message-card', { unread: !item.isRead }]"
        @click="openMessage(item)"
      >
        <view class="message-top">
          <view class="tag-wrap">
            <text v-if="!item.isRead" class="dot" />
            <text :class="['tag', messageClass(item.type)]">{{ item.typeLabel }}</text>
            <text :class="['read-state', { unread: !item.isRead }]">
              {{ item.isRead ? "已读" : "未读" }}
            </text>
          </view>
          <text>{{ item.createTime.slice(5, 16) }}</text>
        </view>
        <text class="message-title">{{ item.title }}</text>
        <text class="message-content">{{ item.content }}</text>
        <view class="message-foot">
          <text v-if="item.creatorName" class="message-source">发起人：{{ item.creatorName }}</text>
          <text v-if="!item.isRead" class="read-action" @click.stop="markAsRead(item)">标为已读</text>
        </view>
      </view>
    </view>
    <WareState
      v-else
      type="empty"
      :title="readFilter === 'unread' ? '暂无未读消息' : readFilter === 'read' ? '暂无已读消息' : '暂无消息'"
      description="有新的业务通知后会在这里展示"
    />
    <AppBottomNav active="messages" />
  </view>
</template>

<style scoped lang="scss">
.page {
  min-height: 100vh;
  padding: 34rpx 28rpx 180rpx;
  background: var(--wms-surface-page);
}
.head {
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  gap: 16rpx;
  margin-bottom: 18rpx;
}
.title,
.caption,
.message-title,
.message-content,
.message-source {
  display: block;
}
.title {
  color: var(--wms-text-main);
  font-size: 42rpx;
  font-weight: 800;
}
.caption {
  margin-top: 8rpx;
  color: var(--wms-text-secondary);
  font-size: 24rpx;
}
.unread-count {
  flex: 0 0 auto;
  margin-top: 6rpx;
  padding: 8rpx 14rpx;
  border-radius: 999rpx;
  background: #fff3f3;
  color: var(--wms-danger);
  font-size: 21rpx;
  font-weight: 700;
}
.tabs {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 10rpx;
  margin-bottom: 18rpx;
  padding: 8rpx;
  border: 1rpx solid var(--wms-border);
  border-radius: 14rpx;
  background: #fff;
}
.tabs text {
  height: 58rpx;
  border-radius: 10rpx;
  color: var(--wms-text-secondary);
  font-size: 24rpx;
  line-height: 58rpx;
  text-align: center;
}
.tabs .active {
  background: var(--wms-primary-700);
  color: #fff;
  font-weight: 800;
}
.message-list {
  display: grid;
  gap: 16rpx;
}
.message-card {
  padding: 24rpx;
  border: 1rpx solid var(--wms-border);
  border-radius: var(--wms-radius-card);
  background: #fff;
  box-shadow: var(--wms-shadow-card);
}
.message-card.unread {
  border-color: rgba(10, 128, 113, 0.32);
  background: #fbfffe;
}
.message-top {
  display: flex;
  align-items: center;
  justify-content: space-between;
  color: var(--wms-text-secondary);
  font-size: 21rpx;
}
.tag-wrap {
  display: flex;
  align-items: center;
  gap: 8rpx;
}
.dot {
  width: 13rpx;
  height: 13rpx;
  border-radius: 50%;
  background: var(--wms-danger);
}
.tag,
.read-state {
  padding: 5rpx 12rpx;
  border-radius: 999rpx;
  font-size: 20rpx;
  font-weight: 700;
}
.tag.warn {
  background: #fff4df;
  color: #a15d00;
}
.tag.cancel {
  background: var(--wms-surface-soft);
  color: var(--wms-primary-700);
}
.tag.success {
  background: #e4f6ee;
  color: var(--wms-success);
}
.read-state {
  background: #eef2f2;
  color: var(--wms-text-secondary);
}
.read-state.unread {
  background: #fff3f3;
  color: var(--wms-danger);
}
.message-title {
  margin-top: 18rpx;
  color: var(--wms-text-main);
  font-size: 29rpx;
  font-weight: 800;
}
.message-content {
  margin-top: 10rpx;
  color: var(--wms-text-secondary);
  font-size: 24rpx;
  line-height: 1.55;
}
.message-foot {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 16rpx;
  margin-top: 14rpx;
}
.message-source {
  color: var(--wms-text-secondary);
  font-size: 21rpx;
}
.read-action {
  flex: 0 0 auto;
  color: var(--wms-primary-700);
  font-size: 22rpx;
  font-weight: 700;
}
</style>
