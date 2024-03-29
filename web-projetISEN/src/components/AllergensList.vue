<template>
  <div class="allergens-container">
    <div class="allergens-list">
      <div
        v-for="(allergen, i) in userAllergens.allergens"
        :key="i"
        class="allergen-item"
        @click="userAllergens.deleteAllergen(i)"
      >
        <div class="allergen-label">{{ getAllergenName(allergen) }}</div>
        <div class="delete-btn">
          <img
            class="delete-icon icon"
            src="/src/assets/icons/delete.svg"
          />
        </div>
      </div>
      <div
        v-if="userAllergens.allergens.length === 0"
        class="label-noallergens"
      >
        {{ $t('message.noAllergen') }}
      </div>
      <div
        class="add-allergen-item"
        @click="openAddPopup"
        v-if="!componentData.popupVisible"
      >
        <div class="allergen-label allergen-label-add">
          {{ $t('message.addAnAllergen') }}
        </div>
        <div class="add-btn">
          <img class="icon" src="/src/assets/icons/add_box.svg" />
        </div>
      </div>
    </div>
    <div class="popup-add-allergen" v-if="componentData.popupVisible">
      <div class="popup-content">
        <div>{{ $t('message.addAnAllergen') }}</div>
        <div class="allergen-input">
          <div class="allergen-input-area">
            <input
              ref="input"
              @focusin="componentData.inputFocus = true"
              @focusout="
                checkValidInput();
                componentData.inputFocus = false
              "
              type="text"
              class="app-input allergen-text-input"
              v-model="componentData.allergenInput"
              placeholder="..."
              @keydown.down="moveSelectedSuggestion(1)"
              @keydown.up="moveSelectedSuggestion(-1)"
              @keydown.enter="
                selectSuggestionIndex(componentData.suggestionSelected)
              "
              @input="componentData.suggestionSelected = 0"
            />
            <div
              class="allergens-suggestion"
              v-if="componentData.inputFocus && suggestions.length > 0"
            >
              <div
                class="suggestion-item"
                v-for="(suggestion, i) in suggestions"
                :key="i"
                @mousedown="selectSuggestionIndex(i)"
                @mouseover="componentData.suggestionSelected = i"
                :class="
                  componentData.suggestionSelected === i
                    ? 'suggestion-item-selected'
                    : ''
                "
              >
                {{ getAllergenName(suggestion) }}
              </div>
            </div>
          </div>
          <div class="app-btn" @click="cancelAddPopup">
            <img src="/src/assets/icons/cancel.svg" class="theme-icon" />
            {{ $t('message.cancel') }}
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script setup>
import { useUserAllergens } from '@/stores/userAllergensStore'
import { computed, reactive, ref } from 'vue'
import { useAllergens } from '@/stores/allergensStore'
import { useI18n } from 'vue-i18n'
const { locale } = useI18n({ useScope: 'global' })

const userAllergens = useUserAllergens()
const allergensStore = useAllergens()

const input = ref(null)

const componentData = reactive({
  popupVisible: false,
  allergenInput: '',
  inputFocus: false,
  suggestionSelected: 0,
})

function getAllergenName(allergen) {
  return allergensStore.getAllergenName(allergen, locale.value)
}

const allergenInputSanitized = computed(() =>
  componentData.allergenInput.trim().toLowerCase()
)

const allergensFilteredUser = computed(() =>
  allergensStore.allergens.filter(
    (v) =>
      !userAllergens.allergens
        .map((v) => v.toLowerCase())
        .includes(v.toLowerCase())
  )
)
const suggestions = computed(() => {
  let suggestions = allergensFilteredUser.value
    .filter((v) =>
    getAllergenName(v).toLowerCase().startsWith(allergenInputSanitized.value)
  )
  if (
    suggestions.length === 1 &&
    suggestions[0] === allergenInputSanitized.value
  ) {
    suggestions = []
  }
  return suggestions
})

function selectSuggestionIndex(index) {
  const allergenOk = suggestions.value[index]
  componentData.allergenInput = getAllergenName(allergenOk)
  componentData.suggestionSelected = 0
  userAllergens.addAllergen(allergenOk)
  componentData.allergenInput = ''
  setTimeout(() => {
    input.value.focus()
  }, 1)
}

function moveSelectedSuggestion(num) {
  componentData.suggestionSelected += num
  if (componentData.suggestionSelected < 0) {
    componentData.suggestionSelected = 0
  } else if (componentData.suggestionSelected >= suggestions.value.length) {
    componentData.suggestionSelected = suggestions.value.length - 1
  }
}

function openAddPopup() {
  componentData.popupVisible = true
  setTimeout(() => {
    input.value.focus()
  }, 1)
}

function cancelAddPopup() {
  componentData.popupVisible = false
  componentData.suggestionSelected = 0
  componentData.allergenInput = ''
}

function checkValidInput() {
  if (!allergensFilteredUser.value.includes(allergenInputSanitized.value)) {
    componentData.allergenInput = ''
  }
}
</script>

<style scoped>
.allergens-suggestion {
  position: absolute;
  top: calc(100% - 0.6rem);
  background-color: var(--color-background);
  z-index: 3;
  width: 100%;
  display: flex;
  flex-direction: column;
  gap: 0.2rem;
  padding: 0.6rem 0.2rem 0.2rem 0.2rem;
  border-left: solid var(--color-border) 2px;
  border-right: solid var(--color-border) 2px;
  border-bottom: solid var(--color-border) 2px;
  border-radius: 0 0 0.375em 0.375em;
  box-shadow: -1px 0 0 0 var(--color-border), 1px 0 0 0 var(--color-border),
    0 1px 0 0 var(--color-border);
}

.suggestions-hidden {
}

.suggestions-show {
}

.suggestion-item {
  color: var(--color-text);
  background-color: var(--color-background-soft);
  padding: 0.2rem;
  border-radius: 0.375em;
  cursor: pointer;
}

.allergen-input-area {
  width: 100%;
  height: auto;
  display: flex;
  align-items: center;
}

.suggestion-item-selected {
  background-color: var(--primary);
  color: var(--vt-c-text-light-1);
}

.popup-add-allergen {
  margin-top: 1rem;
  justify-content: center;
  align-items: center;
  border-top: solid var(--color-border) 1px;
  display: flex;
}

.popup-hidden {
  display: none;
}

.popup-visible {
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
  height: calc(100%);
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
  border: solid var(--color-border) 2px;
}

.allergen-item:hover {
  background-color: var(--primary);
  filter: brightness(115%);
  color: black;
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

.add-allergen-item:hover {
  background-color: var(--primary);
  filter: brightness(115%);
}

.add-allergen-item:hover > .allergen-label {
  color: var(--vt-c-text-light-1);
}

.allergen-item:hover .delete-icon {
  width: 100%;
}

.add-allergen-item:hover .allergen-label {
  width: 100%;
  display: flex;
}

.add-allergen-item > .allergen-label {
  width: 100%;
}

.label-noallergens {
  font-size: large;
}

.allergen-label-add {
  color: var(--vt-c-text-light-1);
}

*,
*::before,
*::after {
  box-sizing: border-box;
  margin: 0;
  position: relative;
  font-weight: normal;
}
</style>
