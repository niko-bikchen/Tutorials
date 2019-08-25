<template>
  <div class="component">
    <h1>The User Component</h1>
    <p>I'm an awesome User!</p>
    <button @click="changeName">Change my name!</button>
    <p>{{ name }}</p>
    <hr />
    <div class="row">
      <div class="col-xs-12 col-sm-6">
        <!-- Passing name prop to the UserDetail component -->
        <!-- Name of the prop can be case-sensetive like camel case, but only in Single File Template -->
        <!-- Extra care must be taken when passing reference types such as Object or Array -->
        <app-user-detail
          :myName="name"
          :userAge="age"
          @nameWasReset="name = $event"
          :resetFunction="resetName"
        ></app-user-detail>
      </div>
      <div class="col-xs-12 col-sm-6">
        <app-user-edit :userAge="age" @ageWasEdited="age = $event"></app-user-edit>
      </div>
    </div> 
  </div>
</template>

<script>
import UserDetail from "./UserDetail.vue";
import UserEdit from "./UserEdit.vue";

export default {
  data() {
    return {
      name: "Nick",
      age: 27
    };
  },
  methods: {
    changeName() {
      this.name = "Jack";
    },
    resetName() {
      this.name = "Nick";
    }
  },
  components: {
    appUserDetail: UserDetail,
    appUserEdit: UserEdit
  }
};
</script>

<style scoped>
div {
  background-color: lightblue;
}
</style>
