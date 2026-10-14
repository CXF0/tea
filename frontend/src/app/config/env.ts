const runtimeHost = typeof location !== 'undefined' ? location.hostname : '127.0.0.1'

export const appConfig = {
  apiBaseUrl: import.meta.env.VITE_API_BASE_URL || (typeof location !== 'undefined' ? '/api' : `http://${runtimeHost}:3101/api`),
  requestTimeout: 10000,
}
