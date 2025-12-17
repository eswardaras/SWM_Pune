const wasteTypeInput = document.getElementById("wasteTypeInput");
const wasteNameInput = document.getElementById("wasteNameInput");
const remarkNameInput = document.getElementById("remarkNameInput");

const btnSubmit = document.getElementById("btnSubmit");
const btnCancel = document.getElementById("btnCancel");

const table = document.getElementById("table");

let isEditing = false;
let wasteIdToEdit = 0;

const getData = async () => {
    $("#table tbody").empty();
    try {
        const requestData = {
            storedProcedureName: "proc_AddWasteType ",
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
                data.pk_wastetypeid
                }' oninput='handlePlantSelect(event)'/></td>
              <td>${srNo}</td>
              <td>${!data.wastetype ? "-" : data.wastetype}</td>
              <td>${!data.wastename ? "-" : data.wastename}</td>
              <td>${!data.remark ? "-" : data.remark}</td>
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
    if (wasteToDelete.length === 0) {
        Swal.fire({
            title: "Attention",
            text: "Please select a waste",
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
            for (waste of wasteToDelete) {
                const requestData = {
                    storedProcedureName: "proc_AddWasteType ",
                    parameters: JSON.stringify({
                        mode: 4,
                        WasteTypeId: waste,
                    }),
                };
                console.log(requestData);
                const response = await axios.post(commonApi, requestData);
                console.log(response);
                if (response.data.CommonMethodResult.Message === "success") {
                    Swal.fire({
                        title: "Done!",
                        text: "deleted successfully",
                        icon: "success",
                    });
                }
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
    wasteTypeInput.value = data.wastetype;
    wasteNameInput.value = data.wastename;
    remarkNameInput.value = data.remark;
    wasteIdToEdit = data.pk_wastetypeid;
};

const handleSubmit = async () => {
    if (
        wasteTypeInput.value === "" ||
        wasteNameInput.value === "" ||
        remarkNameInput.value === ""
    ) {
        Swal.fire({
            title: "Attention",
            text: "Please fill waste type, waste name and remark",
            icon: "info",
        });
        return;
    }
    try {
        if (!isEditing) {
            const requestData = {
                storedProcedureName: "proc_AddWasteType ",
                parameters: JSON.stringify({
                    mode: 2,
                    accid: 11401,
                    WasteName: wasteNameInput.value,
                    WasteType: wasteTypeInput.value,
                    Remark: remarkNameInput.value,
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
                storedProcedureName: "proc_AddWasteType ",
                parameters: JSON.stringify({
                    mode: 3,
                    accid: 11401,
                    WasteName: wasteNameInput.value,
                    WasteType: wasteTypeInput.value,
                    Remark: remarkNameInput.value,
                    WasteTypeId: wasteIdToEdit,
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
            wasteIdToEdit = 0;
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
    wasteTypeInput.value = "";
    wasteNameInput.value = "";
    remarkNameInput.value = "";
    wasteIdToEdit = 0;
};

const wasteToDelete = [];
const handlePlantSelect = async (e) => {
    const checkboxValue = e.target.value;

    if (e.target.checked) {
        wasteToDelete.push(checkboxValue);
        console.log(wasteToDelete);
    } else {
        const indexToRemove = wasteToDelete.indexOf(checkboxValue);
        if (indexToRemove !== -1) {
            wasteToDelete.splice(indexToRemove, 1);
            console.log(wasteToDelete);
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
                    title: 'Add type of waste' + " - " + getFormattedDate(),
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
