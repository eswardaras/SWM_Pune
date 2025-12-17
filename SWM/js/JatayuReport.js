const zoneDropdown = document.getElementById("zoneDropdown");
const wardDropdown = document.getElementById("wardDropdown");
const jatayuNameDropdown = document.getElementById("jatayuNameDropdown");
const startDate = document.getElementById("startDate");
const endDate = document.getElementById("endDate");

let map;

const dateSpan = document.getElementById("dateSpan");
const btnSearch = document.getElementById("btnSearch");

const table = document.getElementById("table");
const imageTable = document.getElementById("imageTable");

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

const populateJatayuNameDropdown = async () => {
    try {
        jatayuNameDropdown.innerHTML =
            '<option value="0">Select Jatayu Name</option>';

        const requestData = {
            storedProcedureName: "proc_jatayucoveragereport",
            parameters: JSON.stringify({
                mode: 3,
                AccId: 11401,
                vehicleid: 0,
                zoneId: zoneDropdown.value,
                WardId: wardDropdown.value,
                startdate: startDate.value,
                enddate: endDate.value,
            }),
        };

        const response = await axios.post(commonApi, requestData);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let dropdownData = JSON.parse(commonReportMasterList);
        console.log(dropdownData);

        for (const data of dropdownData) {
            const option = document.createElement("option");
            option.value = data.pk_vehicleid;
            option.text = data.vehiclename;
            jatayuNameDropdown.appendChild(option);
            jatayuNameDropdown.fstdropdown.rebind();
        }
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const populateTable = async () => {
    try {
        $("#dateSpan").text(
            `Jatayu Report From ${startDate.value} To ${endDate.value}`
        );

        const tbody = table.querySelector("tbody");
        tbody.innerHTML = `<tr>
                          <td colspan='50' class='text-danger'>Loading...</td>
                       </tr>`;

        const jatayuReportRequestData = {
            storedProcedureName: "proc_jatayucoveragereport",
            parameters: JSON.stringify({
                mode: 4,
                AccId: 11401,
                RoleID: 0,
                AdminID: 0,
                ZoneId: zoneDropdown.value,
                WardId: wardDropdown.value,
                vehicleid: jatayuNameDropdown.value,
                startdate: startDate.value,
                enddate: endDate.value,
            }),
        };

        const response = await axios.post(commonApi, jatayuReportRequestData);
        console.log(response);

        tbody.innerHTML = "";
        if (!response.data.CommonMethodResult.CommonReportMasterList) {
            // const tableBody = table1.querySelector("tbody");
            tbody.innerHTML = `<tr>
                               <td colspan='50' class='text-danger'>
                                  <i class="fa-solid fa-triangle-exclamation mx-1"></i>
                                  No Data Found
                                </td>
                            </tr>`;
            return;
        }

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let tableData = JSON.parse(commonReportMasterList);
        console.log(tableData);

        setDataTable(table);

        let totalCronicSpot = tableData[0].CronicSpotcnt;
        let totalWasteCollected = tableData[0].WasteCnt;
        $("#cronicSpot").text(totalCronicSpot);
        $("#wasteCollected").text(totalWasteCollected);

        for (const data of tableData) {
            const tr = document.createElement("tr");
            tr.innerHTML = `<tr>
                       <td>${formatDate(data.date)}</td>
                       <td>${data.zonename}</td>
                       <td>${data.wardname}</td>
                       <td>${data.vehiclename}</td>
                       <td>${data.VisitedCronicSpot}</td>
                       <td>${data.TotalWaste}</td>
                       <td><button type=button class='btn btn-sm btn-secondary' onclick='handleViewImage(event)' value='${JSON.stringify(
                    data
                )}'>View Image</button></td>
                       <td><button type=button class='btn btn-sm btn-info text-white' onclick='handleViewHistory(event)' value='${JSON.stringify(
                    data
                )}'>View Map</button></td>
        </tr>`;

            table.querySelector("tbody").appendChild(tr);
        }
    } catch (error) {
        console.error("An error occurred while populating the table:", error);
        const tbody = table.querySelector("tbody");
        tbody.innerHTML = `<tr>
    <td colspan='50' class='text-danger'>
       <i class="fa-solid fa-triangle-exclamation mx-1"></i>
       No Data Found
     </td>
 </tr>`;
    }
};

const handleViewImage = async (event) => {
    const { value } = event.target;
    const data = JSON.parse(value);

    // imagesParameters.ZoneId = data.zonename;
    // imagesParameters.WardId = data.Wardid;
    // imagesParameters.vehicleid = data.fk_vehicleid;
    // imagesParameters.startdate = data.date;
    // imagesParameters.enddate = data.date;

    await populateImageTable(data);
    $("#photo").modal("show");
    console.log(imagesParameters);
};

const populateImageTable = async (data) => {
    try {
        const tbody = imageTable.querySelector("tbody");
        tbody.innerHTML = `<tr>
                          <td colspan='50' class='text-danger'>Loading...</td>
                       </tr>`;

        const imageTableRequestData = {
            storedProcedureName: "proc_jatayucoveragereport",
            parameters: JSON.stringify({
                mode: 5,
                Accid: loginId,
                zoneId: data.zonename,
                WardId: data.Wardid,
                vehicleid: data.fk_vehicleid,
                startdate: data.date,
                enddate: data.date,
            }),
        };

        console.log("imageTableRequestData", imageTableRequestData);

        const response = await axios.post(commonApi, imageTableRequestData);
        console.log(response);

        tbody.innerHTML = "";
        if (!response.data.CommonMethodResult.CommonReportMasterList) {
            // const tableBody = table1.querySelector("tbody");
            tbody.innerHTML = `<tr>
                               <td colspan='50' class='text-danger'>
                                  <i class="fa-solid fa-triangle-exclamation mx-1"></i>
                                  No Data Found
                                </td>
                            </tr>`;
            return;
        }

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let tableData = JSON.parse(commonReportMasterList);
        console.log(tableData);

        // setDataTable(imageTable);

        for (const data of tableData) {
            const tr = document.createElement("tr");
            tr.innerHTML = `<tr>
                       <td>${data.optime.split("T")[0]}</td>
                       <td>${data.optime.split("T")[1]}</td>
                       <td>${
                !data.cronic_spot_name ? "-" : data.cronic_spot_name
                }</td>
                       <td><img src='${trimUrl(
                    data.beforeimg
                )}' class='w-100'/></td>
                       <td><img src='${trimUrl(
                    data.afterimg
                )}' class='w-100'/></td>
        </tr>`;

            imageTable.querySelector("tbody").appendChild(tr);
        }
    } catch (error) {
        console.error("An error occurred while populating the table:", error);
    }
};

const trimUrl = (url) => {
    const fileName = url.substring(url.lastIndexOf("/") + 1);

    const fixUrl = "https://iswmpune.in/FineCollection/";
    const result = fixUrl + fileName;

    return result;
};

const handleViewHistory = (event) => {
    const { value } = event.target;
    const encodedData = encodeURIComponent(value);
    window.open(`jatayuMap.aspx?data=${encodedData}`, '_blank');
};

const viewLocation = async (data) => {
    map.eachLayer(function (layer) {
        if (layer instanceof L.Marker) {
            layer.remove();
        }
    });

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
    console.log(mapData);

    for (const data of mapData) {
        var marker = L.marker([data.lat, data.long]).addTo(map);
        marker.bindPopup(
            `<p>Name:- ${!data.cronic_spot_name ? "---" : data.cronic_spot_name}</p>
                      <p>Date:- ${data.optime.split("T")[0]}</p>
                      <p>Time:- ${data.optime.split("T")[1]}</p>`
        );
        marker.on("click", function () {
            this.openPopup();
        });
        map.panTo(new L.LatLng(data.lat, data.long));
    }
};

const initializeMap = () => {
    map = L.map("map").setView([18.5204, 73.8567], 18);

    var osm = L.tileLayer("https://{s}.tile.osm.org/{z}/{x}/{y}.png", {
        attribution:
            '&copy; <a href="https://osm.org/copyright">OpenStreetMap</a> contributors',
    }).addTo(map);
    map.addControl(new L.Control.Fullscreen());

    var bm = {
        "Base Map": osm,
    };

    // L.tileLayer("https://tile.openstreetmap.org/{z}/{x}/{y}.png", {
    //   maxZoom: 19,
    //   attribution:
    //     '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>',
    // }).addTo(map);
    // map.addControl(new L.Control.Fullscreen());
};

// Handlers

const handleZoneSelect = (event) => {
    populateWardDropdown();
};

const handleWardSelect = (event) => {
    populateJatayuNameDropdown();
};

// Listeners

btnSearch.addEventListener("click", async (e) => {
    e.preventDefault();

    if (startDate.value > endDate.value) {
        $("#error_warning").modal("show");
        return;
    }

    $("#tableWrapper").slideDown("slow");
    await populateTable();
    $("#countWrapper").slideDown("slow");
});

// DataTable

function setDataTable(tableId) {
    if ($.fn.DataTable.isDataTable(tableId)) {
        // DataTable is already initialized, no need to reinitialize
        $(tableId).DataTable().clear().draw();
        $(tableId).DataTable().destroy();
    }

    $(document).ready(function () {
        var table = $(tableId).DataTable({
            pageLength: 5,
            dom:
                "<'row'<'col-sm-12 col-md-6'B><'col-sm-12 col-md-6'f>>" +
                "<'row'<'col-sm-12'tr>>" +
                "<'row justify-content-between'<'col-sm-12 col-md-auto d-flex align-items-center'l><'col-sm-12 col-md-auto'i><'col-sm-12 col-md-auto'p>>",
            buttons: [
                {
                    extend: "excelHtml5",
                    text: "Excel <i class='fas fa-file-excel'></i>",
                    title: document.title,
                    className: "btn btn-sm btn-success mb-2", // Add your Excel button class here
                },
                {
                    extend: "pdf",
                    text: "PDF <i class='fa-regular fa-file-pdf'></i>",
                    title: document.title,
                    className: "btn btn-sm btn-danger mb-2", // Add your Excel button class here
                    customize: function (doc) {
                        // Set custom page size (width x height)
                        doc.pageOrientation = "landscape"; // or "portrait" for portrait orientation
                        doc.pageSize = "A4"; // or an array: [width, height]

                        // Set custom margins (left, right, top, bottom)
                        doc.pageMargins = [20, 20, 20, 20];
                    },
                },
                // "pdf",
                // "csvHtml5",
            ],
            language: {
                lengthMenu: "_MENU_  records per page",
                sSearch: "<img src='Images/search.png' alt='search'>",
                paginate: {
                    first: "First",
                    last: "Last",
                    next: "Next &rarr;",
                    previous: "&larr; Previous",
                },
            },
            lengthMenu: [
                [5, 10, 25, 50, -1],
                [5, 10, 25, 50, "All"],
            ],

            // use below code to disable sorting on first column
            order: [],
            columnDefs: [
                {
                    targets: "no-sort",
                    orderable: false,
                },
            ],

            // use below code to disable sorting on any column (0 based index/ use -1 for last column)
            // columnDefs: [{ orderable: false, targets: -1 }],
        });
    });
}

// Format date
function formatDate(input) {
    var datePart = input.match(/\d+/g),
        year = datePart[0],
        month = datePart[1],
        day = datePart[2];

    return day + "-" + month + "-" + year;
}

window.addEventListener("load", async () => {
    await populateZoneDropdown();
    await populateJatayuNameDropdown();
    initializeMap();
});
