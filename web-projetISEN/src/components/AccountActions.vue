<template>
  <div class="account-actions">
    <div class="infos">
      <p>email : {{ userContext.email }}</p>
      <p>name : {{ userContext.name }}</p>
    </div>
    <div class="actions">
      <div class="app-btn">
        <img src="src/assets/icons/key.svg" />
        Request a new password
      </div>
      <div class="btn-warning app-btn">
        <img src="src/assets/icons/person_remove.svg" />
        Delete account
      </div>
    </div>
  </div>
</template>

<script setup>
import { useUserContext } from '@/stores/userContextStore'

const userContext = useUserContext()
</script>

<style scoped>
.account-actions {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.infos {
}

.actions {
  display: flex;
  justify-content: flex-end;
  gap: 0.4rem;
}
</style>
