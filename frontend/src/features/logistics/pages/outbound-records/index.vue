<script setup lang="ts">
import { computed, ref } from "vue";
import { onLoad } from "@dcloudio/uni-app";
import { logisticsApi } from "../../api/logistics.api";
import type { LogisticsShelf } from "../../models/logistics";
import SessionTrigger from "@/shared/components/SessionTrigger.vue";
import SessionDatePicker from "@/shared/components/SessionDatePicker.vue";
import WareState from "@/shared/components/WareState.vue";
const date = ref(""),
  rows = ref<LogisticsShelf[]>([]),
  loading = ref(false),
  pickerVisible = ref(false);
const total = computed(() => rows.value.reduce((s, r) => s + r.shippedNum, 0));
async function load() {
  loading.value = true;
  try {
    rows.value = await logisticsApi.shelves({
      date: date.value,
      status: 1,
      keyword: "",
      zone: "",
    });
  } finally {
    loading.value = false;
  }
}
function open(row: LogisticsShelf) {
  uni.navigateTo({
    url: `/features/logistics/pages/shelf-detail/index?date=${date.value}&shelfSn=${row.shelfSn}`,
  });
}
onLoad((q) => {
  date.value = String(q?.date || new Date().toISOString().slice(0, 10));
  load();
});
</script>
<template>
  <view class="page"
    ><view class="filter"
      ><SessionTrigger :value="date" @click="pickerVisible = true" /><text
        >合计出库 {{ total }} 件</text
      ></view
    ><view class="thead"
      ><text>箱子型号</text><text>单价</text><text>出库数量</text
      ><text>操作</text></view
    ><WareState v-if="loading" type="loading" title="正在加载出库记录" /><view
      v-else-if="rows.length"
      class="list"
      ><view v-for="row in rows" :key="row.shelfSn" class="tr"
        ><text>{{ row.packageName || "未配置" }}</text
        ><text>—</text><text>{{ row.shippedNum }}</text
        ><text @click="open(row)">查看</text></view
      ></view
    ><WareState v-else type="empty" title="暂无出库记录" /><SessionDatePicker
      v-model="date"
      v-model:visible="pickerVisible"
      title="选择日期"
      @confirm="load"
  /></view>
</template>
<style scoped>
.page {
  min-height: 100vh;
  padding: 22rpx;
}
.filter {
  display: flex;
  height: 76rpx;
  align-items: center;
  justify-content: space-between;
}
.filter > text {
  color: var(--wms-text-secondary);
  font-size: 19rpx;
}
.thead,
.tr {
  display: grid;
  grid-template-columns: 1.4fr 1fr 1fr 0.8fr;
  align-items: center;
  padding: 0 18rpx;
}
.thead {
  height: 62rpx;
  background: var(--wms-primary-700);
  color: #fff;
  font-size: 19rpx;
  font-weight: 700;
}
.tr {
  min-height: 66rpx;
  margin-top: 5rpx;
  background: #fff;
  font-size: 19rpx;
}
.tr text:last-child {
  color: var(--wms-primary-700);
}
</style>
