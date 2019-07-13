(function ($) {
    $.fn.slider = function (options) {
        var defaults = {
            duration: 1000,
            animationDelay: 5000
        };
        var settings = $.extend({}, defaults, options);

        return this.each(function () {
            var $slider = $(this);
            var $sliderList = $slider.children("ul");
            var $sliderItems = $sliderList.children("li");
            var $allButtons = $slider.find(".button");
            var $buttons = {
                forward: $allButtons.filter(".forward"),
                back: $allButtons.filter(".back")
            };
            var imageWidth = $sliderItems.first().children("img").width();
            var endMargin = -($sliderItems.length - 1) * imageWidth;
            var totalImages = $sliderItems.length;
            var currentIndex = 1;
            var $index = $(".index");

            var timer = setTimeout(automaticSlide, settings.animationDelay);

            $allButtons.on("click", function (event) {
                resetTimer();
                var isBackButton = $(this).hasClass("back");
                triggerSlider((isBackButton ? "+" : "-"));
                event.preventDefault();
            });

            function animateSlider(direction, callback) {
                $sliderList.stop(true, true).animate({
                    "margin-left": direction + "=" + imageWidth
                }, settings.duration, function () {
                    var increment = (direction === "+" ? -1 : 1);
                    updateIndex(currentIndex + increment);
                    if (callback && typeof callback == "function") {
                        callback();
                    }
                });
            }

            function getLeftMargin() {
                return parseInt($sliderList.css("margin-left"), 10);
            }

            function isAtBeginning() {
                return getLeftMargin() >= 0;
            }

            function isAtEnd() {
                return getLeftMargin() <= endMargin;
            }

            function animateSliderToMargin(margin, callback) {
                $sliderList.stop(true, true).animate({
                    "margin-left": margin
                }, settings.duration, callback);
            }

            function updateIndex(newIndex) {
                currentIndex = newIndex;
                $index.text(currentIndex);
            }

            $(document.documentElement).on("keyup", function (event) {
                if (event.keyCode === 37) {
                    resetTimer();
                    triggerSlider('+');
                } else if (event.keyCode === 39) {
                    resetTimer();
                    triggerSlider('-');
                }
            });

            function triggerSlider(direction, callback) {
                var isBackButton = (direction === "+");
                if (!isBackButton && isAtEnd()) {
                    animateSliderToMargin(0, callback);
                    updateIndex(1);
                } else if (isBackButton && isAtBeginning()) {
                    animateSliderToMargin(endMargin, callback);
                    updateIndex(totalImages);
                } else {
                    animateSlider(direction, callback);
                }
            }

            function automaticSlide() {
                setTimeout(function () {
                    triggerSlider("-", function () {
                        automaticSlide();
                    });
                }, settings.animationDelay);
            }

            function resetTimer() {
                if (timer) {
                    clearTimeout(timer);
                }
                timer = setTimeout(automaticSlide, 30000);
            }
        });
    }
})(jQuery);