<script setup lang="ts">
import { computed, nextTick, onMounted, onUnmounted, ref, watch } from "vue";
import { onBackPress, onLoad } from "@dcloudio/uni-app";
import Sortable from "sortablejs";
import { sessionStore } from "@/store/session";
import {
  cardOrderStorageKey,
  dataCardsByCategory,
  dataCategoryLabels,
  normalizeCardOrder,
  type DataCardDefinition,
  type DataCategoryKey,
} from "./card-registry";

const category = ref<DataCategoryKey>("core");
const cards = ref<DataCardDefinition[]>([]);
const baseline = ref("");
const saving = ref(false);
const listElement = ref<HTMLElement | { $el?: HTMLElement } | null>(null);
let sortable: Sortable | undefined;

const dirty = computed(() => JSON.stringify(cards.value.map((card) => card.id)) !== baseline.value);
const onlyOne = computed(() => cards.value.length === 1);

function initialize() {
  const definitions = dataCardsByCategory[category.value].filter((card) =>
    category.value === "core"
      ? sessionStore.state.dataCardIds.includes(card.id)
      : category.value === "arrival" && ["arrival-volume", "self-pickup"].includes(card.id)
        ? sessionStore.state.dataCardIds.includes(card.id)
      : category.value === "distribution" && card.id === "contractor-distribution"
        ? sessionStore.state.dataCardIds.includes(card.id)
      : true,
  );
  const order = normalizeCardOrder(
    uni.getStorageSync(cardOrderStorageKey(sessionStore.state.userId, category.value)),
    definitions,
  );
  cards.value = [...definitions].sort((a, b) => order.indexOf(a.id) - order.indexOf(b.id));
  baseline.value = JSON.stringify(cards.value.map((card) => card.id));
}

async function initializeSortable() {
  await nextTick();
  const candidate = listElement.value;
  const element =
    typeof HTMLElement !== "undefined" && candidate instanceof HTMLElement
      ? candidate
      : candidate && "$el" in candidate
        ? candidate.$el
        : undefined;
  if (!element) return;
  if (sortable) {
    sortable.option("disabled", cards.value.length < 2);
    return;
  }
  sortable = Sortable.create(element, {
    animation: 160,
    delay: 220,
    delayOnTouchOnly: true,
    draggable: ".sort-row",
    forceFallback: true,
    fallbackOnBody: true,
    fallbackTolerance: 4,
    scroll: true,
    scrollSensitivity: 70,
    scrollSpeed: 14,
    ghostClass: "sortable-ghost",
    chosenClass: "sortable-chosen",
    dragClass: "sortable-drag",
    disabled: cards.value.length < 2,
    onEnd: ({ oldIndex, newIndex }) => {
      if (oldIndex === undefined || newIndex === undefined || oldIndex === newIndex) return;
      const next = [...cards.value];
      const [card] = next.splice(oldIndex, 1);
      next.splice(newIndex, 0, card);
      cards.value = next;
    },
  });
}

function save() {
  if (saving.value) return;
  saving.value = true;
  try {
    const order = cards.value.map((card) => card.id);
    uni.setStorageSync(cardOrderStorageKey(sessionStore.state.userId, category.value), order);
    baseline.value = JSON.stringify(order);
    uni.showToast({ title: "排序已保存", icon: "success" });
    setTimeout(() => uni.navigateBack(), 350);
  } catch {
    uni.showToast({ title: "保存失败，请重试", icon: "none" });
  } finally {
    saving.value = false;
  }
}

function back() {
  if (!dirty.value) return uni.navigateBack();
  uni.showModal({
    title: "是否放弃本次排序调整？",
    content: "未保存的卡片顺序不会生效。",
    cancelText: "继续调整",
    confirmText: "放弃修改",
    success: ({ confirm }) => {
      if (confirm) uni.navigateBack();
    },
  });
}

