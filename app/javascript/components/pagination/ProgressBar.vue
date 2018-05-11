<template>
  <div class="progress-bar flex flex-column flex-v-center">
    <div class="progress-bar__tooltip" :class="'progress-bar__tooltip-' + page">
      <i class="progress-bar__tooltip-icon"></i>
      <span>You are {{ remainingPages }} away from finding out your results</span>
    </div>
    
    <span class="progress-bar__icon" :class="'progress-bar__icon-' + page"></span>
    <p class="progress-bar__page-numbers">
      <span class="bold">Page {{ page }}</span> <span class="italic">of</span> <span class="bold">{{ totalPages }}</span>
    </p>
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
        return this.$store.state.pagination.totalPages
      },

      remainingPages () {
        const remaining = this.totalPages - this.page
        const string = remaining == 1 ? 'page' : 'pages'

        return `${remaining} ${string}`
      }
    }
  }  
</script>
