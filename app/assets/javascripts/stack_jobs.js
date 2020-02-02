$(document).ready(function() {

    var map = L.map('map', { zoomControl: false });

    L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
        attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(map);

    /* Create the GeoJSON objects */

    function onEachFeature(feature, layer) {
        var popupContent = "";
        var pubDate = new Date(Date.parse(feature.properties.date));

        if (feature.properties) {
        popupContent += "<a href='" + feature.properties.link + "' target='_blank'>" + feature.properties.name + "</a><br>";
        popupContent += "<strong>Company: </strong>" + feature.properties.company + "<br>";
      if (feature.properties.city){
        popupContent += "<strong>Location: </strong>" + feature.properties.city + "<br>";
      } else {
        popupContent += "<strong>Location: </strong>No office location listed<br>";
      }
        popupContent += "<strong>Posted: </strong>" + pubDate.toUTCString() + "<br>";
        popupContent += "<strong>Tags: </strong>"+ feature.properties.category.join(", ") + "<br>";
        }


        layer.bindPopup(popupContent);
    }

    var markers = L.markerClusterGroup({
        spiderfyDistanceMultiplier: 2,
        showCoverageOnHover: false,

    });

    var geoJsonLayer = L.geoJSON(geojson_jobs, {

        onEachFeature: onEachFeature,

        style: function (feature) {
            var today = new Date();
            var weekDate = new Date().setDate(today.getDate()-7);
            var pubDate = Date.parse(feature.properties.date);
            var old = pubDate < weekDate;
            if (old) {
                return {fillColor: "grey"};
           }
           return {fillColor: "blue"}
        },
        pointToLayer: function(feature, latlng) {
            return L.circleMarker(latlng, {
                radius: 10,
                fillColor: "#0080FF",
                color: "#000",
                weight: 1,
                opacity: 0.75,
                fillOpacity: 0.8
            });
        }

    })

    markers.addLayer(geoJsonLayer);
    map.addLayer(markers);
    $(document).ready(function(){
        console.log("ready");
        $(".advanced-option-toggle").on("click", function() {
        $(".advanced-search").toggleClass("hide");
        console.log("clicked");
        });
    });

    map.fitBounds(markers.getBounds());
    new L.Control.Zoom({position: 'bottomright' }).addTo(map);
});
