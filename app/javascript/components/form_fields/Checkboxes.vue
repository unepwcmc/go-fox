<template>
  <div>
    <p class="form__validation-message" v-show="errors">Please select an option below</p>

    <p v-for="option in options">
      <input :name="name + '[]'" value="option.text" :id="id(option.text)" type="checkbox" v-model="input">
      <label :for="id(option.text)" class="">{{ option.text }}</label>
    </p>
  </div>
</template>

<script>
  import { mixinValidate } from '../../mixins/mixin-validate.js'

  export default {
    name: 'checkboxes',

    mixins: [ mixinValidate ],

    props: {
      validate: { required: true },
      name: { required: true },
      options: { required: true }
    },

    methods: {
      id (string) {
        return string.toLowerCase().replace(' ', '-') + this.index
      },

      validateField () {
        this.validateRequired()
      }
    }
  }
</script>