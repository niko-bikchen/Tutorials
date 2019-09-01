<template>
  <div>
    <h1>The User Page</h1>
    <hr />
    <button @click="navigateToHome" class="btn btn-primary">Go to Home</button>
    <hr />
    <!-- Load subroutes of the User -->
    <router-view></router-view>
  </div>
</template>

<script>
export default {
  // data() {
  //   return {
  //     id: this.$route.params.id // $route is the route that was loaded
  //   };
  // },
  // // If we already on the user component and the path (url) changes but we would load the
  // // same component, Vue will load the resources but will not recreate the component
  // // thus we need to watch the route and change the id when it is changed
  // // watch: {
  // //   $route(to, from) {
  // //     this.id = to.params.id;
  // //   }
  // // },
  // // An alternative to using watch on params.id. You need to set props: true in the routes. Also you can supply props with a function
  // props: ["id"],
  methods: {
    navigateToHome() {
      // Pushed route to the stack of routes we were at
      // this.$router.push("/");
      this.$router.push({ name: "home"}); // Using route names
      // this.$router.push({path: "/"}); Same stuff
    }
  }
};
</script>