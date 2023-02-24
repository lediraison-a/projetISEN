import { defineStore } from 'pinia'
import { ref } from 'vue'
import { useUserContext } from '@/stores/userContextStore'
import { useAppAlert } from '@/stores/appAlertStore'
import router from '@/router'

export const useAdmin = defineStore('admin', () => {
  const userList = ref([])

  const appAlert = useAppAlert()

  function checkAdmin(resp) {
    if (resp.status === 403) {
      router.push('/')
    }
  }

  async function isSelfAdmin() {
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

    return fetch(
      import.meta.env.VITE_API_URL + 'admin/selfadmin',
      requestOptions
    )
      .then((response) => response.text())
      .then(() => true)
      .catch((error) => {
        console.log('error', error)
        return false
      })
  }

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
      .then((response) => {
        checkAdmin(response)
        return response.text()
      })
      .then((result) => (userList.value = JSON.parse(result)))
      .catch((error) => {
        console.log('error', error)
        appAlert.setAlertErrorTimed('alert.errorFetchUserList', 3500)
      })
  }

  async function updateUsers() {
    const userContext = useUserContext()
    const token = await userContext.getToken()

    const myHeaders = new Headers()
    myHeaders.append('accept', 'application/json')
    myHeaders.append('Authorization', 'Bearer ' + token)

    const requestOptions = {
      method: 'PUT',
      headers: myHeaders,
      body: JSON.stringify(userList.value),
      redirect: 'follow',
    }

    fetch(import.meta.env.VITE_API_URL + 'admin/users', requestOptions)
      .then((response) => {
        checkAdmin(response)
        return response.text()
      })
      .then((result) => console.log(result))
      .catch((error) => {
        console.log('error', error)
        appAlert.setAlertErrorTimed('alert.errorUpdatingUsers', 3500)
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
      .then((response) => {
        checkAdmin(response)
        return response.text()
      })
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
      .then((response) => {
        checkAdmin(response)
        return response.text()
      })
      .then((result) => console.log(result))
      .catch((error) => {
        console.log('error', error)
        appAlert.setAlertErrorTimed('alert.errorReactivateUser', 3500)
      })
  }

  return {
    userList,
    isSelfAdmin,
    fetchUserList,
    deactivateUser,
    reactivateUser,
    updateUsers,
  }
})
