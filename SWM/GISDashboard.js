const zoneDropdown = document.getElementById("zoneDropdown");
const wardDropdown = document.getElementById("wardDropdown");
const kothiDropdown = document.getElementById("kothiDropdown");
const startdate = document.getElementById("startdate");
const enddate = document.getElementById("enddate");

let config = {
    minZoom: 8,
    maxZoom: 24,
};

// var map = L.map("map").setView([18.523204, 73.852011], 12);
var map = L.map("map", config).setView([18.523204, 73.852011], 13);

var osm = L.tileLayer("https://{s}.tile.osm.org/{z}/{x}/{y}.png", {
    attribution:
        '&copy; <a href="https://osm.org/copyright">OpenStreetMap</a> contributors',
}).addTo(map);
map.addControl(new L.Control.Fullscreen());

const degreeIcon = "./Images/rb.png";
var degree = L.icon({
    iconUrl: degreeIcon,
    iconSize: [20, 20],
    iconAnchor: [10, 10],
});

const adhocIcon = "http://13.200.33.105:8422/static/garbage.png";
var adhocicon = L.icon({
    iconUrl: adhocIcon,
    iconSize: [20, 20],
    iconAnchor: [10, 10],
});

const kothiIcon = "./Images/gf.png";
var kothiI = L.icon({
    iconUrl: kothiIcon,
    iconSize: [30, 30],
    iconAnchor: [10, 10],
});

const liveKothiIcon = "./Images/blue_circle.png";
var liveKothiI = L.icon({
    iconUrl: liveKothiIcon,
    iconSize: [30, 30],
    iconAnchor: [10, 10],
});

const ctIcon = "./Images/CT.png";
var ctI = L.icon({
    iconUrl: ctIcon,
    iconSize: [25, 25],
    iconAnchor: [10, 10],
});

const ptIcon = "./Images/PT.png";
var ptI = L.icon({
    iconUrl: ptIcon,
    iconSize: [25, 25],
    iconAnchor: [10, 10],
});

const UrIcon = "./Images/Ur.png";
var urI = L.icon({
    iconUrl: UrIcon,
    iconSize: [25, 25],
    iconAnchor: [10, 10],
});

const feederIcon = "./Images/feeder.png";
var feederI = L.icon({
    iconUrl: feederIcon,
    iconSize: [25, 25],
    iconAnchor: [10, 10],
});

const blueFeederIcon = "./Images/BLUEFEEDER.png";
var blueFeederI = L.icon({
    iconUrl: blueFeederIcon,
    iconSize: [25, 25],
    iconAnchor: [10, 10],
});

var wardlayer = L.layerGroup(); // Declare the GeoJSON layer variable outside the event listener
var ctlayer = L.layerGroup();
var ptlayer = L.layerGroup();
var urlayer = L.layerGroup();
var kothilayer = L.layerGroup();
var feederlayer = L.layerGroup();
var sweeperlayer = L.layerGroup();
var padikHaddilayer = L.layerGroup();
// var mechSweeperlayer = L.layerGroup();
var cwlayer = L.layerGroup();
var GVP = L.layerGroup();
var adhoc = L.layerGroup();

var liveFeederLayer = L.layerGroup();
var liveKothiLayer = L.layerGroup();
var liveSweeperLayer = L.layerGroup();
var liveMechSweeperLayer = L.layerGroup();

var bm = {
    "Base Map": osm,
};

