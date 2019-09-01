import Vue from 'vue'
import App from './App.vue'

// Creating global filter
Vue.filter('toLowercase', function (value) {
  return value.toLowerCase();
});

// ! Global mixin is merged with each component you use in the app
Vue.mixin({
  created() {
    console.log("Global mixin created");
  }
})

new Vue({
  el: '#app',
  render: h => h(App)
})
