new Vue({
    el: '#app',
    data() {
        return {
            title: 'Hello World',
            link: 'http://google.com',
            finishedLink: '<a href="http://google.com">Google</a>"'
        }
    },
    methods: {
        changeTitle(event) {
            this.title = event.target.value;
        },
        sayHello() {
            this.title = "Hello";
            // Vue creates a proxy so that by using this we could access data prop
            return this.title;
        }
    }
})