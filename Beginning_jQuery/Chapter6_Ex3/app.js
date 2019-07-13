$(function () {
    $('a').on('click', function () {
        $(this).parent().css('background', 'blue');

        event.preventDefault();
    });
});