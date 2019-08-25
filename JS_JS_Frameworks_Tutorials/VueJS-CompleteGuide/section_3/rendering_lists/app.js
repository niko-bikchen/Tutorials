new Vue({
    el: '#app',
    data() {
        return {
            ingridients: ["meat", "fruit", "cookies"],
            persons: [
                {name: "Bruce", age: 30, color: "Black"},
                {name: "Peter", age: 'NaN', color: "Brown"}
            ]
        }
    },
})