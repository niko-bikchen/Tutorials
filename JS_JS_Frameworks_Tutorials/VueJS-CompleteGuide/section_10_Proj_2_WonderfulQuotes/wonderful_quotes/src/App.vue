<template>
  <div class="container">
    <app-header :quoteCount="quotes.length" :maxQuotes="maxQuotes"></app-header>
    <app-new-quote @quoteAdded="newQuote"></app-new-quote>
    <app-quote-grid :quotes="quotes" @quoteDeleted="deleteQuote"></app-quote-grid>
    <div class="row mt-5">
      <div class="col-12 text-center">
        <div class="alert alert-info">Click on a quote to delete it!</div>
      </div>
    </div>
  </div>
</template>

<script>
import QuoteGrid from "./components/QuoteGrid";
import NewQuote from "./components/NewQuote";
import Header from "./components/Header";

export default {
  data() {
    return {
      maxQuotes: 10,
      quotes: ["Just a quote to see something"]
    };
  },
  components: {
    appQuoteGrid: QuoteGrid,
    appNewQuote: NewQuote,
    appHeader: Header
  },
  methods: {
    newQuote(quote) {
      quote.replace(/\s*/, "") != ""
        ? this.quotes.length < 10
          ? this.quotes.push(quote)
          : alert("Too much quotes. Delete one to add a new one.")
        : alert("Quote cannot be empty.");
    },
    deleteQuote(index) {
      this.quotes.splice(index, 1);
    }
  }
};
</script>

<style lang="scss">
</style>
