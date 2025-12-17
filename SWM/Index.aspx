<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="SWM.Index" %>
  
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
       <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.7.1/leaflet.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.7.1/leaflet.js"></script>

</head>
<body>
    <form id="form1" runat="server">
        <div>
        <div>
    <asp:TextBox ID="txtInput" runat="server" />
    <asp:Button ID="btnHighlight" runat="server" Text="Highlight Area" OnClick="btnHighlight_Click" />
</div>
<div id="mapid" style="height: 500px;"></div>
        </div>
            <script>
            var map = L.map('mapid').setView([51.505, -0.09], 13);
            L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                attribution: 'Map data &copy; OpenStreetMap contributors'
            }).addTo(map);
            var polygon = L.polygon([[51.509, -0.08], [51.503, -0.06], [51.51, -0.047]]).addTo(map);
            polygon.setStyle({ fillColor: '#00FF00', fillOpacity: 0.7, color: 'black', weight: 2 });
        </script>
    </form>
</body>
</html>
