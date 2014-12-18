$(function () {
  $('#checkin-button').click(function (e) {
    e.preventDefault();

    postData = {
      'email': $('#email-input').val(),
      'message': $('#location-input').val()
    }

    $.ajax({
      url: '/checkin',
      type: 'POST',
      data: postData,
      success: function(response) {
        var person = window.people[postData.email];
        data = JSON.parse(response);

        person.message = postData.message;
        person.lat = data.lat;
        person.lng = data.lng;

        addCheckin(person);
      }
    });
  });
});
