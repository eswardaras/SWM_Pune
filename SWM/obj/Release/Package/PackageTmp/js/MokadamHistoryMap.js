const zoneDropdown = document.getElementById("zoneDropdown");
const wardDropdown = document.getElementById("wardDropdown");
const kothiDropdown = document.getElementById("kothiDropdown");
const mokadumDropdown = document.getElementById("mokadumDropdown");
const startDate = document.getElementById("startDate");
const endDate = document.getElementById("endDate");

const btnShowRoute = document.getElementById("btnShowRoute");
const btnPlay = document.getElementById("btnPlay");
const btnRefresh = document.getElementById("btnRefresh");

var isPlaying = false;

// Map

let config = {
    minZoom: 8,
    maxZoom: 18,
    fullscreenControl: true,
};

var map = L.map("map", config).setView([18.523204, 73.852011], 13);
var marker, marker1;

const sweeperI = `./Images/worker.png`;
const degreeIcon = `./Images/degree.png`;
const G_dot = `./Images/dotgreen.png`;
const R_dot = `./Images/dotred.png`;

var osm = L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright"></a>',
}).addTo(map);

var sweepIcon = L.icon({
    iconUrl: sweeperI,
    iconSize: [40, 40],
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

var dotMarkerLayer = L.layerGroup();
var routeLayer = L.layerGroup();
var Kothilayer = L.layerGroup();

var bm = {
    "Base Map": osm,
};

var overlays = {
    "Mokadum Location": dotMarkerLayer,
    Kothi: Kothilayer,
    // Route: routeLayer,
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

        // Create a circle with a 25-meter radius around the marker
        const bufferCircle = L.circle([kLatitude, kLongitude], {
            color: "red",
            fillColor: "red",
            fillOpacity: 0.3,
            radius: 25, // Radius in meters
        }).addTo(Kothilayer); // Add the buffer circle directly to the map
        bufferCircle.bindPopup(kothiName);

        map.fitBounds(bufferCircle.getBounds());
    } catch (error) {
        console.error("Error fetching kothi data:", error);
    }
};

const Show_Route_Polyline = async (routeId) => {
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
        showPolylineOnMap(coordinates);
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const showPolylineOnMap = (coordinates) => {
    var decorator;
    var polyline = L.polyline(coordinates, {
        color: "red",
        opacity: 0.5,
    }).addTo(routeLayer);
    polyline.addTo(routeLayer);

    var bufferedPolylines = [];
    for (var i = 0; i < coordinates.length - 1; i++) {
        var startPoint = L.latLng(coordinates[i]);
        var endPoint = L.latLng(coordinates[i + 1]);
        var segmentPolyline = L.polyline([startPoint, endPoint]);

        // Calculate the buffer for the segment
        var bufferedSegment = segmentPolyline.toGeoJSON().geometry;
        var buffered = turf.buffer(bufferedSegment, 5, { units: "meters" });

        // Convert the buffer to Leaflet geometry
        var bufferedLayer = L.geoJSON(buffered);

        // Add the buffered segment to the polyline group
        bufferedLayer.addTo(routeLayer);
        bufferedPolylines.push(bufferedLayer);
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
        await kothi(mokadumDropdown.value);

        const requestData = {
            storedProcedureName: "SP_Get_RouteId ",
            parameters: JSON.stringify({
                mode: 1,
                fk_VehicleId: mokadumDropdown.value,
            }),
        };

        const response = await axios.post(commonApi, requestData);

        if (!response.data.CommonMethodResult.CommonReportMasterList) {
            toast.show();
            return;
        }

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let data = JSON.parse(commonReportMasterList);
        console.log("sweeper route id", data);

        if (data) {
            Show_Route_Polyline(data[0].RouteId);
            //   const Fk_VehicleId = sweeperDropdown.value; // Assuming sweeperDropdown contains the value of Fk_VehicleId
        }
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

function addMarkersWithDelay(data) {
    var marker;
    var markerPosition = [];

    for (var i = 0; i < data.length; i++) {
        var lat = data[i].latitude;
        var lon = data[i].longitude;
        var time = data[i].datetim;
        var speed = data[i].speed;

        console.log("speed" + speed);
        var dotIcon = speed > 3 ? reddot : greendot;
        marker1 = L.marker([lat, lon], { icon: dotIcon }).addTo(dotMarkerLayer);
        marker1.bindPopup(`
    <b>Latitude:</b> ${lat} <br>
    <b>Longitude:</b> ${lon} <br>
    <b>Time:</b> ${time} <br>
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

const populateMokadumDropdown = async () => {
    try {
        mokadumDropdown.innerHTML = '<option value="0">Select Sweeper</option>';

        const sweeperRequestData = {
            storedProcedureName: "SP_DROPDOWNS",
            parameters: JSON.stringify({
                MODE: 5,
                ZONEID: zoneDropdown.value,
                WARDID: wardDropdown.value,
                KOTHIID: kothiDropdown.value,
            }),
        };

        const response = await axios.post(commonApi, sweeperRequestData);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let dropdownData = JSON.parse(commonReportMasterList);

        for (const data of dropdownData) {
            const option = document.createElement("option");
            option.value = data.VEHICLEID;
            option.text = data.MOKADAM_NAME;
            mokadumDropdown.appendChild(option);
            mokadumDropdown.fstdropdown.rebind();
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
                FK_VehicleID: mokadumDropdown.value,
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
        Swal.fire({
            icon: "error",
            title: "Oops",
            text: "Nothing found",
            timer: 2000,
            timerProgressBar: true,
        });
        isPlaying = false;
        btnPlay.innerHTML = `<i class="fa-regular fa-circle-play text-white"></i>Play`;
        btnPlay.classList.remove("btn-danger");
        btnPlay.classList.add("btn-success");
        timeoutIds.forEach(function (timeoutId) {
            clearTimeout(timeoutId); // Clear all timeouts to pause the animation
        });
    }
};

// Handlers

const handleZoneSelect = (event) => {
    populateWardDropdown();
};

const handleWardSelect = (event) => {
    populateKothiDropdown();
};

const handleKothiSelect = (event) => {
    populateMokadumDropdown();
};

btnShowRoute.addEventListener("click", async (e) => {
    e.preventDefault();

    if (mokadumDropdown.value === "0") {
        Swal.fire({
            icon: "info",
            title: "Attention",
            text: "Please select mokadum name",
        });
        return;
    }

    clearMap();
    // await getRouteId();
    await kothi(mokadumDropdown.value);
});

btnPlay.addEventListener("click", async (e) => {
    e.preventDefault();

    if (
        zoneDropdown.value === "0" ||
        wardDropdown.value === "0" ||
        kothiDropdown.value === "0" ||
        mokadumDropdown.value === "0" ||
        !startDate.value ||
        !endDate.value
    ) {
        Swal.fire({
            icon: "info",
            title: "Attention",
            text: "Please select zone, ward, kothi, mokadum name, startdate and enddate",
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

window.addEventListener("load", populateZoneDropdown);
// window.addEventListener("load", initializeMap());

// Bootstrap

const toast = new bootstrap.Toast(document.getElementById("noDataToast"));
