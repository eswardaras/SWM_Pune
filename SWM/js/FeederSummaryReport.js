const zoneDropdown = document.getElementById("zoneDropdown");
const wardDropdown = document.getElementById("wardDropdown");
const routeDropdpown = document.getElementById("routeDropdpown");
const vehicleDropdpown = document.getElementById("vehicleDropdpown");
const startDate = document.getElementById("startDate");
const endDate = document.getElementById("endDate");

const dateSpan = document.getElementById("dateSpan");
const btnSearch = document.getElementById("btnSearch");
const table1 = document.getElementById("table1");
const table2 = document.getElementById("table2");

//const zoneApi = "https://iswmpune.in/SWMServiceLive/SWMService.svc/GetZone";
//const wardApi = "https://iswmpune.in/SWMServiceLive/SWMService.svc/GetWard";
//const vehicleApi =
//    "https://iswmpune.in/SWMService.svc/GetVehicle";
//const kothiApi = "https://iswmpune.in/SWMServiceLive/SWMService.svc/GetKothi";
//const routeApi = "https://iswmpune.in/SWMServiceLive/SWMService.svc/GetRoute";
//const commonApi =
//    "https://iswmpune.in/SWMServiceLive/SWMService.svc/CommonMethod";
//const loginId = 11401;

// AJAX requests

