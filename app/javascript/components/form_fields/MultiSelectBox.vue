<template>
  <div>
    <select :name="name + '[]'" multiple="multiple">
      <option v-for="option in options" :value="option.text">{{ option.text }}</option>
    </select>
  </div>
</template>

<script>
  export default {
    name: 'multi-select-box',

    props: {
      name: { required: true },
      options: { required: true },
    }
  }  
</script>
