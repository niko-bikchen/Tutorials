$(function () {
    $('h5').on('click', function(){
        $('div').trigger('bgchange');
    });

    $('div').on('bgchange', function(){
        $(this).css('background', 'green');
    });
});