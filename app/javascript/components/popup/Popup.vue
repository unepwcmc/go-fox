<template>
  <div class="popup">
    <button class="button--share" @click="togglePopup"><i class="material-icons">{{ icon }}</i>{{ title }}</button>

    <div class="popup__box flex-column" :class="{ 'popup--active' : isActive }">
      <input class="js-copy popup__input" type="text" :value="url" readonly="readonly"></input>
      <button class="popup__button button--copy flex-vs-center" :class="{ 'button--copied' : hasCopied }" @click="copy">{{ copyButton }}</button>
    </div>
    <div class="popup-wrapper" :class="{ 'popup--active' : isActive }" @click="closePopup"></div>
  </div>  
</template>

<script>
  export default {
    name: 'popup',

    props: {
      title: String,
      icon: String,
      url: String
    },

    data () {
      return {
        isActive: false,
        hasCopied: false
      }
    },

    computed: {
      copyButton () {
        return this.hasCopied ? 'Copied!' : 'Copy'
      }
    },

    methods: {
      togglePopup () {
        this.isActive = !this.isActive
      },

      closePopup () {
        this.isActive = false
        this.hasCopied = false
      },

      copy () {
        let input = this.$el.querySelector('.js-copy')

        input.select()
        
        let copy = document.execCommand('copy')

        if(copy){
          this.hasCopied = true
        }
      }
    }
  }
</script>

<style lang="scss">
  .popup-wrapper {
    display: none;
    position: fixed;
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;

    &--active { display: block; }
  }

  .popup {
    position: relative;

    &__box {
      display: none;
      position: absolute;
      left: 50%;
      top: 100%;

      transform: translateX(-50%);
    }

    &--active { display: flex; }
  }
</style>
