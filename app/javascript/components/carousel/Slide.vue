<template>
  <div class="carousel__slide content-small" :class="{ 'carousel__slide--hide' : !show, 'carousel__slide--show' : show }">
    <slot></slot>

    <span v-if="notLast" class="button--blue-shadow button--icon-chevron flex-inline flex-v-center" @click="nextStep">Next <i class="material-icons">chevron_right</i></span>
  </div>
</template>

<script>
  import { eventHub } from '../../admin.js'

  export default {
    name: 'slide',

    props: {
      first: Boolean,
      last: Boolean
    },

    data () {
      return {
        show: Boolean(this.first)
      }
    },

    computed: {
      notLast () {
        return !this.last
      }
    },

    methods: {
      nextStep () {
        eventHub.$emit('nextStep', this.index)
      }
    }
  }
</script>
