<template>
  <li class="list-group-item" @click="choseServer">
    <button class="btn bg-white">Server #{{ serverNumber }}. Status: {{ serverStatus }}</button>
  </li>
</template>

<script>
import { eventBus } from "./main";

export default {
  props: {
    serverNumber: {
      type: Number,
      required: true
    },
    serverStatus: {
      type: String,
      required: true
    }
  },
  methods: {
    choseServer() {
      eventBus.$emit("serverChosen", {
        id: this.serverNumber,
        status: this.serverStatus
      });
    }
  }
};
</script>

<style lang="scss">
</style>