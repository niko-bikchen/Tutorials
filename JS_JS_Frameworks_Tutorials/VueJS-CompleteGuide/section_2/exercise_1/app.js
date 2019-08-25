new Vue({
    el: '#exercise',
    data() {
        return {
            name: "Nick",
            age: 19,
            img_src: 'https://picsum.photos/536/354'
        }
    },
    methods: {
        randomFloat() {
            return Math.floor(Math.random() * 99) + 1;
        }
    },
});