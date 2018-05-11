<template>
  <li class="nav__li">
    <a :href="href" class="nav__a flex flex-v-center flex-h-between" :class="{ 'nav--active' : currentPage }">
      <span>{{ text }}</span>
      <i class="material-icons nav__icon">chevron_right</i>
    </a>
  </li>
</template>

<script>
  export default {
    name: 'nav-link',

    props: {
      href: { required: true },
      text: { required: true },
      currentPage: { type: Boolean }
    }
  }  
</script>
