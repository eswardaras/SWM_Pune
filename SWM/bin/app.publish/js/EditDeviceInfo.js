

function setDropdownByTextOrValue(dropdown, value) {
  const normalize = (val) => String(val ?? "").trim().toLowerCase();
  const target = normalize(value);
  const options = Array.from(dropdown.options);

  // First try by value
  let match = options.find(opt => normalize(opt.value) === target);

  // Then try by visible text
  if (!match) {
    match = options.find(opt => normalize(opt.text) === target);
  }

  if (match) {
    dropdown.value = match.value;
    dropdown.dispatchEvent(new Event("change"));
    dropdown.fstdropdown?.rebind?.();
  } else {
    console.warn(`${dropdown.id} - No match found for "${value}"`);
  }
}
// ✅ Main loader function
window.onload = async function () {
  const query = new URLSearchParams(window.location.search);
  const id = query.get("ID");
  const vehicle = query.get("vname");
  const accid = query.get("ACK");
  const readonlyIMEI = query.get("readonlyIMEI") === "true";
  const readonlyVehicleName = query.get("readonlyVehicleName") === "true";
  const readonlySimNumber = query.get("readonlySimNumber") === "true";

  const setReadOnly = (id) => {
    const el = document.getElementById(id);
    if (el) {
      el.readOnly = true;
      el.style.backgroundColor = "#e9ecef";
    }
  };

  if (readonlyIMEI) setReadOnly("imeiNumber");
  if (readonlyVehicleName) setReadOnly("vehicleName");
  if (readonlySimNumber) setReadOnly("simPhoneNumber");

  const vehicleType = document.getElementById("vehicleType");
  const vendorName = document.getElementById("VendorName");
  const deviceCompany = document.getElementById("deviceCompany");
  const deviceType = document.getElementById("deviceType");
  const EmpType = document.getElementById("ddlEmployeeType");
  const EmpWorkType = document.getElementById("ddlWorkerType");

  try {
    const requestData = {
      storedProcedureName: "proc_fetchEditVehiclescs",
      parameters: JSON.stringify({
        flag: 1,
        accid: parseInt(accid),
        vname: vehicle,
        fk_VehicleID: parseInt(id),
        mode: 13
      }),
    };

    const response = await axios.post(commonApi, requestData);
    const result = response.data.CommonMethodResult.CommonReportMasterList;

    if (!result?.length) throw new Error("No data returned.");
    const parsedData = JSON.parse(result[0].ReturnValue || "[]");
    const data = parsedData[0];
    globalDeviceId = data.FK_DeviceId;
    if (!data) throw new Error("Parsed data is empty.");

    console.log("Parsed JSON data:", data);

    // Populate dropdowns
    await populateVehicleTypeDropdown(data.vtype);
    await populateVendorNameDropdown(data.Fk_EmpId);
    await populateDeviceCompanyDropdown(data.FK_DeviceCompId);
    await populateDeviceTypeDropdown(data.FK_DeviceCompId);
    await populateEmpTypeDropdown(data.EmploymentType);
    await populateEmpWorkTypeDropdown(data.fkWorkId);

    // Set dropdown values
    setDropdownByTextOrValue(vehicleType, data.vtype);
    setDropdownByTextOrValue(deviceCompany, data.FK_DeviceCompId);
    setDropdownByTextOrValue(vendorName, data.Fk_EmpId);
    setDropdownByTextOrValue(EmpType, data.EmploymentType);
    setDropdownByTextOrValue(EmpWorkType, data.fkWorkId);
    setDropdownByTextOrValue(deviceType, data.PK_DeviceModelId);

    // Show form
    document.getElementById("EditDevice").style.display = "block";
    document.getElementById("UpdateDeviceContainer").style.display = "block";

    // Fill form fields
    $("#accountID").empty().append(`<option value="${data.username}" selected>${data.username}</option>`);
    $("#vehicleName").val(data.vehiclename);
    $("#pcbVersion").val(data.pcbtype);
    $("#simPhoneNumber").val(data.sim);
    $("#imeiNumber").val(data.IMEI);
    $("#simProvider").val(data.Operator);
    $("#ActiveStatus").val(data.Active);
    $("#currentOdometer").val(data.Odometer);
    $("#fuelTank").val(data.FuelTank);
    $("#fuelFactor").val(data.FuelFactor);
    $("#vehicleMileage").val(data.VehicleMileageKmWise);
    $("#installationDate").val(formatDateForInput(data.installtion));
    $("#expiryDate").val(formatDateForInput(data.expiry));
    $("#LastCheckin").val(data.last);
    $("#InDays").val(data.inDays);

    // Voltage checkboxes
    $("#voltageNormal").prop("checked", data.voltageType == 0);
    $("#voltageReverse").prop("checked", data.voltageType != 0);
    $("#fuel5Volt").prop("checked", data.FuelVoltage == 5);
    $("#fuel9Volt").prop("checked", data.FuelVoltage != 5);

  } catch (error) {
    console.error("Error loading data:", error);
    Swal.fire("Error", "Failed to load device information.", "error");
  }

  // Toggle collapsible sections
  $(document).ready(function () {
    $(".toggler__btn").click(function () {
      $(this).parent().next().slideToggle("fast");
    });
  });

  function formatDateForInput(dateString) {
    const date = new Date(dateString);
    if (isNaN(date)) return "";
    return `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, "0")}-${String(date.getDate()).padStart(2, "0")}`;
  }
};

