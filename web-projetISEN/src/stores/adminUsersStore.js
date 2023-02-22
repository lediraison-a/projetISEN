import { defineStore } from 'pinia'
import { ref } from 'vue'

export const adminUsers = defineStore('users', () => {
  const userList = ref([])

  function fetchUserList() {
    
  }
  
  function deactivateUser() {
    
  }
  
  function reactivateUser() {

  }

  return {
    userList,
    fetchUserList,
    deactivateUser,
    reactivateUser,
  }
})
