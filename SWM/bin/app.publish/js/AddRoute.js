const zoneDropdown = document.getElementById("zoneDropdown");
const wardDropdown = document.getElementById("wardDropdown");
const routeDropdown = document.getElementById("routeDropdown");
const vehicleDropdown = document.getElementById("vehicleDropdown");
const newRouteInput = document.getElementById("newRouteInput");
const btnDraw = document.getElementById("btnDraw");
const fileInputKmlReplace = document.getElementById("fileInputKmlReplace");
const fileInputImport = document.getElementById("fileInputImport");

// Dropdowns

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

const populateRouteDropdown = async () => {
    try {
        routeDropdown.innerHTML = '<option value="0">Select Route</option>';

        const requestData = {
            storedProcedureName: "SP_putRouteLatLong",
            parameters: JSON.stringify({
                mode: 7,
                wardId: wardDropdown.value,
            }),
        };

        const response = await axios.post(commonApi, requestData);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let dropdownData = JSON.parse(commonReportMasterList);

        for (const data of dropdownData) {
            const option = document.createElement("option");
            option.value = data.RouteName;
            option.text = data.RouteName;
            routeDropdown.appendChild(option);
        }
        routeDropdown.fstdropdown.rebind();
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const populateVehicleDropdown = async () => {
    try {
        vehicleDropdown.innerHTML = '<option value="0">Select Vehicle</option>';

        const requestData = {
            storedProcedureName: "SP_GET_VEHICLEANDSWEEPER",
            parameters: JSON.stringify({
                mode: 1,
                zoneId: zoneDropdown.value,
                wardId: wardDropdown.value,
            }),
        };
        const response = await axios.post(commonApi, requestData);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let dropdownData = JSON.parse(commonReportMasterList);

        for (const data of dropdownData) {
            const option = document.createElement("option");
            option.value = data.fk_VehicleId;
            option.text = data.vehicleName;
            vehicleDropdown.appendChild(option);
        }
        vehicleDropdown.fstdropdown.rebind();
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const handleZoneSelect = async (event) => {
    await populateWardDropdown();
};

const handleWardSelect = async (event) => {
    await populateRouteDropdown();
    await populateVehicleDropdown();
};

const handleRouteSelect = async (event) => {
    $(".vehicle-component").hide(500);
};

const handleVehicleSelect = async (event) => {
    $(".route-component").hide(500);
};

window.addEventListener("load", populateZoneDropdown);

// Map

var map = L.map("map").setView([18.523204, 73.852011], 13);
L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
    attribution: "© OpenStreetMap contributors",
}).addTo(map);
map.addControl(new L.Control.Fullscreen());

var currentTimestamp;
var cordsData = [];
var clickedCoordinates = [];
var currentSelectionIndex = -1;
var count = 0;
var polylineLayer = L.layerGroup().addTo(map);
var markerLayer = L.layerGroup().addTo(map);

var isSelecting = false;

var totalDistance = 0;

// map.on("click", function (e) {
//   if (isSelecting) {
//     var lat = e.latlng.lat;
//     var lng = e.latlng.lng;

//     var currentDate = new Date();
//     var options = {
//       year: "numeric",
//       month: "2-digit",
//       day: "2-digit",
//       hour: "2-digit",
//       minute: "2-digit",
//       second: "2-digit",
//       fractionalSecondDigits: 3,
//       timeZone: "Asia/Kolkata",
//     };
//     currentTimestamp = currentDate
//       .toLocaleString("en-US", options)
//       .replace(/,/g, "");

//     clickedCoordinates.push([lat, lng]);
//     cordsData.push([lat, lng, null, count, currentTimestamp]);
//     count++;

//     polylineLayer.clearLayers();
//     markerLayer.clearLayers();

//     L.polyline(clickedCoordinates, { color: "red" }).addTo(polylineLayer);

//     currentSelectionIndex = clickedCoordinates.length - 1;

//     L.marker([lat, lng], {
//       icon: L.divIcon({ className: "custom-marker" }),
//     }).addTo(markerLayer);
//   }
// });

// Create a layer group to store all markers
var markersLayerGroup = L.layerGroup().addTo(map);

map.on("click", function (e) {
    // Check if the Ctrl key is pressed
    if (e.originalEvent.ctrlKey && isSelecting) {
        var lat = e.latlng.lat;
        var lng = e.latlng.lng;

        var currentDate = new Date();
        var options = {
            year: "numeric",
            month: "2-digit",
            day: "2-digit",
            hour: "2-digit",
            minute: "2-digit",
            second: "2-digit",
            fractionalSecondDigits: 3,
            timeZone: "Asia/Kolkata",
        };
        currentTimestamp = currentDate
            .toLocaleString("en-US", options)
            .replace(/,/g, "");

        clickedCoordinates.push([lat, lng]);
        cordsData.push([lat, lng, null, count, currentTimestamp]);
        count++;

        polylineLayer.clearLayers();

        // Create a marker with a custom icon and show the count on it
        var customIcon = L.divIcon({
            className: "custom-marker",
            html: "<div class='marker-label badge bg-primary'>" + count + "</div>",
        });

        var marker = L.marker([lat, lng], { icon: customIcon });

        // Add the marker to the markers layer group
        markersLayerGroup.addLayer(marker);

        // Draw the polyline using the clicked coordinates
        L.polyline(clickedCoordinates, { color: "red" }).addTo(polylineLayer);

        currentSelectionIndex = clickedCoordinates.length - 1;

        if (clickedCoordinates.length >= 2) {
            const startPoint = clickedCoordinates[0];
            const endPoint = clickedCoordinates[clickedCoordinates.length - 1];
            totalDistance = haversineDistance(
                startPoint[0],
                startPoint[1],
                endPoint[0],
                endPoint[1]
            );
            console.log(
                "Distance from starting point to end point: " +
                totalDistance.toFixed(2) +
                " km"
            );
        } else {
            console.log("Not enough points to calculate distance.");
        }
    }
});

function haversineDistance(lat1, lon1, lat2, lon2) {
    const earthRadius = 6371; // Radius of the Earth in kilometers
    const dLat = ((lat2 - lat1) * Math.PI) / 180;
    const dLon = ((lon2 - lon1) * Math.PI) / 180;
    const a =
        Math.sin(dLat / 2) * Math.sin(dLat / 2) +
        Math.cos((lat1 * Math.PI) / 180) *
        Math.cos((lat2 * Math.PI) / 180) *
        Math.sin(dLon / 2) *
        Math.sin(dLon / 2);
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    const distance = earthRadius * c;
    return distance;
}

const startSelection = () => {
    isSelecting = true;
};

const stopSelection = () => {
    isSelecting = false;
};

const undoSelection = () => {
    console.log("Before undo - clickedCoordinates:", clickedCoordinates);
    if (currentSelectionIndex >= 0) {
        clickedCoordinates.pop();
        console.log("After undo - clickedCoordinates:", clickedCoordinates);

        polylineLayer.clearLayers();
        markersLayerGroup.clearLayers(); // Clear all markers

        if (clickedCoordinates.length > 0) {
            // Recalculate distance if there are at least two points
            if (clickedCoordinates.length >= 2) {
                const startPoint = clickedCoordinates[0];
                const endPoint = clickedCoordinates[clickedCoordinates.length - 1];
                totalDistance = haversineDistance(
                    startPoint[0],
                    startPoint[1],
                    endPoint[0],
                    endPoint[1]
                );
                console.log(
                    "Distance from starting point to end point: " +
                    totalDistance.toFixed(2) +
                    " km"
                );
                // Now you can use the updated distanceInKm variable as needed
            } else {
                console.log("Not enough points to calculate distance.");
            }

            // Redraw the polyline and markers
            L.polyline(clickedCoordinates, { color: "red" }).addTo(polylineLayer);

            clickedCoordinates.forEach(function (coords, index) {
                var customIcon = L.divIcon({
                    className: "custom-marker",
                    html:
                        "<div class='marker-label badge bg-primary'>" +
                        (index + 1) +
                        "</div>",
                });

                var marker = L.marker(coords, { icon: customIcon }).addTo(
                    markersLayerGroup
                );
            });

            // Update the count variable to continue numbering
            count = clickedCoordinates.length;
        }

        currentSelectionIndex = clickedCoordinates.length - 1;
    }
};

const clearMap = () => {
    if (decorator) {
        map.removeLayer(decorator);
    }
    isSelecting = false;
    polylineLayer.clearLayers();
    markerLayer.clearLayers();
    clickedCoordinates = [];
};

$(document).ready(function () {
    $("#createRouteRadio").click(function () {
        if ($("#createRouteRadio").prop("checked")) {
            clearMap();
            startSelection();
        } else {
            clearMap();
        }
    });
});

let decorator = null; // Initialize decorator outside the function to ensure it's not reinitialized on each function call

const showPolylineOnMap = (coordinates) => {
    polylineLayer.clearLayers();
    markerLayer.clearLayers();

    // Check if coordinates array is empty or has insufficient points
    if (!Array.isArray(coordinates) || coordinates.length < 2) {
        console.error("Invalid coordinates array.");
        return;
    }

    const polyline = L.polyline(coordinates, { color: "red" }).addTo(
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
                    pixelSize: 20,
                    polygon: true,
                    pathOptions: { stroke: true, color: "#414181" },
                }),
            },
        ],
    }).addTo(map);

    decorator.addTo(map);

    coordinates.forEach((coords, index) => {
        if (index === 0) {
            L.marker(coords, {
                icon: L.divIcon({ className: "custom-start-marker" }),
            }).addTo(markerLayer);
        } else {
            L.marker(coords, {
                icon: L.divIcon({ className: "custom-marker" }),
            }).addTo(markerLayer);
        }
    });
};

