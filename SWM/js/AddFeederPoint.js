const zoneDropdown = document.getElementById("zoneDropdown");
const wardDropdown = document.getElementById("wardDropdown");
const vehicleDropdown = document.getElementById("vehicleDropdown");
const routeDropdown = document.getElementById("routeDropdown");

const feederNameInput = document.getElementById("feederNameInput");
const latitudeInput = document.getElementById("latitudeInput");
const longitudeInput = document.getElementById("longitudeInput");
const addressInput = document.getElementById("addressInput");
const expectedTimeInput = document.getElementById("expectedTimeInput");

const table = document.getElementById("table");

let isEditing = false;
let feederToEdit;

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

const populateVehicleDropdown = async () => {
    try {
        $("#vehicleDropdown").empty();
        $("#vehicleDropdown").append(
            $("<option>", {
                value: "0",
                text: "Select Vehicle",
            })
        );
        const requestData = {
            storedProcedureName: "proc_InsertFeederPoint",
            parameters: JSON.stringify({
                mode: 3,
                fk_accid: 11401,
                fk_wardid: wardDropdown.value,
            }),
        };

        const response = await axios.post(commonApi, requestData);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let dropdownData = JSON.parse(commonReportMasterList);
        console.log(dropdownData);

        for (const data of dropdownData) {
            const option = document.createElement("option");
            option.value = data.pk_vehicleid;
            option.text = data.vehiclename;
            vehicleDropdown.appendChild(option);
        }
        vehicleDropdown.fstdropdown.rebind();
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const populateRouteDropdown = async () => {
    try {
        $("#routeDropdown").empty();
        $("#routeDropdown").append(
            $("<option>", {
                value: "0",
                text: "Select Route",
            })
        );
        routeDropdown.fstdropdown.rebind();
        const requestData = {
            storedProcedureName: "proc_InsertFeederPoint",
            parameters: JSON.stringify({
                mode: 4,
                fk_accid: 11401,
                fk_vehicleid: vehicleDropdown.value,
            }),
        };

        const response = await axios.post(commonApi, requestData);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let dropdownData = JSON.parse(commonReportMasterList);
        console.log(dropdownData);

        if (dropdownData[0] && dropdownData[0].Message) {
            Swal.fire({
                title: "Attention!",
                text: "No route found",
                icon: "info",
            });
            return;
        }

        for (const data of dropdownData) {
            const option = document.createElement("option");
            option.value = data.routeid;
            option.text = data.routename;
            routeDropdown.appendChild(option);
        }
        routeDropdown.fstdropdown.rebind();
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const populateTable = async () => {
    try {
        const requestData = {
            storedProcedureName: "proc_InsertFeederPoint",
            parameters: JSON.stringify({
                mode: 6,
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
              <td>${!data.ZoneName ? "-" : data.ZoneName}</td>
              <td>${!data.wardname ? "-" : data.wardname}</td>
              <td>${!data.vehiclename ? "-" : data.vehiclename}</td>
              <td>${!data.RouteName ? "-" : data.RouteName}</td>
              <td>${!data.feedername ? "-" : data.feedername}</td>
              <td>${
                !data.optime
                    ? "-"
                    : `${data.optime.split("T")[0]} ${data.optime.split("T")[1]}`
                }</td>
              <td><i class="fa-solid fa-pen-to-square text-info cursor-pointer" onclick='handleEdit(${
                data.pk_feederid
                })'></i></td>
              <td><i class="fa-solid fa-trash-can text-danger cursor-pointer" onclick='handleDelete(${
                data.pk_feederid
                })'></i></td>
          </tr>`;

            table.querySelector("tbody").appendChild(tr);
        }
        $("#tableWrapper").slideDown("slow");
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const autoFillForm = async (data) => {
    // zoneDropdown.fstdropdown.setValue(0);
    // wardDropdown.fstdropdown.setValue(0);
    // vehicleDropdown.fstdropdown.setValue(0);
    // routeDropdown.fstdropdown.setValue(0);

    const expectedtime12h = data[0].expectedtime;
    const expectedtime24h = convertTo24HourFormat(expectedtime12h);

    $("#feederNameInput").val(data[0].feedername);
    $("#latitudeInput").val(data[0].latitude);
    $("#longitudeInput").val(data[0].longitude);
    $("#expectedTimeInput").val(expectedtime24h);
    $("#addressInput").val(data[0].address);

    zoneDropdown.fstdropdown.setValue(data[0].fk_zoneid);
    await populateWardDropdown();
    wardDropdown.fstdropdown.setValue(data[0].fk_wardid);
    await populateVehicleDropdown();
    vehicleDropdown.fstdropdown.setValue(data[0].fk_vehicleid);
    await populateRouteDropdown();
    routeDropdown.fstdropdown.setValue(data[0].fk_routeid);
};

const convertTo24HourFormat = (time12h) => {
    const [time, modifier] = time12h.split(" ");

    let [hours, minutes] = time.split(":");

    if (hours === "12") {
        hours = "00";
    }

    if (modifier === "PM") {
        hours = parseInt(hours, 10) + 12;
    }

    return `${String(hours).padStart(2, "0")}:${minutes}`;
};

const convertTo12HourFormat = (time24h) => {
    let [hours, minutes] = time24h.split(":");
    hours = parseInt(hours, 10);
    const ampm = hours >= 12 ? "PM" : "AM";
    hours = hours % 12 || 12; // Convert 0 to 12 for 12 AM
    return `${hours}:${minutes} ${ampm}`;
};

const handleEdit = async (feederId) => {
    console.log(feederId);
    try {
        isEditing = true;
        $("#btnSearch").text("Update");
        feederToEdit = feederId;
        const requestData = {
            storedProcedureName: "proc_InsertFeederPoint",
            parameters: JSON.stringify({
                mode: 7,
                fk_feederid: feederId,
            }),
        };

        const response = await axios.post(commonApi, requestData);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let tableData = JSON.parse(commonReportMasterList);
        console.log("edit data", tableData);
        autoFillForm(tableData);
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const handleDelete = async (feederId) => {
    console.log(feederId);
    const userConfirmed = await Swal.fire({
        title: "Are you sure?",
        text: "You won't be able to revert this back",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "Yes, Delete it!",
    });

    if (userConfirmed.isConfirmed) {
        try {
            const requestData = {
                storedProcedureName: "proc_InsertFeederPoint",
                parameters: JSON.stringify({
                    mode: 9,
                    fk_feederid: feederId,
                }),
            };

            const response = await axios.post(commonApi, requestData);
            if (response.data.CommonMethodResult.Message === "success") {
                Swal.fire({
                    title: "Done!",
                    text: "Deleted successfully",
                    icon: "success",
                });
                await populateTable();
            } else {
                Swal.fire({
                    title: "Oops!",
                    text: "Something went wrong",
                    icon: "error",
                });
            }
        } catch (error) {
            console.error("Error fetching data:", error);
        }
    }
};

const handleSubmit = async () => {
    if (
        !zoneDropdown.value ||
        !wardDropdown.value ||
        !vehicleDropdown.value ||
        !routeDropdown.value ||
        feederNameInput.value.length === 0 ||
        latitudeInput.value.length === 0 ||
        longitudeInput.value.length === 0 ||
        expectedTimeInput.value.length === 0 ||
        addressInput.value.length === 0 ||
        feederNameInput.value === "" ||
        latitudeInput.value === "" ||
        longitudeInput.value === "" ||
        expectedTimeInput.value === "" ||
        addressInput.value === ""
    ) {
        return Swal.fire({
            title: "Attention",
            text: "Please fill all the fields",
            icon: "info",
        });
    }
    try {
        if (isEditing) {
            const requestData = {
                storedProcedureName: "proc_InsertFeederPoint",
                parameters: JSON.stringify({
                    mode: 8,
                    fk_accid: 11401,
                    fk_routeid: routeDropdown.value,
                    fk_vehicleid: vehicleDropdown.value,
                    fk_zoneid: zoneDropdown.value,
                    fk_wardid: wardDropdown.value,
                    feedername: feederNameInput.value,
                    lat: latitudeInput.value,
                    lng: longitudeInput.value,
                    expectedtime: convertTo12HourFormat(expectedTimeInput.value),
                    address: addressInput.value,
                    fk_feederid: feederToEdit,
                }),
            };

            console.log("isEditing", requestData);
            const response = await axios.post(commonApi, requestData);

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
                await populateTable();
            } else {
                Swal.fire({
                    title: "Oops!",
                    text: "Something went wrong",
                    icon: "error",
                });
            }
            isEditing = false;
            feederToEdit = 0;
        } else {
            const requestData = {
                storedProcedureName: "proc_InsertFeederPoint",
                parameters: JSON.stringify({
                    mode: 5,
                    fk_accid: 11401,
                    fk_routeid: routeDropdown.value,
                    fk_vehicleid: vehicleDropdown.value,
                    fk_zoneid: zoneDropdown.value,
                    fk_wardid: wardDropdown.value,
                    feedername: feederNameInput.value,
                    lat: latitudeInput.value,
                    lng: longitudeInput.value,
                    address: addressInput.value,
                    expectedtime: convertTo12HourFormat(expectedTimeInput.value),
                }),
            };

            console.log("requestData", requestData);
            const response = await axios.post(commonApi, requestData);
            console.log(response);

            const commonReportMasterList =
                response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

            let tableData = JSON.parse(commonReportMasterList);
            console.log(tableData);

            if (tableData[0].msg === "Success") {
                Swal.fire({
                    title: "Done!",
                    text: "New entry created successfully",
                    icon: "success",
                });
                clearAllFields();
                await populateTable();
            } else if (tableData[0].msg === "fail") {
                Swal.fire({
                    title: "Oops!",
                    text: "Already exists",
                    icon: "error",
                });
            }
        }
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

const handleVehicleSelect = async () => {
    await populateRouteDropdown();
};

const clearAllFields = () => {
    $("#feederNameInput").val("");
    $("#latitudeInput").val("");
    $("#longitudeInput").val("");
    $("#expectedTimeInput").val("");
    $("#addressInput").val("");
    $("#btnSearch").text("Add Feeder");

    zoneDropdown.fstdropdown.setValue(0);
    wardDropdown.fstdropdown.setValue(0);
    vehicleDropdown.fstdropdown.setValue(0);
    routeDropdown.fstdropdown.setValue(0);
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
    //await populateZoneDropdown();
    await populateTable();
});
