<template>
  <div class="page-overlay" v-show="isActive">>
    <div class="modal item-center item-center--fixed">
      <slot></slot>
      <div class="modal__footer flex-center">
        <button @click="closeModal" class="modal__button button--blue-light">{{ buttonText }}</button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    buttonText: {
      type: String,
      default: 'Close'
    }
  },

  data () {
    return {
      isActive: true
    }
  },

  methods: {
    closeModal () {
      this.isActive = false
    }
  }
}
</script>
