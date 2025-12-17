const zoneDropdown = document.getElementById("zoneDropdown");
const wardDropdown = document.getElementById("wardDropdown");

var map = L.map("map").setView([18.523204, 73.852011], 12);

var osm = L.tileLayer("https://{s}.tile.osm.org/{z}/{x}/{y}.png", {
    attribution:
        '&copy; <a href="https://osm.org/copyright">OpenStreetMap</a> contributors',
}).addTo(map);
map.addControl(new L.Control.Fullscreen());

const litterBinIcon = "./Images/litterbin.png";
var degree = L.icon({
    iconUrl: litterBinIcon,
    iconSize: [20, 20],
    iconAnchor: [10, 10],
});

var litterBinLayer = L.layerGroup(); // Declare the GeoJSON layer variable outside the event listener
var bm = {
    "Base Map": osm,
};

var overlays = {
    LitterBin: litterBinLayer,
};

var layerControl = L.control
    .layers(null, overlays, { collapsed: false })
    .addTo(map);
var controlElement = layerControl.getContainer();
controlElement.style.fontSize = "10px";
controlElement.style.backgroundColor = "#f1f1f1";
controlElement.style.borderRadius = "5px";
controlElement.style.padding = "10px";
controlElement.style.margin = "0";

litterBinLayer.addTo(map);

var litterBin;

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

const handleZoneSelect = async (event) => {
    await populateWardDropdown();
};

const handleWardSelect = async (event) => {
    await getData();
};

const displayLitterBin = async (data) => {
    try {
        if (litterBin) {
            map.removeLayer(litterBin);
        }

        const markerArray = [];

        for (const d of data) {
            marker = L.marker([d.latitude, d.longitude], {
                icon: degree,
            }).addTo(litterBinLayer);
            marker.bindPopup(`
      ZoneName: ${d.ZoneName} <br>
      Wardname: ${d.wardName} <br>
      Litterbin Name: ${d.litterbinname}
      `);

            markerArray.push(marker);
        }

        const bounds = L.latLngBounds(
            markerArray.map((marker) => marker.getLatLng())
        );

        // Fit the map to the bounds
        map.fitBounds(bounds);
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const getData = async () => {
    try {
        const requestData = {
            storedProcedureName: "SP_putRouteLatLong",
            parameters: JSON.stringify({
                mode: 11,
                zoneId: zoneDropdown.value,
                WardId: wardDropdown.value,
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
        console.log(data);
        displayLitterBin(data);
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

window.addEventListener("load", populateZoneDropdown);

// Bootstrap

const toast = new bootstrap.Toast(document.getElementById("noDataToast"));
