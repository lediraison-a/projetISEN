<template>
  <div class="header">
    <router-link to="/">
      {{ appName }}
    </router-link>
  </div>
</template>
<script setup>
import { inject } from 'vue'

const appName = inject('appName')

</script>
<style scoped>
.header {
  display: flex;
  align-items: center;
  padding-left: 2rem;
}
</style>