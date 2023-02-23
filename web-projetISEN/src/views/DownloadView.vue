<template>
  <div class="download-content">
    <h2>L'application smartphone</h2>
    <div class="text">
      <p>Pour detecter les allergenes présent dans les produits, Dish propose un application smartphone. L'application est disponible sous la forme d'un fichier .apk à installer sur votre appareil.</p>
      <p>L'application est diponible pour les téléphones android. Cliquez sur le bouton suivant pour télécharger l'application.</p>
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
  /*height: calc(100vh - 3.5rem);*/
  /*display: flex;*/
  /*justify-content: center;*/
  /*align-items: center;*/
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
