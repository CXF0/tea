<script setup lang="ts">
import { computed, ref } from "vue";
import { onLoad } from "@dcloudio/uni-app";
import { logisticsApi } from "../../api/logistics.api";
import type { LogisticsShelfDetail } from "../../models/logistics";
import { appConfig } from "@/app/config/env";
import { sessionStore } from "@/store/session";
import WareState from "@/shared/components/WareState.vue";
const date = ref(""),
  shelfSn = ref(0),
  detail = ref<LogisticsShelfDetail>(),
  loading = ref(true),
  submitting = ref(false),
  photos = ref<string[]>([]),
  selected = ref(0);
const current = computed(() => detail.value?.packages[selected.value]);
const canShip = computed(
  () =>
    sessionStore.can("logistics.operate") &&
    !!detail.value?.packages.some((p) => p.status >= 10 && p.status < 20),
);
const imageUrl = (url: string) =>
  url.startsWith("http")
    ? url
    : `${appConfig.apiBaseUrl.replace(/\/api$/, "")}${url}`;
async function load() {
  loading.value = true;
  try {
    detail.value = await logisticsApi.detail(date.value, shelfSn.value);
    photos.value = [
      ...new Set(detail.value.packages.flatMap((p) => p.shipPhotos)),
    ];
  } finally {
    loading.value = false;
  }
}
async function addPhoto() {
  const result = await new Promise<UniApp.ChooseImageSuccessCallbackResult>(
    (resolve, reject) =>
      uni.chooseImage({
        count: 3 - photos.value.length,
        sizeType: ["compressed"],
        sourceType: ["camera", "album"],
        success: resolve,
        fail: reject,
      }),
  );
  for (const path of result.tempFilePaths) {
    const uploaded = await logisticsApi.upload(path);
    photos.value.push(uploaded.url);
  }
}
async function ship() {
  if (!photos.value.length)
    return uni.showToast({ title: "请先上传过秤照片", icon: "none" });
  uni.showModal({
    title: "确认完成发货",
    content: `将货架 ${detail.value?.shelfNo} 的可发货包裹标记为已发货，是否继续？`,
    success: async (r) => {
      if (!r.confirm) return;
      submitting.value = true;
      try {
        detail.value = await logisticsApi.ship(
          date.value,
          shelfSn.value,
          photos.value,
        );
        uni.showToast({ title: "发货完成", icon: "success" });
      } finally {
        submitting.value = false;
      }
    },
  });
}
onLoad((q) => {
  date.value = String(q?.date || "");
  shelfSn.value = Number(q?.shelfSn || 0);
  load();
});
</script>
<template>
  <view class="page"
    ><WareState
      v-if="loading"
      type="loading"
      title="正在加载发货详情" /><template v-else-if="detail && current"
      ><view class="summary"
        ><view
          ><text>{{ detail.warehouseName }} · 货架号</text
          ><strong>{{ detail.shelfNo }}</strong></view
        ><view
          ><text>发货进度</text
          ><strong
            >{{ detail.packages.filter((p) => p.status >= 20).length }} /
            {{ detail.packages.length }}</strong
          ></view
        ></view
      ><scroll-view scroll-x class="package-tabs"
        ><view class="tab-row"
          ><view
            v-for="(p, index) in detail.packages"
            :key="p.id"
            :class="['package-tab', { active: selected === index }]"
            @click="selected = index"
            ><text>{{ p.serialNum }}</text
            ><i :class="{ done: p.status >= 20 }" /></view></view></scroll-view
      ><view class="card"
        ><view class="title"
          ><strong># {{ detail.shelfNo }}-{{ current.serialNum }}</strong
          ><text :class="{ done: current.status >= 20 }">{{
            current.status >= 20
              ? "发货完成"
              : current.status >= 10
                ? "打包完成"
                : "待打包"
          }}</text></view
        ><view class="rows"
          ><view
            ><text>场次</text><strong>{{ detail.date }}</strong></view
          ><view
            ><text>包裹类型</text
            ><strong>{{ current.packageName || "未配置" }}</strong></view
          ><view
            ><text>发货物流</text
            ><strong
              >{{ current.expressName }}
              <i v-if="current.expressType === 1" class="badge early"
                >早班</i
              ></strong
            ></view
          ><view
            ><text>发货单号</text><strong>{{ current.sendNo }}</strong></view
          ><view
            ><text>目的城市</text><strong>{{ current.city }}</strong></view
          ><view
            ><text>花材数量</text
            ><strong>{{ current.itemNum }} 扎</strong></view
          ><view
            ><text>收货人</text
            ><strong
              >{{ current.receiveName }} {{ current.receiveTel }}</strong
            ></view
          ><view
            ><text>收货地址</text
            ><strong>{{ current.receiveAddress }}</strong></view
          ><view
            ><text>备注</text><strong>{{ current.remark || "—" }}</strong></view
          ><view
            ><text class="danger">物流备注</text
            ><strong class="danger">{{
              current.logisticsRemark || "—"
            }}</strong></view
          ><view v-if="current.packageUserName"
            ><text>打包人</text
            ><strong>{{ current.packageUserName }}</strong></view
          ><view v-if="current.packageTime"
            ><text>打包时间</text
            ><strong>{{ current.packageTime }}</strong></view
          ><view v-if="current.shipUserName"
            ><text>发货姓名</text
            ><strong>{{ current.shipUserName }}</strong></view
          ><view v-if="current.shipTime"
            ><text>发货时间</text><strong>{{ current.shipTime }}</strong></view
          ><view
            ><text>称重（kg）</text
            ><strong class="danger">{{
              current.weight.toFixed(2)
            }}</strong></view
          ><view
            ><text>运费合计（元）</text
            ><strong class="danger">{{
              current.freight.toFixed(2)
            }}</strong></view
          ></view
        ></view
      ><view class="photos"
        ><strong>过秤拍照</strong
        ><view class="photo-grid"
          ><view v-for="(url, index) in photos" :key="url"
            ><image :src="imageUrl(url)" mode="aspectFill" /><text
              v-if="canShip"
              @click="photos.splice(index, 1)"
              >×</text
            ></view
          ><view
            v-if="canShip && photos.length < 3"
            class="add"
            @click="addPhoto"
            ><b>＋</b><span>拍照</span></view
          ></view
        ></view
      ><view v-if="canShip" class="footer"
        ><button :disabled="submitting" @click="ship">
          {{ submitting ? "提交中…" : "确认完成发货" }}
        </button></view
      ></template
    ><WareState v-else type="empty" title="未找到发货数据"
  /></view>
