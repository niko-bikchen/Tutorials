import Vue from 'vue'
import App from './App.vue'

// Definig directive globally
Vue.directive('highlight', {
  bind(el, binding, vnode) {
    // el.style.backgroundColor = 'green'; // Accessing native html element and its style
    //el.style.backgroundColor = binding.value; // Binding has info about our directive binding (place in a code where we use v-highlight); value has values we pass like v-highlight="bla bla bla"
    var delay = 0;
    if (binding.modifiers['delayed']) {
      delay = 3000;
    }
    setTimeout(function () {
      if (binding.arg == "background") {
        el.style.backgroundColor = binding.value;
      } else {
        el.style.color = binding.value;
      }
    }, delay);
  }
});

new Vue({
  el: '#app',
  render: h => h(App)
})
