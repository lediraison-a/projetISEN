import { computed, ref } from 'vue'
import { defineStore } from 'pinia'
import firebase from 'firebase/compat/app'
import router from '@/router'

export const useUserContext = defineStore('userContext', () => {
  const email = ref('')
  const uid = ref('')
  const name = ref('')
  const isConnected = computed(() => email.value && uid.value)

  function userSetInfo(user) {
    uid.value = user.uid
    email.value = user.email
    name.value = user.displayName
  }

  async function userLogout() {
    firebase
      .auth()
      .signOut()
      .then(() => {
        email.value = ''
        uid.value = ''
        name.value = ''
        router.push('/')
      })
  }

  async function getToken() {
    function getCurrentUser(auth) {
      return new Promise((resolve, reject) => {
        const unsubscribe = auth.onAuthStateChanged((user) => {
          unsubscribe()
          resolve(user)
        }, reject)
      })
    }

    const currentUser = await getCurrentUser(firebase.auth())
    let token = ''
    await currentUser.getIdTokenResult().then((value) => (token = value.token))
    return token
  }

  return {
    email,
    uid,
    name,
    isConnected,
    userSetInfo,
    userLogout,
    getToken,
  }
})
