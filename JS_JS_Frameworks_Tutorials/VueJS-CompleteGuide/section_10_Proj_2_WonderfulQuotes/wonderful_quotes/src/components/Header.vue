<template>
  <div class="row mb-4">
    <div class="col-12">
      <h3>Quotes added</h3>
      <div class="progress">
        <div
          class="progress-bar"
          role="progressbar"
          aria-valuenow="60"
          aria-valuemin="0"
          aria-valuemax="100"
          :style="{width: ((quoteCount / maxQuotes) * 100) + '%'}"
        >{{ quoteCount }} / {{ maxQuotes }}</div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    quoteCount: {
      type: Number,
      required: true
    },
    maxQuotes: {
      type: Number,
      required: true
    }
  }
};
</script>