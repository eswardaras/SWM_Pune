<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="VehicleMapViewHistory.aspx.cs" Inherits="SWM.VehicleMapViewHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <head>
        <link href="css/styles.css" rel="stylesheet" />
        <link href="css/AddRoute.css" rel="stylesheet" />
        <%--        <style>
            .start-icon {
                background-image: url('./Images/flag-icon.png');
            }
        </style>--%>
        <title></title>
        <!-- Leaftlet Links -->
        <link
            rel="stylesheet"
            href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"
            integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY="
            crossorigin="" />
        <script
            src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"
            integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo="
            crossorigin=""></script>
        <script src="js/Leaflet.Marker.SlideTo.js"></script>
        <!-- Leaftlet Links End -->
        <!-- Leaflet Map Full Screen Links -->
        <script src="js/leaflet.polylineDecorator.js"></script>
        <script src="https://api.mapbox.com/mapbox.js/plugins/leaflet-fullscreen/v1.0.1/Leaflet.fullscreen.min.js"></script>
        <link
            href="https://api.mapbox.com/mapbox.js/plugins/leaflet-fullscreen/v1.0.1/leaflet.fullscreen.css"
            rel="stylesheet" />
        <!-- Leaflet Map Full Screen Links End-->

    </head>
    <div class="map-wrapper">
        <div class="heading">
            <i class="fa-solid fa-location-dot"></i>
            <span>
                <asp:Label ID="lblHeading" runat="server"></asp:Label></span>
        </div>
        <div id="map"></div>
    </div>
    <script>
        var map11 = L.map("map").setView([18.523204, 73.852011], 12);
        var osm = L.tileLayer("https://{s}.tile.osm.org/{z}/{x}/{y}.png", {
            attribution:
                '&copy; <a href="https://osm.org/copyright">OpenStreetMap</a> contributors',
        }).addTo(map11);
        map11.addControl(new L.Control.Fullscreen());

        var bm = {
            "Base Map": osm,
        };
        var wayLayer = L.layerGroup();
        var markerLayer = L.layerGroup();
        var polylineLayer = L.layerGroup().addTo(map11);
        wayLayer.addTo(map11);
        markerLayer.addTo(map11);

        const wayI = "./Images/WayIcon.png";
        var degree = L.icon({
            iconUrl: wayI,
            iconSize: [20, 20],
            iconAnchor: [10, 10],
        });

        var overlays = {
            Route: wayLayer,
            marker: markerLayer,
        };

        var layerControl = L.control
            .layers(null, overlays, { collapsed: false })
            .addTo(map11);
        var controlElement = layerControl.getContainer();
        controlElement.style.fontSize = "10px";
        controlElement.style.backgroundColor = "#f1f1f1";
        controlElement.style.borderRadius = "5px";
        controlElement.style.padding = "10px";
        controlElement.style.margin = "10px";

        var gpsPoint;
        //Image
        function showPopup() {
            $('#popup').modal('show');
        }
        //Map

        function showMap(vehicleName, latitude, longitude)
        //initMap(latitude, longitude) 
        {
            // Initialize the map
            //var map = L.map('map').setView([latitude, longitude], 12);

            //// Add a tile layer (e.g., OpenStreetMap)
            //L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            //    attribution: 'Map data © OpenStreetMap contributors',
            //}).addTo(map);
            console.log('vehicleName', vehicleName);
            console.log('latitude', latitude);
            console.log('longitude', longitude);
            // Create a marker
            var marker = L.marker([latitude, longitude]).addTo(map11);

            // Create a popup
            marker.bindPopup("<b>" + vehicleName + "</b>").openPopup();

            // Create a LatLngBounds object with the marker's coordinates
            var markerBounds = L.latLngBounds([marker.getLatLng()]);

            // Fit the map bounds to include the marker
            map11.fitBounds(markerBounds);

            // $('#popupmap').modal('show');
        }

        function showMapmultiple(vehicleName, coordinates, DetailsJson, AttendTime, LogoJson, Status, AttendTime1, WaitTime, expectedtime) {
            console.log(vehicleName);
            console.log(coordinates);
            console.log(DetailsJson);
            console.log('attendTime', AttendTime);
            console.log(LogoJson);
            console.log(Status);
            console.log('attendTime1', AttendTime1);
            console.log(WaitTime);
            console.log(expectedtime);
            // Initialize the map
            //var map = L.map('map').setView(coordinates[0], 12);

            //// Add a tile layer (e.g., OpenStreetMap)
            //L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            //    attribution: 'Map data © OpenStreetMap contributors',
            //}).addTo(map);

            // Loop through the coordinates array
            for (var i = 0; i < coordinates.length; i++) {
                var coordinate = coordinates[i];
                //alert(AttendTime);
                if (LogoJson[i].toString().startsWith("V")) {
                    iconUrl1 = "Images/WayIcon.png";
                }
                else {
                    if (Status[i].toString().startsWith("U")) {
                        console.log("Status starts with 'N'");
                        iconUrl1 = "Images/Red_feeder.png";
                    }
                    else {
                        console.log("Else");
                        iconUrl1 = "Images/Blue_feeder.png";
                    }
                }
                //iconUrl = "../Images/Red_feeder.png";
                const IIcon = L.icon({
                    iconUrl: iconUrl1,
                    iconSize: [38, 38],
                    iconAnchor: [18, 18],
                    popupAnchor: [-3, -76],
                    // You can also customize other icon properties like shadowUrl, shadowSize, etc.
                });

                //const markeri = L.marker([lat, lon], { icon: IIcon });
                // Create a marker for each coordinate

                if (LogoJson[i].toString().startsWith("V")) {
                    var marker = L.marker(coordinate, { icon: IIcon }).addTo(wayLayer);
                    // Create a popup for the marker
                    marker.bindPopup("<b>Vehicle Number:-" + vehicleName[i] + " </br>AttendTime:-" + AttendTime1[i] + "</b>").openPopup();

                }
                else {
                    var marker = L.marker(coordinate, { icon: IIcon }).addTo(markerLayer);
                    // Create a popup for the marker
                    marker.bindPopup("<b>Feeder Name:-" + vehicleName[i] + "</br>Status:- " + Status[i] + " </br>AttendTime:-" + AttendTime1[i] + "</br>WaitTime:- " + WaitTime[i] + "</br>Expectedtime:- " + expectedtime[i] + "</b>").openPopup();

                }
            }

            // Create a LatLngBounds object with all marker coordinates
            var markerBounds = L.latLngBounds(coordinates);

            // Fit the map bounds to include all markers
            map11.fitBounds(markerBounds);

            // $('#popupmap').modal('show');
        }

        let map1;

        // function showMechanicalMapRoute(vehicleName, coordinates) {
        //    // Initialize the map
        //     if (!map) {
        //         map = L.map('map').setView(coordinates[0], 12);
        //     }
        //     console.log('map initiallized1');

        //    // Add a tile layer (e.g., OpenStreetMap)
        //    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        //        attribution: 'Map data © OpenStreetMap contributors',
        //    }).addTo(map);

        //    // Loop through the coordinates array
        //     for (var i = 0; i < coordinates.length; i++)
        //     {
        //         var coordinate = coordinates[i];
        //         console.log(coordinate);
        //         var marker = new L.Marker([coordinate[0], coordinate[1]]);
        //         marker.addTo(map);

        //         iconUrl1 = "Images/WayIcon.png";
        //        //alert(AttendTime);

        //        //if (LogoJson[i].toString().startsWith("V")) {
        //        //    iconUrl1 = "Images/WayIcon.png";
        //        //}
        //        //else {
        //        //    if (AttendTime[i].toString().startsWith("N")) {
        //        //        console.log("Status starts with 'N'");
        //        //        iconUrl1 = "Images/Red_feeder.png";
        //        //    }
        //        //    else {
        //        //        console.log("Else");
        //        //        iconUrl1 = "Images/Blue_feeder.png";
        //        //    }
        //        //}

        //        const IIcon = L.icon({
        //            iconUrl: iconUrl1,
        //            iconSize: [38, 38],
        //            iconAnchor: [18, 18],
        //            popupAnchor: [-3, -76],
        //            // You can also customize other icon properties like shadowUrl, shadowSize, etc.
        //        });

        //        //const markeri = L.marker([lat, lon], { icon: IIcon });
        //        // Create a marker for each coordinate

        //        //if (LogoJson[i].toString().startsWith("V")) {
        //        //    var marker = L.marker(coordinate, { icon: IIcon }).addTo(map);
        //        //    // Create a popup for the marker
        //        //    marker.bindPopup("<b>Vehicle Number:-" + vehicleName[i] + " </br>AttendTime:-" + AttendTime1[i] +  "</b>").openPopup();

        //        //          }
        //        //else {
        //        //    var marker = L.marker(coordinate, { icon: IIcon }).addTo(map);
        //        //    // Create a popup for the marker
        //        //    marker.bindPopup("<b>Feeder Name:-" + vehicleName[i] + "</br>Status:- " + Status[i] + " </br>AttendTime:-" + AttendTime1[i] + "</br>WaitTime:- " + WaitTime[i] + "</br>Expectedtime:- " + expectedtime[i] + "</b>").openPopup();

        //        //}
        //    }

        //    // Create a LatLngBounds object with all marker coordinates
        //    var markerBounds = L.latLngBounds(coordinates);

        //    // Fit the map bounds to include all markers
        //    map.fitBounds(markerBounds);

        //    // $('#popupmap').modal('show');
        //}

        function showMechanicalMapmultiple(vehicleName, coordinates, coordinatesroute) {
            // Loop through the coordinates array
            showPolylineOnMap(coordinatesroute);
            addGpsPoints(coordinates);
        }

        const addGpsPoints = (data) => {
            try {
                console.log(data);
                //for (const data of coordinates) {
                //    let marker = L.marker([data[0], data[1]]).addTo(markerLayer);
                //    marker.bindPopup(`Vehicle name: ${vehicleName}`);
                //}
                if (gpsPoint) {
                    map.removeLayer(gpsPoint);
                }
                const markerArray = [];
                for (const d of data) {
                    marker = L.marker([d[0], d[1]], {
                        icon: degree,
                    }).addTo(wayLayer);
                    marker.bindPopup(` Latitude: ${d[0]} <br> Longitude: ${d[1]}`);

                    markerArray.push(marker);
                }

                const bounds = L.latLngBounds(
                    markerArray.map((marker) => marker.getLatLng())
                );

                // Fit the map to the bounds
                map11.fitBounds(bounds);
            } catch (error) {
                console.error("Error fetching data:", error);
            }
        };

        var decorator;
        const showPolylineOnMap = (coordinates) => {
            wayLayer.clearLayers();
            markerLayer.clearLayers();

            var polyline = L.polyline(coordinates, { color: "red" }).addTo(wayLayer);
            polyline.addTo(map11);

            var bounds = polyline.getBounds();
            map11.flyToBounds(bounds, { duration: 2, easeLinearity: 0.25 });

            if (decorator) {
                map11.removeLayer(decorator);
            }
            decorator = L.polylineDecorator(polyline, {
                patterns: [
                    {
                        offset: 0,
                        symbol: L.Symbol.marker({
                            markerOptions: {
                                icon: L.divIcon({ className: "start-icon" }),
                                zIndexOffset: 1000,
                            },
                        }),
                    },
                    {
                        offset: "10%",
                        repeat: 50,
                        symbol: L.Symbol.arrowHead({
                            pixelSize: 20,
                            polygon: true,
                            pathOptions: { stroke: true, color: "#414181" },
                        }),
                    },
                ],
            }).addTo(map11);

            decorator.addTo(wayLayer);

            coordinates.forEach(function (coords, index) {
                if (index === 0) {
                    L.marker(coords, {
                        icon: L.divIcon({ className: "custom-start-marker" }),
                    }).addTo(wayLayer);
                } else {
                    L.marker(coords, {
                        icon: L.divIcon({ className: "custom-marker" }),
                    }).addTo(wayLayer);
                }
            });
        };


    </script>

    <script type="text/javascript">
        var map = null;
        var poly = [];
        var decorator;
        var line;
        var center = new L.LatLng(28.549948, 77.268241);
        var interval = 0;
        var markerlatlongforPolygon = [];

        //var map = new MapmyIndia.Map("map", {
        //    center: [19.0760, 72.8777],
        //    zoomControl: true,
        //    hybrid: true,
        //    search: true,
        //    location: true
        //});
        function DrawMap() {

            var offset = 0; //intial offset value
            var w = 14, h = 33;

            //Polyline css
            var linecss = {
                color: '#fd4000',
                weight: 3,
                opacity: 1
            };
            line = L.polyline(markerlatlongforPolygon, linecss).addTo(map); //add polyline on map

            decorator = L.polylineDecorator(line).addTo(map); //create a polyline decorator instance.

            //offset and repeat can be each defined as a number,in pixels,or in percentage of the line's length,as a string
            interval = window.setInterval(function () {
                decorator.setPatterns([{
                    offset: offset + '%', //Offset value for first pattern symbol,from the start point of the line. Default is 0.
                    repeat: 0, //repeat pattern at every x offset. 0 means no repeat.
                    //Symbol type.
                    symbol: L.Symbol.marker({
                        rotate: true, //move marker along the line. false value may cause the custom marker to shift away from a curved polyline. Default is false.
                        markerOptions: {
                            icon: L.icon({
                                iconUrl: '../images/car.png', // Image add in images folder
                                iconAnchor: [w / 2, h / 2], //Handles the marker anchor point. For a correct anchor point [ImageWidth/2,ImageHeight/2]
                                iconSize: [14, 33]
                            })
                        }
                    })
                }
                ]);
                if ((offset += 0.03) > 100) //Sets offset. Smaller the value smoother the movement.
                    offset = 0;
            }, 10);
            poly.push(line);
            poly.push(decorator);
            map.fitBounds(line.getBounds());
        }
        function Addboundries(Lat, Long) {
            // markerlatlongforPolygon.push({ "lat": Lat, "lng": Long, "clientname": Clientname });
            markerlatlongforPolygon.push(new L.LatLng(Lat, Long));
        }
        function ClearMap() {
            removePolyline();
            //var marker = L.marker(markerlatlongforPolygon[0]).removeTo(map);// 1st Marker
        }
        function Clearboundries() {
            // delete marker;
            markerlatlongforPolygon = new Array();
            poly = new Array();
        }
        var removePolyline = function () {
            //alert('call');
            var polylength = poly.length;
            if (polylength > 0) {
                for (var i = 0; i < polylength; i++) {
                    if (poly[i] !== undefined) {
                        map.removeLayer(poly[i]);
                    }
                }
                //map.removeTo();
                poly = new Array();
                window.clearInterval(interval);
            }
        }
    </script>
</asp:Content>
