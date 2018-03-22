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
      total: { type: Number }
    },

    data () {
      return {
        itemsPerPage: 10
      }
    },

    created () {
      this.updateActiveIndicies()

      if (this.total != undefined && typeof this.total == 'number') {
        this.$store.commit('pagination/updateTotalPageItems', this.total)
        this.$store.commit('pagination/updateTotalPages', Math.ceil(this.total/this.itemsPerPage))
      }
        
    },

    computed: {
      isActive () {
        let page = this.$store.state.pagination.page
        let totalItems = this.$store.state.pagination.totalPageItems
        return (this.type === 'previous' && page > 1) || (this.type === 'next' && page < totalItems/this.itemsPerPage)
      }
    },

    methods: {
      changePage () {
        if (!this.isActive) return false

        let page = this.$store.state.pagination.page
        let totalItems = this.$store.state.pagination.totalPageItems

        if (this.type === 'previous' && page > 1) {
          page = page - 1

        } else if (this.type === 'next' && page < totalItems/this.itemsPerPage) {
          page = page + 1
        }

        if (this.type === 'next'){
          this.$store.commit('pagination/resetErrors')
          eventHub.$emit('validateIfActive')
          console.log(this.$store.state.pagination.errors)
          if (this.$store.state.pagination.errors == 0) { this.newPage(page) }

        } else {
          this.newPage(page)  
        }
      },

      newPage (page) {
        this.$store.commit('pagination/updatePage', page)

        this.updateActiveIndicies()
      },

      updateActiveIndicies () {
        let page = this.$store.state.pagination.page

        const startIndex = ((page - 1) * this.itemsPerPage)
        const endIndex = startIndex + this.itemsPerPage

        this.$store.commit('pagination/updateStartIndex', startIndex)
        this.$store.commit('pagination/updateEndIndex', endIndex)
      }
    }
  }
</script>
