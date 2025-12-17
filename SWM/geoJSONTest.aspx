<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="geoJSONTest.aspx.cs" Inherits="SWM.geoJSONTest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <head>
        <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
    </head>
    <body>
        <script src="js/axios.js"></script>
        <script>
            const host = "localhost";
            const port = "57324";
            const file = `http://${host}:${port}/service/geofence.geojson`;

            const getGeofenceData = async () => {
                try {
                    const { data } = await axios.get(file);

                    console.log(data);
                } catch (error) {
                    console.error("Error fetching data:", error);
                }
            };

            getGeofenceData();
        </script>
    </body>
</asp:Content>