// Vehicle type dropdown function
const populateVehicleTypeDropdown = async (selectedType = "") => {
  try {
    const vehicleType = document.getElementById("vehicleType");
    vehicleType.innerHTML = '<option value="0">Select</option>';

    const requestData = {
      storedProcedureName: "proc_myvehiclescs",
      parameters: JSON.stringify({ mode: 20 }),
    };

    const response = await axios.post(commonApi, requestData);
    const returnValue = response.data.CommonMethodResult.CommonReportMasterList?.[0]?.ReturnValue;
    const dropdownData = JSON.parse(returnValue || "[]");

    for (const item of dropdownData) {
      const option = document.createElement("option");
      option.value = item.Id;
      option.text = item.vehicleType;
      vehicleType.appendChild(option);
    }

    if (selectedType) {
      setDropdownByTextOrValue(vehicleType, selectedType);
    }

    vehicleType.fstdropdown?.rebind?.(); // Rebind if plugin used
  } catch (error) {
    console.error("Error fetching vehicle type data:", error);
    Swal.fire("Error", "Failed to load vehicle types.", "error");
  }
};


const populateVendorNameDropdown = async (selectedType = "") => {
  try {
    const vendorName = document.getElementById("VendorName");
    vendorName.innerHTML = '<option value="0">Select</option>';

    const requestData = {
      storedProcedureName: "proc_myvehiclescs",
      parameters: JSON.stringify({
        mode: 21,
      }),
    };

    const response = await axios.post(commonApi, requestData);

    const returnValue = response.data.CommonMethodResult.CommonReportMasterList?.[0]?.ReturnValue;
    let dropdownData = JSON.parse(returnValue || "[]");

    for (const item of dropdownData) {
      const option = document.createElement("option");
      option.value = item.Id;
      option.text = item.VendorName;
      vendorName.appendChild(option);
    }

    vendorName.fstdropdown?.rebind?.(); // Safely rebind if plugin is used
  }
  catch (error) {
    console.error("Error fetching vehicle type data:", error);
    Swal.fire("Error", "Failed to load vehicle types.", "error");
  }
};

