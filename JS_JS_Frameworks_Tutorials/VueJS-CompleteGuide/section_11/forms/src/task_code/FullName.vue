<template>
  <div>
    <p>Full Name:</p>
    <input type="text" @blur="typed(1, $event)" placeholder="First name" />
    <input type="text" @blur="typed(2, $event)" placeholder="Last name" />
  </div>
</template>

<script>
export default {
  props: ["fullName"],
  data() {
    return {
      name: ""
    };
  },
  methods: {
    typed(id, event) {
      if ((id == 1 && this.name == "") || (id == 2 && this.name == "")) {
        this.name = event.target.value + " ";
      } else if ((id == 1 && this.name != "") || (id == 2 && this.name != "")) {
        this.$emit("input", this.name + event.target.value);
      }
    }
  }
};
</script>

<style scoped>
</style>