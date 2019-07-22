<template>
  <div
    class="expandable-item relative"
    :class="{'expandable-item--active': isActive}"
  >
    <button
      aria-haspopup="true"
      :aria-expanded="isActive"
      :aria-controls="contentId"
      class="expandable-item__header hover--pointer flex flex-v-center"
      @click="toggle"
    >
      <slot name="header" />
      <span 
        class="drop-arrow drop-arrow--end arrow-svg"
        :style="arrowTransformStyle"
      />
    </button>
    <div
      v-show="isActive"
      :id="contentId"
      class="expandable-item__container item-padding"
    >
      <slot name="content" />
    </div>
  </div>
</template>


<script>
import mixinPopupCloseListeners from '../../mixins/mixin-popup-close-listeners'

export default {
  mixins: [mixinPopupCloseListeners({closeCallback: 'close'})],
  data () {
    return {
      isActive: false,
      contentId: `expandable-item-content-${this._uid}`
    }
  },

  computed: {
    arrowTransformStyle () {
      return {
        transform: this.isActive ? 'rotate(180deg)' : 'rotate(0deg)'
      }
    }
  },
  
  methods: {
    toggle () {
      this.isActive ? this.close() : this.open()
    },
    close () {
      this.isActive = false
    },
    open () {
      this.isActive = true
    }
  }
}
</script>
