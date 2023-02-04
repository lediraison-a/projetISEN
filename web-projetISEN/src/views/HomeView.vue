<template>
  <div class="home-content">
    <div class="app-btn-primary" v-if="!userContext.isConnected">
      <img src="/src/assets/icons/login.svg" />
      <router-link to="/signin"> Sign in to get started </router-link>
    </div>
    <div v-else class="btn-start-connected">
      <div class="app-btn-primary">
        <img src="/src/assets/icons/edit.svg" />
        <router-link to="/user">Edit your allergens</router-link>
      </div>
      <div>or</div>
      <div class="app-btn-primary">
        <img src="/src/assets/icons/download.svg" />
        <router-link to="/download">Download the app</router-link>
      </div>
    </div>
  </div>
</template>
<script setup>
import { useUserContext } from '@/stores/userContextStore'

const userContext = useUserContext()
</script>
<style scoped>
.home-content {
  height: calc(100vh - 3.5rem);
  display: flex;
  justify-content: center;
  align-items: center;
}

a {
  color: var(--vt-c-text-light-1);
  font-size: large;
}

.btn-start-connected {
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  gap: 1rem;
}
</style>
