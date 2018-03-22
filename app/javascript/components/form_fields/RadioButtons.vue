<template>
  <div>
    <p class="form__validation-message" v-show="errors">Please select an option below</p>

    <p v-if="showSmiles" class="flex" :class="{ 'form__validation-border': errors }">
      <input type="hidden" :name="name" :value="name">

      <span v-for="option in options" class="radio-button">

        <input required type="radio" v-model="selectedOption" :value="option" :name="name" :id="id(option)" class="radio-button__input">
        <label :for="id(option)" :class="labelClass(option)" class="radio-button__label flex flex-column flex-h-center">{{ option }}</label>
        <i class="radio-button__tick"></i>
      </span>
    </p>

    <p v-else v-for="option in options">
      <input required type="radio" v-model="selectedOption" :value="option.text" :name="name" :id="id(option.text)">
      <label :for="id(option.text)" :class="labelClass(option.text)">{{ option.text }}</label>
    </p>
  </div>
</template>

<script>
  import { eventHub } from '../../admin.js'

  export default {
    name: 'radio-buttons',

    props: {
      validate: { required: true },
      options: { required: true },
      name: { required: true },
      index: { required: true },
      scale: { type: Boolean }
    },

    data () {
      return {
        errors: false,
        selectedOption: null,
        showSmiles: false
      }
    },

    created () {
      eventHub.$on('validateIfActive', this.validateField)

      if (this.scale) { this.showSmiles = this.scale }
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
        if(this.validate){
          if(this.selectedOption ){
            this.errors = false
          } else {
            this.errors = true
            this.$store.commit('pagination/updateErrors')
          }
        }
      }
    }
  }
</script>
