<template>
  <div>
    <p class="form__validation-message" v-show="errors">Please select at least one option below</p>
    
    <div class="flex flex-wrap">
      <p v-for="option in options" class="checkbox flex flex-1-half" @click.self="toggleCheckbox(option.text)">

        <input 
          :name="name + '[]'" 
          :value="option.text" 
          :id="id(option.text)" 
          v-model="inputMultiple" 
          type="checkbox" 
          :ref="option.text"
          @click>

        <label :for="id(option.text)" class="checkbox__label">{{ option.text }}</label>
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
      options: { required: true }
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