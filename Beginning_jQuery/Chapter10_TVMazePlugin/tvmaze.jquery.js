(function ($) {
    $.tvmaze = {
        getEpisode(showId, callback) {
            $.ajax({
                url: 'http://api.tvmaze.com/shows/' + showId + '/episodes'
            }).done(callback);
        },
        getShow(showName, callback) {
            $.ajax({
                url: 'http://api.tvmaze.com/search/shows/?q=' + showName
            }).done(callback);
        }
    }
})(jQuery)