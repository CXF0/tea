<script setup lang="ts">
import { computed, ref } from 'vue'
import { onLoad, onPullDownRefresh } from '@dcloudio/uni-app'
import WareState from '@/shared/components/WareState.vue'
import SessionTrigger from '@/shared/components/SessionTrigger.vue'
import SessionDatePicker from '@/shared/components/SessionDatePicker.vue'
import { agriDriverApi, type DeliverySummary } from '../../api/agri-driver.api'

const date = ref(new Date().toISOString().slice(0, 10))
const keyword = ref('')
const baseName = ref('')
const supplierId = ref(0)
const bases = ref<string[]>([])
const suppliers = ref<Array<{ id: number; name: string }>>([])
const rows = ref<DeliverySummary[]>([])
const loading = ref(true)
const error = ref('')
const datePicker = ref(false)
const picker = ref<'base' | 'supplier' | ''>('')
const totalQuantity = computed(() => rows.value.reduce((sum, item) => sum + item.totalCount, 0))
const totalOrders = computed(() => rows.value.reduce((sum, item) => sum + item.orderCount, 0))

async function load() {
  loading.value = true
  error.value = ''
  try {
    const [filters, list] = await Promise.all([
      agriDriverApi.filters(date.value, 'delivery'),
      agriDriverApi.deliveries({ date: date.value, baseName: baseName.value, supplierId: supplierId.value, keyword: keyword.value.trim() }),
    ])
    bases.value = filters.bases
    suppliers.value = filters.suppliers
    rows.value = list
  } catch (cause) {
    error.value = cause instanceof Error ? cause.message : '农资送货单加载失败'
  } finally {
    loading.value = false
    uni.stopPullDownRefresh()
  }
}
function detail(item: DeliverySummary) {
  uni.navigateTo({ url: `/features/agri-driver/pages/delivery/detail?date=${date.value}&goodsId=${item.goodsId}&skuId=${item.skuId}&goodsName=${encodeURIComponent(item.goodsName)}&skuName=${encodeURIComponent(item.skuName)}&baseName=${encodeURIComponent(baseName.value)}&supplierId=${supplierId.value}` })
}
function chooseBase(value: string) { baseName.value = value; picker.value = ''; load() }
function chooseSupplier(value: number) { supplierId.value = value; picker.value = ''; load() }
onLoad(load)
onPullDownRefresh(load)
</script>

<template>
  <view class="page">
    <view class="filter-bar">
      <view class="search-box"><text class="search-icon">⌕</text><input v-model="keyword" placeholder="商品名称" confirm-type="search" @confirm="load" /></view>
      <SessionTrigger :value="date" @click="datePicker = true" />
    </view>
    <view class="selector-row">
      <button class="filter-trigger" @click="picker = 'base'"><text>{{ baseName || '全部基地' }}</text><i /></button>
      <button class="filter-trigger" @click="picker = 'supplier'"><text>{{ suppliers.find(item => item.id === supplierId)?.name || '全部农资商' }}</text><i /></button>
    </view>

    <view class="overview">
      <view><b>{{ rows.length }}</b><text>种</text><small>商品规格</small></view>
      <view><b>{{ totalQuantity }}</b><text>件</text><small>待配送数量</small></view>
      <view><b>{{ totalOrders }}</b><text>单</text><small>关联订单</small></view>
    </view>
    <view class="section-title"><b>商品汇总</b><text>按商品规格合并</text></view>

    <WareState v-if="loading" type="loading" title="正在加载农资送货单" />
    <WareState v-else-if="error" type="error" title="加载失败" :description="error" action-label="重试" @action="load" />
    <WareState v-else-if="!rows.length" type="empty" title="当前条件暂无农资送货单" description="可切换场次、基地或供应商查看" />
    <view v-else class="goods-list">
      <view v-for="item in rows" :key="`${item.goodsId}-${item.skuId}`" class="goods-card" @click="detail(item)">
        <image v-if="item.image" :src="item.image" mode="aspectFill" />
        <view v-else class="goods-icon">农资</view>
        <view class="goods-main"><b>{{ item.goodsName }}</b><small>{{ item.skuName || '默认规格' }}</small><text>{{ item.orderCount }} 张订单</text></view>
        <view class="quantity"><b>{{ item.totalCount }}</b><small>件</small></view>
        <i class="arrow" />
      </view>
    </view>

    <SessionDatePicker v-model="date" v-model:visible="datePicker" @confirm="load" />
    <view v-if="picker" class="mask" @click="picker = ''">
      <view class="drawer" @click.stop>
        <view class="drawer-title"><b>{{ picker === 'base' ? '选择基地' : '选择农资供应商' }}</b><text @click="picker = ''">关闭</text></view>
        <view v-if="picker === 'base'" class="options"><view :class="{ active: !baseName }" @click="chooseBase('')">全部基地</view><view v-for="item in bases" :key="item" :class="{ active: baseName === item }" @click="chooseBase(item)">{{ item }}</view></view>
        <view v-else class="options"><view :class="{ active: !supplierId }" @click="chooseSupplier(0)">全部农资商</view><view v-for="item in suppliers" :key="item.id" :class="{ active: supplierId === item.id }" @click="chooseSupplier(item.id)">{{ item.name }}</view></view>
      </view>
    </view>
  </view>
