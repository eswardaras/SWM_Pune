const routeNameInput = document.getElementById("routeNameInput");
const table = document.getElementById("table");

let routeToEdit;
let isEditing = false;


// Zone

const populateTable = async () => {
    try {
        const requestData = {
            storedProcedureName: "proc_EditRouteName",
            parameters: JSON.stringify({
                mode: 1,
                accid: 11401,
            }),
        };

        const response = await axios.post(commonApi, requestData);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let tableData = JSON.parse(commonReportMasterList);

        setDataTable(table);

        let srNo = 0;
        for (const data of tableData) {
            srNo++;
            const tr = document.createElement("tr");
            tr.innerHTML = `<tr>
              <td>${srNo}</td>
              <td>${!data.routename ? "-" : data.routename}</td>
              <td><button type='button' class='btn btn-sm btn-info' onclick='handleEdit(${JSON.stringify(
                    data
                )})'>Edit</button></td>
              <td><button type='button' class='btn btn-sm btn-danger' onclick='handleDelete(${
                data.routeid
                })'>Delete</button></td>
          </tr>`;

            table.querySelector("tbody").appendChild(tr);
        }
        $("#tableWrapper").slideDown("slow");
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const handleEdit = async (data) => {
    $("#editPanel").show("fast");
    isEditing = true;
    routeNameInput.value = data.routename;
    routeToEdit = data.routeid;
};

const handleDelete = async (routeid) => {
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
                storedProcedureName: "proc_EditRouteName",
                parameters: JSON.stringify({
                    mode: 3,
                    accid: 11401,
                    routeid,
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

const handleUpdate = async () => {
    if (routeNameInput.value === "") {
        Swal.fire({
            icon: "info",
            title: "Attention",
            text: "Please fill route name",
        });
        return;
    }
    try {
        if (isEditing) {
            const requestData = {
                storedProcedureName: "proc_EditRouteName",
                parameters: JSON.stringify({
                    mode: 4,
                    accid: 11401,
                    routename: DOMPurify.sanitize(routeNameInput.value),
                    routeid: routeToEdit,
                }),
            };

            const response = await axios.post(commonApi, requestData);
            if (response.data.CommonMethodResult.Message === "success") {
                Swal.fire({
                    title: "Done!",
                    text: "Edited successfully",
                    icon: "success",
                });
                routeToEdit = false;
                $("#editPanel").hide();
                await populateTable();
            } else {
                routeToEdit = false;
            }
        }
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const handleCancel = () => {
    routeNameInput.value = "";
    $("#editPanel").hide();
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
});
