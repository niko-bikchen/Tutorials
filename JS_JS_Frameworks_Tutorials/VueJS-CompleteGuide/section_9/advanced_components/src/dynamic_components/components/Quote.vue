<template>
  <div>
    <div class="title">
      <slot name="title"></slot>
      <span style="color: #ccc">
        <slot name="subtitle">The subtitle</slot>
      </span>
    </div>
    <hr />
    <div>
      <slot></slot>
    </div>
  </div>
</template>

<script>
export default {};
</script>

<style lang="scss" scoped>
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