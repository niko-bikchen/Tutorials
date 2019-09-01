import Vue from 'vue';
import App from './App.vue';
import VueResource from 'vue-resource';

Vue.use(VueResource);

// Setting url for vue-resource to use globally
Vue.http.options.root = "https://vuejs-complete-guide-5721d.firebaseio.com/";
// Creating interceptors - functions which will be executed on each request/response
// Call next() at the end when you are finished working with the request so that 
// vue-resource could proceed with operation
// ! PUT overrides the data in the DB
// Vue.http.interceptors.push((request, next) => {
//   console.log(request);
//   if (request.method == "POST") {
//     request.method = "PUT";
//   }
//   next();
// });

Vue.http.interceptors.push((request, next) => {
  console.log(request);
  if (request.method == "POST") {
    request.method = "PUT";
  }
  // Intercepting responses
  // ! Overwriting json() will effect all requests
  next(response => {
    response.json = () => {
      return { messages: response.body }
    }
  });
});

new Vue({
  el: '#app',
  render: h => h(App)
})
