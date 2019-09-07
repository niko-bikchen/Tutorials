import Vue from 'vue';
import Vuex from 'vuex';
import axios from "./axios-auth";
import globalAxios from 'axios';

import router from './router';

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    idToken: null,
    userId: null,
    user: null
  },
  mutations: {
    authUser(state, userData) {
      state.idToken = userData.token;
      state.userId = userData.userId;
    },
    storeUser(state, user) {
      state.user = user;
    },
    clearAuthData(state) {
      state.idToken = null;
      state.userId = null;
    }
  },
  actions: {
    setLogOutTimer(context, expirationTime) {
      setTimeout(() => {
        this.commit('clearAuthData');
      }, expirationTime * 1000);
    },
    signUp(context, payload) {
      axios
        .post("/accounts:signUp?key=AIzaSyC07GR_W2MTdhKgl6sK9ioreoo03a_V9B8", {
          email: payload.email,
          password: payload.password,
          returnSecureToken: true
        })
        .then(
          result => {
            console.log(result);
            context.commit("authUser", {
              token: result.data.idToken,
              userId: result.data.localId
            });
            const now = new Date();
            const expirationDate = new Date(now.getTime() + result.data.expiresIn * 1000);

            localStorage.setItem('token', result.data.idToken);
            localStorage.setItem('expiresDate', expirationDate);
            localStorage.setItem('userId', result.data.localId);
            context.dispatch("storeUser", payload);
            this.dispatch("setLogOutTimer", result.data.expiresIn);
          },
          error => {
            console.log(error);
          }
        );
    },
    logOut(context) {
      context.commit("clearAuthData");
      router.push("/signin");
      localStorage.removeItem("expiresDate");
      localStorage.removeItem("token");
      localStorage.removeItem("userId");
    },
    storeUser(context, userData) {
      if (context.state.idToken) {
        globalAxios.post(`/users.json?auth=${context.state.idToken}`, userData)
          .then(result => console.log(result))
          .catch(error => console.error(error));
      }
      else {
        return;
      }
    },
    signIn(context, payload) {
      axios
        .post("/accounts:signInWithPassword?key=AIzaSyC07GR_W2MTdhKgl6sK9ioreoo03a_V9B8", {
          email: payload.email,
          password: payload.password,
          returnSecureToken: true
        })
        .then(
          result => {
            console.log(result);
            context.commit("authUser", {
              token: result.data.idToken,
              userId: result.data.localId
            });
            const now = new Date();
            const expirationDate = new Date(now.getTime() + result.data.expiresIn * 1000);

            localStorage.setItem('token', result.data.idToken);
            localStorage.setItem('expiresDate', expirationDate);
            localStorage.setItem('userId', result.data.localId);
            this.dispatch("setLogOutTimer", result.data.expiresIn);
          },
          error => {
            console.log(error);
          }
        );
    },
    tryAutoLogIn(context) {
      const token = localStorage.getItem("token");
      if (!token) {
        return;
      }
      const expirationDate = localStorage.getItem("expiresDate");
      const now = new Date();
      if (now >= expirationDate) {
        return;
      }
      const userId = localStorage.getItem("userId");
      context.commit("authUser", { token, userId });
    },
    fetchUser(context) {
      if (context.state.idToken) {
        globalAxios
          .get(`/users.json?auth=${context.state.idToken}`)
          .then(response => {
            console.log(response);

            const data = response.data;
            const users = [];

            for (let key in data) {
              const user = data[key];

              user.id = key;
              users.push(user);
            }

            console.log(users);

            context.commit("storeUser", users[0]);
          })
          .catch(error => {
            console.log(error);
          });
      }
      else {
        return;
      }
    }
  },
  getters: {
    user(state) {
      return state.user;
    },
    isAuthenticated(store) {
      return store.idToken !== null;
    }
  }
})