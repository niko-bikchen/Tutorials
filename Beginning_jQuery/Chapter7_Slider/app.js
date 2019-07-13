$(function () {
    var $sliderWrapper = $('#slider');
    var $sliderList = $('ul');
    var $sliderItems = $('li');
    var $buttons = $sliderWrapper.children('.button');

    $buttons.on("click", function slide() {
        var isPrevBtn = $(this).hasClass('prev');

        if ((isPrevBtn && isAtStart()) || (!isPrevBtn && isAtEnd())) {
            return;
        }

        animateSlider($(this).hasClass('prev') ? '+' : '-', 1000);
    });

    function animateSlider(direction, duration, callback) {
        $sliderList.stop(true, true).animate({
            'margin-left': direction + '=300px'
        }, duration, callback);
    }

    function isAtStart() {
        return parseInt($sliderList.css('margin-left'), 10) > -300;
    }

    function isAtEnd() {
        var imageWidth = $sliderItems.first().width();
        var imageQuantity = $sliderItems.length;

        return parseInt($sliderList.css('margin-left'), 10) < -(imageWidth * (imageQuantity - 2));
    }
});