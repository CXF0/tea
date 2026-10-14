<script setup lang="ts">
import { computed, ref } from 'vue'
import { onLoad, onPullDownRefresh } from '@dcloudio/uni-app'
import WareState from '@/shared/components/WareState.vue'
import WarePhoneLink from '@/shared/components/WarePhoneLink.vue'
import SessionTrigger from '@/shared/components/SessionTrigger.vue'
import SessionDatePicker from '@/shared/components/SessionDatePicker.vue'
import { agriDriverApi, type DriverOrder } from '../../api/agri-driver.api'

const date = ref(new Date().toISOString().slice(0, 10))
const status = ref(0)
const keyword = ref('')
const baseName = ref('')
const supplierId = ref(0)
const bases = ref<string[]>([])
const suppliers = ref<Array<{ id: number; name: string }>>([])
const orders = ref<DriverOrder[]>([])
const loading = ref(true)
const error = ref('')
const datePicker = ref(false)
const picker = ref<'base' | 'supplier' | ''>('')

const statusTabs = ['全部', '待发货', '待签收', '已签收']
const counts = computed(() => [0, 1, 2, 3].map(value => value ? orders.value.filter(item => item.orderStatus === value).length : orders.value.length))
const visible = computed(() => orders.value.filter(item =>
  (!status.value || item.orderStatus === status.value) &&
  (!keyword.value.trim() || item.buySupplierName.includes(keyword.value.trim()) || item.orderId.includes(keyword.value.trim())),
))
const totalQuantity = computed(() => visible.value.reduce((sum, item) => sum + item.goodsCount, 0))
const totalAmount = computed(() => visible.value.reduce((sum, item) => sum + item.totalPrice, 0))

async function load() {
  loading.value = true
  error.value = ''
  try {
    const [filters, list] = await Promise.all([
      agriDriverApi.filters(date.value, 'order'),
      agriDriverApi.orders({ date: date.value, status: 0, keyword: '', baseName: baseName.value, supplierId: supplierId.value }),
    ])
    bases.value = filters.bases
    suppliers.value = filters.suppliers
    orders.value = list
  } catch (cause) {
    error.value = cause instanceof Error ? cause.message : '农资订单加载失败'
  } finally {
    loading.value = false
    uni.stopPullDownRefresh()
  }
}

function detail(item: DriverOrder) {
  uni.navigateTo({ url: `/features/agri-driver/pages/orders/detail?id=${encodeURIComponent(item.orderId)}` })
}
function chooseBase(value: string) { baseName.value = value; picker.value = ''; load() }
function chooseSupplier(value: number) { supplierId.value = value; picker.value = ''; load() }

onLoad(load)
onPullDownRefresh(load)
</script>

