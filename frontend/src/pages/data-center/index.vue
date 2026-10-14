<script setup lang="ts">
import { computed, reactive, ref } from "vue";
import { onLoad, onPullDownRefresh, onShow } from "@dcloudio/uni-app";
import type { QualityBusinessSummary, QualityIssueTrend } from "@/features/quality/models/quality";
import { qualityApi } from "@/features/quality/api/quality.api";
import { distributionApi } from "@/features/distribution/api/distribution.api";
import type { AgencyDistributionSummary, ContractorDistributionSummary, DistributionSummary } from "@/features/distribution/models/distribution";
import { restockApi } from "@/features/restock/api/restock.api";
import type { RestockDemand } from "@/features/restock/models/restock";
import { admissionApi } from "@/features/admission/api/admission.api";
import type { ArrivalBusinessSummary } from "@/features/admission/models/admission";
import { packingApi } from "@/features/packing/api/packing.api";
import type { PackingPackagingStatistic, PackingSizeStatistic } from "@/features/packing/models/packing";
import { workforceApi } from "@/features/workforce/api/workforce.api";
import { authApi } from "@/features/auth/api/auth.api";
import { siteLocationApi } from "@/features/site-location/api/site-location.api";
import type { SiteLocationStatistics } from "@/features/site-location/models/site-location";
import { agriMaterialApi, type AgriDashboard } from "@/features/agri-material/api/agri-material.api";
import { logisticsApi, type LogisticsDashboard } from "@/features/logistics/api/logistics.api";
import AppBottomNav from "@/shared/components/AppBottomNav.vue";
import WareState from "@/shared/components/WareState.vue";
import SessionDatePicker from "@/shared/components/SessionDatePicker.vue";
import { sessionStore } from "@/store/session";
import {
  cardOrderStorageKey,
  dataCardsByCategory,
  normalizeCardOrder,
  type DataCategoryKey,
} from "./card-registry";

type CategoryKey = DataCategoryKey;
type FilterState = { date: string; area: string; zone: string; status: string };
const defaults: CategoryKey[] = [
  "core",
  "quality",
  "distribution",
  "arrival",
  "centralProcurement",
  "packing",
  "logistics",
  // supplier 暂不展示，后续供应商数据卡片确认后再恢复
  // "supplier",
  "agri",
];
const labels: Record<CategoryKey, string> = {
  core: "核心",
  quality: "质检",
  distribution: "配货",
  arrival: "到场货",
  centralProcurement: "集采",
  packing: "打包",
  logistics: "物流",
  supplier: "供应商",
  agri: "农资",
};
const capability: Record<CategoryKey, string[]> = {
  core: [],
  quality: ["quality.view"],
  distribution: ["distribution.view"],
  arrival: ["admission.view"],
  centralProcurement: [],
  packing: ["packing.view"],
  logistics: ["logistics.view"],
  supplier: ["baseManagement.view"],
  agri: ["agriMaterial.view"],
};
const today = new Date().toISOString().slice(0, 10);
const active = ref<CategoryKey>("core"),
  moreVisible = ref(false),
  filterVisible = ref(false),
  trendVisible = ref(false),
  datePicker = ref(false),
  agriMonthPicker = ref(false);
const loading = ref(true),
  error = ref(""),
  qualityBusiness = ref<QualityBusinessSummary | null>(null),
  arrivalBusiness = ref<ArrivalBusinessSummary | null>(null),
  distribution = ref<DistributionSummary | null>(null),
  siteDistribution = ref<DistributionSummary | null>(null),
  agencyDistribution = ref<AgencyDistributionSummary | null>(null),
  contractorDistribution = ref<ContractorDistributionSummary | null>(null),
  restockDemand = ref<RestockDemand[]>([]),
  packingSizes = ref<PackingSizeStatistic | null>(null),
  packagingStatistics = ref<PackingPackagingStatistic[]>([]),
  siteLocations = ref<SiteLocationStatistics | null>(null),
  qualityAttendance = ref<{ total: number; present: number; rest: number } | null>(null),
  qualityIssueTrend = ref<QualityIssueTrend[]>([]),
  agriDashboard = ref<AgriDashboard | null>(null),
  logisticsDashboard = ref<LogisticsDashboard | null>(null);
const agriMode = ref<"day" | "month">("day");
const qualityZones=ref<Array<{code:string;name:string}>>([]);
const responsibilityZones=ref<Array<{code:string;name:string}>>([]);
const allQualityZonesLabel="全部责任分区";
const allResponsibilityZonesLabel="全部责任区域";
const selectedQualityZoneCode=computed(()=>qualityZones.value.find(zone=>zone.name===filters.quality.zone)?.code);
const distributionRate = computed(() =>
  distribution.value?.totalUnits
    ? Math.round(
        (distribution.value.allocatedUnits / distribution.value.totalUnits) * 10000,
      ) / 100
    : 0,
);
const siteDistributionRate = computed(() =>
  siteDistribution.value?.totalUnits
    ? Math.round((siteDistribution.value.allocatedUnits / siteDistribution.value.totalUnits) * 10000) / 100
    : 0,
);
const pendingSiteDistributionUnits = computed(() =>
  Math.max(0,(siteDistribution.value?.totalUnits ?? 0)-(siteDistribution.value?.allocatedUnits ?? 0)),
);
const pendingDistributionUnits = computed(() =>
  Math.max(
    0,
    (distribution.value?.totalUnits ?? 0) -
      (distribution.value?.allocatedUnits ?? 0),
  ),
);
const restockSummary = computed(() =>
  restockDemand.value.reduce(
    (summary, item) => ({
      need: summary.need + item.needNum,
      submitted: summary.submitted + item.submittedNum,
      pending: summary.pending + item.pendingNum,
    }),
    { need: 0, submitted: 0, pending: 0 },
  ),
);
const restockSubmitRate = computed(() =>
  restockSummary.value.need
    ? Math.round((restockSummary.value.submitted / restockSummary.value.need) * 100)
    : 0,
);
const packagingTotal = computed(() => packagingStatistics.value.reduce((sum, item) => sum + item.num, 0));
const packagingTop = computed(() => packagingStatistics.value.slice(0, 5));
const packagingMax = computed(() => Math.max(1, ...packagingTop.value.map((item) => item.num)));
const packagingOther = computed(() => ({
  kinds: Math.max(0, packagingStatistics.value.length - packagingTop.value.length),
  total: packagingStatistics.value.slice(packagingTop.value.length).reduce((sum, item) => sum + item.num, 0),
}));
const siteLocationTotals = computed(() =>
  (siteLocations.value?.summary ?? []).reduce(
    (total, item) => ({ enabled: total.enabled + item.enabled, disabled: total.disabled + item.disabled }),
    { enabled: 0, disabled: 0 },
  ),
);
const filters = reactive<Record<CategoryKey, FilterState>>(
  Object.fromEntries(
    defaults.map((k) => [
      k,
      {
        date: today,
        area: "全部责任区域",
        zone: k === "quality" ? allQualityZonesLabel : "全部分区",
        status: "全部状态",
      },
    ]),
  ) as Record<CategoryKey, FilterState>,
);
const draft = reactive({
  date: today,
  area: "全部责任区域",
  zone: allQualityZonesLabel,
  status: "全部状态",
});
const trendRange = ref("近7天");
const issueType=ref("all"),draftIssueType=ref("all");
const issueTypeLabels:Record<string,string>={all:"全部类型",downgrade:"降级",return:"退货",shortage:"缺货",exchange:"换货"};
const qualityTrendMax=computed(()=>Math.max(1,...qualityIssueTrend.value.map(item=>item.count)));
const qualityTrendPoints=computed(()=>qualityIssueTrend.value.map((item,index,list)=>({
  ...item,
  x:list.length===1?350:35+index*(630/(list.length-1)),
  y:170-(item.count/qualityTrendMax.value)*135,
})));
const qualityTrendPath=computed(()=>{
  const points=qualityTrendPoints.value;
  if(!points.length)return "";
  return points.slice(1).reduce((path,point,index)=>{
    const previous=points[index];
    const middle=(previous.x+point.x)/2;
    return `${path} C ${middle} ${previous.y}, ${middle} ${point.y}, ${point.x} ${point.y}`;
  },`M ${points[0].x} ${points[0].y}`);
});
const agriColors=["#0F766E","#16866F","#D99525","#C93636","#68777A"];
const agriPeriodLabel=computed(()=>agriMode.value==="month"?filters.agri.date.slice(0,7):filters.agri.date);
const agriMonthDraftYear=ref(Number(today.slice(0,4)));
const agriMonthOptions=computed(()=>Array.from({length:12},(_,index)=>{
  const month=String(index+1).padStart(2,"0");
  const value=`${agriMonthDraftYear.value}-${month}`;
  return{value,label:`${index+1}月`,disabled:value>today.slice(0,7)};
}));
const canAgriPrevYear=computed(()=>agriMonthDraftYear.value>2020);
const canAgriNextYear=computed(()=>agriMonthDraftYear.value<Number(today.slice(0,4)));
const agriProductSegments=computed(()=>{
  const circumference=251.2;
  let offset=0;
  return (agriDashboard.value?.productSales.items??[]).map((item,index)=>{
    const dash=Math.max(0,(item.percent/100)*circumference);
    const segment={...item,color:agriColors[index%agriColors.length],dashArray:`${dash} ${Math.max(0,circumference-dash)}`,dashOffset:-offset};
    offset+=dash;
    return segment;
  });
});
const agriTrendMax=computed(()=>Math.max(1,...(agriDashboard.value?.salesTrend??[]).map(item=>item.salesAmount)));
const agriTrendPoints=computed(()=>(agriDashboard.value?.salesTrend??[]).map((item,index,list)=>({
  ...item,
  x:list.length===1?350:35+index*(630/(list.length-1)),
  y:170-(item.salesAmount/agriTrendMax.value)*135,
})));
const agriTrendPath=computed(()=>{
  const points=agriTrendPoints.value;
  if(!points.length)return "";
  return points.slice(1).reduce((path,point,index)=>{
    const previous=points[index];
    const middle=(previous.x+point.x)/2;
    return `${path} C ${middle} ${previous.y}, ${middle} ${point.y}, ${point.x} ${point.y}`;
  },`M ${points[0].x} ${points[0].y}`);
});
const storageKey = computed(
  () => `dataCenterCategoryOrder:${sessionStore.state.userId}`,
);
const categoryOrderVersion = ref(0);
const allowed = computed(() =>
  defaults.filter(
    (k) => !capability[k].length || sessionStore.canAny(capability[k]),
  ),
);
const ordered = computed(() => {
  categoryOrderVersion.value;
  const saved = uni.getStorageSync(storageKey.value) as CategoryKey[];
  const valid = Array.isArray(saved)
    ? saved.filter((k) => allowed.value.includes(k))
    : [];
  const merged = [...valid, ...allowed.value.filter((k) => !valid.includes(k))];
  if (allowed.value.includes("arrival") && !valid.includes("arrival")) {
    const current = merged.indexOf("arrival");
    if (current >= 0) merged.splice(current, 1);
    const distributionIndex = merged.indexOf("distribution");
    merged.splice(distributionIndex >= 0 ? distributionIndex + 1 : 0, 0, "arrival");
  }
  return merged;
});
const topCategories = computed(() =>
    ordered.value.length <= 5 ? ordered.value : ordered.value.slice(0, 4),
  ),
  moreCategories = computed(() =>
    ordered.value.length <= 5 ? [] : ordered.value.slice(4),
  );
