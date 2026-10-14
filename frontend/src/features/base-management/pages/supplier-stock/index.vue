<script setup lang="ts">
import { computed, ref } from "vue";
import { onLoad, onPullDownRefresh } from "@dcloudio/uni-app";
import WareState from "@/shared/components/WareState.vue";
import WarePhoneLink from "@/shared/components/WarePhoneLink.vue";
import {
  baseManagementApi,
  type StockItem,
  type SupplierStatistics,
  type VarietyPermission,
} from "../../api/base-management.api";

const id = ref(0),
  date = ref(""),
  supplier = ref<{
    id: number;
    name: string;
    phone: string;
    baseName: string;
  }>(),
  statistics = ref<SupplierStatistics>(),
  items = ref<StockItem[]>([]),
  permissions = ref<VarietyPermission[]>([]),
  tab = ref<"inventory" | "permission">("inventory"),
  keyword = ref(""),
  loading = ref(true),
  error = ref("");
const visible = computed(() =>
  items.value.filter(
    (x) =>
      !keyword.value.trim() || x.productName.includes(keyword.value.trim()),
  ),
);
const visiblePermissions = computed(() =>
  permissions.value.filter(
    (x) => !keyword.value.trim() || x.name.includes(keyword.value.trim()),
  ),
);
const metrics = computed(() =>
  statistics.value
    ? [
        {
          value: statistics.value.saleVarietyCount,
          unit: "种",
          label: "在售品种",
        },
        { value: statistics.value.stockNum, unit: "扎", label: "库存扎数" },
        { value: statistics.value.normalSales, unit: "扎", label: "普通销量" },
        {
          value: statistics.value.soldOrderCount,
          unit: "单",
          label: "已售订单",
        },
        { value: statistics.value.agencySales, unit: "扎", label: "代卖销量" },
        {
          value: statistics.value.authorizedVarietyCount,
          unit: "种",
          label: "权限品种",
        },
      ]
    : [],
);
async function load() {
  loading.value = true;
  error.value = "";
  try {
    const d = await baseManagementApi.supplier(id.value, date.value);
    supplier.value = d.supplier;
    statistics.value = d.statistics;
    items.value = d.items;
    permissions.value = d.permissions;
  } catch (e) {
    error.value = e instanceof Error ? e.message : "库存加载失败";
  } finally {
    loading.value = false;
    uni.stopPullDownRefresh();
  }
}
onLoad((q) => {
  id.value = Number(q?.id);
  date.value = String(q?.date || new Date().toISOString().slice(0, 10));
  load();
});
onPullDownRefresh(load);
</script>
<template>
  <view class="page"
    ><WareState
      v-if="loading"
      type="loading"
      title="正在加载供应商库存"
    /><WareState
      v-else-if="error"
      type="error"
      title="加载失败"
      :description="error"
      action-label="重试"
      @action="load"
    /><template v-else-if="supplier && statistics">
      <view class="supplier"
        ><b>{{ supplier.name }}</b
        ><WarePhoneLink :phone="supplier.phone" /></view
      >
      <view class="section-title">今日统计</view
      ><view class="metrics"
        ><view v-for="x in metrics" :key="x.label"
          ><b
            >{{ x.value }}<small>{{ x.unit }}</small></b
          ><text>{{ x.label }}</text></view
        ></view
      >
      <view class="inventory-head"
        ><view class="title-tabs"
          ><text
            :class="{ active: tab === 'inventory' }"
            @click="
              tab = 'inventory';
              keyword = '';
            "
            >供应商库存</text
          ><text
            :class="{ active: tab === 'permission' }"
            @click="
              tab = 'permission';
              keyword = '';
            "
            >品种权限</text
          ></view
        ><view class="search"
          ><input v-model="keyword" placeholder="商品名称" /></view
      ></view>
      <template v-if="tab === 'inventory'"
        ><view class="table-head"
          ><text>花材</text><text>库存</text><text>价格</text></view
        ><WareState
          v-if="!visible.length"
          type="empty"
          title="当前场次暂无库存"
          description="可更换场次或检查商品名称"
        />
        <view
          v-for="x in visible"
          v-else
          :key="`${x.productId}-${x.rank}-${x.specification}`"
          class="row"
          ><view
            ><b
              >{{ x.productName }}
              <i>{{ ["", "A", "B", "C", "D", "E"][x.rank] || x.rank }}级</i></b
            ><small v-if="x.specification">{{ x.specification }}</small></view
          ><strong>{{ x.stockNum }}</strong
          ><strong>{{ x.price.toFixed(1) }}</strong></view
        ></template
      >
      <template v-else
        ><view class="permission-head"
          ><text>花材</text><text>权限等级</text></view
        ><WareState
          v-if="!visiblePermissions.length"
          type="empty"
          title="暂无品种权限"
          description="当前供应商尚未配置可售品种"
        /><view
          v-for="x in visiblePermissions"
          v-else
          :key="x.secondId"
          class="permission-row"
          ><b>{{ x.name }}</b
          ><text>{{ x.levels || "未配置等级" }}</text></view
        ></template
      >
    </template></view
  >
