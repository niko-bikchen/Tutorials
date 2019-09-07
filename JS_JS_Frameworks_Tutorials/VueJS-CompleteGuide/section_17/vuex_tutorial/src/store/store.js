import Vue from 'vue';
import Vuex from 'vuex';
import counter from './modules/counter';

// This will give us an object with all exported values
import * as actions from './actions';

Vue.use(Vuex);

export const store = new Vuex.Store({
    state: {
        counter: 0,
        value: 0
    },
    // Setting getters
    getters: {
        value(state) {
            return state.value;
        }
    },
    // Setting mutations
    // ! Don't use Mutations to run async code as it will be difficult to track them
    // TODO Use Actions
    mutations: {
        updateValue(state, payload) {
            state.value = payload;
        }
    },
    // Setting up actions
    // ! Use if you have async tasks
    actions,
    // Using modules to outsorce different states (see counter.js file)
    modules: {
        counter
    }
});