var overlays = {
    Ward: wardlayer,
    CT: ctlayer,
    PT: ptlayer,
    Urinars: urlayer,
    Kothi: kothilayer,
    Feeder: feederlayer,
    /*    Sweeper: sweeperlayer,*/
    Padik_Haddi: padikHaddilayer,
    // MechSweeper: mechSweeperlayer,
    "Cw Pockets": cwlayer,
    GVP: GVP,
    adhoc: adhoc,

    Live_kothi: liveKothiLayer,
    Live_feeder: liveFeederLayer,
    Live_sweeper: liveSweeperLayer,
    Live_MechSweeper: liveMechSweeperLayer,
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

wardlayer.addTo(map);
ctlayer.addTo(map);
ptlayer.addTo(map);
urlayer.addTo(map);
kothilayer.addTo(map);
feederlayer.addTo(map);
/*sweeperlayer.addTo(map);*/
padikHaddilayer.addTo(map);
// mechSweeperlayer.addTo(map);
cwlayer.addTo(map);
GVP.addTo(map);
adhoc.addTo(map);

liveFeederLayer.addTo(map);
liveKothiLayer.addTo(map);
liveSweeperLayer.addTo(map);
liveMechSweeperLayer.addTo(map);

var geojsonLayer; // Declare the GeoJSON layer variable outside the event listener
var ct;
var pt;
var ur;
var ko;
var fd;
var sr;
var pk;
var cw;
var gvp;

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
            mode: 56,
            Fk_accid: 11401,
            Fk_ambcatId: 0,
            Fk_divisionid: 0,
            FK_VehicleID: 0,
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

const handleZoneSelect = async () => {
    await populateWardDropdown();
};

const handleWardSelect = async () => {
    await populateKothiDropdown();
    await displayGVP();
    await displayWard();
    await displayCT();
    await displayPT();
    await displayUR();
    await displayCw();
    await displayFeeder();
    await displayKothi();
    //await displaySweeper();
    await displayPadikHaddi();

    if ($("#liveKothi").is(":checked")) {
        await liveKothiData();
    }

    if ($("#liveFeeder").is(":checked")) {
        await liveFeeder();
    }

    if ($("#liveSweeperRoute").is(":checked")) {
        await liveSweeperRoute();
    }

    if ($("#liveMechSweeperRoute").is(":checked")) {
        await liveMechSweeperRoute();
    } else {
    }

    // // if ($("#liveCT").is(":checked")) {
    // //   await liveCTPTUrinal();
    // // }
};

const handleKothiSelect = async () => {
    await displaySweeper();

    if ($("#liveSweeperRoute").is(":checked")) {
        await liveSweeperRoute();
    }
};

const handleLiveKothiSelect = async () => {
    if ($("#liveKothi").is(":checked")) {
        await liveKothiData();
    } else {
        if (liveKothiLayer) {
            liveKothiLayer.clearLayers();
        }
    }
};

const handleLiveFeederSelect = async () => {
    if ($("#liveFeeder").is(":checked")) {
        await liveFeeder();
    } else {
        if (liveFeederLayer) {
            liveFeederLayer.clearLayers();
        }
    }
};

// Flag to track if live sweeper operation should continue
let liveSweeperActive = false;

const handleLiveSweeperSelect = async () => {
    if ($("#liveSweeperRoute").is(":checked")) {
        liveSweeperActive = true;
        await liveSweeperRoute();
    } else {
        liveSweeperActive = false;
        if (liveSweeperLayer) {
            liveSweeperLayer.clearLayers();
        }
        // Hide date wrapper when unchecking
        $(".date-wrapper").hide();
    }
};

const handleLiveMechSweeperSelect = async () => {
    if ($("#liveMechSweeperRoute").is(":checked")) {
        await liveMechSweeperRoute();
    } else {
        if (liveMechSweeperLayer) {
            liveMechSweeperLayer.clearLayers();
        }
    }
};

const handleEndDateSelect = async () => {
    if (liveSweeperActive && startdate.value && enddate.value) {
        await liveSweeperRoute();
    }
};

const handleStartDateSelect = async () => {
    if (!liveSweeperActive) {
        return;
    }
    const startDate = startdate.value;
    const endDate = enddate.value;

    if (startDate && endDate) {
        if (new Date(endDate) >= new Date(startDate)) {
            await liveSweeperRoute();
        } else {
            alert("Start date cannot be greater than end date.");
        }
    }
};

// Static data


const displayWard = async () => {
    try {
        if (geojsonLayer) {
            map.removeLayer(geojsonLayer);
        }

        const { data } = await axios.get("./service/ward1.txt");

        var jsonData = data; // Parse response as JSON

        // Clear previous geojsonLayer if it exists

        // console.log("selectedWard in try", selectedWard);
        // Create GeoJSON layer with filtering
        geojsonLayer = L.geoJSON(jsonData, {
            filter: function (feature) {
                //console.log(
                //  "selected ward in geojson layer",
                //  wardDropdown.selectedOptions[0].textContent
                //);
                if (wardDropdown.selectedOptions[0].textContent === "DEFAULT") {
                    return true; // Show all features if no ward is selected
                }
                return (
                    feature.properties.ward_name ===
                    wardDropdown.selectedOptions[0].textContent
                );
                //console.log("selected ward in geojson layer", selectedWard);
                //console.log("selected ward Data:", jsonData);
            },
            style: function (feature) {
                // Define your polygon styling here
                return {
                    fillColor: "beige",
                    color: "black",
                    weight: 1.5,
                    opacity: 1,
                    fillOpacity: 0.6,
                };
            },
            onEachFeature: function (feature, layer) {
                // Create a popup for each feature
                var popupContent =
                    "<div class='popup-content'>" +
                    "<b>Ward Name:</b> " +
                    feature.properties.ward_name +
                    "<br>" +
                    "</div>";

                layer.bindPopup(popupContent);
            },
        });

        // Add the new geojsonLayer to the map and fit bounds
        geojsonLayer.addTo(wardlayer);
        map.fitBounds(geojsonLayer.getBounds());
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const displayCT = async () => {
    try {
        if (ct) {
            map.removeLayer(ct);
        }

        const { data } = await axios.get("./service/ct.txt");
        console.log(data);

        var jsonData = data; // Parse response as JSON

        // Clear previous geojsonLayer1 if it exists

        // Create GeoJSON layer with filtering and marker style
        ct = L.geoJSON(jsonData, {
            filter: function (feature) {
                if (wardDropdown.selectedOptions[0].textContent === "DEFAULT") {
                    return true; // Show all features if no ward is selected
                }
                return (
                    feature.properties.ward_name ===
                    wardDropdown.selectedOptions[0].textContent
                );
            },
            pointToLayer: function (feature, latlng) {
                // Define your marker styling here
                return L.marker(latlng, {
                    icon: L.icon({
                        iconUrl: "./Images/CT.png", // URL to your marker icon image
                        iconSize: [32, 32], // Size of the icon
                        iconAnchor: [16, 16], // Anchor point of the icon
                    }),
                });
            },
            onEachFeature: function (feature, layer) {
                var properties = feature.properties;
                var popupContent =
                    "<div class='popup-content'>" +
                    "<b>Zone:</b> " +
                    properties.zonename +
                    "<br>" +
                    "<b>Ward:</b> " +
                    properties.wardName +
                    "<br>" +
                    "<b>Block Type:</b> " +
                    properties.blocktypen +
                    "<br>" +
                    "<b>Block Name:</b> " +
                    properties.BlockNam_1 +
                    "<br>" +
                    "<b>Mukadam:</b> " +
                    properties.Mokadam +
                    "<br>" +
                    "<b>No. of Seats:</b> " +
                    properties.NoOfSeats +
                    "<br>" +
                    "<b>Address:</b> " +
                    properties.Address +
                    "</div>";
                layer.bindPopup(popupContent);
            },
        });

        // Add the new geojsonLayer1 to the map
        ct.addTo(ctlayer);
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const displayPT = async () => {
    try {
        if (pt) {
            map.removeLayer(pt);
        }

        const { data } = await axios.get("./service/pt.txt");
        console.log(data);

        var jsonData = data; // Parse response as JSON

        // Create GeoJSON layer with filtering and marker style
        pt = L.geoJSON(jsonData, {
            filter: function (feature) {
                if (wardDropdown.selectedOptions[0].textContent === "DEFAULT") {
                    return true; // Show all features if no ward is selected
                }
                return (
                    feature.properties.ward_name ===
                    wardDropdown.selectedOptions[0].textContent
                );
            },
            pointToLayer: function (feature, latlng) {
                // Define your marker styling here
                return L.marker(latlng, {
                    icon: L.icon({
                        iconUrl: "./Images/PT.png", // URL to your marker icon image
                        iconSize: [32, 32], // Size of the icon
                        iconAnchor: [16, 16], // Anchor point of the icon
                    }),
                });
            },
            onEachFeature: function (feature, layer) {
                var properties = feature.properties;
                var popupContent =
                    "<div class='popup-content'>" +
                    "<b>Zone:</b> " +
                    properties.zonename +
                    "<br>" +
                    "<b>Ward:</b> " +
                    properties.wardName +
                    "<br>" +
                    "<b>Block Type:</b> " +
                    properties.blocktypen +
                    "<br>" +
                    "<b>Block Name:</b> " +
                    properties.BlockNam_1 +
                    "<br>" +
                    "<b>Mukadam:</b> " +
                    properties.Mokadam +
                    "<br>" +
                    "<b>No. of Seats:</b> " +
                    properties.NoOfSeats +
                    "<br>" +
                    "<b>Address:</b> " +
                    properties.Address +
                    "</div>";
                layer.bindPopup(popupContent);
            },
        });

        // Add the new geojsonLayer1 to the map
        pt.addTo(ptlayer);
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const displayUR = async () => {
    try {
        if (ur) {
            map.removeLayer(ur);
        }

        const { data } = await axios.get("./service/ur.txt");
        console.log(data);

        var jsonData = data; // Parse response as JSON

        // Create GeoJSON layer with filtering and marker style
        ur = L.geoJSON(jsonData, {
            filter: function (feature) {
                if (wardDropdown.selectedOptions[0].textContent === "DEFAULT") {
                    return true; // Show all features if no ward is selected
                }
                return (
                    feature.properties.ward_name ===
                    wardDropdown.selectedOptions[0].textContent
                );
            },
            pointToLayer: function (feature, latlng) {
                // Define your marker styling here
                return L.marker(latlng, {
                    icon: L.icon({
                        iconUrl: "./Images/Ur.png", // URL to your marker icon image
                        iconSize: [32, 32], // Size of the icon
                        iconAnchor: [16, 16], // Anchor point of the icon
                    }),
                });
            },
            onEachFeature: function (feature, layer) {
                var properties = feature.properties;
                var popupContent =
                    "<div class='popup-content'>" +
                    "<b>Zone:</b> " +
                    properties.zonename +
                    "<br>" +
                    "<b>Ward:</b> " +
                    properties.wardName +
                    "<br>" +
                    "<b>Block Type:</b> " +
                    properties.blocktypen +
                    "<br>" +
                    "<b>Block Name:</b> " +
                    properties.BlockNam_1 +
                    "<br>" +
                    "<b>Mukadam:</b> " +
                    properties.Mokadam +
                    "<br>" +
                    "<b>No. of Seats:</b> " +
                    properties.NoOfSeats +
                    "<br>" +
                    "<b>Address:</b> " +
                    properties.Address +
                    "</div>";
                layer.bindPopup(popupContent);
            },
        });

        // Add the new geojsonLayer1 to the map
        ur.addTo(urlayer);
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const displayKothi = async () => {
    try {
        if (ko) {
            map.removeLayer(ko);
        }
        const { data } = await axios.get("./service/kothi.txt");
        console.log(data);

        var jsonData = data; // Parse response as JSON

        // Create GeoJSON layer with filtering and marker style
        ko = L.geoJSON(jsonData, {
            filter: function (feature) {
                if (wardDropdown.selectedOptions[0].textContent === "DEFAULT") {
                    return true; // Show all features if no ward is selected
                }
                return (
                    feature.properties.ward_name ===
                    wardDropdown.selectedOptions[0].textContent
                );
            },
            pointToLayer: function (feature, latlng) {
                // Define your marker styling here
                return L.marker(latlng, {
                    icon: L.icon({
                        iconUrl: "./Images/gf.png", // URL to your marker icon image
                        iconSize: [32, 32], // Size of the icon
                        iconAnchor: [16, 16], // Anchor point of the icon
                    }),
                });
            },
            onEachFeature: function (feature, layer) {
                var properties = feature.properties;
                var popupContent =
                    "<div class='popup-content'>" +
                    "<b>Kothi Name:</b> " +
                    properties.Kothiname +
                    "<br>";
                ("</div>");
                layer.bindPopup(popupContent);
            },
        });

        // Add the new geojsonLayer1 to the map
        ko.addTo(kothilayer);
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const displayFeeder = async () => {
    try {
        if (fd) {
            map.removeLayer(fd);
        }

        const { data } = await axios.get("./service/feeder.txt");
        console.log(data);

        var jsonData = data; // Parse response as JSON

        // Create GeoJSON layer with filtering and marker style
        fd = L.geoJSON(jsonData, {
            filter: function (feature) {
                if (wardDropdown.selectedOptions[0].textContent === "DEFAULT") {
                    return true; // Show all features if no ward is selected
                }
                return (
                    feature.properties.ward_name ===
                    wardDropdown.selectedOptions[0].textContent
                );
            },
            pointToLayer: function (feature, latlng) {
                // Define your marker styling here
                return L.marker(latlng, {
                    icon: L.icon({
                        iconUrl: "./Images/Feeder.png", // URL to your marker icon image
                        iconSize: [25, 25], // Size of the icon
                        iconAnchor: [12, 12], // Anchor point of the icon
                    }),
                });
            },
            onEachFeature: function (feature, layer) {
                var properties = feature.properties;
                var popupContent =
                    "<div class='popup-content'>" +
                    "<b>Feeder Name:</b> " +
                    properties.feedername +
                    "<br>";
                ("</div>");
                layer.bindPopup(popupContent);
            },
        });

        // Add the new geojsonLayer1 to the map
        fd.addTo(feederlayer);
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const displaySweeper = async () => {
    try {
        if (sr) {
            map.removeLayer(sr);
        }

        const { data } = await axios.get("./service/0607sw.txt");
        var jsonData = data; // Assuming data is already in JSON format

        console.log("sweeper static data", jsonData);
        console.log("Selected ward value:", wardDropdown.value);
        console.log(
            "Selected ward text:",
            wardDropdown.selectedOptions[0].textContent
        );
        console.log(
            "Selected kothi text:",
            kothiDropdown.selectedOptions[0].textContent
        );

        // Create GeoJSON layer with filtering
        sr = L.geoJSON(jsonData, {
            filter: function (feature) {
                const selectedWard = wardDropdown.selectedOptions[0].textContent;
                const wardValue = wardDropdown.value;
                const kothiValue = kothiDropdown.value;

                if (selectedWard === "DEFAULT" || wardValue === "0") {
                    return true; // Show all features if no ward is selected
                }

                if (wardValue && kothiValue !== "0") {
                    console.log("reached");
                    // const featureWardId = feature.properties.Fk_WardId.toString();
                    if (feature.properties.fk_kothiId) {
                        const featureKothiId = feature.properties.fk_kothiId.toString();
                        return featureKothiId === kothiValue;
                    }
                }

                if (wardValue) {
                    if (feature.properties.Fk_WardId) {
                        const featureWardId = feature.properties.Fk_WardId.toString();
                        return featureWardId === wardValue; // Compare as strings
                    }
                }

                // if (kothiDropdown.value !== "0") {
                //   // const featureWardId = feature.properties.Fk_WardId.toString();
                //   const featureKothiId = feature.properties.Fk_WardId.toString();

                //   return featureKothiId === kothiValue;
                // }
                // const featureWardId = feature.properties.Fk_WardId.toString();

                // return featureWardId === wardValue; // Compare as strings
            },
            style: function (feature) {
                // Define your polygon styling here
                return {
                    fillColor: "blue",
                    color: "blue",
                    weight: 1,
                    opacity: 1,
                    fillOpacity: 0.2,
                };
            },
            onEachFeature: function (feature, layer) {
                // Create a popup for each feature
                var popupContent = `
          <div class='popup-content'>
            <b>Sweeper Name:</b> ${feature.properties.vehicleNam || "N/A"}<br>
          </div>`;
                layer.bindPopup(popupContent);
            },
        });

        // Add the new geojsonLayer to the map and fit bounds
        sr.addTo(sweeperlayer);
        // map.fitBounds(sr.getBounds()); // Uncomment if you want to fit the map to the bounds of the layer
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const displayPadikHaddi = async () => {
    try {
        if (pk) {
            map.removeLayer(pk);
        }

        const { data } = await axios.get("./service/routewithpakki.txt");
        // const { data } = await axios.get("./service/0607sw1.txt");
        var jsonData = data; // Assuming data is already in JSON format

        console.log("sweeper static data", jsonData);
        console.log("Selected ward value:", wardDropdown.value);
        console.log(
            "Selected ward text:",
            wardDropdown.selectedOptions[0].textContent
        );
        console.log(
            "Selected kothi text:",
            kothiDropdown.selectedOptions[0].textContent
        );

        // Create GeoJSON layer with filtering
        pk = L.geoJSON(jsonData, {
            filter: function (feature) {
                const selectedWard = wardDropdown.selectedOptions[0].textContent;
                const wardValue = wardDropdown.value;

                if (selectedWard === "DEFAULT" || wardValue === "0") {
                    const featureVehicleName = feature.properties.vehicleNam;
                    return featureVehicleName === "Padik Haddi";
                } else if (wardValue) {
                    if (feature.properties.Fk_WardId) {
                        const featureWardId = feature.properties.Fk_WardId.toString();
                        const featureVehicleName = feature.properties.vehicleNam;
                        return (
                            featureWardId === wardDropdown.value &&
                            featureVehicleName === "Padik Haddi"
                        );
                    }
                }

                // if (kothiDropdown.value !== "0") {
                //   // const featureWardId = feature.properties.Fk_WardId.toString();
                //   const featureKothiId = feature.properties.Fk_WardId.toString();

                //   return featureKothiId === kothiValue;
                // }
                // const featureWardId = feature.properties.Fk_WardId.toString();

                // return featureWardId === wardValue; // Compare as strings
            },
            style: function (feature) {
                // Define your polygon styling here
                return {
                    fillColor: "red",
                    color: "red",
                    weight: 1,
                    opacity: 1,
                    fillOpacity: 0.2,
                };
            },
            onEachFeature: function (feature, layer) {
                // Create a popup for each feature
                var popupContent = `
          <div class='popup-content'>
            <b>Sweeper Name:</b> ${feature.properties.vehicleNam || "N/A"}<br>
          </div>`;
                layer.bindPopup(popupContent);
            },
        });

        // Add the new geojsonLayer to the map and fit bounds
        pk.addTo(padikHaddilayer);
        // map.fitBounds(sr.getBounds()); // Uncomment if you want to fit the map to the bounds of the layer
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const displayCw = async () => {
    try {
        if (cw) {
            map.removeLayer(cw);
        }

        const { data } = await axios.get("./service/cw.txt");
        /* console.log(data);*/

        var jsonData = data; // Parse response as JSON

        // Create GeoJSON layer with filtering
        cw = L.geoJSON(jsonData, {
            filter: function (feature) {
                if (wardDropdown.selectedOptions[0].textContent === "DEFAULT") {
                    return true; // Show all features if no ward is selected
                }
                return (
                    feature.properties.ward_name ===
                    wardDropdown.selectedOptions[0].textContent
                );
            },

            style: function (feature) {
                // Define your polygon styling here
                return {
                    fillColor: "blue",
                    color: "blue",
                    weight: 0.5,
                    opacity: 1,
                    fillOpacity: 0.1,
                };
            },
            onEachFeature: function (feature, layer) {
                // Create a popup for each feature
                var popupContent =
                    "<div class='popup-content'>" +
                    "<b>CW Pocket Name:</b> " +
                    feature.properties.Pocket_Nam +
                    "<br>" +
                    "</div>";

                layer.bindPopup(popupContent);
            },
        });

        // Add the new geojsonLayer to the map and fit bounds
        cw.addTo(cwlayer);
        // map.fitBounds(sr.getBounds());
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const displayGVP = async () => {
    try {
        if (GVP) {
            GVP.clearLayers();
        }

        const requestData = {
            storedProcedureName: "SP_putRouteLatLong",
            parameters: JSON.stringify({
                mode: 12,
                zoneId: zoneDropdown.value,
                WardId: wardDropdown.value,
            }),
        };

        const response = await axios.post(commonApi, requestData);

        if (!response.data.CommonMethodResult.CommonReportMasterList) return;

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let data = JSON.parse(commonReportMasterList);

        /*   console.log(data);*/

        const markerArray = [];

        for (const d of data) {
            marker = L.marker([d.latitute, d.longitude], {
                icon: degree,
            }).addTo(GVP);
            marker.bindPopup(`
            Sweeper: ${d.sweepername}
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

// Live data

const liveKothiData = async () => {
    try {
        // Validate that zone and ward are selected
        const zoneValue = zoneDropdown.value;
        const wardValue = wardDropdown.value;

        if (!zoneValue || zoneValue === "0" || !wardValue || wardValue === "" || wardValue === "0") {
            // Uncheck the Live Kothi checkbox
            $("#liveKothi").prop("checked", false);
            
            Swal.fire({
                position: "top-end",
                icon: "warning",
                title: "Please select Zone and Ward first!",
                showConfirmButton: false,
                timer: 500,
            });
            // Clear the layer if validation fails
            if (liveKothiLayer) {
                liveKothiLayer.clearLayers();
            }
            return;
        }

        const requestData = {
            storedProcedureName: "GetKothiDetails",
            parameters: JSON.stringify({
                Mode: 3,
                ZONEID: zoneValue,
                WARDID: wardValue,
            }),
        };

        const response = await axios.post(commonApi, requestData);

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

        if (liveKothiLayer) {
            liveKothiLayer.clearLayers();
        }

        /* console.log("live kothi data", data);*/

        const markerArray = [];

        for (const d of data) {
            // Validate that latitude and longitude are valid numbers
            if (d.kLatitude && d.kLongitude && 
                !isNaN(parseFloat(d.kLatitude)) && 
                !isNaN(parseFloat(d.kLongitude))) {
                marker = L.marker([d.kLatitude, d.kLongitude], {
                    icon: liveKothiI,
                }).addTo(liveKothiLayer);
                marker.bindPopup(`
              <b>Kothi Name:</b> ${d.KothiName}
              `);

                markerArray.push(marker);
            }
        }

        // Only fit bounds if we have valid markers
        if (markerArray.length > 0) {
            const bounds = L.latLngBounds(
                markerArray.map((marker) => marker.getLatLng())
            );

            // Fit the map to the bounds
            map.fitBounds(bounds);
        } else {
            Swal.fire({
                position: "top-end",
                icon: "info",
                title: "No valid kothi locations found!",
                showConfirmButton: false,
                timer: 1500,
            });
        }
    } catch (error) {
        console.error("Error fetching kothi data:", error);
        if (liveKothiLayer) {
            liveKothiLayer.clearLayers();
        }
    }
};

const liveCTPTUrinal = async () => {
    try {
        const requestData = {
            storedProcedureName: "proc_ctptdashboard",
            parameters: JSON.stringify({
                mode: 7,
                Accid: 11401,
                zoneId: zoneDropdown.value,
                WardId: wardDropdown.value,
                blocktypeid: 0,
            }),
        };

        const response = await axios.post(commonApi, requestData);

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

        /*  console.log("ctpturinal data", data);*/

        if (ctlayer) {
            ctlayer.clearLayers();
        }

        if (ptlayer) {
            ptlayer.clearLayers();
        }

        if (urlayer) {
            urlayer.clearLayers();
        }

        const markerArray = [];

        for (const d of data) {
            if (d.blocktypename === "CT") {
                marker = L.marker([d.Latitude, d.longitude], {
                    icon: ctI,
                }).addTo(ctlayer);
            } else if (d.blocktypename === "PT") {
                marker = L.marker([d.Latitude, d.longitude], {
                    icon: ptI,
                }).addTo(ptlayer);
            } else if (d.blocktypename === "Urinals") {
                marker = L.marker([d.Latitude, d.longitude], {
                    icon: urI,
                }).addTo(urlayer);
            }

            marker.bindPopup(`
                  <b>Zone:</b> ${d.zonename} <br>
                  <b>Ward:</b> ${d.wardName} <br>
                  <b>Block Name:</b> ${d.BlockName} <br>
                  <b>Address:</b> ${d.Address} <br>
                  <b>Block Type Name:</b> ${d.blocktypename} <br>
                  <b>Number of seats:</b> ${d.NoOfSeats} <br>
                  <b>Mokadum:</b> ${d.Mokadam} <br>
                  `);

            markerArray.push(marker);
        }

        const bounds = L.latLngBounds(
            markerArray.map((marker) => marker.getLatLng())
        );

        // Fit the map to the bounds
        map.fitBounds(bounds);
    } catch (error) {
        console.error("Error fetching kothi data:", error);
    }
};

const liveFeeder = async () => {
    try {
        // Validate that zone and ward are selected
        const zoneValue = zoneDropdown.value;
        const wardValue = wardDropdown.value;

        if (!zoneValue || zoneValue === "0" || !wardValue || wardValue === "" || wardValue === "0") {
            // Uncheck the Live Feeder checkbox
            $("#liveFeeder").prop("checked", false);
            
            Swal.fire({
                position: "top-end",
                icon: "warning",
                title: "Please select Zone and Ward first!",
                showConfirmButton: false,
                timer: 500,
            });
            // Clear the layer if validation fails
            if (liveFeederLayer) {
                liveFeederLayer.clearLayers();
            }
            return;
        }

        const requestData = {
            storedProcedureName: "GetKothiDetails",
            parameters: JSON.stringify({
                Mode: 4,
                ZONEID: zoneValue,
                WARDID: wardValue,
            }),
        };

        const response = await axios.post(commonApi, requestData);

        if (!response.data.CommonMethodResult.CommonReportMasterList) {
            Swal.fire({
                position: "top-end",
                icon: "info",
                title: "Feeder not found!",
                showConfirmButton: false,
                timer: 1500,
            });
            return;
        }

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        const data = JSON.parse(commonReportMasterList);

        if (liveFeederLayer) {
            liveFeederLayer.clearLayers();
        }

        /*  console.log("live feeder data", data);*/

        const markerArray = [];

        for (const d of data) {
            // Validate that latitude and longitude are valid numbers
            if (d.latitude && d.longitude && 
                !isNaN(parseFloat(d.latitude)) && 
                !isNaN(parseFloat(d.longitude))) {
                marker = L.marker([d.latitude, d.longitude], {
                    icon: blueFeederI,
                }).addTo(liveFeederLayer);
                marker.bindPopup(`
                  <b>Feeder Name:</b> ${d.feedername}
                  `);

                marker.bindTooltip(d.feedername, {
                    permanent: true,
                    direction: "bottom",
                    className: "transparent-tooltip",
                });

                markerArray.push(marker);
            }
        }
        // for (const d of data) {
        //   marker = L.marker([d.latitude, d.longitude], {
        //     icon: blueFeederI,
        //   }).addTo(liveFeederLayer);
        //   marker.bindPopup(`
        //               <b>Feeder Name:</b> ${d.feedername}
        //               `);

        //   markerArray.push(marker);
        // }

        // Only fit bounds if we have valid markers
        if (markerArray.length > 0) {
            const bounds = L.latLngBounds(
                markerArray.map((marker) => marker.getLatLng())
            );

            // Fit the map to the bounds
            map.fitBounds(bounds);
        } else {
            Swal.fire({
                position: "top-end",
                icon: "info",
                title: "No valid feeder locations found!",
                showConfirmButton: false,
                timer: 1500,
            });
        }
    } catch (error) {
        console.error("Error fetching kothi data:", error);
        if (liveFeederLayer) {
            liveFeederLayer.clearLayers();
        }
    }
};

const liveSweeperRoute = async () => {
    try {
        // Check if operation was cancelled
        if (!liveSweeperActive) {
            return;
        }

        $(".date-wrapper").show();
        let requestData = {};
        if (startdate.value && enddate.value) {
            requestData = {
                storedProcedureName: "GetKothiDetails",
                parameters: JSON.stringify({
                    Mode: 5,
                    ZONEID: zoneDropdown.value,
                    WARDID: wardDropdown.value,
                    // KOTHIID: kothiDropdown.value,
                    STARTDATE: `${startdate.value} 01:00:00`,
                    ENDDATE: `${enddate.value} 23:59:00`,
                }),
            };
        } else {
            requestData = {
                storedProcedureName: "GetKothiDetails",
                parameters: JSON.stringify({
                    Mode: 5,
                    ZONEID: zoneDropdown.value,
                    WARDID: wardDropdown.value,
                    // KOTHIID: kothiDropdown.value,
                    // STARTDATE: startdate.value,
                    // ENDDATE: enddate.value,
                }),
            };
        }

        /* console.log("this is here", requestData);*/
        const response = await axios.post(commonApi, requestData);

        // Check again if operation was cancelled during API call
        if (!liveSweeperActive) {
            if (liveSweeperLayer) {
                liveSweeperLayer.clearLayers();
            }
            return;
        }

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

        const data = JSON.parse(commonReportMasterList);
        /*  console.log(data);*/

        // Check again if operation was cancelled after parsing
        if (!liveSweeperActive) {
            if (liveSweeperLayer) {
                liveSweeperLayer.clearLayers();
            }
            return;
        }

        const vehicleCoordinates = {};

        // Process the vehicle data
        data.forEach((entry) => {
            const { fk_VehicleId, vehicleName, RouteLat, RouteLng } = entry;

            // Validate coordinates before adding
            if (RouteLat && RouteLng && 
                !isNaN(parseFloat(RouteLat)) && 
                !isNaN(parseFloat(RouteLng))) {
                if (!vehicleCoordinates[fk_VehicleId]) {
                    vehicleCoordinates[fk_VehicleId] = {
                        vehicleName,
                        coordinates: [],
                    };
                }

                vehicleCoordinates[fk_VehicleId].coordinates.push([RouteLat, RouteLng]);
            }
        });

        // Convert the object to an array of arrays for each vehicleId
        const result = Object.keys(vehicleCoordinates).map((fk_VehicleId) => ({
            vehicleId: fk_VehicleId,
            vehicleName: vehicleCoordinates[fk_VehicleId].vehicleName,
            coordinates: vehicleCoordinates[fk_VehicleId].coordinates,
        }));

        // Check again if operation was cancelled
        if (!liveSweeperActive) {
            if (liveSweeperLayer) {
                liveSweeperLayer.clearLayers();
            }
            return;
        }

        // Only call showPolyline once with the entire result array
        if (result.length > 0) {
            showPolyline(result, liveSweeperLayer);
        } else {
            if (liveSweeperLayer) {
                liveSweeperLayer.clearLayers();
            }
            Swal.fire({
                position: "top-end",
                icon: "info",
                title: "No valid routes found!",
                showConfirmButton: false,
                timer: 1500,
            });
        }
    } catch (error) {
        if (liveSweeperLayer) {
            liveSweeperLayer.clearLayers();
        }
        if (liveSweeperActive) {
            Swal.fire({
                icon: "info",
                title: "No route found",
            });
        }
        /*  console.error("Error fetching kothi data:", error);*/
        return;
    }
};

const liveMechSweeperRoute = async () => {
    try {
        const requestData = {
            storedProcedureName: "GetKothiDetails",
            parameters: JSON.stringify({
                Mode: 6,
                ZONEID: zoneDropdown.value,
                WARDID: wardDropdown.value,
                // KOTHIID: kothiDropdown.value,
            }),
        };

        const response = await axios.post(commonApi, requestData);

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
        //console.log(data);
        // for (const d of data) {
        // }

        const vehicleCoordinates = {};

        // Process the vehicle data
        data.forEach((entry) => {
            const { fk_VehicleId, vehicleName, RouteLat, RouteLng } = entry;

            if (!vehicleCoordinates[fk_VehicleId]) {
                vehicleCoordinates[fk_VehicleId] = {
                    vehicleName,
                    coordinates: [],
                };
            }

            vehicleCoordinates[fk_VehicleId].coordinates.push([RouteLat, RouteLng]);
        });

        // Convert the object to an array of arrays for each vehicleId
        const result = Object.keys(vehicleCoordinates).map((fk_VehicleId) => ({
            vehicleId: fk_VehicleId,
            vehicleName: vehicleCoordinates[fk_VehicleId].vehicleName,
            coordinates: vehicleCoordinates[fk_VehicleId].coordinates,
        }));

        //console.log("sweeper route data", data);
        //console.log("result", result);

        for (const data of result) {
            showPolyline(result, liveMechSweeperLayer);
        }
    } catch (error) {
        console.error("Error fetching kothi data:", error);
        if (liveMechSweeperLayer) {
            liveMechSweeperLayer.clearLayers();
        }
    }
};

// Map

const createPolyline = (coordinates, mech) => {
    if (mech) {
        //console.log("yes");
    }
    return L.polyline(coordinates, {
        fillColor: "green",
        color: mech ? "#34126d" : "green",
        // color: "blue",
        weight: 3,
        opacity: 1,
        fillOpacity: 0.9,
        colorOpacity: 0.2,
    });
};

const showPolyline = (data, layerName) => {
    // Check if operation was cancelled (for live sweeper)
    if (layerName === liveSweeperLayer && !liveSweeperActive) {
        return;
    }

    const polylines = [];

    if (layerName) {
        layerName.clearLayers();
    }

    // Validate data array
    if (!Array.isArray(data) || data.length === 0) {
        return;
    }

    for (const d of data) {
        // Validate coordinates before creating polyline
        if (!d.coordinates || !Array.isArray(d.coordinates) || d.coordinates.length < 2) {
            continue;
        }

        let polyline;
        if (layerName == liveMechSweeperLayer) {
            polyline = createPolyline(d.coordinates, true);
        } else {
            polyline = createPolyline(d.coordinates);
        }
        polyline.bindPopup(`
      <b>Vehicle Name:</b> ${d.vehicleName} <br>
    `);
        polyline.addTo(layerName);
        polylines.push(polyline);
    }

    // Only fit bounds if we have valid polylines
    if (polylines.length > 0) {
        // Check again if operation was cancelled before fitting bounds
        if (layerName === liveSweeperLayer && !liveSweeperActive) {
            return;
        }

        // Calculate bounds to fit all polylines
        const bounds = polylines.reduce(
            (acc, polyline) => {
                try {
                    const polyBounds = polyline.getBounds();
                    if (polyBounds && polyBounds.isValid()) {
                        return acc.extend(polyBounds);
                    }
                } catch (e) {
                    console.error("Error getting polyline bounds:", e);
                }
                return acc;
            },
            L.latLngBounds()
        );

        // Only fit bounds if we have a valid bounds object
        if (bounds.isValid()) {
            map.fitBounds(bounds);
        }
    }
};

window.addEventListener("load", populateZoneDropdown);

// Bootstrap

const toast = new bootstrap.Toast(document.getElementById("noDataToast"));

// const handleDownload = async () => {
//   try {
//     // Wait for all necessary data and map to be fully loaded
//     // await Promise.all([populateZoneDropdown(), liveFeeder(), liveSweeperRoute(), liveMechSweeperRoute()]);

//     // Wait for a short delay to ensure map rendering
//     // await new Promise((resolve) => setTimeout(resolve, 500));

//     // Capture the map as an image using HTML2Canvas
//     const canvas = await html2canvas(document.getElementById("map"), {
//       useCORS: true,
//       logging: true,
//       width: document.getElementById("map").offsetWidth,
//       height: document.getElementById("map").offsetHeight,
//       willReadFrequently: true,
//     });

//     // Convert the captured image to a PDF
//     const imgData = canvas.toDataURL("image/png");
//     const { jsPDF } = window.jspdf;
//     const pdf = new jsPDF("landscape", "pt", [canvas.width, canvas.height]);
//     pdf.addImage(imgData, "PNG", 0, 0, canvas.width, canvas.height);

//     // Save the PDF
//     pdf.save("map.pdf");
//   } catch (error) {
//     console.error("Error downloading map:", error);
//   }
// };

var printOptions = {
    documentTitle: `GIS Dashboard - ${new Date().toLocaleString()}`,
    closePopupsOnPrint: false,
};

var browserPrintControl = L.control.browserPrint(printOptions).addTo(map);

// Add event listener for printend event
map.on("browser-print-end", function () {
    alert("Map saved successfully!");
});
