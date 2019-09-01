<template>
  <div class="row mb-4">
    <form class="col-12">
      <div class="col-sm-8 offset-sm-2 col-xs-12 col-md-6 offset-md-3 form-group">
        <label for="quote">
          <b>Quote</b>
        </label>
        <textarea name="quote" id="quote" rows="3" class="form-control" v-model="quote"></textarea>
      </div>
      <div class="col-sm-8 offset-sm-2 col-xs-12 col-md-6 offset-md-3 form-group text-center">
        <button class="btn btn-primary btn-block" @click.prevent="createNew">Add Quote</button>
      </div>
    </form>
  </div>
</template>

<script>
export default {
  data() {
    return {
      quote: ""
    };
  },
  methods: {
    createNew() {
      this.$emit("quoteAdded", this.quote);
      this.quote = "";
    }
  }
};
</script>

<style lang="scss">
</style>