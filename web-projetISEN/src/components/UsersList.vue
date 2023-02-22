<template>
  <div class="users-container">
    <div class="allergens-list">
      
    </div>
  </div>
</template>

<script setup>
import { useAdmin } from '@/stores/adminStore'

const adminStore = useAdmin()

async function deactivateUser(uid) {
  await adminStore.deactivateUser(uid)
}

async function reactivateUser(uid) {
  await adminStore.reactivateUser(uid)
}
</script>
<style scoped>
</style>
  