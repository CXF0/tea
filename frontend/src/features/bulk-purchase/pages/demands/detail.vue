<script setup lang="ts">
import { computed, ref } from "vue";
import { onLoad } from "@dcloudio/uni-app";
import WareState from "@/shared/components/WareState.vue";
import { bulkPurchaseApi, type BulkDemandDetail } from "../../api/bulk-purchase.api";

const detail = ref<BulkDemandDetail | null>(null);
const loading = ref(true);
const error = ref("");
let demandId = 0;
const demandStatuses = ["草稿","报价中","待定采","已确认","已完成","已关闭"];
const orderStatuses:Record<number,string> = {10:"待进场",20:"已进场",30:"盘点中",40:"已结算",90:"已取消"};
const rankNames:Record<number,string> = {0:"无等级",1:"A级",2:"B级",3:"C级",4:"D级",5:"E级",6:"O级"};
const scopeNames:Record<number,string> = {1:"全部供应商",2:"指定基地",3:"品质优选供应商",4:"近30天有销量供应商",5:"指定供应商",6:"白名单供应商"};
const ranks = computed(() => String(detail.value?.demand.rankCodes || "").split(/[,，/]/).map(v => v.trim()).filter(Boolean));
const numberText = (value:number | null | undefined) => Number(value || 0).toLocaleString("zh-CN");
const quoteResult = (value:number) => value === 1 ? "已采用" : value === 2 ? "不予采用" : "待定采";
const quoteClass = (value:number) => value === 1 ? "ok" : value === 2 ? "reject" : "pending";

async function load() {
  loading.value = true; error.value = "";
  try { detail.value = await bulkPurchaseApi.demandDetail(demandId); }
  catch (reason) { error.value = reason instanceof Error ? reason.message : "需求详情加载失败"; }
  finally { loading.value = false; }
}
onLoad((options) => { demandId = Number(options?.id || 0); if (!demandId) { loading.value=false; error.value="缺少集采需求编号"; return; } load(); });
</script>

<template>
  <view class="page">
    <WareState v-if="loading" type="loading" title="正在加载需求详情" />
    <WareState v-else-if="error" type="error" title="需求详情加载失败" :description="error" action-label="重试" @action="load" />
    <template v-else-if="detail">
      <view class="hero">
        <view class="hero-title"><view><b>{{ detail.demand.theme }}</b><text>{{ detail.demand.demandNo }}</text></view><span :class="`status s${detail.demand.status}`">{{ demandStatuses[detail.demand.status] || '未知' }}</span></view>
        <view class="summary">
          <view><text>需求数量</text><b>{{ numberText(detail.demand.demandNum + detail.demand.appendNum) }}<small>枝</small></b></view>
          <view><text>报价进度</text><b>{{ detail.demand.quotedSupplierCount }} / {{ detail.demand.eligibleSupplierCount }}<small>家</small></b></view>
          <view><text>定采数量</text><b>{{ numberText(detail.demand.confirmedQuantity) }}<small>枝</small></b></view>
          <view><text>场次</text><b class="date">{{ detail.demand.roundNo }}</b></view>
        </view>
      </view>

      <view class="section">
        <view class="section-title">采购信息</view>
        <view class="info-grid">
          <view><text>采购主体</text><b>{{ detail.demand.publishSupplierName }}</b></view>
          <view><text>集采类型</text><b>成品花材集采</b></view>
          <view><text>花材品种</text><b>{{ detail.demand.secondName }}</b></view>
          <view><text>包装规格</text><b>{{ detail.demand.specNum }}{{ detail.demand.specUnit || '枝' }}/扎</b></view>
          <view><text>报价截止</text><b>{{ detail.demand.dounanQuoteEndTime || detail.demand.nonDounanQuoteEndTime || '—' }}</b></view>
          <view><text>到货截止</text><b>{{ detail.demand.dounanCheckInEndTime || detail.demand.nonDounanCheckInEndTime || '—' }}</b></view>
          <view><text>供应商范围</text><b>{{ scopeNames[detail.demand.scopeType] || '按需求配置' }}</b></view>
          <view><text>备注</text><b>{{ detail.demand.remark || '—' }}</b></view>
        </view>
      </view>

      <view class="section">
        <view class="section-title"><b>分等级需求与报价限制</b><text>数量按枝</text></view>
        <view class="grade-head"><text>采购等级</text><text>总需求</text><text>最低起报</text></view>
        <view class="grade-row"><view class="rank-list"><span v-for="rank in ranks" :key="rank">{{ /^\d+$/.test(rank) ? (rankNames[Number(rank)] || rank) : rank }}</span></view><b>{{ numberText(detail.demand.demandNum + detail.demand.appendNum) }}</b><b>{{ numberText(detail.demand.minQuoteNum) }}</b></view>
        <view class="grade-note">各等级报价与供应数量以供应商报价快照为准</view>
      </view>

      <view class="section">
        <view class="section-title"><b>供应商报价快照</b><text>结算单价（元/枝）</text></view>
        <view v-if="!detail.quotes.length" class="inline-empty">暂无供应商报价</view>
        <view v-for="quote in detail.quotes" :key="quote.id" class="quote-card">
          <view class="quote-top"><view><b>{{ quote.supplierName }}</b><text>{{ quote.supplierTag || (quote.isDounan ? '斗南供应商' : '外部供应商') }}</text></view><span :class="quoteClass(quote.selectStatus)">{{ quoteResult(quote.selectStatus) }}</span></view>
          <view class="quote-total"><text>总可供数量</text><b>{{ numberText(quote.totalSupplyNum) }} 枝</b></view>
          <view class="price-list"><span v-for="price in quote.rankPrices" :key="price.rankCode"><i>{{ rankNames[price.rankCode] || price.rankCode }}</i> ¥{{ Number(price.price).toFixed(2) }}/枝</span></view>
        </view>
      </view>

      <view class="section">
        <view class="section-title"><b>供货与履约</b><text>{{ detail.orders.length }} 单</text></view>
        <view v-if="!detail.orders.length" class="inline-empty">暂无关联供货单</view>
        <view v-for="order in detail.orders" :key="order.id" class="order-card">
          <view class="order-top"><b>{{ order.orderNo }}</b><span>{{ orderStatuses[order.status] || '处理中' }}</span></view>
          <view class="order-supplier">{{ order.supplierName }}<text v-if="order.shelfCode">货架 {{ order.shelfCode }}</text></view>
          <view class="order-metrics"><view><text>定采数量</text><b>{{ numberText(order.confirmNum) }}</b></view><view><text>盘点产出</text><b>{{ numberText(order.actualNum) }}</b></view><view><text>结算数量</text><b>{{ order.settleNum == null ? '—' : numberText(order.settleNum) }}</b></view></view>
        </view>
      </view>
    </template>
  </view>
