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
<style>
@import '@/style/firebaseui.css';
@import '@/style/appStyle.css';

.app-header {
  width: 100%;
  position: fixed;
  top: 0;
  left: 0;
  height: 3rem;
  background-color: var(--color-background-soft);
}

.app-content {
  height: 100vh;
}

.app-view {
  left: 0;
  top: 3rem;
  position: absolute;
  z-index: -1;
}
</style>
