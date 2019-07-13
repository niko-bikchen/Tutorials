$(function () {
    $('#submitButton').on('click', getShowName);

    function getShowName(evt) {
        evt.preventDefault();

        if ($('#showInput')[0].value.length > 0) {
            let searchValue = $('#showInput')[0].value;

            $.tvmaze.getShow(searchValue, (results) => {
                displayShowResults(results[0].show);
            });
        }
    }

    function displayShowResults(results) {
        $('#tableBody').html('<td id="episodeName" data-episodeid="' + results.id + '">'
            + result.name + '</td>' + '<td>'
            + checkNetwork(results.network) + '</td>'
            + '<td>' + results.type + '</td>'
            + '<td> <img class="image-border" src=" '
            + results.image.medium + '"> </td>');
        $('#episodeInfo tr').remove();
        $('#episodeName').on('click', (event) => {
            getEpisodes(event.target.dataset.episodeid);
        });
    }

    function getEpisodes(episodeID) {
        $().tvmaze.getEpisodes(episodeID, function (results) {
            for (var I = 0; I < results.length; i++) {
                $('#episodeInfo').append('<tr> <td>'
                    + results[i].airdate + '</td> <td>'
                    + results[i].name + '</td> <td>'
                    + results[i].number + '</td> <td>'
                    + results[i].season + '</td> <td>'
                    + results[i].runtime + '</td> <td>'
                    + results[i].summary + '<td>'
                    + '</tr>')
            }
        });
    }

    function checkNetwork(networkName) {
        if (networkName != null) {
            return networkName.name;
        } else {
            return 'Not Listed';
        }
    }
});