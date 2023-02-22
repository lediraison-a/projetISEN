import { defineStore } from 'pinia'
import { ref } from 'vue'
import { useUserContext } from '@/stores/userContextStore'
import { useAppAlert } from '@/stores/appAlertStore'

export const useAdmin = defineStore('admin', () => {
  const userList = ref([])

  const appAlert = useAppAlert()

  async function fetchUserList() {
    const userContext = useUserContext()
    const token = await userContext.getToken()

    const myHeaders = new Headers()
    myHeaders.append('accept', 'application/json')
    myHeaders.append('Authorization', 'Bearer ' + token)

    const requestOptions = {
      method: 'GET',
      headers: myHeaders,
      redirect: 'follow',
    }

    fetch(import.meta.env.VITE_API_URL + 'admin/users', requestOptions)
      .then((response) => response.text())
      .then((result) => (userList.value = JSON.parse(result)))
      .catch((error) => {
        console.log('error', error)
        appAlert.setAlertErrorTimed('alert.errorFetchUserList', 3500)
      })
  }

  async function deactivateUser(uid) {
    const userContext = useUserContext()
    const token = await userContext.getToken()

    const myHeaders = new Headers()
    myHeaders.append('accept', 'application/json')
    myHeaders.append('Authorization', 'Bearer ' + token)

    const requestOptions = {
      method: 'POST',
      headers: myHeaders,
      redirect: 'follow',
    }

    fetch(
      import.meta.env.VITE_API_URL + 'admin/deactivate/' + uid,
      requestOptions
    )
      .then((response) => response.text())
      .then((result) => console.log(result))
      .catch((error) => {
        console.log('error', error)
        appAlert.setAlertErrorTimed('alert.errorDeactivateUser', 3500)
      })
  }

  async function reactivateUser(uid) {
    const userContext = useUserContext()
    const token = await userContext.getToken()

    const myHeaders = new Headers()
    myHeaders.append('accept', 'application/json')
    myHeaders.append('Authorization', 'Bearer ' + token)

    const requestOptions = {
      method: 'POST',
      headers: myHeaders,
      redirect: 'follow',
    }

    fetch(
      import.meta.env.VITE_API_URL + 'admin/reactivate/' + uid,
      requestOptions
    )
      .then((response) => response.text())
      .then((result) => console.log(result))
      .catch((error) => {
        console.log('error', error)
        appAlert.setAlertErrorTimed('alert.errorReactivateUser', 3500)
      })
  }

  return {
    userList,
    fetchUserList,
    deactivateUser,
    reactivateUser,
  }
})
