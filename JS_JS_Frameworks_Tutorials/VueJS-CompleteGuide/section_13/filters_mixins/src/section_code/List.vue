<template>
  <div>
    <h1>List</h1>
    <input type="text" v-model="filterText" />
    <ul>
      <li v-for="fruit in filteredFruits" :key="fruit">{{ fruit }}</li>
    </ul>
  </div>
</template>

<script>
import { fruitMixin } from "./fruitMxin";

export default {
  mixins: [fruitMixin],
  created() {
      console.log("Created inside List");
  }
};
</script>

<style lang="scss">
</style>