<template>
  <div class="allergens-container">
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
    <div v-if="userAllergens.allergens.length === 0" class="label-noallergens">
      no allergens
    </div>
    <div class="add-allergen-item">
      <div class="allergen-label">add an allergen</div>
      <div class="add-btn">
        <img class="icon" src="src/assets/icons/add_box.svg" />
      </div>
    </div>
  </div>
</template>
<script setup>
import { useUserAllergens } from '@/stores/userAllergens'

const userAllergens = useUserAllergens()
</script>

<style scoped>
.allergens-container {
  border-radius: 0.6rem;
  background-color: var(--color-background-soft);
  padding: 0.4rem;
  margin: 1rem;
  display: flex;
  gap: 0.2rem;
  flex-wrap: wrap;
}

.allergen-item,
.add-allergen-item {
  cursor: pointer;
  background-color: cadetblue;
  border-radius: 0.4rem;
  min-width: fit-content;
  display: flex;
  align-items: center;
}

.delete-icon {
  width: 0;
}

.icon {
  height: 22px;
  display: flex;
  align-items: center;
}

.delete-btn, .add-btn {
  padding: 0.2rem;
  border-radius: 0 0.4rem 0.4rem 0;
}

.allergen-label {
  font-size: large;
  padding: 0 0.4rem;
}

.delete-btn:hover, .add-allergen-item:hover {
  background-color: red;
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
