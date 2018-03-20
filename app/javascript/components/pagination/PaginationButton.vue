<template>
  <span class="button--blue-shadow" :class="{ 'button--disabled' : !isActive }" v-bind="{ 'disabled' : !isActive }" @click="changePage">
    <slot></slot>
  </span>
</template>

<script>
  export default {
    name: 'pagination-button',

    props: {
      'type': { required: true },
      'total': { type: Number }
    },

    data () {
      return {
        'itemsPerPage': 10
      }
    },

    created () {
      this.updateActiveIndicies()

      if (this.total != undefined && typeof this.total == 'number') {
        this.$store.commit('pagination/updateTotalPageItems', this.total)
        this.$store.commit('pagination/updateTotalPages', this.total/this.itemsPerPage)
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

        console.log(totalItems)

        if (this.type === 'previous' && page > 1) {
          page = page - 1

        } else if (this.type === 'next' && page < totalItems/this.itemsPerPage) {
          console.log(page)
          console.log(totalItems/this.itemsPerPage)
          page = page + 1
        }



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
