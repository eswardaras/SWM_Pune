<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Livetracking.aspx.cs" Inherits="SWM.Livetracking" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <head>
        <link href="css/styles.css" rel="stylesheet" />
        <title></title>
        <%-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.7.1/leaflet.css" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.7.1/leaflet.js"></script>--%>

        <link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css" />
        <script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"></script>

    </head>
    <div class="map-wrapper">
        <div class="heading">
            <i class="fa-solid fa-location-dot"></i>
            <span>Vehicle Live Tracking</span>
        </div>
        <div class="map-controls">
            <div class="dropdown-wrapper">

                <div class="control">
                    <p>Zone</p>
                    <asp:DropDownList ID="ddlZone" runat="server" OnSelectedIndexChanged="ddlZone_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList>
                </div>

                <div class="control">
                    <p>Ward</p>
                    <asp:DropDownList ID="ddlWard" runat="server" OnSelectedIndexChanged="ddlWard_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList>
                </div>

                <div class="control">
                    <p>Vehicle</p>
                    <asp:DropDownList ID="ddlVehicle" runat="server"></asp:DropDownList>
                </div>

            </div>
            <div class="control">
                <%-- <asp:TextBox ID="txtInput" runat="server" />
            <asp:Button ID="Button1" runat="server" Text="Highlight Area" OnClick="Button1_Click" />--%>
                <p>Click Here</p>
                <div class="btn-wrapper">
                    <asp:Button runat="server" Text="Current Location" ID="btnCurrentlocation" OnClick="btnCurrentlocation_Click" />
                    <asp:Button runat="server" Text="Start Live Tracking" ID="btnlivetracking" OnClientClick="addLiveTracking();" OnClick="btnlivetracking_Click2" />
                </div>
            </div>
        </div>
        <div id="map"></div>
    </div>

    <script>
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

    </script>

</asp:Content>
