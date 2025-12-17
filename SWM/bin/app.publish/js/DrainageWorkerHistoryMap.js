const zoneDropdown = document.getElementById("zoneDropdown");
const wardDropdown = document.getElementById("wardDropdown");
const kothiDropdown = document.getElementById("kothiDropdown");
const drainageWorkerDropdown = document.getElementById(
    "drainageWorkerDropdown"
);
const startDate = document.getElementById("startDate");
const endDate = document.getElementById("endDate");

const btnShowRoute = document.getElementById("btnShowRoute");
const btnPlay = document.getElementById("btnPlay");
const btnRefresh = document.getElementById("btnRefresh");

var isPlaying = false;

// Map

let config = {
    minZoom: 8,
    maxZoom: 24,
    fullscreenControl: true,
};

var map = L.map("map", config).setView([18.523204, 73.852011], 13);
var marker, marker1;

const sweeperI = `./Images/drainageWorker.png`;
const degreeIcon = `./Images/degree.png`;
const G_dot = `./Images/dotgreen.png`;
const R_dot = `./Images/dotred.png`;
const B_dot = `./Images/dot.png`;

var osm = L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright"></a>',
}).addTo(map);

var sweepIcon = L.icon({
    iconUrl: sweeperI,
    iconSize: [50, 40],
    iconAnchor: [20, 20],
});
var degree = L.icon({
    iconUrl: degreeIcon,
    iconSize: [32, 32],
    iconAnchor: [16, 16],
});
var greendot = L.icon({
    iconUrl: G_dot,
    iconSize: [32, 32],
    iconAnchor: [16, 16],
});
var reddot = L.icon({
    iconUrl: R_dot,
    iconSize: [32, 32],
    iconAnchor: [16, 16],
});
var bluedot = L.icon({
    iconUrl: B_dot,
    iconSize: [32, 32],
    iconAnchor: [16, 16],
});

var dotMarkerLayer = L.layerGroup();
var routeLayer = L.layerGroup();
var Kothilayer = L.layerGroup();
var Drainagelayer = L.layerGroup();
var linelayer = L.layerGroup();

var bm = {
    "Base Map": osm,
};

var overlays = {
    "Drainage Worker Location": dotMarkerLayer,
    "Drainage Points": Drainagelayer,
};

var layerControl = L.control
    .layers(bm, overlays, { collapsed: false })
    .addTo(map);

var controlElement = layerControl.getContainer();
controlElement.style.fontSize = "12px";
controlElement.style.backgroundColor = "#f1f1f1";
controlElement.style.borderRadius = "5px";
controlElement.style.padding = "10px";

dotMarkerLayer.addTo(map);
routeLayer.addTo(map);
Kothilayer.addTo(map);
Drainagelayer.addTo(map);
linelayer.addTo(map);

var lst_lat, lst_lon, featureGroup;
var markerGroup = L.featureGroup().addTo(map);
var timeoutIds = []; // Array to store the timeout IDs for each marker
var markersweep;
var SWEEPERPosition = [];

// const initializeMap = () => {};

