import { appConfig } from '@/app/config/env'
import { sessionStore } from '@/store/session'
import { ApiError } from './errors'

interface ApiEnvelope<T> { data: T }
interface ErrorEnvelope { error?: { code?: string; message?: string } }

export async function request<T>(options: UniApp.RequestOptions): Promise<T> {
  const response = await new Promise<UniApp.RequestSuccessCallbackResult>((resolve, reject) => {
    uni.request({
      ...options,
      url: `${appConfig.apiBaseUrl}${options.url}`,
      timeout: appConfig.requestTimeout,
      header: {
        'content-type': 'application/json',
        ...(sessionStore.state.token ? { authorization: `Bearer ${sessionStore.state.token}` } : {}),
        'x-user-id': String(sessionStore.state.userId),
        'x-user-name': encodeURIComponent(sessionStore.state.userName),
        ...options.header,
      },
      success: resolve,
      fail: (error) => reject(new ApiError('NETWORK_ERROR', error.errMsg || '网络连接失败')),
    })
  })

  if (response.statusCode >= 200 && response.statusCode < 300) {
    return (response.data as ApiEnvelope<T>).data
  }
  const payload = response.data as ErrorEnvelope
  throw new ApiError(payload.error?.code || 'REQUEST_FAILED', payload.error?.message || '请求失败', response.statusCode)
}
