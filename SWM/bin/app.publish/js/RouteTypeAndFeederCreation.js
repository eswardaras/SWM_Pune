const zoneDropdown = document.getElementById("zoneDropdown");
const wardDropdown = document.getElementById("wardDropdown");
const userDropdown = document.getElementById("userDropdown");
const startDate = document.getElementById("startDate");
const endDate = document.getElementById("endDate");

const dateSpan1 = document.getElementById("dateSpan1");
const table1 = document.getElementById("table1");

const dateSpan2 = document.getElementById("dateSpan2");
const table2 = document.getElementById("table2");

const populateZoneDropdown = async () => {
    try {
        const response = await axios.post(zoneApi, {
            mode: 11,
            vehicleId: 0,
            AccId: 11401,
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
            AccId: 11401,
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

const populateUserDropdown = async () => {
    try {
        userDropdown.innerHTML = '<option value="0">Select User Name</option>';

        const requestData = {
            storedProcedureName: "proc_dailyrouteandfeedermade",
            parameters: JSON.stringify({
                mode: 3,
                accid: 11401,
            }),
        };

        const response = await axios.post(commonApi, requestData);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let dropdownData = JSON.parse(commonReportMasterList);

        for (const data of dropdownData) {
            const option = document.createElement("option");
            option.value = data.pk_empid;
            option.text = data.EmpName;
            userDropdown.appendChild(option);
        }
        userDropdown.fstdropdown.rebind();
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const populateTable1 = async (tableData) => {
    try {
        dateSpan1.innerHTML = `Route Creation:- From ${formatDate(
            startDate.value
        )} To ${formatDate(endDate.value)}`;

        const tbody = table1.querySelector("tbody");
        tbody.innerHTML = `<tr>
                                <td colspan='50' class='text-danger'>Loading...</td>
                             </tr>`;

        tbody.innerHTML = "";
        if (!tableData) {
            tbody.innerHTML = `<tr>
                                     <td colspan='50' class='text-danger'>
                                        <i class="fa-solid fa-triangle-exclamation mx-1"></i>
                                        No Data Found
                                      </td>
                                  </tr>`;
            return;
        }

        setDataTable(table1);

        let srNo = 0;
        for (const data of tableData) {
            srNo++;
            const tr = document.createElement("tr");
            tr.innerHTML = `<tr>
                  <td>${srNo}</td>
                  <td>${!data.Date ? "-" : data.Date}</td>
                  <td>${!data.ZoneName ? "-" : data.ZoneName}</td>
                  <td>${!data.WardName ? "-" : data.WardName}</td>
                  <td>${!data.RouteName ? "-" : data.RouteName}</td>
                  <td>${!data.Routekilomtr ? "-" : data.Routekilomtr}</td>
                  <td>${!data.EmployeeName ? "-" : data.EmployeeName}</td>
                  <td>${!data.Mob ? "-" : data.Mob}</td>
              </tr>`;

            table1.querySelector("tbody").appendChild(tr);
        }
    } catch (error) {
        console.error("An error occurred while populating the table:", error);
    }
};

const populateTable2 = async (tableData) => {
    try {
        dateSpan2.innerHTML = `Feeder Creation:- From ${formatDate(
            startDate.value
        )} To ${formatDate(endDate.value)}`;

        const tbody = table2.querySelector("tbody");
        tbody.innerHTML = `<tr>
                                <td colspan='50' class='text-danger'>Loading...</td>
                             </tr>`;

        tbody.innerHTML = "";
        if (!tableData) {
            tbody.innerHTML = `<tr>
                                     <td colspan='50' class='text-danger'>
                                        <i class="fa-solid fa-triangle-exclamation mx-1"></i>
                                        No Data Found
                                      </td>
                                  </tr>`;
            return;
        }

        setDataTable(table2);

        for (const data of tableData) {
            const tr = document.createElement("tr");
            tr.innerHTML = `<tr>
                  <td>${!data.Date ? "-" : data.Date}</td>
                  <td>${!data.Zone ? "-" : data.Zone}</td>
                  <td>${!data.wardName ? "-" : data.wardName}</td>
                  <td>${!data.kothi ? "-" : data.kothi}</td>
                  <td>${!data.Present ? "-" : data.Present}</td>
                  <td>${
                !data["Route Deviated"] ? "-" : data["Route Deviated"]
                }</td>
                  <td>${
                !data["Leave/Holiday"] ? "-" : data["Leave/Holiday"]
                }</td>
                  <td>${!data.Absent ? "-" : data.Absent}</td>
                  <td>${!data.Total ? "-" : data.Total}</td>
                  <td>${!data.Percent ? "-" : data.Percent}</td>
                  <td>${
                !data["Device Percent"] ? "-" : data["Device Percent"]
                }</td>
              </tr>`;

            table2.querySelector("tbody").appendChild(tr);
        }
    } catch (error) {
        console.error("An error occurred while populating the table:", error);
    }
};

const getData = async () => {
    $("#tableWrapper1").slideDown("slow");
    $("#tableWrapper2").slideDown("slow");

    try {
        const requestData = {
            storedProcedureName: "proc_dailyrouteandfeedermade",
            parameters: JSON.stringify({
                mode: 6,
                accid: 11401,
                zoneid: zoneDropdown.value,
                wardid: wardDropdown.value,
                startdate: startDate.value,
                enddate: endDate.value,
                empid: userDropdown.value,
            }),
        };

        const response = await axios.post(commonApi, requestData);
        console.log(response);

        let table1Data;
        let table2Data;

        if (response.data.CommonMethodResult.CommonReportMasterList) {
            table1Data =
                response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

            table2Data =
                response.data.CommonMethodResult.CommonReportMasterList[1].ReturnValue;

            populateTable1(JSON.parse(table1Data));
            populateTable2(JSON.parse(table2Data));
        } else {
            populateTable1(table1Data);
            populateTable2(table2Data);
        }
    } catch (error) {
        console.error("An error occurred while populating the table:", error);
    }
};

// Handlers

const handleZoneSelect = (event) => {
    populateWardDropdown();
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
                    text: "Excel <i class='fas fa-file-excel text-white'></i>",
                    title: document.title + " - " + getFormattedDate(),
                    className: "btn btn-sm btn-success mb-2", // Add your Excel button class here
                },
                {
                    extend: "pdf",
                    text: "PDF <i class='fa-regular fa-file-pdf text-white'></i>",
                    title: document.title + " - " + getFormattedDate(),
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
            order: [[0, "asc"]],
        });
    });
}

function getFormattedDate() {
    const today = new Date();
    const options = { year: "numeric", month: "short", day: "numeric" };
    return today.toLocaleDateString("en-US", options);
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
    await populateUserDropdown();
});
