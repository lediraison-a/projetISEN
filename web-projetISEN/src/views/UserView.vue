<template>
  <div class="user-view">
    <h2>{{ $t('message.allergens') }}</h2>
    <AllergensList />
    <AllergensActions />
    <div class="account-area">
      <h2>{{ $t('message.accountSettings') }}</h2>
      <AccountActions />
    </div>
  </div>
</template>

<script setup>
import { onMounted } from 'vue'
import { useUserAllergens } from '@/stores/userAllergensStore'
import AllergensList from '@/components/AllergensList.vue'
import AllergensActions from '@/components/AllergensActions.vue'
import AccountActions from '@/components/AccountActions.vue'

const userAllergens = useUserAllergens()

onMounted(async () => {
  await userAllergens.fetchUserAllergens()
})
</script>

<style scoped>
.user-view {
  padding: 1rem;
}

.account-area {
  margin-top: 1rem;
  padding-top: 1rem;
  border-top: solid var(--color-border) 1px;
}
</style>
