<script setup lang="ts">
import { computed, ref } from 'vue'
import { onLoad } from '@dcloudio/uni-app'
import { qualityApi } from '../../api/quality.api'
import type { QualityTask, ReasonGroup } from '../../models/quality'
import { qualityService } from '../../services/quality.service'
import WareState from '@/shared/components/WareState.vue'
import WareStatus from '@/shared/components/WareStatus.vue'
import { sessionStore } from '@/store/session'

const task = ref<QualityTask | null>(null)
const loading = ref(true)
const submitting = ref(false)
const error = ref('')
const result = ref<1 | 2 | 10>(1)
const remark = ref('')
const reasonId = ref<number>()
const reasonGroups = ref<ReasonGroup[]>([])
const reasonOptions = computed(() => reasonGroups.value.flatMap(group => group.reasons.map(reason => ({ ...reason, group: group.name }))))

async function load(taskId: number) {
  loading.value = true; error.value = ''
  try { task.value = await qualityApi.getTask(taskId); if (task.value.status === 0) reasonGroups.value = await qualityApi.getReasons() }
  catch (cause) { error.value = cause instanceof Error ? cause.message : '任务加载失败' }
  finally { loading.value = false }
}

function changeReason(event: { detail: { value: string } }) { reasonId.value = reasonOptions.value[Number(event.detail.value)]?.id }

async function submit() {
  if (!task.value || !sessionStore.can('quality.task.submit')) return
  if (result.value === 10 && !reasonId.value) return uni.showToast({ title: '请选择不合格原因', icon: 'none' })
  submitting.value = true
  try {
    await qualityService.submitResult(task.value.id, { result: result.value, remark: remark.value, reasonId: reasonId.value })
    uni.showToast({ title: '质检结果已提交', icon: 'success' })
    setTimeout(() => uni.navigateBack(), 500)
  } catch (cause) { uni.showToast({ title: cause instanceof Error ? cause.message : '提交失败', icon: 'none' }) }
  finally { submitting.value = false }
}

onLoad(query => { const id = Number(query?.id); if (Number.isInteger(id) && id > 0) load(id); else { loading.value = false; error.value = '任务编号无效' } })
</script>

<template>
  <view class="page">
    <WareState v-if="loading" type="loading" title="正在加载质检任务" />
    <WareState v-else-if="error" type="error" title="加载失败" :description="error" />
    <template v-else-if="task">
      <view class="task-card">
        <view class="title-row"><view><text class="flower">{{ task.flowerName }}</text><text class="grade">{{ task.grade }}</text></view><WareStatus :tone="task.status === 0 ? 'warning' : task.status === 10 ? 'danger' : 'success'" :label="task.statusLabel" /></view>
        <view class="location">{{ task.location }} · {{ task.quantity }} {{ task.unit }}</view>
        <view class="facts"><view><text>供应商</text><text>{{ task.supplierName }}</text></view><view><text>规格</text><text>{{ task.specification || '—' }}</text></view><view><text>场次</text><text>{{ task.session }}</text></view></view>
      </view>
      <view v-if="task.status === 0" class="form-card">
        <text class="section-title">质检结果</text>
        <view class="result-grid"><view :class="{selected:result===1}" @click="result=1">合格</view><view :class="{selected:result===2}" @click="result=2">良好</view><view :class="['danger',{selected:result===10}]" @click="result=10">不合格</view></view>
        <template v-if="result===10"><text class="field-label">不合格原因</text><picker :range="reasonOptions" range-key="name" @change="changeReason"><view class="picker">{{ reasonOptions.find(item=>item.id===reasonId)?.name || '请选择原因' }}</view></picker></template>
        <text class="field-label">质检备注</text><textarea v-model="remark" maxlength="255" class="remark" placeholder="填写花材状态或处理说明（选填）" />
        <button class="submit" :loading="submitting" :disabled="submitting || !sessionStore.can('quality.task.submit')" @click="submit">确认提交</button>
      </view>
      <view v-else class="form-card"><text class="section-title">处理记录</text><view class="record"><text>操作人</text><text>{{ task.assigneeName || '—' }}</text></view><view class="record"><text>完成时间</text><text>{{ task.finishedAt || '—' }}</text></view><view class="record"><text>备注</text><text>{{ task.remark || '无' }}</text></view></view>
    </template>
  </view>
</template>

<style scoped lang="scss">
.page{min-height:100vh;padding:24rpx;background:var(--wms-background)}.task-card,.form-card{padding:28rpx;border-radius:var(--wms-radius-card);background:#fff}.form-card{margin-top:20rpx}.title-row{display:flex;align-items:center;justify-content:space-between}.flower{font-size:36rpx;font-weight:750}.grade{margin-left:12rpx;padding:4rpx 12rpx;border-radius:8rpx;background:var(--wms-primary-100);color:var(--wms-primary-700);font-size:23rpx}.location{margin-top:18rpx;color:var(--wms-primary-700);font-size:30rpx;font-weight:700}.facts{margin-top:24rpx;border-top:1rpx solid var(--wms-border)}.facts view,.record{display:flex;justify-content:space-between;padding-top:20rpx;color:var(--wms-text-secondary);font-size:25rpx}.facts view text:last-child,.record text:last-child{color:var(--wms-text);font-weight:600}.section-title{display:block;font-size:31rpx;font-weight:750}.result-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:14rpx;margin-top:22rpx}.result-grid view,.picker{display:flex;height:82rpx;align-items:center;justify-content:center;border-radius:18rpx;background:var(--wms-background);color:var(--wms-text-secondary);font-size:27rpx}.result-grid .selected{background:var(--wms-primary-100);color:var(--wms-primary-700);font-weight:700}.result-grid .danger.selected{background:#fff0f0;color:var(--wms-danger)}.field-label{display:block;margin:28rpx 0 14rpx;font-size:25rpx;font-weight:650}.picker{justify-content:flex-start;padding:0 22rpx}.remark{box-sizing:border-box;width:100%;height:150rpx;padding:20rpx;border-radius:18rpx;background:var(--wms-background);font-size:26rpx}.submit{height:92rpx;margin-top:30rpx;border:0;border-radius:22rpx;background:var(--wms-primary-700);color:#fff;font-size:29rpx;font-weight:700;line-height:92rpx}.submit:after{border:0}.submit[disabled]{background:#aabbb8;color:#fff}
</style>
