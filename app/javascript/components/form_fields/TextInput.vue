<template>
  <div>
    <p class="form__validation-message" v-show="errors">Please select enter an answer below</p>

    <input :name="name" type="text" v-model="input">
  </div>
</template>

<script>
  import { mixinValidate } from '../../mixins/mixin-validate.js'

  export default {
    name: 'text-input',

    mixins: [ mixinValidate ],

    props: {
      name: { required: true },
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
        if (this.validation_rules['required']) { this.validateRequired() }
      }
    }
  }
</script>
