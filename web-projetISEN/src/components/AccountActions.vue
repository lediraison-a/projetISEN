<template>
  <div class="account-actions">
    <div class="infos">
      <p>{{ $t('message.email') }} : {{ userContext.email }}</p>
      <p>{{ $t('message.name') }} : {{ userContext.name }}</p>
    </div>
    <div class="actions">
      <div class="app-btn" @click="onRequestNewPassword">
        <img src="/src/assets/icons/key.svg" class="theme-icon" />
        {{ $t('message.passwordChange') }}
      </div>
      <div class="btn-warning app-btn" @click="onDeleteAccount">
        <img src="/src/assets/icons/person_remove.svg" class="theme-icon" />
        {{ $t('message.deleteAccount') }}
      </div>
    </div>
    <div class="popup" v-if="hasToConfirm">
      <div class="popup-content">
        <div class="popup-info">
          <img src="/src/assets/icons/warning.svg" class="icon theme-icon" />
          <div class="popup-msg">{{ $t(confirmData.message) }}</div>
        </div>
        <div class="popup-actions">
          <div class="app-btn" @click="onCancelConfirm">
            {{ $t(confirmData.cancelLabel) }}
          </div>
          <div class="app-btn-warning" @click="onAcceptConfirm">
            {{ $t(confirmData.confirmLabel) }}
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { useUserContext } from '@/stores/userContextStore'
import { reactive, ref } from 'vue'

const userContext = useUserContext()

const hasToConfirm = ref(false)
let confirmFunc = null

const confirmData = reactive({
  message: '',
  cancelLabel: 'message.cancel',
  confirmLabel: 'message.yes',
})

function onRequestNewPassword() {
  hasToConfirm.value = true
  confirmFunc = userContext.sendEmailReset
  confirmData.message = 'accountActions.passwordResetConfirmMsg'
  confirmData.confirmLabel = 'accountActions.passwordResetConfirmLabel'
}

function onDeleteAccount() {
  hasToConfirm.value = true
  confirmFunc = userContext.deleteCurrentUser
  confirmData.message = 'accountActions.deleteConfirmMsg'
  confirmData.confirmLabel = 'accountActions.deleteConfirmLabel'
}

function onCancelConfirm() {
  hasToConfirm.value = false
}

function onAcceptConfirm() {
  confirmFunc.apply()
  hasToConfirm.value = false
}
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

.popup-actions {
  display: flex;
  flex-direction: row;
  gap: 0.4rem;
  margin-top: 1rem;
  justify-content: flex-end;
}

.popup-content {
  background-color: var(--color-background-soft);
  border-radius: 0.375em;
  border: solid var(--color-border) 1px;
  padding: 0.8rem;
}

.icon {
  height: 24px;
}

.popup-info {
  gap: 1rem;
  display: flex;
  flex-direction: row;
}

.popup-msg {
  color: var(--error);
}
</style>
