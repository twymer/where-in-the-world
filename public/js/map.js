$(function () {
  addCheckin = function (person) {
    if (person.marker) {
      person.marker.setLatLng(L.latLng(person.lat, person.lng));
    } else {
      var imageIcon = L.icon({
        iconUrl: person.icon_url,
        iconSize: [30, 30],
        iconAnchor: [15, 15],
      });

      if (person.lat && person.lng) {
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

  window.map = L.map('map').setView([51.505, -0.09], 3);
  L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png').addTo(window.map);
  window.oms = new OverlappingMarkerSpiderfier(window.map);

  _.each(window.people, function (person) {
    addCheckin(person);
  });
});

