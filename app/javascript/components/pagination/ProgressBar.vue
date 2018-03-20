<template>
  <div class="progress-bar">
    <span class="progress-bar__icon" :class="classes"></span>
    <span class="bold">Page {{ page }}</span> <span class="italic">of</span> <span class="bold">{{ totalPages }}</span>
  </div>
</template>

<script>
  export default {
    name: 'progress-bar',

    computed: {
      page () {
        return this.$store.state.pagination.page
      },

      totalPages () {
        return Math.ceil(this.$store.state.pagination.totalPages)
      },

      classes () {
        return 'progress-bar__icon-' + this.$store.state.pagination.page
      }
    }
  }  
</script>
