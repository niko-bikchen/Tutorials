new Vue({
    el: '#vue-app',
    data: {
        output: 'You fav food'
    },
    methods: {
        readRefs() {
            // List of ALL refs
            console.log(this.$refs.input.value);
            console.log(this.$refs.polite.innerText);
            this.output = this.$refs.input.value;
        }
    },
    computed: {

    }
});