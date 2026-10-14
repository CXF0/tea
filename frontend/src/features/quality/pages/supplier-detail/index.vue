<script setup lang="ts">
import { computed, ref } from 'vue'
import { onLoad, onPullDownRefresh, onShow } from '@dcloudio/uni-app'
import { admissionApi } from '@/features/admission/api/admission.api'
import { qualityApi } from '../../api/quality.api'
import type { SupplierFlowerItem } from '../../models/quality'
import WareState from '@/shared/components/WareState.vue'
import WareStatus from '@/shared/components/WareStatus.vue'
import { sessionStore } from '@/store/session'

interface SupplierContext { id: number; supplierName: string; phone: string; status: 0 | 1; session: string }
const supplier = ref<SupplierContext | null>(null)
const items = ref<SupplierFlowerItem[]>([])
const loading = ref(true)
const error = ref('')
const issueCount = computed(() => items.value.filter(item => item.qualityStatus === 10).length)

async function load() {
  if (!supplier.value) return
  loading.value = true; error.value = ''
  try { items.value = await qualityApi.getSupplierItems(supplier.value.id) }
  catch (cause) { error.value = cause instanceof Error ? cause.message : '货架花材加载失败' }
  finally { loading.value = false; uni.stopPullDownRefresh() }
}
function openItem(item: SupplierFlowerItem) { uni.navigateTo({ url: `/features/quality/pages/shelf-inspection/index?id=${item.id}&supplier=${encodeURIComponent(supplier.value?.supplierName || '')}` }) }
function toggleAdmission() {
  if (!supplier.value || !sessionStore.can('admission.confirm')) return uni.showToast({ title: '当前账户没有入场操作权限', icon: 'none' })
  const next = supplier.value.status === 1 ? 0 : 1
  uni.showModal({ title: next ? '确认入场' : '取消入场', content: next ? `确认“${supplier.value.supplierName}”已经到场？` : `确认取消该供应商入场？`, confirmColor: next ? '#0F766E' : '#C93636', success: async ({ confirm }) => {
    if (!confirm || !supplier.value) return
    try { await admissionApi.setStatus(supplier.value.id, next); supplier.value.status = next; uni.showToast({ title: next ? '已确认入场' : '已取消入场', icon: 'success' }) }
    catch (cause) { uni.showToast({ title: cause instanceof Error ? cause.message : '操作失败', icon: 'none' }) }
  } })
}
onLoad(query => { try { supplier.value = JSON.parse(decodeURIComponent(String(query?.supplier || ''))) as SupplierContext; load() } catch { loading.value = false; error.value = '供应商参数无效' } }); onShow(() => { if (supplier.value) load() }); onPullDownRefresh(load)
</script>

<template>
  <view class="page">
    <view v-if="supplier" class="supplier-card"><view><text class="name">{{ supplier.supplierName }}</text><text class="phone">{{ supplier.phone || '未留手机号' }}</text><text class="session">{{ supplier.session }} 场次 · {{ items.length }} 个货架条目 · 有问题 {{ issueCount }}</text></view><button :class="['entry-action',{entered:supplier.status===1}]" @click="toggleAdmission">{{ supplier.status === 1 ? '已入场' : '确认入场' }}</button></view>
    <view class="section-head"><text>货架花材</text><text>数量 / 质检结果</text></view>
    <WareState v-if="loading" type="loading" title="正在加载货架花材" />
    <WareState v-else-if="error" type="error" title="加载失败" :description="error" action-label="重试" @action="load" />
    <view v-else-if="items.length" class="items"><view v-for="item in items" :key="item.id" class="item" @click="openItem(item)"><view class="item-main"><view class="shelf-row"><text class="shelf">{{ item.shelf }}</text><text v-if="item.subShelf" class="sub-shelf">{{ item.subShelf }}</text></view><text class="flower">{{ item.flowerName }} · {{ item.grade }} · {{ item.maturity || '成熟度未设置' }} · {{ item.bundleSpecification || '规格未设置' }}</text></view><view class="item-side"><text class="quantity">{{ item.quantity }}{{ item.unit }}</text><WareStatus :tone="item.qualityStatus===0?'neutral':item.qualityStatus===1?'success':'danger'" :label="item.qualityStatusLabel" /></view><text class="chevron">›</text></view></view>
    <WareState v-else type="empty" title="该供应商暂无货架花材" description="请核对当前场次与供应商入场数据" />
  </view>
</template>

<style scoped lang="scss">
.page{min-height:100vh;padding:24rpx}.supplier-card{display:flex;align-items:center;justify-content:space-between;gap:20rpx;padding:28rpx;border-radius:var(--wms-radius-card);background:#fff}.name,.phone,.session{display:block}.name{font-size:34rpx;font-weight:800}.phone{margin-top:8rpx;color:var(--wms-primary-700);font-size:24rpx}.session{margin-top:10rpx;color:var(--wms-text-secondary);font-size:22rpx}.entry-action{box-sizing:border-box;flex:none;height:68rpx;margin:0;padding:0 18rpx;border:0;border-radius:15rpx;background:var(--wms-primary-700);color:#fff;font-size:22rpx;font-weight:700;line-height:68rpx}.entry-action:after{border:0}.entry-action.entered{background:var(--wms-surface-soft);color:var(--wms-primary-700)}.section-head{display:flex;justify-content:space-between;padding:30rpx 4rpx 16rpx;color:var(--wms-text-secondary);font-size:23rpx}.section-head text:first-child{color:var(--wms-text);font-size:31rpx;font-weight:800}.items{overflow:hidden;border-radius:var(--wms-radius-card);background:#fff}.item{display:flex;min-height:132rpx;align-items:center;gap:16rpx;padding:22rpx;border-bottom:1rpx solid var(--wms-border)}.item:last-child{border:0}.item-main{min-width:0;flex:1}.shelf-row{display:flex;align-items:center;gap:9rpx}.shelf{color:var(--wms-primary-700);font-size:28rpx;font-weight:750}.sub-shelf{padding:3rpx 8rpx;border-radius:7rpx;background:var(--wms-surface-soft);color:var(--wms-primary-700);font-size:19rpx}.flower{display:block;margin-top:10rpx;overflow:hidden;color:var(--wms-text-secondary);font-size:22rpx;white-space:nowrap;text-overflow:ellipsis}.item-side{display:flex;align-items:flex-end;flex-direction:column;gap:9rpx}.quantity{font-size:27rpx;font-weight:750}.chevron{color:#9aa7a8;font-size:38rpx}
</style>
