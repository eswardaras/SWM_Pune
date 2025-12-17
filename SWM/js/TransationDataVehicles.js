
let isEditing = false;
let elementToEdit = 0;

const handleSubmit = async () => {
    try {
        if (isEditing) {
            const requestData = {
                storedProcedureName: "Sp_Transactional_data_vehicles ",
                parameters: JSON.stringify({
                    Mode: 4,
                    PreventiveMaintenance: sanitizeInput($('#preventiveInput').val()),
                    BreakdownMaintenance: sanitizeInput($('#breakdownMaintananceInput').val()),
                    RTOpassingalerts: sanitizeInput($('#rtoPassInput').val()),
                    PurchaseYear: sanitizeInput($('#purchageYearInput').val()),
                    Cost: sanitizeInput($('#constInput').val()),
                    Depreciation: sanitizeInput($('#depreciationInput').val()),
                    Insurance: sanitizeInput($('#insuranceInput').val()),
                    Vehiclenumber: sanitizeInput($('#vehicleNumberInput').val()),
                    AlertType: sanitizeInput($('#alertDropdown').val()),
                    OtherVehicle: sanitizeInput($('#otherVehicleInput').val()),
                    FuelDataConsumption: sanitizeInput($('#fuelDataInput').val()),
                    DailyUtilizationDataBackhoeLoaders: sanitizeInput($('#dailyInput').val()),
                    CreatedBy: loginId,
                    Id: elementToEdit,
                }),
            };

            const response = await axios.post(commonApi, requestData);
            console.log("is editing", response);

            if (response.data.CommonMethodResult.Message === "success") {
                Swal.fire({
                    title: "Done!",
                    text: "Edited successfully",
                    icon: "success",
                });
            }
            isEditing = false;
            elementToEdit = 0;
        } else {
            const requestData = {
                storedProcedureName: "Sp_Transactional_data_vehicles ",
                parameters: JSON.stringify({
                    Mode: 1,
                    PreventiveMaintenance: sanitizeInput($('#preventiveInput').val()),
                    BreakdownMaintenance: sanitizeInput($('#breakdownMaintananceInput').val()),
                    RTOpassingalerts: sanitizeInput($('#rtoPassInput').val()),
                    PurchaseYear: sanitizeInput($('#purchageYearInput').val()),
                    Cost: sanitizeInput($('#constInput').val()),
                    Depreciation: sanitizeInput($('#depreciationInput').val()),
                    Insurance: sanitizeInput($('#insuranceInput').val()),
                    Vehiclenumber: sanitizeInput($('#vehicleNumberInput').val()),
                    AlertType: sanitizeInput($('#alertDropdown').val()),
                    OtherVehicle: sanitizeInput($('#otherVehicleInput').val()),
                    FuelDataConsumption: sanitizeInput($('#fuelDataInput').val()),
                    DailyUtilizationDataBackhoeLoaders: sanitizeInput($('#dailyInput').val()),
                    CreatedBy: loginId,
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
        }
        await getData();
    } catch (error) {
        Swal.fire({
            title: "Oops",
            text: "Something went wrong",
            icon: "error",
        });
        console.error("Error fetching data:", error);
    }
};

const getData = async () => {
    try {
        $("#table tbody").empty();
        const requestData = {
            storedProcedureName: "Sp_Transactional_data_vehicles ",
            parameters: JSON.stringify({
                Mode: 2,
            }),
        };

        const response = await axios.post(commonApi, requestData);
        console.log("retrive record", response);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let tableData = JSON.parse(commonReportMasterList);
        console.log(tableData);

        //setDataTable(table);

        let srNo = 0;
        for (const data of tableData) {
            srNo++;
            const tr = $("<tr></tr>");
            tr.html(`
                <td>${srNo}</td>
                <td>${!data.PreventiveMaintenance ? "-" : data.PreventiveMaintenance}</td>
                <td>${!data.BreakdownMaintenance ? "-" : data.BreakdownMaintenance}</td>
                <td>${!data.RTOpassingalerts ? "-" : data.RTOpassingalerts}</td>
                <td>${!data.PurchaseYear ? "-" : data.PurchaseYear}</td>
                <td>${!data.Cost ? "-" : data.Cost}</td>
                <td>${!data.Depreciation ? "-" : data.Depreciation}</td>
                <td>${!data.Insurance ? "-" : data.Insurance}</td>
                <td>${!data.Vehiclenumber ? "-" : data.Vehiclenumber}</td>
                <td>${!data.AlertType ? "-" : data.AlertType}</td>
                <td>${!data.OtherVehicle ? "-" : data.OtherVehicle}</td>
                <td>${!data.FuelDataConsumption ? "-" : data.FuelDataConsumption}</td>
                <td>${!data.DailyUtilizationDataBackhoeLoaders ? "-" : data.DailyUtilizationDataBackhoeLoaders}</td>
                <td><i class="fa-solid fa-pen-to-square text-info cursor-pointer" onclick='handleEdit(${JSON.stringify(data)}) '></i></td>
                <td><i class="fa-solid fa-trash-can text-danger cursor-pointer" onclick='handleDelete(${data.Id})'></i></td>
                `);
            $("#table tbody").append(tr);
        }
        $("#tableWrapper").slideDown("slow");
    } catch (error) {
        console.error("Error fetching data:", error);
    }
}

const handleEdit = (data) => {
    $('#preventiveInput').val(data.PreventiveMaintenance);
    $('#breakdownMaintananceInput').val(data.BreakdownMaintenance);
    $('#rtoPassInput').val(data.RTOpassingalerts);
    $('#purchageYearInput').val(data.PurchaseYear);
    $('#constInput').val(data.Cost);
    $('#depreciationInput').val(data.Depreciation);
    $('#insuranceInput').val(data.Insurance);
    $('#vehicleNumberInput').val(data.Vehiclenumber);
    document.querySelector("#alertDropdown").fstdropdown.setValue(data.AlertType);
    $('#otherVehicleInput').val(data.OtherVehicle);
    $('#fuelDataInput').val(data.FuelDataConsumption);
    $('#dailyInput').val(data.DailyUtilizationDataBackhoeLoaders);
    elementToEdit = data.Id;
    isEditing = true;
}

const handleDelete = async (Id) => {
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
                storedProcedureName: "Sp_Transactional_data_vehicles ",
                parameters: JSON.stringify({
                    Mode: 5,
                    CreatedBy: '-',
                    Id,
                }),
            };

            const response = await axios.post(commonApi, requestData);
            console.log("delted record", response);

            if (response.data.CommonMethodResult.Message === "success") {
                Swal.fire({
                    title: "Done!",
                    text: "Deleted successfully",
                    icon: "success",
                });
            }
            await getData();
        } catch (error) {
            console.error("Error fetching data:", error);
        }
    }
}

const sanitizeInput = (input) => {
    return input.replace(/<[^>]*>?/gm, '');
};

window.addEventListener('load', async () => {
    await getData();
})

