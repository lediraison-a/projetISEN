<template>
  <div class="users-container">
    <h3>Liste des utilisateurs</h3>
    <div>
      <table class="userlist-table">
        <tr>
          <th>Name</th>
          <th>Mail</th>
          <th>Uid</th>
          <th>is deactivated</th>
          <th>is admin</th>
        </tr>
        <tr v-for="user in adminStore.userList" :key="user.uid">
          <td>{{ user.name }}</td>
          <td>{{ user.mail }}</td>
          <td>{{ user.uid }}</td>
          <td class="center-cell">
            <input type="checkbox" v-model="user.disabled" />
          </td>
          <td class="center-cell">
            <input type="checkbox" v-model="user.isadmin" />
          </td>
        </tr>
      </table>
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

async function saveChanges() {
  await adminStore.updateUsers()
}

async function cancelChanges() {
  await adminStore.fetchUserList()
}
</script>
<style scoped>
.action-btns {
  display: flex;
  flex-direction: row;
  gap: 1rem;
}

.list-actions {
  padding-top: 1rem;
  display: flex;
  justify-content: flex-end;
}

tr:nth-child(even) {
  background-color: var(--color-background-soft);
}

.userlist-table {
  width: 100%;
  border: solid var(--color-border) 1px;
  border-radius: 0.5rem;
  border-spacing: 0.2rem 0.4rem;
}

.users-container {
  padding: 1rem 2rem;
}

td, th {
  padding: 0.3rem;
}


input[type=checkbox] {
  accent-color: var(--primary);
}


/*input[type='checkbox'] {*/
/*  position: relative;*/
/*  appearance: none;*/
/*  width: 2.6rem;*/
/*  height: 1.3rem;*/
/*  background: #ccc;*/
/*  border-radius: 1.3rem;*/
/*  box-shadow: inset 0 0 5px rgba(0, 0, 0, 0.2);*/
/*  cursor: pointer;*/
/*  transition: 0.1s;*/
/*}*/

/*input:checked[type='checkbox'] {*/
/*  background: var(--primary);*/
/*}*/

/*input[type='checkbox']::after {*/
/*  position: absolute;*/
/*  content: '';*/
/*  width: 1.3rem;*/
/*  height: 1.3rem;*/
/*  top: 0;*/
/*  left: 0;*/
/*  background: #fff;*/
/*  border-radius: 50%;*/
/*  box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);*/
/*  transform: scale(1.1);*/
/*  transition: 0.1s;*/
/*}*/

/*input:checked[type='checkbox']::after {*/
/*  left: 50%;*/
/*}*/
</style>
