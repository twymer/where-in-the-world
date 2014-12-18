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

  $('#location-button').click(function (e) {
    e.preventDefault();

    function updateFromGeoLocation(position) {
      coords = position.coords.latitude.toString();
      coords += ', ';
      coords += position.coords.longitude.toString();
      $('#location-input').val(coords);
    }

    if (Modernizr.geolocation) {
      navigator.geolocation.getCurrentPosition(updateFromGeoLocation);
    } else {
      alert("Aw, bummer, your browser isn't new enough to get geo location or you have it disabled or I don't know something broke, okay? You can just type it in instead.");
    }
  });
});
