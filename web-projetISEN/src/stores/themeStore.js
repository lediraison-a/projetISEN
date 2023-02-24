import { defineStore } from 'pinia'
import { ref } from 'vue'

export const useTheme = defineStore('theme', () => {
  const themePrefKey = 'dish-themePref'
  const theme = ref('')

  function fetchTheme() {
    const themePref = localStorage.getItem(themePrefKey)
    if (themePref) {
      theme.value = themePref
      return
    }

    theme.value = window?.matchMedia?.('(prefers-color-scheme:dark)')?.matches
      ? 'dark'
      : 'light'
  }

  function switchTheme() {
    theme.value = theme.value === 'dark' ? 'light' : 'dark'
    localStorage.setItem(themePrefKey, theme.value)
  }

  return {
    theme,
    fetchTheme,
    switchTheme,
  }
})