const activeInMore = computed(() =>
  moreCategories.value.includes(active.value),
);
const currentFilter = computed(() => filters[active.value]);
const hasUnifiedFilter = computed(() =>
  ["core", "quality", "distribution", "arrival", "packing", "logistics"].includes(
    active.value,
  ),
);
const cardIds = computed(() => new Set(sessionStore.state.dataCardIds));
const cardOrderIds = ref<string[]>([]);
function isCardVisible(cardId:string) {
  if (active.value === "core") return cardIds.value.has(cardId);
  if (active.value === "packing" && cardId === "packaging-statistics")
    return sessionStore.can("packing.statistics.packaging");
  if (active.value === "arrival" && ["arrival-volume", "self-pickup"].includes(cardId))
    return cardIds.value.has(cardId);
  if (active.value === "distribution" && cardId === "contractor-distribution")
    return cardIds.value.has(cardId);
  return true;
}
const currentCards = computed(() => {
  const cards = dataCardsByCategory[active.value].filter((card) => isCardVisible(card.id));
  const order = normalizeCardOrder(cardOrderIds.value, cards);
  return [...cards].sort((a, b) => order.indexOf(a.id) - order.indexOf(b.id));
});
function loadCardOrder() {
  const cards = dataCardsByCategory[active.value].filter((card) => isCardVisible(card.id));
  cardOrderIds.value = normalizeCardOrder(
    uni.getStorageSync(cardOrderStorageKey(sessionStore.state.userId, active.value)),
    cards,
  );
}
function cardOrder(id: string) {
  const index = currentCards.value.findIndex((card) => card.id === id);
  return index < 0 ? 999 : index;
}
function hasCurrentCard(id:string){return currentCards.value.some(card=>card.id===id);}
function formatMoney(value:number){return Number(value||0).toFixed(2);}
function openCardSort() {
  if (!currentCards.value.length) return;
  uni.navigateTo({ url: `/pages/data-center/card-sort?category=${active.value}` });
}
async function loadResponsibilityZones(category:CategoryKey=active.value){
  const scope=await authApi.responsibilityZones(category);
  if(category!==active.value)return;
  responsibilityZones.value=scope.zones;
  const selected=filters[category].area;
  if(selected!==allResponsibilityZonesLabel&&!scope.zones.some(zone=>zone.name===selected))filters[category].area=allResponsibilityZonesLabel;
}
function select(k: CategoryKey) {
  active.value = k;
  moreVisible.value = false;
  loadCardOrder();
  void loadResponsibilityZones(k);
}
function openFilter() {
  Object.assign(draft, currentFilter.value);
  filterVisible.value = true;
}
function applyFilter() {
  Object.assign(currentFilter.value, draft);
  filterVisible.value = false;
  load();
}
function resetFilter() {
  Object.assign(draft, {
    date: today,
    area: "全部责任区域",
    zone: active.value === "quality" ? allQualityZonesLabel : "全部分区",
    status: "全部状态",
  });
}
function openSort() {
  moreVisible.value = false;
  uni.navigateTo({ url: "/pages/data-center/category-sort" });
}
function openQualityStatistics() {
  uni.navigateTo({ url: `/features/quality/pages/statistics/index?date=${filters.quality.date}${selectedQualityZoneCode.value ? `&zone=${selectedQualityZoneCode.value}` : ''}` });
}
function openQualityAttendance() {
  uni.navigateTo({ url: "/features/workforce/pages/inspection-attendance/index" });
}
function openTrendFilter(){if(active.value==="quality")draftIssueType.value=issueType.value;trendVisible.value=true;}
async function loadQualityIssueTrend(){qualityIssueTrend.value=await qualityApi.getIssueTrend(issueType.value,selectedQualityZoneCode.value);}
async function applyTrendFilter(){if(active.value==="quality"){issueType.value=draftIssueType.value;await loadQualityIssueTrend();}trendVisible.value=false;}
async function switchAgriMode(mode:"day"|"month"){
  agriMode.value=mode;
  if(mode==="month")agriMonthDraftYear.value=Number(filters.agri.date.slice(0,4));
  agriDashboard.value=await agriMaterialApi.dashboard(filters.agri.date,agriMode.value);
}
function openAgriDatePicker(){
  if(agriMode.value==="month"){
    agriMonthDraftYear.value=Number(filters.agri.date.slice(0,4));
    agriMonthPicker.value=true;
    return;
  }
  draft.date=filters.agri.date;
  datePicker.value=true;
}
async function chooseAgriMonth(value:string){
  if(value>today.slice(0,7))return;
  const day=filters.agri.date.slice(8,10);
  const lastDay=new Date(Number(value.slice(0,4)),Number(value.slice(5,7)),0).getDate();
  filters.agri.date=`${value}-${String(Math.min(Number(day),lastDay)).padStart(2,"0")}`;
  agriMonthPicker.value=false;
  agriDashboard.value=await agriMaterialApi.dashboard(filters.agri.date,agriMode.value);
}
async function load() {
  loading.value = true;
  error.value = "";
  try {
    await loadResponsibilityZones();
    if(sessionStore.can("quality.statistics")){
      const scope=await qualityApi.getDataScope();qualityZones.value=scope.zones;
      if(filters.quality.zone!==allQualityZonesLabel&&!scope.zones.some(zone=>zone.name===filters.quality.zone))filters.quality.zone=allQualityZonesLabel;
    }
    const jobs: Promise<void>[] = [];
    if (
      cardIds.value.has("quality-supplier-admission") ||
      cardIds.value.has("quality-business-statistics")
    )
      jobs.push(
        qualityApi
          .getBusinessSummary(filters.quality.date,selectedQualityZoneCode.value)
          .then((business) => { qualityBusiness.value = business; })
          .catch(() => { qualityBusiness.value = null; }),
      );
    if (cardIds.value.has("quality-staff") && sessionStore.can("inspectionAttendance.view"))
      jobs.push(workforceApi.attendance("", "",selectedQualityZoneCode.value?[selectedQualityZoneCode.value]:qualityZones.value.map(zone=>zone.code)).then((value) => { qualityAttendance.value = value.summary; }));
    if(sessionStore.can("quality.statistics"))jobs.push(loadQualityIssueTrend());
    if (cardIds.value.has("session-size-statistics") && sessionStore.can("packing.view"))
      jobs.push(
        packingApi.sizeStatistics(filters.core.date).then((value) => {
          packingSizes.value = value;
        }),
      );
    if (cardIds.value.has("site-location-statistics"))
      jobs.push(
        siteLocationApi.statistics().then((value) => { siteLocations.value = value; }),
      );
    if (sessionStore.can("packing.statistics.packaging"))
      jobs.push(
        packingApi
          .packagingStatistics(filters.packing.date)
          .then((value) => { packagingStatistics.value = value; })
          .catch(() => { packagingStatistics.value = []; }),
      );
    if (sessionStore.can("distribution.view"))
      jobs.push(
        Promise.all([
          distributionApi.summary(filters.distribution.date,"team"),
          cardIds.value.has("site-distribution-progress") ? distributionApi.summary(filters.core.date,"site") : Promise.resolve(null),
          distributionApi.agencySummary(filters.distribution.date).catch(() => ({
            totalSupplierCount: 0,
            totalItemCount: 0,
            daySupplierCount: 0,
            dayItemCount: 0,
            nightSupplierCount: 0,
            nightItemCount: 0,
          })),
          cardIds.value.has("contractor-distribution") ? distributionApi.contractorSummary(filters.distribution.date).catch(() => ({ contracted:false })) : Promise.resolve(null),
        ]).then(([summary, siteSummary, agency, contractor]) => {
          distribution.value = summary;
          siteDistribution.value = siteSummary;
          agencyDistribution.value = agency;
          contractorDistribution.value = contractor;
        }),
      );
    if (sessionStore.can("distribution.view"))
      jobs.push(
        restockApi
          .demand(filters.distribution.date, { zone: "", type: 0 })
          .then((value) => { restockDemand.value = value; })
          .catch(() => { restockDemand.value = []; }),
      );
    if (sessionStore.can("admission.view"))
      jobs.push(
        admissionApi
          .getBusinessSummary(filters.arrival.date)
          .then((business) => { arrivalBusiness.value = business; })
          .catch(() => { arrivalBusiness.value = null; }),
      );
    if (sessionStore.can("logistics.view"))
      jobs.push(
        logisticsApi
          .dashboard(filters.logistics.date)
          .then((value) => { logisticsDashboard.value = value; })
          .catch(() => { logisticsDashboard.value = null; }),
      );
    if (sessionStore.can("agriMaterial.view"))
      jobs.push(
        agriMaterialApi
          .dashboard(filters.agri.date, agriMode.value)
          .then((value) => { agriDashboard.value = value; })
          .catch(() => { agriDashboard.value = null; }),
      );
    await Promise.all(jobs);
  } catch (e) {
    error.value = e instanceof Error ? e.message : "数据加载失败";
  } finally {
    loading.value = false;
    uni.stopPullDownRefresh();
  }
}
function chooseDate(value: string) {
  draft.date = value;
  if (active.value === "agri" && !filterVisible.value) {
    filters.agri.date = value;
    void load();
  }
  datePicker.value = false;
}
function openDistribution() {
  uni.navigateTo({
    url: `/pages/data-center/distribution-detail?date=${active.value === 'core' ? filters.core.date : filters.distribution.date}&scope=${active.value === 'core' ? 'site' : 'team'}`,
  });
}
function openPackagingStatistics() {
  uni.navigateTo({ url: "/features/packing/pages/statistics/index" });
}
function openSiteLocations() {
  uni.navigateTo({ url: "/pages/data-center/site-locations" });
}
function openLogisticsPickupProgress() {
  uni.navigateTo({ url: `/features/logistics/pages/pickup-progress/index?date=${filters.logistics.date}` });
}
onLoad(load);
onShow(() => {
  categoryOrderVersion.value += 1;
  if (!ordered.value.includes(active.value))
    active.value = ordered.value[0] || "core";
  loadCardOrder();
  uni.pageScrollTo({ scrollTop: 0, duration: 0 });
});
onPullDownRefresh(load);
</script>

