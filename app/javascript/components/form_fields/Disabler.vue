<template>
  <div class="disabler" :class="{'disabler--active': isDisabled}">
    <slot></slot>
  </div>
</template>

<script>
export default {
  props: {
    inputValue: {
      default: '',
      type: String
    },
    inputGroupName: {
      default: '',
      type: String
    }
  },

  data () {
    return {
      isDisabled: false
    }
  },

  mounted () {
    if(!this.inputValue || !this.inputGroupName) {
      this.isDisabled = true
    } else {
      const watchedInputs = document.querySelectorAll(`input[name="${this.inputGroupName}"]`)

      watchedInputs.forEach(input => {
        if(input.value === this.inputValue) {this.isDisabled = !input.checked}
        
        input.onchange = e => {
          this.isDisabled = e.target.value !== this.inputValue
        }
      })
    }
  }
}
</script>

