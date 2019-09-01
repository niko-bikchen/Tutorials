import Vue from 'vue';
import App from './App.vue';
import VueRouter from 'vue-router';

// Importing routes
import { routes } from './routes';

// Regestering a plugin
Vue.use(VueRouter);

// Creating and cofiguring router
const router = new VueRouter({
  routes: routes, mode: "history", scrollBehavior(to, from, savedPosition) {
    // Scrolls page 700px down
    // return { x: 0, y: 700 };
    // Saved position is needed for the case when the user uses the back button
    // we won't scroll him up or down but to the position he was previously at
    if (savedPosition) {
      return savedPosition;
    }
    // Using a selector
    if (to.hash) {
      return { selector: to.hash };
    }
    return { x: 0, y: 0 }
  }
});

// Is executed every time we go to the new route
router.beforeEach(function (to, from, next) {
  console.log("global before each");
  // Can pass false to abort, can pass path to redirect
  next();
});

new Vue({
  el: '#app',
  render: h => h(App),
  router: router
})
