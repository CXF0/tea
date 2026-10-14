<script setup lang="ts">
import { computed, ref } from 'vue'
import { onLoad } from '@dcloudio/uni-app'
import { scanOperations } from '@/app/workbench/configuration-registry'
import { scanner } from '@/platform/scanner'
import { parseScanCode } from '@/platform/scanner/parser'
import type { ScanOperationId } from '@/platform/scanner/types'
import { sessionStore } from '@/store/session'

const operationId = ref<ScanOperationId>('quality-inspection')
const date = ref(new Date().toISOString().slice(0, 10))
const scanning = ref(false)
const error = ref('')
const lastCode = ref('')
const selectorVisible = ref(false)

const availableOperations = computed(() => {
  const configured = new Set(sessionStore.state.scanOperationIds)
  return scanOperations.filter(item => configured.has(item.id) && sessionStore.can(item.capability))
})
const operation = computed(() => availableOperations.value.find(item => item.id === operationId.value))

function selectOperation(id: string) {
  operationId.value = id as ScanOperationId
  selectorVisible.value = false
  error.value = ''
  lastCode.value = ''
}

function route(raw: string) {
  const parsed = parseScanCode(raw, operationId.value)
  const encodedRaw = encodeURIComponent(parsed.raw)
  const encodedValue = encodeURIComponent(parsed.value)
  const encodedDate = encodeURIComponent(date.value)
  const routes: Partial<Record<ScanOperationId, string>> = {
    'admission-checkin': `/features/admission/pages/home/index?date=${encodedDate}&supplierId=${parsed.id || encodedValue}&fromScan=1`,
    'quality-inspection': `/features/quality/pages/shelf-inspection/index?id=${parsed.id || encodedValue}&fromScan=1`,
    'quality-video': `/features/quality/pages/video-submit/index?date=${encodedDate}&content=${encodedRaw}`,
    'distribution-shelf': `/features/distribution/pages/shelf-detail/index?date=${encodedDate}&shelf=${encodedValue}`,
    'packing-shelf': `/features/packing/pages/task-detail/index?date=${encodedDate}&shelfSn=${parsed.id || encodedValue}`,
    'logistics-shelf': `/features/logistics/pages/shelf-detail/index?date=${encodedDate}&shelfSn=${parsed.id || encodedValue}`,
  }
  const url = routes[operationId.value]
  if (!url) throw new Error('当前扫码作业暂不支持该二维码')
  uni.navigateTo({ url })
}

function openDedicatedScanner() {
  if (operationId.value === 'base-return-confirm') {
    uni.navigateTo({ url: '/features/base-return/pages/scan/index' })
    return true
  }
  if (operationId.value === 'cold-storage-bare') {
    uni.navigateTo({ url: `/features/cold-storage/pages/bare-register/index?date=${encodeURIComponent(date.value)}` })
    return true
  }
  return false
}

async function recognize(source: 'camera' | 'image') {
  if (scanning.value || !operation.value) return
  if (openDedicatedScanner()) return
  scanning.value = true
  error.value = ''
  try {
    const result = source === 'image' ? await scanner.scanImage() : await scanner.scan()
    lastCode.value = result.value
    route(result.value)
  } catch (reason) {
    const message = reason instanceof Error ? reason.message : '扫码失败'
    if (!/cancel|取消/i.test(message)) error.value = message
  } finally {
    scanning.value = false
  }
}

onLoad(query => {
  date.value = String(query?.date || date.value)
  const requested = String(query?.operation || '')
  const selected = availableOperations.value.find(item => item.id === requested) || availableOperations.value[0]
  if (selected) operationId.value = selected.id as ScanOperationId
})
</script>

