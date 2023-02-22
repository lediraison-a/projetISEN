<template>
  <div class="app-content bgpattern">
    <HeaderView class="app-header" />
    <div class="app-view">
      <RouterView></RouterView>
    </div>
    <FooterView class="app-footer" />
  </div>
  <AppAlert />
</template>
<script setup>
import HeaderView from './views/HeaderView.vue'
import AppAlert from '@/components/AppAlert.vue'
import FooterView from '@/views/FooterView.vue'
</script>
<style scoped>
@import '@/assets/appStyle.css';

.app-header {
  width: 100%;
  position: fixed;
  top: 0;
  left: 0;
  height: 3.5rem;
  background-color: var(--color-background-soft);
}

.app-content {
  width: 100vw;
  display: flex;
  justify-content: center;
  flex-direction: column;
}

.app-view {
  background-color: var(--color-background);
  position: relative;
  width: 100vw;
  max-width: 85rem;
  border-left: solid var(--color-border) 1px;
  border-right: solid var(--color-border) 1px;
  min-height: calc(100vh - 3.5rem);
  top: 3.5rem;
  margin-left: auto;
  margin-right: auto;
}

.app-footer {

}
</style>
