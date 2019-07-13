$(function () {
    var $theList = $('<ul />')

    for (let i = 0; i < 10; ++i) {
        $('<li />', {
            text: (i + 1)
        }).appendTo($theList);
    }

    $theList.appendTo('body');
});