export const lengthCounterMixin = {
    computed: {
        counted() {
            return `${this.text} (${this.text.length})`;
        }
    }
}