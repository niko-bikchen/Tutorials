<template>
  <div>
    <p>Server status: {{ status }}</p>
    <button @click="changeStatus">Change status</button>
  </div>
</template>

<script>
export default {
  data() {
    return {
      status: "Critical"
    };
  },
  methods: {
    changeStatus() {
      this.status = "Stable";
    }
  }
};
</script>