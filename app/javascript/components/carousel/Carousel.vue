<template>
  <div class="carousel">
    <h1>{{ title }}</h1><span class="carousel__steps">Step {{ currentStep }} of {{ totalSteps }}</span>

    <div class="slides">
      <slot></slot>
    </div>
  </div>
</template>

<script>
  import { eventHub } from '../../admin.js'
  export default {
    name: 'carousel',

    props: {
      title: String
    },

    data () {
      return {
        currentStep: 1,
        totalSteps: 0,
        children: this.$children
      }
    },

    created () {
      eventHub.$on('nextStep', this.nextStep)
    },

    mounted () {
      this.totalSteps = this.children.length
      this.addIndices()
    },

    methods: {
      addIndices () {
        this.children.forEach( (child, index) => {
          child.index = index
        })
      },

      nextStep (currentIndex) {
        let nextIndex = currentIndex + 1

        this.children.forEach(child => {
          child.show = child.index === nextIndex
        })

        this.currentStep++
      }
    }
  }
</script>

<style lang="scss">
  .carousel {
    // &__slides { width: 100%; }
  }
</style>
