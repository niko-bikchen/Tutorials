// These two new Vue({...}) instances don't depend on each other and cannot
// access properties of each other

var data = {
    title: 'The VueJS Instance',
    showParagraph: false
}

// Regestering a reusable component
// First arg is a component selector, second is a js object !similar! 
// (it's not exactly equal, some things, like the data prop, are used differently)
// to the object we pass to the Vue instance
// Vue.component('hello', {
//     template: '<h1>Hello</h1>'
// });

// vm - vue model
var vm1 = new Vue({
    // el: '#app1',
    data: data,
    methods: {
        show: function () {
            this.showParagraph = true;
            this.updateTitle('The VueJS Instance (Updated)');
            console.log(this.$refs.myButton);
            this.$refs.myButton.innerText = "Test";
        },
        updateTitle: function (title) {
            this.title = title;
        }
    },
    computed: {
        lowercaseTitle: function () {
            return this.title.toLowerCase();
        }
    },
    watch: {
        title: function (value) {
            alert('Title changed, new value: ' + value);
        }
    }
});

// Allows us to do the same as the 'el' property
vm1.$mount('#app1');

// $data - contains all props from data
console.log(vm1.$data == data);
console.log(vm1.$data.title);
console.log(vm1.$data);
vm1.$refs.heading.childNodes[0].data = 'Something else';

// Accessing Vue instance from js code
// We can access properties in Vue instance like this
// because behind the scenes Vue will take the object
// we pass to the constructor, take data and methods 
// props from it and will use them as native props
// of Vue js instance object
// Also it sets a watcher for each property
// to watch if it changed (basically it will be getters and setters)
setTimeout(function () {
    vm1.title = "Changed by timer!";
    vm1.show();
}, 3000);

var vm2 = new Vue({
    el: '#app2',
    data() {
        return {
            title: "The second instance"
        }
    },
    methods: {
        onChange: function () {
            // Accessing one instance from another
            vm1.title = "Changed!";
        }
    }
});

var vm3 = new Vue({
    // This Vue has its own element
    // el: 'hello', - will work only on the first DOM element which satisfies the el selector
    template: '<h1>Hello</h1>'
})

vm3.$mount('#app3');
// vm3.$mount(); - renders element off-screen
// document.getElementById('app3').appendChild(vm3.$el);