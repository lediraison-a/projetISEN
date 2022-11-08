import { defineStore } from 'pinia'
import { ref } from 'vue'

export const useUserContext = defineStore('userAllergens', () => {
  const allergens = ref([])

  async function fetchUserAllergens() {
    const userContext = useUserContext()

    const myHeaders = new Headers()
    myHeaders.append('accept', 'application/json')
    myHeaders.append('Authorization', 'Bearer ' + userContext.getToken())

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

  return {
    allergens,
    fetchUserAllergens,
  }
})
