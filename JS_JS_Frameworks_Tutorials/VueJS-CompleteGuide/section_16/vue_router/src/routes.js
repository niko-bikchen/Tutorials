import User from './components/user/User.vue';
import UserStart from './components/user/UserStart.vue';
import UserDetail from './components/user/UserDetail.vue';
import UserEdit from './components/user/UserEdit.vue';
import Home from './components/Home.vue';
import Header from './components/Header.vue';

// Here each object represents a route
// path - will be appended to your domain like yourdomain.com/path
export const routes = [
    // We are saying: "When you visit /user - load the User component"
    {
        path: "/",
        // component: Home,
        name: "home",
        // Using named router-views
        components: {
            default: Home,
            'header-top': Header
        }
    },
    // Route parameters. That means user component will be loaded when you go to /user/something (id)
    // { path: "/user/:id", component: User, props: true }
    {
        // Subcomponents (child routes) for user
        // empty path specifies what will be appended to /user like test.com/user/something
        // if you will write path that will start with a /
        // it will be appended directly to your domain like test.com/something
        path: "/user", component: User, children: [
            { path: "", component: UserStart },
            {
                // beforeEnter works every time we enter UserDetail route
                path: ":id", component: UserDetail, beforeEnter(to, from, next) {
                    console.log("inside route setup");
                    next();
                }
            },
            // Setting up name of the route to use it in "to" attr
            { path: ":id/edit", component: UserEdit, name: "userEdit" }
        ],
        components: {
            default: User,
            'header-bottom': Header
        }
    },
    // Redirecting user
    {
        path: '/redirect-me', redirect: '/user'
    },
    // Catches any path
    {
        path: '*',
        redirect: '/'
    }
];