export const mixinValidate = {
  methods: {
    validateRequired () {
      console.log('hello from mixin!')

      if(this.input ){
        console.log('passed')
        this.errors = false
        
      } else {
        console.log('failed')
        this.errors = true
        this.$store.commit('pagination/updateErrors')

      }
    }
  }
}