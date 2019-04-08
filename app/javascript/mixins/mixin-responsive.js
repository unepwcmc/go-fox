export const mixinResponsive = {
  data () {
    return {
      width: 0,
      breakpoints: {
        small: 720,
        medium: 960
      }
    }
  },

  created () {
    window.addEventListener('load', this.updateWindowSize);
    window.addEventListener('resize', this.updateWindowSize);
  },

  methods: {
    updateWindowSize () {
      this.width = window.innerWidth
    },

    isSmall () {
      return this.width <= this.breakpoints.small
    },

    isLarge () {
      return this.width > this.breakpoints.medium
    }
  }
}
