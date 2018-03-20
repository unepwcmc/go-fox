<template>
  <div v-show="isActive">
    <slot></slot>
  </div>
</template>

<script>
  export default {
    name: 'page-item',

    props: {
      'index': {
        required: true,
        type: Number
      }
    },

    computed: {
      isActive () {
        return this.$store.state.pagination.startIndex <= this.index && this.$store.state.pagination.endIndex > this.index
      }
    }
  }  
</script>
