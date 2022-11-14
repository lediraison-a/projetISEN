<template>
  <div class="user-view">
    <h2>Allergens</h2>
    <AllergensList />
    <AllergensActions />
    <h2>Account settings</h2>
  </div>
</template>

<script setup>
import { onMounted } from 'vue'
import { useUserAllergens } from '@/stores/userAllergens'
import AllergensList from '@/components/AllergensList.vue'
import AllergensActions from '@/components/AllergensActions.vue'

const userAllergens = useUserAllergens()

onMounted(async () => {
  await userAllergens.fetchUserAllergens()
  console.log(userAllergens.allergens)
})
</script>

<style scoped>
.user-view {
  padding: 1rem;
}
</style>
