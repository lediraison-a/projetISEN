<template>
  <div class="user-auth">
    <div v-if="!userContext.isConnected" class="auth-links">
      <div class="auth-link" @click="router.push('/signin')">
        <img src="/src/assets/icons/login.svg" class="theme-icon" />
        {{ $t('message.signIn') }}
      </div>
    </div>
    <div v-else class="auth-links">
      <div class="auth-info">{{ userContext.name }}</div>
      <div class="auth-link" @click="userContext.userLogout">
        <img src="/src/assets/icons/logout.svg" class="theme-icon" />
        {{ $t('message.logOut') }}
      </div>
    </div>
  </div>
</template>

<script setup>
// https://firebase.google.com/docs/auth/web/firebaseui?authuser=0
import firebase from 'firebase/compat/app'
import { useUserContext } from '@/stores/userContextStore'
import { onMounted } from 'vue'
import router from '@/router'

const userContext = useUserContext()

onMounted(() => {
  firebase.auth().onAuthStateChanged(function (user) {
    if (user) {
      userContext.userSetInfo(user)
      firebase
        .auth()
        .currentUser.getIdTokenResult()
        .then((value) => console.log(value.token))
    } else {
      router.push('/')
    }
  })
})
</script>

<style scoped>
.auth-links {
  display: flex;
  flex-direction: row;
  padding: 5px;
}

.auth-link {
  padding: 3px 8px;
  cursor: pointer;
  border: solid var(--color-border) 2px;
  border-radius: 0.375em;
  background-color: var(--color-background);
  -webkit-box-shadow: 0 0 13px -8px rgba(0, 0, 0, 0.37);
  box-shadow: 0 0 13px -8px rgba(0, 0, 0, 0.37);
  transition: 250ms;
  display: flex;
  align-items: center;
  gap: 0.2rem;
}

.auth-link:hover {
  background-color: var(--color-background-mute);
  transition: 250ms;
}

.auth-link > img {
  height: 18px;
}

.auth-info {
  margin: 3px;
  padding: 2px;
  color: var(--color-heading);
}
</style>
