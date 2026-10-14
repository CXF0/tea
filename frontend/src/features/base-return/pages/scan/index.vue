<script setup lang="ts">
import { computed, onBeforeUnmount, ref } from "vue";
import { baseReturnApi } from "../../api/base-return.api";
import { scanner } from "@/platform/scanner";

const flash = ref<"off" | "torch">("off");
const processing = ref(false), feedback = ref<"idle" | "loading" | "success" | "error">("idle");
const message = ref(""), lastCode = ref("");
const recent = new Map<string, number>();
let resetTimer: ReturnType<typeof setTimeout> | undefined;
const prompt = computed(() => message.value || (processing.value ? "正在确认…" : "请将二维码或条码放入框内"));

function back() { uni.navigateBack(); }
function toggleFlash() { flash.value = flash.value === "off" ? "torch" : "off"; }
function show(state: typeof feedback.value, text: string) {
  feedback.value = state; message.value = text;
  if (resetTimer) clearTimeout(resetTimer);
  if (state === "success" || state === "error") resetTimer = setTimeout(() => { feedback.value = "idle"; message.value = ""; }, 1300);
}
async function processCode(raw: string) {
  const code = String(raw || "").trim();
  if (!code || processing.value) return;
  const now = Date.now();
  if (recent.has(code) && now - recent.get(code)! < 1500) return;
  recent.set(code, now); lastCode.value = code; processing.value = true; show("loading", "正在确认…");
  try {
    const data = await baseReturnApi.confirm(code);
    show("success", `${data.productName} ${data.confirmedQuantity}扎确认成功`);
    if (typeof uni.vibrateShort === "function") uni.vibrateShort({});
  } catch (e) { show("error", e instanceof Error ? e.message : "确认失败，请重新扫描"); }
  finally { setTimeout(() => { processing.value = false; }, 500); }
}
function cameraScan(event: any) { processCode(event?.detail?.result || ""); }
async function manualScan() {
  if (processing.value) return;
  try { const result = await scanner.scan(); processCode(result.value); }
  catch { show("error", "未完成补扫"); }
}
onBeforeUnmount(() => { if (resetTimer) clearTimeout(resetTimer); });
</script>

<template>
  <view class="page">
    <!-- #ifdef MP-WEIXIN -->
    <camera class="camera" mode="scanCode" device-position="back" :flash="flash" @scancode="cameraScan">
      <cover-view class="overlay">
        <cover-view class="header">
          <cover-view class="back" @click="back">‹</cover-view>
          <cover-view class="title">退货二次确认</cover-view>
          <cover-view class="actions"><cover-view @click="manualScan">补扫</cover-view><cover-view @click="toggleFlash">{{ flash === 'torch' ? '关灯' : '灯' }}</cover-view></cover-view>
        </cover-view>
        <cover-view class="frame"></cover-view>
        <cover-view class="feedback" :class="feedback"><cover-view>{{ prompt }}</cover-view><cover-view v-if="lastCode" class="code">{{ lastCode }}</cover-view></cover-view>
      </cover-view>
    </camera>
    <!-- #endif -->
    <!-- #ifndef MP-WEIXIN -->
    <view class="preview">
      <view class="header">
        <view class="back" @click="back">‹</view><view class="title">退货二次确认</view>
        <view class="actions"><view @click="manualScan">补扫</view><view @click="toggleFlash">灯</view></view>
      </view>
      <view class="frame"><text>当前环境未找到摄像头</text></view>
      <view class="feedback" :class="feedback"><text>{{ prompt }}</text><small v-if="lastCode">{{ lastCode }}</small></view>
    </view>
    <!-- #endif -->
  </view>
</template>

<style scoped>
.page,.camera,.preview{width:100vw;height:100vh;overflow:hidden;background:#444a4e}.overlay,.preview{box-sizing:border-box;padding:calc(env(safe-area-inset-top) + 24rpx) 24rpx 44rpx}.overlay{display:flex;flex-direction:column;background:#0002}.header{display:grid;grid-template-columns:66rpx minmax(0,1fr) 150rpx;align-items:center;height:66rpx;color:#fff}.back,.actions>view,.actions>cover-view{display:flex;align-items:center;justify-content:center;height:58rpx;border:1rpx solid #899398;border-radius:30rpx;background:#172126cc;color:#fff}.back{width:58rpx;font-size:47rpx;line-height:52rpx}.title{font-size:28rpx;font-weight:700}.actions{display:flex;justify-content:flex-end;gap:9rpx}.actions>view,.actions>cover-view{width:58rpx;font-size:20rpx}.frame{display:flex;align-items:center;justify-content:center;box-sizing:border-box;width:100%;height:49vh;min-height:520rpx;max-height:760rpx;margin-top:60rpx;border:4rpx solid #f4f7f7;border-radius:23rpx;color:#aeb7bb;font-size:23rpx}.feedback{margin-top:auto;padding:20rpx;border-radius:13rpx;background:#101b20ed;color:#fff;font-size:24rpx;font-weight:700;text-align:center}.feedback.success{background:#16866fee}.feedback.error{background:#c93636ee}.feedback.loading{background:#b66c14ee}.code,.feedback small{display:block;margin-top:7rpx;color:#ffffffaa;font-size:18rpx;font-weight:400}.preview{display:flex;flex-direction:column}
</style>
