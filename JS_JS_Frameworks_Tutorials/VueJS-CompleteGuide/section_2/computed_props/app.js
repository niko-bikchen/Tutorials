new Vue({
    el: '#app',
    data() {
        return {
            counter: 1,
            counter_2: 1
        }
    },
    // * Every time we hange property from data object Vue will reload the page
    // * and also will call all the methods we use as Vue doesn't know whether the
    // * changed property was used by the mehods on the page or not so it just calls
    // * them all. To prevent this we can use computed propeties which are only
    // * called if the value they use is changed because the Vue analyzes their contents
    // * and knows which values they use.
    // ! Cannot be used to run async tasks
    computed: {
        output() {
            console.log("Computed");
            return "Kek"
        }
    },
    // * Is called whenever counter changes
    // ! Can be used to perform async tasks since we don't return a value neccessary
    // ! for html rendering
    watch: {
        counter: function (value) {
            var vm = this;
            setTimeout(function () {
                vm.counter = 0;
            }, 2000);
        }
    },
    methods: {
        // increase() {
        //     this.counter++;
        //     this.result = this.counter > 5 ? "Greater than 5" : "Lesser than 5";
        // },
        // decrease() {
        //     this.counter--;
        //     this.result = this.counter > 5 ? "Greater than 5" : "Lesser than 5";
        // }
        result() {
            console.log("Method");
            return this.counter > 5 ? "Greater than 5" : "Lesser than 5";
        }
    },
})