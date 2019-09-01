<template>
  <div class="container">
    <div class="row">
      <div class="col-xs-12 col-sm-8 offset-sm-2 col-md-6 offset-md-3">
        <h1 class="text-center">Http</h1>
        <div class="from-group">
          <label for="user_name">Username</label>
          <input id="user_name" class="form-control" type="text" v-model="user.name" />
        </div>
        <div class="from-group mt-2">
          <label for="user_name">Mail</label>
          <input id="user_mail" class="form-control" type="text" v-model="user.email" />
        </div>
        <div class="from-group mt-2">
          <label for="url">Url To Use</label>
          <input id="url" class="form-control" type="text" v-model="node" />
        </div>
        <button class="btn btn-primary btn-block mt-3" @click="submit">Submit</button>
        <button class="btn btn-primary btn-block mt-3" @click="fetchData">Get Data</button>
        <ul class="list-group">
          <li
            class="list-group-item"
            v-for="(user, index) in users"
            :key="user.name"
          >{{ index + 1 }}. {{user.name}} - {{user.email}}</li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      user: {
        name: "",
        email: ""
      },
      users: [],
      resource: {},
      node: "data"
    };
  },
  methods: {
    submit() {
      // Sending data with Vue resource
      // ! $http is added by vue-resource to each Vue instance
      // this.$http.post("data.json", this.user).then(
      //   response => {
      //     console.log(response);
      //   },
      //   error => {
      //     console.log(error);
      //   }
      // );
      //this.resource.save({}, this.user);
      this.resource.saveAlt(this.user);
    },
    fetchData() {
      // this.$http
      //   .get("data.json")
      //   .then(
      //     response => {
      //       // json is a vue-resource helper method
      //       return response.json();
      //     },
      //     error => {
      //       console.log(error);
      //     }
      //   )
      //   .then(data => {
      //     const result = [];
      //     for (let key in data) {
      //       result.push(data[key]);
      //     }
      //     this.users = result;
      //   });
      this.resource
        .getData({ node: this.node })
        .then(
          response => {
            // json is a vue-resource helper method
            return response.json();
          },
          error => {
            console.log(error);
          }
        )
        .then(data => {
          const result = [];
          for (let key in data) {
            result.push(data[key]);
          }
          this.users = result;
        });
    }
  },
  created() {
    const customActions = {
      saveAlt: { method: "POST", url: "alternative.json" },
      getData: { method: "GET" }
    };
    // Setting up vue-resource resource
    this.resource = this.$resource("{node}.json", {}, customActions);
  }
};
</script>

<style>
</style>
