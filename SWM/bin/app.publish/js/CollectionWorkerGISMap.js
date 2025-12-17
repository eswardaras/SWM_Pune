const zoneDropdown = document.getElementById("zoneDropdown");
const wardDropdown = document.getElementById("wardDropdown");
const kothiDropdown = document.getElementById("kothiDropdown");
const sweeperDropdown = document.getElementById("sweeperDropdown");
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

const sweeperI = `./Images/collectionWorker.png`;
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

var bm = {
    "Base Map": osm,
};

var overlays = {
    "Collection Worker Location": dotMarkerLayer,

    Route: routeLayer,
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

var lst_lat, lst_lon, featureGroup;
var markerGroup = L.featureGroup().addTo(map);
var timeoutIds = []; // Array to store the timeout IDs for each marker
var markersweep;
var SWEEPERPosition = [];

// const initializeMap = () => {};

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
            storedProcedureName: "SP_Get_RouteId ",
            parameters: JSON.stringify({
                mode: 1,
                fk_VehicleId: sweeperDropdown.value,
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
        marker1.bindPopup("Time: " + time);
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
        kothiDropdown.innerHTML = '<option value="0">Select Prabhag</option>';

        const requestData = {
            storedProcedureName: "proc_collectionworkerAttendance",
            parameters: JSON.stringify({
                mode: 10,
                accid: loginId,
                zoneid: zoneDropdown.value,
                wardid: wardDropdown.value,
            }),
        };

        const response = await axios.post(commonApi, requestData);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let dropdownData = JSON.parse(commonReportMasterList);
        console.log(dropdownData);

        for (const data of dropdownData) {
            const option = document.createElement("option");
            option.value = data.pk_prabhagid;
            option.text = data.prabhagname;
            kothiDropdown.appendChild(option);
            kothiDropdown.fstdropdown.rebind();
        }
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const populateSweeperDropdown = async () => {
    try {
        sweeperDropdown.innerHTML = '<option value="0">Select Collection worker</option>';

        const sweeperRequestData = {
            storedProcedureName: "GetHumanDataByDateAndIds",
            parameters: JSON.stringify({
                mode: 2,
                prabhagId: kothiDropdown.value,
            }),
        };

        const response = await axios.post(commonApi, sweeperRequestData);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let dropdownData = JSON.parse(commonReportMasterList);
        console.log(dropdownData);

        for (const data of dropdownData) {
            const option = document.createElement("option");
            option.value = data.PK_VehicleId;
            option.text = data.vehicleName;
            sweeperDropdown.appendChild(option);
            sweeperDropdown.fstdropdown.rebind();
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
                FK_VehicleID: sweeperDropdown.value,
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
        toast.show();
        console.error("Error fetching data:", error);
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
    populateSweeperDropdown();
};

btnShowRoute.addEventListener("click", async (e) => {
    e.preventDefault();
    clearMap();
    await getRouteId();
});

btnPlay.addEventListener("click", async (e) => {
    e.preventDefault();

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
};

window.addEventListener("load", populateZoneDropdown());
// window.addEventListener("load", initializeMap());

// Bootstrap

const toast = new bootstrap.Toast(document.getElementById("noDataToast"));
