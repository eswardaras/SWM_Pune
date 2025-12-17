let data = {
    empdropdownData: [],
    zoneData: [],
    wardData: [],
    kothiData: [],
    prabhagData: [],
    vehicleData: [],
};

const getData = async () => {
    try {
        const requestData = {
            storedProcedureName: "proc_EmpZnWdVehicleAssign_P_New",
            parameters: JSON.stringify({
                mode: 1,
                accid: 11401,
                zoneid: 0,
                WardId: 0,
                VehicleIds: null,
                Empid: 0,
                RoleId: 4,
                zones: null,
                wards: null,
                Vstatus: 1,
                kothis: null,
            }),
        };

        const response = await axios.post(commonApi, requestData);
        console.log(response);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList;

        data.empdropdownData = JSON.parse(commonReportMasterList[3].ReturnValue);
        data.zoneData = JSON.parse(commonReportMasterList[0].ReturnValue);
        data.wardData = JSON.parse(commonReportMasterList[1].ReturnValue);
        data.kothiData = JSON.parse(commonReportMasterList[4].ReturnValue);
        data.prabhagData = JSON.parse(commonReportMasterList[5].ReturnValue);
        data.vehicleData = JSON.parse(commonReportMasterList[2].ReturnValue);

        console.log(data);
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

window.addEventListener("load", async () => {
    await getData();
    populateEmployeeDropdown(data.empdropdownData);
    populateZoneDropdown(data.zoneData);
    populateWardDropdown(data.wardData);
    populateKothiDropdown(data.kothiData);
    populatePrabhagDropdown(data.prabhagData);
    populateVehicleDropdown(data.vehicleData);
});

const populateEmployeeDropdown = (data) => {
    try {
        $.each(data, (index, item) => {
            const option = $("<option>", {
                value: item.Pk_EmpId,
                text: item.EmpName,
            });
            $("#employeeDropdown").append(option);
        });
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const populateZoneDropdown = (data) => {
    try {
        $.each(data, (index, item) => {
            const option = $("<option>", {
                value: item.ZoneId,
                text: item.ZoneName,
            });
            $("#zoneDropdown").append(option);
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

const handleAssign = async () => {
    try {
        if ($("#zoneWardKothiRadio").prop("checked")) {
            await assignZoneWardKothi();
        } else {
            await assignVehicle();
        }
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
    $("#employeeDropdown").val(0).trigger("change");
    $("#zoneDropdown").val(null).trigger("change");
    $("#wardDropdown").val(null).trigger("change");
    $("#kothiDropdown").val(null).trigger("change");
    $("#prabhagDropdown").val(null).trigger("change");
    $("#vehicleDropdown").val(null).trigger("change");
};

$(document).ready(function () {
    $("#employeeDropdown").select2({
        width: "100%",
    });
    $("#vehicleDropdown").select2({
        width: "100%",
    });
    $("#zoneDropdown").select2({
        placeholder: "Select zones",
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
