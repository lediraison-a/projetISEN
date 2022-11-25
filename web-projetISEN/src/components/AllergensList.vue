<template>
  <div class="allergens-container">
    <div class="allergens-list">
      <div
        v-for="(allergen, i) in userAllergens.allergens"
        :key="i"
        class="allergen-item"
      >
        <div class="allergen-label">{{ allergen }}</div>
        <div class="delete-btn" @click="userAllergens.deleteAllergen(i)">
          <img class="delete-icon icon" src="src/assets/icons/delete.svg" />
        </div>
      </div>
      <div
        v-if="userAllergens.allergens.length === 0"
        class="label-noallergens"
      >
        no allergens
      </div>
      <div
        class="add-allergen-item"
        @click="popupVisible = true"
        v-if="!popupVisible"
      >
        <div class="allergen-label">add an allergen</div>
        <div class="add-btn">
          <img class="icon" src="src/assets/icons/add_box.svg" />
        </div>
      </div>
    </div>
    <div class="popup-add-allergen" v-if="popupVisible">
      <div class="popup-content">
        <div>Add an allergen</div>
        <div class="allergen-input">
          <input
            type="text"
            class="app-input allergen-text-input"
            v-model="allergenInput"
          />
          <div class="app-btn" @click="popupVisible = false">
            <img src="src/assets/icons/cancel.svg" />
            Cancel
          </div>
          <div class="app-btn-primary" @click="addAllergen">
            <img src="src/assets/icons/add_box.svg" />
            Add
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script setup>
import { useUserAllergens } from '@/stores/userAllergensStore'
import { ref } from 'vue'

const popupVisible = ref(false)
const allergenInput = ref('')

const userAllergens = useUserAllergens()

function addAllergen() {
  if (!allergenInput.value.trim()) {
    allergenInput.value = ''
    return
  }
  userAllergens.addAllergen(allergenInput.value)
  popupVisible.value = false
  allergenInput.value = ''
}
</script>

<style scoped>
.popup-add-allergen {
  margin-top: 1rem;
  display: flex;
  justify-content: center;
  align-items: center;
  border-top: solid var(--color-border) 1px;
}

.popup-content {
  border-radius: 0.5rem;
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
  width: 100%;
}

.allergen-input {
  display: flex;
  gap: 0.4rem;
  width: 100%;
}

.allergen-text-input {
  width: 100%;
}

.allergens-container {
  border-radius: 0.6rem;
  background-color: var(--color-background-soft);
  padding: 0.8rem;
  display: flex;
  flex-direction: column;
  gap: 0.3rem;
  flex-wrap: wrap;
  margin: 1rem 0;
  border: solid var(--color-border) 1px;
}

.allergens-list {
  display: flex;
  flex-wrap: wrap;
  gap: 0.5rem;
}

.allergen-item,
.add-allergen-item {
  cursor: pointer;
  border-radius: 0.375em;
  min-width: fit-content;
  display: flex;
  align-items: center;
  box-sizing: border-box;
}

.add-allergen-item {
  background-color: var(--primary);
}

.allergen-item {
  background-color: var(--color-background);
  outline: solid var(--primary) 2px;
}

.delete-icon {
  width: 0;
}

.icon {
  height: 22px;
  display: flex;
  align-items: center;
}

.delete-btn,
.add-btn {
  padding: 0.2rem;
  border-radius: 0 0.4rem 0.4rem 0;
}

.allergen-label {
  font-size: medium;
  padding: 0 0.4rem;
}

.delete-btn:hover,
.add-allergen-item:hover {
  background-color: var(--primary);
  filter: brightness(115%);
}

.allergen-item:hover .delete-icon {
  width: 100%;
}

.add-allergen-item:hover .allergen-label {
  width: 100%;
  display: flex;
}

.add-allergen-item > .allergen-label {
  width: 0;
  display: none;
}

.label-noallergens {
  font-size: large;
}
</style>
