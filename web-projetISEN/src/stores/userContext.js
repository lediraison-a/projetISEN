import { computed, ref } from 'vue'
import { defineStore } from 'pinia'

export const useUserContext = defineStore('userContext', () => {
  const email = ref('')
  const uid = ref('')
  const isConnected = computed(() => email.value && uid.value)

  function set(userEmail, userUid) {
    uid.value = userUid
    email.value = userEmail
  }

  function unset() {
    uid.value = ''
    email.value = ''
  }

  return {
    email,
    uid,
    isConnected,
    set,
    unset,
  }
})
