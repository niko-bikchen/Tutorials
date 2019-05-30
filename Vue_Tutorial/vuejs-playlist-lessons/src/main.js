import Vue from 'vue'
import App from './App.vue'
// import Ninjas from './Ninjas.vue'

// Vue.component('ninjas', Ninjas); // Component registere globally. Can be used by all other components.

new Vue({
  el: '#app',
  render: h => h(App) // Here we render imported App root component to the html. Root component is the top (mother) component which sits above all others
})

// Vue files are extensions of components. Basically it's components which have their own files