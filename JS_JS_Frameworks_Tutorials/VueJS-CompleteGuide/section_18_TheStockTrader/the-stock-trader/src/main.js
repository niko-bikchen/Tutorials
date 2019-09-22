import Vue from 'vue';
import App from './App.vue';
import VueRouter from 'vue-router';
import { routes } from './routes';
import store from './store/store.js';
import VueResource from 'vue-resource';

Vue.use(VueRouter);
Vue.use(VueResource);

Vue.http.options.root = "https://stock-trader-c9b58.firebaseio.com/";

Vue.filter('currency', function (value) {
  return '$' + value.toLocaleString();
})

const router = new VueRouter({
  mode: 'history',
  routes
});

new Vue({
  el: '#app',
  router,
  store,
  render: h => h(App)
})
