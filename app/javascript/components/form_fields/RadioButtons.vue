<template>
  <div>
    <p class="form__validation-message" v-show="errors">Please select an option below</p>

    <div v-if="scale" class="radio-button--scale-wrapper" :class="{ 'form__validation-border': errors }">
      <input type="hidden" :name="name" :value="name">

      <div v-for="option in options" class="radio-button--scale">

        <input required type="radio" v-model="input" :value="option" :name="name" :id="id(option)" class="radio-button__input">
        <label :for="id(option)" :class="labelClass(option)" class="radio-button__label flex flex-column flex-h-center">{{ option }}</label>
        <i class="radio-button__tick"></i>
      </div>
    </div>
    
    <div v-else class="radio-button-wrapper flex-wrap">
      <p v-for="option in options" class="radio-button flex flex-1-half flex-v-center" @click="toggleRadio(option.text)">
        <input required type="radio" v-model="input" :value="option.text" :name="name" :id="id(option.text)">
        <label :for="id(option.text)" :class="labelClass(option.text)" class="radio-button__label">{{ option.text }}</label>
      </p>
    </div>
  </div>
</template>

<script>
  import { mixinValidate } from '../../mixins/mixin-validate.js'

  export default {
    name: 'radio-buttons',

    mixins: [ mixinValidate ],

    props: { 
      validate: { required: true },
      options: { required: true },
      name: { required: true },
      index: { required: true },
      scale: { type: Boolean }
    },

    methods: {
      friendly (string) {
        return string.toLowerCase().replace(' ', '-')
      },

      labelClass (string) {
        return 'radio-button__label-' + this.friendly(string)
      },

      id (string) {
        return this.friendly(string) + this.index
      },

      validateField () {
        this.validateRequired()
      },

      toggleRadio (text) {
        this.input = text
      }
    }
  }
</script>
