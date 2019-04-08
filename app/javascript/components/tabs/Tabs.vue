<template>
  <div class="tabs">
    <ul class="tabs__triggers ul-inline ul-unstyled flex flex-h-between">
      <li v-for="child in children" @click="click(child)" class="tab__trigger" :class="{ 'tab--active' : child.isActive }">
        {{ child.title }}
      </li>
    </ul>
    <slot></slot>
  </div>
</template>

<script>
  export default {
    name: 'tabs',

    data () {
      return {
        children: []
      }
    },

    created () {
      this.children = this.$children
    },

    mounted () {
      this.openFirstTab()
    },

    methods: {
      click (selectedChild) {
        this.children.forEach(child => {
          child.isActive = child.id === selectedChild.id
        })
      },

      openFirstTab () {
        this.children.forEach((child, index) => {
          child.isActive = index === 0
        })
      }
    }
  }
</script>
