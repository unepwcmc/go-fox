<template>
  <div v-show="isActive">
    <slot name="formField" :validate="isActive"></slot>
  </div>
</template>

<script>
  import { eventHub } from '../../admin.js'

  export default {
    name: 'page-item',

    props: {
      index: { type: Number },
      type: { type: String }
    },

    computed: {
      isActive () {
        return this.$store.state.pagination.startIndex <= this.index && this.$store.state.pagination.endIndex > this.index
      }
    }
  }  
</script>
