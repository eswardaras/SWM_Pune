const plantTypeInput = document.getElementById("plantTypeInput");
const plantNameInput = document.getElementById("plantNameInput");
const locationInput = document.getElementById("locationInput");

const btnSubmit = document.getElementById("btnSubmit");
const btnCancel = document.getElementById("btnCancel");

const table = document.getElementById("table");

isEditing = false;
plantIdToEdit = 0;

const populateTable = async () => {
    try {
        campaignDropdown.innerHTML = '<option value="0">Select Campaign</option>';

        const requestData = {
            storedProcedureName: "proc_CreateCampaign",
            parameters: JSON.stringify({
                mode: 27,
            }),
        };

        const response = await axios.post(commonApi, requestData);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let dropdownData = JSON.parse(commonReportMasterList);

        for (const data of dropdownData) {
            const option = document.createElement("option");
            option.value = data.pk_campid;
            option.text = data.campname;
            campaignDropdown.appendChild(option);
        }
        campaignDropdown.fstdropdown.rebind();
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const getData = async () => {
    $("#table tbody").empty();
    try {
        const requestData = {
            storedProcedureName: "proc_AddTypeofEndProcessingUnit",
            parameters: JSON.stringify({
                mode: 1,
            }),
        };

        const response = await axios.post(commonApi, requestData);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let tableData = JSON.parse(commonReportMasterList);
        console.log(tableData);

        let srNo = 0;

        for (const data of tableData) {
            srNo++;
            const tr = document.createElement("tr");
            tr.innerHTML = `<tr>
              <td><input type="checkbox" class="rowCheck" value='${
                data.pk_TypeofEndProcessingUnit
                }' oninput='handlePlantSelect(event)'/></td>
              <td>${srNo}</td>
              <td>${!data.planttype ? "-" : data.planttype}</td>
              <td>${!data.plantname ? "-" : data.plantname}</td>
              <td>${!data.Location ? "-" : data.Location}</td>
              <td><button type='button' class='btn btn-sm btn-info text-white' onclick='handleEdit(${JSON.stringify(
                    data
                )})'>Edit</button></td>
          </tr>`;

            table.querySelector("tbody").appendChild(tr);
        }
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const handleDelete = async () => {
    if (plantsToDelete.length === 0) {
        Swal.fire({
            title: "Attention",
            text: "Please select a plant",
            icon: "info",
        });
        return;
    }

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
            for (plant of plantsToDelete) {
                const requestData = {
                    storedProcedureName: "proc_AddTypeofEndProcessingUnit ",
                    parameters: JSON.stringify({
                        mode: 4,
                        TypeofEndProcessingUnit_Id: plant,
                    }),
                };
                console.log(requestData);
                const response = await axios.post(commonApi, requestData);
                console.log(response);
            }
            await getData();
        } catch (error) {
            console.error("Error fetching data:", error);
        }
    }
};

const handleEdit = async (data) => {
    console.log(data);
    isEditing = true;
    plantTypeInput.value = data.planttype;
    plantNameInput.value = data.plantname;
    locationInput.value = data.Location;
    plantIdToEdit = data.pk_TypeofEndProcessingUnit;
};

const handleSubmit = async () => {
    if (
        plantTypeInput.value.length === 0 ||
        !plantNameInput.value.length === 0 ||
        locationInput.value.length === 0
    ) {
        Swal.fire({
            title: "Attention",
            text: "Please fill plant type, plant name and location",
            icon: "info",
        });
        return;
    }
    try {
        if (!isEditing) {
            const requestData = {
                storedProcedureName: "proc_AddTypeofEndProcessingUnit ",
                parameters: JSON.stringify({
                    mode: 2,
                    accid: 11401,
                    PlantName: DOMPurify.sanitize(plantNameInput.value),
                    PlantType: DOMPurify.sanitize(plantTypeInput.value),
                    Location: DOMPurify.sanitize(locationInput.value),
                }),
            };

            const response = await axios.post(commonApi, requestData);
            console.log("submiting new record", response);

            if (response.data.CommonMethodResult.Message === "success") {
                Swal.fire({
                    title: "Done!",
                    text: "New entry created successfully",
                    icon: "success",
                });
            }
            await getData();
        } else {
            const requestData = {
                storedProcedureName: "proc_AddTypeofEndProcessingUnit ",
                parameters: JSON.stringify({
                    mode: 3,
                    accid: 11401,
                    PlantName: DOMPurify.sanitize(plantNameInput.value),
                    PlantType: DOMPurify.sanitize(plantTypeInput.value),
                    Location: DOMPurify.sanitize(locationInput.value),
                    TypeofEndProcessingUnit_Id: plantIdToEdit,
                }),
            };

            console.log("editing record", requestData);
            const response = await axios.post(commonApi, requestData);

            if (response.data.CommonMethodResult.Message === "success") {
                Swal.fire({
                    title: "Done!",
                    text: "edited successfully",
                    icon: "success",
                });
            }
            await getData();
            plantIdToEdit = 0;
        }
    } catch (error) {
        Swal.fire({
            title: "Oops",
            text: "Something went wrong",
            icon: "error",
        });
        console.error("Error fetching data:", error);
    }
};

const handleCancel = async () => {
    isEditing = false;
    plantTypeInput.value = "";
    plantNameInput.value = "";
    locationInput.value = "";
    plantIdToEdit = 0;
};

const plantsToDelete = [];
const handlePlantSelect = async (e) => {
    const checkboxValue = e.target.value;

    if (e.target.checked) {
        plantsToDelete.push(checkboxValue);
        console.log(plantsToDelete);
    } else {
        const indexToRemove = plantsToDelete.indexOf(checkboxValue);
        if (indexToRemove !== -1) {
            plantsToDelete.splice(indexToRemove, 1);
            console.log(plantsToDelete);
        }
    }
};

// Input
const handleSelectAll = (e) => {
    if (e.target.checked) {
        $(".rowCheck").prop("checked", true);
    } else {
        $(".rowCheck").prop("checked", false);
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
            order: [0, 1, 2],
        });
    });
}

function getFormattedDate() {
    const today = new Date();
    const options = { year: "numeric", month: "short", day: "numeric" };
    return today.toLocaleDateString("en-US", options);
}

window.addEventListener("load", getData());
$("#selectAllCheckbox").on("change", handleSelectAll);
