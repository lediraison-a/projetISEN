<template>
  <div class="download-content">
    <h2>{{ $t('message.smartphoneApp') }}</h2>
    <div class="text">
      <p>{{ $t('message.explainDownload1') }}</p>
      <p>{{ $t('message.explainDownload2') }}</p>
    </div>
    <div class="actions">
      <div class="app-btn-primary" @click="download">
        <img src="/src/assets/icons/download.svg" />
        <div>{{ $t('message.downloadApk') }}</div>
      </div>
    </div>
  </div>
</template>

<script setup>
const apkFile = 'README.md'

const download = () => {
  window.open(apkFile)
}
</script>

<style scoped>
.download-content {
  padding: 1rem;
}

.text {
  padding: 0 1rem;
}

.actions {
  display: flex;
  width: 100%;
  padding: 1rem 3rem;
}
</style>