</template>

<style scoped>
.page{min-height:100vh;padding:18rpx;background:var(--wms-background);box-sizing:border-box}.hero,.section{margin-bottom:14rpx;padding:20rpx;border-radius:14rpx;background:#fff}.hero-title,.section-title,.quote-top,.order-top,.order-supplier{display:flex;align-items:center;justify-content:space-between}.hero-title b{display:block;font-size:27rpx}.hero-title text{display:block;margin-top:5rpx;color:var(--wms-text-secondary);font-size:18rpx}.status,.quote-top span,.order-top span{padding:5rpx 10rpx;border-radius:6rpx;background:var(--wms-surface-soft);color:var(--wms-primary-700);font-size:18rpx}.status.s1,.status.s2,.pending{background:#fff3dd!important;color:var(--wms-warning)!important}.status.s0,.status.s5{background:#eef1f0;color:var(--wms-text-secondary)}.summary{display:grid;grid-template-columns:1fr 1fr;margin-top:18rpx;border-top:1rpx solid var(--wms-border)}.summary view{padding:17rpx 10rpx;border-right:1rpx solid var(--wms-border);border-bottom:1rpx solid var(--wms-border)}.summary view:nth-child(2n){border-right:0}.summary text,.summary b{display:block}.summary text{color:var(--wms-text-secondary);font-size:18rpx}.summary b{margin-top:4rpx;font-size:27rpx}.summary small{margin-left:4rpx;font-size:16rpx}.summary .date{font-size:22rpx}.section-title{margin-bottom:15rpx;font-size:23rpx;font-weight:600}.section-title text{color:var(--wms-text-secondary);font-size:17rpx;font-weight:400}.info-grid{display:grid;grid-template-columns:1fr 1fr;gap:17rpx 20rpx}.info-grid text,.info-grid b{display:block}.info-grid text{margin-bottom:5rpx;color:var(--wms-text-secondary);font-size:17rpx}.info-grid b{font-size:20rpx;font-weight:500;line-height:1.45}.grade-head,.grade-row{display:grid;grid-template-columns:1.4fr .8fr .8fr;align-items:center;gap:8rpx}.grade-head{padding:10rpx 12rpx;background:var(--wms-primary-700);color:#fff;font-size:18rpx}.grade-row{padding:14rpx 12rpx;background:var(--wms-surface-page);font-size:19rpx}.grade-row>b{text-align:right}.rank-list{display:flex;gap:6rpx;flex-wrap:wrap}.rank-list span{padding:3rpx 7rpx;border-radius:5rpx;background:var(--wms-surface-soft);color:var(--wms-primary-700);font-size:17rpx}.grade-note{margin-top:10rpx;color:var(--wms-text-secondary);font-size:17rpx}.inline-empty{padding:32rpx 0;text-align:center;color:var(--wms-text-secondary);font-size:19rpx}.quote-card,.order-card{padding:15rpx 0;border-top:1rpx solid var(--wms-border)}.quote-card:first-of-type{border-top:0}.quote-top b,.quote-top text{display:block}.quote-top b{font-size:21rpx}.quote-top text{margin-top:3rpx;color:var(--wms-text-secondary);font-size:16rpx}.quote-top .ok{background:var(--wms-surface-soft);color:var(--wms-primary-700)}.quote-top .reject{border:1rpx solid var(--wms-danger);background:#fff;color:var(--wms-danger);transform:rotate(-2deg)}.quote-total{display:flex;justify-content:space-between;margin-top:12rpx;font-size:18rpx}.quote-total text{color:var(--wms-text-secondary)}.price-list{display:flex;flex-wrap:wrap;gap:8rpx;margin-top:10rpx}.price-list span{padding:7rpx 9rpx;background:var(--wms-surface-page);font-size:17rpx}.price-list i{font-style:normal;font-weight:600}.order-card{padding:15rpx 0}.order-top b{font-size:19rpx}.order-supplier{margin-top:10rpx;font-size:20rpx}.order-supplier text{color:var(--wms-text-secondary);font-size:17rpx}.order-metrics{display:grid;grid-template-columns:repeat(3,1fr);margin-top:12rpx;padding:11rpx 0;background:var(--wms-surface-page)}.order-metrics view{text-align:center;border-right:1rpx solid var(--wms-border)}.order-metrics view:last-child{border:0}.order-metrics text,.order-metrics b{display:block}.order-metrics text{color:var(--wms-text-secondary);font-size:16rpx}.order-metrics b{margin-top:4rpx;font-size:20rpx}
</style>
