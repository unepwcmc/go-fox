<template>
  <div class="accordion-item">
    <a class="accordion-item__title flex flex-h-between" @click="toggleAccordionContent()">
      <p>{{ title }}</p>
      <i class="material-icons">{{ arrow }}</i>
    </a>
    
    <transition name="accordion-toggle">
      <div v-show="isActive" class="accordion-item__content-wrapper">
        <div class="accordion-item__content">
          <slot></slot>
        </div>
      </div>
    </transition>
  </div>  
</template>

<script>
  import { eventHub } from '../../admin.js'

  export default {
    name: 'accordion-item',

    props: {
      id: {
        required: true,
        type: String
      },
      title: String,
      open: Boolean
    },

    data () {
      return {
        isActive: this.open
      }
    },

    computed: {
      arrow () {
        return this.isActive ? 'arrow_downward' : 'arrow_forward'
      }
    },

    methods: {
      toggleAccordionContent () {
        eventHub.$emit('calltoggleAccordionContent', this.id);
      }
    }
  }
</script>

<style lang="scss">
  @keyframes open {
    from { max-height: 0; }
    to { max-height: 500px; }
  }

  @keyframes close {
    from { max-height: 500px; }
    to { max-height: 0; }
  }

  .accordion-toggle-enter-active {
    animation: open .4s forwards ease-in;
  }

  .accordion-toggle-leave-active {
    animation: close .4s forwards ease-out;
  }

  .accordion-item {
    &__title {
      cursor: pointer;
    }

    &__content-wrapper {
      overflow: hidden;
      height: auto;
    }
  }
</style>
