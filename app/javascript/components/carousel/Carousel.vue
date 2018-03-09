<template>
  <div class="carousel">
    <h1>{{ title }}</h1><span class="carousel__steps">Step {{ currentStep }} of {{ totalSteps }}</span>

    <div class="slides">
      <slot></slot>
    </div>
  </div>
</template>

<script>
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

    mounted () {
      this.totalSteps = this.children.length
      this.addIndices()
    },

    methods: {
      addIndices () {
        this.children.forEach( (child, index) => {
          child.index = index
        })
      }
    }
  }
</script>

<style lang="scss">
  .carousel {
    // &__slides { width: 100%; }
  }
</style>
