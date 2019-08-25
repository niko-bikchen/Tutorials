<template>
  <div class="container">
    <div class="row">
      <div class="col-xs-12">
        <!-- Dynamic components -->
        <button @click="selectedComponent= 'appQuote'">Quote</button>
        <button @click="selectedComponent= 'appAuthor'">Author</button>
        <button @click="selectedComponent= 'appNew'">New</button>
        <p>{{ selectedComponent }}</p>
        <!-- <app-quote>
          <h2 slot="title">{{ quoteTitle }}</h2>
          <p>A wonderfult Quote</p>
        </app-quote>-->
        <keep-alive>
          <component :is="selectedComponent">
            <p>Default content</p>
          </component>
        </keep-alive>
      </div>
    </div>
  </div>
</template>

<script>
import Quote from "./components/Quote";
import Author from "./components/Author";
import New from "./components/New";

export default {
  data() {
    return {
      quoteTitle: "The Quote",
      selectedComponent: "appQuote"
    };
  },
  components: {
    appQuote: Quote,
    appAuthor: Author,
    appNew: New
  }
};
</script>

<style lang="scss">
</style>
