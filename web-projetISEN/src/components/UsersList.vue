<template>
  <div class="users-container">
    <h3>Liste des utilisateurs</h3>
    <div class="allergens-list">
      <div v-for="user in adminStore.userList" :key="user.uid">
        <label :for="'user-' + user.uid"> Disabled :</label>
        <input
          type="checkbox"
          :id="'user-' + user.Uid"
          :value="user.uid"
          v-model="user.disabled"
          @change="onCheckboxChange(user)"
        />
        <label :for="'user-' + user.uid">{{ user.mail }}</label>
      </div>
    </div>
    <div class="list-actions">
      <div class="action-btns">
        <div class="btn-cancel app-btn" @click="cancelChanges">
          {{ $t('message.cancelChanges') }}
        </div>
        <div class="btn-save app-btn-primary" @click="saveChanges">
          <img src="/src/assets/icons/save.svg" />
          {{ $t('message.saveChanges') }}
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { useAdmin } from '@/stores/adminStore'

const adminStore = useAdmin()

console.log(adminStore)

async function deactivateUser(uid) {
  await adminStore.deactivateUser(uid)
}

async function reactivateUser(uid) {
  await adminStore.reactivateUser(uid)
}

function onCheckboxChange(user) {
  if (user.disabled) {
    console.log('tu es bien en train de désactiver un mec')
    deactivateUser(user.uid)
  } else {
    console.log("tu es bien en train d'activer un mec")
    reactivateUser(user.uid)
  }
}

function saveChanges() {
  adminStore.updateUsers()
}

function cancelChanges() {
  adminStore.fetchUserList()
}
</script>
<style scoped>
.action-btns {
  display: flex;
  flex-direction: row;
  gap: 1rem;
}


.list-actions {
  display: flex;
  justify-content: flex-end;
}
</style>
