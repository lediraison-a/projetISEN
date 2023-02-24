<template>
  <div>
    <div class="header-content">
      <div class="header-content-left">
        <div class="home-link">
          <router-link to="/">
            <img src="/src/assets/icons/logo/Logo-dark.svg" v-if="theme.theme === 'dark'">
            <img src="/src/assets/icons/logo/Logo-light.svg" v-else>
            {{ appName }}
          </router-link>
        </div>
        <div class="nav-links" v-if="userContext.isConnected">
          <div class="nav-link" v-for="link in links" :key="link">
            <router-link :to="link[0]">{{ $t(link[1]) }}</router-link>
          </div>
        </div>
        <router-link
          to="admin"
          v-if="adminStore.isSelfAdmin"
          class="admin-link"
        >
          {{ $t('message.admin') }}
        </router-link>
      </div>
      <div class="header-content-right">
        <div class="site-prefs">
          <div class="app-btn" @click="theme.switchTheme">
            {{ theme.theme === 'dark' ? '🌙' : '🌞' }}
          </div>
          <div class="app-btn" @click="switchLang">
            {{ locale === 'en' ? '🇬🇧' : '🇫🇷' }}
          </div>
        </div>
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
import { onMounted } from 'vue'
import { useLangPref } from '@/stores/LangPrefStore'
import { useI18n } from 'vue-i18n'
import { useTheme } from "@/stores/themeStore";
import { useAdmin } from "@/stores/adminStore";
const { locale } = useI18n({ useScope: 'global' })

const userContext = useUserContext()
const langPrefStore = useLangPref()
const adminStore = useAdmin()

const links = [
  ['/user', 'header.user'],
  ['/download', 'header.download'],
  ['/qna', 'header.qna'],
]

const appName = import.meta.env.VITE_APP_TITLE

const theme = useTheme()

onMounted(() => {
  const langPref = langPrefStore.getLangPref()
  if (langPref) {
    locale.value = langPref
  }
  theme.fetchTheme()
})

function switchLang() {
  if (locale.value === 'en') {
    locale.value = 'fr'
  } else if (locale.value === 'fr') {
    locale.value = 'en'
  }
  langPrefStore.saveLangPref(locale.value)
}

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

.admin-link {
  font-size: larger;
  margin-left: 2rem;
}

.site-prefs {
  display: flex;
  flex-direction: row;
  gap: 0.5rem;
}

.site-prefs > .app-btn {
  font-size: larger;
  padding: 0.5rem;
  line-height: 1.2rem;
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
