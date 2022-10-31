<template>
  <div class="login-content">
    <div id="firebaseui-auth-container" @keydown.esc="authUi.reset()"></div>
  </div>
</template>

<script setup>
import { onMounted, onUnmounted } from 'vue'
import firebase from 'firebase/compat/app'
import * as firebaseui from 'firebaseui'
import { useUserContext } from '@/stores/userContext'
import router from '@/router'

const userContext = useUserContext()
const authUi =
  firebaseui.auth.AuthUI.getInstance() ||
  new firebaseui.auth.AuthUI(firebase.auth())

onMounted(() => {
  if (userContext.isConnected) {
    router.push('/user')
    return
  }
  authUi.start('#firebaseui-auth-container', {
    callbacks: {
      signInSuccessWithAuthResult: function (authResult, redirectUrl) {
        console.log(redirectUrl)
        console.log(authResult.user)
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
})

onUnmounted(() => {
  authUi.reset()
})
</script>

<style scoped>
.login-content {
  display: flex;
  align-items: center;
  justify-content: center;
  height: calc(100vh - 3rem);
}
</style>
