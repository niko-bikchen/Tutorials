<template>
  <div>
    <button class="btn btn-primary" @click="increment(100)">Increment</button>
    <button class="btn btn-primary" @click="decrement">Decrement</button>
  </div>
</template>

<script>
// import { mapMutations } from "vuex";
import { mapActions } from "vuex";

export default {
  methods: {
    // increment() {
    //   // this.$emit('updated', 1);
    //   // Using mutations
    //   this.$store.commit("increment");
    // },
    // decrement() {
    //   // this.$emit('updated', -1);
    //   // Using mutations
    //   this.$store.commit("decrement");
    // }
    // Works like getters
    // Since on click methods have the same name as our
    // mutations everything will work
    // ...mapMutations([...])
    // ! mapActions will give us several functions like increment() below
    ...mapActions(["increment", "decrement"])
    // increment(by) {
    //   this.$store.dispatch("increment", by);
    // }
  }
};
</script>