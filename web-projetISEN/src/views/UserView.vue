<template>
  <div>
    <p>User</p>
    <AllergensList />
  </div>
</template>

<script setup>
import { onMounted } from 'vue'
import { useUserAllergens } from '@/stores/userAllergens'
import AllergensList from '@/components/AllergensList.vue'

const userAllergens = useUserAllergens()

onMounted(async () => {
  await userAllergens.fetchUserAllergens()
  console.log(userAllergens.allergens)
})
</script>

<style scoped></style>
