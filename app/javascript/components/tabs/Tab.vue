<template>
  <div v-show="isActive" class="tab">
    <slot></slot>
  </div>
</template>

<script>
  export default {
    name: 'tab',

    props: {
      title: { 
        required: true,
        type: String 
      },
      active: { type: Boolean }
    },

    data () {
      return {
        isActive: false
      }
    },

    created () {
      if (this.active) { this.isActive = this.active }

      this.id = 'tab' + this.removeWhiteSpaces(this.title)
    }, 

    methods: {
      removeWhiteSpaces (string) {
        const regex = new RegExp(/\s/g)

        return string.replace(regex, g => { return '' })
      }
    }
  }
</script>

<style lang="scss">
  .tab {

    &__trigger {
      cursor: pointer;
    }
  }  
</style>
