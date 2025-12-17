const vehicleDropdown = document.getElementById("vehicleDropdown");
const routeDropdown = document.getElementById("routeDropdown");
const defaultDropdown = document.getElementById("defaultDropdown");
const table = document.getElementById("table");

let roleToEdit;
let isEditing = false;

const populateVehicleDropdown = async () => {
    try {
        const requestData = {
            storedProcedureName: "proc_AssignRoute",
            parameters: JSON.stringify({
                mode: 2,
                AccId: loginId,
            }),
        };

        const response = await axios.post(commonApi, requestData);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let dropdownData = JSON.parse(commonReportMasterList);

        for (const data of dropdownData) {
            const option = document.createElement("option");
            option.value = data.Pk_VehicleId;
            option.text = data.VehicleName;
            vehicleDropdown.appendChild(option);
        }
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const populateRouteDropdown = async () => {
    try {
        const requestData = {
            storedProcedureName: "proc_AssignRoute",
            parameters: JSON.stringify({
                mode: 1,
                AccId: loginId,
            }),
        };

        const response = await axios.post(commonApi, requestData);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let dropdownData = JSON.parse(commonReportMasterList);

        for (const data of dropdownData) {
            const option = document.createElement("option");
            option.value = data.RouteId;
            option.text = data.RouteName ? data.RouteName : "";
            routeDropdown.appendChild(option);
            if (data.RouteId === 6744) {
                console.log("is available");
            }
        }
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const populateDefaultDropdown = async (VehicleId) => {
    try {
        $("#defaultDropdown").empty();
        $("#defaultDropdown").append(
            $("<option>", {
                value: "0",
                text: "Select",
            })
        );
        $("#defaultDropdown").trigger("change.select2");
        const requestData = {
            storedProcedureName: "proc_AssignRoute",
            parameters: JSON.stringify({
                mode: 8,
                VehicleId,
            }),
        };

        const response = await axios.post(commonApi, requestData);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let dropdownData = JSON.parse(commonReportMasterList);

        for (const data of dropdownData) {
            const option = document.createElement("option");
            option.value = data.RouteId;
            option.text = data.RouteName ? data.RouteName : "";
            defaultDropdown.appendChild(option);
        }
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const populateTable = async () => {
    try {
        const requestData = {
            storedProcedureName: "proc_AssignRoute",
            parameters: JSON.stringify({
                mode: 4,
                AccId: loginId,
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
              <td>${!data.vehicleName ? "-" : data.vehicleName}</td>
              <td>${!data.RouteName ? "-" : data.RouteName}</td>
          </tr>`;

            table.querySelector("tbody").appendChild(tr);
        }
        $("#tableWrapper").slideDown("slow");
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const handleEdit = async (data) => {
    console.log(data);
    $("#editPanel").show("fast");
    isEditing = true;
    roleNameInput.value = data.RoleName;
    roleToEdit = data.PK_RoldeId;
};

const handleDelete = async (pk_roleid) => {
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
                storedProcedureName: "proc_AssignRoute",
                parameters: JSON.stringify({
                    mode: 5,
                    UserId: 11401,
                    VehicleId: $("#vehicleDropdown").val(),
                }),
            };

            const response = await axios.post(commonApi, requestData);
            console.log(response);
            if (response.status === 200) {
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
    if (vehicleDropdown.value === "") {
        Swal.fire({
            icon: "info",
            title: "Attention",
            text: "Please fill role name",
        });
        return;
    }
    try {
        const requestData = {
            storedProcedureName: "proc_AssignRoute",
            parameters: JSON.stringify({
                mode: 33,
                UserId: 11401,
                VehicleId: $("#vehicleDropdown").val(),
                RouteId: $("#routeDropdown").val()[0],
                AccId: loginId,
            }),
        };

        console.log(requestData);

        const response = await axios.post(commonApi, requestData);
        console.log(response);
        if (response.data.CommonMethodResult.Message === "success") {
            Swal.fire({
                title: "Done!",
                text: "Edited successfully",
                icon: "success",
            });
            roleToEdit = false;
            await populateTable();
        }
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

// Handlers

const handleVehicleSelect = async (e) => {
    const { value: VehicleId } = e.target;
    console.log(vehicleDropdown.value);

    if (vehicleDropdown.value == 0) return;
    try {
        const requestData = {
            storedProcedureName: "proc_AssignRoute",
            parameters: JSON.stringify({
                mode: 6,
                VehicleId,
            }),
        };

        const response = await axios.post(commonApi, requestData);
        console.log(response);
        if (response.data.CommonMethodResult.CommonReportMasterList) {
            const commonReportMasterList =
                response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

            let dropdownData = JSON.parse(commonReportMasterList);

            let selectedValues = [];
            for (const data of dropdownData) {
                selectedValues.push(data.fk_RouteId);
            }

            $("#routeDropdown").val(selectedValues);
            $("#routeDropdown").trigger("change.select2");
            await populateDefaultDropdown(VehicleId);
        } else {
            $("#routeDropdown").val([]);
            $("#routeDropdown").trigger("change.select2");
        }
    } catch (error) {
        $("#routeDropdown").val([]);
        $("#routeDropdown").trigger("change.select2");

        Swal.fire({
            icon: "error",
            title: "Oops",
            text: "No route found",
            timer: 2000,
            timerProgressBar: true,
        });
        console.error("Error fetching data:", error);
    }
};

const handleRouteSelect = (e) => {
    const selectedRouteIds = $(e.target).val(); // Get selected values from #routeDropdown
    const selectedRouteNames = $(e.target)
        .find("option:selected")
        .map(function () {
            return $(this).text();
        })
        .get();

    const defaultDropdown = $("#defaultDropdown");
    defaultDropdown.empty();
    $("#defaultDropdown").append(
        $("<option>", {
            value: "0",
            text: "Select",
        })
    );

    selectedRouteNames.forEach(function (name, index) {
        defaultDropdown.append(
            $("<option>", {
                value: selectedRouteIds[index],
                text: name,
            })
        );
    });

    defaultDropdown.trigger("change.select2");
};

const handleRefresh = () => {
    $("#vehicleDropdown").val(0);
    $("#vehicleDropdown").trigger("change.select2");
    $("#routeDropdown").val([]);
    $("#routeDropdown").trigger("change.select2");
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
    await populateTable();
    await populateVehicleDropdown();
    await populateRouteDropdown();
});

$(document).ready(function () {
    $("#vehicleDropdown").select2();
    $("#routeDropdown").select2();
    $("#defaultDropdown").select2();
});