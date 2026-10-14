<script setup lang="ts">
import { onLaunch } from '@dcloudio/uni-app'
import { sessionStore } from '@/store/session'

onLaunch(() => {
  sessionStore.restore()
  console.info('梦花仓管启动')
})
</script>

<style lang="scss">
@use './shared/styles/tokens.scss';

page {
  min-height: 100%;
  background: var(--wms-page);
  color: var(--wms-text);
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'PingFang SC', sans-serif;
  font-synthesis: none;
  text-rendering: optimizeLegibility;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
button::after { border: 0; }
</style>