<template>
  <view class="page">
    <view class="filter-bar">
      <view class="search-box">
        <text class="search-icon">⌕</text>
        <input v-model="keyword" placeholder="供应商或订单号" confirm-type="search" />
      </view>
      <SessionTrigger :value="date" @click="datePicker = true" />
    </view>
    <view class="selector-row">
      <button class="filter-trigger" @click="picker = 'base'"><text>{{ baseName || '全部基地' }}</text><i /></button>
      <button class="filter-trigger" @click="picker = 'supplier'"><text>{{ suppliers.find(item => item.id === supplierId)?.name || '全部农资商' }}</text><i /></button>
    </view>

    <view class="overview">
      <view><b>{{ visible.length }}</b><text>订单</text><small>当前结果</small></view>
      <view><b>{{ totalQuantity }}</b><text>件</text><small>商品数量</small></view>
      <view><b>{{ totalAmount.toFixed(2) }}</b><text>元</text><small>订单金额</small></view>
    </view>

    <view class="tabs">
      <view v-for="(name, index) in statusTabs" :key="name" :class="{ active: status === index }" @click="status = index">
        <text>{{ name }}</text><b>{{ counts[index] }}</b>
      </view>
    </view>

    <WareState v-if="loading" type="loading" title="正在加载农资订单" />
    <WareState v-else-if="error" type="error" title="加载失败" :description="error" action-label="重试" @action="load" />
    <WareState v-else-if="!visible.length" type="empty" title="当前条件暂无农资订单" description="可切换场次、基地或状态查看" />
    <view v-else class="order-list">
      <view v-for="item in visible" :key="item.orderId" class="order-card" @click="detail(item)">
        <view class="order-head">
          <view><b>{{ item.buySupplierName }}</b><small>{{ item.orderId }}</small></view>
          <text class="status-tag" :class="`status-${item.orderStatus}`">{{ item.statusLabel }}</text>
        </view>
        <view class="route-row">
          <text class="base-tag">{{ item.baseName }}</text>
          <text>由 {{ item.peasantSupplierName }} 配送</text>
        </view>
        <view class="receiver-row">
          <text>{{ item.receiverName || '收货人未填写' }}</text>
          <WarePhoneLink :phone="item.receiverPhone" compact />
        </view>
        <view class="order-foot">
          <view><b>{{ item.itemCount }}</b><text>种</text><b>{{ item.goodsCount }}</b><text>件</text></view>
          <strong>¥{{ item.totalPrice.toFixed(2) }}</strong>
        </view>
        <view class="time-row"><text>下单 {{ item.createTime }}</text><text class="detail-link">详情 ›</text></view>
      </view>
    </view>

    <SessionDatePicker v-model="date" v-model:visible="datePicker" @confirm="load" />
    <view v-if="picker" class="mask" @click="picker = ''">
      <view class="drawer" @click.stop>
        <view class="drawer-title"><b>{{ picker === 'base' ? '选择基地' : '选择农资供应商' }}</b><text @click="picker = ''">关闭</text></view>
        <view v-if="picker === 'base'" class="options">
          <view :class="{ active: !baseName }" @click="chooseBase('')">全部基地</view>
          <view v-for="item in bases" :key="item" :class="{ active: baseName === item }" @click="chooseBase(item)">{{ item }}</view>
        </view>
        <view v-else class="options">
          <view :class="{ active: !supplierId }" @click="chooseSupplier(0)">全部农资商</view>
          <view v-for="item in suppliers" :key="item.id" :class="{ active: supplierId === item.id }" @click="chooseSupplier(item.id)">{{ item.name }}</view>
        </view>
      </view>
    </view>
  </view>
</template>

