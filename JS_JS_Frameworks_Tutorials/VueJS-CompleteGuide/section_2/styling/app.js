new Vue({
    el: '#app',
    data() {
        return {
            attachRed: false,
            color: 'green',
            width: 100
        }
    },
    computed: {
        divClasses: function () {
            return {
                red: this.attachRed,
                blue: !this.attachRed
            }
        },
        myStyle: function () {
            return {
                backgroundColor: this.color,
                width: this.width + 'px'
            }
        }
    },
})