<template>
  <div class="user-auth">
    <div v-if="!userContext.isConnected" class="auth-links">
      <div class="auth-link" @click="router.push('/signin')">Sign in</div>
    </div>
    <div v-else class="auth-links">
      <div class="auth-info">{{ userContext.email }}</div>
      <div class="auth-link" @click="userContext.userLogout">Log out</div>
    </div>
  </div>
</template>

<script setup>
// https://firebase.google.com/docs/auth/web/firebaseui?authuser=0
import firebase from 'firebase/compat/app'
import { useUserContext } from '@/stores/userContext'
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
}

.auth-link:hover {
  background-color: var(--color-background-mute);
  transition: 250ms;
}

.auth-info {
  margin: 3px;
  padding: 2px;
  color: var(--color-heading);
}
</style>
