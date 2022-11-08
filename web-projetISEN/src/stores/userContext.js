import { computed, ref } from 'vue'
import { defineStore } from 'pinia'
import firebase from 'firebase/compat/app'
import router from '@/router'

export const useUserContext = defineStore('userContext', () => {
  const email = ref('')
  const uid = ref('')
  const isConnected = computed(() => email.value && uid.value)

  function set(user) {
    uid.value = user.uid
    email.value = user.email
  }

  async function logout() {
    firebase
      .auth()
      .signOut()
      .then(() => {
        email.value = ''
        uid.value = ''
        router.push('/')
      })
  }

  async function getToken() {
    let token = ''
    await firebase
      .auth()
      .currentUser.getIdTokenResult()
      .then((value) => (token = value))
    return token
  }

  return {
    email,
    uid,
    isConnected,
    set,
    logout,
    getToken,
  }
})