const populateZoneDropdown = async () => {
    try {
        const response = await axios.post(zoneApi, {
            mode: 11,
            vehicleId: 0,
            AccId: loginId,
        });

        const zoneMasterList = response.data.GetZoneResult.ZoneMasterList;
        console.log("Zonelist", zoneMasterList)

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
        routeDropdpown.innerHTML = '<option value="0">Select Route</option>';

        const response = await axios.post(routeApi, {
            mode: 24,
            Fk_accid: 11401,
            FK_VehicleID: 0,
            Fk_ZoneId: zoneDropdown.value || 0,
            FK_WardId: wardDropdown.value || 0,
            Startdate: "",
            Enddate: "",
        });

        const RouteMasterList = response.data.GetRouteResult.RouteMasterList;

        for (const route of RouteMasterList) {
            const option = document.createElement("option");
            option.value = route.RouteId;
            option.text = route.RouteName;
            routeDropdpown.appendChild(option);
        }
        routeDropdpown.fstdropdown.rebind();
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const populateVehicleDropdown = async () => {
    try {
        vehicleDropdpown.innerHTML = '<option value="0">Select Vehicle</option>';

        const response = await axios.post(vehicleApi, {
            mode: 3,
            FK_VehicleID: 0,
            zoneId: zoneDropdown.value || 0,
            WardId: wardDropdown.value || 0,
            sDate: "",
            eDate: "",
            UserID: 11401,
            zoneName: 0,
            WardName: 0,
        });

        const vehicleMasterList = response.data.GetVehicleResult.VehicleMasterList;

        for (const vehicle of vehicleMasterList) {
            const option = document.createElement("option");
            option.value = vehicle.PK_VehicleId;
            option.text = vehicle.vehicleName;
            vehicleDropdpown.appendChild(option);
            vehicleDropdpown.fstdropdown.rebind();
        }
        vehicleDropdpown.fstdropdown.rebind();
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const getData = async () => {
    try {
        // Basic validation – ensure dates are present
        if (!startDate.value || !endDate.value) {
            alert("Please select both From Date and To Date.");
            return;
        }

        dateSpan.innerHTML = `Feeder Summary Report:- From ${formatDate(
            startDate.value
        )} To ${formatDate(endDate.value)}`;

        let sData = new Date(startDate.value);
        let eData = new Date(endDate.value);

        // Normalize empty dropdowns to 0 so that backend treats them as "All"
        const vehicleId =
            vehicleDropdpown.value === "" || vehicleDropdpown.value === "0"
                ? 0
                : Number(vehicleDropdpown.value);
        const zoneId =
            zoneDropdown.value === "" || zoneDropdown.value === "0"
                ? 0
                : Number(zoneDropdown.value);
        const wardId =
            wardDropdown.value === "" || wardDropdown.value === "0"
                ? 0
                : Number(wardDropdown.value);
        const routeId =
            routeDropdpown.value === "" || routeDropdpown.value === "0"
                ? 0
                : Number(routeDropdpown.value);

        const requestData = {
            storedProcedureName: "sp_FEEDER_REPORT",
            parameters: JSON.stringify({
                mode: 1,
                vehicleId: vehicleId,
                fkid: loginId,
                zoneid: zoneId,
                wardid: wardId,
                STARTDATE: startDate.value,
                ENDDATE: endDate.value,
                RouteId: routeId,
            }),
        };

        const response = await axios.post(commonApi, requestData);
        console.log(response);

        if (!response.data.CommonMethodResult.CommonReportMasterList) {
            alert("no data found");
            return;
        }

        const data1 =
            response.data.CommonMethodResult.CommonReportMasterList[1].ReturnValue;
        const data2 =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let tableData1 = JSON.parse(data1);
        let tableData2 = JSON.parse(data2);

        console.log(tableData1);
        console.log(tableData2);

        if ((eData - sData) / (1000 * 60 * 60 * 24) >= 30) {
            function createExcelFile(data, sheetName) {
                const ws = XLSX.utils.json_to_sheet(data);
                const wb = XLSX.utils.book_new();
                XLSX.utils.book_append_sheet(wb, ws, sheetName);
                return XLSX.write(wb, { bookType: "xlsx", type: "binary" });
            }

            function s2ab(s) {
                const buf = new ArrayBuffer(s.length);
                const view = new Uint8Array(buf);
                for (let i = 0; i < s.length; i++) view[i] = s.charCodeAt(i) & 0xff;
                return buf;
            }

            const zip = new JSZip();

            zip.file(
                "FeederSummaryReportOverall.xlsx",
                s2ab(createExcelFile(tableData1, "Sheet1")),
                {
                    binary: true,
                }
            );
            zip.file(
                "FeederSummaryReport.xlsx",
                s2ab(createExcelFile(tableData2, "Sheet1")),
                {
                    binary: true,
                }
            );

            zip.generateAsync({ type: "blob" }).then(function (content) {
                Swal.close();
                saveAs(content, "FeederSummaryReport.zip");
            });

            return;
        } else {
            populateTable1(tableData1);
            populateTable2(tableData2);
        }
    } catch (error) {
        alert("no data found");
        // Log more details to help understand API errors (e.g. 404, 500)
        if (error.response) {
            console.error(
                "Error fetching data:",
                error.response.status,
                error.response.statusText,
                error.response.data
            );
        } else {
            console.error("Error fetching data:", error.message || error);
        }
    }
};

const populateTable1 = async (tableData) => {
    try {
        $("#table1 tbody").html("");
        setDataTable(table1);
        let srNo = 0;
        for (const data of tableData) {
            srNo++;
            const tr = document.createElement("tr");
            tr.innerHTML = `<tr>
            <td>${srNo}</td>
            <td>${data.TOTAL_FEEDER}</td>
            <td>${data.COVER_FEEDER}</td>
            <td>${data.UNCOVER_FEEDER}</td>
            <td>${data.UNATTENDED_FEEDER}</td>
            <td>${data.PERCENT_COVER}</td>
        </tr>`;

            table1.querySelector("tbody").appendChild(tr);

            $("#btnTotalFeeder").html(data.TOTAL_FEEDER);
            $("#btnCoverFeeder").html(data.COVER_FEEDER);
            $("#btnUncoverFeeder").html(data.UNCOVER_FEEDER);
            $("#btnUnattendedFeeder").html(data.UNATTENDED_FEEDER);
            $("#btnPercentage").html(data.PERCENT_COVER);
        }
    } catch (error) {
        console.error("An error occurred while populating the table:", error);
    }
};

const populateTable2 = async (tableData) => {
    try {
        $("#table2 tbody").html("");
        setDataTable(table2);
        let srNo = 0;
        for (const data of tableData) {
            srNo++;
            const tr = document.createElement("tr");
            tr.innerHTML = `<tr>
            <td>${srNo}</td>
            <td>${data.DATE}</td>
            <td>${data.ZONE}</td>
            <td>${data.WARD}</td>
            <td>${data.ROUTE}</td>
            <td>${data.VEHICLE}</td>
            <td>${data.TOTAL_FEEDER}</td>
            <td>${data.COVER_FEEDER}</td>
            <td>${data.UNCOVER_FEEDER}</td>
            <td>${data.UNATTENDED_FEEDER}</td>
            <td>${data.PERCENT_COVER}</td>
            <td><button type='button' class='btn btn-sm btn-info text-white' value='${JSON.stringify(
                    data
                )}' onclick='handleViewRoute(event)'>View Route</button></td>
        </tr>`;

            table2.querySelector("tbody").appendChild(tr);
        }
    } catch (error) {
        console.error("An error occurred while populating the table:", error);
    }
};

const handleViewRoute = (event) => {
    // const data = JSON.parse(target.value);
    // console.log(data);

    const { value } = event.target;
    try {
        const parsedValue = JSON.parse(value);
        console.log(parsedValue);
        const dataToPass = {
            vehicleId: parsedValue.FK_VEHICLEID,
            date: parsedValue.DATE,
            routeid: parsedValue.FK_RID,
            vehiclename: parsedValue.VEHICLE,
            zonename: parsedValue.ZONE,
            wardname: parsedValue.WARD,
        };

        const jsonString = JSON.stringify(dataToPass); // Convert the new object to a JSON string
        const encodedData = encodeURIComponent(jsonString); // Encode the JSON string
        console.log(encodedData);
        window.open(`FeederSummaryMap.aspx?data=${encodedData}`, "_blank");
    } catch (error) {
        console.error("Failed to process data", error);
    }
};

// Handlers

const handleZoneSelect = () => {
    populateWardDropdown();
};

const handleWardSelect = () => {
    populateRouteDropdown();
    populateVehicleDropdown();
};

const handleRouteSelect = () => {
    populateVehicleDropdown();
};

const handleMonthSelect = (event) => {
    const { value } = event.target;
    const selectedMonth = event.target.options[event.target.selectedIndex].text;
    setMonth(value);
};

const handleWeekSelect = (event) => {
    const { value: weekNumber } = event.target;
    setWeek(weekNumber);
};

// Listners

btnSearch.addEventListener("click", async (e) => {
    e.preventDefault();

    let sData = new Date(startDate.value);
    let eData = new Date(endDate.value);

    if ((eData - sData) / (1000 * 60 * 60 * 24) < 30) {
        $("#tableWrapper").slideDown("slow");
        $("#table1 tbody").html(`<tr>
      <td colspan='50' class='text-danger'>Loading...</td>
    </tr>`);
        $("#table2 tbody").html(`<tr>
      <td colspan='50' class='text-danger'>Loading...</td>
    </tr>`);

        await getData();
    } else {
        Swal.fire({
            title: "Please wait",
            html: "Preparing to download the excel file",
            allowOutsideClick: false,
            didOpen: () => {
                Swal.showLoading();
            },
        });

        await getData();
    }
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
let ddlMonthSelect;

function formatDate(input) {
    var datePart = input.match(/\d+/g),
        year = datePart[0],
        month = datePart[1],
        day = datePart[2];

    return day + "-" + month + "-" + year;
}

const setWeek = (weekNumber) => {
    let date = new Date();
    let dateMonth = new Date();
    dateMonth.setMonth(0);
    let firstDay;
    let lastDay;
    let month = ddlMonthSelect
        ? dateMonth.getMonth() + (ddlMonthSelect - 1)
        : date.getMonth();
    if (weekNumber == 1) {
        firstDay = new Date(date.getFullYear(), month, 1).toLocaleDateString(
            "en-GB"
        );

        lastDay = new Date(date.getFullYear(), month, 7).toLocaleDateString(
            "en-GB"
        );
    } else if (weekNumber == 2) {
        console.log("weekNumber", weekNumber);
        firstDay = new Date(date.getFullYear(), month, 8).toLocaleDateString(
            "en-GB"
        );

        lastDay = new Date(date.getFullYear(), month, 15).toLocaleDateString(
            "en-GB"
        );
    } else if (weekNumber == 3) {
        console.log("weekNumber", weekNumber);
        firstDay = new Date(date.getFullYear(), month, 16).toLocaleDateString(
            "en-GB"
        );

        lastDay = new Date(date.getFullYear(), month, 22).toLocaleDateString(
            "en-GB"
        );
    } else if (weekNumber == 4) {
        console.log("weekNumber", weekNumber);
        firstDay = new Date(date.getFullYear(), month, 23).toLocaleDateString(
            "en-GB"
        );

        lastDay = new Date(date.getFullYear(), month + 1, 0).toLocaleDateString(
            "en-GB"
        );
    } else {
        const currentDate = new Date().toISOString().substr(0, 10);
        startDate.value = currentDate;
        endDate.value = currentDate;
        return;
    }

    // dateWiseWeightReportParameters.date1 = formatDateForInput(firstDay);
    // dateWiseWeightReportParameters.date2 = formatDateForInput(lastDay);
    startDate.value = formatDateForInput(firstDay);
    endDate.value = formatDateForInput(lastDay);
};

const setMonth = (selectedMonth) => {
    ddlMonthSelect = selectedMonth;
    var startDate1 = new Date(new Date().getFullYear(), selectedMonth - 1, 1);

    var endDate1 = new Date(new Date().getFullYear(), selectedMonth, 0);

    var formattedStartDate = startDate1.toLocaleDateString("en-GB");
    var formattedEndDate = endDate1.toLocaleDateString("en-GB");

    startDate.value = formatDateForInput(formattedStartDate);
    endDate.value = formatDateForInput(formattedEndDate);
};

function formatDateForInput(input) {
    var datePart = input.match(/\d+/g),
        day = datePart[0],
        month = datePart[1],
        year = datePart[2];

    return year + "-" + month + "-" + day;
}

// Bootstrap

const toast = new bootstrap.Toast(document.getElementById("noDataToast"));

// on Window load

window.addEventListener("load", async () => {
    await populateZoneDropdown();
    // await populateRouteDropdown();
    // await populateVehicleDropdown();
});
