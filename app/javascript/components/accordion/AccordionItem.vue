<template>
  <div class="accordion-item" :class="{ 'accordion-item--open' : isActive, 'accordion-item--close' : isClosed }">

    <a class="accordion-item__title flex flex-h-between" @click="toggleAccordionContent()">
      <span>{{ title }}</span>
      <i class="material-icons">{{ arrow }}</i>
    </a>

    <div class="accordion-item__content-wrapper">
      <div class="accordion-item__content">
        <slot></slot>
      </div>
    </div>

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
        isActive: this.open,
        isClosed: false
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
    from { max-height: 0; },
    to { max-height: 500px; }
  }

  @keyframes close {
    from { max-height: 500px; },
    to { max-height: 0; }
  }

  .accordion-item {
    &__title {
      cursor: pointer;
    }

    &__content-wrapper {
      overflow: hidden;
      height: auto;
      max-height: 0;

      .accordion-item--open & {
        animation: open .5s forwards ease-in;
      }

      .accordion-item--close & {
        animation: close .5s forwards ease-out;
      }
    }
  }
</style>
