const vehicleNumberDropdown = document.getElementById("vehicleNumberDropdown");
const vehicleTypeDropdown = document.getElementById("vehicleTypeDropdown");
const vehicleModelDropdown = document.getElementById("vehicleModelDropdown");
const vehicleCategoryDropdown = document.getElementById(
    "vehicleCategoryDropdown"
);

const table = document.getElementById("table");

let isEditing = false;

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

const populateFormDropdown = async () => {
    try {
        const requestData = {
            storedProcedureName: "proc_VehicleMaster ",
            parameters: JSON.stringify({
                mode: 2,
                accid: 11401,
            }),
        };

        const response = await axios.post(commonApi, requestData);
        console.log(response);
        populateVehicleNumberDropdown(
            response.data.CommonMethodResult.CommonReportMasterList[1].ReturnValue
        );
        populateVehicleTypeDropdown(
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue
        );
        populateVehicleModelDropdown(
            response.data.CommonMethodResult.CommonReportMasterList[2].ReturnValue
        );
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const populateVehicleNumberDropdown = (data) => {
    try {
        vehicleNumberDropdown.innerHTML = '<option value="0">Select</option>';

        let dropdownData = JSON.parse(data);

        for (const data of dropdownData) {
            const option = document.createElement("option");
            option.value = data.PK_VehicleId;
            option.text = data.vehicleName;
            vehicleNumberDropdown.appendChild(option);
        }
        vehicleNumberDropdown.fstdropdown.rebind();
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const populateVehicleTypeDropdown = (data) => {
    try {
        vehicleTypeDropdown.innerHTML = '<option value="0">Select</option>';

        let dropdownData = JSON.parse(data);
        console.log(dropdownData);

        for (const data of dropdownData) {
            const option = document.createElement("option");
            option.value = data.WorkingType;
            option.text = data.WorkingType;
            vehicleTypeDropdown.appendChild(option);
        }
        vehicleTypeDropdown.fstdropdown.rebind();
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const populateVehicleModelDropdown = (data) => {
    try {
        vehicleModelDropdown.innerHTML = '<option value="0">Select</option>';

        let dropdownData = JSON.parse(data);
        console.log(dropdownData);

        for (const data of dropdownData) {
            const option = document.createElement("option");
            option.value = data.PK_VTypeId;
            option.text = data.VTypeName;
            vehicleModelDropdown.appendChild(option);
        }
        vehicleModelDropdown.fstdropdown.rebind();
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const getData = async () => {
    try {
        const requestData = {
            storedProcedureName: "proc_VehicleMaster",
            parameters: JSON.stringify({
                Mode: 3,
                accid: 11401,
            }),
        };

        const response = await axios.post(commonApi, requestData);
        console.log(response);
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
              <td>${!data.IMEI ? "-" : data.IMEI}</td>
              <td>${!data.VehicleType ? "-" : data.VehicleType}</td>
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
    $("#editContainer").show("slow");
    await populateFormDropdown();
    console.log(data);
    vehicleNumberDropdown.fstdropdown.setValue(data.VehicleId);
    vehicleTypeDropdown.fstdropdown.setValue(data.VehicleType);
    isEditing = true;
};

const handleCancel = () => {
    $("#editContainer").hide("slow");
    $("#btnAddVehicleInfo").show();
    vehicleNumberDropdown.fstdropdown.setValue(0);
    vehicleTypeDropdown.fstdropdown.setValue(0);
};

// FOR DROPDOWN mode=2
// exec proc_VehicleMaster @PK_VMId=0,@vehicleID=0,@AccId=11401,@vendorID=0,@vehicleName=default,
// @vehicleType=default,@workingType=default,@chassi_num=default,@puc_num=default,@puc_date=default,
// @puc_expdate=default,@insurance_company=default,@insurance_name=default,@insurance_date=default,
// @insurance_expdate=default,@insurance_num=default,@fservicing_date=default,@servicing_months=0,
// @beforeservicing_km=0,@expectedservicing_date=default,@expectedserv_km=0,@fuelFactor=default,
// @fuelSubstractor=default,@fuelTank=0,@votageType=0,@milage=0,@astatus=0,@opId=0,@mode=2,@OpRoleId=0,
// @ModelType=default

// ModelType=@ModelType ,workingType=@workingType,puc_num=@puc_num,puc_date=@puc_date,
// puc_expdate=@puc_expdate, insurance_company=@insurance_company ,insurance_name=@insurance_name,insurance_date=@insurance_date ,
// insurance_expdate=@insurance_expdate, insurance_num=@insurance_num,
// servicing_months=@servicing_months,beforeservicing_km=@beforeservicing_km ,expectedservicing_date=@expectedservicing_date ,
// expectedserv_km=@expectedserv_km ,chassi_num=@chassi_num,
// milage=@milage,OpupdateTime=getdate(), OpUpdateId=@opId, OpUpdateRoleId=@OpRoleId
// WHERE Fk_VehicleId=@VehicleId and FK_vendorID=@AccId

const handleSubmit = async () => {
    try {
        if (isEditing) {
            const requestData = {
                storedProcedureName: "proc_VehicleMaster",
                parameters: JSON.stringify({
                    mode: 5,
                    ModelType: $("#vehicleModelDropdown").val(),
                    workingType: 0,
                    puc_num: $("#pucNumberInput").val(),
                    puc_date: $("#pucDate").val(),
                    puc_expdate: $("#expiryDate").val(),
                    insurance_company: $("#insuranceCompanyInput").val(),
                    insurance_name: $("#insuranceNameInput").val(),
                    insurance_date: $("#insuranceDate").val(),
                    insurance_expdate: $("#insuranceExpiryDate").val(),
                    insurance_num: $("#insuranceNumberInput").val(),
                    servicing_months: $("#sevicingMonthsInput").val(),
                    beforeservicing_km: $("#beforeServicingInput").val(),
                    expectedservicing_date: $("#expectedServicingInput").val(),
                    expectedserv_km: $("#expectedServicingInput").val(),
                    chassi_num: $("#chassieNumberInput").val(),
                    milage: $("#vehicleMilageInput").val(),
                    vehicleID: vehicleNumberDropdown.value,
                    AccId: 11401,
                }),
            };

            console.log(requestData);
            const response = await axios.post(commonApi, requestData);
            console.log(response);
        } else {
            const requestData = {
                storedProcedureName: "proc_VehicleMaster",
                parameters: JSON.stringify({
                    mode: 2,
                    PK_VMId: 0,
                    vehicleID: vehicleNumberDropdown.value,
                    AccId: 11401,
                    vendorID: 0,
                    vehicleName: vehicleNumberDropdown.selectedOptions[0].textContent,
                    vehicleType: vehicleTypeDropdown.value,
                    workingType: 0,
                    chassi_num: $("#chassieNumberInput").val(),
                    puc_num: $("#pucNumberInput").val(),
                    puc_date: $("#pucDate").val(),
                    puc_expdate: $("#expiryDate").val(),
                    insurance_company: $("#insuranceCompanyInput").val(),
                    insurance_num: $("#insuranceNumberInput").val(),
                    insurance_name: $("#insuranceNameInput").val(),
                    insurance_date: $("#insuranceDate").val(),
                    insurance_expdate: $("#insuranceExpiryDate").val(),
                    fservicing_date: $("#servicingDate").val(),
                    servicing_months: $("#sevicingMonthsInput").val(),
                    beforeservicing_km: $("#beforeServicingInput").val(),
                    expectedservicing_date: $("#expectedServicingInput").val(),
                    expectedserv_km: $("#expectedServicingInput").val(),
                    fuelFactor: $("#fuelFactorInput").val(),
                    fuelSubstractor: $("#fuelSubfactoryInput").val(),
                    fuelTank: $("#fuelTankCapacityInput").val(),
                    astatus: $("#statusDropdown").val(),
                    votageType: $("#voltageTypeDropdown").val(),
                    milage: $("#vehicleMilageInput").val(),
                    ModelType: $("#vehicleModelDropdown").val(),
                }),
            };

            console.log(requestData);
            const response = await axios.post(commonApi, requestData);
            console.log(response);
        }

        // const commonReportMasterList =
        //   response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        // let tableData = JSON.parse(commonReportMasterList);
        // console.log(tableData);
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const handleShowForm = async () => {
    $("#editContainer").show("slow");
    $("#btnAddVehicleInfo").hide();
    await populateFormDropdown();
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
});