<style scoped>
.page{min-height:100vh;padding:16rpx 20rpx 32rpx;background:var(--wms-background);box-sizing:border-box}.filter-bar,.selector-row{display:flex;gap:10rpx;align-items:center}.search-box{display:flex;flex:1;align-items:center;height:64rpx;padding:0 14rpx;background:#fff;border:1rpx solid var(--wms-border);border-radius:10rpx;box-sizing:border-box}.search-icon{margin-right:8rpx;color:var(--wms-text-secondary);font-size:28rpx}.search-box input{min-width:0;font-size:23rpx}.filter-bar :deep(.session-trigger){width:214rpx;height:64rpx;padding:0 12rpx}.selector-row{margin-top:10rpx}.filter-trigger{display:flex;flex:1;align-items:center;justify-content:space-between;height:60rpx;margin:0;padding:0 16rpx;background:#fff;border:1rpx solid var(--wms-border);border-radius:10rpx;color:var(--wms-primary-700);font-size:22rpx;line-height:60rpx}.filter-trigger::after{border:0}.filter-trigger text{overflow:hidden;text-overflow:ellipsis;white-space:nowrap}.filter-trigger i{flex:0 0 auto;width:8rpx;height:8rpx;margin-left:8rpx;border-right:2rpx solid;border-bottom:2rpx solid;transform:rotate(45deg)}.overview{display:grid;grid-template-columns:repeat(3,1fr);margin-top:14rpx;padding:18rpx 8rpx;background:#fff;border:1rpx solid var(--wms-border);border-radius:14rpx}.overview>view{text-align:center;border-right:1rpx solid var(--wms-border)}.overview>view:last-child{border:0}.overview b{font-size:31rpx;color:var(--wms-primary-700);font-variant-numeric:tabular-nums}.overview text{margin-left:3rpx;font-size:20rpx}.overview small{display:block;margin-top:4rpx;color:var(--wms-text-secondary);font-size:19rpx}.tabs{display:flex;margin-top:14rpx;background:#fff;border-bottom:1rpx solid var(--wms-border)}.tabs view{position:relative;display:flex;flex:1;gap:5rpx;align-items:center;justify-content:center;min-height:68rpx;color:var(--wms-text-secondary);font-size:22rpx}.tabs b{font-size:19rpx;font-weight:500}.tabs .active{color:var(--wms-primary-700);font-weight:700}.tabs .active::after{position:absolute;right:18rpx;bottom:-1rpx;left:18rpx;height:4rpx;background:var(--wms-primary-700);content:''}.order-list{margin-top:12rpx}.order-card{margin-bottom:12rpx;padding:18rpx;background:#fff;border:1rpx solid var(--wms-border);border-radius:14rpx;box-shadow:0 4rpx 12rpx rgba(24,50,48,.04)}.order-head,.receiver-row,.order-foot,.time-row{display:flex;align-items:center;justify-content:space-between}.order-head>view{min-width:0}.order-head b{display:block;overflow:hidden;color:var(--wms-text-primary);font-size:27rpx;text-overflow:ellipsis;white-space:nowrap}.order-head small{display:block;margin-top:4rpx;color:var(--wms-text-secondary);font-size:19rpx}.status-tag{flex:0 0 auto;padding:5rpx 10rpx;border-radius:6rpx;font-size:20rpx;font-weight:600}.status-1{background:#f1f3f3;color:#596768}.status-2{background:#fff1da;color:#9b5c00}.status-3{background:var(--wms-surface-soft);color:var(--wms-success)}.route-row{display:flex;gap:10rpx;align-items:center;margin-top:14rpx;color:var(--wms-text-secondary);font-size:21rpx}.base-tag{padding:4rpx 9rpx;background:var(--wms-surface-soft);border-radius:5rpx;color:var(--wms-primary-700);font-weight:600}.receiver-row{min-height:54rpx;margin-top:9rpx;font-size:22rpx}.order-foot{margin-top:8rpx;padding-top:13rpx;border-top:1rpx dashed var(--wms-border)}.order-foot view{display:flex;gap:4rpx;align-items:baseline}.order-foot b{margin-left:8rpx;font-size:28rpx}.order-foot b:first-child{margin-left:0}.order-foot text{color:var(--wms-text-secondary);font-size:19rpx}.order-foot strong{color:var(--wms-danger);font-size:28rpx}.time-row{margin-top:12rpx;color:var(--wms-text-secondary);font-size:19rpx}.detail-link{color:var(--wms-primary-700);font-weight:600}.mask{position:fixed;z-index:80;inset:0;display:flex;align-items:flex-end;background:rgba(16,28,27,.48)}.drawer{width:100%;min-height:48vh;max-height:72vh;padding:26rpx 20rpx calc(26rpx + env(safe-area-inset-bottom));overflow:auto;background:#fff;border-radius:24rpx 24rpx 0 0;box-sizing:border-box}.drawer-title{display:flex;align-items:center;justify-content:space-between;font-size:27rpx}.drawer-title text{color:var(--wms-primary-700);font-size:23rpx}.options{display:grid;grid-template-columns:repeat(3,1fr);gap:10rpx;margin-top:20rpx}.options view{display:flex;align-items:center;justify-content:center;min-height:68rpx;padding:6rpx;background:var(--wms-background);border:1rpx solid transparent;font-size:22rpx;text-align:center}.options .active{background:var(--wms-surface-soft);border-color:var(--wms-primary-700);color:var(--wms-primary-700);font-weight:600}
</style>
