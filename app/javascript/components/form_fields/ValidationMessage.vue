<template>
  <div class="validation-message" v-show="errors">{{ message }}</div>
</template>

<script>
  export default {
    name: 'validation-message',

    props: {
      message: { required: String }
    },

    computed: {
      errors () {
        return this.$store.state.pagination.errors > 0
      }
    }
  }
</script>
