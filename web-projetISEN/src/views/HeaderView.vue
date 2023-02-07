<template>
  <div>
    <div
      class="side-header"
      :class="showSideHeader ? 'side-header-show' : 'side-header-hide'"
    >
      <div class="home-link">
        <router-link to="/">
          <img src="/src/assets/icons/logo/LogoLight.svg" />
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
    <div class="header-content">
      <div class="menu-btn" @click="showSideHeader = true">
        <img src="/src/assets/icons/menu.svg" class="theme-icon" />
      </div>
      <div class="header-content-left">
        <div class="home-link">
          <router-link to="/">
            <img src="/src/assets/icons/logo/LogoLight.svg" />
            {{ appName }}
          </router-link>
        </div>
        <div class="nav-links" v-if="userContext.isConnected">
          <div class="nav-link" v-for="link in links" :key="link">
            <router-link :to="link[0]">{{ link[1] }}</router-link>
          </div>
        </div>
      </div>
      <div class="header-content-right">
        <div class="connect-links">
          <UserAuth />
        </div>
      </div>
    </div>
  </div>
</template>
<script setup>
import UserAuth from '../components/UserAuth.vue'
import { useUserContext } from '@/stores/userContextStore'

const userContext = useUserContext()

const links = [
  ['/user', 'User'],
  ['/download', 'Download'],
  ['/qna', 'Q&A'],
]

const appName = import.meta.env.VITE_APP_TITLE

let showSideHeader = false
</script>
<style scoped>
@media screen and (max-width: 500px) {
  .nav-links {
    display: none;
  }
}

@media screen and (min-width: 500px) {
  .nav-links {
    display: flex;
  }
}

.side-header {
  position: fixed;
  top: 0;
  left: 0;
  width: 15rem;
  height: 100vh;
  background-color: var(--color-background-soft);
  border-right: solid var(--color-border) 1px;
}

.side-header-show {
  left: 0;
  transition: 150ms;
}

.side-header-hide {
  left: -100%;
  transition: 150ms;
}

.menu-btn {
  height: 100%;
  width: 1rem;
  display: flex;
  justify-content: center;
  cursor: pointer;
  margin-right: 1rem;
  margin-left: 1rem;
}

.header-content-left,
.header-content-right {
  display: flex;
  width: 100%;
  align-items: center;
  flex-direction: row;
}

.header-content-right {
  display: flex;
  justify-content: flex-end;
  margin-right: 0.3rem;
}

.header-content-left {
  margin-left: 0.3rem;
}

.header-content {
  display: flex;
  flex-direction: row;
  align-items: center;
  margin-left: auto;
  margin-right: auto;
  width: 100vw;
  max-width: 85rem;
}

.app-header {
  display: flex;
  align-items: center;
  justify-content: start;
  background-color: var(--color-background-soft);
  z-index: 10;
  border-bottom: solid var(--color-border) 1px;
}

.home-link {
  font-size: x-large;
}

.nav-links {
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

img {
  height: 38px;
}

a {
  display: flex;
  gap: 0.3rem;
  justify-content: center;
}
</style>
