<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CWPocketMap_Mobile.aspx.cs" Inherits="SWM.CWPocketMap_Mobile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="urf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link
        rel="stylesheet"
        href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"
        integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY="
        crossorigin="" />
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
        rel="stylesheet"
        integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM"
        crossorigin="anonymous" />
    <%--<link rel="stylesheet" href="icon.css" />--%>
    <%--<link rel="stylesheet" href="static/css/sweeperAttendance.css" />--%>
    <link href="CW%20POCKET/static/css/sweeperAttendance.css" rel="stylesheet" />
    <style>
        #map {
            width: 100%;
            height: 90vh;
        }
    </style>
    <script type="text/javascript">
        var commonApi = '<%= ConfigurationManager.AppSettings["CommonApiUrl"]%>';
        var zoneApi = '<%= ConfigurationManager.AppSettings["ZoneApiUrl"]%>';
        var wardApi = '<%= ConfigurationManager.AppSettings["WardApiUrl"]%>';
        var kothiApi = '<%= ConfigurationManager.AppSettings["KothiApiUrl"]%>';
        var routeApi = '<%= ConfigurationManager.AppSettings["RouteApiUrl"]%>';
    </script>
    <script>
        let loginId;
        const currentURL = window.location.href;

        function getQueryParam(url, param) {
            const queryString = url.split('?')[1];
            if (!queryString) {
                return null;
            }
            const params = new URLSearchParams(queryString);
            return params.get(param);
        }

        const loginIdParam = getQueryParam(currentURL, 'loginId');

        if (loginIdParam) {
            try {
                const trimmedLoginId = loginIdParam.substring(2, loginIdParam.length - 2);
                loginId = trimmedLoginId;
                console.log(loginId);
            } catch (error) {
                console.error("Error occurred while trimming loginId:", error);
                // Redirect to the login page
                window.location.href = "Login.aspx";
            }
        } else {
            console.log("loginId parameter not found in the URL.");
        }
    </script>
    <title>CW Pocket Map</title>
</head>
<body>
    <section class="filters-section">
        <div class="filters-container map-filters">
            <div class="title dropdown-btn">
                <h3>CW Pockets Map</h3>
            </div>
        </div>
    </section>
    <section>
        <div class="p-20">
            <div
                class="folium-map map-wrapper litter-bin map-container position-relative"
                id="map_04c15fbd253ae0e683d735ffb0a6a841">
                <div id="map"></div>
            </div>
        </div>
    </section>

    <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
        crossorigin="anonymous"></script>

    <script
        src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"
        integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo="
        crossorigin=""></script>

    <%--<script src="static/cwpockets.js"></script>--%>
    <script src="CW%20POCKET/static/cwpockets.js"></script>
    <script>
        var map = L.map("map").setView([18.5260137, 73.865075], 12);

        var osm = L.tileLayer("https://tile.openstreetmap.org/{z}/{x}/{y}.png", {
            attribution:
                '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
        });
        osm.addTo(map);

        var bm = {
            osm: osm,
        };

        var cw = L.geoJSON(cwJSON, {
            style: function (feature) {
                return {
                    fillColor: "blue",
                    fillOpacity: 0.1,
                    weight: 1,
                    color: "blue",
                    opacity: 0.4,
                };
            },
            onEachFeature: function (feature, layer) {
                if (feature.properties && feature.properties.Pocket_Nam) {
                    layer.bindPopup(feature.properties.Pocket_Nam);
                }
            },
        }).addTo(map);

        var overlays = {
            "CW Pockets": cw,
        };

        L.control.layers(bm, overlays, { collapsed: false }).addTo(map);
    </script>
</body>
</html>
