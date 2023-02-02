<template>
  <div class="download-content">
    <div class="app-btn-primary" @click="download">
      <img src="src/assets/icons/download.svg" />
      <div> Download the .apk file </div>
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
  height: calc(100vh - 3.5rem);
  display: flex;
  justify-content: center;
  align-items: center;
}
</style>
