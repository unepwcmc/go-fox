<template>
  <div class="carousel">
    <h1>{{ title }}</h1><span class="carousel__steps">Step {{ currentStep }} of {{ totalSteps }}</span>

    <div v-cloak class="slides">
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
      this.addInvalidEmailEventHandler()
    },

    methods: {
      addIndices () {
        this.children.forEach( (child, index) => {
          child.index = index
        })
      },

      updateChildVisibility () {
        this.children.forEach(child => {
          child.show = child.index + 1 === this.currentStep
        })
      },

      changeStep (index) {
        this.currentStep = index
        this.updateChildVisibility()
      },

      nextStep () {
        this.changeStep(this.currentStep + 1)
      },

      addInvalidEmailEventHandler () {
        this.$el
        .querySelector("#user_email")
        .addEventListener("invalid", event => {this.changeStep(1)})
      }
    }
  }
</script>

<style lang="scss">
  .carousel {
    // &__slides { width: 100%; }
  }
</style>
