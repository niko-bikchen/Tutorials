<template>
  <div class="container">
    <div class="row">
      <div class="col-xs-12 col-sm-8 offset-sm-2 col-md-6 offset-md-3">
        <h1>Filters & Mixins</h1>
        <p>{{ text | toUppercase | toLowercase}}</p>
        <hr />
        <button @click="fruits.push('Pineapple')">Add new item</button>
        <input type="text" v-model="filterText" />
        <ul>
          <li v-for="fruit in filteredFruits" :key="fruit">{{ fruit }}</li>
        </ul>
        <app-list></app-list>
      </div>
    </div>
  </div>
</template>

<script>
import List from "./List";
import { fruitMixin } from "./fruitMxin";

export default {
  // Mixins are merged with Vue instance
  mixins: [fruitMixin],
  data() {
    return {
      text: "Hello there!",
      // fruits: ["Apple", "Banana", "Mango", "Melon"],
      // filterText: ""
    };
  },
  filters: {
    // Filter is a function which receives data that we want to transform
    // ! Filter doesn't chage the data prop itself but only how this value is displayed
    // ! Filtets are run upon each DOM re-render so you might consider using computed props
    toUppercase(value) {
      // Here we return the transformed value
      return value.toUpperCase();
    }
  },
  // computed: {
  //   filteredFruits() {
  //     return this.fruits.filter(element => {
  //       return element.match(this.filterText);
  //     });
  //   }
  // },
  components: {
    appList: List
  }
};
</script>

<style lang="scss">
</style>