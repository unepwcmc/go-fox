<template>
  <div class="modal" :class="{ 'modal--active' : isActive }" :style="{ 'top' : topPosition }">

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

    data () {
      return {
        config: {
          smallBreakpoint: 720 // must match scss file
        },
        modalContent: {},
        top: 0,
        hero: true
      }
    },

    created () {
      eventHub.$on('openModal', this.openModal)

      eventHub.$on('getScrollY', this.getScrollY)
    },

    computed: {
      isActive () {
        return this.$store.state.modal.isActive
      },

      topPosition () {
        return this.top + 'px'
      },
    },

    methods: {
      toggleModal () {
        this.$store.commit('modal/updateModalStatus')
      },

      openModal ( hero = true ) {
        this.hero = hero

        // get the y position and open the modal and modal wrapper
        this.getScrollY()

        // update the modal with the latest event content
        if(!this.hero){ this.modalContent = this.$store.state.modal.modalContent }

        this.toggleModal()
      },

      closeModal () {
        this.toggleModal()
      },

      getScrollY () {
        // add top padding if being viewed on medium or large breakpoints
        this.top = window.innerWidth <= this.config.smallBreakpoint ? window.pageYOffset : window.pageYOffset + 40
      },

      hasContent (property) {
        return !!property
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
