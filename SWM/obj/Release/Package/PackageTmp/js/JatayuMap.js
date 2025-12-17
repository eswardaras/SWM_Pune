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
var bm = {
    "Base Map": osm,
};

var overlays = {
    cronicSpot: cronicSpotLayer,
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
        console.log(data);

        $("#mapTitle").text(
            `Vehicle- ${data.vehiclename} | Zone- ${data.zonename} | Ward- ${data.wardname}`
        );

        await viewGpsPoint(data);
        await viewLocation(data);
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
                FK_VehicleID: data.fk_vehicleid,
                zoneId: 0,
                WardId: data.Wardid,
                sDate: `${formattedDate} 00:31:28.000`,
                eDate: `${formattedDate} 11:31:28.000`,
            }),
        };
        // const requestData = {
        //   storedProcedureName: "Proc_VehicleMapwithRoute",
        //   parameters: JSON.stringify({
        //     mode: 13,
        //     Fk_accid: loginId,
        //     FK_VehicleID: data.fk_vehicleid,
        //     Fk_ZoneId: 0,
        //     FK_WardId: 0,
        //     Startdate: `${data.date} 00:00:00`,
        //     Enddate: `${data.date} 23:59:00`,
        //   }),
        // };

        console.log(requestData);

        const response = await axios.post(commonApi, requestData);
        console.log("view gps location", response);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let data1 = JSON.parse(commonReportMasterList);

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
    var marker;

    for (var i = 0; i < data.length; i++) {
        var color = data[i].color;

        if (data[i].color === "red") {
            marker1 = L.marker([data[i].latitude, data[i].longitude], {
                icon: rdot,
            }).addTo(dotMarkerLayer);
        } else {
            marker1 = L.marker([data[i].latitude, data[i].longitude], {
                icon: dot,
            }).addTo(dotMarkerLayer);
        }

        marker1.bindPopup(`Time:- ${data[i].datetim}`);
    }
};

const viewLocation = async (data) => {
    try {
        //map.eachLayer(function (layer) {
        //    if (layer instanceof L.Marker) {
        //        layer.remove();
        //    }
        //});

        const locationRequestData = {
            storedProcedureName: "proc_jatayucoveragereport",
            parameters: JSON.stringify({
                mode: 6,
                Accid: loginId,
                vehicleid: data.fk_vehicleid,
                zoneId: data.zonename,
                WardId: data.Wardid,
                startdate: data.date,
                enddate: data.date,
            }),
        };

        console.log("locationRequestData", locationRequestData);
        const response = await axios.post(commonApi, locationRequestData);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let mapData = JSON.parse(commonReportMasterList);
        console.log("cronic spots", mapData);

        const markerArray = [];

        for (const d of mapData) {
            marker = L.marker([d.lat, d.long], {
                icon: degree,
            }).addTo(cronicSpotLayer);
            marker.bindPopup(`
            <p>Name:- ${!d.cronic_spot_name ? "---" : d.cronic_spot_name}</p>
            <p>Date:- ${d.optime.split("T")[0]}</p>
            <p>Time:- ${d.optime.split("T")[1]}</p>
            `);

            markerArray.push(marker);

            const bounds = L.latLngBounds(
                markerArray.map((marker) => marker.getLatLng())
            );

            // Fit the map to the bounds
            map.fitBounds(bounds);
        }
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

// window.onload = initializePage();

window.addEventListener("DOMContentLoaded", () => {
    initializePage();
});

