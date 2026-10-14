<script setup lang="ts">
import { computed, nextTick, onMounted, onUnmounted, ref } from "vue";
import { onHide, onLoad, onShow, onUnload } from "@dcloudio/uni-app";
import Sortable from "sortablejs";
import {
  domainEntries,
  type DomainEntry,
} from "@/app/workbench/configuration-registry";
import {
  normalizeShortcutPreferences,
  saveShortcutPreferences,
  sortShortcutEntries,
  type ShortcutAttention,
  type ShortcutPreferences,
} from "@/app/workbench/shortcut-preferences";
import { sessionStore } from "@/store/session";

const allowed = computed(() =>
  domainEntries.filter((entry) => sessionStore.can(entry.capability)),
);
const preference = ref<ShortcutPreferences>({ order: [], attention: {} }),
  baseline = ref(""),
  attentionEntry = ref<DomainEntry | null>(null),
  dragging = ref(-1),
  dragTarget = ref(-1),
  saving = ref(false);
const entries = computed(() =>
  sortShortcutEntries(allowed.value, preference.value),
);
const dirty = computed(
  () => JSON.stringify(preference.value) !== baseline.value,
);
const labels: Record<ShortcutAttention, string> = {
  default: "默认",
  follow: "关注",
  high: "高度关注",
};
let mousePressTimer: ReturnType<typeof setTimeout> | undefined;
let interactionTimer: ReturnType<typeof setTimeout> | undefined;
let suppressNextClick = false;
let mouseStartX = 0;
let mouseStartY = 0;
let pendingMouseIndex = -1;
let blockAttentionUntil = 0;
const interactionReady = ref(false);
const sorting = ref(false);
const editMode = ref<"attention" | "sort">("attention");
const confirmAction = ref<"back" | "reset" | null>(null);
const gridElement = ref<HTMLElement | { $el?: HTMLElement } | null>(null);
let sortable: Sortable | undefined;

function clearTransientState() {
  clearTimeout(mousePressTimer);
  clearTimeout(interactionTimer);
  mousePressTimer = undefined;
  interactionTimer = undefined;
  attentionEntry.value = null;
  confirmAction.value = null;
  dragging.value = -1;
  dragTarget.value = -1;
  sorting.value = false;
  editMode.value = "attention";
  sortable?.option("disabled", true);
  blockAttentionUntil = Date.now() + 300;
  interactionReady.value = false;
  suppressNextClick = true;
  pendingMouseIndex = -1;
}

