<template>
  <div class="account-actions">
    <div class="infos">
      <p>email : {{ userContext.email }}</p>
      <p>name : {{ userContext.name }}</p>
    </div>
    <div class="actions">
      <div class="app-btn" @click="onRequestNewPassword">
        <img src="src/assets/icons/key.svg" class="theme-icon" />
        Request a password change
      </div>
      <div class="btn-warning app-btn" @click="onDeleteAccount">
        <img src="src/assets/icons/person_remove.svg" class="theme-icon" />
        Delete account
      </div>
    </div>
    <div class="popup" v-if="hasToConfirm">
      <div class="popup-content">
        <div class="popup-info">
          <img src="src/assets/icons/warning.svg" class="icon theme-icon" />
          <div class="popup-msg">{{ confirmData.message }}</div>
        </div>
        <div class="popup-actions">
          <div class="app-btn" @click="onCancelConfirm">
            {{ confirmData.cancelLabel }}
          </div>
          <div class="app-btn-warning" @click="onAcceptConfirm">
            {{ confirmData.confirmLabel }}
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
  message: 'message',
  cancelLabel: 'Cancel',
  confirmLabel: 'Yes',
})

function onRequestNewPassword() {
  hasToConfirm.value = true
  confirmFunc = userContext.sendEmailReset
  confirmData.message =
    'Request a password change ? You will receive a email with a link to change your password.'
  confirmData.confirmLabel = 'Yes send me the email'
}

function onDeleteAccount() {
  hasToConfirm.value = true
  confirmFunc = userContext.deleteCurrentUser
  confirmData.message = 'Delete account ? Warning : no undo.'
  confirmData.confirmLabel = 'Yes delete my account'
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
  width: 100%;
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