</template>

<style scoped>
.page{min-height:100vh;padding:16rpx 20rpx 32rpx;background:var(--wms-background);box-sizing:border-box}.filter-bar,.selector-row{display:flex;gap:10rpx;align-items:center}.search-box{display:flex;flex:1;align-items:center;height:64rpx;padding:0 14rpx;background:#fff;border:1rpx solid var(--wms-border);border-radius:10rpx;box-sizing:border-box}.search-icon{margin-right:8rpx;color:var(--wms-text-secondary);font-size:28rpx}.search-box input{min-width:0;font-size:23rpx}.filter-bar :deep(.session-trigger){width:214rpx;height:64rpx;padding:0 12rpx}.selector-row{margin-top:10rpx}.filter-trigger{display:flex;flex:1;align-items:center;justify-content:space-between;height:60rpx;margin:0;padding:0 16rpx;background:#fff;border:1rpx solid var(--wms-border);border-radius:10rpx;color:var(--wms-primary-700);font-size:22rpx;line-height:60rpx}.filter-trigger::after{border:0}.filter-trigger text{overflow:hidden;text-overflow:ellipsis;white-space:nowrap}.filter-trigger i{flex:0 0 auto;width:8rpx;height:8rpx;margin-left:8rpx;border-right:2rpx solid;border-bottom:2rpx solid;transform:rotate(45deg)}.overview{display:grid;grid-template-columns:repeat(3,1fr);margin-top:14rpx;padding:18rpx 8rpx;background:#fff;border:1rpx solid var(--wms-border);border-radius:14rpx}.overview>view{text-align:center;border-right:1rpx solid var(--wms-border)}.overview>view:last-child{border:0}.overview b{font-size:31rpx;color:var(--wms-primary-700);font-variant-numeric:tabular-nums}.overview text{margin-left:3rpx;font-size:20rpx}.overview small{display:block;margin-top:4rpx;color:var(--wms-text-secondary);font-size:19rpx}.section-title{display:flex;align-items:center;justify-content:space-between;margin:20rpx 2rpx 10rpx}.section-title b{font-size:26rpx}.section-title text{color:var(--wms-text-secondary);font-size:19rpx}.goods-card{display:grid;grid-template-columns:84rpx minmax(0,1fr) auto 18rpx;gap:13rpx;align-items:center;margin-bottom:10rpx;padding:16rpx;background:#fff;border:1rpx solid var(--wms-border);border-radius:14rpx;box-shadow:0 4rpx 12rpx rgba(24,50,48,.04)}.goods-card image,.goods-icon{width:84rpx;height:84rpx;border-radius:10rpx}.goods-icon{display:flex;align-items:center;justify-content:center;background:var(--wms-surface-soft);color:var(--wms-primary-700);font-size:21rpx;font-weight:600}.goods-main{min-width:0}.goods-main b,.goods-main small,.goods-main text{display:block}.goods-main b{overflow:hidden;font-size:26rpx;text-overflow:ellipsis;white-space:nowrap}.goods-main small{margin-top:5rpx;color:var(--wms-text-secondary);font-size:20rpx}.goods-main text{margin-top:6rpx;color:var(--wms-primary-700);font-size:19rpx}.quantity{display:flex;align-items:baseline}.quantity b{color:var(--wms-primary-700);font-size:34rpx;font-variant-numeric:tabular-nums}.quantity small{margin-left:3rpx;color:var(--wms-text-secondary);font-size:19rpx}.arrow{width:9rpx;height:9rpx;border-right:2rpx solid var(--wms-text-secondary);border-top:2rpx solid var(--wms-text-secondary);transform:rotate(45deg)}.mask{position:fixed;z-index:80;inset:0;display:flex;align-items:flex-end;background:rgba(16,28,27,.48)}.drawer{width:100%;min-height:48vh;max-height:72vh;padding:26rpx 20rpx calc(26rpx + env(safe-area-inset-bottom));overflow:auto;background:#fff;border-radius:24rpx 24rpx 0 0;box-sizing:border-box}.drawer-title{display:flex;align-items:center;justify-content:space-between;font-size:27rpx}.drawer-title text{color:var(--wms-primary-700);font-size:23rpx}.options{display:grid;grid-template-columns:repeat(3,1fr);gap:10rpx;margin-top:20rpx}.options view{display:flex;align-items:center;justify-content:center;min-height:68rpx;padding:6rpx;background:var(--wms-background);border:1rpx solid transparent;font-size:22rpx;text-align:center}.options .active{background:var(--wms-surface-soft);border-color:var(--wms-primary-700);color:var(--wms-primary-700);font-weight:600}
</style>
