import Vue from 'vue';
import App from './App.vue';
import axios from 'axios';
import Vuelidate from 'vuelidate';

import router from './router';
import store from './store';

Vue.use(Vuelidate);

// Setting up global options
axios.defaults.baseURL = "https://axios-and-vue.firebaseio.com/"; // Setting base URL
// axios.defaults.headers.common["Authorization"] = "Your stuff"; // Adding to default headers. Will be applied to any request (GET, POST, etc.)
axios.defaults.headers.get["Accepts"] = "application/json"; // Setting header for GET requests

// Setting interceptors
const reqInterceptor = axios.interceptors.request.use(config => {
  console.log("Request Intercetor", config);
  // ! Don't forget to return it, otherwise the request will be blocked
  return config;
});

const resInterceptor = axios.interceptors.response.use(response => {
  console.log("Response interceptor", response);
  // ! Don't forget to return it, otherwise the response will be blocked
  return response;
});

// Removing interceptors
axios.interceptors.request.eject(reqInterceptor);
axios.interceptors.response.eject(resInterceptor);

new Vue({
  el: '#app',
  router,
  store,
  render: h => h(App)
})
