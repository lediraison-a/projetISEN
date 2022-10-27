<template>
  <div class="app-content">
    <HeaderView class="app-header" />
    <div class="app-view">
      <RouterView></RouterView>
    </div>
  </div>
</template>
<script setup>
import HeaderView from './views/HeaderView.vue'
</script>
<style scoped>
.app-header {
  width: 100%;
  position: fixed;
  top: 0;
  left: 0;
  height: 3rem;
}

.app-content {
  height: 100vh;
}

.app-view {
  left: 0;
  width: 100vw;
  top: 2rem;
  position: absolute;
}

</style>
