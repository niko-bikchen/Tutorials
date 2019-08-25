import Vue from 'vue'
import App from './App.vue'

// el - selects the place where we load our Vue app
// rener - renders template to the el. h - is a render function.
// render is like a template prop where we pass string, but here we pass compiled template
// ! Contents of the el will be overwritten with the template contents we specify for render
new Vue({
  el: '#app',
  render: h => h(App)
})
