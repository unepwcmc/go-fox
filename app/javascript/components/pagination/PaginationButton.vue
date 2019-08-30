<template>
  <span class="button--blue-shadow" :class="{ 'button--disabled' : !isActive }" v-bind="{ 'disabled' : !isActive }" @click="changePage">
    <slot></slot>
  </span>
</template>

<script>
  import { eventHub } from '../../admin.js'

  export default {
    name: 'pagination-button',

    props: {
      type: { required: true },
      sectionTotals: { type: Array },
    },

    created () {
      if (this.sectionTotals != undefined && typeof this.sectionTotals[0] == 'number') {
        this.$store.dispatch('pagination/updateSectionItemTotals', this.sectionTotals)
      }
        
    },

    computed: {
      isActive () {
        const page = this.$store.state.pagination.page
        const totalPages = this.$store.state.pagination.totalPages

        return (this.type === 'previous' && page > 1) || (this.type === 'next' && page < totalPages)
      }
    },

    methods: {
      changePage () {
        if (!this.isActive) return false

        let page = this.$store.state.pagination.page
        const totalPages = this.$store.state.pagination.totalPages

        if (this.type === 'previous' && page > 1) {
          page = page - 1

        } else if (this.type === 'next' && page < totalPages) {
          page = page + 1
        }

        if (this.type === 'next'){
          this.$store.commit('pagination/resetErrors')
          
          eventHub.$emit('validateIfActive')
          
          // if (this.$store.state.pagination.errors == 0) { this.newPage(page) }
          this.newPage(page)

          window.scrollTo({ top: 0, behavior: 'smooth' })

        } else {
          this.newPage(page)  
        }
      },

      newPage (page) {
        this.$store.commit('pagination/updatePage', page)
        window.scrollTo({ top: 0, behavior: 'smooth' })
      }
    }
  }
</script>
