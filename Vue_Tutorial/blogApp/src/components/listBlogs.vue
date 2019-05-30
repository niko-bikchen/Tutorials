<template>
  <div id="show-blogs">
    <h1>List Blog Titles</h1>
    <input type="text" v-model="search" placeholder="Search blogs">
    <div class="single-blog" v-for="(blog, index) in filteredBlogs" v-bind:key="index">
      <h2 v-rainbow>{{ blog.title | to-uppercase }}</h2>
    </div>
  </div>
</template>

<script>
import searchMixin from "../mixins/searchMixin";

export default {
  //   computed: {
  //     filteredBlogs() {
  //       return this.blogs.filter(blog => blog.title.match(this.search));
  //     }
  //   },
  data() {
    return {
      blogs: [],
      search: ""
    };
  },
  methods: {},
  created() {
    // Making an http get request using vue resource
    this.$http
      .get("http://jsonplaceholder.typicode.com/posts")
      .then(result => {
        this.blogs = result.body.slice(0, 10);
      })
      .catch(err => {
        console.log("An error occured", err);
      });
  },
  filters: {
    "to-uppercase": function(value) {
      return value.toUpperCase();
    }
    // Same stuff
    // toUppercase(value) {
    //   return value.toUpperCase();
    // }
  },
  directives: {
    rainbow: {
      bind(el, binding, vnode) {
        el.style.color =
          "#" +
          Math.random()
            .toString()
            .slice(2, 8);
      }
    }
  },
  mixins: [searchMixin]
};
</script>

<style>
#show-blogs {
  max-width: 800px;
  margin: 0 auto;
}
.single-blog {
  padding: 20px;
  margin: 20px 0;
  box-sizing: border-box;
  background: #eee;
}
input[type="text"] {
  display: block;
  width: 100%;
  padding: 8px;
}
</style>