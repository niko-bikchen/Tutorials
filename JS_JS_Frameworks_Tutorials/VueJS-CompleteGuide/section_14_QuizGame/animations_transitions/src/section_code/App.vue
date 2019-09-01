<template>
  <div class="container">
    <div class="row">
      <div class="col-xs-12 col-sm-8 offset-sm-2 col-md-6 offset-md-3">
        <h1>Animations</h1>
        <hr />

        <select v-model="alertAnimation" class="form-control">
          <option value="fade">Fade</option>
          <option value="slide">Slide</option>
        </select>

        <br />
        <button class="btn btn-primary" @click="show = !show">Show Alert</button>
        <!-- Transition is used to animate element between its tags -->
        <!-- You can animate only one element () you can show only one element at a time, but you can have multiple elemnts to transition between them -->
        <br />
        <br />
        <!-- 
          When animating vue adds classes to the object by default they are:
            When going from:
              v-if/show=false to v-if/show=true
              • *-enter - Here you set initial state with which your animation will begin. Last 1 Frame
              • *-enter-active - Here you set styles which will change during animation duration
            When going from:
              v-if/show=true to v-if/show=false
              • *-leave
              • *-leave-active
          Where * is the part of the class name you supply by yourself (by default it is "v")
          Length of the animation will be calculated by Vue looking at how you change styles
        -->
        <!-- You name to paste instead of * -->
        <!-- You can not only hardcode name prop like name="..." but to bind it -->
        <transition :name="alertAnimation">
          <div class="alert alert-info" v-show="show">This is some info</div>
        </transition>

        <!--  
          By default length of the animation is dicatated by the longest animation
          thus when you have animation and transition together you should specify type
          to tell who dictates the animation so it could be smooth
        -->
        <transition name="slide" type="animation">
          <div class="alert alert-info" v-if="show">This is some info</div>
        </transition>

        <!-- On load animation. Animates when attached to DOM -->
        <transition name="fade" appear>
          <div class="alert alert-info" v-if="show">This is some info</div>
        </transition>

        <!-- Overriding default classes vue attaches  -->
        <transition appear enter-active-class="animated bounce" leave-active-class="animated shake">
          <div class="alert alert-info" v-if="show">This is some info</div>
        </transition>

        <!-- 
          We use key since vue doesn't know the difference between elements whic is neccessary to attach classes
          and only swaps the contents instead of animating.
          Mode: 
            • out-in: Let the old element animate out and only then animate the new one
        -->
        <transition :name="alertAnimation" mode="out-in">
          <div class="alert alert-info" v-if="show" key="info">This is some info</div>
          <div class="alert alert-warning" v-else key="warning">This is some warning</div>
        </transition>
        <hr />
        <button class="btn btn-primary" @click="load = !load">Load / Remove element</button>
        <br />
        <br />
        <!-- 
          To tell Vue that we don't have css classes attached to the elemnet
          we set css prop to false
        -->
        <transition
          @before-enter="beforeEnter"
          @enter="enter"
          @after-enter="afterEnter"
          @enter-cancelled="enterCancelled"
          @before-leave="beforeLeave"
          @leave="leave"
          @after-leave="afterLeave"
          @leave-cancelled="leaveCancelled"
          :css="false"
        >
          <div style="width: 300px; height: 100px;background-color: lightgreen;" v-if="load"></div>
        </transition>

        <hr />
        <button
          class="btn btn-primary"
          @click="selectedComponent == 'app-success-alert' ? selectedComponent = 'app-danger-alert' : selectedComponent = 'app-success-alert'"
        >Toggle</button>
        <br />
        <br />
        <transition name="fade" mode="out-in">
          <component :is="selectedComponent"></component>
        </transition>
        <hr />
        <button class="btn btn-primary" @click="addItem">Add item</button>
        <br />
        <br />
        <!-- 
          Transition is not rendered in the DOM
          but transition-group is. By default it 
          will be a span but you can change it by
          <transiton-group tag="TAG"></transiton-group>
        -->
        <ul class="list-group">
          <transition-group name="slide">
            <!--
               Key is important for animation to correctly work 
               Vue uses it to differentiate elements it needs to
               animate
            -->
            <li
              style="cursor: pointer;"
              class="list-group-item"
              v-for="(number, index) in numbers"
              :key="number"
              @click="removeItem(index)"
            >{{ number }}</li>
          </transition-group>
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
import DangerAlert from "./DangerAlert";
import SuccessAlert from "./SuccessAlert";

export default {
  data() {
    return {
      show: false,
      load: true,
      alertAnimation: "fade",
      elementWidth: 100,
      selectedComponent: "app-success-alert",
      numbers: [1, 3, 5, 7, 8]
    };
  },
  components: {
    appDangerAlert: DangerAlert,
    appSuccessAlert: SuccessAlert
  },
  methods: {
    beforeEnter(el) {
      console.log("beforeEnter");
      this.elementWidth = 100;
      el.style.width = this.elementWidth + "px";
    },
    enter(el, done) {
      console.log("enter");
      // Tells Vue that this animation is finished when in css it is derived from animation's time
      // ! done() is neccessary to call when you don't have any css attached to your element
      let round = 1;
      const vm = this;
      const interval = setInterval(function() {
        el.style.width = vm.elementWidth + round * 10 + "px";
        round++;
        if (round > 20) {
          clearInterval(interval);
          done();
        }
      }, 20);
    },
    afterEnter(el) {
      console.log("afterEnter");
    },
    enterCancelled(el) {
      console.log("enterCancelled");
    },
    beforeLeave(el) {
      console.log("beforeLeave");
      this.elementWidth = 300;
      el.style.width = this.elementWidth + "px";
    },
    leave(el, done) {
      console.log("leave");
      let round = 1;
      const vm = this;
      const interval = setInterval(function() {
        el.style.width = vm.elementWidth - round * 10 + "px";
        round++;
        if (round > 20) {
          clearInterval(interval);
          done();
        }
      }, 20);
    },
    afterLeave() {
      console.log("afterLeave");
    },
    leaveCancelled(el) {
      console.log("leaveCancelled");
    },
    addItem() {
      const pos = Math.floor(Math.random() * this.numbers.length);
      this.numbers.splice(pos, 0, this.numbers.length + 1);
    },
    removeItem(index) {
      this.numbers.splice(index, 1);
    }
  }
};
</script>

<style scoped>
.fade-enter {
  opacity: 0;
}

.fade-enter-active {
  transition: opacity 1s;
}

.fade-leave {
  /* opacity: 1; */
}

.fade-leave-active {
  transition: opacity 1s;
  opacity: 0;
}

.slide-enter {
  /* transform: translateY(20px) */
  /* Mixing transition and animation */
  opacity: 0;
}

.slide-enter-active {
  animation: slide-in 1s ease-out forwards;
  transition: opacity 0.5s;
}

.slide-leave {
}

.slide-leave-active {
  animation: slide-out 1s ease-out forwards;
  transition: opacity 3s;
  opacity: 0;
  /* To smoothly remove elements from the list. */
  position: absolute;
}

/* This class is attached to elements being moved */
.slide-move {
  transition: transform 1s;
}

@keyframes slide-in {
  from {
    transform: translateY(20px);
  }
  to {
    transform: translateY(0);
  }
}

@keyframes slide-out {
  from {
    transform: translateY(0);
  }
  to {
    transform: translateY(20px);
  }
}
</style>
