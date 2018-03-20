<template>
  <span class="button--blue-shadow" @click="changePage">
    <slot></slot>
  </span>
</template>

<script>
  export default {
    name: 'pagination-button',

    data () {
      return {
        'page': 1,
        'itemsPerPage': 6
      }
    },

    mounted () {
      this.updateActiveIndicies()
    },

    methods: {
      changePage () {
        this.page = this.page + 1

        this.updateActiveIndicies()
      },

      updateActiveIndicies () {
        let startIndex = ((this.page - 1) * this.itemsPerPage) + 1
        let endIndex = startIndex + this.itemsPerPage

        this.$store.commit('pagination/updateStartIndex', startIndex)
        this.$store.commit('pagination/updateEndIndex', endIndex)
      }
    }
  }
</script>
