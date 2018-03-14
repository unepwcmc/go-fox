<template>
  <div>
    <slot></slot>
  </div>
</template>

<script>
  import { eventHub } from '../../admin.js'

  export default {
    name: 'accordion',

    data () {
      return {
        children: this.$children
      }
    },

    mounted () {
      eventHub.$on('calltoggleAccordionContent', this.toggleAccordionContent)
    },

    methods: {
      toggleAccordionContent (id) {
        this.children.forEach(child => {
          child.isActive = child.id === id && child.isActive !== true
        })
      }
    }
  }
</script>
