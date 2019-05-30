<template>
  <div id="product-list-one">
    <h2>Product List One</h2>
    <ul>
      <li v-for="(product, index) in saleProducts" v-bind:key="index">
        <span class="name">{{ product.name }}</span>
        <span class="price">${{ product.price }}</span>
      </li>
    </ul>
    <button v-on:click="reducePrice(4)">Reduce Price</button>
  </div>
</template>

<script>
import { mapActions, mapGetters } from "vuex";

export default {
  //   props: ["products"],
  data() {
    return {};
  },
  computed: {
    // Computed prop.
    products() {
      // This is how we reach out to the Store to get data from it.
      return this.$store.state.products;
    },
    // // Computed props. are used as getters or to get smt from the Store
    // // We leave the comp. prop. to use it to access getter
    // saleProducts() {
    //   //   var saleProducts = this.$store.state.products.map(product => {
    //   //     return {
    //   //       name: "**" + product.name + "**",
    //   //       price: product.price / 2
    //   //     };
    //   //   });
    //   //   return saleProducts;

    //   // Accessing the getter in the store
    //   return this.$store.getters.saleProducts;
    // }
    // MAPPING GETTERS TO THE COMPONENT
    ...mapGetters(["saleProducts"])
  },
  methods: {
    // // Directly editing Store state, which is NOT good
    // reducePrice(amount) {
    //   //   this.$store.state.products.forEach(product => {
    //   //     product.price -= 1;
    //   //   });

    //   // COMMITING A !MUTATION!
    //   // It's like to trigger a function
    //   // this.$store.commit('reducePrice');

    //   // Insted of directly commiting a mutation, we dispatch an action
    //   // so we could do smt before commiting a mutation
    //   // THIS IS SAID TO BE A GOOD PRACTICE

    //   this.$store.dispatch("reducePrice", amount); // <= passing a param to the action and/or mutation function
    // }
    // MAPPING ACTIONS TO THE COMPONENT
    ...mapActions(['reducePrice'])
  }
};
</script>

<style scoped>
#product-list-one {
  background: #fff8b1;
  box-shadow: 1px 2px 3px rgba(0, 0, 0, 0.2);
  margin-bottom: 30px;
  padding: 10px 20px;
}
#product-list-one ul {
  padding: 0;
}
#product-list-one li {
  display: inline-block;
  margin-right: 10px;
  margin-top: 10px;
  padding: 20px;
  background: rgba(255, 255, 255, 0.7);
}
.price {
  font-weight: bold;
  color: #e8800c;
}
</style>