<template>
  <view class="page">
    <view class="data-center-nav">
      <view />
      <b>数据中心</b>
      <text
        :class="{ disabled: !currentCards.length }"
        @click="openCardSort"
        >设置</text
      >
    </view>
    <view v-if="ordered.length > 1" class="category-bar"
      ><view
        v-for="k in topCategories"
        :key="k"
        :class="['category', { active: active === k && !activeInMore }]"
        @click="select(k)"
        >{{ labels[k] }}</view
      ><view
        v-if="moreCategories.length"
        :class="['category more', { active: activeInMore }]"
        @click="moreVisible = true"
        ><text class="more-label">更多</text><text class="more-arrow" /></view
      ></view
    >
    <view v-if="activeInMore && !['agri','logistics','arrival','centralProcurement'].includes(active)" class="section-name"
      ><b>{{ labels[active] }}数据</b
      ><text @click="moreVisible = true">切换分类</text></view
    >
    <view v-if="active === 'agri'" class="agri-filter-row">
      <view class="agri-toolbar">
        <view class="agri-mode-switch">
          <view :class="{ active: agriMode === 'day' }" @tap.stop="switchAgriMode('day')" @click.stop="switchAgriMode('day')">按日期</view>
          <view :class="{ active: agriMode === 'month' }" @tap.stop="switchAgriMode('month')" @click.stop="switchAgriMode('month')">按月份</view>
        </view>
        <view class="agri-date" @tap.stop="openAgriDatePicker" @click.stop="openAgriDatePicker">{{ agriPeriodLabel }}<i /></view>
      </view>
    </view>
    <view v-if="hasUnifiedFilter" class="filter-bar"
      ><button @click="openFilter">{{ currentFilter.date }}<i /></button
      ><button @click="openFilter">
        {{
          active === "quality"
            ? currentFilter.zone
            : active === "logistics"
              ? currentFilter.status
              : currentFilter.area
        }}<i /></button
      ><text @click="openFilter">筛选</text></view
    >
    <WareState v-if="loading" type="loading" title="正在加载数据" /><WareState
      v-else-if="error"
      type="error"
      title="加载失败"
      :description="error"
      action-label="重试"
      @action="load"
    />
    <view v-else class="cards">
      <template v-if="active === 'core'">
        <view v-if="cardIds.has('site-distribution-progress')" class="metric-card full allocation-card" :style="{ order: cardOrder('site-distribution-progress') }">
          <view class="card-head"><b>场地配货总进度</b><text class="card-link" @click="openDistribution">分区配货详情 →</text></view>
          <small class="session-scope">场次：{{ filters.core.date }}</small>
          <view class="allocation-summary">
            <span><small>全场总货量</small><b>{{ siteDistribution?.totalUnits ?? 0 }}<i>扎</i></b></span>
            <span><small>配货中</small><b>{{ pendingSiteDistributionUnits }}<i>扎</i></b></span>
            <span><small>已配货</small><b>{{ siteDistribution?.allocatedUnits ?? 0 }}<i>扎</i></b></span>
          </view>
          <small class="scope-note">统计全场地配货数据，不受账号分区权限限制</small>
          <view :class="['allocation-progress-head',{ warning: siteDistributionRate < 99.5 }]">
            <view><b>全场地配货进度</b><small>共 {{ siteDistribution?.totalShelves ?? 0 }} 个货架</small></view>
            <strong>{{ siteDistributionRate.toFixed(2) }}%</strong>
          </view>
          <view :class="['progress','allocation-progress',{ warning: siteDistributionRate < 99.5 }]"><i :style="{ width: `${siteDistributionRate}%` }" /></view>
          <view :class="['allocation-status',{ warning: siteDistributionRate < 99.5 }]">
            <b>{{ siteDistributionRate >= 99.5 ? '可以开始补货' : '暂不建议开始补货' }}</b>
            <small>配货进度达到 99.5% 后，可开始补货</small>
          </view>
        </view>
        <view v-if="cardIds.has('session-size-statistics')" class="metric-card full size-statistics-card" :style="{ order: cardOrder('session-size-statistics') }">
          <view class="card-head"><b>场次大小件统计</b><small class="session-scope">场次：{{ filters.core.date }}</small></view>
          <view class="size-total"><text>总件数</text><strong>{{ packingSizes?.total ?? 0 }}<small>件</small></strong></view>
          <view class="size-stat-row"><text>大件（&gt;55kg）</text><strong>{{ packingSizes?.large ?? 0 }}<small>件</small></strong></view>
          <view class="size-stat-row"><text>正常件（25–55kg）</text><strong>{{ packingSizes?.regular ?? 0 }}<small>件</small></strong></view>
          <view class="size-stat-row"><text>小件（18–25kg）</text><strong>{{ packingSizes?.small ?? 0 }}<small>件</small></strong></view>
          <view class="size-stat-row"><text>特小件（&lt;18kg）</text><strong>{{ packingSizes?.extraSmall ?? 0 }}<small>件</small></strong></view>
        </view>
        <view v-if="cardIds.has('site-location-statistics')" class="metric-card full location-stat-card" :style="{ order: cardOrder('site-location-statistics') }" @click="openSiteLocations">
          <view class="card-head"><b>场地货位统计</b><text class="card-link">查看明细 ›</text></view>
          <view class="location-status-head"><text>件型</text><text>启用</text><text>停用</text></view>
          <view v-for="item in siteLocations?.summary ?? []" :key="item.type" class="location-stat-row">
            <text>{{ item.label }}</text><b>{{ item.enabled }}<small>个</small></b><span>{{ item.disabled }}<small>个</small></span>
          </view>
          <view v-if="siteLocations?.summary.length" class="location-stat-row location-stat-total">
            <text>合计</text><b>{{ siteLocationTotals.enabled }}<small>个</small></b><span>{{ siteLocationTotals.disabled }}<small>个</small></span>
          </view>
          <view v-if="!siteLocations?.summary.length" class="location-stat-empty">暂无货位配置</view>
        </view>
        <view v-if="!currentCards.length" class="state-card"
          ><WareState
            type="empty"
            title="暂无核心指标"
            description="当前账号未配置核心数据卡片"
        /></view>
      </template>
      <template v-else-if="active === 'quality'">
        <view v-if="cardIds.has('quality-supplier-admission')" class="metric-card full supplier-admission-card" :style="{ order: cardOrder('quality-supplier-admission') }">
          <view class="card-head"><b>供应商入场</b><small class="session-scope">场次：{{ currentFilter.date }}</small></view>
          <view class="admission-status-grid">
            <view class="admission-total"><small>需入场</small><b>{{ qualityBusiness?.requiredSuppliers ?? 0 }}<i>家</i></b></view>
            <view><small>已入场</small><b>{{ qualityBusiness?.admittedSuppliers ?? 0 }}<i>家</i></b></view>
            <view class="pending"><small>未入场</small><b>{{ qualityBusiness?.pendingSuppliers ?? 0 }}<i>家</i></b></view>
          </view>
          <view class="admission-progress"><i :style="{ width: `${qualityBusiness?.requiredSuppliers ? Math.round(qualityBusiness.admittedSuppliers / qualityBusiness.requiredSuppliers * 100) : 0}%` }" /></view>
        </view>
        <view v-if="cardIds.has('quality-business-statistics')" class="metric-card full quality-stat-card tappable" :style="{ order: cardOrder('quality-business-statistics') }" @click="openQualityStatistics">
          <view class="card-head"><b>质检问题统计</b><text @click="openQualityStatistics">分区质检详情 ›</text></view>
          <small class="session-scope">场次：{{ currentFilter.date }}</small>
          <view class="quality-main-stats">
            <span><small>降级</small><b>{{ qualityBusiness?.downgradeUnits ?? 0 }}<i>扎</i></b></span>
            <span><small>退货</small><b>{{ qualityBusiness?.returnUnits ?? 0 }}<i>扎</i></b></span>
            <span><small>缺货</small><b>{{ qualityBusiness?.shortageUnits ?? 0 }}<i>扎</i></b></span>
            <span><small>换货</small><b>{{ qualityBusiness?.exchangeUnits ?? 0 }}<i>扎</i></b></span>
          </view>
          <view class="quality-follow-stats">
            <span><small>退货转到场</small><b>{{ qualityBusiness?.returnTransferUnits ?? qualityBusiness?.resaleUnits ?? 0 }} 扎</b></span>
            <span><small>涉及货位</small><b>{{ qualityBusiness?.involvedLocationCount ?? 0 }} 个</b></span>
            <span><small>涉及供应商</small><b>{{ qualityBusiness?.involvedSupplierCount ?? 0 }} 家</b></span>
          </view>
        </view>
        <view v-if="cardIds.has('quality-trend')" class="metric-card full" :style="{ order: cardOrder('quality-trend') }"
          ><view class="card-head"
            ><b>花材问题趋势</b
            ><button @click.stop="openTrendFilter">问题类型：{{ issueTypeLabels[issueType] }}<i /></button></view
          ><view v-if="qualityIssueTrend.length" class="issue-trend">
            <view class="trend-plot">
              <svg viewBox="0 0 700 195" preserveAspectRatio="none" aria-label="最近七个场次花材问题趋势">
                <line x1="35" y1="170" x2="665" y2="170" class="trend-baseline" />
                <path :d="qualityTrendPath" class="trend-line" />
                <g v-for="point in qualityTrendPoints" :key="point.date">
                  <circle :cx="point.x" :cy="point.y" r="7" />
                </g>
              </svg>
              <text v-for="point in qualityTrendPoints" :key="`value-${point.date}`" class="trend-value" :style="{ left: `${point.x / 7}%`, top: `${point.y / 1.95}%` }">{{ point.count }}</text>
            </view>
            <view class="trend-labels" :style="{ gridTemplateColumns: `repeat(${qualityIssueTrend.length}, minmax(0, 1fr))` }"><small v-for="item in qualityIssueTrend" :key="item.date">{{ item.date.slice(5) }}</small></view>
          </view>
          <small v-else class="trend-empty">近 7 个场次暂无花材问题数据</small>
          <small>最近 {{ qualityIssueTrend.length || 7 }} 个真实场次 · {{ currentFilter.zone }}</small></view
        >
        <view v-if="cardIds.has('quality-staff')" class="metric-card full quality-attendance-card" :style="{ order: cardOrder('quality-staff') }">
          <view class="card-head"><b>质检假勤统计</b><text @click="openQualityAttendance">查看假勤 ›</text></view>
          <view class="quality-attendance-grid">
            <span><small>质检人员</small><b>{{ qualityAttendance?.total ?? 0 }}<i>人</i></b></span>
            <span><small>出勤</small><b>{{ qualityAttendance?.present ?? 0 }}<i>人</i></b></span>
            <span class="rest"><small>休息</small><b>{{ qualityAttendance?.rest ?? 0 }}<i>人</i></b></span>
          </view>
        </view>
      </template>
      <template v-else-if="active === 'distribution'">
        <view class="metric-card full allocation-card" :style="{ order: cardOrder('distribution-progress') }">
          <view class="card-head"
            ><b>分区配货进度</b
            ><text class="card-link" @click="openDistribution"
              >分区配货详情 ›</text
            ></view
          >
          <small class="session-scope">场次：{{ currentFilter.date }}</small>
          <view class="allocation-summary">
            <span
              ><small>今日货量</small
              ><b>{{ distribution?.totalUnits ?? 0 }}<i>扎</i></b></span
            ><span
              ><small>配货中</small
              ><b>{{ pendingDistributionUnits }}<i>扎</i></b></span
            ><span
              ><small>已配货</small
              ><b>{{ distribution?.allocatedUnits ?? 0 }}<i>扎</i></b></span
            >
          </view>
          <small class="scope-note">{{ distribution?.scopeName || '当前配货团队' }}<template v-if="distribution?.zones?.length"> · {{ distribution.zones.join('、') }}区</template></small>
          <view
            :class="[
              'allocation-progress-head',
              { warning: distributionRate < 99.5 },
            ]"
            ><view
              ><b>团队分区配货进度</b
              ><small
                >共 {{ distribution?.totalShelves ?? 0 }} 个货架</small
              ></view
            ><strong>{{ distributionRate.toFixed(2) }}%</strong></view
          >
          <view
            :class="[
              'progress',
              'allocation-progress',
              { warning: distributionRate < 99.5 },
            ]"
            ><i :style="{ width: `${distributionRate}%` }" /></view
          ><view
            :class="[
              'allocation-status',
              { warning: distributionRate < 99.5 },
            ]"
            ><b>{{
              distributionRate >= 99.5
                ? "可以开始补货"
                : "暂不建议开始补货"
            }}</b
            ><small>配货进度达到 99.5% 后，可开始补货</small></view
          >
        </view>
        <view class="metric-card full agency-card" :style="{ order: cardOrder('agency-distribution') }">
          <view class="card-head">
            <b>代配货统计</b>
            <small class="session-scope">场次：{{ currentFilter.date }}</small>
          </view>
          <view class="agency-total">
            <view>
              <small>代配供应商</small>
              <b>{{ agencyDistribution?.totalSupplierCount ?? 0 }}<i>家</i></b>
            </view>
            <view>
              <small>代配货数量</small>
              <b>{{ agencyDistribution?.totalItemCount ?? 0 }}<i>扎</i></b>
            </view>
          </view>
          <view class="agency-breakdown">
            <view class="agency-row">
              <text><i class="day-dot" />白场</text>
              <span>
                <small>供应商</small>
                <b>{{ agencyDistribution?.daySupplierCount ?? 0 }} 家</b>
              </span>
              <span>
                <small>代配货</small>
                <b>{{ agencyDistribution?.dayItemCount ?? 0 }} 扎</b>
              </span>
            </view>
            <view class="agency-row">
              <text><i class="night-dot" />晚场</text>
              <span>
                <small>供应商</small>
                <b>{{ agencyDistribution?.nightSupplierCount ?? 0 }} 家</b>
              </span>
              <span>
                <small>代配货</small>
                <b>{{ agencyDistribution?.nightItemCount ?? 0 }} 扎</b>
              </span>
            </view>
          </view>
        </view>
        <view v-if="cardIds.has('contractor-distribution')" class="metric-card full contractor-card" :style="{ order: cardOrder('contractor-distribution') }">
          <view class="card-head"><b>配货统计（外包负责人）</b><small class="session-scope">场次：{{ currentFilter.date }}</small></view>
          <view v-if="!contractorDistribution?.contracted" class="contractor-empty"><b>当前不是配货外包负责人</b><small>账号未配置外包配货负责人关系，暂无可展示数据</small></view>
          <template v-else>
            <view class="contractor-top">
              <span><small>总货量</small><b>{{ contractorDistribution.itemNum ?? 0 }}<i>扎</i></b><em>补货 {{ contractorDistribution.returnReplenishNum ?? 0 }} 扎</em></span>
              <span><small>配货收益</small><b>¥{{ Number(contractorDistribution.deliveryIncome ?? 0).toFixed(2) }}</b></span>
            </view>
            <view class="contractor-summary">
              <span><small>已配</small><b>{{ contractorDistribution.prepareItemNum ?? 0 }} 扎</b></span>
              <span><small>配货完成率</small><b>{{ Number(contractorDistribution.prepareRate ?? 0).toFixed(2) }}%</b></span>
              <span><small>已配99.5%时间</small><b>{{ contractorDistribution.prepareCompleteTime || '--:--' }}</b></span>
            </view>
            <view class="contractor-target"><small>要求完成时间</small><b>{{ contractorDistribution.prepareTargetTime || '--:--' }}</b></view>
            <view class="contractor-trend-title">趋势对比（较上一场次）</view>
            <view class="contractor-trends">
              <span><b>{{ Number(contractorDistribution.itemNumDiff ?? 0) >= 0 ? '+' : '' }}{{ contractorDistribution.itemNumDiff ?? 0 }} 扎</b><small>货量变化 · {{ Number(contractorDistribution.itemNumDiffRate ?? 0).toFixed(2) }}%</small></span>
              <span><b>{{ Number(contractorDistribution.prepareRateDiff ?? 0) >= 0 ? '+' : '' }}{{ Number(contractorDistribution.prepareRateDiff ?? 0).toFixed(2) }}%</b><small>完成率变化 · {{ Number(contractorDistribution.prepareRateDiffRate ?? 0).toFixed(2) }}%</small></span>
            </view>
          </template>
        </view>
        <view class="metric-card full" :style="{ order: cardOrder('restock-units') }">
          <view class="card-head"><b>补货统计</b><small class="session-scope">场次：{{ currentFilter.date }}</small></view>
          <view class="allocation-summary">
            <span><small>需补</small><b>{{ restockSummary.need }}<i>扎</i></b></span>
            <span><small>已提交</small><b>{{ restockSummary.submitted }}<i>扎</i></b></span>
            <span><small>待提交</small><b>{{ restockSummary.pending }}<i>扎</i></b></span>
          </view>
          <view class="allocation-progress-head">
            <view><b>补货提交进度</b><small>数据来源：补货管理</small></view>
            <strong>{{ restockSubmitRate }}%</strong>
          </view>
          <view class="progress allocation-progress"><i :style="{ width: `${restockSubmitRate}%` }" /></view>
        </view>
      </template>
      <template v-else-if="active === 'arrival'">
        <view v-if="cardIds.has('arrival-volume')" class="metric-card full arrival-stat-card" :style="{ order: cardOrder('arrival-volume') }">
          <view class="card-head"><b>到场货统计</b><small class="session-scope">场次：{{ currentFilter.date }}</small></view>
          <view class="arrival-total-row">
            <view><small>销售货量</small><b>{{ arrivalBusiness?.soldUnits ?? 0 }}<i>扎</i></b></view>
            <view><small>收花量</small><b>{{ arrivalBusiness?.receivedUnits ?? 0 }}<i>扎</i></b></view>
          </view>
          <view class="arrival-sale-breakdown">
            <view class="arrival-day-block">
              <small>白场</small>
              <b>{{ arrivalBusiness?.daySoldUnits ?? 0 }}<i>扎</i></b>
            </view>
            <view class="arrival-night-block">
              <view class="arrival-night-total">
                <small>晚场</small>
                <b>{{ arrivalBusiness?.nightAddedSoldUnits ?? 0 }}<i>扎</i></b>
              </view>
              <view class="arrival-night-parts">
                <span><small>自营</small><b>{{ arrivalBusiness?.selfOperatedUnits ?? 0 }} 扎</b></span>
                <span><small>外部供应商</small><b>{{ arrivalBusiness?.externalSupplierUnits ?? 0 }} 扎</b></span>
              </view>
            </view>
          </view>
        </view>
        <view v-if="cardIds.has('self-pickup')" class="metric-card full pickup-stat-card" :style="{ order: cardOrder('self-pickup') }">
          <view class="card-head"><b>自提统计</b><small class="session-scope">场次：{{ currentFilter.date }}</small></view>
          <view class="pickup-total">
            <span><small>自提扎数合计</small><b>{{ arrivalBusiness?.pickupUnits ?? 0 }}<i>扎</i></b></span>
            <span><small>自提人数合计</small><b>{{ arrivalBusiness?.pickupPeople ?? 0 }}<i>人</i></b></span>
          </view>
          <view class="pickup-breakdown">
            <view><b>普通批发</b><span>{{ arrivalBusiness?.ordinaryPickupUnits ?? 0 }} 扎</span><small>{{ arrivalBusiness?.ordinaryPickupPeople ?? 0 }} 人</small></view>
            <view><b>分销自提</b><span>{{ arrivalBusiness?.partnerPickupUnits ?? 0 }} 扎</span><small>{{ arrivalBusiness?.partnerPickupPeople ?? 0 }} 人</small></view>
          </view>
        </view>
      </template>
      <template v-else-if="active === 'packing'">
        <view v-if="sessionStore.can('packing.statistics.packaging')" class="metric-card full packaging-stat-card" :style="{ order: cardOrder('packaging-statistics') }">
          <view class="card-head">
            <b>包装使用统计</b>
            <text class="card-link" @click="openPackagingStatistics">查看全部 ›</text>
          </view>
          <small class="session-scope">场次：{{ currentFilter.date }}</small>
          <view class="packaging-summary">
            <span><small>包装数量</small><b>{{ packagingTotal }}<i>件</i></b></span>
            <span><small>使用规格</small><b>{{ packagingStatistics.length }}<i>种</i></b></span>
          </view>
          <view v-if="packagingTop.length" class="packaging-ranking">
            <view v-for="item in packagingTop" :key="item.name" class="packaging-rank-row">
              <view><text>{{ item.name }}</text><b>{{ item.num }}<small>件</small></b></view>
              <view class="packaging-bar"><i :style="{ width: `${item.num / packagingMax * 100}%` }" /></view>
            </view>
            <small v-if="packagingOther.kinds" class="packaging-other">其余 {{ packagingOther.kinds }} 种，共 {{ packagingOther.total }} 件</small>
          </view>
          <view v-else class="packaging-empty">当前场次暂无已完成打包记录</view>
        </view>
        <view v-else class="state-card"><WareState type="forbidden" title="暂无包装统计权限" description="当前账号未配置打包包装统计权限" /></view>
      </template>
      <template v-else-if="active === 'logistics'">
        <view v-if="hasCurrentCard('logistics-outbound-collection')" class="metric-card full logistics-outbound-card" :style="{ order: cardOrder('logistics-outbound-collection') }">
          <view class="card-head"><b>出库与揽收</b><small class="session-scope">场次：{{ currentFilter.date }}</small></view>
          <view class="logistics-package-grid">
            <view><b>{{ logisticsDashboard?.outboundCollection.totalPackages ?? 0 }}</b><small>包裹数</small></view>
            <view><b>{{ logisticsDashboard?.outboundCollection.packedPackages ?? 0 }}</b><small>已打包</small></view>
            <view><b>{{ logisticsDashboard?.outboundCollection.outboundPackages ?? 0 }}</b><small>已出库</small></view>
            <view><b>{{ logisticsDashboard?.outboundCollection.pickedPackages ?? 0 }}</b><small>已揽收</small></view>
          </view>
          <view class="logistics-ring-row">
            <view class="logistics-ring">
              <view class="ring" :style="{ '--rate': `${logisticsDashboard?.outboundCollection.outboundRate ?? 0}%` }"><b>{{ logisticsDashboard?.outboundCollection.outboundRate ?? 0 }}%</b></view>
              <small>出库进度</small>
              <text>{{ logisticsDashboard?.outboundCollection.outboundPackages ?? 0 }} / {{ logisticsDashboard?.outboundCollection.totalPackages ?? 0 }}</text>
            </view>
            <view class="logistics-ring">
              <view class="ring" :style="{ '--rate': `${logisticsDashboard?.outboundCollection.pickupRate ?? 0}%` }"><b>{{ logisticsDashboard?.outboundCollection.pickupRate ?? 0 }}%</b></view>
              <small>揽收进度</small>
              <text>{{ logisticsDashboard?.outboundCollection.pickedPackages ?? 0 }} / {{ logisticsDashboard?.outboundCollection.totalPackages ?? 0 }}</text>
            </view>
          </view>
        </view>
        <view v-if="hasCurrentCard('logistics-collection-progress')" class="metric-card full logistics-progress-card tappable" :style="{ order: cardOrder('logistics-collection-progress') }" @click="openLogisticsPickupProgress">
          <view class="card-head"><b>物流揽收进度</b><text class="card-link">全部 ›</text></view>
          <view v-if="logisticsDashboard?.collectionProgress.types.length" class="logistics-type-list">
            <view v-for="item in logisticsDashboard.collectionProgress.types.slice(0,5)" :key="item.expressType" class="logistics-type-row">
              <view class="logistics-type-meta"><text>{{ item.expressName }}</text><b>{{ item.rate }}%</b></view>
              <view class="logistics-type-bar"><i :style="{ width: `${item.rate}%` }" /></view>
            </view>
            <small class="logistics-more">… 共 {{ logisticsDashboard.collectionProgress.types.length }} 项</small>
          </view>
          <view v-else class="packaging-empty">当前场次暂无物流揽收数据</view>
        </view>
      </template>
      <template v-else-if="active === 'agri'">
        <view v-if="hasCurrentCard('agri-sales-overview')" class="metric-card full agri-overview-card" :style="{ order: cardOrder('agri-sales-overview') }">
          <view class="agri-kpi-grid">
            <view><b>{{ agriDashboard?.overview.orderCount.value ?? 0 }}<small>单</small></b><span>订单</span><em :class="{ down: (agriDashboard?.overview.orderCount.compareRate ?? 0) < 0 }">{{ (agriDashboard?.overview.orderCount.compareRate ?? 0) >= 0 ? '+' : '' }}{{ agriDashboard?.overview.orderCount.compareRate ?? 0 }}%</em></view>
            <view><b>{{ formatMoney(agriDashboard?.overview.salesAmount.value ?? 0) }}<small>元</small></b><span>销售额</span><em :class="{ down: (agriDashboard?.overview.salesAmount.compareRate ?? 0) < 0 }">{{ (agriDashboard?.overview.salesAmount.compareRate ?? 0) >= 0 ? '+' : '' }}{{ agriDashboard?.overview.salesAmount.compareRate ?? 0 }}%</em></view>
            <view><b>{{ agriDashboard?.overview.supplierCount.value ?? 0 }}<small>个</small></b><span>下单供应商</span><em :class="{ down: (agriDashboard?.overview.supplierCount.compareRate ?? 0) < 0 }">{{ (agriDashboard?.overview.supplierCount.compareRate ?? 0) >= 0 ? '+' : '' }}{{ agriDashboard?.overview.supplierCount.compareRate ?? 0 }}%</em></view>
            <view><b>{{ agriDashboard?.overview.baseCount.value ?? 0 }}<small>个</small></b><span>下单基地</span><em :class="{ down: (agriDashboard?.overview.baseCount.compareRate ?? 0) < 0 }">{{ (agriDashboard?.overview.baseCount.compareRate ?? 0) >= 0 ? '+' : '' }}{{ agriDashboard?.overview.baseCount.compareRate ?? 0 }}%</em></view>
          </view>
        </view>
        <view v-if="hasCurrentCard('agri-product-sales')" class="metric-card full agri-chart-card" :style="{ order: cardOrder('agri-product-sales') }">
          <view class="card-head"><b>商品销售统计</b><small>{{ agriPeriodLabel }}</small></view>
          <view v-if="agriProductSegments.length" class="agri-donut-wrap">
            <svg class="agri-donut" viewBox="0 0 120 120" aria-label="农资商品销售占比">
              <circle cx="60" cy="60" r="40" class="agri-donut-bg" />
              <circle v-for="item in agriProductSegments" :key="item.name" cx="60" cy="60" r="40" :stroke="item.color" :stroke-dasharray="item.dashArray" :stroke-dashoffset="item.dashOffset" class="agri-donut-segment" />
              <text x="60" y="58" text-anchor="middle">{{ formatMoney(agriDashboard?.productSales.totalAmount ?? 0) }}</text>
              <text x="60" y="73" text-anchor="middle">元</text>
            </svg>
            <view class="agri-legend">
              <view v-for="item in agriProductSegments" :key="item.name"><i :style="{ background: item.color }" /><text>{{ item.name }}</text><b>{{ item.percent.toFixed(2) }}%</b></view>
            </view>
          </view>
          <view v-else class="packaging-empty">当前统计范围暂无农资商品销售数据</view>
        </view>
        <view v-if="hasCurrentCard('agri-sales-trend')" class="metric-card full agri-trend-card" :style="{ order: cardOrder('agri-sales-trend') }">
          <view class="card-head"><b>销售额趋势（近一周）</b><small>截至 {{ filters.agri.date }}</small></view>
          <view v-if="agriTrendPoints.length" class="issue-trend agri-trend">
            <view class="trend-plot">
              <svg viewBox="0 0 700 195" preserveAspectRatio="none" aria-label="农资近一周销售额趋势">
                <line x1="35" y1="170" x2="665" y2="170" class="trend-baseline" />
                <path :d="agriTrendPath" class="trend-line" />
                <g v-for="point in agriTrendPoints" :key="point.date"><circle :cx="point.x" :cy="point.y" r="7" /></g>
              </svg>
            </view>
            <view class="trend-labels" :style="{ gridTemplateColumns: `repeat(${agriTrendPoints.length}, minmax(0, 1fr))` }"><small v-for="item in agriDashboard?.salesTrend ?? []" :key="item.date">{{ item.date.slice(5) }}</small></view>
            <view class="agri-trend-legend"><i />销售额</view>
          </view>
          <small v-else class="trend-empty">近一周暂无农资销售数据</small>
        </view>
      </template>
      <template v-else
        ><view class="state-card"
          ><WareState
            type="empty"
            :title="`${labels[active]}暂无数据`"
            description="当前统计范围内暂无可展示的数据卡片" /></view
      ></template>
    </view>

    <view v-if="moreVisible" class="mask" @click="moreVisible = false"
      ><view class="drawer" @click.stop
        ><view class="drawer-head"
          ><b>更多分类</b><text @click="moreVisible = false">关闭</text></view
        ><view class="category-grid"
          ><view
            v-for="k in moreCategories"
            :key="k"
            :class="{ active: active === k }"
            @click="select(k)"
            >{{ labels[k] }}<text v-if="active === k">✓</text></view
          ></view
        ><button class="outline" @click="openSort">调整顺序</button></view
      ></view
    >
    <view v-if="filterVisible" class="mask" @click="filterVisible = false"
      ><view class="drawer filter-drawer" @click.stop
        ><view class="drawer-head"
          ><b>{{ labels[active] }}筛选</b
          ><text @click="filterVisible = false">关闭</text></view
        ><view class="filter-scroll"
          ><text class="filter-title">场次</text
          ><view class="selected-trigger" @click="datePicker = true"
            >{{ draft.date }}<i /></view
          ><template v-if="active === 'quality'"
            ><text class="filter-title">分区</text
            ><view class="option-grid"
              ><view
                v-for="x in [allQualityZonesLabel, ...qualityZones.map(zone => zone.name)]"
                :key="x"
                :class="{ active: draft.zone === x }"
                @click="draft.zone = x"
                >{{ x }}</view
              ></view
            ></template
          ><template v-else-if="active === 'logistics'"
            ><text class="filter-title">运输状态</text
            ><view class="option-grid"
              ><view
                v-for="x in ['全部状态', '待发运', '运输中', '已送达']"
                :key="x"
                :class="{ active: draft.status === x }"
                @click="draft.status = x"
                >{{ x }}</view
              ></view
            ></template
          ><template v-else
            ><text class="filter-title">责任区域</text
            ><view class="option-grid"
              ><view
                v-for="x in [allResponsibilityZonesLabel, ...responsibilityZones.map(zone => zone.name)]"
                :key="x"
                :class="{ active: draft.area === x }"
                @click="draft.area = x"
                >{{ x }}</view
              ></view
            ></template
          ></view
        ><view class="drawer-actions"
          ><button @click="resetFilter">重置</button
          ><button class="primary" @click="applyFilter">确定</button></view
        ></view
      ></view
    >
    <view v-if="trendVisible" class="mask" @click="trendVisible = false"
      ><view class="drawer trend-drawer" @click.stop
        ><view class="drawer-head"
          ><view
            ><b>{{ active === "quality" ? "花材问题趋势" : "发运趋势" }}</b
            ><small>仅筛选当前卡片</small></view
          ><text @click="trendVisible = false">关闭</text></view
        ><text class="filter-title">{{ active === "quality" ? "问题类型" : "统计时间" }}</text
        ><view v-if="active === 'quality'" class="option-grid"><view v-for="(label,key) in issueTypeLabels" :key="key" :class="{active:draftIssueType===key}" @click="draftIssueType=key">{{label}}</view></view>
        <view v-else class="option-grid"
          ><view
            v-for="x in ['近7天', '近15天', '近30天', '自定义']"
            :key="x"
            :class="{ active: trendRange === x }"
            @click="trendRange = x"
            >{{ x }}</view
          ></view
        ><view class="drawer-actions"
          ><button @click="active === 'quality' ? draftIssueType = 'all' : trendRange = '近7天'">重置</button
          ><button class="primary" @click="applyTrendFilter">
            确定
          </button></view
        ></view
      ></view
    >
    <SessionDatePicker
      v-model="draft.date"
      v-model:visible="datePicker"
      @confirm="chooseDate"
    />
    <view v-if="agriMonthPicker" class="mask" @click="agriMonthPicker = false">
      <view class="drawer agri-month-drawer" @click.stop>
        <view class="drawer-head">
          <b>选择月份</b><text @click="agriMonthPicker = false">关闭</text>
        </view>
        <view class="agri-month-year">
          <button :disabled="!canAgriPrevYear" @click="agriMonthDraftYear--">上一年</button>
          <b>{{ agriMonthDraftYear }}年</b>
          <button :disabled="!canAgriNextYear" @click="agriMonthDraftYear++">下一年</button>
        </view>
        <view class="agri-month-grid">
          <view
            v-for="item in agriMonthOptions"
            :key="item.value"
            :class="{ active: agriPeriodLabel === item.value, disabled: item.disabled }"
            @click="!item.disabled && chooseAgriMonth(item.value)"
            >{{ item.label }}</view
          >
        </view>
      </view>
    </view>
    <AppBottomNav active="data" />
  </view>
