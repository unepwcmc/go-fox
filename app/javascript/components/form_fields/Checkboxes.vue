<template>
  <div>
    <p class="form__validation-message" v-show="errors">{{ validationMessage }}</p>
    
    <div class="flex-m-t-stack flex-wrap">
      <p v-for="option in options" class="checkbox flex flex-1-half flex-v-center" @click.self="toggleCheckbox(option.name)">

        <input 
          :name="name + '[]'" 
          :value="option.name" 
          :id="id(option.name)" 
          v-model="inputMultiple" 
          type="checkbox" 
          :ref="option.name"
          @click>

        <label :for="id(option.name)" class="checkbox__label">{{ option.text }}</label>
      </p>
    </div>
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
      index: { required: true },
      options: { required: true },
      validationMessage: { required: true }
    },

    methods: {
      id (string) {
        return string.toLowerCase().replace(' ', '-') + this.index
      },

      validateField () {
        this.validateRequiredMultiple()
      },

      toggleCheckbox (option) {
        this.$refs[option][0].click()
      }
    }
  }
</script>