<template>
  <div id="add-blog">
    <h2>Add a New Blog Post</h2>
    <form v-if="!submitted">
      <label>Blog Title:</label>
      <input type="text" v-model.lazy="blog.title" required>
      <div id="checkboxes">
        <label>Ninjas</label>
        <input type="checkbox" value="Ninjas" v-model="blog.categories">
        <label>Wizards</label>
        <input type="checkbox" value="Wizards" v-model="blog.categories">
        <label>Mario</label>
        <input type="checkbox" value="Mario" v-model="blog.categories">
        <label>Cheese</label>
        <input type="checkbox" value="Cheese" v-model="blog.categories">
      </div>
      <label>Author</label>
      <select v-model="blog.author">
        <option v-for="(author, index) in authors" v-bind:key="index">{{ author }}</option>
      </select>
      <label>Blog Content:</label>
      <textarea v-model="blog.content"></textarea>
      <button v-on:click.prevent="post">Add Blog</button>
    </form>
    <div v-if="submitted">
      <h3>Thanks for adding your post</h3>
    </div>
    <div id="preview">
      <h3>Preview Blog:</h3>
      <p>Blog title: {{ blog.title }}</p>
      <p>Blog categories:</p>
      <ul>
        <li v-for="(category, index) in blog.categories" v-bind:key="index">{{ category }}</li>
      </ul>
      <p>Author: {{ blog.author }}</p>
      <p>Blog content:</p>
      <p>{{ blog.content }}</p>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      blog: { title: "", content: "", categories: [], author: "" },
      authors: ["The Net Ninja", "The Angular Avenger", "The Vue Vindicator"],
      submitted: false
    };
  },
  methods: {
    post() {
      // Making http post request using vue resource
      this.$http
        .post(
          "https://vuejs-tutorial-1bd13.firebaseio.com/posts.json",
          this.blog
        )
        .then(function(data) {
          console.log(data);
          this.submitted = true;
        })
        .catch(function(err) {
          console.log("An error occured", err);
        });
    }
  }
};
</script>

<style scoped>
#add-blog * {
  box-sizing: border-box;
}
#add-blog {
  margin: 20px auto;
  max-width: 500px;
}
label {
  display: block;
  margin: 20px 0 10px;
}
input[type="text"],
textarea {
  display: block;
  width: 100%;
  padding: 8px;
}
#preview {
  padding: 10px 20px;
  border: 1px dotted #ccc;
  margin: 30px 0;
}
h3 {
  margin-top: 10px;
}
#checkboxes input {
  display: inline-block;
  margin-right: 10px;
}
#checkboxes label {
  display: inline-block;
}
</style>