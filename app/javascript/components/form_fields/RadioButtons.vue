<template>
  <div>
    <p class="form__validation-message" v-show="errors">Please select an option below</p>

    <p class="flex" :class="{ 'form__validation-border': errors }">
      <input type="hidden" :name="name" :value="name">

      <span v-for="option in options" class="radio-button">

        <input required type="radio" v-model="selectedOption" :value="option" :name="name" :id="id(option)" class="radio-button__input">
        <label :for="id(option)" :class="labelClass(option, '-')" class="radio-button__label flex flex-column flex-h-center">{{ option }}</label>
        <i class="radio-button__tick"></i>
      </span>
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
      attribute: { required: true },
      model: { required: true },
      index: { required: true }
    },

    data () {
      return {
        errors: false,
        selectedOption: null
      }
    },

    created () {
      eventHub.$on('validateIfActive', this.validateField)
    },

    computed: {
      name () {
        return this.model + '[' + this.attribute + '][' + this.index + '][raw]'
      }
    },

    methods: {
      labelClass (string, separator) {
        return 'radio-button__label-' + this.text(string, separator)
      },

      id (string) {
        return 'response_answers_attributes_' + this.index + '_raw_' + this.text(string, '_')
      },

      text (string, separator) {
        return string.toLowerCase().replace(' ', separator)
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
