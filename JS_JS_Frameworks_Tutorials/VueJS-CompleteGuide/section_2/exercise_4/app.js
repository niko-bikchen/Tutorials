new Vue({
  el: '#exercise',
  data() {
    return {
      isHighlight: true,
      isShrink: false,
      colorRed: 'red',
      colorGreen: 'green',
      classFromInput: 'crimson',
      isApplied: true,
      bcColor: 'red',
      width: 0
    };
  },
  computed: {
    someClasses: function () {
      return {
        pink: true,
        blue: true
      };
    },
    progressBar: function () {
      return {
        width: this.width + '%',
        backgroundColor: 'green',
        textAlign: 'center'
      };
    }
  },
  methods: {
    startEffect: function () {
      console.log('Hello');
      const vm = this;
      setInterval(function () {
        vm.isHighlight = !vm.isHighlight;
        vm.isShrink = !vm.isShrink;
      }, 500);
    },
    startProgress: function () {
      const vm = this;
      var id = setInterval(function () {
        vm.width += 10;
        if (vm.width == 100) {
          clearInterval(id);
        }
      }, 500);
    }
  }
});