const populateEmpTypeDropdown = async (selectedType = "") => {
  try {
    const EmpType = document.getElementById("ddlEmployeeType");
    EmpType.innerHTML = '<option value="0">Select</option>';

    const requestData = {
      storedProcedureName: "proc_myvehiclescs",
      parameters: JSON.stringify({
        mode: 23,
      }),
    };

    const response = await axios.post(commonApi, requestData);

    const returnValue = response.data.CommonMethodResult.CommonReportMasterList?.[0]?.ReturnValue;
    let dropdownData = JSON.parse(returnValue || "[]");

    for (const item of dropdownData) {
      const option = document.createElement("option");
      option.value = item.EmpTypeId;
      option.text = item.EmpTypeName;
      EmpType.appendChild(option);
    }

    EmpType.fstdropdown?.rebind?.(); // Safely rebind if plugin is used
  }
  catch (error) {
    console.error("Error fetching vehicle type data:", error);
    Swal.fire("Error", "Failed to load vehicle types.", "error");
  }
};


const populateEmpWorkTypeDropdown = async (selectedType = "") => {
  try {
    const EmpWorkType = document.getElementById("ddlWorkerType");
    EmpWorkType.innerHTML = '<option value="0">Select</option>';

    const requestData = {
      storedProcedureName: "proc_myvehiclescs",
      parameters: JSON.stringify({
        mode: 22,
      }),
    };

    const response = await axios.post(commonApi, requestData);

    const returnValue = response.data.CommonMethodResult.CommonReportMasterList?.[0]?.ReturnValue;
    let dropdownData = JSON.parse(returnValue || "[]");

    for (const item of dropdownData) {
      const option = document.createElement("option");
      option.value = item.pkWorkId;
      option.text = item.Workname;
      EmpWorkType.appendChild(option);
    }

    EmpWorkType.fstdropdown?.rebind?.(); // Safely rebind if plugin is used
  }
  catch (error) {
    console.error("Error fetching vehicle type data:", error);
    Swal.fire("Error", "Failed to load vehicle types.", "error");
  }
};



const populateDeviceCompanyDropdown = async (selectedType = "") => {
  try {
    const deviceCompany = document.getElementById("deviceCompany");
    deviceCompany.innerHTML = '<option value="0">Select</option>';

    const requestData = {
      storedProcedureName: "proc_myvehiclescs",
      parameters: JSON.stringify({
        mode: 13,
      }),
    };

    const response = await axios.post(commonApi, requestData);

    const returnValue = response.data.CommonMethodResult.CommonReportMasterList?.[0]?.ReturnValue;
    let dropdownData = JSON.parse(returnValue || "[]");

    for (const item of dropdownData) {
      const option = document.createElement("option");
      option.value = item.PK_DeviceCompId;
      option.text = item.DeviceCompName;
      deviceCompany.appendChild(option);
    }

    deviceCompany.fstdropdown?.rebind?.(); // Safely rebind if plugin is used
  }
  catch (error) {
    console.error("Error fetching vehicle type data:", error);
    Swal.fire("Error", "Failed to load vehicle types.", "error");
  }
};

const populateDeviceTypeDropdown = async (deviceCompId1 = "") => {
  try {
    const deviceType = document.getElementById("deviceType");
    deviceType.innerHTML = '<option value="0">Select</option>';

    const requestData = {
      storedProcedureName: "proc_myvehiclescs",
      parameters: JSON.stringify({
        mode: 14,
        devicecompid: deviceCompId1  
       
      }),
    };

    const response = await axios.post(commonApi, requestData);

    const returnValue = response.data.CommonMethodResult.CommonReportMasterList?.[0]?.ReturnValue;
    let dropdownData = JSON.parse(returnValue || "[]");

    for (const item of dropdownData) {
      const option = document.createElement("option");
      option.value = item.PK_DeviceModelId;
      option.text = item.DeviceModel;
      deviceType.appendChild(option);
    }

    deviceType.fstdropdown?.rebind?.(); // Safely rebind if plugin is used
  }
  catch (error) {
    console.error("Error fetching vehicle type data:", error);
    Swal.fire("Error", "Failed to load vehicle types.", "error");
  }
};

let globalDeviceId = null;

//document.getElementById("btnSave").addEventListener("click", async function () {
//  const id = new URLSearchParams(window.location.search).get("ID");
//  const accid = new URLSearchParams(window.location.search).get("ACK");
// /* const accid = new URLSearchParams(window.location.search).get("ACK");*/

