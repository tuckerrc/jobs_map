var stackJobs = {};

stackJobs.leaflet = function () {
    var map, markers, geojsonLayer;

    var init = function() {
        map = L.map('map', { zoomControl: false });

        markers = L.markerClusterGroup({
            spiderfyDistanceMultiplier: 2,
            showCoverageOnHover: false,

        });

        initializeEventListeners();

        L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
            attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
        }).addTo(map);

        map.addLayer(markers);

        new L.Control.Zoom({position: 'bottomright' }).addTo(map);
    };

    var initializeEventListeners = function() {
        $(".advanced-option-toggle").on("click", function() {
            $(".advanced-search").toggleClass("hide");
        });
    };

    var onEachFeature = function(feature, layer) {
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
    };

    var updateGeoJsonLayer = function(geojson) {
        if (geojsonLayer !== undefined) {
            markers.removeLayer(geojsonLayer);
        }

        geojsonLayer = L.geoJSON(geojson, {

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
        });

        markers.addLayer(geojsonLayer);
        map.addLayer(markers);
        map.fitBounds(markers.getBounds());
    };

    var publicObjects = {
        init: init,
        updateGeoJsonLayer, updateGeoJsonLayer,
    }
    return publicObjects;
}();
