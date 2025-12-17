const vehicleNameInput = document.getElementById("vehicleNameInput");
const imeiNoInput = document.getElementById("imeiNoInput");
const vehicleTypeDropdown = document.getElementById("vehicleTypeDropdown");
const vehicleCategoryDropdown = document.getElementById(
    "vehicleCategoryDropdown"
);

const table = document.getElementById("table");

let vehicleToUpdate;

const populateVehicleTypeDropdown = async () => {
    try {
        vehicleTypeDropdown.innerHTML = '<option value="0">Select</option>';

        const requestData = {
            storedProcedureName: "Proc_EditVehicleByUser",
            parameters: JSON.stringify({
                mode: 2,
            }),
        };

        const response = await axios.post(commonApi, requestData);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let dropdownData = JSON.parse(commonReportMasterList);

        for (const data of dropdownData) {
            const option = document.createElement("option");
            option.value = data.PK_VTypeId;
            option.text = data.VTypeName;
            vehicleTypeDropdown.appendChild(option);
        }
        vehicleTypeDropdown.fstdropdown.rebind();
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const populateVehicleCategoryDropdown = async () => {
    try {
        vehicleCategoryDropdown.innerHTML = '<option value="0">Select</option>';

        const requestData = {
            storedProcedureName: "Proc_EditVehicleByUser",
            parameters: JSON.stringify({
                mode: 3,
            }),
        };

        const response = await axios.post(commonApi, requestData);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let dropdownData = JSON.parse(commonReportMasterList);
        console.log(dropdownData);

        for (const data of dropdownData) {
            const option = document.createElement("option");
            option.value = data.Type;
            option.text = data.Type;
            vehicleCategoryDropdown.appendChild(option);
        }
        vehicleCategoryDropdown.fstdropdown.rebind();
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const getData = async () => {
    try {
        const requestData = {
            storedProcedureName: "Proc_EditVehicleByUser",
            parameters: JSON.stringify({
                Mode: 1,
                AccId: 11401,
            }),
        };

        const response = await axios.post(commonApi, requestData);
        $("#table tbody").empty();
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
              <td>${!data.VehicleName ? "-" : data.VehicleName}</td>
              <td>${!data.VehicleType ? "-" : data.VehicleType}</td>
              <td>${!data.workingType ? "-" : data.workingType}</td>
              <td>${!data.Imei ? "-" : data.Imei}</td>
              <td><button class='btn btn-sm btn-info' type='button' onclick='handleEdit(${JSON.stringify(
                    data
                )})'>Edit</button></td> 
          </tr>`;

            table.querySelector("tbody").appendChild(tr);
        }
        $("#tableWrapper").slideDown("slow");
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const handleEdit = async (data) => {
    vehicleToUpdate = data.VehicleId;
    $("#editContainer").show("slow");
    vehicleNameInput.value = data.VehicleName;
    imeiNoInput.value = data.Imei;
    vehicleCategoryDropdown.value = data.workingType;
    vehicleCategoryDropdown.fstdropdown.rebind();
    vehicleTypeDropdown.value = data.VehicleType;

    for (var i = 0; i < vehicleTypeDropdown.options.length; i++) {
        if (vehicleTypeDropdown.options[i].text === data.VehicleType) {
            // Set the selected attribute for the matching option
            vehicleTypeDropdown.options[i].selected = true;
            vehicleTypeDropdown.fstdropdown.rebind();
            break; // Stop iterating once a match is found
        }
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
    await getData();
    await populateVehicleTypeDropdown();
    await populateVehicleCategoryDropdown();
});
