const shiftInput = document.getElementById("shiftInput");
const startTime = document.getElementById("startTime");
const endTime = document.getElementById("endTime");

const table = document.getElementById("table");

let isEditing = false;
let shiftToEdit = 0;

const getData = async () => {
    try {
        const requestData = {
            storedProcedureName: "proc_AddShifts",
            parameters: JSON.stringify({
                mode: 1,
                ShiftId: 0,
                FK_AccId: 11401,
            }),
        };

        const response = await axios.post(commonApi, requestData);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let tableData = JSON.parse(commonReportMasterList);
        console.log(tableData);

        let srNo = 0;

        setDataTable(table);

        for (const data of tableData) {
            srNo++;
            const tr = document.createElement("tr");
            tr.innerHTML = `<tr>
              <td>${srNo}</td>
              <td>${!data.ShiftName ? "-" : data.ShiftName}</td>
              <td>${!data.StartTime ? "-" : data.StartTime}</td>
              <td>${!data.EndTime ? "-" : data.EndTime}</td>
              <td>${
                !data.Optime
                    ? "-"
                    : `${data.Optime.split("T")[0]} ${data.Optime.split("T")[1]}`
                }</td>
              <td><button type='button' class='btn btn-sm btn-info text-white' onclick='handleEdit(${JSON.stringify(
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

const handleEdit = (data) => {
    console.log(data);
    isEditing = true;
    shiftInput.value = data.ShiftName;
    startTime.value = data.StartTime;
    endTime.value = data.EndTime;
    shiftToEdit = data.ShiftId;
    $("#shiftInput").prop("disabled", true);
};

const handleSubmit = async () => {
    if (
        shiftInput.value === "" ||
        startTime.value === "" ||
        endTime.value === ""
    ) {
        Swal.fire({
            title: "Attention",
            text: "Please fill shift name, start time and end time",
            icon: "info",
        });
        return;
    }
    try {
        if (!isEditing) {
            const requestData = {
                storedProcedureName: "proc_AddShifts ",
                parameters: JSON.stringify({
                    mode: 2,
                    FK_AccId: 11401,
                    ShiftName: shiftInput.value,
                    StartTime: startTime.value,
                    EndTime: endTime.value,
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
                storedProcedureName: "proc_AddShifts ",
                parameters: JSON.stringify({
                    mode: 3,
                    FK_AccId: 11401,
                    ShiftName: shiftInput.value,
                    StartTime: startTime.value,
                    EndTime: endTime.value,
                    ShiftId: shiftToEdit,
                }),
            };

            console.log("editing record", requestData);
            const response = await axios.post(commonApi, requestData);
            console.log(response);

            if (response.data.CommonMethodResult.Message === "success") {
                Swal.fire({
                    title: "Done!",
                    text: "edited successfully",
                    icon: "success",
                });
            }
            await getData();
            handleCancel();
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
    shiftInput.value = "";
    startTime.value = "";
    endTime.value = "";
    shiftToEdit = 0;
    $("#shiftInput").prop("disabled", false);
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
                    title: 'Add shift' + " - " + getFormattedDate(),
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

window.addEventListener("load", getData());
