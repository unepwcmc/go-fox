<template>
  <div>
    <select :name="name">
      <option value="">Choose a country</option>
      <option v-for="option in options" :value="option.text">{{ option.text }}</option>
    </select>
  </div>
</template>

<script>
  export default {
    name: 'select-box',

    props: {
      name: { required: true },
      options: { required: true },
    }
  }  
</script>
