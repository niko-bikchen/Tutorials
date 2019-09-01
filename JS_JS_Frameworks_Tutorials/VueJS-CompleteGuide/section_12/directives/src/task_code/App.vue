<template>
  <div class="container">
    <div class="row">
      <div class="col-xs-12 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3">
        <h1>Directives Exercise</h1>
        <br />
        <!-- Exercise -->
        <!-- Build a Custom Directive which works like v-on (Listen for Events) -->
        <button v-my-on:click="clicked" class="btn btn-primary">Click me!</button>
        <div
          v-my-on:mouseenter="entered"
          v-my-on:mouseleave="left"
          style="width: 100px; height: 100px; background-color: lightgreen;"
        ></div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  directives: {
    myOn: {
      bind(el, binding) {
        // el.onclick = function() {
        //   binding.value();
        // };
        const type = binding.arg;
        const fn = binding.value;
        el.addEventListener(type, fn);
      }
    }
  },
  methods: {
    clicked() {
      alert("I'm alive!");
    },
    entered() {
      console.log("Mouse entered");
    },
    left() {
      console.log("Mouse left");
    }
  }
};
</script>

<style scoped>
span {
  padding: 10px;
  cursor: pointer;
  border: 1px solid blue;
  border-radius: 5px;
}
</style>
