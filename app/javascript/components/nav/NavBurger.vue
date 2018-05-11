<template>
  <div class="nav--burger">
    <button class="button--plain nav__burger" @click="toggleNavPane"><i class="material-icons nav__burger-icon">{{ icon }}</i></button>

    <ul v-show="isActive" class="nav__pane ul-unstyled">
      <slot></slot>
    </ul>
  </div>
</template>

<script>
  import { mixinResponsive } from '../../mixins/mixin-responsive.js'

  export default {
    name: 'nav-burger',

    mixins: [ mixinResponsive ],

    data () {
      return {
        isActive: false
      }
    },

    created () {
      if (this.isLarge) { this.isActive = true }
    },

    computed: {
      icon () {
        return this.isActive ? 'close' : 'menu'
      }
    },

    watch: {
      width () {
        if (this.isLarge()) { 
          this.isActive = true
        } else {
          // make sure the burger nav is closed if moving from large to medium/small
          if(this.isActive) { this.isActive = false }
        }
      }
    },

    methods: {
      toggleNavPane () {
        this.isActive = !this.isActive
      }
    }
  }  
</script>
