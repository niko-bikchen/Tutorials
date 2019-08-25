new Vue({
    el: '#app',
    data() {
        return {
            title: "The Vue.js instance"
        }
    },
    beforeCreate() {
        alert("beforeCreate");
    },
    created() {
        alert("created");
    },
    beforeMount() {
        alert("beforeMount");
    },
    mounted() {
        alert("mounted");
    },
    beforeUpdate() {
        alert("beforeUpdate");
    },
    updated() {
        alert("updated");
    },
    beforeDestroy() {
        //* Good for cleanup
        alert("beforeDestroy");
    },
    destroyed() {
        alert("destroyed")
    },
    methods: {
        destroy() {
            //! Doesn't remove code from html, but all js logic behind it
            this.$destroy();
        }
    }
})