const kothi = async (Fk_VehicleId) => {
    console.log("kothi", Fk_VehicleId);
    try {
        const kothiData = {
            storedProcedureName: "GetKothiDetails",
            parameters: JSON.stringify({
                Mode: 1,
                Fk_VehicleId: Fk_VehicleId,
            }),
        };
        const response = await axios.post(commonApi, kothiData);

        if (!response.data.CommonMethodResult.CommonReportMasterList) {
            Swal.fire({
                position: "top-end",
                icon: "info",
                title: "Kothi not found!",
                showConfirmButton: false,
                timer: 1500,
            });
            return;
        }

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;
        const data = JSON.parse(commonReportMasterList);

        // Access latitude and longitude from parsed data
        const kLatitude = data[0].kLatitude;
        const kLongitude = data[0].kLongitude;
        console.log("Kothi Latitude:", kLatitude);
        console.log("Kothi Longitude:", kLongitude);

        // Create a marker at the kothi location and add it to the map
        const kothiMarker = L.marker([kLatitude, kLongitude]);
        // Optionally, you can add a popup to the marker with the kothi name
        const kothiName = data[0].KothiName;

        // Create a circle with a 15-meter radius around the marker
        const bufferCircle = L.circle([kLatitude, kLongitude], {
            color: "red",
            fillColor: "red",
            fillOpacity: 0.3,
            radius: 15, // Radius in meters
        }).addTo(Kothilayer); // Add the buffer circle directly to the map
        bufferCircle.bindPopup(kothiName);

        var bounds = bufferCircle.getBounds();
        map.flyToBounds(bounds, { duration: 2, easeLinearity: 0.25 });
    } catch (error) {
        console.error("Error fetching kothi data:", error);
    }
};

const drainagePoint = async (drainageWorkerName) => {
    try {
        const kothiData = {
            storedProcedureName: "sp_drainageWorkerDetails",
            parameters: JSON.stringify({
                mode: 2,
            }),
        };
        const response = await axios.post(commonApi, kothiData);

        if (!response.data.CommonMethodResult.CommonReportMasterList) {
            Swal.fire({
                position: "top-end",
                icon: "info",
                title: "Kothi not found!",
                showConfirmButton: false,
                timer: 1500,
            });
            return;
        }

        Drainagelayer.clearLayers();
        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;
        const data = JSON.parse(commonReportMasterList);

        console.log("drainage worker points", data);

        for (const d of data) {
            const kLatitude = d.latitude;
            const kLongitude = d.longitute;
            // Optionally, you can add a popup to the marker with the kothi name
            const drainageName = d.drainage_worker;

            // Create a circle with a 15-meter radius around the marker
            const bufferCircle = L.circle([kLatitude, kLongitude], {
                color: "blue",
                fillColor: "blue",
                fillOpacity: 0.3,
                radius: 10, // Radius in meters
            }).addTo(Drainagelayer); // Add the buffer circle directly to the map
            bufferCircle.bindPopup(drainageName);
        }
        //var bounds = bufferCircle.getBounds();
        //map.flyToBounds(bounds, { duration: 2, easeLinearity: 0.25 });
    } catch (error) {
        console.error("Error fetching kothi data:", error);
    }
};

const Show_Route_Polyline = async (routeId, routeName) => {
    console.log(routeId);
    try {
        const sweeperRequestData = {
            storedProcedureName: "proc_VehicleMapwithRoute_1",
            parameters: JSON.stringify({
                Mode: 28,
                Fk_accid: loginId,
                Fk_ZoneId: zoneDropdown.value,
                FK_WardId: wardDropdown.value,
                Fk_divisionid: routeId,
            }),
        };

        console.log("route id", sweeperRequestData);
        const response = await axios.post(commonApi, sweeperRequestData);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let data = JSON.parse(commonReportMasterList);
        // console.log("polyline Data", data);
        let coordinates = [];
        // console.log(dropdownData);
        for (const d of data) {
            let array = [];
            array.push(d.RouteLat);
            array.push(d.RouteLng);
            coordinates.push(array);
        }
        console.log(coordinates);
        showPolylineOnMap(coordinates, routeName);
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const showPolylineOnMap = (coordinates, routeName) => {
    var decorator;
    var polyline = L.polyline(coordinates, {
        color: "red",
        opacity: 0.5,
    }).addTo(routeLayer);

    polyline.bindPopup(routeName); // Bind the popup and open it immediately

    var bufferedPolylines = [];
    for (var i = 0; i < coordinates.length - 1; i++) {
        var startPoint = L.latLng(coordinates[i]);
        var endPoint = L.latLng(coordinates[i + 1]);
        var segmentPolyline = L.polyline([startPoint, endPoint]);

        var bufferedSegment = segmentPolyline.toGeoJSON().geometry;
        var buffered = turf.buffer(bufferedSegment, 5, { units: "meters" });

        var bufferedLayer = L.geoJSON(buffered);

        bufferedLayer.addTo(routeLayer);
        bufferedPolylines.push(bufferedLayer);

        // Ensure that clicks on the buffered layer also open the popup
        bufferedLayer.eachLayer(function (layer) {
            layer.bindPopup(routeName);
            layer.on("click", function (e) {
                polyline.openPopup(e.latlng);
            });
        });
    }

    var bounds = polyline.getBounds();
    map.flyToBounds(bounds, { duration: 2, easeLinearity: 0.25 });
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
                    pixelSize: 5,
                    polygon: true,
                    pathOptions: { stroke: true, color: "#414181" },
                }),
            },
        ],
    }).addTo(routeLayer);

    decorator.addTo(routeLayer);

    coordinates.forEach(function (coords, index) {
        if (index === 0) {
            L.marker(coords, {
                icon: L.divIcon({ className: "custom-start-marker" }),
            }).addTo(routeLayer);
        } else {
            L.marker(coords, {
                icon: L.divIcon({ className: "custom-marker" }),
            }).addTo(routeLayer);
        }
    });
};

