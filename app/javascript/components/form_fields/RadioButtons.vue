<template>
  <div>
    <p class="flex">
      <input type="hidden" :name="name" value="">

      <span v-for="option in options" class="radio-button">
        <input required type="radio" :value="option" :name="name" :id="id(option)" class="radio-button__input">
        <label :for="id(option)" :class="labelClass(option, '-')" class="radio-button__label flex flex-column flex-h-center">{{ option }}</label>
        <i class="radio-button__tick"></i>
      </span>
    </p>
  </div>
</template>

<script>
  export default {
    name: 'radio-buttons',

    props: {
      options: { required: true },
      attribute: { required: true },
      model: { required: true },
      index: { required: true }
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
      }
    }
  }
</script>
