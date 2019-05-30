var one = new Vue({
    el: '#vue-app-one',
    data: {
        title: 'Vue app one'
    },
    methods: {
        
    },
    computed: {
        greet() {
            return 'Hello from app one'
        }
    }
});

var two = new Vue({
    el: '#vue-app-two',
    data: {
        title: 'Vue app two'
    },
    methods: {
        changeTitle() {
            one.title = 'Title changed';
        }
    },
    computed: {
        greet() {
            return 'Hello from app two'
        }
    }
});

two.title = "Changed from outside";
