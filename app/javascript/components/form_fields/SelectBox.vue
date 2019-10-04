<template>
  <div>
    <p class="form__validation-message" v-show="errors">{{ validationMessage }}</p>

    <select :name="name" v-model="input" class="select">
      <option selected disabled>Choose a country</option>
      <option v-for="option in options" :value="option.name" class="select__option">{{ option.text }}</option>
    </select>
  </div>
</template>

<script>
  import { mixinValidate } from '../../mixins/mixin-validate.js'

  export default {
    name: 'select-box',

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
      },
      validationMessage: { 
        type: String,
        required: true
      }
    },

    methods: {
      validateField () {
        if (this.validation_rules['required']) { this.validateRequired() }
      }
    }
  }
</script>
