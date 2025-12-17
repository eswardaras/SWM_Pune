window.addEventListener("load", async () => {

    await populateRampDropdown();
    await populateDataGrid();
});

const table = document.getElementById("table");

const populateRampDropdown = async () => {
    try {
        const ddlRamp = document.getElementById("ddlRamp");

        // Clear existing options
        ddlRamp.innerHTML = "";

        const requestData = {
            storedProcedureName: "proc_RampDashboard",
            parameters: JSON.stringify({
                mode: 1

            }),
        };

        const response = await axios.post(commonApi, requestData);
        console.log("Dropdown Data Response:", response);

        const rampList =
            response.data.CommonMethodResult.CommonReportMasterList;

        // Parse and process the data
        const dropdownData = JSON.parse(rampList[0].ReturnValue); // Dropdown data

        console.log("Parsed Dropdown Data:", dropdownData);

        // Add a default option
        //const defaultOption = document.createElement("option");
        //defaultOption.value = "";
        //defaultOption.textContent = "Select Ramp Name";
        //ddlRamp.appendChild(defaultOption);

        // Add options from data
        dropdownData.forEach((item) => {
            const option = document.createElement("option");
            option.value = item.RMM_ID; // Use the unique ID for value
            option.textContent = item.RMM_NAME
                ; // Use the name for display
            ddlRamp.appendChild(option);
        });
        ddlRamp.fstdropdown.rebind();
        console.log("Dropdown populated successfully.");
    } catch (error) {
        console.error("Error populating dropdown:", error);
    }
};

const populateDataGrid = async () => {
    try {
        const tableBody = document.querySelector("#table tbody");
        const dateInput = document.getElementById('Date');
        const ddlRamp = document.getElementById('ddlRamp');

        const requestData = {
            storedProcedureName: "proc_Ramp_Get_Data_FOR_WAIT_TIME_CALCULATION",
            parameters: JSON.stringify({
                mode: 2,
                ramp_id: ddlRamp.value,
                Att_Date: dateInput.value

            }),
        };
        console.log('before', requestData)
        const response = await axios.post(commonApi, requestData);
        console.log("Table Data Response:", response);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList;

        // Parse and process the data
        const tableData = JSON.parse(commonReportMasterList[0].ReturnValue); // Main data

        console.log("Parsed Table Data:", tableData);
        setDataTable("#table");

        let srNo = 0;
        tableData.forEach((item) => {
            srNo++;
            const row = document.createElement("tr");

            row.innerHTML = `
               <td>${srNo}</td>
              
              
                <td>${item.VEHICLE_DEPO_NO}</td>
                <td>${item.VEHICLENAME}</td>
                 <td>${item.VEHICLETYPE}</td>
                <td>${item.NET_WEIGHT}</td>
                <td>${item.GROSS_WEIGHT}</td>
                <td>${item.TARE_WEIGHT}</td>
                <td>${item.InTime}</td>
                <td>${item.Date}</td>
                <td>${item.OutTime}</td>
                <td>${item.WaitTime}</td>
              
            `;

            tableBody.appendChild(row);
        });

        // Show table and initialize DataTable
        $("#tableWrapper").slideDown("slow");


    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

// Function to initialize/reinitialize DataTable
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