<template>
  <div>
    <div class="online-status">
      <div class="online" v-if="online">
        <span class="light">
          <p>
            A staff member is
            <b>online</b> and
            <b>available</b>
          </p>
        </span>
      </div>
      <div class="offline" v-if="!online">
        <span class="light">
          <p>
            A staff member is
            <b>offline</b> and
            <b>unavailable</b>
          </p>
        </span>
      </div>
    </div>
    <button v-on:click="online = !online">Toggle Status</button>
  </div>
</template>

<script>
export default {
  data() {
    return {
      online: true
    };
  }
};
</script>

<style scoped>
.online-status {
  background: #eee;
  border: 1px dashed #ddd;
  display: inline-block;
  padding: 10px;
}

p {
  display: inline-block;
  margin: 0;
  color: #555;
}

.light {
  display: inline-block;
  width: 10px;
  height: 10px;
  border-radius: 50%;
  margin-right: 10px;
}

.online .light {
  background: limegreen;
}

.offline .light {
  background: crimson;
}
</style>
