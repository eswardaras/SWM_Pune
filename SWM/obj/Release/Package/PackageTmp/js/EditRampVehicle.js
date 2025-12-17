
let tableData = []; // Declare a global variable to store the data


let vcmidvalue = '1';
console.log(tableData, 'table data show ')

let isEditing = false;
let VehicleToEdit;
window.addEventListener("load", async () => {
    await populateDataGrid();
    await GetVehicleType();

});



const table = document.getElementById("table");
const populateDataGrid = async () => {
    try {
        const tableBody = document.querySelector("#table tbody");

        const requestData = {
            storedProcedureName: "proc_myvehiclescs",
            parameters: JSON.stringify({
                mode: 19,
                accid: 11401
                

            }),
        };
        console.log('before', requestData)
        const response = await axios.post(commonApi, requestData);
        console.log("Table Data Response:", response);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList;

        // Parse and process the data
         tableData = JSON.parse(commonReportMasterList[0].ReturnValue); // Main data

        console.log("Parsed Table Data:", tableData);
        setDataTable("#table");

        let srNo = 0;
        tableData.forEach((item) => {
            srNo++;
            const row = document.createElement("tr");

            row.innerHTML = `
               <td>${srNo}</td>
              
                <td>${item.VTM_NAME}</td>
                <td>${item.VCM_DEPO_NO}</td>
                <td>${item.VCM_TARE_WEIGHT}</td>
             
                <td>${item.VTA_RTO_NO}</td>
                <td>${item.VCM_COMPARTMENT}</td>
                <td>
    <i
        class="fa-solid fa-pen-to-square text-primary cursor-pointer"
        onclick="handleEdit('${item.VCM_ID}','${item.VTM_NAME}','${item.VCM_DEPO_NO}','${item.VCM_TARE_WEIGHT}','${item.VTA_RTO_NO}','${item.VCM_COMPARTMENT}','${item.VTM_ID}')">
    </i>
</td>
            `;

            tableBody.appendChild(row);
        });

        // Show table and initialize DataTable
        $("#tableWrapper").slideDown("slow");


    } catch (error) {
        console.error("Error fetching data:", error);
    }
};



const handleEdit = async (VCM_ID, VTM_NAME, VCM_DEPO_NO, VCM_TARE_WEIGHT, VTA_RTO_NO, VCM_COMPARTMENT, VTM_ID) => {
    
    try {
        //data.currentVehicleId = VCM_ID;
        //console.log("Set currentVehicleId:", data.currentVehicleId);
              vcmidvalue = String(VCM_ID);

               selectvehicletype(VTM_ID);
            document.getElementById("EditDepotNo").value = VCM_DEPO_NO
            document.getElementById("EditTareWeight").value = VCM_TARE_WEIGHT
            document.getElementById("EditRTO").value = VTA_RTO_NO
            document.getElementById("EditCompartment").value = VCM_COMPARTMENT
        
        $("#EditddlVTM").change();
        $("#EditDepotNo").change();

        $("#EditTareWeight").change();
        $("#EditRTO").change();
        $("#EditCompartment").change();
        document.getElementById("EditVehicleFormContainer").style.display = "block";
        document.getElementById('gvRampVehicles').style.display = 'none';




    } catch (error) {
        console.error("Error fetching data:", error);
    }
};


