const geofenceDropdown = document.getElementById("geofenceDropdown");
const geoNameInput = document.getElementById("geoNameInput");
const shapeTypeDropdown = document.getElementById("shapeTypeDropdown");
const latitudeInput = document.getElementById("latitudeInput");
const longitudeInput = document.getElementById("longitudeInput");
const radiusInput = document.getElementById("radiusInput");
const saveModal = document.getElementById("saveModal");

const btnShowGeofence = document.getElementById("btnShowGeofence");
const btnSaveShape = document.getElementById("btnSaveShape");

const populateGeofenceDropdown = async () => {
    try {
        geofenceDropdown.innerHTML = '<option value="0">Select Geofence</option>';

        const requestData = {
            storedProcedureName: "GET_ALLGEOFENCE_NAME",
            parameters: JSON.stringify({
                mode: 1,
            }),
        };

        const response = await axios.post(commonApi, requestData);
        console.log(response);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let dropdownData = JSON.parse(commonReportMasterList);

        for (const data of dropdownData) {
            const option = document.createElement("option");
            option.value = data.geoName;
            option.text = data.geoName;
            geofenceDropdown.appendChild(option);
        }
        geofenceDropdown.fstdropdown.rebind();
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

var map = L.map("map").setView([18.523204, 73.852011], 12);

L.tileLayer("https://{s}.tile.osm.org/{z}/{x}/{y}.png", {
    attribution:
        '&copy; <a href="https://osm.org/copyright">OpenStreetMap</a> contributors',
}).addTo(map);
L.Control.geocoder().addTo(map);

var drawnFeatures = new L.FeatureGroup();
map.addLayer(drawnFeatures);

var drawControl = new L.Control.Draw({
    edit: false,
    draw: {
        polygon: false,
        polyline: false,
        rectangle: false,
        circle: false,
        marker: {
            shapeOptions: {
                color: "steelblue",
            },
        },
    },
});
map.addControl(drawControl);

map.on("draw:created", function (e) {
    var layer = e.layer;
    drawnFeatures.addLayer(layer);

    var shapeType = "Point";
    var latitude = layer.getLatLng().lat.toFixed(4);
    var longitude = layer.getLatLng().lng.toFixed(4);

    shapeTypeDropdown.value = shapeType;
    latitudeInput.value = latitude;
    longitudeInput.value = longitude;

    layer.bindPopup(
        `<p>Shape Type: ${shapeType}<br>Latitude: ${latitude}<br>Longitude: ${longitude}</p>`
    );
});

map.on("draw:edited", function (e) {
    var layers = e.layers;
    layers.eachLayer(function (layer) {
        console.log(layer);
    });
});

/// Create a LayerGroup or FeatureGroup to store the markers
var markerGroup = L.layerGroup().addTo(map);
var filteredLayer = null;
var circle = null; // Initialize the circle variable

// Function to clear all markers from the map
function clearMarkers() {
    markerGroup.clearLayers(); // Clear all markers from the markerGroup
}

const showGeofenceonMap = async () => {
    // Clear the previous filtered layer, if any
    if (filteredLayer) {
        map.removeLayer(filteredLayer);
    }

    // Clear all markers from the markerGroup
    clearMarkers();

    try {
        const requestData = {
            storedProcedureName: "SP_GET_GEOFENCE_DETAILS",
            parameters: JSON.stringify({
                mode: 1,
                geoName: geofenceDropdown.value,
            }),
        };

        const response = await axios.post(commonApi, requestData);
        console.log(response);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let data = JSON.parse(commonReportMasterList);
        console.log("geofence details", data);

        var geo = data[0].geoName;
        var lat = data[0].latitude;
        var lon = data[0].longitude;
        var radius = data[0].radius || 1; // Set a default radius of 1 kilometer if not provided

        if (!map) {
            map = L.map("map").setView([18.523204, 73.852011], 13);
        }

        if (circle) {
            map.removeLayer(circle);
        }

        circle = L.circle([lat, lon], { radius: radius * 1000 }).addTo(map); // Convert radius to meters by multiplying with 1000

        // Update the filteredLayer with the new circle layer
        filteredLayer = L.featureGroup([circle]);
        circle
            .bindPopup(geo, { closeButton: false, className: "popup-style" })
            .addTo(map);
        // var circleCenter = circle.getLatLng();
        // map.setView(circleCenter);
        circle.openPopup();
        var layerBounds = filteredLayer.getBounds();
        if (layerBounds.isValid()) {
            // Set the desired zoom level
            var zoomLevel = 15;
            // Zoom to the bounds of the filtered layer
            map.fitBounds(layerBounds, { maxZoom: zoomLevel });
        } else {
            console.log("Invalid bounds. No features found or empty geometry.");
        }

        console.log(filteredLayer);
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

//const saveShape = async (event) => {
//    if (!geoNameInput.value && !latitudeInput.value && !longitudeInput.value) {
//        validationToast.show();
//        return;
//    }
//    event.preventDefault();

//    const requestData = {
//        storedProcedureName: "SP_GET_GEOFENCE_DETAILS",
//        parameters: JSON.stringify({
//            mode: 2,
//            geoName: sanitizeInput(geoNameInput.value),
//            latitude: sanitizeInput(parseFloat(latitudeInput.value)),
//            longitude: sanitizeInput(parseFloat(longitudeInput.value)),
//            radius: sanitizeInput(radiusInput.value),
//        }),
//    };

//    console.log("type of latitude", requestData);

//    const response = await axios.post(commonApi, requestData);
//    console.log(response);

//    successToast.show();
//    populateGeofenceDropdown();
//};

const saveShape = async (event) => {
    // Check if required fields are empty
    if (!geoNameInput.value || !latitudeInput.value || !longitudeInput.value) {
        validationToast.show();
        return;
    }

    // Validate latitude and longitude
    const latitude = parseFloat(latitudeInput.value);
    const longitude = parseFloat(longitudeInput.value);
    if (isNaN(latitude) || isNaN(longitude)) {
        // Handle invalid coordinates
        alert('Invalid coordinates');
        return;
    }

    event.preventDefault();

    const requestData = {
        storedProcedureName: "SP_GET_GEOFENCE_DETAILS",
        parameters: JSON.stringify({
            mode: 2,
            geoName: sanitizeInput(geoNameInput.value),
            latitude: latitude,
            longitude: longitude,
            radius: sanitizeInput(radiusInput.value),
        }),
    };

    try {
        const response = await axios.post(commonApi, requestData);
        console.log(response);
        successToast.show();
        populateGeofenceDropdown();
    } catch (error) {
        // Handle axios request error
        console.error('Error saving shape:', error);
        // Show error message to user
        alert('Failed to save shape. Please try again later.');
    }
};

window.addEventListener("load", async () => {
    await populateGeofenceDropdown();
});

const sanitizeInput = (input) => {
    return input.replace(/<[^>]*>?/gm, '');
};

// Bootstrap

const successToast = new bootstrap.Toast(
    document.getElementById("successToast")
);

const validationToast = new bootstrap.Toast(
    document.getElementById("validationToast")
);