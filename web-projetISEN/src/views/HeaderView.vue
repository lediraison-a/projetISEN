<template>
  <div>
    <div class="home-link">
      <router-link to="/">
        {{ appName }}
      </router-link>
    </div>
    <div class="nav-links"></div>
    <div class="connect-links">
      <UserAuth />
    </div>
  </div>
</template>
<script setup>
import { inject } from 'vue'
import UserAuth from '../components/UserAuth.vue'

const appName = inject('appName')
</script>
<style scoped>
.app-header {
  display: flex;
  align-items: center;
  padding-left: 2rem;
  justify-content: start;
}

.home-link {
  font-size: x-large;
}

.connect-links {
  right: 1rem;
  position: absolute;
}
</style>
