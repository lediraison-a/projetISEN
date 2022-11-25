import { computed, ref } from 'vue'
import { defineStore } from 'pinia'
import firebase from 'firebase/compat/app'
import { getAuth, sendPasswordResetEmail, deleteUser } from 'firebase/auth'
import router from '@/router'
import { useAppAlert } from '@/stores/appAlertStore'

export const useUserContext = defineStore('userContext', () => {
  const email = ref('')
  const uid = ref('')
  const name = ref('')
  const isConnected = computed(() => email.value && uid.value)

  const appAlert = useAppAlert()

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
        appAlert.setAlertInfoTimed('Successfully logged out', 3500)
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

  function sendEmailReset() {
    sendPasswordResetEmail(getAuth(), email.value)
      .then(() => {
        appAlert.setAlertInfoTimed('Reset email sent', 3500)
      })
      .catch((error) => {
        const errorCode = error.code
        const errorMessage = error.message
        console.log('Error ' + errorCode + ' : ' + errorMessage)
        appAlert.setAlertErrorTimed(errorMessage, 3500)
      })
  }

  function deleteCurrentUser() {
    deleteUser(getAuth().currentUser)
      .then(() => {
        email.value = ''
        uid.value = ''
        name.value = ''
        router.push('/')
        appAlert.setAlertInfoTimed('User deleted', 3500)
      })
      .catch((error) => {
        console.log(error.message)
        appAlert.setAlertErrorTimed('Error deleting user', 3500)
      })
  }

  return {
    email,
    uid,
    name,
    isConnected,
    userSetInfo,
    userLogout,
    getToken,
    sendEmailReset,
    deleteCurrentUser,
  }
})
