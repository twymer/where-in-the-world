$(function () {
  var map = L.map('map').setView([51.505, -0.09], 3);

  L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png').addTo(map);

  var oms = new OverlappingMarkerSpiderfier(map);

  $(".checkin").each(function () {
    var imageIcon = L.icon({
      iconUrl: $(this).data('icon-url'),
      iconSize: [30, 30],
      iconAnchor: [15, 15],
    });

    if ($(this).data('lat') && $(this).data('lng')) {
      var marker = L.marker(
        [$(this).data('lat'), $(this).data('lng')],
        {icon: imageIcon}
      )
      marker.addTo(map);
      oms.addMarker(marker);
    }
  });
});