//  const requestData = {
//    storedProcedureName: "proc_UpdateVehiclescs", // Update to your correct SP
//    parameters: JSON.stringify({
//      PK_VehicleId: parseInt(id),
//      accId: parseInt(accid),
//      mode: 1,
//      vehiclname: $("#vehicleName").val(),
//      vtype: $("#vehicleType option:selected").text(),
//      cname: $("#deviceCompany").val(),
//      dtype: $("#deviceType").val(),
//      pcbtype: $("#pcbVersion").val(),
//      simno: $("#simPhoneNumber").val(),
//      newimei: $("#imeiNumber").val(),
//      servpro: $("#simProvider").val(),
//      status: $("#ActiveStatus").val(),
//      cuodo: parseInt($("#currentOdometer").val()),
//      tank: parseFloat($("#fuelTank").val()),
//      factor: parseFloat($("#fuelFactor").val()),
//      Mileage: parseFloat($("#vehicleMileage").val()),
//      instdate: $("#installationDate").val(),
//      expirydate: $("#expiryDate").val(),
//      voltageType: $("input[name='voltageType']:checked").val(),
//      FuelVoltage: $("input[name='fuelVoltage']:checked").val(),
//      fk_empid: $("#VendorName").val(),
//      oldimei: "",
//      optime: "",
//      vehicleOtherName: "",
//      FK_BranchId: "",
//      fk_districtid: "",
//      city: "",
//      amcvaliditi: "",
//      HrMileage: "",
//      Pk_DeviceId: globalDeviceId,
//      opid:11401
//    }),
//  };



//  try {
//    console.log(requestData, 'Request Data');

//    const response = await axios.post(commonApi, requestData);
//    console.log(response, 'Response Data');

//    const commonReportMasterList = response.data.CommonMethodResult.CommonReportMasterList;

//    // Safely get and parse the ReturnValue
//    const returnValue = commonReportMasterList[0]?.ReturnValue;
//    let result;

//    try {
//      result = JSON.parse(returnValue);
//      if (result[0].Column1 === 'SUCCESS') {
//        Swal.fire("Success", result.Message || "Device information updated successfully.", "success")
//          .then(() => {
//            // Clear the fields
//            document.querySelectorAll('input, textarea').forEach(input => {
//              input.value = '';
//            });

//            // Optionally, clear select elements or reset them
//            document.querySelectorAll('select').forEach(select => {
//              select.selectedIndex = 0;  // Or use .value = '' to reset to default value
//            });

//            // Redirect back to the previous page
//            window.history.back();
//          });
//      } else {
//        Swal.fire("Error", result?.Message || "Update failed.", "error");
//      }
//    } catch (parseError) {
//      console.error("JSON parsing failed:", parseError);
//      Swal.fire("Error", "Invalid response format from server.", "error");
//      return;
//    }

//    console.log(result, 'Result');

//  } catch (error) {
//    console.error("Update failed:", error);
//    Swal.fire("Error", "An error occurred while updating.", "error");
//  }



//});


