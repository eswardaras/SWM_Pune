const zoneDropdown = document.getElementById("zoneDropdown");
const wardDropdown = document.getElementById("wardDropdown");
const blockDropdown = document.getElementById("blockDropdown");
const totalCount = document.getElementById("totalCount");

const btnSearch = document.getElementById("btnSearch");

let map;

const zoneRequestData = {
    mode: 11,
    vehicleId: 0,
    AccId: loginId,
};

const wardRequestData = {
    mode: 12,
    vehicleId: 0,
    AccId: loginId,
    ZoneId: 0,
};

const ctptParameters = {
    mode: 7,
    Accid: loginId,
    zoneId: 0,
    WardId: 0,
    blocktypeid: 0,
};

// Dropdowns

const populateZoneDropdown = async () => {
    try {
        const response = await axios.post(zoneApi, zoneRequestData, {
            headers: {
                "Content-Type": "application/json",
            },
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

        const response = await axios.post(wardApi, wardRequestData, {
            headers: {
                "Content-Type": "application/json",
            },
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

// Main

const getPoints = async () => {
    try {
        map.eachLayer(function (layer) {
            if (layer instanceof L.Marker) {
                layer.remove();
            }
        });

        const ctptRequestData = {
            storedProcedureName: "proc_ctptdashboard",
            parameters: JSON.stringify(ctptParameters),
        };

        const response = await axios.post(commonApi, ctptRequestData);
        console.log(response);

        if (!response.data.CommonMethodResult.CommonReportMasterList) {
            toast.show();
            totalCount.innerText = 0;
            return;
        }

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0]
                .ReturnValue;

        let pointsData = JSON.parse(commonReportMasterList);

        totalCount.innerText = pointsData.length;

        addPoints(pointsData);
    } catch (error) {
        console.error("An error occurred while getting location:", error);
    }
};

// Handlers

const handleZoneSelect = (event) => {
    const { value } = event.target;
    wardRequestData.ZoneId = !value ? 0 : value;
    ctptParameters.zoneId = !value ? 0 : value;
    populateWardDropdown();
};

const handleWardSelect = (event) => {
    const { value } = event.target;
    ctptParameters.WardId = !value ? 0 : value;
};

const handleBlockSelect = (event) => {
    const { value } = event.target;
    ctptParameters.blocktypeid = !value ? 0 : value;
};

// Map

const initializeMap = () => {
    map = L.map("map").setView([18.5204, 73.8567], 13);
    L.tileLayer("https://tile.openstreetmap.org/{z}/{x}/{y}.png", {
        maxZoom: 19,
        attribution:
            '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>',
    }).addTo(map);
    map.addControl(new L.Control.Fullscreen());
};

const addPoints = (mapData) => {
    console.log("mapData", mapData);

    for (const data of mapData) {
        if (data.blocktypename === "CT") {
            addCT(data);
        } else if (data.blocktypename === "PT") {
            addPT(data);
        } else {
            addUrinal(data);
        }
        map.panTo(new L.LatLng(data.Latitude, data.longitude));
    }
};

const addCT = (data) => {
    var blueFeeder = L.icon({
        iconUrl: "./Images/CT.png",

        iconSize: [38, 38], // size of the icon
        iconAnchor: [20, 20], // point of the icon which will correspond to marker's location
        popupAnchor: [0, -20], // point from which the popup should open relative to the iconAnchor
    });
    var marker = L.marker([data.Latitude, data.longitude], {
        icon: blueFeeder,
    }).addTo(map);

    marker.bindPopup(
        `<p><b>Zone:-</b> ${data.zonename}</p>
    <p><b>Ward Name:-</b> ${data.wardName}</p>
    <p><b>Block Type:-</b> ${data.blocktypename}</p>
    <p><b>Block Name:-</b> ${data.BlockName}</p>
    <p><b>Mokadam:-</b> ${data.Mokadam}</p>
    <p><b>No. Of Seats:-</b> ${data.NoOfSeats}</p>
    <p><b>Address:-</b> ${data.Address}</p>`
    );
    marker.on("click", function () {
        this.openPopup();
    });
};

const addPT = (data) => {
    var blueFeeder = L.icon({
        iconUrl: "./Images/PT.png",

        iconSize: [38, 38], // size of the icon
        iconAnchor: [20, 20], // point of the icon which will correspond to marker's location
        popupAnchor: [0, -20], // point from which the popup should open relative to the iconAnchor
    });
    var marker = L.marker([data.Latitude, data.longitude], {
        icon: blueFeeder,
    }).addTo(map);

    marker.bindPopup(
        `<p><b>Zone:-</b> ${data.zonename}</p>
    <p><b>Ward Name:-</b> ${data.wardName}</p>
    <p><b>Block Type:-</b> ${data.blocktypename}</p>
    <p><b>Block Name:-</b> ${data.BlockName}</p>
    <p><b>Mokadam:-</b> ${data.Mokadam}</p>
    <p><b>No. Of Seats:-</b> ${data.NoOfSeats}</p>
    <p><b>Address:-</b> ${data.Address}</p>`
    );
    marker.on("click", function () {
        this.openPopup();
    });
};

const addUrinal = (data) => {
    var blueFeeder = L.icon({
        iconUrl: "./Images/Urinal.png",

        iconSize: [38, 38], // size of the icon
        iconAnchor: [20, 20], // point of the icon which will correspond to marker's location
        popupAnchor: [0, -20], // point from which the popup should open relative to the iconAnchor
    });
    var marker = L.marker([data.Latitude, data.longitude], {
        icon: blueFeeder,
    }).addTo(map);

    marker.bindPopup(
        `<p><b>Zone:-</b> ${data.zonename}</p>
    <p><b>Ward Name:-</b> ${data.wardName}</p>
    <p><b>Block Type:-</b> ${data.blocktypename}</p>
    <p><b>Block Name:-</b> ${data.BlockName}</p>
    <p><b>Mokadam:-</b> ${data.Mokadam}</p>
    <p><b>No. Of Seats:-</b> ${data.NoOfSeats}</p>
    <p><b>Address:-</b> ${data.Address}</p>`
    );
    marker.on("click", function () {
        this.openPopup();
    });
};

window.addEventListener("load", populateZoneDropdown);
window.addEventListener("load", initializeMap());

// Event Listners

btnSearch.addEventListener("click", async (e) => {
    e.preventDefault();

    await getPoints();
});

// Bootstrap

const toast = new bootstrap.Toast(document.getElementById("noDataToast"));
