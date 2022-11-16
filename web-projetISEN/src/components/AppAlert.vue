<template>
  <div class="alert" v-if="appAlert.show" :class="appAlert.level">
    <img src="src/assets/icons/info.svg" v-if="appAlert.level === 'info'" />
    <img src="src/assets/icons/warning.svg" v-if="appAlert.level === 'error'" />
    <div class="alert-message">{{ appAlert.message }}</div>
  </div>
</template>
<script setup>
import { useAppAlert } from '@/stores/appAlertStore'

const appAlert = useAppAlert()
</script>

<style scoped>
.alert {
  position: fixed;
  bottom: 1rem;
  right: 1rem;
  background-color: var(--color-background-soft);
  border-radius: 0.5rem;
  border: solid var(--color-border) 1px;
  padding: 0.5rem;
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

img {
  height: 24px;
}

.alert-message {
  font-size: large;
  user-select: none;
}

.info {
  border: solid var(--color-border) 1px;
  color: var(--color-text);
}

.error {
  border: solid var(--error) 1px;
  color: var(--error);
}
</style>
