const zoneDropdown = document.getElementById("zoneDropdown");
const wardDropdown = document.getElementById("wardDropdown");

const table = document.getElementById("table");

const populateZoneDropdown = async () => {
    try {
        const requestData = {
            storedProcedureName: "proc_InsertFeederPoint",
            parameters: JSON.stringify({
                mode: 1,
                fk_accid: 11401,
            }),
        };

        const response = await axios.post(commonApi, requestData);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let dropdownData = JSON.parse(commonReportMasterList);
        console.log(dropdownData);

        for (const data of dropdownData) {
            const option = document.createElement("option");
            option.value = data.zoneid;
            option.text = data.zonename;
            zoneDropdown.appendChild(option);
        }
        zoneDropdown.fstdropdown.rebind();
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const populateWardDropdown = async () => {
    try {
        $("#wardDropdown").empty();
        $("#wardDropdown").append(
            $("<option>", {
                value: "0",
                text: "Select Ward",
            })
        );
        const requestData = {
            storedProcedureName: "proc_InsertFeederPoint",
            parameters: JSON.stringify({
                mode: 2,
                fk_accid: 11401,
                fk_zoneid: zoneDropdown.value,
            }),
        };

        const response = await axios.post(commonApi, requestData);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let dropdownData = JSON.parse(commonReportMasterList);
        console.log(dropdownData);

        for (const data of dropdownData) {
            const option = document.createElement("option");
            option.value = data.pk_wardid;
            option.text = data.wardname;
            wardDropdown.appendChild(option);
        }
        wardDropdown.fstdropdown.rebind();
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const populateTable = async () => {
    try {
        const requestData = {
            storedProcedureName: "Proc_VehicleMap_1",
            parameters: JSON.stringify({
                mode: 14,
                UserID: 11401,
                zoneId: zoneDropdown.value,
                WardId: wardDropdown.value,
                vendorid: 0,
                RoleID: 0,
            }),
        };

        const response = await axios.post(commonApi, requestData);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let tableData = JSON.parse(commonReportMasterList);
        console.log(tableData);

        setDataTable(table);

        let srNo = 0;
        for (const data of tableData) {
            srNo++;
            const tr = document.createElement("tr");
            tr.innerHTML = `<tr>
              <td>${srNo}</td>
              <td>${!data.datetim ? "-" : data.datetim}</td>
              <td>${!data.ZoneName ? "-" : data.ZoneName}</td>
              <td>${!data.wardName ? "-" : data.wardName}</td>
              <td>${!data.vehicleName ? "-" : data.vehicleName}</td>
              <td>${!data.IMEINO ? "-" : data.IMEINO}</td>
              <td>${!data.vehicleType ? "-" : data.vehicleType}</td>
              <td>${!data.VendorName ? "-" : data.VendorName}</td>
              <td>${!data.LstRunIdletime ? "-" : data.LstRunIdletime}</td>
          </tr>`;

            table.querySelector("tbody").appendChild(tr);
        }
        $("#tableWrapper").slideDown("slow");
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};


const handleCancel = () => {
    roleNameInput.value = "";
};

// Handlers

const handleZoneSelect = async () => {
    await populateWardDropdown();
};

const handleWardSelect = async () => {
    await populateVehicleDropdown();
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

window.addEventListener("load", async () => {
    await populateZoneDropdown();
    /*    await populateTable();*/
});
