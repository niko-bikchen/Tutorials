<template>
  <div>
    <h3>New quote</h3>
    <p>{{ counter }}</p>
    <button @click="counter++">Increase!</button>
  </div>
</template>

<script>
export default {
  data() {
    return {
      counter: 0
    };
  },
  destroyed() {
    console.log("New Destroyed");
  },
  deactivated() {
      console.log("Deactivated");   
  },
  activated() {
      console.log("Activated");
  }
};
</script>

<style lang="scss" scoped>
</style>