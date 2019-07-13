$(function () {
    $('p').filter(function onlyStrong() {
        return $(this).children('strong').length > 0;
    }).css('background', 'red');
});