import { defineStore } from 'pinia'
import { ref } from 'vue'
import { useUserContext } from '@/stores/userContextStore'
import { useAppAlert } from '@/stores/appAlertStore'

export const useAllergens = defineStore('allergens', () => {
  const allergens = ref([])

  const appAlert = useAppAlert()

  function getAllergensFilteredUser(userAllergens) {
    return allergens.value
      .filter((value) => !userAllergens.includes(value))
      .map((value) => value.trim().toLowerCase())
  }

  async function fetchAllergens() {
    const userContext = useUserContext()
    const token = await userContext.getToken()

    let myHeaders = new Headers()
    myHeaders.append('accept', 'application/json')
    myHeaders.append('Authorization', 'Bearer ' + token)

    const requestOptions = {
      method: 'GET',
      headers: myHeaders,
      redirect: 'follow',
    }

    fetch(import.meta.env.VITE_API_URL + 'allergens', requestOptions)
      .then((response) => response.text())
      .then((result) => (allergens.value = JSON.parse(result)))
      .catch((error) => {
        console.log('error', error.message)
        appAlert.setAlertErrorTimed('Error fetching allergens', 3500)
      })
  }

  return {
    allergens,
    fetchAllergens,
    getAllergensFilteredUser,
  }
})
