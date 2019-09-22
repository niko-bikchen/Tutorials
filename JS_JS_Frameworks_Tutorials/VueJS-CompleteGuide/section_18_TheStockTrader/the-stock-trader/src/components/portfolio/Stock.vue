<template>
  <div class="col-md-6 mb-4">
    <div class="card border-info">
      <div class="card-header">
        {{stock.name}}
        <small>Price {{stock.price}} | Quantity {{ stock.quantity }}</small>
      </div>
      <div class="card-body">
        <div class="float-left">
          <input
            type="number"
            class="form-control"
            placeholder="Quantity"
            v-model.number="quantity"
            :class="{'border-danger': insufficientQuantity}"
          />
        </div>
        <div class="text-right float-right">
          <button
            class="btn btn-success"
            :class="{'bg-danger': insufficientQuantity, 'border-danger': insufficientQuantity}"
            @click="sellStock"
            :disabled="insufficientQuantity || quantity <= 0 || !Number.isInteger(quantity)"
          >{{insufficientQuantity ? 'Not Enough Stocks' : 'Sell'}}</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapActions } from "vuex";

export default {
  props: ["stock"],
  data() {
    return {
      quantity: 0
    };
  },
  computed: {
    insufficientQuantity() {
      return this.quantity > this.stock.quantity;
    }
  },
  methods: {
    ...mapActions({
      placeSellOrder: "sellStock"
    }),
    sellStock() {
      const order = {
        stockId: this.stock.id,
        stockPrice: this.stock.price,
        quantity: this.quantity
      };
      this.placeSellOrder(order);
      this.quantity = 0;
    }
  }
};
</script>