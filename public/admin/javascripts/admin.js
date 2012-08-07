$(function () {
	$('.logout').on('click', function (event) {
    event.preventDefault();
    var $link = $(this);
    $.ajax({
      type: 'DELETE',
      url: $link.attr('href'),
      success: function (response) {
        window.location.reload('/admin');
      }
    });
  });
});