<script setup lang="ts">
withDefaults(defineProps<{ phone?: string | null; compact?: boolean }>(), { phone: "", compact: false });
function call(phone?: string | null) {
  const phoneNumber = String(phone || "").replace(/[^\d+]/g, "");
  if (!phoneNumber) return;
  // #ifdef H5
  window.location.href = `tel:${phoneNumber}`;
  // #endif
  // #ifndef H5
  uni.makePhoneCall({ phoneNumber, fail: () => uni.showToast({ title: "无法唤起拨号，请稍后重试", icon: "none" }) });
  // #endif
}
</script>
<template><text v-if="phone" :class="['ware-phone-link',{compact}]" @click.stop="call(phone)"><svg class="phone-icon" viewBox="0 0 24 24" aria-hidden="true"><path d="M7.2 3.5 4.8 4.8c-.8.4-1.2 1.3-1 2.2 1.4 6.5 6.5 11.6 13 13 .9.2 1.8-.2 2.2-1l1.3-2.4-4.6-2.1-1.2 2a14.2 14.2 0 0 1-7-7l2-1.2-2.3-4.8Z"/></svg><text>{{phone}}</text></text></template>
<style scoped>.ware-phone-link{display:inline-flex;min-height:44rpx;align-items:center;gap:6rpx;color:var(--wms-primary-700);font-size:var(--wms-font-list-meta);font-weight:500;line-height:1;white-space:nowrap}.ware-phone-link.compact{min-height:34rpx;font-size:var(--wms-font-list-caption)}.phone-icon{width:23rpx;height:23rpx;flex:none;fill:none;stroke:currentColor;stroke-width:1.8;stroke-linecap:round;stroke-linejoin:round}</style>
