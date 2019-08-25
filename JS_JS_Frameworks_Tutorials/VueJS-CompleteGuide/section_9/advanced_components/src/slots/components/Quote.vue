<template>
  <div>
    <!-- Html that was passed to the component will be rendered in the slot tags -->
    <!-- <slot></slot> -->
    <!-- Multiple slots -->
    <div class="title">
      <!-- Named slots go here -->
      <slot name="title"></slot>
      <!-- Slot which might be not passed -->
      <span style="color: #ccc">
        <!-- Stuff between <slot> is a default content for this slot -->
        <slot name="subtitle">The subtitle</slot>
      </span>
    </div>
    <hr />
    <div>
      <!-- <slot name="content"></slot> -->
      <!-- Unnamed slots go here -->
      <slot></slot>
    </div>
  </div>
</template>

<script>
export default {};
</script>

<style lang="scss" scoped>
// This tyle for h2 is applied to h2 rendered to slot
// If we set style for h2 passed to slot in the parent it will not be applied
h2 {
  color: red;
}

div {
  padding: 30px;
  margin: 30px auto;

  text-align: center;

  border: 1px solid #cccccc;
  box-shadow: 1px 1px 2px black;

  &.title {
    font-style: italic;
  }
}
</style>