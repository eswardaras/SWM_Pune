window.addEventListener("load", async () => {
    /*  await populateDataGrid();*/

    // Add event listener for "View" button
    document.getElementById("filterBtn").addEventListener("click", () => {
        filterData();
    });

    // Add event listeners to radio buttons to update placeholder dynamically
    document.querySelectorAll('input[name="searchType"]').forEach(radio => {
        radio.addEventListener("change", updatePlaceholder);
    });


    // Set initial placeholder
    updatePlaceholder();
});


let tableData = [];
let currentPage = 1;
let recordsPerPage = 5;

const populateDataGrid = async () => {
    const loadingSpinner = document.getElementById("loadingSpinner");
    const button = document.getElementById("showVehicleListBtn");

    if (!loadingSpinner || !button) {
        console.error("Required elements not found");
        return;
    }

    try {
        console.log("Showing spinner");
        loadingSpinner.style.display = "block";
        button.disabled = true;

        const requestData = {
            storedProcedureName: "proc_myvehiclescs",
            parameters: JSON.stringify({
                mode: 3,
                accId: 11401,
                devicecompid: 0,
                vehiclename: ''
            }),
        };

        console.log(requestData, 'Request Data');
        const response = await axios.post(commonApi, requestData);

        console.log(response, 'Response Data');
        const commonReportMasterList = response.data.CommonMethodResult.CommonReportMasterList;

        tableData = JSON.parse(commonReportMasterList[0].ReturnValue);


        console.log(tableData, 'TableData')
        renderTableData(currentPage);

    } catch (error) {
        console.error("Error fetching data:", error);
    } finally {
        loadingSpinner.style.display = "none";
        button.disabled = false;
    }
};


// Render paginated data
const renderTableData = (page) => {

    const tableBody = document.querySelector("#table tbody");
    tableBody.innerHTML = '';


    const startIndex = (page - 1) * recordsPerPage;
    const endIndex = Math.min(startIndex + recordsPerPage, tableData.length);

    for (let i = startIndex; i < endIndex; i++) {
        const item = tableData[i];
        const row = document.createElement("tr");

        row.innerHTML = `
            <td>${i + 1}</td>
            <td>${item.vtype}</td>
            <td>${item.vehiclename}</td>
            <td>${item.username}</td>
            <td>${item.dtype}<br>${item.pbctype}<br>${item.SignalStrength}</td>
            <td>
                <strong>IMEI:</strong> ${item.imei} <br>
                <strong>SIM:</strong> ${item.sim} <br>
                <strong>Operator:</strong> ${item.Operator}
            </td>
            <td>${item.Active}</td>
            <td>${item.installtion}</td>
            <td>${item.expiry}</td>

            <td>${item.last}</td>
            <td>${item.inDays}</td>
                <td>
                <i
                    class="fa-solid fa-pen-to-square text-primary cursor-pointer"
                    onclick="handleEditRedirect('${item.vehiclename}','${item.FK_AccId}','${item.PK_VehicleId}')">
                </i>
            </td>
        `;
        tableBody.appendChild(row);
    }
    updatePaginationControls();
};



const handleEditRedirect = (vehiclename, accId, id) => {
    const searchType = document.querySelector('input[name="searchType"]:checked') ?.value || '';

    const queryString = new URLSearchParams({
        vname: vehiclename,
        ACK: `${accId}`,
        ID: id,
        readonlyIMEI: searchType === "IMEI" ? "true" : "false",
        readonlyVehicleName: searchType === "VehicleName" ? "true" : "false",
        readonlySimNumber: searchType === "SimNumber" ? "true" : "false"
    }).toString();

    console.log('Query string:', queryString);
    window.location.href = `EditDeviceInfo.aspx?${queryString}`;
};




