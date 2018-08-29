import { eventHub } from '../admin.js'

export const mixinValidate = {
  data () {
    return {
      errors: false,
      input: null,
      inputMultiple: []
    }
  },

  created () {
    eventHub.$on('validateIfActive', this.check)
  },

  methods: {
    check () {
      if(this.validate) { this.validateField() }
    },

    validateRequired () {
      this.input ? this.passedValidation() : this.failedValidation()
    },

    validateInteger () {
      //js to validate integer
    },

    validateRequiredMultiple () {
      this.inputMultiple.length > 0 ? this.passedValidation() : this.failedValidation()
    },

    passedValidation () {
      this.errors = false
    },

    failedValidation () {
      this.errors = true
      this.$store.commit('pagination/updateErrors')
    }
  }
}