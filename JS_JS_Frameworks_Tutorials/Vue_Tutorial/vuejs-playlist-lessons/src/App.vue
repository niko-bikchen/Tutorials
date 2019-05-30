<template>
  <div>
    <h1>{{ title }}</h1>
    <ninjas></ninjas>
  </div>
</template>

<script>
// In the template can exist only one high level element which will contain the other
import Ninjas from './Ninjas.vue' // To register Ninjas component locally. Can be used ONLY here

export default {
  components: {
    'ninjas': Ninjas
  },
  data() {
    return {
      title: "Ninja App"
    };
  }
};
</script>

<style scoped>
h1 {
  color: green;
}
</style>
