<template>
  <div class="admin-view">
    <h2>{{ $t('message.loggedAsAdmin') }}</h2>
    <UsersList />
  </div>
</template>

<script setup>
import { onMounted } from 'vue'
import UsersList from '@/components/UsersList.vue'

onMounted(async () => {})
</script>

<style scoped>
.admin-view {
  padding: 1rem;
}

.account-area {
  margin-top: 1rem;
  padding-top: 1rem;
  border-top: solid var(--color-border) 1px;
}
</style>
