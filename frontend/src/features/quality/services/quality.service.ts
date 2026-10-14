import { qualityApi } from '../api/quality.api'

export const qualityService = {
  async loadWorkbench(date: string) {
    const [summary, tasks] = await Promise.all([qualityApi.getSummary(date), qualityApi.getTasks(date, 0)])
    return { summary, tasks: tasks.slice(0, 3) }
  },
  submitResult(taskId: number, form: { result: 1 | 2 | 10; remark: string; reasonId?: number }) {
    if (form.result === 10 && !form.reasonId) throw new Error('请选择不合格原因')
    return qualityApi.submitInspection(taskId, { status: form.result, remark: form.remark.trim(), reasonId: form.reasonId })
  },
}