document.getElementById("btnSave").addEventListener("click", async function () {
  const id = parseInt(new URLSearchParams(window.location.search).get("ID") || "0");
  const accid = parseInt(new URLSearchParams(window.location.search).get("ACK") || "0");

  const vehicleName = $("#vehicleName").val().trim();
  const imeiNumber = $("#imeiNumber").val().trim();
  const simNumber = $("#simPhoneNumber").val().trim();

  async function checkDuplicate(mode) {
    const requestData = {
      storedProcedureName: "proc_UpdateVehiclescs",
      parameters: JSON.stringify({
        PK_VehicleId: id,
        accId: accid,
        mode: mode,
        vehiclname: vehicleName,
        newimei: imeiNumber,
        simno: simNumber
      })
    };

    try {
      const response = await axios.post(commonApi, requestData);
      const data = response.data.CommonMethodResult;

      // Defensive check for empty/null list
      if (!data.CommonReportMasterList || data.CommonReportMasterList.length === 0) {
        return false; // no duplicates found
      }

      // Parse the ReturnValue safely
      const returnValueRaw = data.CommonReportMasterList[0].ReturnValue;
      let returnValue;
      try {
        returnValue = JSON.parse(returnValueRaw);
      } catch {
        console.warn("Could not parse ReturnValue:", returnValueRaw);
        return false;
      }

      // Check structure of returnValue, example: [{ Col1: 1 }] or similar
      return Array.isArray(returnValue) && returnValue.length > 0 && returnValue[0].Col1 === 1;

    } catch (err) {
      console.error(`Check failed for mode ${mode}:`, err);
      return false;
    }
  }

  // Check for duplicate vehicle name
  if (await checkDuplicate(2)) {
    Swal.fire("Duplicate Entry", "Vehicle name already exists.", "warning");
    return;
  }

  // Check for duplicate IMEI number
  if (await checkDuplicate(3)) {
    Swal.fire("Duplicate Entry", "IMEI number already exists.", "warning");
    return;
  }

  // Check for duplicate SIM number
  if (await checkDuplicate(4)) {
    Swal.fire("Duplicate Entry", "SIM number already exists.", "warning");
    return;
  }

  // Proceed to save if no duplicates
  const requestData = {
    storedProcedureName: "proc_UpdateVehiclescs",
    parameters: JSON.stringify({
      PK_VehicleId: id,
      accId: accid,
      mode: 1,
      vehiclname: vehicleName,
      vtype: $("#vehicleType option:selected").text(),
      cname: $("#deviceCompany").val(),
      dtype: $("#deviceType").val(),
      pcbtype: $("#pcbVersion").val(),
      simno: simNumber,
      newimei: imeiNumber,
      servpro: $("#simProvider").val(),
      status: $("#ActiveStatus").val(),
      cuodo: parseInt($("#currentOdometer").val()) || 0,
      tank: parseFloat($("#fuelTank").val()) || 0,
      factor: parseFloat($("#fuelFactor").val()) || 0,
      Mileage: parseFloat($("#vehicleMileage").val()) || 0,
      instdate: $("#installationDate").val(),
      expirydate: $("#expiryDate").val(),
      voltageType: $("input[name='voltageType']:checked").val(),
      FuelVoltage: $("input[name='fuelVoltage']:checked").val(),
      fk_empid: $("#VendorName").val(),
      oldimei: "",
      optime: "",
      vehicleOtherName: "",
      FK_BranchId: "",
      fk_districtid: "",
      city: "",
      amcvaliditi: "",
      HrMileage: "",
      Pk_DeviceId: globalDeviceId,
      opid: 11401,
      fkWorkId: $("#ddlWorkerType").val(),
      EmploymentType: $("#ddlEmployeeType").val(),
    }),
  };

  try {
    const response = await axios.post(commonApi, requestData);
    const data = response.data.CommonMethodResult;
    console.log("Update data",data)
    if (!data.CommonReportMasterList || data.CommonReportMasterList.length === 0) {
      Swal.fire("Error", "Unexpected response from server.", "error");
      return;
    }

    const returnValueRaw = data.CommonReportMasterList[0].ReturnValue;
    let returnValue;
    try {
      returnValue = JSON.parse(returnValueRaw);
    } catch {
      Swal.fire("Error", "Could not parse server response.", "error");
      return;
    }

    if (returnValue.length > 0 && returnValue[0].Column1 === 'SUCCESS') {
      Swal.fire("Success", returnValue[0].Message || "Device information updated successfully.", "success").then(() => window.history.back());
    } else {
      Swal.fire("Error", returnValue[0]?.Message || "Update failed.", "error");
    }
  } catch (error) {
    console.error("Update failed:", error);
    Swal.fire("Error", "An error occurred while updating.", "error");
  }
});








//document.getElementById("btnSave").addEventListener("click", async function () {
//  const id = new URLSearchParams(window.location.search).get("ID");
//  const accid = new URLSearchParams(window.location.search).get("ACK");

