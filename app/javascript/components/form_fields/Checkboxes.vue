<template>
  <div>
    <p class="form__validation-message" v-show="errors">Please select an option below</p>
    
    <p v-for="option in options">
      <input :name="name + '[]'" value="option.text" type="checkbox">
      <label :for="name + '[]'" class="">{{ option.text }}</label>
    </p>
  </div>
</template>

<script>
  export default {
    name: 'checkboxes',

    props: {
      name: { required: true },
      options: { required: true }
    },

    data() {
      return {
        errors: false
      }
    }
  }
</script>