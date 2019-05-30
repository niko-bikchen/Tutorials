<template>
  <div id="single-blog">
    <h1>{{ blog.title }}</h1>
    <article>{{ blog.content }}</article>
    <p>Author: {{ blog.author }}</p>
    <p>Categories:</p>
    <ul>
      <li v-for="(category, index) in blog.categories" v-bind:key="index">{{ category }}</li>
    </ul>
  </div>
</template>

<script>
export default {
  data() {
    return {
      id: this.$route.params.id,
      blog: {}
    };
  },
  created() {
    this.$http
      .get(
        "https://vuejs-tutorial-1bd13.firebaseio.com/posts/" + this.id + ".json"
      )
      .then(result => {
        return result.json();
      })
      .then(result => {
        this.blog = result;
      })
      .catch(err => {
        console.log("An error occured", err);
      });
  }
};
</script>

<style scoped>
#single-blog {
  max-width: 960px;
  margin: 0 auto;
}
</style>
