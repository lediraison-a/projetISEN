<template>
  <div class="users-container">
    <div class="allergens-list">
      
    </div>
  </div>
</template>

<script setup>

import { adminUsers } from '@/stores/adminUsersStore'

const usersList = adminUsers()
console.log(usersList)

</script>
  
<style scoped>
</style>
  