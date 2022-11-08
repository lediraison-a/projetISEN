<template>
  <div class="home-content">
    <div class="btn-start app-btn-primary">
      <router-link to="/signin" class="signin-link"
        >Sign in to get started</router-link
      >
    </div>
  </div>
</template>
<script setup></script>
<style scoped>
.home-content {
  height: calc(100vh - 3rem);
  display: flex;
  justify-content: center;
  align-items: center;
}

.btn-start {
  font-size: large;
  font-weight: bold;
}

.signin-link {
  color: var(--vt-c-text-light-1);
}
</style>
