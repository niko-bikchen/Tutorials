const state = {
    counter: 0
};

const getters = {
    doubleCounter(state) {
        return state.counter * 2;
    },
    stringCounter(state) {
        return state.counter + " Clicks";
    }
};

const mutations = {
    increment(state, payload) {
        state.counter += isNaN(payload) ? 1 : payload;
    },
    decrement(state) {
        state.counter--;
    }
}

const actions = {
    // Won't conflict with mutations since they are 2 different objects
    // context gives us access to the commit method
    increment(context, payload) {
        // Now the actions triggers the mutation
        // ! Context has many methods of the store but not all of them
        context.commit("increment", payload);
    },
    decrement(context) {
        context.commit("decrement");
    },
    asyncIncrement(context) {
        setTimeout(function () {
            context.commit("decrement");
        }, 1000);
    },
    updateValue(context, payload) {
        context.commit("updateValue", payload);
    }
};

export default {
    state,
    mutations,
    actions,
    getters
}