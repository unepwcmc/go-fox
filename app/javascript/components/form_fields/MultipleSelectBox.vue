<template>
  <div>
    <p class="form__validation-message" v-show="errors">{{ validationMessage }}</p>

    <v-multiselect :config="selectConfig" :options="selectOptions" :max-count="3"></v-multiselect>
  </div>
</template>

<script>
  import VMultiselect from './VMultiselect'
  import { mixinValidate } from '../../mixins/mixin-validate.js'

  export default {
    name: 'multiple-select-box',

    components: {VMultiselect},

    mixins: [ mixinValidate ],

    props: {
      name: { required: true },
      options: { required: true },
      validate: {
        type: Boolean,
        required: true
      },
      validation_rules: {
        type: Object,
        required: true
      },
      validationMessage: {
        type: String,
        required: true
      }
    },

    computed: {
      selectConfig () {
        return {
          id: this.makeIdSafe(this.name),
          name: this.name + '[]'
        }
      },

      selectOptions () {
        console.log(this.options)
        return this.options.map(option => ({
          name: option.name,
          text: option.text,
          id: this.makeIdSafe(option.name)
        }))
      }
    },

    methods: {
      validateField () {
        if (this.validation_rules['required']) { this.validateRequiredMultiple() }
      },

      makeIdSafe (str) {
        return str.replace(/[\[\]]/g, '-').toLowerCase()
      }
    }
  }
</script>