</template>
<style scoped>
.page {
  min-height: 100vh;
  padding: 17rpx 20rpx 40rpx;
  background: var(--wms-background);
}
.supplier b,
.supplier text {
  display: block;
}
.supplier b {
  color: var(--wms-primary-700);
  font-size: 29rpx;
}
.supplier text {
  width: max-content;
  margin-top: 4rpx;
  color: var(--wms-primary-700);
  font-size: 18rpx;
}
.section-title {
  margin-top: 14rpx;
  font-size: 22rpx;
  font-weight: 700;
}
.metrics {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 9rpx;
  margin-top: 10rpx;
}
.metrics view {
  min-width: 0;
  padding: 11rpx 8rpx;
  background: var(--wms-surface-soft);
  color: var(--wms-primary-700);
}
.metrics b,
.metrics text {
  display: block;
}
.metrics b {
  font-size: 27rpx;
  font-variant-numeric: tabular-nums;
}
.metrics small {
  margin-left: 2rpx;
  font-size: 15rpx;
  font-weight: 400;
}
.metrics text {
  margin-top: 3rpx;
  font-size: 16rpx;
}
.inventory-head {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-top: 24rpx;
  border-bottom: 1rpx solid var(--wms-border);
}
.title-tabs {
  display: flex;
  align-self: stretch;
  gap: 25rpx;
}
.title-tabs text {
  position: relative;
  display: flex;
  align-items: center;
  color: var(--wms-text-secondary);
  font-size: 20rpx;
  white-space: nowrap;
}
.title-tabs .active {
  color: var(--wms-primary-700);
  font-weight: 700;
}
.title-tabs .active:after {
  position: absolute;
  right: 20%;
  bottom: -1rpx;
  left: 20%;
  height: 3rpx;
  background: var(--wms-primary-700);
  content: "";
}
.search {
  width: 185rpx;
  height: 58rpx;
  padding: 0 13rpx;
  border: 1rpx solid var(--wms-border);
  border-radius: 8rpx;
  background: #fff;
  margin-bottom: 8rpx;
}
.search input {
  height: 58rpx;
  font-size: 17rpx;
}
.table-head,
.row {
  display: grid;
  grid-template-columns: minmax(0, 1.7fr) 0.55fr 0.55fr;
  align-items: center;
  gap: 10rpx;
}
.table-head {
  margin-top: 12rpx;
  padding: 13rpx 15rpx;
  background: var(--wms-primary-700);
  color: #fff;
  font-size: 18rpx;
}
.row {
  margin-top: 6rpx;
  padding: 14rpx 15rpx;
  background: #fff;
  border-radius: 8rpx;
}
.row b,
.row small {
  display: block;
}
.row b {
  font-size: 19rpx;
}
.row i {
  color: var(--wms-danger);
  font-style: normal;
}
.row small {
  margin-top: 4rpx;
  color: var(--wms-text-secondary);
  font-size: 14rpx;
}
.row strong {
  font-size: 19rpx;
  font-variant-numeric: tabular-nums;
}
.permission-head,
.permission-row {
  display: grid;
  grid-template-columns: minmax(0, 1.55fr) 1fr;
  align-items: center;
  gap: 12rpx;
}
.permission-head {
  margin-top: 12rpx;
  padding: 13rpx 15rpx;
  background: var(--wms-primary-700);
  color: #fff;
  font-size: 18rpx;
}
.permission-row {
  margin-top: 6rpx;
  padding: 17rpx 15rpx;
  border-radius: 8rpx;
  background: #fff;
  font-size: 19rpx;
}
.permission-row text {
  font-variant-numeric: tabular-nums;
  letter-spacing: 2rpx;
}
</style>
<style scoped>
.supplier b{font-size:var(--wms-font-list-title)}.section-title,.title-tabs text{font-size:var(--wms-font-list-body)}.metrics text,.metrics small{font-size:var(--wms-font-list-caption)}.search input{font-size:var(--wms-font-list-meta)}.table-head,.permission-head{font-size:var(--wms-font-list-meta)}.row,.permission-row{font-size:var(--wms-font-list-body);line-height:var(--wms-line-list)}.row b,.row strong{font-size:var(--wms-font-list-body)}.row small{font-size:var(--wms-font-list-caption)}
</style>
