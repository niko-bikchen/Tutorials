<template>
  <div>
    <app-server-status v-for="(server, index) in 5" :key="index"></app-server-status>
  </div>
</template>

<script>
import ServerStatus from "./ServerStatus.vue";

export default {
    // Registering component locally
  components: {
    "app-server-status": ServerStatus
  }
};
</script>