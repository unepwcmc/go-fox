<template>
  <div>
    <p class="form__validation-message" v-show="errors">Please select an option below</p>

    <input :name="name" type="text" v-model="input">
  </div>
</template>

<script>
  import { mixinValidate } from '../../mixins/mixin-validate.js'

  export default { 
    name: 'text-input',

    mixins: [ mixinValidate ],

    props: {
      validate: { required: true },
      name: { required: true }
    },

    methods: {
      validateField () {
        this.validateRequired()
      }
    }
  }
</script>
