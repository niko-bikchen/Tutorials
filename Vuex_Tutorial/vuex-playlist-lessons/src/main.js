import Vue from 'vue'
import App from './App.vue'
import { store } from './store/store'

// Now the store is used by the App root component
new Vue({
  store: store,
  el: '#app',
  render: h => h(App)
})
