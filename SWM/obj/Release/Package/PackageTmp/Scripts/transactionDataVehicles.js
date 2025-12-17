const textA1 = document.getElementById("textA1");
const textA2 = document.getElementById("textA2");
const textA3 = document.getElementById("textA3");
const textA4 = document.getElementById("textA4");
const textA5 = document.getElementById("textA5");
const textA6 = document.getElementById("textA6");
const textA7 = document.getElementById("textA7");
const textA8 = document.getElementById("textA8");
const textA9 = document.getElementById("textA9");
const textA10 = document.getElementById("textA10");
const textA11 = document.getElementById("textA11");

const dropdown1 = document.getElementById("dropdown1");

const dateSpan = document.getElementById("dateSpan");
const btnSubmit = document.getElementById("btnSubmit");
const btnView = document.getElementById("btnView");

const table = document.getElementById("table");

const commonApi =
    "https://iswmpune.in/SWMServiceLive/SWMService.svc/CommonMethod";

const forInsertParameters = {
    mode: 2,
    PreventiveMaintenance: "",
    BreakdownMaintenance: "",
    RTOpassingalerts: "",
    PurchaseYear: "",
    Cost: "",
    Depreciation: "",
    Insurance: "",
    Vehiclenumber: "",
    AlertType: "Painting",
    OtherVehicle: "",
    FuelDataConsumption: "",
    DailyUtilizationDataBackhoeLoaders: "",
};

const forSelectParameters = {
    mode: 1,
};

const insertData = async () => {
    try {
        const forInsertRequestData = {
            storedProcedureName: "Sp_Transactional_data_vehicles",
            parameters: JSON.stringify(forInsertParameters),
        };

        const response = await axios.post(commonApi, forInsertRequestData);
        console.log(response);

        if (response.data.CommonMethodResult.Message === "success") {
            $("#message_modal").modal("show");

            $("#tableWrapper").slideDown("slow");
            populateTable();
        }
    } catch (error) {
        console.error("An error occurred while populating the table:", error);
    }
};

const populateTable = async () => {
    try {
        const tbody = table.querySelector("tbody");
        tbody.innerHTML = `<tr>
                          <td colspan='50' class='text-danger'>Loading...</td>
                       </tr>`;

        const populateTableRequestData = {
            storedProcedureName: "Sp_Transactional_data_vehicles",
            parameters: JSON.stringify(forSelectParameters),
        };

        const response = await axios.post(commonApi, populateTableRequestData);
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

        for (const data of tableData) {
            const tr = document.createElement("tr");
            tr.innerHTML = `<tr>
                <td>${encodeHTML(data.Id)}</td>
                <td>${encodeHTML(data.PreventiveMaintenance)}</td>
                <td>${encodeHTML(data.BreakdownMaintenance)}</td>
                <td>${encodeHTML(data.RTOpassingalerts)}</td>
                <td>${encodeHTML(data.PurchaseYear)}</td>
                <td>${encodeHTML(data.Cost)}</td>
                <td>${encodeHTML(data.Depreciation)}</td>
                <td>${encodeHTML(data.Insurance)}</td>
                <td>${encodeHTML(data.Vehiclenumber)}</td>
                <td>${encodeHTML(data.AlertType)}</td>
                <td>${encodeHTML(data.OtherVehicle)}</td>
                <td>${encodeHTML(data.FuelDataConsumption)}</td>
                <td>${encodeHTML(data.DailyUtilizationDataBackhoeLoaders)}</td>
            </tr>`;
            table.querySelector("tbody").appendChild(tr);
        }
    } catch (error) {
        console.error("An error occurred while populating the table:", error);
    }
};

// Handlers

const handleViewHistory = (event) => {
    const { value } = event.target;
    const data = JSON.parse(value);
    locationParameters.zoneId = data.zonename;
    locationParameters.WardId = data.Wardid;
    locationParameters.vehicleid = data.fk_vehicleid;
    locationParameters.startdate = data.date;
    locationParameters.enddate = data.date;

    $("#mapModal").modal("show");
    viewLocation();
    map.invalidateSize();
};

const handleStartDateSelect = () => {
    selectedStartDate = startDate.value;
    jatayuReportParameters.startdate = startDate.value;
    imagesParameters.startdate = startDate.value;
};

const handleEndDateSelect = () => {
    selectedEndDate = endDate.value;
    jatayuReportParameters.enddate = endDate.value;
    imagesParameters.enddate = endDate.value;
};

const handleTextChange1 = (event) => {
    const { value } = event.target;
    const selectedValue = !value ? "-" : value;
    forInsertParameters.PreventiveMaintenance = selectedValue;
};

const handleTextChange2 = (event) => {
    const { value } = event.target;
    const selectedValue = !value ? "-" : value;
    forInsertParameters.BreakdownMaintenance = selectedValue;
};

const handleTextChange3 = (event) => {
    const { value } = event.target;
    const selectedValue = !value ? "-" : value;
    forInsertParameters.RTOpassingalerts = selectedValue;
};

const handleTextChange4 = (event) => {
    const { value } = event.target;
    const selectedValue = !value ? "-" : value;
    forInsertParameters.PurchaseYear = selectedValue;
};

const handleTextChange5 = (event) => {
    const { value } = event.target;
    const selectedValue = !value ? "-" : value;
    forInsertParameters.Cost = selectedValue;
};

const handleTextChange6 = (event) => {
    const { value } = event.target;
    const selectedValue = !value ? "-" : value;
    forInsertParameters.Depreciation = selectedValue;
};

const handleTextChange7 = (event) => {
    const { value } = event.target;
    const selectedValue = !value ? "-" : value;
    forInsertParameters.Insurance = selectedValue;
};

const handleTextChange8 = (event) => {
    const { value } = event.target;
    const selectedValue = !value ? "-" : value;
    forInsertParameters.OtherVehicle = selectedValue;
};

const handleTextChange9 = (event) => {
    const { value } = event.target;
    const selectedValue = !value ? "-" : value;
    forInsertParameters.FuelDataConsumption = selectedValue;
};

const handleTextChange10 = (event) => {
    const { value } = event.target;
    const selectedValue = !value ? "-" : value;
    forInsertParameters.DailyUtilizationDataBackhoeLoaders = selectedValue;
};

const handleTextChange11 = (event) => {
    const { value } = event.target;
    const selectedValue = !value ? "-" : value;
    forInsertParameters.Vehiclenumber = selectedValue;
};

const handleAlertSelect = () => {
    const selectedValue = $("#dropdown1 :selected").text();
    forInsertParameters.AlertType = !selectedValue ? "Painting" : selectedValue;
};

// Listeners

btnView.addEventListener("click", (e) => {
    e.preventDefault();

    populateTable();
    $("#tableWrapper").slideDown("slow");
    console.log(forInsertParameters);
});

// Apply input validation for textA1 to textA11 fields
const validateInput = () => {
    const textInputs = [textA1, textA2, textA3, textA4, textA5, textA6, textA7, textA8, textA9, textA10, textA11];
    for (const input of textInputs) {
        if (!input.value.trim()) {
            alert("Please fill all the input fields");
            return false;
        }
    }
    return true;
};

// Update btnSubmit event listener to validate input before inserting data
btnSubmit.addEventListener("click", async (e) => {
    e.preventDefault();
    if (!validateInput()) return;
    const allTextArea = document.querySelectorAll("textarea");
    allTextArea.forEach((textarea) => (textarea.value = ""));
    insertData();
});

// Properly encode data before appending to table cells
const encodeHTML = (str) => {
    return str.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/"/g, "&quot;").replace(/'/g, "&#39;");
};

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