// To insert new lat long
const newRouteLatLong = async (routeId, data) => {
    try {
        Swal.fire({
            title: "Processing",
            html: "Please wait...",
            allowOutsideClick: false,
            showConfirmButton: false,
            onBeforeOpen: () => {
                Swal.showLoading();
            },
        });
        for (const d of data) {
            const requestData = {
                storedProcedureName: "SP_putRouteLatLong",
                parameters: JSON.stringify({
                    mode: 1,
                    lat: d[0],
                    long: d[1],
                    routeId: routeId,
                    sequenceId: d[3],
                    opTime: d[4],
                }),
            };

            console.log(requestData);
            const response = await axios.post(commonApi, requestData);
            console.log(response);
        }

        Swal.close();
    } catch (error) {
        console.error("Error fetching data:", error);
        Swal.fire({
            icon: "error",
            title: "Error",
            text: "Failed to process data. Please try again later.",
        });
    }
};

const importRouteLatLong = async (routeId, data) => {
    try {
        Swal.fire({
            title: "Processing",
            html: "Please wait...",
            allowOutsideClick: false,
            showConfirmButton: false,
            onBeforeOpen: () => {
                Swal.showLoading();
            },
        });
        for (const [index, d] of data.entries()) {
            const requestData = {
                storedProcedureName: "SP_putRouteLatLong",
                parameters: JSON.stringify({
                    mode: 1,
                    lat: d[0],
                    long: d[1],
                    routeId: routeId,
                    sequenceId: index,
                }),
            };

            console.log(requestData);
            const response = await axios.post(commonApi, requestData);
            console.log(response);
        }
        Swal.close();
    } catch (error) {
        console.error("Error fetching data:", error);
        Swal.fire({
            icon: "error",
            title: "Error",
            text: "Failed to process data. Please try again later.",
        });
    }
};

