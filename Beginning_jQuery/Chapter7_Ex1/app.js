$(function () {
    $('div')
        .animate({ 'height': 300 })
        .fadeOut()
        .show(500)
        .animate({ 'width': 100 })
        .css('background', 'green');
});