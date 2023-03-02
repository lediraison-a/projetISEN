<template>
  <div class="notfound-content">
    <div class="hero">
      <div class="error">{{ $t('notfound.error') }}</div>
      <div class="error-text">{{ $t('notfound.errorText') }}</div>
      <router-link to="/">{{ $t('notfound.back') }}</router-link>
    </div>
  </div>
</template>

<script setup>

</script>

<style scoped>
.notfound-content {
  display: flex;
  justify-content: center;
  align-items: center;
  height: calc(100vh - 4rem);
}

.hero {
  max-width: 40rem;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  gap: 2rem;
}

.error {
  font-size: xxx-large;
  font-weight: bolder;
}

.error-text {
  font-size: large;
}
</style>