// Update pagination controls
const updatePaginationControls = () => {
    const paginationWrapper = document.getElementById("paginationWrapper");
    const totalPages = Math.ceil(tableData.length / recordsPerPage);

    const maxVisibleButtons = 5; // Maximum visible page numbers
    let startPage = Math.max(1, currentPage - Math.floor(maxVisibleButtons / 2));
    let endPage = Math.min(totalPages, startPage + maxVisibleButtons - 1);

    if (endPage - startPage < maxVisibleButtons - 1) {
        startPage = Math.max(1, endPage - maxVisibleButtons + 1);
    }

    let paginationHTML = `
        <button ${currentPage === 1 ? 'disabled' : ''} onclick="changePage(${currentPage - 1})">&larr; Previous</button>
    `;

    for (let i = startPage; i <= endPage; i++) {
        paginationHTML += `
            <button ${i === currentPage ? 'class="active"' : ''} onclick="changePage(${i})">${i}</button>
        `;
    }

    paginationHTML += `
        <button ${currentPage === totalPages ? 'disabled' : ''} onclick="changePage(${currentPage + 1})">Next &rarr;</button>
    `;

    paginationWrapper.innerHTML = paginationHTML;
};

const changePage = (page) => {
    const totalPages = Math.ceil(tableData.length / recordsPerPage);

    if (page < 1 || page > totalPages) return;

    currentPage = page;
    renderTableData(currentPage);
    updatePaginationControls();
};




const filterData = async () => {
    const searchInput = document.getElementById("searchInput").value.trim();
    const searchType = document.querySelector('input[name="searchType"]:checked').value;

    if (!searchInput) {
        alert("Please enter a search term.");
        return;
    }

    // Determine stored procedure mode based on search type
    let mode;
    switch (searchType) {
        case "IMEI":
            mode = 6;
            break;
        case "VehicleName":
            mode = 7;
            break;
        case "SimNumber":
            mode = 8;
            break;
        default:
            console.error("Invalid search type.");
            return;
    }

    // Prepare request payload
    const requestData = {
        storedProcedureName: "proc_myvehiclescs",
        parameters: JSON.stringify({
            mode: mode,
            accId: 11401,
            devicecompid: 0,
            vehiclename: searchInput  // Parameter used for all cases in stored procedure
        }),
    };

    try {
        console.log("Requesting filtered data...", requestData);

        const response = await axios.post(commonApi, requestData);

        const commonReportMasterList = response.data.CommonMethodResult.CommonReportMasterList;

        if (commonReportMasterList && commonReportMasterList.length > 0) {
            const filteredData = JSON.parse(commonReportMasterList[0].ReturnValue);

            // Assign to global tableData if needed
            tableData = filteredData;

            // Render filtered result
            renderTableData(filteredData);

            currentPage = 1; // Reset to first page
            tableData = filteredData;
            renderTableData(currentPage);



        } else {
            console.warn("No data found for the search.");
            renderTableData([]); // Clear table or show empty message
        }
    } catch (error) {
        console.error("Error fetching filtered data:", error);
        alert("Something went wrong while fetching data.");
    }
};


const renderFilteredData = (filteredData) => {
    const tableBody = document.querySelector("#table tbody");
    tableBody.innerHTML = ''; // Clear existing rows

    filteredData.forEach((item, index) => {
        const row = document.createElement("tr");

        row.innerHTML = `
            <td>${index + 1}</td>
            <td>${item.vtype}</td>
            <td>${item.vehiclename}</td>
            <td>${item.username}</td>
            <td>${item.dtype}<br>${item.SoftVer}<br>${item.pbctype}<br>${item.SignalStrength}</td>
            <td>
                <strong>IMEI:</strong> ${item.IMEI} <br>
                <strong>SIM:</strong> ${item.sim} <br>
                <strong>Operator:</strong> ${item.Operator}
            </td>
            <td>${item.Active}</td>
            <td>${item.installtion}</td>
            <td>${item.expiry}</td>
            <td>${item.RmkType}</td>
            <td>${item.last}</td>
            <td>${item.inDays}</td>
            <td>
                <button class="edit-btn" title="Edit">
                    <i class="fa fa-pencil"></i>
                </button>
            </td>
        `;
        tableBody.appendChild(row);
    });
};

const updatePlaceholder = () => {
    const searchType = document.querySelector('input[name="searchType"]:checked').value;
    const searchInput = document.getElementById("searchInput");

    switch (searchType) {
        case "IMEI":
            searchInput.placeholder = "Enter last digits of IMEI";
            break;
        case "VehicleName":
            searchInput.placeholder = "Enter Vehicle Name";
            break;
        case "SimNumber":
            searchInput.placeholder = "Enter last digits of SIM Number";
            break;
    }
};