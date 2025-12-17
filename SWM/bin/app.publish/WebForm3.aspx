<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="WebForm3.aspx.cs" Inherits="SWM.WebForm3" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <head>
        <%--  <link rel="stylesheet" href="" />leaflet.css--%>
        <link rel="stylesheet" href="https://unpkg.com/leaflet@1.3.1/dist/leaflet.css" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.3.1/leaflet.js"></script>
        <script src="https://unpkg.com/leaflet.vectorgrid@latest/dist/Leaflet.VectorGrid.bundled.js"></script>
        <!--script src="https://getbounds.com/apps-plugins/vectorgrid/leaflet-vector-grid-bundled-working.js"></script-->
        <link href="Content/leaflet.css" rel="stylesheet" />
        <%--<script src="leaflet.js"></script>--%>
        <script src="Scripts/leaflet-0.7.3.js"></script>
    </head>
    <div id="map"></div>
    <script type="text/javascript">
        var myMap = L.map('map').setView([51.505, -0.09], 13);
        var marker = L.marker([51.5, -0.09]).addTo(myMap);
    </script>
</asp:Content>