//  const vehicleName = $("#vehicleName").val();
//  const imeiNumber = $("#imeiNumber").val();
//  const simNumber = $("#simPhoneNumber").val();

//  async function checkDuplicate(mode, paramName, value) {
//    const requestData = {
//      storedProcedureName: "proc_UpdateVehiclescs",
//      parameters: JSON.stringify({
//        PK_VehicleId: parseInt(id),
//        accId: parseInt(accid),
//        mode: mode,
//        vehiclname: vehicleName,
//        newimei: imeiNumber,
//        simno: simNumber
//      })
//    };

//    try {
//      const response = await axios.post(commonApi, requestData);
//      const result = JSON.parse(response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue);
//      console.log("Result", result)
//      return result.length > 0 && result[0].Col1 === 1;
//    } catch (err) {
//      console.error(`Check failed for mode ${mode}:`, err);
//      return false;
//    }
//  }

//  // Check for duplicate vehicle name
//  if (await checkDuplicate(2)) {
//    Swal.fire("Duplicate Entry", "Vehicle name already exists.", "warning");
//    return;
//  }

//  // Check for duplicate IMEI number
//  if (await checkDuplicate(3)) {
//    Swal.fire("Duplicate Entry", "IMEI number already exists.", "warning");
//    return;
//  }

//  // Check for duplicate SIM number
//  if (await checkDuplicate(4)) {
//    Swal.fire("Duplicate Entry", "SIM number already exists.", "warning");
//    return;
//  }

//  // If all checks pass, proceed with saving (mode = 1)
//  const requestData = {
//    storedProcedureName: "proc_UpdateVehiclescs",
//    parameters: JSON.stringify({
//      PK_VehicleId: parseInt(id),
//      accId: parseInt(accid),
//      mode: 1,
//      vehiclname: vehicleName,
//      vtype: $("#vehicleType option:selected").text(),
//      cname: $("#deviceCompany").val(),
//      dtype: $("#deviceType").val(),
//      pcbtype: $("#pcbVersion").val(),
//      simno: simNumber,
//      newimei: imeiNumber,
//      servpro: $("#simProvider").val(),
//      status: $("#ActiveStatus").val(),
//      cuodo: parseInt($("#currentOdometer").val()),
//      tank: parseFloat($("#fuelTank").val()),
//      factor: parseFloat($("#fuelFactor").val()),
//      Mileage: parseFloat($("#vehicleMileage").val()),
//      instdate: $("#installationDate").val(),
//      expirydate: $("#expiryDate").val(),
//      voltageType: $("input[name='voltageType']:checked").val(),
//      FuelVoltage: $("input[name='fuelVoltage']:checked").val(),
//      fk_empid: $("#VendorName").val(),
//      oldimei: "",
//      optime: "",
//      vehicleOtherName: "",
//      FK_BranchId: "",
//      fk_districtid: "",
//      city: "",
//      amcvaliditi: "",
//      HrMileage: "",
//      Pk_DeviceId: globalDeviceId,
//      opid: 11401
//    }),
//  };

//  try {
//    const response = await axios.post(commonApi, requestData);
//    const returnValue = JSON.parse(response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue);
//    if (returnValue[0].Column1 === 'SUCCESS') {
//      Swal.fire("Success", returnValue.Message || "Device information updated successfully.", "success")
//        .then(() => window.history.back());
//    } else {
//      Swal.fire("Error", returnValue?.Message || "Update failed.", "error");
//    }
//  } catch (error) {
//    console.error("Update failed:", error);
//    Swal.fire("Error", "An error occurred while updating.", "error");
//  }
//});


document.getElementById("btnCancel").addEventListener("click", function () {

  Swal.fire({
    title: "Are you sure?",
    text: "Changes will be lost.",
    icon: "warning",
    showCancelButton: true,
    confirmButtonText: "Yes, cancel",
    cancelButtonText: "No, stay",
  }).then((result) => {
    if (result.isConfirmed) {
      window.history.back(); // or redirect to another page
    }
  });

});




