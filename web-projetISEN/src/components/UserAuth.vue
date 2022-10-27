<template>
  <div class="user-auth">
    <div v-if="!userContext.isConnected" class="auth-links">
      <div class="auth-link" @click="signIn">Sign in</div>
    </div>
    <div v-else class="auth-links">
      <div class="auth-info">{{ userContext.email }}</div>
      <div class="auth-link" @click="logOut">Log out</div>
    </div>
  </div>
  <div class="auth-popup">
    <div id="firebaseui-auth-container"></div>
  </div>
</template>

<script setup>
// https://firebase.google.com/docs/auth/web/firebaseui?authuser=0
import firebase from 'firebase/compat/app'
import * as firebaseui from 'firebaseui'
import { useUserContext } from '@/stores/userContext'
import { onMounted } from 'vue'
import router from '@/router'

const userContext = useUserContext()

onMounted(() => {
  firebase.auth().onAuthStateChanged(function (user) {
    if (user) {
      const uid = user.uid
      const email = user.email
      userContext.set(email, uid)
    }
  })
  if (!userContext.isConnected) {
    router.push('/')
  }
})

function logOut() {
  firebase
    .auth()
    .signOut()
    .then(() => {
      userContext.unset()
      router.push('/')
    })
}

function signIn() {
  const ui =
    firebaseui.auth.AuthUI.getInstance() ||
    new firebaseui.auth.AuthUI(firebase.auth())
  ui.start('#firebaseui-auth-container', {
    callbacks: {
      signInSuccessWithAuthResult: function (authResult, redirectUrl) {
        console.log(redirectUrl)
        const uid = authResult.user.uid
        const email = authResult.user.email
        userContext.set(email, uid)
        router.push('/user')
        return false
      },
    },
    signInOptions: [
      {
        provider: firebase.auth.EmailAuthProvider.PROVIDER_ID,
        requireDisplayName: true,
      },
    ],
    signInFlow: 'popup',
  })
}
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
  transition: 150ms;
}

.auth-link:hover {
  background-color: var(--color-background-mute);
  transition: 150ms;
}

.auth-info {
  margin: 3px;
  padding: 2px;
  color: var(--color-heading);
}

.auth-popup {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100vw;
  min-width: 30rem;
  height: 100vh;
  min-height: 20rem;
  position: fixed;
  left: 0;
  z-index: 20;
}

#firebaseui-auth-container {
}
</style>
