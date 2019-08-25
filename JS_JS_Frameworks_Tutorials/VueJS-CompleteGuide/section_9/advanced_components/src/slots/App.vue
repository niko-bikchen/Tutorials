<template>
  <div class="container">
    <div class="row">
      <div class="col-xs-12">
        <app-quote>
          <!-- Passing html to the app quote component -->
          <!-- Rendering (like pasting content instead of interpolations) happens here -->
          <!-- Styling happens in the component which encloses this html as well as in here -->
          <!-- Multiple slots -->
          <h2 slot="title">{{ quoteTitle }}</h2>
          <!-- <p slot="content">A wonderfult Quote</p> -->
          <!-- When we have named and unnamed slots together, unnamed will go to the <slot> tags -->
          <p>A wonderfult Quote</p>
        </app-quote>
      </div>
    </div>
  </div>
</template>

<script>
import Quote from "./components/Quote";

export default {
  data() {
    return {
      quoteTitle: "The Quote"
    };
  },
  components: {
    appQuote: Quote
  }
};
</script>

<style lang="scss">
</style>
