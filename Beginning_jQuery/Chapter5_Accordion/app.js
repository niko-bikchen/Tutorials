$(function () {
    var $headings = $('h2');
    var $paragraphs = $('p');
    var $accordion = $("#accordion");

    $paragraphs.not(':first').hide();

    $accordion.on('click', 'h2', function () {
        var $current = $(this);
        var $currentPara = $current.next();

        if (!$currentPara.is(':visible')) {
            $currentPara.trigger('showParagraph');
        }
    });

    $accordion.on('showParagraph', 'p', function () {
        animateAccordion(this, 'normal', 'easeInBack');
    });

    function animateAccordion(elem, duration, easing) {
        $paragraphs.stop(true, true).slideUp(duration, easing);
        $(elem).stop(true, true).slideDown(duration, easing);
    }
});