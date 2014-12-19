$(function () {
  // Use this to add a checkin for a person from a list of
  // people
  addCheckin = function (person) {
    if(person.marker) {
      person.marker.setLatLng(L.latLng(person.lat, person.lng));
    } else {
      var imageIcon = L.icon({
        iconUrl: person.icon_url,
        iconSize: [30, 30],
        iconAnchor: [15, 15],
      });

      if(person.lat && person.lng) {
        var marker = L.marker(
          [person.lat, person.lng],
          {icon: imageIcon}
        )
        marker.addTo(window.map);
        window.oms.addMarker(marker);
        person.marker = marker;
      }
    }
  }

  // Use this to add a checkin for the map on a users
  // profile page
  var addProfileCheckin = function (checkin) {
    console.log(checkin);
    L.marker([checkin.lat, checkin.lng]).addTo(window.map);
  }

  window.map = L.map('map').setView([51.505, -0.09], 3);
  L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png').addTo(window.map);
  window.oms = new OverlappingMarkerSpiderfier(window.map);

  if(window.people) {
    _.each(window.people, function (person) {
      addCheckin(person);
    });
  } else if(window.checkins) {
    _.each(window.checkins, function (checkin) {
      addProfileCheckin(checkin);
    });
  }
});

