$(function () {
  function addCheckin(person, map) {
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
      marker.addTo(map);
      oms.addMarker(marker);
    }
  }

  var map = L.map('map').setView([51.505, -0.09], 3);
  L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png').addTo(map);
  var oms = new OverlappingMarkerSpiderfier(map);

  _.each(window.people, function (person) {
    addCheckin(person, map);
  });
});

