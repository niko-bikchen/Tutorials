new Vue({
    el: '#app',
    data() {
        return {
            counter: 0,
            x: 0,
            y: 0
        }
    },
    methods: {
        increase(step, event) {
            this.counter += 2;
        },
        updateCoords(event) {
            this.x = event.clientX;
            this.y = event.clientY;
        },
        // dummy() {
        //     event.stopPropagation();
        // }
        alertMe() {
            alert("Hello");
        }
    }
})