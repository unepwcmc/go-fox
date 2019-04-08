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
        const pageIndex = this.$store.state.pagination.page - 1
        const pageItemIndices = this.$store.state.pagination.pageIndices[pageIndex]

        if (!pageItemIndices) { return false }
        return pageItemIndices.start <= this.index && pageItemIndices.end >= this.index
      }
    }
  }  
</script>
