$(function () {
    // $('#box').slideUp(2000);

    var $box = $('#box');

    for (let i = 0; i < 10; ++i) {
        $box.slideToggle(2000);
    }
});