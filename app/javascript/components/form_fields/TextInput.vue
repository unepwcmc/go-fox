<template>
  <div @click="test">
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
      name: { required: true }
    },

    data () {
      return {
        input: null,
        errors: false
      }
    },

    methods: {
      test() { this.validateRequired() }
    }
  }
</script>
