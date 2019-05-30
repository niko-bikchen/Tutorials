import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex);

// Here we create Vuex Store to manage state (data) of our app
// HINT: Better to use in big apps
export const store = new Vuex.Store({
    // This line disables the ability to change the state directly (like with a function from a component), so only mutations could be used to change it. Fires an error if you attempt to change state directly.
    strict: true,
    // Data for our app. Here we define different sets of data.
    // Products data are now defined in central state where it can be accessed by different components without being passed to them as a prop.
    state: {
        products: [
            { name: "Banana Skin", price: 20 },
            { name: "Shiny Star", price: 40 },
            { name: "Green Shells", price: 60 },
            { name: "Red Shells", price: 80 }
        ]
    },
    // Getters (their function is obvious I suppose)
    getters: {
        saleProducts(state) {
            var saleProducts = state.products.map(product => {
                return {
                    name: "**" + product.name + "**",
                    price: product.price / 2
                };
            });

            return saleProducts;
        }
    },
    // Used to change state. CAN be TRACKED DOWN while debugging apart from simple functions which cahge the state directly
    // !! WARNING !! YOU SHOULD'T USE ASYNC. FUNCTION CALLS INSIDE MUTATIONS (like setTimeout(), or grabbing data from a server)
    // P.S. LIKE, YOU CAN DO IT BUT IT WILL BE HARDER TO TRACK DOWN THE CHANGES AS THE MUTATION IS LOGGED IMMIDIATELY, EVEN IF TAKES TIME TO COMMIT IT

    // We can pass params. to the actions and/or mutations. Payload is its name.
    mutations: {
        reducePrice(state, payload = 1) {
            state.products.forEach(product => {
                product.price -= payload;
            });
        }
    },
    // Actions are another layer between component which triggers the mutation and the mutation call itself
    actions: {
        // Context is !like! a store or it's represents a store, thus it can be used like a store
        // Action gives us a possibility to do smt (like async. calls) before commiting a mutation
        // Like a request to the server or DB
        // WHEN USING ACTIONS THE MUTATION IS LOGGED ONLY AFTER AN ACTION IS COMPLETED

        // We can pass params. to the actions and/or mutations. Payload is its name.
        reducePrice(context, payload = 1) {
            setTimeout(function () {
                context.commit('reducePrice', payload);
            }, 2000)
        }
    }
});