</template>

<style scoped lang="scss">
.page {
  min-height: 100vh;
  padding: calc(var(--status-bar-height) + 112rpx) 24rpx 170rpx;
  background: var(--wms-surface-page);
}
.data-center-nav {
  position: fixed;
  z-index: 20;
  top: 0;
  right: 0;
  left: 0;
  display: grid;
  height: 92rpx;
  padding-top: var(--status-bar-height);
  grid-template-columns: 100rpx 1fr 100rpx;
  align-items: center;
  border-bottom: 1rpx solid var(--wms-border);
  background: #fff;
}
.data-center-nav b {
  font-size: 29rpx;
  text-align: center;
}
.data-center-nav text {
  display: flex;
  height: 64rpx;
  align-items: center;
  justify-content: center;
  color: var(--wms-primary-700);
  font-size: 25rpx;
  font-weight: 700;
}
.data-center-nav text.disabled {
  color: var(--wms-text-secondary);
  opacity: 0.4;
  pointer-events: none;
}
.category-bar {
  display: flex;
  gap: 8rpx;
  padding: 6rpx;
  border: 1rpx solid var(--wms-border);
  border-radius: 10rpx;
  background: #fff;
}
.category {
  display: flex;
  min-width: 0;
  height: 64rpx;
  align-items: center;
  justify-content: center;
  flex: 1;
  border-radius: 7rpx;
  color: var(--wms-text-secondary);
  font-size: 25rpx;
}
.category.active {
  background: var(--wms-primary-700);
  color: #fff;
  font-weight: 700;
}
.category.more {
  display: inline-flex;
  align-items: center;
  justify-content: center;
}
.category.more .more-label {
  line-height: 1;
}
.category.more .more-arrow {
  box-sizing: border-box;
  width: 10rpx;
  height: 10rpx;
  margin-left: 8rpx;
  border-right: 2rpx solid currentColor;
  border-bottom: 2rpx solid currentColor;
  transform: translateY(-3rpx) rotate(45deg);
}
.sort-menu {
  display: flex;
  width: 64rpx;
  align-items: center;
  justify-content: center;
}
.section-name,
.card-head {
  display: flex;
  align-items: center;
  justify-content: space-between;
}
.section-name {
  padding: 18rpx 2rpx 4rpx;
}
.section-name b {
  font-size: 30rpx;
}
.section-name text,
.agri-filter-row > text,
.card-head > text {
  color: var(--wms-primary-700);
  font-size: 23rpx;
}
.filter-bar {
  display: flex;
  gap: 10rpx;
  align-items: center;
  margin-top: 14rpx;
}
.filter-bar button,
.selected-trigger,
.card-head button {
  display: flex;
  height: 56rpx;
  align-items: center;
  gap: 9rpx;
  margin: 0;
  padding: 0 14rpx;
  border: 1rpx solid var(--wms-border);
  border-radius: 8rpx;
  background: #fff;
  color: var(--wms-primary-700);
  font-size: 21rpx;
  line-height: 56rpx;
}
.filter-bar button:after,
.card-head button:after {
  border: 0;
}
.filter-bar > text {
  margin-left: auto;
  color: var(--wms-primary-700);
  font-size: 23rpx;
}
.filter-bar i,
.selected-trigger i,
.card-head button i {
  width: 8rpx;
  height: 8rpx;
  border-right: 2rpx solid;
  border-bottom: 2rpx solid;
  transform: rotate(45deg);
}
.cards {
  display: grid;
  grid-template-columns: repeat(2, minmax(0, 1fr));
  gap: 14rpx;
  margin-top: 16rpx;
}
.metric-card {
  box-sizing: border-box;
  min-height: 190rpx;
  padding: 22rpx;
  border: 1rpx solid var(--wms-border);
  border-radius: var(--wms-radius-card);
  background: #fff;
  box-shadow: var(--wms-shadow-card);
}
.metric-card.tappable {
  cursor: pointer;
}
.metric-card.full,
.state-card {
  grid-column: 1/-1;
}
.metric-card > text,
.metric-card > small {
  display: block;
}
.metric-card > text,
.metric-card > .card-head > b {
  font-size: 25rpx;
  font-weight: 700;
}
.metric-card > b,
.metric-card > strong {
  display: block;
  margin-top: 20rpx;
  font-size: 42rpx;
  font-variant-numeric: tabular-nums;
}
.metric-card small {
  color: var(--wms-text-secondary);
  font-size: 21rpx;
  font-weight: 400;
}
.metric-card .session-scope {
  display: block;
  margin-top: 8rpx;
  color: var(--wms-text-secondary);
  font-size: 21rpx;
  font-weight: 500;
  line-height: 1.4;
}
.card-head .session-scope {
  margin-top: 0;
  white-space: nowrap;
}
.progress {
  height: 10rpx;
  margin: 16rpx 0 10rpx;
  border-radius: 8rpx;
  background: var(--wms-surface-soft);
  overflow: hidden;
}
.progress i {
  display: block;
  height: 100%;
  background: var(--wms-primary-700);
}
.pair,
.distribution {
  display: flex;
  margin-top: 18rpx;
}
.pair span,
.distribution span {
  display: flex;
  min-width: 0;
  flex: 1;
  flex-direction: column;
}
.pair span + span,
.distribution span + span {
  padding-left: 20rpx;
  border-left: 1rpx solid var(--wms-border);
}
.pair b,
.distribution b {
  font-size: 34rpx;
}
.actionable:active {
  opacity: 0.75;
}
.card-link {
  color: var(--wms-primary-700);
  font-size: 22rpx;
}
.allocation-card {
  min-height: 0;
}
.allocation-summary {
  display: grid;
  grid-template-columns: repeat(3, minmax(0, 1fr));
  margin-top: 24rpx;
}
.allocation-summary span {
  min-width: 0;
  padding: 0 18rpx;
  border-right: 1rpx solid var(--wms-border);
}
.allocation-summary span:first-child {
  padding-left: 0;
}
.allocation-summary span:last-child {
  padding-right: 0;
  border-right: 0;
}
.allocation-summary small,
.allocation-summary b {
  display: block;
}
.allocation-summary b {
  margin-top: 8rpx;
  color: var(--wms-primary-700);
  font-size: 36rpx;
  white-space: nowrap;
}
.allocation-summary i {
  margin-left: 3rpx;
  font-size: 19rpx;
  font-style: normal;
  font-weight: 500;
}
.scope-note {
  display: block;
  margin-top: 18rpx;
}
.allocation-progress-head {
  display: flex;
  align-items: flex-end;
  justify-content: space-between;
  margin-top: 24rpx;
  padding-top: 22rpx;
  border-top: 1rpx solid var(--wms-border);
}
.allocation-progress-head b,
.allocation-progress-head small {
  display: block;
}
.allocation-progress-head b {
  font-size: 25rpx;
}
.allocation-progress-head small {
  margin-top: 5rpx;
}
.allocation-progress-head strong {
  color: var(--wms-primary-700);
  font-size: 38rpx;
  font-variant-numeric: tabular-nums;
}
.allocation-progress-head.warning strong {
  color: var(--wms-warning);
}
.allocation-progress {
  height: 14rpx;
  margin-top: 15rpx;
}
.allocation-progress.warning {
  background: color-mix(in srgb, var(--wms-warning) 14%, white);
}
.allocation-progress.warning i {
  background: var(--wms-warning);
}
.allocation-status {
  display: flex;
  align-items: baseline;
  justify-content: space-between;
  gap: 16rpx;
  margin-top: 12rpx;
  padding: 14rpx 16rpx;
  border-radius: 10rpx;
  background: var(--wms-surface-soft);
}
.allocation-status b {
  color: var(--wms-primary-700);
  font-size: 23rpx;
}
.allocation-status small {
  text-align: right;
}
.allocation-status.warning {
  background: color-mix(in srgb, var(--wms-warning) 12%, white);
}
.allocation-status.warning b,
.allocation-status.warning small {
  color: var(--wms-warning);
}
.agency-card {
  min-height: 0;
}
.agency-total {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 14rpx;
  margin-top: 20rpx;
}
.agency-total > view {
  padding: 18rpx 20rpx;
  border-radius: 12rpx;
  background: var(--wms-surface-soft);
}
.agency-total small,
.agency-total b {
  display: block;
}
.agency-total b {
  margin-top: 7rpx;
  color: var(--wms-primary-700);
  font-size: 36rpx;
}
.agency-total i {
  margin-left: 4rpx;
  font-size: 19rpx;
  font-style: normal;
  font-weight: 500;
}
.agency-breakdown {
  margin-top: 16rpx;
  border-top: 1rpx solid var(--wms-border);
}
.agency-row {
  display: grid;
  min-height: 82rpx;
  grid-template-columns: 120rpx 1fr 1fr;
  align-items: center;
  border-bottom: 1rpx solid var(--wms-border);
}
.agency-row:last-child {
  border-bottom: 0;
}
.agency-row > text {
  display: flex;
  align-items: center;
  gap: 10rpx;
  font-size: 23rpx;
  font-weight: 700;
}
.agency-row > text i {
  width: 12rpx;
  height: 12rpx;
  border-radius: 50%;
  background: var(--wms-primary-700);
}
.agency-row > text .night-dot {
  background: var(--wms-warning);
}
.agency-row span small,
.agency-row span b {
  display: block;
}
.agency-row span b {
  margin-top: 3rpx;
  font-size: 23rpx;
}
.contractor-card{min-height:0}.contractor-empty{margin-top:18rpx;padding:34rpx 20rpx;border-radius:12rpx;background:var(--wms-surface-soft);text-align:center}.contractor-empty b,.contractor-empty small{display:block}.contractor-empty small{margin-top:8rpx;color:var(--wms-text-secondary);font-size:20rpx}.contractor-top{display:grid;grid-template-columns:1.35fr 1fr;gap:14rpx;margin-top:18rpx}.contractor-top>span{padding:17rpx;border-radius:12rpx;background:var(--wms-surface-soft)}.contractor-top small,.contractor-top b,.contractor-top em{display:block}.contractor-top b{margin-top:5rpx;color:var(--wms-primary-700);font-size:31rpx}.contractor-top i{margin-left:3rpx;font-size:18rpx;font-style:normal}.contractor-top em{margin-top:3rpx;color:var(--wms-text-secondary);font-size:18rpx;font-style:normal}.contractor-summary{display:grid;grid-template-columns:repeat(3,1fr);margin-top:16rpx;padding:15rpx 0;border-top:1rpx solid var(--wms-border);border-bottom:1rpx solid var(--wms-border)}.contractor-summary span{text-align:center}.contractor-summary span+span{border-left:1rpx solid var(--wms-border)}.contractor-summary small,.contractor-summary b{display:block}.contractor-summary b{margin-top:5rpx;font-size:22rpx}.contractor-target{display:flex;margin-top:14rpx;padding:13rpx 16rpx;align-items:center;justify-content:space-between;border:1rpx solid var(--wms-border);border-radius:10rpx}.contractor-target b{color:var(--wms-warning);font-size:24rpx}.contractor-trend-title{margin-top:17rpx;color:var(--wms-text-secondary);font-size:20rpx}.contractor-trends{display:grid;grid-template-columns:1fr 1fr;gap:12rpx;margin-top:10rpx}.contractor-trends span{padding:14rpx;border-radius:10rpx;background:var(--wms-surface-soft);text-align:center}.contractor-trends b,.contractor-trends small{display:block}.contractor-trends b{color:var(--wms-primary-700);font-size:24rpx}.contractor-trends small{margin-top:5rpx;color:var(--wms-text-secondary);font-size:18rpx}
.arrival-stat-card,
.pickup-stat-card {
  min-height: 0;
}
.supplier-admission-card,
.quality-stat-card {
  min-height: 0;
}
.admission-status-grid {
  display: grid;
  grid-template-columns: 1.15fr 1fr 1fr;
  gap: 12rpx;
  margin-top: 18rpx;
}
.admission-status-grid > view {
  padding: 16rpx;
  border-radius: 12rpx;
  background: var(--wms-surface-soft);
}
.admission-status-grid small,
.admission-status-grid b {
  display: block;
}
.admission-status-grid b {
  margin-top: 6rpx;
  color: var(--wms-primary-700);
  font-size: 31rpx;
}
.admission-status-grid i,
.quality-main-stats i {
  margin-left: 3rpx;
  font-size: 18rpx;
  font-style: normal;
  font-weight: 500;
}
.admission-status-grid .pending b {
  color: var(--wms-warning);
}
.admission-progress {
  height: 7rpx;
  margin-top: 14rpx;
  overflow: hidden;
  border-radius: 6rpx;
  background: var(--wms-border);
}
.admission-progress i {
  display: block;
  height: 100%;
  border-radius: inherit;
  background: var(--wms-primary-700);
}
.quality-main-stats {
  display: grid;
  grid-template-columns: repeat(4, minmax(0, 1fr));
  gap: 10rpx;
  margin-top: 18rpx;
}
.quality-main-stats span,
.quality-follow-stats span {
  min-width: 0;
}
.quality-main-stats small,
.quality-main-stats b,
.quality-follow-stats small,
.quality-follow-stats b {
  display: block;
}
.quality-main-stats b {
  margin-top: 5rpx;
  color: var(--wms-primary-700);
  font-size: 27rpx;
  white-space: nowrap;
}
.quality-follow-stats {
  display: grid;
  grid-template-columns: repeat(3, minmax(0, 1fr));
  gap: 12rpx;
  margin-top: 16rpx;
  padding-top: 15rpx;
  border-top: 1rpx solid var(--wms-border);
}
.quality-follow-stats span {
  padding: 12rpx 15rpx;
  border-radius: 10rpx;
  background: var(--wms-surface-soft);
}
.quality-follow-stats span:nth-child(n + 4) {
  display: none;
}
.quality-attendance-grid {
  display: grid;
  grid-template-columns: repeat(3, minmax(0, 1fr));
  margin-top: 20rpx;
}
.quality-attendance-grid span {
  min-width: 0;
  padding: 0 18rpx;
  border-left: 1rpx solid var(--wms-border);
}
.quality-attendance-grid span:first-child {
  padding-left: 0;
  border-left: 0;
}
.quality-attendance-grid small,
.quality-attendance-grid b {
  display: block;
}
.quality-attendance-grid b {
  margin-top: 6rpx;
  color: var(--wms-primary-700);
  font-size: 34rpx;
  font-variant-numeric: tabular-nums;
}
.quality-attendance-grid .rest b {
  color: var(--wms-text-secondary);
}
.quality-attendance-grid i {
  margin-left: 4rpx;
  font-size: 19rpx;
  font-style: normal;
  font-weight: 500;
}
.quality-follow-stats b {
  margin-top: 4rpx;
  font-size: 23rpx;
}
.arrival-total-row {
  display: grid;
  grid-template-columns: repeat(2, minmax(0, 1fr));
  gap: 14rpx;
  margin-top: 18rpx;
}
.arrival-total-row > view {
  padding: 17rpx 18rpx;
  border-radius: 12rpx;
  background: var(--wms-surface-soft);
}
.arrival-total-row small,
.arrival-total-row b,
.arrival-day-block small,
.arrival-day-block b,
.arrival-night-total small,
.arrival-night-total b,
.arrival-night-parts small,
.arrival-night-parts b {
  display: block;
}
.arrival-total-row b {
  margin-top: 6rpx;
  color: var(--wms-primary-700);
  font-size: 34rpx;
}
.arrival-total-row i,
.arrival-day-block i,
.arrival-night-total i,
.pickup-total i {
  margin-left: 3rpx;
  font-size: 18rpx;
  font-style: normal;
  font-weight: 500;
}
.arrival-sale-breakdown {
  display: grid;
  grid-template-columns: 0.8fr 2fr;
  gap: 14rpx;
  margin-top: 14rpx;
  padding-top: 16rpx;
  border-top: 1rpx solid var(--wms-border);
}
.arrival-day-block,
.arrival-night-block {
  padding: 15rpx 16rpx;
  border: 1rpx solid var(--wms-border);
  border-radius: 12rpx;
}
.arrival-day-block b,
.arrival-night-total b {
  margin-top: 5rpx;
  color: var(--wms-primary-700);
  font-size: 28rpx;
  white-space: nowrap;
}
.arrival-night-block {
  display: grid;
  grid-template-columns: 0.8fr 1.6fr;
  align-items: center;
  gap: 14rpx;
}
.arrival-night-parts {
  display: grid;
  grid-template-columns: repeat(2, minmax(0, 1fr));
  gap: 10rpx;
  padding-left: 14rpx;
  border-left: 1rpx solid var(--wms-border);
}
.arrival-night-parts small {
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
}
.arrival-night-parts b {
  margin-top: 4rpx;
  font-size: 21rpx;
  white-space: nowrap;
}
.pickup-total {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 14rpx;
  margin-top: 18rpx;
}
.pickup-total span {
  padding: 17rpx 18rpx;
  border-radius: 12rpx;
  background: var(--wms-surface-soft);
}
.pickup-total small,
.pickup-total b {
  display: block;
}
.pickup-total b {
  margin-top: 6rpx;
  color: var(--wms-primary-700);
  font-size: 34rpx;
}
.pickup-breakdown {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 14rpx;
  margin-top: 16rpx;
}
.pickup-breakdown > view {
  display: grid;
  grid-template-columns: 1fr auto;
  gap: 7rpx 10rpx;
  padding: 15rpx 18rpx;
  border: 1rpx solid var(--wms-border);
  border-radius: 10rpx;
}
.pickup-breakdown b {
  grid-column: 1/-1;
  font-size: 22rpx;
}
.pickup-breakdown span {
  color: var(--wms-text);
  font-size: 22rpx;
  font-weight: 700;
}
.pickup-breakdown small {
  text-align: right;
}
.trend {
  display: flex;
  height: 150rpx;
  align-items: flex-end;
  gap: 18rpx;
  margin: 18rpx 8rpx 10rpx;
  border-bottom: 1rpx solid var(--wms-border);
}
.trend i {
  flex: 1;
  border-radius: 5rpx 5rpx 0 0;
  background: var(--wms-primary-700);
  opacity: 0.78;
}
.issue-trend {
  margin: 18rpx 0 12rpx;
}
.trend-plot {
  position: relative;
  height: 195rpx;
}
.issue-trend svg {
  display: block;
  width: 100%;
  height: 195rpx;
  overflow: visible;
}
.issue-trend .trend-baseline {
  stroke: var(--wms-border);
  stroke-width: 2;
}
.issue-trend .trend-line {
  fill: none;
  stroke: var(--wms-primary-700);
  stroke-linecap: round;
  stroke-linejoin: round;
  stroke-width: 6;
}
.issue-trend circle {
  fill: #fff;
  stroke: var(--wms-primary-700);
  stroke-width: 5;
}
.trend-value {
  position: absolute;
  color: var(--wms-primary-900);
  font-size: 20rpx;
  font-weight: 700;
  font-variant-numeric: tabular-nums;
  line-height: 1;
  transform: translate(-50%, -150%);
}
.trend-labels {
  display: grid;
  margin-top: -4rpx;
}
.trend-labels small {
  font-size: 18rpx;
  text-align: center;
  white-space: nowrap;
}
.trend-empty {
  display: flex;
  min-height: 150rpx;
  align-items: center;
  justify-content: center;
}
.state-card {
  background: #fff;
  border-radius: var(--wms-radius-card);
}
.mask {
  position: fixed;
  z-index: 30;
  inset: 0;
  background: rgba(23, 43, 41, 0.45);
}
.drawer {
  position: absolute;
  right: 0;
  bottom: 0;
  left: 0;
  box-sizing: border-box;
  min-height: 390rpx;
  max-height: 78vh;
  padding: 28rpx 24rpx calc(28rpx + env(safe-area-inset-bottom));
  border-radius: 24rpx 24rpx 0 0;
  background: #fff;
  overflow-y: auto;
}
.drawer-head {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 24rpx;
}
.drawer-head b {
  font-size: 30rpx;
}
.drawer-head text {
  color: var(--wms-primary-700);
  font-size: 24rpx;
}
.drawer-head small {
  display: block;
  margin-top: 5rpx;
  color: var(--wms-text-secondary);
  font-size: 21rpx;
}
.filter-drawer {
  display: flex;
  flex-direction: column;
  overflow: hidden;
}
.filter-drawer .drawer-head {
  flex: 0 0 auto;
}
.filter-scroll {
  min-height: 0;
  flex: 1 1 auto;
  overflow-y: auto;
  overscroll-behavior: contain;
  padding-bottom: 12rpx;
}
.category-grid,
.option-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 12rpx;
}
.category-grid view,
.option-grid view {
  position: relative;
  display: flex;
  min-height: 78rpx;
  align-items: center;
  justify-content: center;
  border: 1rpx solid var(--wms-border);
  border-radius: 8rpx;
  background: var(--wms-surface-page);
  font-size: 25rpx;
}
.category-grid .active,
.option-grid .active {
  border-color: var(--wms-primary-700);
  background: var(--wms-surface-soft);
  color: var(--wms-primary-700);
  font-weight: 700;
}
.category-grid view text {
  position: absolute;
  right: 8rpx;
  top: 5rpx;
}
.outline {
  margin-top: 28rpx;
  border: 1rpx solid var(--wms-primary-700);
  background: #fff;
  color: var(--wms-primary-700);
  font-size: 25rpx;
}
.filter-title {
  display: block;
  margin: 22rpx 0 12rpx;
  font-size: 24rpx;
  font-weight: 700;
}
.selected-trigger {
  width: 100%;
  box-sizing: border-box;
  justify-content: space-between;
}
.drawer-actions {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 14rpx;
  margin-top: 34rpx;
}
.filter-drawer .drawer-actions {
  flex: 0 0 auto;
  margin-top: 20rpx;
  padding-top: 16rpx;
  border-top: 1rpx solid var(--wms-border);
  background: #fff;
}
.filter-drawer .drawer-actions button {
  width: 100%;
  height: 88rpx;
  margin: 0;
  padding: 0;
  border-radius: 10rpx;
  font-size: 28rpx;
  line-height: 88rpx;
}
.drawer-actions button {
  font-size: 26rpx;
}
.drawer-actions .primary {
  background: var(--wms-primary-700);
  color: #fff;
}
.size-statistics-card {
  padding-bottom: 8rpx;
}
.size-statistics-card .card-head small {
  color: var(--wms-primary-700);
  font-size: 22rpx;
  font-weight: 650;
}
.size-total,
.size-stat-row {
  display: flex;
  min-height: 72rpx;
  align-items: center;
  justify-content: space-between;
  border-top: 1rpx solid var(--wms-border);
}
.size-total {
  margin-top: 14rpx;
}
.size-total text,
.size-stat-row text {
  color: var(--wms-text-primary);
  font-size: 23rpx;
}
.size-total strong,
.size-stat-row strong {
  font-size: 27rpx;
  font-weight: 750;
}
.size-total strong small,
.size-stat-row strong small {
  margin-left: 3rpx;
  color: inherit;
  font-size: 19rpx;
  font-weight: 500;
}
.packaging-summary {
  display: grid;
  grid-template-columns: 1fr 1fr;
  margin-top: 18rpx;
  padding: 18rpx 0;
  border-top: 1rpx solid var(--wms-border);
  border-bottom: 1rpx solid var(--wms-border);
}
.packaging-summary span {
  padding: 0 20rpx;
  border-right: 1rpx solid var(--wms-border);
}
.packaging-summary span:first-child { padding-left: 0; }
.packaging-summary span:last-child { border-right: 0; }
.packaging-summary small,
.packaging-summary b { display: block; }
.packaging-summary b { margin-top: 5rpx; font-size: 34rpx; }
.packaging-summary i { margin-left: 5rpx; font-size: 19rpx; font-style: normal; font-weight: 500; }
.packaging-ranking { margin-top: 18rpx; }
.packaging-rank-row { margin-top: 15rpx; }
.packaging-rank-row:first-child { margin-top: 0; }
.packaging-rank-row > view:first-child { display: flex; align-items: center; justify-content: space-between; gap: 20rpx; }
.packaging-rank-row text { overflow: hidden; font-size: 22rpx; white-space: nowrap; text-overflow: ellipsis; }
.packaging-rank-row b { flex: none; font-size: 23rpx; }
.packaging-rank-row b small { margin-left: 3rpx; color: inherit; font-size: 17rpx; font-weight: 500; }
.packaging-bar { height: 8rpx; margin-top: 8rpx; overflow: hidden; border-radius: 8rpx; background: var(--wms-border); }
.packaging-bar i { display: block; height: 100%; border-radius: inherit; background: var(--wms-primary-700); }
.packaging-other { display: block; margin-top: 17rpx; color: var(--wms-text-secondary); text-align: right; }
.packaging-empty { padding: 36rpx 0 20rpx; color: var(--wms-text-secondary); font-size: 22rpx; text-align: center; }
.location-stat-card { cursor: pointer; }
.location-status-head,
.location-stat-row { display: grid; grid-template-columns: 1.5fr 1fr 1fr; align-items: center; }
.location-status-head { height: 48rpx; margin-top: 14rpx; padding: 0 12rpx; background: var(--wms-primary-700); color: #fff; font-size: 18rpx; }
.location-status-head text:not(:first-child) { text-align: right; }
.location-stat-row { min-height: 64rpx; padding: 0 12rpx; border-bottom: 1rpx solid var(--wms-border); }
.location-stat-row > text { font-size: 22rpx; font-weight: 650; }
.location-stat-row > b,
.location-stat-row > span { text-align: right; font-size: 25rpx; }
.location-stat-row > b { color: var(--wms-success); }
.location-stat-row > span { color: var(--wms-text-secondary); }
.location-stat-row small { display: inline; margin-left: 3rpx; color: inherit; font-size: 17rpx; font-weight: 500; }
.location-stat-total { margin-top: 4rpx; border-bottom: 0; background: var(--wms-surface-soft); }
.location-stat-total > text,
.location-stat-total > b,
.location-stat-total > span { font-weight: 800; }
.location-stat-empty { padding: 28rpx 0 12rpx; color: var(--wms-text-secondary); font-size: 21rpx; text-align: center; }
.logistics-outbound-card,
.logistics-progress-card { min-height: 0; }
.logistics-main-grid {
  display: grid;
  grid-template-columns: repeat(3, minmax(0, 1fr));
  gap: 10rpx;
  margin-top: 20rpx;
}
.logistics-main-grid view {
  min-width: 0;
  padding: 18rpx 10rpx;
  border-radius: 14rpx;
  background: var(--wms-surface-soft);
  text-align: center;
}
.logistics-main-grid b,
.logistics-main-grid small,
.logistics-main-grid i { display: block; }
.logistics-main-grid small { color: var(--wms-text-secondary); font-size: 20rpx; }
.logistics-main-grid b { margin-top: 8rpx; color: var(--wms-text-main); font-size: 34rpx; font-variant-numeric: tabular-nums; }
.logistics-main-grid i { margin-top: 2rpx; font-size: 18rpx; font-style: normal; font-weight: 500; }
.logistics-sub-grid {
  display: grid;
  grid-template-columns: repeat(3, minmax(0, 1fr));
  gap: 10rpx;
  margin-top: 14rpx;
}
.logistics-sub-grid span {
  min-width: 0;
  padding: 14rpx 10rpx;
  border: 1rpx solid var(--wms-border);
  border-radius: 12rpx;
}
.logistics-sub-grid small,
.logistics-sub-grid b { display: block; }
.logistics-sub-grid b { margin-top: 6rpx; font-size: 24rpx; font-variant-numeric: tabular-nums; white-space: nowrap; }
.logistics-progress-top {
  display: flex;
  align-items: flex-end;
  justify-content: space-between;
  margin-top: 18rpx;
}
.logistics-progress-top b { color: var(--wms-primary-700); font-size: 44rpx; font-variant-numeric: tabular-nums; }
.logistics-progress-top i { margin-left: 2rpx; font-size: 22rpx; font-style: normal; }
.logistics-progress-top small { display: block; margin-top: 4rpx; }
.logistics-type-list { display: grid; gap: 16rpx; margin-top: 18rpx; }
.logistics-type-row { min-width: 0; }
.logistics-type-meta { display: flex; align-items: center; justify-content: space-between; gap: 14rpx; }
.logistics-type-meta text { min-width: 0; color: var(--wms-text-main); font-size: 24rpx; font-weight: 700; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
.logistics-type-meta b { color: var(--wms-primary-700); font-size: 23rpx; font-variant-numeric: tabular-nums; white-space: nowrap; }
.logistics-type-bar { height: 10rpx; margin: 9rpx 0 5rpx; border-radius: 999rpx; background: var(--wms-surface-soft); overflow: hidden; }
.logistics-type-bar i { display: block; height: 100%; border-radius: inherit; background: var(--wms-primary-700); }
.logistics-type-row small { color: var(--wms-text-secondary); font-size: 20rpx; }
.logistics-package-grid {
  display: grid;
  grid-template-columns: repeat(4, minmax(0, 1fr));
  margin-top: 22rpx;
}
.logistics-package-grid view {
  min-width: 0;
  text-align: center;
}
.logistics-package-grid view + view { border-left: 1rpx solid var(--wms-border); }
.logistics-package-grid b,
.logistics-package-grid small { display: block; }
.logistics-package-grid b {
  color: var(--wms-text-main);
  font-size: 34rpx;
  font-variant-numeric: tabular-nums;
}
.logistics-package-grid small {
  margin-top: 7rpx;
  color: var(--wms-text-secondary);
  font-size: 20rpx;
}
.logistics-ring-row {
  display: grid;
  grid-template-columns: repeat(2, minmax(0, 1fr));
  gap: 30rpx;
  margin-top: 30rpx;
}
.logistics-ring {
  display: flex;
  align-items: center;
  flex-direction: column;
}
.logistics-ring .ring {
  display: flex;
  width: 112rpx;
  height: 112rpx;
  align-items: center;
  justify-content: center;
  border-radius: 50%;
  background: conic-gradient(var(--wms-primary-700) var(--rate), var(--wms-surface-soft) 0);
  position: relative;
}
.logistics-ring .ring::after {
  position: absolute;
  inset: 16rpx;
  border-radius: 50%;
  background: #fff;
  content: "";
}
.logistics-ring .ring b {
  position: relative;
  z-index: 1;
  font-size: 25rpx;
}
.logistics-ring small {
  margin-top: 12rpx;
  color: var(--wms-text-secondary);
  font-size: 21rpx;
}
.logistics-ring text {
  margin-top: 4rpx;
  color: var(--wms-text-secondary);
  font-size: 19rpx;
}
.logistics-more {
  display: block;
  margin-top: 12rpx;
  text-align: center;
}
.agri-overview-card,
.agri-chart-card,
.agri-trend-card { min-height: 0; }
.agri-filter-row { padding: 18rpx 2rpx 4rpx; }
.agri-filter-row .agri-toolbar { width: 100%; }
.agri-toolbar { display: flex; align-items: center; justify-content: space-between; gap: 16rpx; }
.agri-mode-switch { display: flex; gap: 8rpx; padding: 5rpx; border-radius: 18rpx; background: var(--wms-surface-soft); }
.agri-mode-switch view,
.agri-date { height: 56rpx; margin: 0; padding: 0 22rpx; border: 0; border-radius: 16rpx; background: transparent; color: var(--wms-text-secondary); font-size: 22rpx; line-height: 56rpx; }
.agri-mode-switch button:after,
.agri-date:after { border: 0; }
.agri-mode-switch view.active { background: var(--wms-primary-700); color: #fff; font-weight: 800; }
.agri-date { display: flex; min-width: 116rpx; box-sizing: border-box; align-items: center; justify-content: flex-end; gap: 8rpx; padding-right: 8rpx; background: #fff; color: var(--wms-text-main); }
.agri-date i { width: 12rpx; height: 12rpx; border-right: 3rpx solid var(--wms-text-secondary); border-bottom: 3rpx solid var(--wms-text-secondary); transform: rotate(45deg) translateY(-3rpx); }
.agri-kpi-grid { display: grid; grid-template-columns: repeat(4, minmax(0, 1fr)); gap: 8rpx; margin-top: 18rpx; }
.agri-kpi-grid view { min-width: 0; padding: 16rpx 8rpx; border-radius: 12rpx; background: var(--wms-surface-soft); text-align: center; }
.agri-kpi-grid b,
.agri-kpi-grid span,
.agri-kpi-grid em { display: block; }
.agri-kpi-grid b { color: var(--wms-text-main); font-size: 27rpx; font-variant-numeric: tabular-nums; white-space: nowrap; }
.agri-kpi-grid small { margin-left: 2rpx; font-size: 18rpx; }
.agri-kpi-grid span { margin-top: 6rpx; color: var(--wms-text-secondary); font-size: 20rpx; }
.agri-kpi-grid em { margin-top: 8rpx; color: var(--wms-primary-700); font-size: 18rpx; font-style: normal; }
.agri-kpi-grid em.down { color: var(--wms-danger); }
.agri-donut-wrap { display: grid; grid-template-columns: 250rpx minmax(0, 1fr); align-items: center; gap: 18rpx; margin-top: 18rpx; }
.agri-donut { width: 250rpx; height: 250rpx; overflow: visible; }
.agri-donut-bg { fill: none; stroke: var(--wms-surface-soft); stroke-width: 36; }
.agri-donut-segment { fill: none; stroke-width: 36; transform: rotate(-90deg); transform-origin: 60px 60px; transition: stroke-dasharray 0.2s ease; }
.agri-donut text:first-of-type { fill: var(--wms-primary-900); font-size: 16px; font-weight: 800; }
.agri-donut text:last-of-type { fill: var(--wms-text-secondary); font-size: 10px; }
.agri-legend { min-width: 0; }
.agri-legend view { display: grid; grid-template-columns: 16rpx minmax(0, 1fr) auto; align-items: center; gap: 10rpx; margin-top: 13rpx; }
.agri-legend view:first-child { margin-top: 0; }
.agri-legend i { width: 16rpx; height: 16rpx; border-radius: 50%; }
.agri-legend text { overflow: hidden; font-size: 21rpx; white-space: nowrap; text-overflow: ellipsis; }
.agri-legend b { color: var(--wms-text-secondary); font-size: 20rpx; }
.agri-trend .trend-line { stroke: var(--wms-primary-700); }
.agri-trend circle { stroke: var(--wms-primary-700); }
.agri-trend-legend { display: flex; align-items: center; justify-content: center; gap: 8rpx; margin-top: 10rpx; color: var(--wms-text-secondary); font-size: 20rpx; }
.agri-trend-legend i { width: 28rpx; height: 5rpx; border-radius: 5rpx; background: var(--wms-primary-700); }
.agri-month-drawer { min-height: 420rpx; }
.agri-month-year { display: grid; grid-template-columns: 140rpx 1fr 140rpx; align-items: center; gap: 14rpx; margin-bottom: 20rpx; }
.agri-month-year b { color: var(--wms-primary-900); font-size: 30rpx; text-align: center; }
.agri-month-year button { height: 58rpx; margin: 0; border: 1rpx solid var(--wms-border); border-radius: 10rpx; background: #fff; color: var(--wms-primary-700); font-size: 22rpx; line-height: 58rpx; }
.agri-month-year button:after { border: 0; }
.agri-month-year button[disabled] { color: var(--wms-text-secondary); opacity: 0.45; }
.agri-month-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 12rpx; }
.agri-month-grid view { height: 72rpx; border: 1rpx solid var(--wms-border); border-radius: 10rpx; background: #fff; color: var(--wms-text-main); font-size: 24rpx; line-height: 72rpx; text-align: center; }
.agri-month-grid view.active { border-color: var(--wms-primary-700); background: var(--wms-primary-700); color: #fff; font-weight: 800; }
.agri-month-grid view.disabled { background: var(--wms-surface-soft); color: var(--wms-text-secondary); opacity: 0.45; }
</style>
