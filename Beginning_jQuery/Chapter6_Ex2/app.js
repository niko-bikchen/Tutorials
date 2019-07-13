$(function () {
    $("h5").on("click", function () {
        alert("header");
        event.stopPropagation();
    });

    $("div").on("click", function () {
        alert("div");
    });
});