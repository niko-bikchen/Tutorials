<template>
  <div id="product-list-two">
    <h2>Product List Two</h2>
    <ul>
      <li v-for="(product, index) in saleProducts" v-bind:key="index">
        <span class="name">{{ product.name }}</span>
        <span class="price">${{ product.price }}</span>
      </li>
    </ul>
  </div>
</template>

<script>
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
    // We leave the comp. prop. to use it ot access getter
    saleProducts() {
      //   var saleProducts = this.$store.state.products.map(product => {
      //     return {
      //       name: "**" + product.name + "**",
      //       price: product.price / 2
      //     };
      //   });
      //   return saleProducts;
      
      // Accessing the getter in the store
      return this.$store.getters.saleProducts
    }
  }
};
</script>

<style scoped>
#product-list-two {
  background: #d1e4ff;
  box-shadow: 1px 2px 3px rgba(0, 0, 0, 0.2);
  margin-bottom: 30px;
  padding: 10px 20px;
}
#product-list-two ul {
  padding: 0;
  list-style-type: none;
}
#product-list-two li {
  margin-right: 10px;
  margin-top: 10px;
  padding: 20px;
  background: rgba(255, 255, 255, 0.7);
}
.price {
  font-weight: bold;
  color: #860ce8;
  display: block;
}
</style>
