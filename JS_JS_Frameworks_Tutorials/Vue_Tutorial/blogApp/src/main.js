import Vue from 'vue'
import App from './App.vue'
import VueResource from 'vue-resource'
import VueRouter from 'vue-router'
import Routes from './routes'

Vue.use(VueResource); // In this way we start using Vue resource module (telling Vue to use it)
Vue.use(VueRouter);

// Defining router object
const router = new VueRouter({
  routes: Routes,
  mode: 'history'
});


// Creating custom directive
// REGISTERED GLOBALLY (can be used by any component)
// Vue.directive('rainbow', {
//   // Vnode - virtual node on the DOM
//   // binding - information about the connection (like arguments)
//   // el - dom element directive is applied to
//   bind(el, binding, vnode) {
//     el.style.color = '#' + Math.random().toString().slice(2, 8);
//   }
// });

Vue.directive('theme', {
  bind(el, binding, vnode) {
    if (binding.value === 'wide') {
      el.style.maxWidth = '1200px';
    } else if (binding.value === 'narrow') {
      el.style.maxWidth = '560px';
    }
    if (binding.arg === 'column') {
      el.style.background = '#ddd';
      el.style.padding = '20px';
    }
  }
});

// Filters (change how the data looks on the page)
// Value refers to the data we 'filter'
// By using filter we change only how data looks. Data 'inside' remains unchanged
// REGISTERED GLOBALLY (can be used by any component)
// Vue.filter('to-uppercase', value => value.toUpperCase());
Vue.filter('snippet', value => value.slice(0, 100) + '...');

new Vue({
  el: '#app',
  render: h => h(App),
  router: router
})
