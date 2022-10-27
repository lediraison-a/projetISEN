<template>
  <div>
    <div class="home-link">
      <router-link to="/">
        {{ appName }}
      </router-link>
    </div>
    <div class="nav-links" v-if="userContext.isConnected">
      <div class="nav-link" v-for="link in links" :key="link">
        <router-link :to="link[0]">{{ link[1] }}</router-link>
      </div>
    </div>
    <div class="connect-links">
      <UserAuth />
    </div>
  </div>
</template>
<script setup>
import { inject } from 'vue'
import UserAuth from '../components/UserAuth.vue'
import { useUserContext } from '@/stores/userContext'

const userContext = useUserContext()

const links = [
  ['/user', 'user'],
  ['/download', 'download app'],
]

const appName = inject('appName')
</script>
<style scoped>
.app-header {
  display: flex;
  align-items: center;
  padding-left: 2rem;
  justify-content: start;
  background-color: var(--color-background-soft);
  -webkit-box-shadow: 0px 0px 19px 0px rgba(0,0,0,0.15);
  box-shadow: 0px 0px 19px 0px rgba(0,0,0,0.15);
}

.home-link {
  font-size: x-large;
}

.nav-links {
  display: flex;
  align-items: center;
  padding: 1rem;
}

.home-link nav-link {
  padding: 0.2rem;
}

.nav-link {
  font-size: larger;
  padding: 0.5rem;
  text-decoration: underline var(--color-heading);
}

.connect-links {
  right: 1rem;
  position: absolute;
}
</style>
