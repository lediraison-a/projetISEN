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
import UserAuth from '../components/UserAuth.vue'
import { useUserContext } from '@/stores/userContextStore'

const userContext = useUserContext()

const links = [
  ['/user', 'user'],
  ['/download', 'download app'],
  ['/qna', 'q & a'],
]

const appName = import.meta.env.VITE_APP_TITLE
</script>
<style scoped>
.app-header {
  display: flex;
  align-items: center;
  padding-left: 2rem;
  justify-content: start;
  background-color: var(--color-background-soft);
  z-index: 10;
  border-bottom: solid var(--color-border) 1px;
}

.home-link {
  font-size: x-large;
}

.nav-links {
  display: flex;
  align-items: center;
  padding: 1rem;
}

.home-link {
  padding: 0.2rem;
}

.nav-link {
  font-size: larger;
  padding: 0.5rem;
}

.connect-links {
  right: 0.5rem;
  position: absolute;
}
</style>
