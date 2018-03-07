<template>
  <div class="modal" :class="{ 'modal--active' : isActive }">

    <div class="modal__content">
      <button class="button--plain modal__close" @click="closeModal">
        <i class="material-icons">close</i>
      </button>

      <slot></slot>
    </div>
  </div>
</template>

<script>
  import { eventHub } from '../../admin.js'

  export default {
    name: 'modal',

    created () {
      eventHub.$on('openModal', this.openModal)
    },

    computed: {
      isActive () {
        return this.$store.state.modal.isActive
      }
    },

    methods: {
      toggleModal () {
        this.$store.commit('modal/updateModalStatus')
      },

      closeModal () {
        this.toggleModal()
      }
    }
  }
</script>

<style lang="scss">
  .modal {
    display: none;
    position: absolute;
    top: 0;
    right: 50%;
    z-index: 6;

    &--active { display: block; }
  }
</style>
