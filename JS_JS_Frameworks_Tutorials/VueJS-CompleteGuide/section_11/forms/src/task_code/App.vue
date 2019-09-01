<template>
  <div class="container">
    <form>
      <div class="row">
        <div class="col-xs-12 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3">
          <!-- Exercise 1 -->
          <!-- Create a Signup Form where you retrieve the following Information -->
          <!-- Full Name (First Name + Last Name) -->
          <!-- Mail -->
          <!-- Password -->
          <!-- Store Data? Yes/No -->

          <!-- Exercise 2 -->
          <!-- Only display the Form if it has NOT been submitted -->
          <!-- Display the Data Summary ONCE the Form HAS been submitted -->

          <!-- Exercise 3 -->
          <!-- Edit the Example from above and create a custom "Full Name" Control -->
          <!-- which still holds the First Name and Last Name Input Field -->
        </div>
      </div>
    </form>
    <hr />
    <div class="row">
      <div class="col-xs-12 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3" v-if="submitted">
        <div class="card">
          <div class="card-header">
            <h4>Enter Your Data</h4>
          </div>
          <div class="card-body">
            <app-full-name v-model="fullName"></app-full-name>
            
            <p>Mail:</p>
            <input type="email" v-model="email" />
            <p>Password:</p>
            <input type="password" v-model="password" />
            <p>Store in Database?:</p>
            <label for="yes">
              <input type="radio" id="yes" value="Yes" v-model="storeInDb" /> Yes
            </label>
            <label for="no">
              <input type="radio" id="no" value="No" v-model="storeInDb" /> No
            </label>
            <button class="btn btn-success btn-block" @click.prevent="submitted = false">Submit</button>
          </div>
        </div>
      </div>
      <div class="col-xs-12 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3" v-else>
        <div class="card">
          <div class="card-header">
            <h4>Your Data</h4>
          </div>
          <div class="card-body">
            <p>Full Name: {{ fullName }}</p>
            <p>Mail: {{ email }}</p>
            <p>Password: {{ password }}</p>
            <p>Store in Database?: {{ storeInDb }}</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import FullName from "./FullName";

export default {
  data() {
    return {
      fullName: "",
      email: "",
      password: "",
      storeInDb: "Yes",
      submitted: true
    };
  },
  components: {
    appFullName: FullName
  }
};
</script>

<style>
</style>
