$(document).ready(function () {
    function handleSearch() {
        jQuery('.search').click(function () {
            if (jQuery('.search-btn').hasClass('glyphicon-search')) {
                jQuery('.search-open').fadeIn(500);
                jQuery('.search-btn').removeClass('glyphicon-search');
                jQuery('.search-btn').addClass('glyphicon-remove');
            } else {
                jQuery('.search-open').fadeOut(500);
                jQuery('.search-btn').addClass('glyphicon-search');
                jQuery('.search-btn').removeClass('glyphicon-remove');
            }
        });
        $('.search-go').click(function () {
            var root = location.protocol + '//' + location.host;
            window.location.href = root + "/Issues/IssueSearch.aspx?q=" + encodeURIComponent($('.search-box').val());
        });
    }
    handleSearch();
});