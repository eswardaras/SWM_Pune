//const loginId = 11401;
//const zoneApi = "http://13.200.33.105/SWMServiceLive/SWMService.svc/GetZone";
//const wardApi = "http://13.200.33.105/SWMServiceLive/SWMService.svc/GetWard";
//const kothiApi = "http://13.200.33.105/SWMServiceLive/SWMService.svc/GetKothi";
//const commonApi =
//    "http://13.200.33.105/SWMServiceLive/SWMService.svc/CommonMethod";

var map = L.map("map").setView([18.523204, 73.852011], 12);

var osm = L.tileLayer("https://{s}.tile.osm.org/{z}/{x}/{y}.png", {
    attribution:
        '&copy; <a href="https://osm.org/copyright">OpenStreetMap</a> contributors',
}).addTo(map);
map.addControl(new L.Control.Fullscreen());

var marker, marker1;

const cronicSpotIcon = "./Images/CronicSpotIcon2.png";

const doti = "./Images/dotgreen.png";
const rdoti = "./Images/dotred.png";

var degree = L.icon({
    iconUrl: cronicSpotIcon,
    iconSize: [40, 40],
    iconAnchor: [10, 10],
});

var dot = L.icon({
    iconUrl: doti,
    iconSize: [40, 40],
    iconAnchor: [16, 16],
});

var rdot = L.icon({
    iconUrl: rdoti,
    iconSize: [40, 40],
    iconAnchor: [16, 16],
});

var cronicSpotLayer = L.layerGroup();
var dotMarkerLayer = L.layerGroup();
var polylineLayer = L.layerGroup().addTo(map);
var markerLayer = L.layerGroup().addTo(map);

let decorator = null;

var bm = {
    "Base Map": osm,
};

var overlays = {
    Route: polylineLayer,
    GPS_Location: dotMarkerLayer,
};

var layerControl = L.control
    .layers(null, overlays, { collapsed: false })
    .addTo(map);

cronicSpotLayer.addTo(map);
dotMarkerLayer.addTo(map);

// Function to get query parameters from the URL
const getQueryParams = () => {
    const queryString = window.location.search;
    const urlParams = new URLSearchParams(queryString);
    return urlParams;
};

// Function to initialize the page and read the data parameter
const initializePage = async () => {
    const params = getQueryParams();
    const dataParam = params.get("data");

    if (dataParam) {
        const data = JSON.parse(decodeURIComponent(dataParam));
        console.log("received data", data);

        $("#mapTitle").text(
            `Vehicle- ${data.vehiclename} | Zone- ${data.zonename} | Ward- ${data.wardname}`
        );

        await viewGpsPoint(data);
        await viewRoute(data);
    }
};

const convertDateFormat = (dateStr) => {
    const [month, day, year] = dateStr.split("-");
    return `${year}-${month}-${day}`;
};

const viewGpsPoint = async (data) => {
    try {
        console.log("received data", data);
        const formattedDate = convertDateFormat(data.date);

        const requestData = {
            storedProcedureName: "Proc_VehicleMap_1",
            parameters: JSON.stringify({
                mode: 4,
                UserID: loginId,
                FK_VehicleID: data.vehicleId,
                zoneId: 0,
                WardId: 0,
                sDate: `${formattedDate} 00:31:28.000`,
                eDate: `${formattedDate} 11:31:28.000`,
            }),
        };

        console.log(requestData);

        const response = await axios.post(commonApi, requestData);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let data1 = JSON.parse(commonReportMasterList);
        console.log("view gps location", data1);

        showGpsPoints(data1);
    } catch (error) {
        console.error("Error fetching data:", error);
        Swal.fire({
            title: "Attention!",
            text: "No gps location found",
            icon: "info",
            showConfirmButton: false,
            timer: 1500,
            timerProgressBar: true,
        });
    }
};

const showGpsPoints = (data) => {
    console.log("showGpsPoint", data);
    for (var i = 0; i < data.length; i++) {
        var color = data[i].color;

        if (data[i].speed >= 7) {
            marker1 = L.marker([data[i].latitude, data[i].longitude], {
                icon: rdot,
            }).addTo(dotMarkerLayer);
        } else {
            marker1 = L.marker([data[i].latitude, data[i].longitude], {
                icon: dot,
            }).addTo(dotMarkerLayer);
        }

        marker1.bindPopup(`Time:- ${data[i].datetim.split("T")[0]} ${
            data[i].datetim.split("T")[1]
            } <br>
                       Speed:- ${data[i].speed} <br>
                       VehicleName:-  ${data[i].vehicleName}`);
    }
};

const viewRoute = async (data) => {
    try {
        const requestData = {
            storedProcedureName: "proc_VehicleMapwithRoute",
            parameters: JSON.stringify({
                mode: 28,
                Fk_accid: 11401,
                Fk_divisionid: data.routeid,
                Fk_ZoneId: 0,
                FK_WardId: 0,
            }),
        };

        const response = await axios.post(commonApi, requestData);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let data1 = JSON.parse(commonReportMasterList);
        console.log("Route location", data1);

        let coordinates = [];
        // console.log(dropdownData);
        for (const d of data1) {
            let array = [];
            array.push(d.RouteLat);
            array.push(d.RouteLng);
            coordinates.push(array);
        }

        showPolylineOnMap(coordinates, data1[1].RouteName, data1[1].color);
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const showPolylineOnMap = (coordinates, routeName, color) => {
    polylineLayer.clearLayers();
    markerLayer.clearLayers();

    // Check if coordinates array is empty or has insufficient points
    if (!Array.isArray(coordinates) || coordinates.length < 2) {
        console.error("Invalid coordinates array.");
        return;
    }

    const polyline = L.polyline(coordinates, { color: color }).addTo(
        polylineLayer
    );
    polyline.addTo(map);

    const bounds = polyline.getBounds();
    map.flyToBounds(bounds, { duration: 2, easeLinearity: 0.25 });

    // Remove existing decorator if present
    if (decorator) {
        map.removeLayer(decorator);
    }

    decorator = L.polylineDecorator(polyline, {
        patterns: [
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
    }).addTo(polylineLayer);

    decorator.addTo(map);

    // coordinates.forEach((coords, index) => {
    //   if (index === 0) {
    //     L.marker(coords, {
    //       icon: L.divIcon({ className: "custom-start-marker" }),
    //     }).addTo(markerLayer);
    //   } else {
    //     L.marker(coords, {
    //       icon: L.divIcon({ className: "custom-marker" }),
    //     }).addTo(markerLayer);
    //   }
    // });
};

// window.onload = initializePage();

window.addEventListener("DOMContentLoaded", () => {
    initializePage();
});
