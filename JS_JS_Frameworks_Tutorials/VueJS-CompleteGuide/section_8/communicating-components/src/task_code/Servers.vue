<template>
  <div class="col-xs-12 col-sm-6">
    <ul class="list-group">
      <server
        v-for="item in servers"
        :key="item.id"
        :serverNumber="item.id"
        :serverStatus="item.status"
      ></server>
    </ul>
  </div>
</template>

<script>
import Server from "./Server.vue";
import { eventBus } from "./main";

export default {
  data() {
    return {
      servers: [
        {
          id: 1,
          status: "Not responding"
        },
        {
          id: 2,
          status: "Not responding"
        },
        {
          id: 3,
          status: "Normal"
        },
        {
          id: 4,
          status: "Normal"
        },
        {
          id: 5,
          status: "Not responding"
        }
      ]
    };
  },
  components: {
    server: Server
  },
  created() {
    eventBus.$on("serverRestored", data => {
      this.servers[data.id - 1].status = data.status;
    });
  }
};
</script>

<style>
</style>