function armInteraction() {
  clearTransientState();
  interactionTimer = setTimeout(() => {
    interactionReady.value = true;
    suppressNextClick = false;
  }, 240);
}
function initialize() {
  preference.value = normalizeShortcutPreferences(
    sessionStore.state.userId,
    allowed.value,
  );
  baseline.value = JSON.stringify(preference.value);
}
async function initializeSortable() {
  await nextTick();
  const candidate = gridElement.value;
  const element =
    typeof HTMLElement !== "undefined" && candidate instanceof HTMLElement
      ? candidate
      : candidate && "$el" in candidate
        ? candidate.$el
        : undefined;
  if (!element || sortable) return;
  sortable = Sortable.create(element, {
    disabled: editMode.value !== "sort",
    animation: 160,
    delay: 0,
    draggable: ".entry",
    forceFallback: true,
    fallbackOnBody: true,
    fallbackTolerance: 4,
    ghostClass: "sortable-ghost",
    chosenClass: "sortable-chosen",
    dragClass: "sortable-drag",
    onStart: () => {
      sorting.value = true;
      blockAttentionUntil = Number.POSITIVE_INFINITY;
      attentionEntry.value = null;
      suppressNextClick = true;
    },
    onEnd: ({ oldIndex, newIndex }) => {
      if (oldIndex !== undefined && newIndex !== undefined) move(oldIndex, newIndex);
      attentionEntry.value = null;
      sorting.value = false;
      blockAttentionUntil = Date.now() + 500;
      suppressNextClick = true;
    },
    onUnchoose: () => {
      // Sortable also emits unchoose after an ordinary press/click. Only a
      // real drag may suppress the following click that opens the attention
      // drawer.
      if (!sorting.value) return;
      attentionEntry.value = null;
      sorting.value = false;
      blockAttentionUntil = Date.now() + 500;
    },
  });
}
function toggleSortMode() {
  attentionEntry.value = null;
  confirmAction.value = null;
  editMode.value = editMode.value === "sort" ? "attention" : "sort";
  sortable?.option("disabled", editMode.value !== "sort");
  sorting.value = false;
  suppressNextClick = false;
  blockAttentionUntil = 0;
}
function move(from: number, to: number) {
  if (from < 0 || to < 0 || from === to) return;
  const next = [...preference.value.order];
  const [id] = next.splice(from, 1);
  next.splice(to, 0, id);
  preference.value = { ...preference.value, order: next };
  dragTarget.value = to;
}
function startDrag(index: number) {
  dragging.value = index;
  dragTarget.value = index;
  uni.vibrateShort({});
}
function moveAtPoint(clientX: number, clientY: number) {
  if (dragging.value < 0 || typeof document === "undefined") return;
  const target = document
    .elementFromPoint(clientX, clientY)
    ?.closest("[data-shortcut-index]") as HTMLElement | null;
  const index = Number(target?.dataset.shortcutIndex);
  if (Number.isInteger(index) && index !== dragging.value) {
    move(dragging.value, index);
    dragging.value = index;
  }
  suppressNextClick = true;
  if (clientY < 80) window.scrollBy({ top: -24 });
  else if (clientY > window.innerHeight - 100) window.scrollBy({ top: 24 });
}
function dragMove(event: TouchEvent) {
  const touch = event.touches[0];
  moveAtPoint(touch.clientX, touch.clientY);
}
function startMousePress(index: number, event: MouseEvent) {
  if (event.button !== 0) return;
  clearTimeout(mousePressTimer);
  pendingMouseIndex = index;
  mouseStartX = event.clientX;
  mouseStartY = event.clientY;
  mousePressTimer = setTimeout(() => {
    suppressNextClick = true;
    startDrag(index);
  }, 360);
}
function markTargetAtPoint(clientX: number, clientY: number) {
  if (typeof document === "undefined") return;
  const target = document
    .elementFromPoint(clientX, clientY)
    ?.closest("[data-shortcut-index]") as HTMLElement | null;
  const index = Number(target?.dataset.shortcutIndex);
  if (Number.isInteger(index)) dragTarget.value = index;
}
function mouseDragMove(event: MouseEvent) {
  if (dragging.value >= 0) {
    event.preventDefault();
    markTargetAtPoint(event.clientX, event.clientY);
    return;
  }
  if (mousePressTimer && Math.hypot(event.clientX - mouseStartX, event.clientY - mouseStartY) > 4) {
    clearTimeout(mousePressTimer);
    mousePressTimer = undefined;
    suppressNextClick = true;
    startDrag(pendingMouseIndex);
    markTargetAtPoint(event.clientX, event.clientY);
  }
}
function endDrag() {
  clearTimeout(mousePressTimer);
  mousePressTimer = undefined;
  pendingMouseIndex = -1;
  if (dragging.value >= 0) {
    suppressNextClick = true;
    move(dragging.value, dragTarget.value);
  }
  dragging.value = -1;
  dragTarget.value = -1;
}
function bindMouseTracking() {
  if (typeof window === "undefined") return;
  unbindMouseTracking();
  window.addEventListener("mousemove", mouseDragMove, { passive: false });
  window.addEventListener("mouseup", endDrag);
}
function unbindMouseTracking() {
  if (typeof window === "undefined") return;
  window.removeEventListener("mousemove", mouseDragMove);
  window.removeEventListener("mouseup", endDrag);
}
function choose(entry: DomainEntry) {
  if (
    editMode.value !== "attention" ||
    !interactionReady.value ||
    sorting.value ||
    Date.now() < blockAttentionUntil
  )
    return;
  if (suppressNextClick) {
    suppressNextClick = false;
    return;
  }
  if (dragging.value < 0) attentionEntry.value = entry;
}
function setAttention(level: ShortcutAttention) {
  if (!attentionEntry.value) return;
  preference.value = {
    ...preference.value,
    attention: {
      ...preference.value.attention,
      [attentionEntry.value.id]: level,
    },
  };
  attentionEntry.value = null;
}
function reset() {
  attentionEntry.value = null;
  confirmAction.value = "reset";
}
function confirmDialog() {
  if (confirmAction.value === "reset") {
    preference.value = {
      order: allowed.value.map((x) => x.id),
      attention: Object.fromEntries(
        allowed.value.map((x) => [x.id, "default"]),
      ),
    };
    confirmAction.value = null;
    return;
  }
  if (confirmAction.value === "back") {
    confirmAction.value = null;
    uni.navigateBack();
  }
}
function save() {
  try {
    saving.value = true;
    saveShortcutPreferences(sessionStore.state.userId, preference.value);
    baseline.value = JSON.stringify(preference.value);
    uni.showToast({ title: "设置已保存", icon: "success" });
    setTimeout(() => uni.navigateBack(), 350);
  } catch {
    uni.showToast({ title: "保存失败，请重试", icon: "none" });
  } finally {
    saving.value = false;
  }
}
function back() {
  attentionEntry.value = null;
  if (!dirty.value) return uni.navigateBack();
  confirmAction.value = "back";
}
onLoad(() => {
  initialize();
  armInteraction();
});
onShow(() => {
  armInteraction();
});
onHide(() => {
  clearTransientState();
});
onUnload(() => {
  clearTransientState();
});
onMounted(initializeSortable);
onUnmounted(() => {
  sortable?.destroy();
  sortable = undefined;
});
</script>

