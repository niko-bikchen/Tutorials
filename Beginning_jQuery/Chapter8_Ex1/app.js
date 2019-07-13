$(function () {
    $.ajax({
        url: './sample.json',
        type: 'get',
        dataType: 'json'
    }).done(function (result) {
        console.log(result);
    }).fail(function (error) {
        console.log('Oops', error);
    });

    $.getJSON('./sample.json', function (data) {
        console.log(data);
    });
});