<template>
  <view class="page">
    <button class="operation-trigger" :disabled="availableOperations.length < 2" @click="selectorVisible = true">
      <view><text>当前作业</text><strong>{{ operation?.title || '暂无扫码能力' }}</strong></view>
      <text v-if="availableOperations.length > 1" class="switch-text">切换⌄</text>
    </button>

    <view class="hero">
      <image src="/static/icons/wms/fwms-scan-outline.svg" />
      <strong>{{ operation?.title || '扫码作业' }}</strong>
      <text>{{ operation?.description || '当前账户没有可用的扫码能力' }}</text>
    </view>
    <view class="scope"><text>当前场次</text><strong>{{ date }}</strong></view>
    <view v-if="error" class="feedback error">
      <strong>无法识别</strong><text>{{ error }}</text><small v-if="lastCode">{{ lastCode }}</small>
    </view>
    <view v-else class="feedback">
      <strong>{{ scanning ? '正在识别二维码' : '请选择扫码方式' }}</strong>
      <text>识别后将进入对应业务页面，最终处理结果以业务页面提交为准。</text>
    </view>

    <view class="actions">
      <button class="primary" :disabled="scanning || !operation" @click="recognize('camera')">
        {{ scanning ? '识别中…' : '相机扫码' }}
      </button>
      <!-- #ifdef H5 -->
      <button class="secondary" :disabled="scanning || !operation" @click="recognize('image')">选择二维码图片</button>
      <!-- #endif -->
    </view>

    <view v-if="selectorVisible" class="mask" @click="selectorVisible = false" />
    <view v-if="selectorVisible" class="sheet">
      <view class="sheet-head"><strong>切换扫码作业</strong><text @click="selectorVisible = false">关闭</text></view>
      <view class="operation-grid">
        <button v-for="item in availableOperations" :key="item.id" :class="{ active: item.id === operationId }" @click="selectOperation(item.id)">
          <strong>{{ item.title }}</strong><text>{{ item.description }}</text>
        </button>
      </view>
    </view>
  </view>
</template>

<style scoped>
.page{min-height:100vh;padding:24rpx;background:var(--wms-background);box-sizing:border-box}.operation-trigger{display:flex;align-items:center;justify-content:space-between;width:100%;height:auto;margin:0 0 16rpx;padding:18rpx 22rpx;border:0;border-radius:14rpx;background:#fff;text-align:left;line-height:1.35}.operation-trigger:after,.actions button:after,.operation-grid button:after{border:0}.operation-trigger view{display:flex;align-items:center;gap:18rpx}.operation-trigger text{color:var(--wms-text-secondary);font-size:22rpx}.operation-trigger strong{font-size:25rpx}.operation-trigger .switch-text{color:var(--wms-primary-700)}.hero{display:flex;align-items:center;flex-direction:column;padding:38rpx 24rpx;border-radius:20rpx;background:#fff}.hero image{width:76rpx;height:76rpx}.hero strong{margin-top:18rpx;font-size:31rpx}.hero text{margin-top:9rpx;color:var(--wms-text-secondary);font-size:22rpx}.scope{display:flex;align-items:center;justify-content:space-between;margin-top:16rpx;padding:22rpx;border-radius:14rpx;background:#fff;font-size:23rpx}.feedback{min-height:150rpx;margin-top:16rpx;padding:24rpx;border:1rpx solid var(--wms-border);border-radius:16rpx;background:#fff;box-sizing:border-box}.feedback strong,.feedback text,.feedback small{display:block}.feedback strong{font-size:25rpx}.feedback text{margin-top:13rpx;color:var(--wms-text-secondary);font-size:21rpx;line-height:1.6}.feedback small{margin-top:15rpx;word-break:break-all;color:var(--wms-text-secondary);font-size:18rpx}.feedback.error{border-color:var(--wms-danger)}.feedback.error strong{color:var(--wms-danger)}.actions{display:flex;gap:14rpx;margin-top:22rpx}.actions button{height:82rpx;margin:0;border:1rpx solid var(--wms-primary-700);border-radius:14rpx;font-size:24rpx;font-weight:700;line-height:80rpx}.actions .primary{flex:1;background:var(--wms-primary-700);color:#fff}.actions .secondary{flex:1;background:#fff;color:var(--wms-primary-700)}.actions button[disabled]{opacity:.55}.mask{position:fixed;z-index:20;inset:0;background:rgba(0,0,0,.42)}.sheet{position:fixed;z-index:21;right:0;bottom:0;left:0;max-height:72vh;padding:28rpx 24rpx 40rpx;border-radius:24rpx 24rpx 0 0;background:#fff;box-sizing:border-box;overflow-y:auto}.sheet-head{display:flex;align-items:center;justify-content:space-between;margin-bottom:22rpx}.sheet-head strong{font-size:28rpx}.sheet-head text{color:var(--wms-primary-700);font-size:23rpx}.operation-grid{display:grid;grid-template-columns:1fr 1fr;gap:14rpx}.operation-grid button{height:auto;min-height:116rpx;margin:0;padding:18rpx;border:1rpx solid var(--wms-border);border-radius:10rpx;background:var(--wms-background);text-align:left;line-height:1.35}.operation-grid button.active{border-color:var(--wms-primary-700);background:var(--wms-primary-50)}.operation-grid strong,.operation-grid text{display:block}.operation-grid strong{font-size:24rpx}.operation-grid text{margin-top:8rpx;color:var(--wms-text-secondary);font-size:19rpx}
</style>
