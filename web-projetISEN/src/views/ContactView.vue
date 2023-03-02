<template>
  <div class="contact">
    <h2>{{ $t('contact.title') }}</h2>
    <div class="hero">
      <form :action="getMailTo" method="get" enctype="text/plain">
        <div class="form-inputs">
          <div class="form-input">
            <label for="subject">{{ $t('contact.subject') }}</label>
            <input type="text" name="subject" id="" class="app-input" />
          </div>
        </div>
        <div class="form-actions">
          <input
            type="submit"
            name="submit"
            :value="$t('contact.send')"
            class="app-btn-primary"
          />
        </div>
      </form>
    </div>
  </div>
</template>
<script setup>
import { computed, reactive } from 'vue'

const formData = reactive({
  subject: '',
})

const contactMail = import.meta.env.VITE_CONTACT_MAIL

const getMailTo = computed(
  () =>
    `mailto:${contactMail}?subject=${formData.subject}&body=${formData.content}`
)
</script>
<style scoped>
.contact {
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 1rem;
  flex-direction: column;
}

.hero {
  width: 100%;
  max-width: 40rem;
}

.form-inputs {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.form-input {
  display: flex;
  flex-direction: column;
}

.form-actions {
  display: flex;
  flex-direction: row;
  gap: 1rem;
  justify-content: flex-end;
  padding-top: 1rem;
}
</style>
