/*
Component is a reusable piece of code or template which we can use in different Vue instances.
Components are created once and than used in different places (Vue instances).
*/

Vue.component('greeting', {
    template: '<p> Greetings, I am {{ name }}. <button v-on:click="changeName">Change name</button> </p>',
    data: function () {
        return {
            name: 'Yoshi'
        };
    },
    methods: {
        changeName() {
            this.name = 'Mario'
        }
    },
});

var one = new Vue({
    el: '#vue-app-one',
    data: {

    },
    methods: {

    },
    computed: {

    }
});

var two = new Vue({
    el: '#vue-app-two',
    data: {

    },
    methods: {

    },
    computed: {

    }
});