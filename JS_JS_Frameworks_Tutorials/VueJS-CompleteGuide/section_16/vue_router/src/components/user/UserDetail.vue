<template>
  <!-- :to="'/user/' + $route.params.id + '/edit'" -->
  <div>
    <h3>Some User Details</h3>
    <!-- this may be unneccessary because you should use it in Vue instance -->
    <p>User loaded has ID: {{ this.$route.params.id }}</p>
    <router-link tag="button" :to="link" class="btn btn-primary">Edit User</router-link>
  </div>
</template>

<script>
export default {
  data() {
    return {
      link: {
        name: "userEdit",
        params: { id: this.$route.params.id },
        query: { locale: "en", q: 100 },
        // We use hash because when the page loads we want to jump to the element with that id
        hash: "#data"
      }
    };
  },
  beforeRouteEnter(to, from, next) {
    // If you don't call next() component will not be created
    // ! Before next you can't enter your Vue instance
    // ! this.link won't work
    // You can pass callback to next where you will have access to your intance
    next();
  }
};
</script>