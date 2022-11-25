import { defineStore } from 'pinia'
import { ref } from 'vue'

export const useAppAlert = defineStore('appAlert', () => {
  const message = ref('alert message')
  const level = ref('info')
  const show = ref(false)

  function closeAlert() {
    message.value = ''
    show.value = false
  }

  function setAlertError(alertMessage) {
    message.value = alertMessage
    show.value = true
    level.value = 'error'
  }
  function setAlertErrorTimed(alertMessage, time) {
    setAlertError(alertMessage)
    setTimeout(() => {
      closeAlert()
    }, time)
  }

  function setAlertInfo(alertMessage) {
    message.value = alertMessage
    show.value = true
    level.value = 'info'
  }
  function setAlertInfoTimed(alertMessage, time) {
    setAlertInfo(alertMessage)
    setTimeout(() => {
      closeAlert()
    }, time)
  }
  return {
    message,
    level,
    show,
    setAlertError,
    setAlertErrorTimed,
    setAlertInfo,
    setAlertInfoTimed,
    closeAlert,
  }
})