onLoad((query) => {
  const requested = String(query?.category || "core") as DataCategoryKey;
  if (requested in dataCardsByCategory) category.value = requested;
  initialize();
});
onMounted(initializeSortable);
watch(() => cards.value.length, () => initializeSortable(), { flush: "post" });
onUnmounted(() => sortable?.destroy());
onBackPress(() => {
  if (!dirty.value) return false;
  back();
  return true;
});
</script>

<template>
  <view class="page">
    <view class="nav">
      <text class="back" @click="back">‹</text>
      <b>卡片排序</b>
      <button :disabled="saving || !dirty" @click="save">保存</button>
    </view>
    <view class="context">
      <b>当前分类：{{ dataCategoryLabels[category] }}</b>
      <text>长按列表项或拖动右侧手柄调整顺序。</text>
      <small v-if="onlyOne">当前仅一张卡片，无需排序</small>
    </view>
    <view v-if="cards.length" ref="listElement" class="sort-list">
      <view v-for="card in cards" :key="card.id" class="sort-row">
        <view class="card-copy">
          <b>{{ card.title }}</b>
          <text>{{ card.description }}</text>
        </view>
        <text class="drag-handle" aria-label="拖动排序">☷</text>
      </view>
    </view>
    <view v-else class="empty">当前分类暂无可排序卡片</view>
  </view>
</template>

<style scoped lang="scss">
.page { min-height: 100vh; padding: calc(var(--status-bar-height) + 112rpx) 24rpx 50rpx; background: var(--wms-surface-page); }
.nav { position: fixed; z-index: 10; top: 0; right: 0; left: 0; display: grid; height: 92rpx; padding-top: var(--status-bar-height); grid-template-columns: 100rpx 1fr 100rpx; align-items: center; border-bottom: 1rpx solid var(--wms-border); background: #fff; }
.nav .back { padding-left: 24rpx; font-size: 52rpx; }
.nav > b { font-size: 29rpx; text-align: center; }
.nav button { height: 64rpx; margin: 0 18rpx 0 0; padding: 0; border: 0; background: transparent; color: var(--wms-primary-700); font-size: 25rpx; font-weight: 700; line-height: 64rpx; }
.nav button::after { border: 0; }
.nav button[disabled] { opacity: .38; }
.context { padding: 22rpx 20rpx; border: 1rpx solid var(--wms-border); border-radius: 12rpx; background: #fff; }
.context b, .context text, .context small { display: block; }
.context b { font-size: 26rpx; }
.context text { margin-top: 9rpx; color: var(--wms-text-secondary); font-size: 21rpx; }
.context small { margin-top: 12rpx; color: var(--wms-warning); font-size: 20rpx; }
.sort-list { display: flex; gap: 12rpx; margin-top: 16rpx; flex-direction: column; }
.sort-row { display: flex; min-height: 104rpx; align-items: center; gap: 16rpx; padding: 16rpx 18rpx 16rpx 22rpx; border: 1rpx solid var(--wms-border); border-radius: 12rpx; background: #fff; box-shadow: var(--wms-shadow-card); }
.card-copy { min-width: 0; flex: 1; }
.card-copy b, .card-copy text { display: block; }
.card-copy b { font-size: 25rpx; }
.card-copy text { margin-top: 7rpx; color: var(--wms-text-secondary); font-size: 20rpx; line-height: 1.45; }
.drag-handle { display: flex; width: 64rpx; height: 64rpx; align-items: center; justify-content: center; flex: none; color: var(--wms-text-secondary); cursor: grab; font-size: 36rpx; user-select: none; }
.sortable-chosen, .sortable-drag { border-color: var(--wms-primary-700); background: var(--wms-surface-soft); }
.sortable-ghost { border: 2rpx dashed var(--wms-primary-700); opacity: .35; }
.empty { margin-top: 16rpx; padding: 80rpx 20rpx; border-radius: 12rpx; background: #fff; color: var(--wms-text-secondary); font-size: 23rpx; text-align: center; }
</style>
