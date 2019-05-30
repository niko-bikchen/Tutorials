<template>
  <div id="app">
    <product-list-one></product-list-one>
    <product-list-two></product-list-two>
  </div>
</template>

<script>
// We imagine that these two lists are situated in different parts of the program, thus we style them differently
import ProductListOne from "./components/ProductListOne";
import ProductListTwo from "./components/ProductListTwo";

// So far App root component hosts all the data used by our app
export default {
  components: {
    "product-list-one": ProductListOne,
    "product-list-two": ProductListTwo
  },
  data() {
    return {
      
    };
  }
};
</script>

<style>
body {
  font-family: sans-serif;
  color: #555;
}
</style>
