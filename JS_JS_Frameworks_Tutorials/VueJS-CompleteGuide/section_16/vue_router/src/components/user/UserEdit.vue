<template>
  <div>
    <h3>Edit the User</h3>
    <p>Locale: {{ this.$route.query.locale }}</p>
    <p>Analytics: {{ this.$route.query.q }}</p>
    <div style="height: 700px"></div>
    <p id="data">Some Extra Data</p>
  </div>
</template>

<script>
export default {
  data() {
    return {
      confirmed: false
    };
  },
  beforeRouteLeave(to, from, next) {
    if (this.confirmed) {
      next();
    } else {
      if (confirm("Are you sure?")) {
        next();
      } else {
        next(false);
      }
    }
  }
};
</script>