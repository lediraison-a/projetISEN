<template>
  <div class="actions">
    <div class="app-btn" @click="userAllergens.fetchUserAllergens">
      <img src="src/assets/icons/cancel.svg" class="theme-icon" />
      Cancel changes
    </div>
    <div class="app-btn-primary" @click="userAllergens.updateUserAllergens">
      <img src="src/assets/icons/save.svg" />
      Save changes
    </div>
  </div>
</template>

<script setup>
import { useUserAllergens } from '@/stores/userAllergensStore'

const userAllergens = useUserAllergens()
</script>

<style scoped>
.actions {
  display: flex;
  justify-content: flex-end;
  gap: 0.4rem;
}
</style>