<template>
  <view class="page"
    ><view class="nav"
      ><text @click="back">‹</text><b>快捷作业设置</b
      ><button :disabled="saving || !dirty" @click="save">保存</button></view
    ><view class="intro"
      ><text>{{
        editMode === "sort"
          ? "拖动入口调整顺序，完成后退出排序模式。"
          : "点击图标设置关注程度。"
      }}</text
      ><view class="intro-actions"
        ><text class="mode-switch" @click="toggleSortMode">{{
          editMode === "sort" ? "完成排序" : "排序"
        }}</text
        ><text class="reset" @click="reset">恢复默认</text></view
      ></view
    ><view
      ref="gridElement"
      class="grid"
      ><view
        v-for="(entry, index) in entries"
        :key="entry.id"
        :data-shortcut-index="index"
        :class="[
          'entry',
          {
            'sort-mode': editMode === 'sort',
            dragging: dragging === index,
            target: dragTarget === index,
          },
        ]"
        ><view
          :class="[
            'icon-surface',
            `attention-${preference.attention[entry.id] || 'default'}`,
          ]"
          @click.stop="choose(entry)"
          ><image :src="entry.icon" /><text v-if="editMode === 'sort'" class="drag-handle">⋮⋮</text></view
        ><text class="name">{{ entry.title }}</text
        ><small>{{
          labels[preference.attention[entry.id] || "default"]
        }}</small></view
      ></view
    ><view v-if="attentionEntry && interactionReady" class="mask" @click="attentionEntry = null"
      ><view class="drawer" @click.stop
        ><view class="drawer-head"
          ><view
            :class="[
              'icon-surface',
              `attention-${preference.attention[attentionEntry.id] || 'default'}`,
            ]"
            ><image :src="attentionEntry.icon" /></view
          ><view
            ><b>关注程度</b><text>{{ attentionEntry.title }}</text></view
          ><text class="close" @click="attentionEntry = null">关闭</text></view
        ><view
          v-for="level in ['default', 'follow', 'high'] as ShortcutAttention[]"
          :key="level"
          class="level"
          @click="setAttention(level)"
          ><view :class="['sample', `attention-${level}`]"
            ><image :src="attentionEntry.icon" /></view
          ><view
            ><b>{{ labels[level] }}</b
            ><text>{{
              level === "default"
                ? "日常入口"
                : level === "follow"
                  ? "需要持续关注"
                  : "近期优先关注"
            }}</text></view
          ><text class="radio">{{
            preference.attention[attentionEntry.id] === level ? "●" : "○"
          }}</text></view
        ><text class="note"
          >关注程度仅为个人标记，不代表业务异常或系统告警。</text
      ></view
    ></view
    ><view v-if="confirmAction" class="confirm-mask" @click="confirmAction = null"
      ><view class="confirm-dialog" @click.stop
        ><b>{{ confirmAction === "back" ? "是否放弃本次修改？" : "恢复默认" }}</b
        ><text>{{
          confirmAction === "back"
            ? "尚未保存的排序和关注程度将不会生效。"
            : "恢复默认顺序，并将所有快捷入口设为默认关注程度？"
        }}</text
        ><view class="confirm-actions"
          ><button @click="confirmAction = null">{{
            confirmAction === "back" ? "继续编辑" : "取消"
          }}</button
          ><button class="primary" @click="confirmDialog">{{
            confirmAction === "back" ? "放弃修改" : "恢复默认"
          }}</button></view
        ></view
      ></view
    ></view
  >
