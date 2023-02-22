import { defineStore } from 'pinia'
import allergenData from '@/assets/allergens.json'
import { computed } from 'vue'

export const useAllergens = defineStore('allergens', () => {
  const allergens = computed(() => {
    return Object.getOwnPropertyNames(allergenData)
      .map((s) => s.substring(3))
      .filter((s) => s !== 'none')
  })

  function getAllergenName(allergen, locale) {
    return allergenData['en:' + allergen]['name'][locale]
  }

  return {
    allergens,
    getAllergenName,
  }
})
