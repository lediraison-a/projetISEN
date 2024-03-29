import { defineStore } from 'pinia'
import { ref } from 'vue'
import { useUserContext } from '@/stores/userContextStore'
import { useAppAlert } from '@/stores/appAlertStore'

export const useUserAllergens = defineStore('userAllergens', () => {
  const allergens = ref([])

  const appAlert = useAppAlert()

  async function fetchUserAllergens() {
    allergens.value = []

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

    fetch(import.meta.env.VITE_API_URL + 'user/allergens', requestOptions)
      .then((response) => response.text())
      .then((result) => (allergens.value = JSON.parse(result)))
      .catch((error) => {
        console.log('error', error.message)
        appAlert.setAlertErrorTimed('alert.errorFetchUserAllergens', 3500)
      })
  }

  async function updateUserAllergens() {
    const userContext = useUserContext()
    const token = await userContext.getToken()

    const myHeaders = new Headers()
    myHeaders.append('accept', 'application/json')
    myHeaders.append('Authorization', 'Bearer ' + token)
    myHeaders.append('Content-Type', 'application/json')

    const requestOptions = {
      method: 'PUT',
      headers: myHeaders,
      body: JSON.stringify(allergens.value),
      redirect: 'follow',
    }

    fetch(import.meta.env.VITE_API_URL + 'user/allergens', requestOptions)
      .then((response) => response.text())
      .then((result) => {
        console.log(result)
        appAlert.setAlertInfoTimed('alert.okUserAllergensUpdate', 3500)
      })
      .catch((error) => {
        console.log('error', error.message)
        appAlert.setAlertErrorTimed('alert.errorUserAllergensUpdate', 3500)
      })
  }

  function deleteAllergen(index) {
    allergens.value.splice(index, 1)
  }

  function addAllergen(allergen) {
    allergens.value.push(allergen)
  }

  return {
    allergens,
    fetchUserAllergens,
    deleteAllergen,
    updateUserAllergens,
    addAllergen,
  }
})
