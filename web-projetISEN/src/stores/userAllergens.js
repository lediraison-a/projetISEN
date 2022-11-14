import { defineStore } from 'pinia'
import { ref } from 'vue'
import { useUserContext } from '@/stores/userContext'

export const useUserAllergens = defineStore('userAllergens', () => {
  const allergens = ref([])

  async function fetchUserAllergens() {
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
      .catch((error) => console.log('error', error))
  }

  async function updateUserAllergens() {
    const userContext = useUserContext()
    const token = await userContext.getToken()

    const myHeaders = new Headers()
    myHeaders.append('Content-Type', 'application/json')
    myHeaders.append('Authorization', 'Bearer ' + token)

    const requestOptions = {
      method: 'PUT',
      headers: myHeaders,
      body: JSON.stringify(allergens.value),
      redirect: 'follow',
    }

    fetch(import.meta.env.VITE_API_URL + 'user/allergens', requestOptions)
      .then((response) => response.text())
      .then((result) => console.log(result))
      .catch((error) => console.log('error', error))
  }

  function deleteAllergen(index) {
    allergens.value.splice(index, 1)
  }

  return {
    allergens,
    fetchUserAllergens,
    deleteAllergen,
    updateUserAllergens,
  }
})
