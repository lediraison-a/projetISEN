<template>
  <div class="home-content">
    <div class="hero">
      <div v-if="userContext.isConnected" class="welcome-text">
        {{ $t('message.welcomeConnected') }}
      </div>
      <div v-else class="welcome-text">
        {{ $t('message.welcomeNotConnected') }}
      </div>
      <div class="app-btn-primary" v-if="!userContext.isConnected">
        <img src="/src/assets/icons/login.svg" />
        <router-link to="/signin"></router-link>
      </div>
      <div v-else class="btn-start-connected">
        <div class="app-btn-primary">
          <img src="/src/assets/icons/edit.svg" />
          <router-link to="/user">
            {{ $t('message.editAllergens') }}
          </router-link>
        </div>
        <div>
          {{ $t('message.or') }}
        </div>
        <div class="app-btn-primary">
          <img src="/src/assets/icons/download.svg" />
          <router-link to="/download">
            {{ $t('message.downloadApp') }}
          </router-link>
        </div>
      </div>
      <div v-if="userContext.isConnected">
        <div class="help-text">
          {{ $t('message.homeGuide1') }}
          <router-link class="help-link" to="qna">
            {{ $t('message.guide') }}
          </router-link>
          {{ $t('message.homeGuide2') }}
        </div>
      </div>
    </div>
  </div>
</template>
<script setup>
import { useUserContext } from '@/stores/userContextStore'

const userContext = useUserContext()
</script>
<style scoped>
.hero {
  display: flex;
  flex-direction: column;
  gap: 4rem;
}

.welcome-text {
  font-size: x-large;
  text-align: center;
}

.help-text {
  text-align: center;
  font-size: large;
}

.help-link {
  font-size: large;
  color: var(--primary);
}

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