const deleteRoute = async (routid, opid) => {
    try {
        const requestData = {
            storedProcedureName: "proc_VehicleMapwithRoute",
            parameters: JSON.stringify({
                Mode: 40,
                RouteId: routid,
                opId: opid,
            }),
        };

        const response = await axios.post(commonApi, requestData);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList;

        let data = JSON.parse(commonReportMasterList);
        return data;
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const createRoute = async (routid, opid, routekilometer) => {
    try {
        const requestData = {
            storedProcedureName: "proc_VehicleMapwithRoute",
            parameters: JSON.stringify({
                Mode: 57,
                RouteId: routid,
                opId: opid,
                routekilometer,
            }),
        };

        const response = await axios.post(commonApi, requestData);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList;

        let data = JSON.parse(commonReportMasterList);
        return data;
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const deleteRouteLatLong = async (routeid) => {
    try {
        const requestData = {
            storedProcedureName: "SP_putRouteLatLong",
            parameters: JSON.stringify({
                mode: 2,
                routeId: routeid,
            }),
        };

        const response = await axios.post(commonApi, requestData);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList;

        let data = JSON.parse(commonReportMasterList);
        console.log(data);
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

// View
const getRouteData = async () => {
    const requestData = {
        storedProcedureName: "SP_GETROUTEDATA",
        parameters: JSON.stringify({
            mode: 1,
            zoneId: zoneDropdown.value,
            wardId: wardDropdown.value,
            routeName: routeDropdown.value,
            fk_VehicleId: vehicleDropdown.value,
        }),
    };
    // console.log("before", requestData);
    const response = await axios.post(commonApi, requestData);

    const commonReportMasterList =
        response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

    let data = JSON.parse(commonReportMasterList);
    console.log("show route data", data);
    let dataArray = [];

    for (const d of data) {
        const array = [d.RouteLat, d.RouteLng];
        dataArray.push(array);
    }
    showPolylineOnMap(dataArray);
};

// Replace
const handleReplace = async () => {
    try {
        const info = await getOpIdForDelete();
        console.log(info);
        await deleteRoute(info.RouteId, info.opId);
        await createRoute(info.RouteId, info.opId, totalDistance);
        await deleteRouteLatLong(info.RouteId);
        await newRouteLatLong(info.RouteId, cordsData);

        const requestData = {
            storedProcedureName: "proc_VehicleMapwithRoute",
            parameters: JSON.stringify({
                Mode: 40,
                RouteId: info.routeId,
                opId: info.opId,
            }),
        };

        const response = await axios.post(commonApi, requestData);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList;

        let data = JSON.parse(commonReportMasterList);
        console.log(data);
        Swal.fire({
            title: "Done!",
            text: "Route Replaced SuccessFully",
            icon: "success",
        });
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const handleKmlReplace = async (event) => {
    const file = event.target.files[0];
    handleFile(event);
    console.log(file);
    const swalWithBootstrapButtons = Swal.mixin({
        customClass: {
            confirmButton: "btn btn-success me-2",
            cancelButton: "btn btn-danger",
        },
        buttonsStyling: false,
    });

    const userConfirmed = await swalWithBootstrapButtons.fire({
        title: "Are you sure?",
        text: "You want to replace this route?",
        icon: "warning",
        html: `
    You want to replace this route with ${file.name}?
  `,
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "Yes, Replace it!",
    });
    if (userConfirmed.isConfirmed) {
        cordsData = kmlCoordinates;
        await handleReplace();
        clearAll();
    } else {
        console.log("stopped");
    }
};

// Delete
// For getting RouteId and OpId for deleting the route
const getOpIdForDelete = async () => {
    try {
        const requestData = {
            storedProcedureName: "SP_putRouteLatLong",
            parameters: JSON.stringify({
                mode: 5,
                zoneId: zoneDropdown.selectedOptions[0].textContent,
                wardId: wardDropdown.value,
                routeName: routeDropdown.selectedOptions[0].textContent,
            }),
        };

        const response = await axios.post(commonApi, requestData);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let data = JSON.parse(commonReportMasterList);
        console.log(data);
        return data[0];
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const handleDelete = async () => {
    const userConfirmed = await Swal.fire({
        title: "Are you sure?",
        text: "You won't be able to revert this back",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "Yes, Delete it!",
    });

    if (userConfirmed.isConfirmed) {
        try {
            const info = await getOpIdForDelete();
            console.log(info);
            const requestData = {
                storedProcedureName: "proc_VehicleMapwithRoute",
                parameters: JSON.stringify({
                    Mode: 40,
                    opId: info.opId,
                    RouteId: info.RouteId,
                }),
            };

            console.log(requestData);

            const response = await axios.post(commonApi, requestData);

            const commonReportMasterList =
                response.data.CommonMethodResult.CommonReportMasterList;

            console.log(response);

            let data = JSON.parse(commonReportMasterList);
            if (data === null) {
                Swal.fire({
                    title: "Done!",
                    text: "Route Deleted SuccessFully",
                    icon: "success",
                });
                clearAll();
            }
        } catch (error) {
            console.error("Error fetching data:", error);
        }
    }
};

// Draw Route
const handleDrawRoute = () => {
    $("#btnReplaceWrapper").show("fast");
    clearMap();
    startSelection();
};

// Create
const handleCreate = async () => {
    if (
        zoneDropdown.value === "0" ||
        wardDropdown.value === "0" ||
        // vehicleDropdown.value === "0" ||
        !newRouteInput.value
    ) {
        Swal.fire({
            icon: "info",
            title: "Attention",
            text: "Please select zone, ward, vehicle name and enter a route name",
        });
        return;
    }
    try {
        const validate = await validateRouteName();
        if (validate) {
            // let rowData = await getOpId();
            // console.log(rowData);
            // const requestData = {
            //   storedProcedureName: "proc_VehicleMapwithRoute_1",
            //   parameters: JSON.stringify({
            //     mode: 38,
            //     FK_AccId: rowData.FK_AccId,
            //     // opId: rowData.opId,
            //     Geoname: newRouteInput.value,
            //     Fk_ZoneId: rowData.Fk_ZoneId,
            //     FK_WardId: rowData.Fk_WardId,
            //   }),
            // };

            const requestData = {
                storedProcedureName: "proc_VehicleMapwithRoute_1",
                parameters: JSON.stringify({
                    mode: 38,
                    FK_AccId: 11401,
                    opId: 11401,
                    Geoname: newRouteInput.value,
                    Fk_ZoneId: zoneDropdown.value,
                    FK_WardId: wardDropdown.value,
                }),
            };

            console.log("handleCreate mode 38 response", requestData);
            const response = await axios.post(commonApi, requestData);
            console.log(response);

            const commonReportMasterList =
                response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

            let data = JSON.parse(commonReportMasterList);
            console.log("mydata", data);
            let newRouteId = data[0].Column1;
            await createRoute(newRouteId, 11401, totalDistance);
            await newRouteLatLong(newRouteId, cordsData);

            Swal.fire({
                title: "Done!",
                text: "New Route Created SuccessFully",
                icon: "success",
            });
        }
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

// Upload KML
const handleFile = (event) => {
    const file = event.target.files[0];

    if (file) {
        const reader = new FileReader();

        reader.onload = function (e) {
            const kmlText = e.target.result;
            const parser = new DOMParser();
            const kmlDoc = parser.parseFromString(kmlText, "text/xml");
            console.log(kmlDoc);
            const coordinates = extractCoordinates(kmlDoc);
            console.log(coordinates);
        };

        reader.readAsText(file);
    }
};

const kmlCoordinates = [];
// const extractCoordinates = (kmlDoc) => {
//   const placemarks = kmlDoc.querySelectorAll("Placemark");

//   placemarks.forEach((placemark) => {
//     const coordinatesText = placemark.querySelector("coordinates").textContent;
//     // const [longitude, latitude] = coordinatesText
//     //   .split(",")
//     //   .map((coord) => parseFloat(coord.trim()));
//     // coordinates.push({ latitude, longitude });
//     console.log("coordinatesText", coordinatesText);

//     const coordinatePairs = coordinatesText.split(" ");
//     console.log("coordinatePairs", coordinatePairs);

//     // Extract latitude and longitude from each coordinate pair
//     const finalcoordinates = coordinatePairs.map((pair, index) => {
//       const [longitude, latitude] = pair
//         .split(",")
//         .map((coord) => parseFloat(coord.trim()));
//       kmlCoordinates.push([latitude, longitude]);

//       if (index > 0) {
//         const prevPair = coordinatePairs[index - 1];
//         const [prevLon, prevLat] = prevPair
//           .split(",")
//           .map((coord) => parseFloat(coord.trim()));

//         // Accumulate distance
//         totalDistance += haversineDistance(
//           prevLat,
//           prevLon,
//           latitude,
//           longitude
//         );
//       }
//     });

//     console.log(totalDistance);
//     // totalDistance = haversineDistance();
//   });
//   console.log("kmlCoordinates", kmlCoordinates);

//   return kmlCoordinates;
// };

const extractCoordinates = (kmlDoc) => {
    const placemarks = kmlDoc.querySelectorAll("Placemark");

    placemarks.forEach((placemark) => {
        const coordinatesText = placemark
            .querySelector("coordinates")
            .textContent.trim();

        // Split the coordinates text into individual coordinate pairs
        const coordinatePairs = coordinatesText.split(/\s+/);

        // Extract latitude and longitude from each coordinate pair
        coordinatePairs.forEach((pair, index) => {
            const [longitude, latitude] = pair
                .split(",")
                .map((coord) => parseFloat(coord.trim()));

            kmlCoordinates.push([latitude, longitude]);

            if (index > 0) {
                const prevPair = coordinatePairs[index - 1];
                const [prevLon, prevLat] = prevPair
                    .split(",")
                    .map((coord) => parseFloat(coord.trim()));

                // Accumulate distance using the Haversine formula
                totalDistance += haversineDistance(
                    prevLat,
                    prevLon,
                    latitude,
                    longitude
                );
            }
        });
    });

    console.log("kmlCoordinates", kmlCoordinates);
    console.log("Total Distance:", totalDistance, "km");

    return kmlCoordinates;
};

// For getting Accid, Zone, Ward for KML upload
const getZoneWard = async () => {
    try {
        const requestData = {
            storedProcedureName: "SP_putRouteLatLong",
            parameters: JSON.stringify({
                mode: 8,
                zoneName: zoneDropdown.selectedOptions[0].textContent,
                wardId: wardDropdown.value,
            }),
        };

        const response = await axios.post(commonApi, requestData);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let data = JSON.parse(commonReportMasterList);
        console.log(data);
        return data[0];
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const handleUploadKML = async () => {
    try {
        const validate = await validateRouteName();
        if (validate) {
            let rowData = await getZoneWard();
            const requestData = {
                storedProcedureName: "proc_VehicleMapwithRoute_1",
                parameters: JSON.stringify({
                    mode: 38,
                    Fk_accid: rowData.FK_AccId,
                    opId: 11401,
                    Geoname: newRouteInput.value,
                    Fk_ZoneId: rowData.Fk_ZoneId,
                    FK_WardId: rowData.Fk_WardId,
                }),
            };
            const response = await axios.post(commonApi, requestData);
            console.log(response);

            const commonReportMasterList =
                response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

            let data = JSON.parse(commonReportMasterList);

            let newRouteId = data[0].Column1;
            await createRoute(newRouteId, 11401, totalDistance);
            await importRouteLatLong(newRouteId, kmlCoordinates);

            console.log(kmlCoordinates);

            Swal.fire({
                title: "Done!",
                text: "New route created SuccessFully",
                icon: "success",
            });
            clearAll();
        }
    } catch (error) {
        console.error("Error fetching data:", error);
        Swal.fire({
            title: "Oops...",
            text: "Something went wrong!",
            icon: "error",
        });
    }
};

// Refresh
const handleRefresh = () => {
    location.reload();
};

// Validate if the route name already exists or not
const validateRouteName = async () => {
    try {
        const requestData = {
            storedProcedureName: "SP_putRouteLatLong",
            parameters: JSON.stringify({
                mode: 6,
                checkRouteName: newRouteInput.value,
            }),
        };

        const response = await axios.post(commonApi, requestData);

        if (response.data.CommonMethodResult.CommonReportMasterList) {
            const commonReportMasterList =
                response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

            let data = JSON.parse(commonReportMasterList);
            console.log("response", data);
            if (data[0].RouteId === 0) {
                console.log(data[0].RouteId);
                return true;
            } else {
                console.log(data[0].RouteId);
                Swal.fire({
                    icon: "error",
                    title: "Oops",
                    text: "Route name already exists try something new",
                });
                return false;
            }
        } else {
            Swal.fire({
                icon: "error",
                title: "Oops",
                text: "Route name already exists try something new",
            });
            return false;
        }
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

// Get zone, ward, opid, fkaccid
const getOpId = async () => {
    try {
        const requestData = {
            storedProcedureName: "SP_putRouteLatLong",
            parameters: JSON.stringify({
                mode: 4,
                zoneId: zoneDropdown.selectedOptions[0].textContent,
                wardId: wardDropdown.value,
                vehicleId: vehicleDropdown.value,
            }),
        };

        const response = await axios.post(commonApi, requestData);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let data = JSON.parse(commonReportMasterList);
        console.log(data);
        return data[0];
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

// Clear all inputs
const clearAll = () => {
    // reset dropdowns
    zoneDropdown.fstdropdown.setValue("0");
    wardDropdown.fstdropdown.setValue("0");
    routeDropdown.fstdropdown.setValue("0");
    vehicleDropdown.fstdropdown.setValue("0");

    //reset inputs
    newRouteInput.value = "";
    fileInputKmlReplace.value = "";
    fileInputImport.value = "";

    //reset variables
    totalDistance = 0;
    cordsData.length = 0;
    kmlCoordinates.length = 0;

    //clear map
    if (decorator) {
        map.removeLayer(decorator);
    }
    polylineLayer.clearLayers();
    markerLayer.clearLayers();
};
