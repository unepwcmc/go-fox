<template>
  <div class="v-select relative" :class="{'v-select--disabled': isDisabled}">
    <input type="hidden" :name="config.name" :id="config.id" v-model="selectedInternal" />

    <div v-if="config.label" class="v-select__label hover--pointer">
      <label :for="toggleId" class="v-select__selection">{{ config.label }}</label>
      <slot name="label-icon"></slot>
    </div>

    <button
      type="button"
      class="v-select__toggle"
      :class="{'v-select__toggle--active': isActive}"
      :id="toggleId"
      aria-haspopup="true"
      :aria-controls="dropdownId"
      :disabled="isDisabled"
      @click="toggleSelect">
      <span class="v-select__dropdown-text">{{ selectionMessage }}</span>
      <i class="drop-arrow arrow-svg"/>
    </button>

    <div v-show="isActive" :id="dropdownId" class="v-select__dropdown flex flex-column">
      <div class="page-overlay"></div>
      <ul 
        aria-multiselectable="true" 
        role="group" 
        class="v-select__options ul-unstyled">

        <li
          v-for="option in options"
          :class="['v-select__option', {'v-select--disabled': isOptionDisabled(option)}]"
          :key="option.id">
          <label :for="getOptionInputId(option)" class="no-margin flex">
            <input
              class="v-select__default-checkbox"
              type="checkbox"
              :id="getOptionInputId(option)"
              :data-mock-focus-id="getMockFocusId(option)"
              :name="dropdownOptionsName"
              :value="option.name"
              :disabled="isOptionDisabled(option)"
              v-model="selectedInternal">
            <span class="v-select__option-label">{{ option.text }}</span>
          </label>
        </li>

      </ul>
      <div class="v-select__dropdown-footer flex flex-v-center">
        <button type="button" class="v-select__dropdown-close" @click="closeSelect">OK</button>
      </div>
    </div>

  </div>
</template>

<script>
import mixinPopupCloseListeners from '../../mixins/mixin-popup-close-listeners'
import mixinFocusCapture from '../../mixins/mixin-focus-capture'

const UNDEFINED_ID = '__UNDEFINED__';
const UNDEFINED_OBJECT = { id: UNDEFINED_ID, name: 'None' }
const DEFAULT_MULTISELECT_MESSAGE = 'Select options'

export default {
  mixins: [
    mixinPopupCloseListeners({closeCallback: 'closeSelect'}),
    mixinFocusCapture({toggleVariable: 'isActive', closeCallback: 'closeSelect', openCallback: 'openSelect'})
  ],

  props: {
    config: {
      required: true,
      type: Object
    },
    options: {
      default: () => [],
      type: Array
    },
    selected: {
      default: () => [],
    },
    maxCount: Number
  },

  created () {
    this.initializeSelectedInternal()
  },

  watch: {
    selected (newSelectedOption) {
      this.selectedInternal = newSelectedOption
    },

    selectedInternal (newSelectedInternal) {
      this.$emit('update:selected-option', newSelectedInternal)
    }
  },

  data () {
    return {
      isActive: false,
      selectedInternal: [],
      dropdownId: 'v-select-dropdown-' + this.config.id,
      dropdownOptionsName: 'v-select-dropdown-input' + this.config.id,
      toggleId: 'v-select-toggle-' + this.config.id,

      mixinModalId: 'v-select-dropdown-' + this.config.id,
      mixinTriggerId: 'v-select-toggle-' + this.config.id,
    }
  },

  computed: {
    isDisabled () {
      return !this.options.length
    },

    selectionMessage () {
      return this.selectedInternal.length ? this.selectedInternal.join(', ') : DEFAULT_MULTISELECT_MESSAGE
    }
  },

  methods: {
    closeSelect () {
      this.isActive = false
    },

    openSelect () {
      this.isActive = true
    },

    toggleSelect (e) {
      if (this.options.length && !this.isActive) {
        this.openSelect(e)
      } else {
        this.closeSelect(e)
      }
    },

    initializeSelectedInternal () {
      if (this.selected === null) {
        this.selectedInternal =  []
      } else {
        this.selectedInternal = this.selected
      }
    },

    isOptionDisabled (option) {
      if (!this.maxCount) { return false }

      return this.selectedInternal.length >= this.maxCount && !this.isSelected(option)
    },

    isSelected (option) {
      return Boolean(this.selectedInternal.find(selectedOption => {
        return option.name === selectedOption
      }))
    },

    getOptionInputId (option) {
      return `option-${this.config.id}-${option.id}`
    },

    getMockFocusId (option) {
      return this.getOptionInputId(option) + '-mock-focus'
    },

    getMockInputClasses (option) {
      const inputClass = 'v-select__checkbox'

      return {
        [inputClass]: true,
        [`${inputClass}--active`]: this.isSelected(option)
      }
    }
  }
}
</script>