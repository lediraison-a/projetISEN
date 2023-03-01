<template>
  <div class="download-content">
    <h2>{{ $t('message.smartphoneApp') }}</h2>
    <div class="text">
      <p>{{ $t('message.explainDownload1') }}</p>
      <p>{{ $t('message.explainDownload2') }}</p>
    </div>
    <div class="actions">
      <div class="app-btn-primary">
        <a href="dish.apk" class="dl-link">
          <img class="dl-icon" src="/src/assets/icons/download.svg" />
          <div class="dl-link-text">{{ $t('message.downloadApk') }}</div>
        </a>
      </div>
    </div>
    <div>
      <hr />
      <p>{{ $t('message.downloadQrcode') }}</p>
      <canvas id="canvas"></canvas>
    </div>
  </div>
</template>

<script setup>
import qrcode from 'qrcode'
import { onMounted } from 'vue'
onMounted(() => {
  const canvas = document.getElementById('canvas')
  qrcode.toCanvas(
    canvas,
    window.location.host + '/' + import.meta.env.VITE_APK_FILE,
    function (error) {
      if (error) console.error(error)
    }
  )
})
</script>

<style scoped>
.download-content {
  padding: 1rem;
}

.text {
}

.actions {
  display: flex;
  width: 100%;
  padding: 1rem 1rem;
}

.dl-link {
  display: flex;
  flex-direction: row;
}

#canvas {
  margin-top: 1rem;
  margin-left: 1rem;
  border: solid var(--color-border) 1px;
  border-radius: 0.4rem;
}

.dl-link-text {
  color: var(--vt-c-text-light-1);
}

.dl-icon {
  width: 1.8rem;
  height: 1.8rem;
}

.dl-link-text {
  font-size: larger;
}
</style>
