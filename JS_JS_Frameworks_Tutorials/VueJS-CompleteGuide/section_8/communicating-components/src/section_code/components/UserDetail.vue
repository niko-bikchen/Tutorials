<template>
  <div class="component">
    <h3>You may view the User Details here</h3>
    <p>Many Details</p>
    <p>User name: {{ myName }}</p>
    <p>User age: {{ userAge }}</p>
    <p>Strange user name: {{ reversedName }}</p>
    <button @click="resetFunction">Reset the name</button>
  </div>
</template>

<script>
import { eventBus } from "../main";

export default {
  // Here we specify all the properties which this component receives from the outside
  // They can be used as the normal props in the data obj
  // props: ["myName"],
  // Setting up props validation (we can specify multiple props in an array)
  props: {
    // myName: String // [String, Array]
    // ! If type is not primitive, like array or object, default must be a function which returns default value
    myName: {
      type: String,
      // required: true, // If true this prop MUST be passed
      default: "Username" // Default value. Doesn't make sense to have with required
    },
    resetFunction: Function,
    userAge: Number
  },
  computed: {
    reversedName() {
      return this.myName
        .split("")
        .reverse()
        .join("");
    }
  },
  methods: {
    resetName() {
      // this.myName = "Nick";
      // $emit() method build in in a Vue instance.
      // ! Component or Single File Template extends Vue instance so they are kinda like Vue instances
      this.$emit("nameWasReset", "Nick");
    }
  },
  created() {
    eventBus.$on("ageWasEdited", age => {
      this.userAge = age;
    });
  }
};
</script>

<style scoped>
div {
  background-color: lightcoral;
}
</style>
