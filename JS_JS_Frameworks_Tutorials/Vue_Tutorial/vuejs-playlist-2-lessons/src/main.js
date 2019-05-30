import Vue from 'vue'
import App from './App.vue'

export const bus = new Vue(); // An EVENT BUS, which will 'pass' our events from one component to the other without involving the parent component.

new Vue({
  el: '#app',
  render: h => h(App)
})
