<template>
  <div>
    <button class="btn btn-primary" @click="increment">Increment</button>
    <button class="btn btn-primary" @click="decrement">Decrement</button>
  </div>
</template>

<script>
import { mapMutations } from "vuex";

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
    ...mapMutations(["increment", "decrement"])
  }
};
</script>