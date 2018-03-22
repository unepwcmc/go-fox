import { eventHub } from '../admin.js'

export const mixinValidate = {
  data () {
    return {
      errors: false,
      input: null,
      checkedInput: []
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
      console.log('input', this.input)

      if(this.input){
        this.errors = false
        
      } else {
        this.errors = true
        this.$store.commit('pagination/updateErrors')

      }
    },

    validateRequiredChecked () {
      console.log('input', this.checkedInput)

      if(this.checkedInput.length > 0){
        this.errors = false
        
      } else {
        this.errors = true
        this.$store.commit('pagination/updateErrors')

      }
    }
  }
}