<template>
  <div class="app-content">
    <HeaderView class="app-header" />
    <div class="app-view">
      <RouterView></RouterView>
    </div>
  </div>
  <AppAlert />
</template>
<script setup>
import HeaderView from './views/HeaderView.vue'
import AppAlert from '@/components/AppAlert.vue'
</script>
<style scoped>
@import '@/assets/appStyle.css';

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
  width: 100vw;
  display: flex;
  justify-content: center;
}

.app-view {
  top: 3rem;
  position: relative;
  width: 100vw;
  max-width: 85rem;
  border-left: solid var(--color-border) 1px;
  border-right: solid var(--color-border) 1px;
  min-height: calc(100vh - 3rem);
  margin-left: auto;
  margin-right: auto;
}
</style>
