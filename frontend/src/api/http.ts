const runtimeHost = typeof location !== 'undefined' ? location.hostname : '127.0.0.1'
const apiBaseUrl = import.meta.env.VITE_API_BASE_URL || `http://${runtimeHost}:3101/api`

export function request<T>(options: UniApp.RequestOptions): Promise<T> {
  return new Promise((resolve, reject) => {
    uni.request({
      ...options,
      url: `${apiBaseUrl}${options.url}`,
      timeout: 10000,
      success(response) {
        if (response.statusCode >= 200 && response.statusCode < 300) resolve(response.data as T)
        else reject(new Error(`请求失败：${response.statusCode}`))
      },
      fail: reject,
    })
  })
}