const UpdateVehicle = async () => {
    try {

        const vcm_id = vcmidvalue;
        console.log("Retrieved currentVehicleId:", vcm_id);

        const vcm_vtm_id = $("#EditddlVTM").val(); // Retrieve selected value from dropdown

        if (!vcm_vtm_id) {
            Swal.fire("Error", "Vehicle type must be selected.", "error");
            return; // Stop execution if dropdown is not selected
        }

        console.log("Retrieved currentVehicleId:", vcm_id);
        console.log("VCM_VTM_ID value:", vcm_vtm_id);

        // Collect the updated data from the form fields
        const requestData = {
            storedProcedureName: "proc_myvehiclescs", // Procedure for updating vehicle
            parameters: JSON.stringify({
                mode: 17, // UPDATE operation
                vcm_id: vcm_id, // Retrieved from the hidden field or data attribute
                VCM_VTM_ID: vcm_vtm_id, // Pass selected value
                depo_no: $("#EditDepotNo").val(), // Updated Depot Number
                Tare_weight: $("#EditTareWeight").val(), // Updated Tare Weight
                RTO_NO: $("#EditRTO").val(), // Updated RTO Number
                VCM_COMPARTMENT: $("#EditCompartment").val(), // Updated Compartment
            }),
        };

        console.log("Update Request Data:", requestData);

        // Make the API request
        const response = await axios.post(commonApi, requestData);
        console.log("Update Response:", response);

        // Handle the response
        if (response.data && response.data.CommonMethodResult.Message === "success") {
            Swal.fire({
                title: "Success",
                text: "Vehicle updated successfully",
                icon: "success",
                confirmButtonText: "OK",
            }).then(() => {
                // Refresh the data grid to reflect updated vehicle details
                populateDataGrid(); // Ensure you have this function implemented

                // Hide the edit vehicle form and show the data grid
                const formContainer = document.getElementById("EditVehicleFormContainer");
                formContainer.style.display = "none";
            });
        } else {
            Swal.fire({
                title: "Error",
                text: "Failed to update vehicle. Please try again.",
                icon: "error",
                confirmButtonText: "OK",
            });
        }
    } catch (error) {
        console.error("Error updating vehicle:", error);
        Swal.fire({
            title: "Error",
            text: "An error occurred while updating the vehicle.",
            icon: "error",
            confirmButtonText: "OK",
        });
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


function toggleEmployeeForm() {
    console.log('reached');
    const formContainer = document.getElementById('addVehicleFormContainer');
    formContainer.style.display = 'block';

    const GridTable = document.getElementById('gvRampVehicles');
    GridTable.style.display = GridTable.style.display = 'none';

    const EditformContainer = document.getElementById('EditVehicleFormContainer');
    EditformContainer.style.display = 'none';

}

const AddRampVehicle = async () => {

    try {
        // Collect the data for the vehicle registration
        const requestData = {
            storedProcedureName: "proc_myvehiclescs", // Procedure for vehicle registration
            parameters: JSON.stringify({
                mode: 18, // INSERT operation
                accid:11401,
                VCM_VTM_ID: $("#ddlVTM").val(), // Vehicle Type ID
                depo_no: $("#txtDepotNo").val(), // Depot Number
                Tare_weight: $("#txtTareWeight").val(), // Tare Weight
                RTO_NO: $("#txtRTO").val(), // RTO Number
                VCM_COMPARTMENT: $("#txtCompartment").val(), // Compartment
            }),
        };

        console.log('requestData', requestData);

        // Make the API request
        const response = await axios.post(commonApi, requestData);
        console.log('responseData', response);

        // Handle the response
        if (response.data && response.data.CommonMethodResult.Message === "success") {
            Swal.fire({
                title: "Success",
                text: "Vehicle registered successfully",
                icon: "success",
                confirmButtonText: "OK",
            }).then(() => {
                // Refresh the table or data grid to show the updated vehicle data
                populateDataGrid(); // Ensure you have this function to refresh the data

                // Hide the add vehicle form and show the vehicle grid (if necessary)
                const formContainer = document.getElementById('addVehicleFormContainer');
                formContainer.style.display = 'none';

                const gridTable = document.getElementById('gvRampVehicles'); // Assuming there's a vehicle grid
                gridTable.style.display = 'block';
            });
        } else {
            Swal.fire({
                title: "Error",
                text: "Failed to register vehicle. Please try again.",
                icon: "error",
                confirmButtonText: "OK",
            });
        }
        clearAllControls();
    } catch (error) {
        console.error("Error fetching data:", error);
        Swal.fire({
            title: "Error",
            text: "An error occurred while registering the vehicle.",
            icon: "error",
            confirmButtonText: "OK",
        });
    }
};



const clearAllControls = () => {

    $("#ddlVTM").val(null).trigger("change");
    $("#txtDepotNo").val(null).trigger("change");
    $("#txtTareWeight").val(null).trigger("change");
    $("#txtRTO").val(null).trigger("change");
    $("#txtCompartment").val(null).trigger("change");

};


function CancelRampVehicle() {
    console.log('cancel reached');


    document.getElementById('addVehicleFormContainer').style.display = 'none';

    
    document.getElementById('gvRampVehicles').style.display = 'block';
}

function EditCancelRampVehicle() {
    console.log('cancel reached');

    // Hide the vehicle form container
    document.getElementById('EditVehicleFormContainer').style.display = 'none';

    // Show the grid table (vehicle data view)
    document.getElementById('gvRampVehicles').style.display = 'block';
}


let data = {
    VehicleTypedropdownData: []

};


const GetVehicleType = async () => {
    try {
        const requestData = {
            storedProcedureName: "proc_myvehiclescs",
            parameters: JSON.stringify({
                mode: 15, // Mode for fetching Type
                accid: 11401
            }),
        };

        const response = await axios.post(commonApi, requestData);
        console.log(response,'Response Data ');

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList;

        data.VehicleTypedropdownData = JSON.parse(commonReportMasterList[0].ReturnValue);
        console.log(data, "VehicleTypedata");
        populateTypeDropdown(data.VehicleTypedropdownData);
        EditpopulateTypeDropdown(data.VehicleTypedropdownData);
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};



const populateTypeDropdown = (data) => {

    try {
        data.forEach(item => {
            const option = $("<option>", {
                value: item.Id,
                text: item.vehicleType,
            });
            $("#ddlVTM").append(option);
        });
    } catch (error) {
        console.error("Error populating role dropdown:", error);
    }
};


const EditpopulateTypeDropdown = (data) => {

    try {
        data.forEach(item => {
            const option = $("<option>", {
                value: item.Id,
                text: item.vehicleType,
            });
            $("#EditddlVTM").append(option);
        });
    } catch (error) {
        console.error("Error populating role dropdown:", error);
    }
};


function selectvehicletype(value) {

    //$("#ShiftDropdown").val(value).trigger("change");; vehicleDropdown ShiftDropdown
    for (let option of EditddlVTM.options) {
        if (String(option.value) === String(value)) {
            option.selected = true;
            // break;
        }
    }
    $("#EditddlVTM").change();
};

