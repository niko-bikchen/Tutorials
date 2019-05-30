/* 
    View instance.
    Controlls all or certain parts of the app.
    Can have one to controll whole app or several to control seperate areas. 
*/
// Takes object as a param, which describes how to controll the app.
/* 
    Obj. props: 
        • el - elements, which vue instance controls.
*/

new Vue({
    el: '#vue-app', // Connects vue instance to the vue-app div (controls it and everything inside).
    data: {
        name: 'Shaun',
        job: 'Ninja',
        website: 'http://www.thenetninja.co.uk/',
        websiteTag: '<a href="http://www.thenetninja.co.uk/"> A website as well </a>',
        age: 22,
        x: 0,
        y: 0,
        realName: '',
        realAge: '',
        a: 0,
        b: 0,
        available: false,
        nearby: false
    },
    methods: {
        greet(daytime) {
            // this.name; // Accessing data from inside the func.
            return 'Good ' + daytime + ', ' + this.name;
        },
        add(val = 1) {
            this.age += val;
            // We don't write this.data.age as in the end Vue places all props on the same level
        },
        subtract(val = 1) {
            this.age -= val;
        },
        updateCoords(event) {
            // event => an event obj
            this.x = event.offsetX;
            this.y = event.offsetY;
        },
        click() {
            alert('Hello');
        },
        logName() {
            console.log('Name entered');
        },
        logAge() {
            console.log('Age entered');
        },
        // addToA() {
        //     return this.a + this.age;
        // },
        // addToB() {
        //     return this.b + this.age;
        // },
    },
    computed: {
        addToA() {
            console.log('A');
            return this.a + this.age;
        },
        addToB() {
            console.log('B');
            return this.b + this.age;
        },
        compClasses() {
            return {
                available: this.available,
                nearby: this.nearby
            };
        }
    }
}); 