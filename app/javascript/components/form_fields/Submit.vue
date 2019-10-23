<template>
  <input @click.prevent="validate" v-show="lastPage" type="submit" :value="buttonText" class="button--blue-shadow">
</template>

<script>
  import { eventHub } from '../../admin.js'

  export default {
    name: 'submit',

    props: {
      id: { required: true },
      buttonText: {type: String, required: true}
    },

    computed: {
      lastPage () {
        return this.$store.state.pagination.totalPages == this.$store.state.pagination.page
      }
    },

    methods: {
      validate () {
        this.$store.commit('pagination/resetErrors')
          
        eventHub.$emit('validateIfActive')
          
        if (this.$store.state.pagination.errors == 0) { document.getElementById(this.id).submit() }
      }
    } 
  }
</script>
