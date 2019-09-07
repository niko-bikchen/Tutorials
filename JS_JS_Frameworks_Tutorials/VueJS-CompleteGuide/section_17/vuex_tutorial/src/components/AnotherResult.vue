<template>
  <div>
    <p>Counter is: {{ doubleCounter }}</p>
    <p>Number of clicks: {{ stringCounter }}</p>
  </div>
</template>

<script>
// Helper to map getters to props
import { mapGetters } from "vuex";

export default {
  // props: ['counter']
  // computed: {
  //   counter() {
  //     // Using getters
  //     return this.$store.getters.doubleCounter;
  //   },
  //   clicks() {
  //     return this.$store.getters.stringCounter;
  //   }
  // }
  // You can also pass an object like {propertyName: 'doubleCounter'}
  // Will create computed properties of the same name and map them to the getters
  // Spread operator will pull out all the props and methods from mapGetters object
  // and create separate key - value pairs for each of them
  computed: {
    ...mapGetters(["doubleCounter", "stringCounter"])
  }
};
</script>