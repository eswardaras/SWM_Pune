const stateDropdown = document.getElementById("stateDropdown");
const areaDropdown = document.getElementById("areaDropdown");
const zoneDropdown = document.getElementById("zoneDropdown");
const zoneNameInput = document.getElementById("zoneNameInput");
const wardNameInput = document.getElementById("wardNameInput");

const table1 = document.getElementById("table1");
const table2 = document.getElementById("table2");
const vehicleCategoryDropdown = document.getElementById(
    "vehicleCategoryDropdown"
);

const table = document.getElementById("table");

let vehicleToUpdate;
let zoneToEdit;
let wardToEdit;
let isEditingZone = false;
let isEditingWard = false;

// Zone

const populateStateDropdown = async () => {
    try {
        stateDropdown.innerHTML = '<option value="0">Select</option>';

        const requestData = {
            storedProcedureName: "proc_AddZoneWardWeb",
            parameters: JSON.stringify({
                mode: 11,
            }),
        };

        const response = await axios.post(commonApi, requestData);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let dropdownData = JSON.parse(commonReportMasterList);
        console.log(dropdownData);

        for (const data of dropdownData) {
            const option = document.createElement("option");
            option.value = data.PK_statId;
            option.text = data.StateName;
            stateDropdown.appendChild(option);
        }
        stateDropdown.fstdropdown.rebind();
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const populateAreaDropdown = async () => {
    try {
        areaDropdown.innerHTML = '<option value="0">Select</option>';

        const requestData = {
            storedProcedureName: "proc_AddZoneWardWeb",
            parameters: JSON.stringify({
                mode: 12,
                statId: stateDropdown.value,
            }),
        };
        console.log(requestData);

        const response = await axios.post(commonApi, requestData);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let dropdownData = JSON.parse(commonReportMasterList);
        console.log(dropdownData);

        for (const data of dropdownData) {
            const option = document.createElement("option");
            option.value = data.PK_distId;
            option.text = data.DistName;
            areaDropdown.appendChild(option);
        }
        areaDropdown.fstdropdown.rebind();
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const populateZoneTable = async () => {
    try {
        const requestData = {
            storedProcedureName: "proc_AddZoneWardWeb",
            parameters: JSON.stringify({
                mode: 2,
                AccId: 11401,
            }),
        };

        const response = await axios.post(commonApi, requestData);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let tableData = JSON.parse(commonReportMasterList);
        console.log(tableData);

        setDataTable(table1);

        let srNo = 0;
        for (const data of tableData) {
            srNo++;
            const tr = document.createElement("tr");
            tr.innerHTML = `<tr>
              <td>${srNo}</td>
              <td>${!data.ZoneName ? "-" : data.ZoneName}</td>
              <td>
                <i class="fa-solid fa-pen-to-square text-info cursor-pointer" onclick='handleZoneEdit(${JSON.stringify(data)})'></i>
              </td>
              <td>
                <i class="fa-solid fa-trash-can text-danger cursor-pointer" onclick='handleDelete(${data.ZoneId})'></i>
              </td>
          </tr>`;

            table1.querySelector("tbody").appendChild(tr);
        }
        $("#tableWrapper1").slideDown("slow");
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const handleStateSelect = () => {
    populateAreaDropdown();
};

const handleZoneEdit = async (data) => {
    isEditingZone = true;
    zoneToEdit = data.ZoneId;
    zoneNameInput.value = data.ZoneName;
};

const handleZoneDelete = async (zoneId) => {
    try {
        const requestData = {
            storedProcedureName: "proc_AddZoneWardWeb",
            parameters: JSON.stringify({
                mode: 9,
                AccId: 11401,
                zoneId,
            }),
        };

        const response = await axios.post(commonApi, requestData);
        console.log(response);
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const submitZone = async () => {
    try {
        if (isEditingZone) {
            const requestData = {
                storedProcedureName: "proc_AddZoneWardWeb",
                parameters: JSON.stringify({
                    mode: 7,
                    AccId: 11401,
                    zoneName: zoneNameInput.value,
                    zoneId: zoneToEdit,
                }),
            };

            console.log("is editing", requestData);
            const response = await axios.post(commonApi, requestData);
            console.log(response);
        } else {
            const requestData = {
                storedProcedureName: "proc_AddZoneWardWeb",
                parameters: JSON.stringify({
                    mode: 1,
                    AccId: 11401,
                    statId: stateDropdown.value,
                    did: areaDropdown.value,
                    zoneName: zoneNameInput.value,
                }),
            };

            console.log("is submitting new", requestData);
            const response = await axios.post(commonApi, requestData);
            console.log(response);
        }
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

// Ward

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

const populateWardTable = async () => {
    try {
        const requestData = {
            storedProcedureName: "proc_AddZoneWardWeb",
            parameters: JSON.stringify({
                mode: 4,
                AccId: 11401,
            }),
        };

        const response = await axios.post(commonApi, requestData);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let tableData = JSON.parse(commonReportMasterList);
        console.log(tableData);

        setDataTable(table2);

        let srNo = 0;
        for (const data of tableData) {
            srNo++;
            const tr = document.createElement("tr");
            tr.innerHTML = `<tr>
              <td>${srNo}</td>
              <td>${!data.ZoneName ? "-" : data.ZoneName}</td>
              <td>${!data.WardName ? "-" : data.WardName}</td>
              <td>
                <i class="fa-solid fa-pen-to-square text-info cursor-pointer"></i>
              </td>
              <td>
                <i class="fa-solid fa-trash-can text-danger cursor-pointer" onclick='handleDelete(${data.Pk_WardId})'></i>
              </td>
          </tr>`;

            table2.querySelector("tbody").appendChild(tr);
        }
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const handleWardDelete = async (wardId) => {
    try {
        const requestData = {
            storedProcedureName: "proc_AddZoneWardWeb",
            parameters: JSON.stringify({
                mode: 10,
                AccId: 11401,
                wardId,
            }),
        };

        const response = await axios.post(commonApi, requestData);
        console.log(response);
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const submitWard = async () => {
    try {
        if (isEditingWard) {
            const requestData = {
                storedProcedureName: "proc_AddZoneWardWeb",
                parameters: JSON.stringify({
                    mode: 8,
                    AccId: 11401,
                    wardId: wardToEdit,
                }),
            };

            console.log("is editing", requestData);
            const response = await axios.post(commonApi, requestData);
            console.log(response);
            isEditingWard = false;
        } else {
            const requestData = {
                storedProcedureName: "proc_AddZoneWardWeb",
                parameters: JSON.stringify({
                    mode: 3,
                    AccId: 11401,
                    zoneId: zoneDropdown.value,
                    wardName: wardNameInput.value,
                }),
            };

            console.log("is submitting new", requestData);
            const response = await axios.post(commonApi, requestData);
            console.log(response);
        }
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const handleCancel = () => {
    vehicleNameInput.value = "";
    imeiNoInput.value = "";
    vehicleTypeDropdown.value = 0;
    vehicleTypeDropdown.fstdropdown.rebind();
    vehicleCategoryDropdown.value = 0;
    vehicleCategoryDropdown.fstdropdown.rebind();
    $("#editContainer").hide();
};

const handleUpdate = async () => {
    try {
        const requestData = {
            storedProcedureName: "Proc_EditVehicleByUser",
            parameters: JSON.stringify({
                Mode: 5,
                AccId: 11401,
                Imei: imeiNoInput.value,
                VehicleId: vehicleToUpdate,
                VehicleName: vehicleNameInput.value,
                VehicleType: vehicleTypeDropdown.selectedOptions[0].textContent,
                workingType: vehicleCategoryDropdown.value,
            }),
        };

        const response = await axios.post(commonApi, requestData);
        console.log(response);

        // const commonReportMasterList =
        //   response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        // let tableData = JSON.parse(commonReportMasterList);
        // console.log(tableData);
    } catch (error) {
        console.error("Error fetching data:", error);
    }
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
    await populateStateDropdown();
    await populateZoneDropdown();
    await populateZoneTable();
    await populateWardTable();
});

$(document).ready(function () {
    $("#zoneRadio").change(() => {
        $(".stateDropdownWrapper").show();
        $(".areaDropdownWrapper").show();
        $(".zoneDropdownWrapper").hide();
        $(".zoneNameInputWrapper").show();
        $(".wardNameInputWrapper").hide();
        $("#tableWrapper1").show();
        $("#tableWrapper2").hide();
    });

    $("#wardRadio").change(() => {
        $(".zoneDropdownWrapper").show();
        $(".zoneNameInputWrapper").hide();
        $(".stateDropdownWrapper").hide();
        $(".areaDropdownWrapper").hide();
        $(".wardNameInputWrapper").show();
        $("#tableWrapper1").hide();
        $("#tableWrapper2").show();
    });
});
