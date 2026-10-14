import jsQR from 'jsqr'

export interface ScanResult {
  value: string
  scanType?: string
}

function decodeImage(path: string): Promise<ScanResult> {
  return new Promise((resolve, reject) => {
    // #ifdef H5
    const image = new Image()
    image.onload = () => {
      const canvas = document.createElement('canvas')
      canvas.width = image.naturalWidth
      canvas.height = image.naturalHeight
      const context = canvas.getContext('2d', { willReadFrequently: true })
      if (!context) return reject(new Error('浏览器无法读取图片'))
      context.drawImage(image, 0, 0)
      const pixels = context.getImageData(0, 0, canvas.width, canvas.height)
      const result = jsQR(pixels.data, pixels.width, pixels.height, { inversionAttempts: 'attemptBoth' })
      result
        ? resolve({ value: result.data, scanType: 'qrCode' })
        : reject(new Error('图片中未识别到二维码'))
    }
    image.onerror = () => reject(new Error('二维码图片读取失败'))
    image.src = path
    // #endif
    // #ifndef H5
    reject(new Error('当前环境请使用相机扫码'))
    // #endif
  })
}

export const scanner = {
  scan(options: { onlyFromCamera?: boolean; scanType?: string[] } = {}): Promise<ScanResult> {
    return new Promise((resolve, reject) => {
      uni.scanCode({
        onlyFromCamera: options.onlyFromCamera ?? true,
        scanType: options.scanType ?? ['qrCode', 'barCode'],
        success: ({ result, scanType }) => resolve({ value: result, scanType }),
        fail: error => reject(new Error(error.errMsg || '扫码失败')),
      })
    })
  },
  scanImage(): Promise<ScanResult> {
    return new Promise((resolve, reject) => {
      uni.chooseImage({
        count: 1,
        sourceType: ['album'],
        success: result => {
          const path = Array.isArray(result.tempFilePaths) ? result.tempFilePaths[0] : result.tempFilePaths
          if (!path) return reject(new Error('未选择二维码图片'))
          decodeImage(path).then(resolve, reject)
        },
        fail: error => reject(new Error(error.errMsg || '未选择二维码图片')),
      })
    })
  },
}
