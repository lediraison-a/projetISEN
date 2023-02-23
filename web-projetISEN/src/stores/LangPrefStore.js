import { defineStore } from 'pinia'

export const useLangPref = defineStore('langPref', () => {
  const langPrefKey = 'dish-langPref'

  function getLangPref() {
    const langPref = localStorage.getItem(langPrefKey)

    if (langPref) return langPref
    else return 'en'
  }

  function saveLangPref(langPref) {
    console.log(langPref)
    localStorage.setItem(langPrefKey, langPref)
  }

  return {
    getLangPref,
    saveLangPref,
  }
})
