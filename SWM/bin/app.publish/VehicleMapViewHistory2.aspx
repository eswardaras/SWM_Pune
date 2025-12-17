<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="VehicleMapViewHistory2.aspx.cs" Inherits="SWM.VehicleMapViewHistory2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
       <head>
        <link href="css/styles.css" rel="stylesheet" />
        <title></title>
        <%-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.7.1/leaflet.css" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.7.1/leaflet.js"></script>--%>

        <link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css" />
        <script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
`

    </head>
    <div class="map-wrapper">
        <div class="heading">
            <i class="fa-solid fa-location-dot"></i>
            <span></span>
        </div>
     <div id="map"></div>
    </div>
<%--    <script>
        //Image
        function showPopup() {
            $('#popup').modal('show');
        }
        //Map
        function showPopupmap(vehicleName, latitude, longitude) {
            // Initialize the map
            var map = L.map('map').setView([latitude, longitude], 12);

            // Add a tile layer (e.g., OpenStreetMap)
            L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                attribution: 'Map data © OpenStreetMap contributors',
            }).addTo(map);

            // Create a marker
            var marker = L.marker([latitude, longitude]).addTo(map);

            // Create a popup
            marker.bindPopup("<b>" + vehicleName + "</b>").openPopup();

            // Create a LatLngBounds object with the marker's coordinates
            var markerBounds = L.latLngBounds([marker.getLatLng()]);

            // Fit the map bounds to include the marker
            map.fitBounds(markerBounds);

            // Pan the map towards the right
            //var panAmount = -1000; // Adjust the pan amount as needed
            //map.panBy([panAmount, 0], { animate: false });
            $('#popupmap').modal('show');

        }

    </script>--%>

    <script>
        var map;
        // Function to initialize the map
        function initMap(lat, lon) {
            // Specify the latitude and longitude of the map's center
            var center = [lat, lon];

            // Create a map object and specify the DOM element for display
            map = L.map('map').setView(center, 10);

            // Add the OpenStreetMap tile layer
            L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors',
                maxZoom: 18,
            }).addTo(map);

            // Specify the latitude and longitude of the circle's center
            var circleCenter = [lat, lon];

            // Specify the radius in meters
            var radius = 1000;

            // Create a circle marker
            L.circle(circleCenter, {
                color: 'red',
                fillColor: '#f03',
                fillOpacity: 0.3,
                radius: radius
            }).addTo(map);

            var latLngList = <%= GetLatLngListAsJavaScriptArray() %>;

            // Create a polyline to connect the points in the latLngList
            var polyline = L.polyline(latLngList, { color: 'red' }).addTo(map);

            // Fit the map bounds to the polyline
            map.fitBounds(polyline.getBounds());

            var jsonData = '<%= GetDataAsJson() %>';
            var data = JSON.parse(jsonData);

            var markerf;
            for (var i = 0; i < data.length; i++) {
                var lat = data[i].sLat;
                var lon = data[i].sLong;
                var Status = data[i].Status;
                var expectedTime = data[i].AttendTime;
               // var markerColor = "Red";
                var Type = data[i].Type;
             
                var markerColor = data[i].Status == "Uncover" ? "red":"green ";
                //markerf = L.marker([lat, lon]).addTo(map);
                // Create a custom icon using divIcon with the appropriate color
                console.log(Type);
                //var dustbin ="Images/dustbin_1.png"
               //var customIcon = L.divIcon({
               //     iconUrl: dustbin,
               //     iconSize: [25, 41],
               //     iconAnchor: [12, 41],
               // });


                
                //var customIcon = L.divIcon({
                //    className: 'custom-icon',
                //    html: '<i style="color: ' + markerColor + ';" class="bi bi-geo-alt-fill"></i>',
                //    iconSize: [25, 41],
                //    iconAnchor: [12, 41],
                //});

                //markerf = L.marker([lat, lon], { icon: customIcon }).addTo(map);
                 var customIcon = L.divIcon({
          className: 'custom-icon',
          html: '<i style="color: ' + markerColor + ';" class="bi bi-geo-alt-fill"></i>',
          iconSize: [25, 41],
          iconAnchor: [12, 41],
        });
                markerf = L.marker([lat, lon], { icon: customIcon }).addTo(map);

                var popupContent = "Lattitude: " + lat + " Longitude: " + lon + "<br/>Status: " + Status + "<br/>Type: " + Type + "<br/>Attend Time: " + expectedTime;
                markerf.bindPopup(popupContent);
            }
        }

// Call the initMap function when the page has finished loading
        window.addEventListener('load', initMap);


        function addMarker(latitude, longitude, color) {
  // Create a marker with the specified latitude, longitude, and color
  var marker = L.marker([latitude, longitude], { icon: getMarkerIcon(color) }).addTo(map);
}

function getMarkerIcon(color) {
  // Define marker icons for different colors
  var iconOptions = {
    green: L.icon({
      iconUrl: 'green-marker-icon.png',
      iconSize: [25, 41],
      iconAnchor: [12, 41],
      popupAnchor: [1, -34]
    }),
    red: L.icon({
      iconUrl: 'red-marker-icon.png',
      iconSize: [25, 41],
      iconAnchor: [12, 41],
      popupAnchor: [1, -34]
    }),
    // Add more color options if needed
  };

  return iconOptions[color] || iconOptions['green']; // Default to green marker if color is not recognized
        }


    </script>

     <%--<script>
        function showPocketOnMap() {
            // Get the sequence of latitude and longitude from the code-behind and convert it to a JavaScript array
            var latLngList = <%= GetLatLngListAsJavaScriptArray() %>;

            // Create a map object and specify the DOM element for display
            var map = L.map('map').setView(latLngList[0], 10);

            // Add the OpenStreetMap tile layer
            L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors',
                maxZoom: 18
            }).addTo(map);

            // Create a polyline to connect the points in the latLngList
            var polyline = L.polyline(latLngList, { color: 'red' }).addTo(map);

            // Fit the map bounds to the polyline
            map.fitBounds(polyline.getBounds());
        }

        // Call the showPocketOnMap function when the page has finished loading
        //window.addEventListener('load', showPocketOnMap);
         window.addEventListener('load', initMap);
    </script>--%>
</asp:Content>
