<template>
  <div class="col-xs-12 col-sm-6">
    <p v-if="!serverChosen">Server Details are currently not updated</p>
    <div v-else>
      <p>Chosen server number: {{ serverId }}</p>
      <p>Chosen server status: {{serverStatus}}</p>
      <button v-if="serverStatus == 'Not responding'" @click.once="restoreServer">Restore the server</button>
    </div>
  </div>
</template>

<script>
import { eventBus } from "./main";

export default {
  data() {
    return {
      serverChosen: false,
      serverId: 0,
      serverStatus: ""
    };
  },
  methods: {
    restoreServer() {
      this.serverStatus = "Normal";
      eventBus.$emit("serverRestored", {
        id: this.serverId,
        status: this.serverStatus
      });
    }
  },
  created() {
    eventBus.$on("serverChosen", data => {
      this.serverChosen = true;
      this.serverId = data.id;
      this.serverStatus = data.status;
    });
  }
};
</script>

<style>
</style>
