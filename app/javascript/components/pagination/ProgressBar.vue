<template>
  <div class="progress-bar flex flex-column flex-v-center">
    <div class="progress-bar__tooltip" :class="'progress-bar__tooltip-' + page">
      <i class="progress-bar__tooltip-icon"></i>
      <span>{{ tooltipMessage }}</span>
    </div>

    <span class="progress-bar__icon" :class="'progress-bar__icon-' + page"></span>
    <p class="progress-bar__page-numbers">
      <span class="bold">{{ translations.page }} {{ page }}</span> 
      <span class="italic">{{ translations.of.toLowerCase() }}</span>
      <span class="bold">{{ totalPages }}</span>
    </p>
  </div>
</template>

<script>
  export default {
    name: 'progress-bar',

    props: {
      translations: {
        type: Object,
        required: true
      }
    },

    computed: {
      page () {
        return this.$store.state.pagination.page
      },

      totalPages () {
        return this.$store.state.pagination.totalPages
      },

      tooltipMessage() {
        return this.translations.tooltip.replace('${count}', this.remainingPages)
      },

      remainingPages () {
        const remaining = this.totalPages - this.page
        const string = remaining == 1 ? 'page' : 'pages'

        return `${remaining} ${string}`
      }
    }
  }
</script>
