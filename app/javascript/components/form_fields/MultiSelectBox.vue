<template>
  <div>
    <p class="form__validation-message" v-show="errors">Please select an option below</p>

    <select :name="name + '[]'" multiple="multiple" v-model="inputMultiple">
      <option v-for="option in options" :value="option.text">{{ option.text }}</option>
    </select>
  </div>
</template>

<script>
  import { mixinValidate } from '../../mixins/mixin-validate.js'

  export default {
    name: 'multi-select-box',

    mixins: [ mixinValidate ],

    props: {
      validate: { required: true },
      name: { required: true },
      options: { required: true },
    },

    methods: {
      validateField () {
        this.validateRequiredMultiple()
      }
    }
  }  
</script>