</template>
<style scoped lang="scss">
.page {
  min-height: 100vh;
  padding: 24rpx 24rpx 150rpx;
}
.summary {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 14rpx;
}
.summary > view,
.card,
.photos {
  padding: 22rpx;
  border-radius: 20rpx;
  background: #fff;
}
.summary text,
.summary strong {
  display: block;
}
.summary text {
  color: var(--wms-text-secondary);
  font-size: 18rpx;
}
.summary strong {
  margin-top: 6rpx;
  font-size: 29rpx;
}
.package-tabs {
  margin: 16rpx 0;
}
.tab-row {
  display: flex;
  width: max-content;
  gap: 12rpx;
}
.package-tab {
  display: flex;
  width: 70rpx;
  height: 68rpx;
  align-items: center;
  justify-content: center;
  flex-direction: column;
  border-radius: 12rpx;
  background: #fff;
}
.package-tab i {
  width: 10rpx;
  height: 10rpx;
  margin-top: 5rpx;
  border-radius: 50%;
  background: var(--wms-warning);
}
.package-tab i.done {
  background: var(--wms-success);
}
.package-tab.active {
  background: var(--wms-primary-700);
  color: #fff;
}
.title {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding-bottom: 18rpx;
  border-bottom: 1rpx solid var(--wms-border);
}
.title strong {
  font-size: 27rpx;
}
.title text {
  padding: 6rpx 10rpx;
  border-radius: 8rpx;
  background: #fff0da;
  color: #a35e00;
  font-size: 18rpx;
}
.title text.done {
  background: var(--wms-surface-soft);
  color: var(--wms-success);
}
.rows > view {
  display: grid;
  grid-template-columns: 145rpx 1fr;
  min-height: 65rpx;
  align-items: center;
}
.rows text {
  color: var(--wms-text-secondary);
  font-size: 19rpx;
}
.rows strong {
  font-size: 20rpx;
}
.rows .badge {
  display: inline-block;
  margin-left: 10rpx;
  padding: 3rpx 8rpx;
  border-radius: 5rpx;
  font-size: 15rpx;
  font-style: normal;
  font-weight: 400;
}
.rows .early {
  background: #fde8e8;
  color: var(--wms-danger);
}
.rows .danger {
  color: var(--wms-danger);
}
.photos {
  margin-top: 16rpx;
}
.photos > strong {
  font-size: 22rpx;
}
.photo-grid {
  display: flex;
  gap: 12rpx;
  margin-top: 14rpx;
}
.photo-grid > view {
  position: relative;
  width: 130rpx;
  height: 130rpx;
  overflow: hidden;
  border-radius: 12rpx;
}
.photo-grid image {
  width: 100%;
  height: 100%;
}
.photo-grid > view > text {
  position: absolute;
  top: 5rpx;
  right: 5rpx;
  display: flex;
  width: 32rpx;
  height: 32rpx;
  align-items: center;
  justify-content: center;
  border-radius: 50%;
  background: #263c39;
  color: #fff;
}
.photo-grid .add {
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: column;
  background: var(--wms-background);
  color: var(--wms-primary-700);
}
.add b {
  font-size: 34rpx;
}
.add span {
  font-size: 17rpx;
}
.footer {
  position: fixed;
  right: 0;
  bottom: 0;
  left: 0;
  padding: 16rpx 24rpx calc(18rpx + env(safe-area-inset-bottom));
  background: #fff;
}
.footer button {
  height: 82rpx;
  border: 0;
  border-radius: 16rpx;
  background: var(--wms-primary-700);
  color: #fff;
  font-size: 24rpx;
  font-weight: 700;
  line-height: 82rpx;
}
</style>