</template>

<style scoped lang="scss">
.page {
  box-sizing: border-box;
  min-height: 100vh;
  padding: calc(var(--status-bar-height) + 92rpx) 24rpx 60rpx;
  background: var(--wms-surface-page);
}
.nav {
  position: fixed;
  z-index: 10;
  top: 0;
  right: 0;
  left: 0;
  display: grid;
  height: 92rpx;
  padding-top: var(--status-bar-height);
  grid-template-columns: 100rpx 1fr 100rpx;
  align-items: center;
  border-bottom: 1rpx solid var(--wms-border);
  background: #fff;
}
.nav > text {
  padding-left: 24rpx;
  font-size: 52rpx;
}
.nav > b {
  font-size: 29rpx;
  text-align: center;
}
.nav button {
  height: 64rpx;
  margin: 0 18rpx 0 0;
  padding: 0;
  border: 0;
  background: transparent;
  color: var(--wms-primary-700);
  font-size: 25rpx;
  font-weight: 700;
  line-height: 64rpx;
}
.nav button:after {
  border: 0;
}
.nav button[disabled] {
  opacity: 0.38;
}
.intro {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 20rpx 2rpx;
  color: var(--wms-text-secondary);
  font-size: 22rpx;
}
.intro > text:first-child {
  max-width: 520rpx;
}
.intro .reset {
  flex: none;
  color: var(--wms-primary-700);
}
.intro-actions {
  display: flex;
  flex: none;
  align-items: center;
  gap: 22rpx;
}
.intro .mode-switch {
  padding: 8rpx 14rpx;
  border: 1rpx solid var(--wms-primary-700);
  border-radius: 9rpx;
  color: var(--wms-primary-700);
}
.grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 18rpx 8rpx;
  padding: 24rpx 12rpx;
  border-radius: var(--wms-radius-card);
  background: #fff;
  box-shadow: var(--wms-shadow-card);
}
.entry {
  display: flex;
  min-width: 0;
  align-items: center;
  padding: 6rpx 0;
  flex-direction: column;
  border: 2rpx solid transparent;
  border-radius: 12rpx;
  transition: transform 0.12s;
  user-select: none;
  cursor: pointer;
}
.entry.sort-mode {
  cursor: grab;
}
.entry.dragging {
  z-index: 2;
  border-color: var(--wms-primary-700);
  background: var(--wms-surface-page);
  opacity: 0.78;
  transform: scale(1.06);
  cursor: grabbing;
}
.entry.target {
  box-shadow: inset 0 0 0 2rpx var(--wms-primary-700);
}
.sortable-chosen,
.sortable-drag {
  border-color: var(--wms-primary-700);
  background: var(--wms-surface-page);
  cursor: grabbing;
}
.sortable-ghost {
  border: 2rpx dashed var(--wms-primary-700);
  opacity: 0.35;
}
.icon-surface,
.sample {
  position: relative;
  display: flex;
  width: 76rpx;
  height: 76rpx;
  align-items: center;
  justify-content: center;
  border-radius: 18rpx;
  background: var(--wms-surface-soft);
}
.icon-surface image,
.sample image {
  width: 44rpx;
  height: 44rpx;
}
.attention-follow {
  background: color-mix(in srgb, var(--wms-warning) 14%, white);
}
.attention-high {
  background: color-mix(in srgb, var(--wms-danger) 13%, white);
}
.drag-handle {
  position: absolute;
  right: -3rpx;
  top: -9rpx;
  color: var(--wms-text-secondary);
  font-size: 18rpx;
  letter-spacing: -3rpx;
}
.name {
  max-width: 100%;
  margin-top: 9rpx;
  overflow: hidden;
  font-size: 22rpx;
  white-space: nowrap;
  text-overflow: ellipsis;
}
.entry small {
  margin-top: 3rpx;
  color: var(--wms-text-secondary);
  font-size: 18rpx;
}
.mask {
  position: fixed;
  z-index: 30;
  inset: 0;
  background: rgba(23, 43, 41, 0.45);
}
.confirm-mask {
  position: fixed;
  z-index: 40;
  inset: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 36rpx;
  background: rgba(23, 43, 41, 0.45);
}
.confirm-dialog {
  box-sizing: border-box;
  width: 100%;
  max-width: 620rpx;
  padding: 30rpx 28rpx 24rpx;
  border-radius: 22rpx;
  background: #fff;
}
.confirm-dialog > b,
.confirm-dialog > text {
  display: block;
}
.confirm-dialog > b {
  color: var(--wms-text);
  font-size: 29rpx;
}
.confirm-dialog > text {
  margin-top: 14rpx;
  color: var(--wms-text-secondary);
  font-size: 22rpx;
  line-height: 1.5;
}
.confirm-actions {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 14rpx;
  margin-top: 28rpx;
}
.confirm-actions button {
  height: 70rpx;
  margin: 0;
  border: 1rpx solid var(--wms-border);
  border-radius: 12rpx;
  background: #fff;
  color: var(--wms-text);
  font-size: 22rpx;
  line-height: 68rpx;
}
.confirm-actions button:after {
  border: 0;
}
.confirm-actions .primary {
  border-color: var(--wms-primary-700);
  background: var(--wms-primary-700);
  color: #fff;
}
.drawer {
  position: absolute;
  right: 0;
  bottom: 0;
  left: 0;
  box-sizing: border-box;
  min-height: 560rpx;
  padding: 28rpx 24rpx calc(30rpx + env(safe-area-inset-bottom));
  border-radius: 26rpx 26rpx 0 0;
  background: #fff;
}
.drawer-head {
  display: flex;
  align-items: center;
  gap: 18rpx;
  padding-bottom: 22rpx;
  border-bottom: 1rpx solid var(--wms-border);
}
.drawer-head > view:nth-child(2) {
  flex: 1;
}
.drawer-head b,
.drawer-head text {
  display: block;
}
.drawer-head b {
  font-size: 29rpx;
}
.drawer-head text {
  margin-top: 5rpx;
  color: var(--wms-text-secondary);
  font-size: 22rpx;
}
.drawer-head .close {
  flex: none;
  color: var(--wms-primary-700);
  font-size: 23rpx;
}
.level {
  display: flex;
  min-height: 104rpx;
  align-items: center;
  gap: 18rpx;
  border-bottom: 1rpx solid var(--wms-border);
}
.sample {
  width: 68rpx;
  height: 68rpx;
}
.sample image {
  width: 40rpx;
  height: 40rpx;
}
.level > view:nth-child(2) {
  flex: 1;
}
.level b,
.level text {
  display: block;
}
.level b {
  font-size: 25rpx;
}
.level text {
  margin-top: 4rpx;
  color: var(--wms-text-secondary);
  font-size: 20rpx;
}
.radio {
  color: var(--wms-primary-700);
  font-size: 30rpx;
}
.note {
  display: block;
  margin-top: 20rpx;
  color: var(--wms-text-secondary);
  font-size: 20rpx;
  line-height: 1.5;
}
</style>
