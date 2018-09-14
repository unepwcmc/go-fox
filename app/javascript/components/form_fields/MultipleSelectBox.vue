<template>
  <div>
    <p class="form__validation-message" v-show="errors">Please select at least one option below</p>

    <select :name="name + '[]'" multiple="multiple" v-model="inputMultiple" class="multiple-select">
      <option v-for="option in options" :value="option.text" class="multiple-select__option">{{ option.text }}</option>
    </select>
  </div>
</template>

<script>
  import { mixinValidate } from '../../mixins/mixin-validate.js'

  export default {
    name: 'multiple-select-box',

    mixins: [ mixinValidate ],

    props: {
      name: { required: true },
      options: { required: true },
      validate: {
        type: Boolean,
        required: true
      },
      validation_rules: {
        type: Object,
        required: true
      }
    },

    methods: {
      validateField () {
        if (this.validation_rules['required']) { this.validateRequiredMultiple() }
      }
    }
  }
</script>