const getRouteId = async () => {
    try {
        const requestData = {
            storedProcedureName: "proc_AssignRoute",
            parameters: JSON.stringify({
                mode: 8,
                VehicleId: drainageWorkerDropdown.value,
            }),
        };

        const response = await axios.post(commonApi, requestData);

        if (!response.data.CommonMethodResult.CommonReportMasterList) {
            Swal.fire({
                position: "top-end",
                icon: "info",
                title: "Route not found!",
                showConfirmButton: false,
                timer: 1500,
            });
            return;
        }

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let data = JSON.parse(commonReportMasterList);
        console.log("sweeper route id", data);

        if (data) {
            for (const d of data) {
                Show_Route_Polyline(d.RouteId, d.RouteName);
            }
            // Show_Route_Polyline(data[0].RouteId);
            //const Fk_VehicleId = sweeperDropdown.value; // Assuming sweeperDropdown contains the value of Fk_VehicleId
            //kothi(Fk_VehicleId);
        }
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

// function addMarkersWithDelay(data) {
//     var marker;
//     var markerPosition = [];

//     for (var i = 0; i < data.length; i++) {
//         var lat = data[i].latitude;
//         var lon = data[i].longitude;
//         var time = data[i].datetim;
//         var speed = data[i].speed;

//         console.log("speed" + speed);
//         var dotIcon = speed > 3 ? reddot : greendot;

//         marker1 = L.marker([lat, lon], { icon: dotIcon }).addTo(dotMarkerLayer);
//         marker1.bindPopup(`
//             <b>Latitude:</b> ${lat} <br>
//             <b>Longitude:</b> ${lon} <br>
//             <b>Time:</b> ${time} <br>
//             `);
//         markerPosition.push(marker);

//         var timeoutId = setTimeout(
//             function (latitude, longitude) {
//                 if (marker) {
//                     map.removeLayer(marker);
//                 }
//                 var newLatLng = new L.LatLng(latitude, longitude);
//                 marker = L.marker(newLatLng, { icon: sweepIcon });
//                 marker.addTo(markerGroup);
//                 map.panTo(newLatLng, { animate: true });
//                 var bounds = markerGroup.getBounds();
//                 var padding = [50, 50]; // Adjust the padding as needed
//                 map.fitBounds({ padding: padding, animate: true });

//                 console.log(
//                     "Your coordinate is: Lat: " + latitude + " Long: " + longitude
//                 );
//             },
//             i * 1000,
//             lat,
//             lon
//         );
//         timeoutIds.push(timeoutId); // Store the timeout ID in the array
//     }
// }

function addMarkersWithDelay(data) {
    console.log(data);
    var marker;
    var markerPosition = [];

    for (var i = 0; i < data.length; i++) {
        var lat = data[i].latitude;
        var lon = data[i].longitude;
        var time = data[i].datetim;
        var speed = data[i].speed;

        // console.log("speed" + speed);

        // Extract the hour from the time
        var date = new Date(time);
        var hour = date.getHours();

        var dotIcon;
        if (speed > 3) {
            dotIcon = reddot;
        } else {
            if (hour <= 10) {
                dotIcon = greendot;
            } else {
                dotIcon = bluedot;
            }
        }

        marker1 = L.marker([lat, lon], { icon: dotIcon }).addTo(dotMarkerLayer);
        marker1.bindPopup(`
            <b>Latitude:</b> ${lat} <br>
            <b>Longitude:</b> ${lon} <br>
            <b>Time:</b> ${time.split("T")[0]} ${time.split("T")[1]}<br>
            <b>Speed:</b> ${speed}<br>
        `);
        markerPosition.push(marker);

        var timeoutId = setTimeout(
            function (latitude, longitude) {
                if (marker) {
                    map.removeLayer(marker);
                }
                var newLatLng = new L.LatLng(latitude, longitude);
                marker = L.marker(newLatLng, { icon: sweepIcon });
                marker.addTo(markerGroup);
                map.panTo(newLatLng, { animate: true });
                var bounds = markerGroup.getBounds();
                var padding = [50, 50]; // Adjust the padding as needed
                map.fitBounds({ padding: padding, animate: true });

                console.log(
                    "Your coordinate is: Lat: " + latitude + " Long: " + longitude
                );
            },
            i * 1000,
            lat,
            lon
        );
        timeoutIds.push(timeoutId); // Store the timeout ID in the array
    }
}

// function addMarkersWithDelay(data) {
//     var sweeperMarker;
//     var markerPosition = [];
//     var timeoutIds = [];
//     var previousLatLng = null;

//     for (var i = 0; i < data.length; i++) {
//         (function(i) {
//             var lat = data[i].latitude;
//             var lon = data[i].longitude;
//             var time = data[i].datetim;
//             var speed = data[i].speed;

//             console.log("speed: " + speed);
//             var dotIcon = speed > 3 ? reddot : greendot;
//             var latLng = [lat, lon];

//             // Add markers with a delay
//             setTimeout(function() {
//                 var marker = L.marker(latLng, { icon: dotIcon }).addTo(dotMarkerLayer);
//                 marker.bindPopup(`
//                     <b>Latitude:</b> ${lat} <br>
//                     <b>Longitude:</b> ${lon} <br>
//                     <b>Time:</b> ${time} <br>
//                 `);
//                 markerPosition.push(marker);

//                 if (previousLatLng) {
//                     var polyline = L.polyline([previousLatLng, latLng], { color: 'blue' }).addTo(dotMarkerLayer);

//                     // Add arrowhead to the polyline
//                     var arrowHead = L.polylineDecorator(polyline, {
//                         patterns: [
//                             { offset: '100%', repeat: 0, symbol: L.Symbol.arrowHead({ pixelSize: 8, polygon: false, pathOptions: { color: 'red', stroke: true } }) }
//                         ]
//                     }).addTo(dotMarkerLayer);
//                 }
//                 previousLatLng = latLng;

//                 if (i === data.length - 1) {
//                     map.fitBounds(dotMarkerLayer.getBounds(), { padding: [50, 50], animate: true });
//                 }
//             }, i * 1000);

//             // Move sweeper icon with a delay
//             var timeoutId = setTimeout(function() {
//                 if (sweeperMarker) {
//                     map.removeLayer(sweeperMarker);
//                 }
//                 var newLatLng = new L.LatLng(lat, lon);
//                 sweeperMarker = L.marker(newLatLng, { icon: sweepIcon });
//                 sweeperMarker.addTo(markerGroup);
//                 map.panTo(newLatLng, { animate: true });

//                 // Adjust map bounds to include all markers
//                 var bounds = markerGroup.getBounds();
//                 var padding = [50, 50]; // Adjust the padding as needed
//                 map.fitBounds(bounds, { padding: padding, animate: true });

//                 console.log("Your coordinate is: Lat: " + lat + " Long: " + lon);
//             }, i * 1000);

//             timeoutIds.push(timeoutId); // Store the timeout ID in the array
//         })(i);
//     }
// }

const clearMarkers = () => {
    console.log("clear");
    markerGroup.clearLayers();
    timeoutIds.forEach(function (timeoutId) {
        clearTimeout(timeoutId); // Clear all timeouts
    });
    timeoutIds = []; // Clear the timeout IDs array
};

const populateZoneDropdown = async () => {
    try {
        const response = await axios.post(zoneApi, {
            mode: 11,
            vehicleId: 0,
            AccId: loginId,
        });

        const zoneMasterList = response.data.GetZoneResult.ZoneMasterList;

        for (const zone of zoneMasterList) {
            const option = document.createElement("option");
            option.value = zone.zoneid;
            option.text = zone.zonename;
            zoneDropdown.appendChild(option);
            zoneDropdown.fstdropdown.rebind();
        }
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const populateWardDropdown = async () => {
    try {
        wardDropdown.innerHTML = '<option value="0">Select Ward</option>';

        const response = await axios.post(wardApi, {
            mode: 12,
            vehicleId: 0,
            AccId: loginId,
            ZoneId: zoneDropdown.value,
        });

        const wardMasterList = response.data.GetWardResult.WardMasterList;

        for (const ward of wardMasterList) {
            const option = document.createElement("option");
            option.value = ward.PK_wardId;
            option.text = ward.wardName;
            wardDropdown.appendChild(option);
            wardDropdown.fstdropdown.rebind();
        }
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const populateKothiDropdown = async () => {
    try {
        kothiDropdown.innerHTML = '<option value="0">Select Kothi</option>';

        const response = await axios.post(kothiApi, {
            mode: 356,
            Fk_accid: 11401,
            Fk_ambcatId: 0,
            Fk_divisionid: 0,
            FK_VehicleID: loginId,
            Fk_ZoneId: zoneDropdown.value,
            FK_WardId: wardDropdown.value,
            Startdate: "",
            Enddate: "",
            Maxspeed: 0,
            Minspeed: 0,
            Fk_DistrictId: 0,
            Geoid: 0,
        });

        const kothiMasterList = response.data.GetKothiResult.KotiMasterList;

        for (const kothi of kothiMasterList) {
            const option = document.createElement("option");
            option.value = kothi.pk_kothiid;
            option.text = kothi.kothiname;
            kothiDropdown.appendChild(option);
            kothiDropdown.fstdropdown.rebind();
        }
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const populateSweeperDropdown = async () => {
    try {
        drainageWorkerDropdown.innerHTML =
            '<option value="0">Select Drainage Worker</option>';

        const sweeperRequestData = {
            storedProcedureName: "drainageworker_proc",
            parameters: JSON.stringify({
                mode: 3,
                ZoneId: zoneDropdown.value,
                WardId: wardDropdown.value,
            }),
        };
        console.log(sweeperRequestData)
        const response = await axios.post(commonApi, sweeperRequestData);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let dropdownData = JSON.parse(commonReportMasterList);
        console.log(dropdownData);

        for (const data of dropdownData) {
            const option = document.createElement("option");
            option.value = data.PK_VehicleId;
            option.text = data.vehicleName;
            drainageWorkerDropdown.appendChild(option);
            drainageWorkerDropdown.fstdropdown.rebind();
        }
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const getData = async () => {
    try {
        const sweeperRequestData = {
            storedProcedureName: "Proc_VehicleMap_1",
            parameters: JSON.stringify({
                mode: 4,
                UserID: loginId,
                zoneId: zoneDropdown.value,
                WardId: wardDropdown.value,
                FK_VehicleID: drainageWorkerDropdown.value,
                sDate: `${startDate.value.split("T")[0]} ${
                    startDate.value.split("T")[1]
                    }`,
                eDate: `${endDate.value.split("T")[0]} ${endDate.value.split("T")[1]}`,
            }),
        };

        console.log(sweeperRequestData);
        const response = await axios.post(commonApi, sweeperRequestData);

        if (!response.data.CommonMethodResult.CommonReportMasterList) {
            toast.show();
            return;
        }

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let data = JSON.parse(commonReportMasterList);
        console.log(data);
        addMarkersWithDelay(data);
        // console.log(dropdownData);
        // for (const data of dropdownData) {
        //   const option = document.createElement("option");
        //   option.value = data.PK_SweeperId;
        //   option.text = data.SweeperName;
        //   sweeperDropdown.appendChild(option);
        //   sweeperDropdown.fstdropdown.rebind();
        // }
    } catch (error) {
        console.error("Error fetching data:", error);
        Swal.fire({
            icon: "info",
            title: "Attention",
            text: "No gps location found",
        });
    }
};

// Handlers

const handleZoneSelect = (event) => {
    populateWardDropdown();
};

const handleWardSelect = (event) => {
    //   populateKothiDropdown();
    populateSweeperDropdown();
};

const handleKothiSelect = (event) => {
    populateSweeperDropdown();
};

//btnShowRoute.addEventListener("click", async (e) => {
//    e.preventDefault();

//    if (drainageWorkerDropdown.value === "0") {
//        Swal.fire({
//            icon: "info",
//            title: "Attention",
//            text: "Please select sweeper name",
//        });
//        return;
//    }

//    clearMap();
//    if (drainageWorkerDropdown.value) {
//        await drainagePoint(
//            $("#drainageWorkerDropdown").find("option:selected").text()
//        );
//        //await kothi(drainageWorkerDropdown.value);
//    }
//    await getRouteId();
//});

btnPlay.addEventListener("click", async (e) => {
    e.preventDefault();

    if (
        zoneDropdown.value === "0" ||
        wardDropdown.value === "0" ||
        // kothiDropdown.value === "0" ||
        drainageWorkerDropdown.value === "0" ||
        !startDate.value ||
        !endDate.value
    ) {
        Swal.fire({
            icon: "info",
            title: "Attention",
            text: "Please select zone, ward, kothi, sweeper name, startdate and enddate",
        });
        return;
    }

    if (isPlaying) {
        // Pause the animation
        isPlaying = false;
        btnPlay.innerHTML = `<i class="fa-regular fa-circle-play text-white"></i>Play`;
        btnPlay.classList.remove("btn-danger");
        btnPlay.classList.add("btn-success");
        timeoutIds.forEach(function (timeoutId) {
            clearTimeout(timeoutId); // Clear all timeouts to pause the animation
        });
    } else {
        // Resume or start the animation
        isPlaying = true;
        btnPlay.innerHTML = `<i class="fa-solid fa-stop text-white"></i>Stop`;
        btnPlay.classList.add("btn-danger");
        btnPlay.classList.remove("btn-success");
        markerGroup.clearLayers();
        await getData();
    }
});

//Clear map

btnRefresh.addEventListener("click", () => {
    clearMap();
});

const clearMap = () => {
    clearAllMarkers();
    clearPolyline();
    clearMarkers();
};

const clearPolyline = () => {
    routeLayer.clearLayers();
};

const clearAllMarkers = () => {
    dotMarkerLayer.clearLayers();
    markerGroup.clearLayers();
    Kothilayer.clearLayers();
};

window.addEventListener("load", async () => {
    await populateZoneDropdown();
    await drainagePoint();
});
// window.addEventListener("load", initializeMap());

// Bootstrap

const toast = new bootstrap.Toast(document.getElementById("noDataToast"));