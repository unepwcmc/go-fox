<template>
  <div v-show="isActive">
    <slot></slot>
  </div>
</template>

<script>
  export default {
    name: 'page-item',

    props: {
      'index': { type: Number },
      'type': { type: String }
    },

    computed: {
      isActive () {
        let isActive

        if(this.type && this.type === 'submit') {
          isActive = this.$store.state.pagination.totalPages == this.$store.state.pagination.page

        } else {
          isActive = this.$store.state.pagination.startIndex <= this.index && this.$store.state.pagination.endIndex > this.index
        }

        return isActive
      }
    }
  }  
</script>
