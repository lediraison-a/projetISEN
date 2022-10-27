<template>
  <div>
    <div class="homeLink">
      <router-link to="/">
        {{ appName }}
      </router-link>
    </div>
    <div class="navLinks"></div>
    <div class="connectLinks">
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

.homeLink {
  font-size: x-large;
}

.connectLinks {
  right: 1rem;
  position: absolute;
}
</style>
