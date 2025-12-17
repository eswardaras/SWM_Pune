let data = {
    ShiftdropdownData: [],
    vehicle: [],
    VehicleShiftData: [],
    kothiData: [],
    prabhagData: [],
    vehicleData: [],
    VehicleShiftAll:[],
};
const table = document.getElementById("table");
const getData = async () => {
    try {
        const requestData = {
            storedProcedureName: "proc_AssignShiftToVehicle",
            parameters: JSON.stringify({
                mode: 1,
                FK_AccId: 11401,
                ShiftId: 0,
                //WardId: 0,
                //VehicleIds: null,
                //Empid: 0,
                //RoleId: 4,
                //zones: null,
                //wards: null,
                //Vstatus: 1,
                //kothis: null,
            }),
        };

        const response = await axios.post(commonApi, requestData);
        console.log(response);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList;

        data.ShiftdropdownData = JSON.parse(commonReportMasterList[1].ReturnValue);
        data.vehicle = JSON.parse(commonReportMasterList[0].ReturnValue);
        //data.wardData = JSON.parse(commonReportMasterList[1].ReturnValue);
        //data.kothiData = JSON.parse(commonReportMasterList[4].ReturnValue);
        //data.prabhagData = JSON.parse(commonReportMasterList[5].ReturnValue);
        //data.vehicleData = JSON.parse(commonReportMasterList[2].ReturnValue);

        console.log(data);
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

window.addEventListener("load", async () => {
    await getData();
    populateEmployeeDropdown(data.ShiftdropdownData);
    populateVehicleDropdown(data.vehicle);
    await populateDataGrid(); 
    //populateKothiDropdown(data.kothiData);
    //populatePrabhagDropdown(data.prabhagData);
    //populateVehicleDropdown(data.vehicleData);
});

const populateDataGrid = async () => {

    try {

        const tableBody = document.querySelector("#table tbody");
        while (tableBody.rows.length > 0) {
            tableBody.deleteRow(0); // Removes the first row until none are left
        }

        const requestData = {
            storedProcedureName: "proc_AssignShiftToVehicle",
            parameters: JSON.stringify({
                mode: 3,
                FK_AccId: 11401,
                ShiftId: 0,
                //WardId: 0,
                //VehicleIds: null,
                //Empid: 0,
                //RoleId: 4,
                //zones: null,
                //wards: null,
                //Vstatus: 1,
                //kothis: null,
            }),
        };

        const response = await axios.post(commonApi, requestData);
        console.log(response);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList;

        data.VehicleShiftData = JSON.parse(commonReportMasterList[0].ReturnValue);
        data.VehicleShiftAll = JSON.parse(commonReportMasterList[1].ReturnValue);
        setDataTable(table);

        let tableData = JSON.parse(commonReportMasterList[0].ReturnValue);

        let srNo = 0;
        for (const data of tableData) {
            srNo++;
            const tr = document.createElement("tr");
            tr.innerHTML = `<tr>
              <td>${srNo}</td>
              <td>${data.vehicleName}</td>
              <td>${data.ShiftName}</td>
              <td>${data.ShiftTIME}</td>

              <td><i class="fa-solid fa-trash-can text-danger cursor-pointer" onclick="handleEdit('${data.PK_VehicleId}', '${data.shiftid}')"></i></td>
          </tr>`;

            table.querySelector("tbody").appendChild(tr);
        }
        $("#tableWrapper").slideDown("slow");
        console.log(data);
    } catch (error) {
        console.error("Error fetching data:", error);
    }

   
};

const vehicleDropdown = document.getElementById("vehicleDropdown");
const shiftDropdown = document.getElementById("ShiftDropdown");

const handleEdit = async (PK_VehicleId,shiftid) => {

    try {
        isEditing = true;
        clearAllControls();
       // selectVehicle(PK_VehicleId)
        //selectShift(shiftid)
        /*        let filteredData = data.VehicleShiftAll.filter(row => parseInt(row.vehicleid, 10) == parseInt(PK_VehicleId, 10) );*/
        vehicleArray = data.VehicleShiftAll;

        for (const x of vehicleArray) {
            if (String(x.VehicleId) === PK_VehicleId) {
                console.log('matched')
            }
        }

        let filteredData = data.VehicleShiftAll.filter(row => String(row.VehicleId) === PK_VehicleId);
        console.log(filteredData);
        for (const data1 of filteredData) {
            selectVehicle(data1.VehicleId)
            selectShift(data1.ShiftId)
        }

        // Function to select an option by value
       


    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

function selectVehicle(value) {
   // $("#vehicleDropdown").val(value).trigger("change");
    //console.log(value);
    for (let option of vehicleDropdown.options) {
        if (String(option.value) ===  String(value)) {
            option.selected = true;
           // break;
        }
    }
    $("#vehicleDropdown").change();
};

function selectShift(value) {
    
    //$("#ShiftDropdown").val(value).trigger("change");; vehicleDropdown ShiftDropdown
    for (let option of shiftDropdown.options) {
        if (String(option.value) === String(value)) {
            option.selected = true;
           // break;
        }
    }
    $("#ShiftDropdown").change();
};

const handleAssign = async () => {
    try {
        const requestData = {
            storedProcedureName: "proc_AssignShiftToVehicle",
            parameters: JSON.stringify({
                mode: 5,
                FK_AccId: 11401,
                Vehicleids: $("#vehicleDropdown").val()?.join(",") || 0,
                shiftids: $("#ShiftDropdown").val()?.join(",") || 0,
            }),
        };

        console.log(requestData);
        const response = await axios.post(commonApi, requestData);

        console.log(response);
        clearAllControls();
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

function setDataTable(tableId) {
    if ($.fn.DataTable.isDataTable(tableId)) {
        // DataTable is already initialized, no need to reinitialize
        $(tableId).DataTable().clear().draw();
        $(tableId).DataTable().destroy();
    }
};

const populateEmployeeDropdown = (data) => {
    try {
        $.each(data, (index, item) => {
            const option = $("<option>", {
                value: item.ShiftId,
                text: item.ShiftName,
            });
            $("#ShiftDropdown").append(option);
        });
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const populateVehicleDropdown = (data) => {
    try {
        $.each(data, (index, item) => {
            const option = $("<option>", {
                value: item.PK_VehicleId,
                text: item.vehicleName,
            });
            $("#vehicleDropdown").append(option);
        });
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const populateWardDropdown = (data) => {
    try {
        $.each(data, (index, item) => {
            const option = $("<option>", {
                value: item.PK_wardId,
                text: item.wardName,
            });
            $("#wardDropdown").append(option);
        });
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const populateKothiDropdown = (data) => {
    try {
        $.each(data, (index, item) => {
            const option = $("<option>", {
                value: item.pk_kothiid,
                text: item.KothiName,
            });
            $("#kothiDropdown").append(option);
        });
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const populatePrabhagDropdown = (data) => {
    try {
        $.each(data, (index, item) => {
            const option = $("<option>", {
                value: item.PK_prabhagId,
                text: item.PrabhagName,
            });
            $("#prabhagDropdown").append(option);
        });
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

//const populateVehicleDropdown = (data) => {
//    try {
//        $.each(data, (index, item) => {
//            const option = $("<option>", {
//                value: item.PK_VehicleId,
//                text: item.vehicleName,
//            });
//            $("#vehicleDropdown").append(option);
//        });
//    } catch (error) {
//        console.error("Error fetching data:", error);
//    }
//};

// Handlers

const handleEmpSelect = async () => {
    if ($("#employeeDropdown").val() === "0") return;

    try {
        const requestData = {
            storedProcedureName: "proc_EmpZnWdVehicleAssign_P_New",
            parameters: JSON.stringify({
                mode: 4,
                accid: $("#employeeDropdown").val(),
                zoneid: 0,
                WardId: 0,
                VehicleIds: null,
                Empid: $("#employeeDropdown").val(),
                RoleId: 4,
                zones: null,
                wards: null,
                Vstatus: 0,
                kothis: null,
            }),
        };

        const response = await axios.post(commonApi, requestData);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList;

        const assignedZoneWardKothi = JSON.parse(
            commonReportMasterList[0].ReturnValue
        );
        const assignedVehicle = JSON.parse(commonReportMasterList[1].ReturnValue);

        console.log("assignedZoneWardKothi", assignedZoneWardKothi);
        console.log("assignedVehicle", assignedVehicle);

        // $("#zoneDropdown")
        //   .val(assignedZoneWardKothi[0].FK_ZoneId)
        //   .trigger("change");
        // $("#wardDropdown")
        //   .val(assignedZoneWardKothi[0].FK_WardId)
        //   .trigger("change");
        // $("#kothiDropdown")
        //   .val(assignedZoneWardKothi[0].FK_Kothi)
        //   .trigger("change");

        const zoneIds = [];
        const wardIds = [];
        const kothiIds = [];
        const prabhagIds = [];
        const vehicleIds = [];

        $.each(assignedZoneWardKothi, (index, data) => {
            zoneIds.push(data.FK_ZoneId);
            wardIds.push(data.FK_WardId);
            kothiIds.push(data.FK_Kothi);
            prabhagIds.push(data.fk_prabhagId);
        });

        $("#zoneDropdown").val(zoneIds).trigger("change");
        $("#wardDropdown").val(wardIds).trigger("change");
        $("#kothiDropdown").val(kothiIds).trigger("change");
        $("#kothiDropdown").val(kothiIds).trigger("change");
        $("#prabhagDropdown").val(prabhagIds).trigger("change");

        $.each(assignedVehicle, (index, vehicle) => {
            vehicleIds.push(vehicle.Fk_Vid);
        });
        $("#vehicleDropdown").val(vehicleIds).trigger("change");
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};



const assignZoneWardKothi = async () => {
    try {
        const requestData = {
            storedProcedureName: "proc_EmpZnWdVehicleAssign_P_New",
            parameters: JSON.stringify({
                mode: 5,
                accid: 11401,
                zoneid: $("#zoneDropdown").val() ?.join(",") || 0,
                WardId: $("#wardDropdown").val() ?.join(",") || 0,
                VehicleIds: null,
                Empid: $("#employeeDropdown").val(),
                RoleId: 1,
                zones: $("#zoneDropdown").val() ?.join(",") || null,
                wards: $("#wardDropdown").val() ?.join(",") || null,
                // Vstatus: 0,
                kothis: $("#kothiDropdown").val() ?.join(",") || null,
                prabhag: $("#prabhagDropdown").val() ?.join(",") || null,
            }),
        };

        console.log(requestData);
        const response = await axios.post(commonApi, requestData);

        console.log(response);
        // const commonReportMasterList =
        //   response.data.CommonMethodResult.CommonReportMasterList;
        if (response.status === 200) {
            Swal.fire({
                title: "Done!",
                text: "Assign Successfully",
                icon: "success",
            });
        } else {
            Swal.fire({
                title: "Oops!",
                text: "Something went wrong",
                icon: "error",
            });
        }
        clearAllControls();
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const assignVehicle = async () => {
    try {
        const requestData = {
            storedProcedureName: "proc_EmpZnWdVehicleAssign",
            parameters: JSON.stringify({
                mode: 3,
                accid: 11401,
                zoneid: $("#zoneDropdown").val() ?.join(",") || 0,
                WardId: $("#wardDropdown").val() ?.join(",") || 0,
                VehicleIds: $("#vehicleDropdown").val() ?.join(",") || null,
                Empid: $("#employeeDropdown").val(),
                RoleId: 1,
                zones: $("#zoneDropdown").val() ?.join(",") || null,
                wards: $("#wardDropdown").val() ?.join(",") || null,
                Vstatus: $("#personalRadio").prop("checked") ? 1 : 0,
                kothis: $("#kothiDropdown").val() ?.join(",") || null,
            }),
        };

        console.log(requestData);
        const response = await axios.post(commonApi, requestData);

        console.log(response);
        // const commonReportMasterList =
        //   response.data.CommonMethodResult.CommonReportMasterList;
        if (response.status === 200) {
            if ($("#personalRadio").prop("checked")) {
                Swal.fire({
                    title: "Done!",
                    text: "Personal Vehicle Assigned Successfully",
                    icon: "success",
                });
            } else {
                Swal.fire({
                    title: "Done!",
                    text: "General Vehicle Assigned Successfully",
                    icon: "success",
                });
            }
        } else {
            Swal.fire({
                title: "Oops!",
                text: "Something went wrong",
                icon: "error",
            });
        }
        clearAllControls();
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const clearAllControls = () => {
    
    $("#vehicleDropdown").val(null).trigger("change");
    $("#ShiftDropdown").val(null).trigger("change");
    populateDataGrid();
    
};

$(document).ready(function () {
    $("#employeeDropdown").select2({
        width: "100%",
    });
    $("#vehicleDropdown").select2({
        width: "100%",
    });
    $("#ShiftDropdown").select2({
        width: "100%",
    });
    $("#zoneDropdown").select2({
        placeholder: "Select Vehicles",
        allowClear: true,
        width: "100%",
    });
    $("#wardDropdown").select2({
        placeholder: "Select ward",
        allowClear: true,
        width: "100%",
    });
    $("#kothiDropdown").select2({
        placeholder: "Select kothi",
        allowClear: true,
        width: "100%",
    });
    $("#prabhagDropdown").select2({
        placeholder: "Select Prabhag",
        allowClear: true,
        width: "100%",
    });

    $("#zoneWardKothiRadio").on("change", function () {
        $(".content2").hide();
        $(".content1").show();
    });

    $("#vehicleRadio").on("change", function () {
        $(".content1").hide();
        $(".content2").show();
    });
});
