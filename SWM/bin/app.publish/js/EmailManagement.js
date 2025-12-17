const zoneDropdown = document.getElementById("zoneDropdown");
const wardDropdown = document.getElementById("wardDropdown");
const table = document.getElementById("table");

let isEditing = false;
let rowToEdit;

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
            storedProcedureName: "sp_manage_PMCcontactdetails",
            parameters: JSON.stringify({
                mode: 4,
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
              <td><i class="fa-solid fa-pen-to-square text-info cursor-pointer" onclick='handleEdit(${data.ID
                })'></i></td>
              <td>${!data.ZONE ? "-" : data.ZONE}</td>
              <td>${!data.WARD ? "-" : data.WARD}</td>
              <td>${!data.DESK_ENGINEER_NAME ? "-" : data.DESK_ENGINEER_NAME
                }</td>
              <td>${!data.CONTACT_NUMBER ? "-" : data.CONTACT_NUMBER}</td>
              <td>${!data.DESK_ENGINEER_MAIL_ID ? "-" : data.DESK_ENGINEER_MAIL_ID
                }</td>
              <td>${!data.FIELD_ENGINEER_NAME ? "-" : data.FIELD_ENGINEER_NAME
                }</td>
              <td>${!data.CONTACT_NUMBER2 ? "-" : data.CONTACT_NUMBER2}</td>
              <td>${!data.FIELD_ENGINEER_MAIL_ID ? "-" : data.FIELD_ENGINEER_MAIL_ID
                }</td>
              <td>${!data.Ward_Officer ? "-" : data.Ward_Officer}</td>
              <td>${!data.JE_Junior_Engineer ? "-" : data.JE_Junior_Engineer
                }</td>
              <td>${!data.JE_MAIL_ID ? "-" : data.JE_MAIL_ID}</td>
              <td>${!data.JE_MOBILE_NUMBER ? "-" : data.JE_MOBILE_NUMBER}</td>
              <td>${!data.DSI_NAME ? "-" : data.DSI_NAME}</td>
              <td>${!data.DSI_MAIL_ID ? "-" : data.DSI_MAIL_ID}</td>
              <td>${!data.DSI_MOBILE_NO ? "-" : data.DSI_MOBILE_NO}</td>
              <td>${!data.SI_NAME ? "-" : data.SI_NAME}</td>
              <td>${!data.SI_MAIL_ID ? "-" : data.SI_MAIL_ID}</td>
              <td>${!data.SI_MOBILE_NO ? "-" : data.SI_MOBILE_NO}</td>
          </tr>`;

            table.querySelector("tbody").appendChild(tr);
        }
        $("#tableWrapper").slideDown("slow");
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const autoFillForm = async (data) => {
    $("#feederNameInput").val(data[0].feedername);
    //$("#zoneInput").val(data[0].ZONE);
    //$("#wardInput").val(data[0].WARD);
    zoneDropdown.fstdropdown.setValue(data[0].ZoneId);
    await populateWardDropdown();
    wardDropdown.fstdropdown.setValue(data[0].PK_wardId);
    $("#deskEngineerNameInput").val(data[0].DESK_ENGINEER_NAME);
    $("#deskEngineerContactInput").val(data[0].CONTACT_NUMBER);
    $("#deskEngineerEmailInput").val(data[0].DESK_ENGINEER_MAIL_ID);
    $("#fieldEngineerNameInput").val(data[0].FIELD_ENGINEER_NAME);
    $("#fieldEngineerContactInput").val(data[0].CONTACT_NUMBER2);
    $("#fieldEngineerEmailInput").val(data[0].FIELD_ENGINEER_MAIL_ID);
    $("#wardOfficerInput").val(data[0].Ward_Officer);
    $("#juniorEngineerNameInput").val(data[0].JE_Junior_Engineer);
    $("#juniorEngineerEmailInput").val(data[0].JE_MAIL_ID);
    $("#juniorEngineerContactInput").val(data[0].JE_MOBILE_NUMBER);
    $("#dsiNameInput").val(data[0].DSI_NAME);
    $("#dsiEmailInput").val(data[0].DSI_MAIL_ID);
    $("#dsiContactInput").val(data[0].DSI_MOBILE_NO);
    $("#siNameInput").val(data[0].SI_NAME);
    $("#siEmailInput").val(data[0].SI_MAIL_ID);
    $("#siContactIput").val(data[0].SI_MOBILE_NO);

    rowToEdit = data[0].ID;
};

const handleEdit = async (targetRowID) => {
    console.log(targetRowID);
    try {
        isEditing = true;
        $("#btnSearch").text("Update");
        feederToEdit = targetRowID;
        const requestData = {
            storedProcedureName: "sp_manage_PMCcontactdetails",
            parameters: JSON.stringify({
                mode: 4,
                ID: targetRowID,
            }),
        };

        const response = await axios.post(commonApi, requestData);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let tableData = JSON.parse(commonReportMasterList);
        console.log("edit data", tableData);
        autoFillForm(tableData);
        $("#editPanel").show();
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const handleZoneSelect = async () => {
    await populateWardDropdown();
};

const handleSubmit = async () => {
    try {
        if (isEditing) {
            const requestData = {
                storedProcedureName: "sp_manage_PMCcontactdetails",
                parameters: JSON.stringify({
                    mode: 2,
                    ID: rowToEdit,
                    //ZONE: parseInt($("#zoneInput").val(), 10),
                    //WARD: $("#wardInput").val(),
                    ZONE: $("#zoneDropdown option:selected").text(),
                    ZoneId: $("#zoneDropdown").val(),
                    WARD: $("#wardDropdown option:selected").text(),
                    WardId: $("#wardDropdown").val(),
                    DESK_ENGINEER_NAME: $("#deskEngineerNameInput").val(),
                    CONTACT_NUMBER: parseInt($("#deskEngineerContactInput").val(), 10),
                    DESK_ENGINEER_MAIL_ID: $("#deskEngineerEmailInput").val(),
                    FIELD_ENGINEER_NAME: $("#fieldEngineerNameInput").val(),
                    CONTACT_NUMBER2: parseInt($("#fieldEngineerContactInput").val(), 10),
                    FIELD_ENGINEER_MAIL_ID: $("#fieldEngineerEmailInput").val(),
                    Ward_Officer: $("#wardOfficerInput").val(),
                    JE_Junior_Engineer: $("#juniorEngineerNameInput").val(),
                    JE_MAIL_ID: $("#juniorEngineerEmailInput").val(),
                    JE_MOBILE_NUMBER: parseInt($("#juniorEngineerContactInput").val(), 10),
                    DSI_NAME: $("#dsiNameInput").val(),
                    DSI_MAIL_ID: $("#dsiEmailInput").val(),
                    DSI_MOBILE_NO: parseInt($("#dsiContactInput").val(), 10),
                    SI_NAME: $("#siNameInput").val(),
                    SI_MAIL_ID: $("#siEmailInput").val(),
                    SI_MOBILE_NO: parseInt($("#siContactIput").val(), 10),
                }),
            };

            console.log("isEditing", requestData);
            const response = await axios.post(commonApi, requestData);
            console.log("response", response);
            const commonReportMasterList =
                response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

            let tableData = JSON.parse(commonReportMasterList);
            console.log(tableData);

            if (tableData[0].msg === "Success") {
                Swal.fire({
                    title: "Done!",
                    text: "Edited successfully",
                    icon: "success",
                });
                isEditing = false;
                clearAllFields();
                $("#editPanel").hide();
                await populateTable();
            } else {
                Swal.fire({
                    title: "Oops!",
                    text: "Something went wrong",
                    icon: "error",
                });
            }
            isEditing = false;
            rowToEdit = 0;
        }
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const handleCancel = () => {
    rowToEdit = 0;
    clearAllFields();
    $("#editPanel").hide();
};

const clearAllFields = () => {
    $("#zoneInput").val("");
    $("#wardInput").val("");
    $("#deskEngineerNameInput").val("");
    $("#deskEngineerContactInput").val("");
    $("#deskEngineerEmailInput").val("");
    $("#fieldEngineerNameInput").val("");
    $("#fieldEngineerContactInput").val("");
    $("#fieldEngineerEmailInput").val("");
    $("#wardOfficerInput").val("");
    $("#juniorEngineerNameInput").val("");
    $("#juniorEngineerEmailInput").val("");
    $("#juniorEngineerContactInput").val("");
    $("#dsiNameInput").val("");
    $("#dsiEmailInput").val("");
    $("#dsiContactInput").val("");
    $("#siNameInput").val("");
    $("#siEmailInput").val("");
    $("#siContactIput").val("");
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
    await populateTable();
});
