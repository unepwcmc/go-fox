<template>
  <input :name="name" type="text" v-model="input">
</template>

<script>
  export default { 
    name: 'text-input',

    props: {
      name: { required: true }
    },

    data () {
      return {
        input: null
      }
    }
  }
</script>
