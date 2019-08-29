<template>
  <div>
    <p class="form__validation-message" v-show="errors">{{ validationMessage }}</p>

    <div v-if="scale" class="flex-m-t-stack" :class="{ 'form__validation-border': errors }">
      <input type="hidden" :name="name" :value="name">

      <div v-for="option in options" class="radio-button--scale">

        <input required type="radio" v-model="input" :value="option.name" :name="name" :id="id(option.name)" class="radio-button__input">
        <label :for="id(option.name)" :class="labelClass(option.text)" class="radio-button__label flex flex-column flex-h-center">{{ option.text }}</label>
        <i class="radio-button__tick"></i>
      </div>
    </div>
    
    <div v-else class="flex-m-t-stack flex-wrap">
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
      scale: { type: Boolean },
      validationMessage: { type: String }
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
