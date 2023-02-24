<template>
  <div class="content">
    <div v-if="locale === 'en'">
      <QnaEN />
    </div>
    <div v-else-if="locale === 'fr'">
      <QnaFR />
    </div>
  </div>
</template>

<script setup>
import QnaFR from '@/assets/qna/qna-fr.md'
import QnaEN from '@/assets/qna/qna-en.md'
import { useI18n } from 'vue-i18n'
const { locale } = useI18n({ useScope: 'global' })
</script>
<style scoped>
.content {
  padding: 1rem;
}
</style>
