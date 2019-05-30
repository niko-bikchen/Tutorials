<template>
  <div>
    <keep-alive>
      <component v-bind:is="component"></component>
    </keep-alive>
    <button v-on:click="component = 'form-one'" v-show="component == 'form-two'">Show form one</button>
    <button v-on:click="component = 'form-two'" v-show="component == 'form-one'">Show form two</button>
  </div>
</template>

<script>
// component allows us to dynamically render components on the page. When the new component is rendered, the old one is destroyed.
// If the old object is destroyed its date is destroyed as well
// keep alive - keeps the old component alive, so it won't be destroyed, thus saving its data. 

import formHelper from "./components/formHelper.vue";
import formOne from "./components/formOne.vue";
import formTwo from "./components/formTwo.vue";

export default {
  components: {
    "form-helper": formHelper,
    "form-one": formOne,
    "form-two": formTwo
  },
  data() {
    return {
      title: "I am a dynamic slot title",
      component: "form-one"
    };
  },
  methods: {
    handleSubmit() {
      console.log("Submitted");
    }
  }
};

// <form-helper>
//   <div slot="form-header">
//     <h3>This is a title of the form</h3>
//     <p>Form info</p>
//   </div>
//   <div slot="form-fields">
//     <input type="text" placeholder="Name" required>
//     <input type="password" placeholder="Password" required>
//   </div>
//   <div slot="form-controls">
//     <button v-on:click="handleSubmit">Submit</button>
//   </div>
// </form-helper>
</script>

<style>
</style>
