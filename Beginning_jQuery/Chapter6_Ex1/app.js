$(function () {
    $('body').on('click', 'p', function handleClick_p(){
        alert("Hello World!");
        $(this).css({
            'background-color': 'green',
            'color': 'white'
        });
    });

    $('<p />', {
        text: "Paragrapg 6"
    }).appendTo('body');
    
    $('<p />', {
        text: "Paragrapg 7"
    }).appendTo('body');

    $('<p />', {
        text: "Paragrapg 8"
    }).appendTo('body');
});