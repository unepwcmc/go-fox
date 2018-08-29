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
      name: { required: true }
      validate: {
        type: Array,
        required: true
      }
    },

    methods: {
      validateField () {
        this.validate.indexOf('required') { this.validateRequired() }
        this.validate.indexOf('integer') { this.validateInteger() }        
      }
    }
  }
</script>


