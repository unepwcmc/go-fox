<template>
  <div class="page-overlay" v-show="isActive">>
    <div class="modal item-center item-center--fixed">
      <div class="survey-warning__content flex flex-column flex-v-center">
        <div class="logo--foc survey-warning__logo"></div>
        <h1 class="survey-warning__title">{{title}}</h1>
        <div class="survey-warning__container--scroll custom-scroll">
          <p class="survey-warning__description" v-html="description"></p>
          <button @click="closeModal" class="modal__button button--blue-light">{{ buttonText }}</button>
        </div>
      </div>
      <div class="modal__footer"></div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    buttonText: {
      type: String,
      default: 'Close'
    },
    title: String,
    description: String
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
