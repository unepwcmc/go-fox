<template>
  <button class="button--beige-dark" @click="openModal"><slot></slot></button>
</template>

<script>
  export default {
    name: 'modal-trigger',

    methods: {
      openModal () {
        this.$store.commit('modal/updateModalStatus')
      }
    }
  }
</script>