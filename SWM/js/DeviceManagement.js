//const zoneDropdown = document.getElementById("zoneDropdown");
//const wardDropdown = document.getElementById("wardDropdown");
//const kothiDropdown = document.getElementById("kothiDropdown");
//const sweeperDropdown = document.getElementById("sweeperDropdown");
//const imeiInput = document.getElementById("imeiInput");
//const reasonInput = document.getElementById("reasonInput");
//const engineerNameInput = document.getElementById("engineerNameInput");

//const table = document.getElementById("table");

//const btnSearch = document.getElementById("btnSearch");

//const populateZoneDropdown = async () => {
//    try {
//        const response = await axios.post(zoneApi, {
//            mode: 11,
//            vehicleId: 0,
//            AccId: 11401,
//        });

//        const zoneMasterList = response.data.GetZoneResult.ZoneMasterList;

//        for (const zone of zoneMasterList) {
//            const option = document.createElement("option");
//            option.value = zone.zoneid;
//            option.text = zone.zonename;
//            zoneDropdown.appendChild(option);
//            zoneDropdown.fstdropdown.rebind();
//        }
//    } catch (error) {
//        console.error("Error fetching data:", error);
//    }
//};

//const populateWardDropdown = async () => {
//    try {
//        wardDropdown.innerHTML = '<option value="0">Select Ward</option>';

//        const response = await axios.post(wardApi, {
//            mode: 12,
//            vehicleId: 0,
//            AccId: 11401,
//            ZoneId: zoneDropdown.value,
//        });

//        const wardMasterList = response.data.GetWardResult.WardMasterList;

//        for (const ward of wardMasterList) {
//            const option = document.createElement("option");
//            option.value = ward.PK_wardId;
//            option.text = ward.wardName;
//            wardDropdown.appendChild(option);
//            wardDropdown.fstdropdown.rebind();
//        }
//    } catch (error) {
//        console.error("Error fetching data:", error);
//    }
//};

//const populateKothiDropdown = async () => {
//    try {
//        kothiDropdown.innerHTML = '<option value="0">Select Kothi</option>';

//        const response = await axios.post(kothiApi, {
//            mode: 56,
//            Fk_accid: 11401,
//            Fk_ambcatId: 0,
//            Fk_divisionid: 0,
//            FK_VehicleID: 0,
//            Fk_ZoneId: zoneDropdown.value,
//            FK_WardId: wardDropdown.value,
//            Startdate: "",
//            Enddate: "",
//            Maxspeed: 0,
//            Minspeed: 0,
//            Fk_DistrictId: 0,
//            Geoid: 0,
//        });

//        const kothiMasterList = response.data.GetKothiResult.KotiMasterList;

//        for (const kothi of kothiMasterList) {
//            const option = document.createElement("option");
//            option.value = kothi.pk_kothiid;
//            option.text = kothi.kothiname;
//            kothiDropdown.appendChild(option);
//            kothiDropdown.fstdropdown.rebind();
//        }
//    } catch (error) {
//        console.error("Error fetching data:", error);
//    }
//};

//const populateSweeperDropdown = async () => {
//    try {
//        sweeperDropdown.innerHTML = '<option value="0">Select Sweeper</option>';

//        const requestData = {
//            storedProcedureName: "Proc_DeviceManagement",
//            parameters: JSON.stringify({
//                mode: 6,
//                zoneid: zoneDropdown.value,
//                wardid: wardDropdown.value,
//                kothiid: kothiDropdown.value,
//            }),
//        };

//        const response = await axios.post(commonApi, requestData);

//        const commonReportMasterList =
//            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

//        let dropdownData = JSON.parse(commonReportMasterList);

//        for (const data of dropdownData) {
//            const option = document.createElement("option");
//            option.value = data.VEHICLEID;
//            option.text = data.NAME;
//            sweeperDropdown.appendChild(option);
//        }
//        sweeperDropdown.fstdropdown.rebind();
//    } catch (error) {
//        console.error("Error fetching data:", error);
//    }
//};

//const populateImeiInput = async () => {
//    try {
//        const requestData = {
//            storedProcedureName: "Proc_DeviceManagement",
//            parameters: JSON.stringify({
//                mode: 1,
//                zoneid: zoneDropdown.value,
//                wardid: wardDropdown.value,
//                kothiid: kothiDropdown.value,
//                vehicleid: sweeperDropdown.value,
//            }),
//        };

//        const response = await axios.post(commonApi, requestData);

//        const commonReportMasterList =
//            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

//        let data = JSON.parse(commonReportMasterList);
//        console.log(data);

//        imeiInput.value = data[0].IMEINO;
//    } catch (error) {
//        console.error("Error fetching data:", error);
//    }
//};

//const getData = async () => {
//    try {
//        const requestData = {
//            storedProcedureName: "Proc_DeviceManagement",
//            parameters: JSON.stringify({
//                mode: 3,
//                vehicleid: 0,
//            }),
//        };

//        const response = await axios.post(commonApi, requestData);

//        const tbody = table.querySelector("tbody");
//        tbody.innerHTML = "";
//        if (!response.data.CommonMethodResult.CommonReportMasterList) {
//            tbody.innerHTML = `<tr>
//                               <td colspan='50' class='text-danger'>
//                                  <i class="fa-solid fa-triangle-exclamation mx-1"></i>
//                                  No Data Found
//                                </td>
//                            </tr>`;
//            return;
//        }

//        const commonReportMasterList =
//            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

//        let tableData = JSON.parse(commonReportMasterList);
//        console.log(tableData);

//        setDataTable(table);

//        let srNo = 0;
//        for (const data of tableData) {
//            srNo++;
//            const tr = document.createElement("tr");
//            tr.innerHTML = `<tr>
//              <td>${srNo}</td>
//              <td>${!data.ZONE ? "-" : data.ZONE}</td>
//              <td>${!data.WARD ? "-" : data.WARD}</td>
//              <td>${!data.KOTHI ? "-" : data.KOTHI}</td>
//              <td>${!data.SWEEPERNAME ? "-" : data.SWEEPERNAME}</td>
//	      <td>${!data.DATE ? "-" : data.DATE.split('T')[0]}</td>
//              <td>${!data.IMEINO ? "-" : data.IMEINO}</td>
//              <td>${!data.REASON ? "-" : data.REASON}</td>
//              <td>${!data.ENGINEERNAME ? "-" : data.ENGINEERNAME}</td>
//              <td><button type="button" class="btn btn-sm btn-info" onclick="handleReturn(${JSON.stringify(
//                    data.VEHICLEID
//                )})"><i class="fa-solid fa-rotate-left"></i></button></td>
//          </tr>`;

//            table.querySelector("tbody").appendChild(tr);
//        }
//    } catch (error) {
//        console.error("Error fetching data:", error);
//    }
//};

//const handleReturn = async (id) => {
//    try {
//        const requestData = {
//            storedProcedureName: "Proc_DeviceManagement",
//            parameters: JSON.stringify({
//                mode: 4,
//                vehicleid: id,
//            }),
//        };

//        console.log("prev", requestData);
//        const response = await axios.post(commonApi, requestData);
//        console.log(response);
//        await getData();
//    } catch (error) {
//        console.error("Error fetching data:", error);
//    }
//};

//const submitData = async () => {
//    if (
//        !zoneDropdown.value ||
//        !wardDropdown.value ||
//        !kothiDropdown.value ||
//        !sweeperDropdown.value ||
//        imeiInput.value === "" ||
//        reasonInput.value === "" ||
//        engineerNameInput.value === ""
//    ) {
//        Swal.fire({
//            icon: "info",
//            title: "Attention",
//            text: "Please fill all the fields",
//        });
//        return;
//    }
//    try {
//        const requestData = {
//            storedProcedureName: "Proc_DeviceManagement",
//            parameters: JSON.stringify({
//                mode: 2,
//                zoneid: zoneDropdown.value,
//                wardid: wardDropdown.value,
//                kothiid: kothiDropdown.value,
//                vehicleid: sweeperDropdown.value,
//                imeino: DOMPurify.sanitize(imeiInput.value),
//                reason: DOMPurify.sanitize(reasonInput.value),
//                engineer_name: DOMPurify.sanitize(engineerNameInput.value),
//            }),
//        };

//        console.log("before", requestData);
//        const response = await axios.post(commonApi, requestData);

//        console.log(response);

//        if (response.data.CommonMethodResult.Message === "success") {
//            const commonReportMasterList =
//                response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

//            let tableData = JSON.parse(commonReportMasterList);

//            if (tableData[0].result === "allready exists") {
//                Swal.fire({
//                    title: "Attention!",
//                    text: "Device already at Command & Control",
//                    icon: "info",
//                });
//                return;
//            } else {
//                Swal.fire({
//                    title: "Done!",
//                    text: "New entry created successfully",
//                    icon: "success",
//                });
//                await getData();
//            }
//        }

//        // if (response.data.CommonMethodResult.Message === "success") {
//        // }
//    } catch (error) {
//        console.error("Error fetching data:", error);
//    }
//};

//const handleZoneSelect = () => {
//    populateWardDropdown();
//};

//const handleWardSelect = () => {
//    populateKothiDropdown();
//};

//const handleKothiSelect = () => {
//    populateSweeperDropdown();
//};

//const handleSweeperSelect = () => {
//    populateImeiInput();
//};

//const clearAll = () => {
//    zoneDropdown.fstdropdown.setValue('0');
//    wardDropdown.fstdropdown.setValue('0');
//    kothiDropdown.fstdropdown.setValue('0');
//}

//// DataTable

//function setDataTable(tableId) {
//    if ($.fn.DataTable.isDataTable(tableId)) {
//        // DataTable is already initialized, no need to reinitialize
//        $(tableId).DataTable().clear().draw();
//        $(tableId).DataTable().destroy();
//    }

//    $(document).ready(function () {
//        var table = $(tableId).DataTable({
//            pageLength: 5,
//            dom:
//                "<'row'<'col-sm-12 col-md-6'B><'col-sm-12 col-md-6'f>>" +
//                "<'row'<'col-sm-12'tr>>" +
//                "<'row justify-content-between'<'col-sm-12 col-md-auto d-flex align-items-center'l><'col-sm-12 col-md-auto'i><'col-sm-12 col-md-auto'p>>",
//            buttons: [
//                {
//                    extend: "excelHtml5",
//                    text: "Excel <i class='fas fa-file-excel text-white'></i>",
//                    title: document.title + " - " + getFormattedDate(),
//                    className: "btn btn-sm btn-success mb-2", // Add your Excel button class here
//                },
//                {
//                    extend: "pdf",
//                    text: "PDF <i class='fa-regular fa-file-pdf text-white'></i>",
//                    title: document.title + " - " + getFormattedDate(),
//                    className: "btn btn-sm btn-danger mb-2", // Add your Excel button class here
//                    customize: function (doc) {
//                        // Set custom page size (width x height)
//                        doc.pageOrientation = "landscape"; // or "portrait" for portrait orientation
//                        doc.pageSize = "A4"; // or an array: [width, height]

//                        // Set custom margins (left, right, top, bottom)
//                        doc.pageMargins = [20, 20, 20, 20];
//                    },
//                },
//                // "pdf",
//                // "csvHtml5",
//            ],
//            language: {
//                lengthMenu: "_MENU_  records per page",
//                sSearch: "<img src='Images/search.png' alt='search'>",
//                paginate: {
//                    first: "First",
//                    last: "Last",
//                    next: "Next &rarr;",
//                    previous: "&larr; Previous",
//                },
//            },
//            lengthMenu: [
//                [5, 10, 25, 50, -1],
//                [5, 10, 25, 50, "All"],
//            ],
//            order: [[0, "asc"]],
//        });
//    });
//}

//function getFormattedDate() {
//    const today = new Date();
//    const options = { year: "numeric", month: "short", day: "numeric" };
//    return today.toLocaleDateString("en-US", options);
//}

//window.addEventListener("load", async () => {
//    await populateZoneDropdown();
//    await getData();
//});


const zoneDropdown = document.getElementById("zoneDropdown");
const wardDropdown = document.getElementById("wardDropdown");
const kothiDropdown = document.getElementById("kothiDropdown");
const sweeperDropdown = document.getElementById("sweeperDropdown");
const imeiInput = document.getElementById("imeiInput");
const reasonInput = document.getElementById("reasonInput");
const engineerNameInput = document.getElementById("engineerNameInput");

const table = document.getElementById("table");
const table1 = document.getElementById("table1");
const btnSearch = document.getElementById("btnSearch");

const populateZoneDropdown = async () => {
    try {
        const response = await axios.post(zoneApi, {
            mode: 11,
            vehicleId: 0,
            AccId: 11401,
        });

        const zoneMasterList = response.data.GetZoneResult.ZoneMasterList;

        for (const zone of zoneMasterList) {
            const option = document.createElement("option");
            option.value = zone.zoneid;
            option.text = zone.zonename;
            zoneDropdown.appendChild(option);
            zoneDropdown.fstdropdown.rebind();
        }
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const populateWardDropdown = async () => {
    try {
        wardDropdown.innerHTML = '<option value="0">Select Ward</option>';

        const response = await axios.post(wardApi, {
            mode: 12,
            vehicleId: 0,
            AccId: 11401,
            ZoneId: zoneDropdown.value,
        });

        const wardMasterList = response.data.GetWardResult.WardMasterList;

        for (const ward of wardMasterList) {
            const option = document.createElement("option");
            option.value = ward.PK_wardId;
            option.text = ward.wardName;
            wardDropdown.appendChild(option);
            wardDropdown.fstdropdown.rebind();
        }
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const populateKothiDropdown = async () => {
    try {
        kothiDropdown.innerHTML = '<option value="0">Select Kothi</option>';

        const response = await axios.post(kothiApi, {
            mode: 56,
            Fk_accid: 11401,
            Fk_ambcatId: 0,
            Fk_divisionid: 0,
            FK_VehicleID: 0,
            Fk_ZoneId: zoneDropdown.value,
            FK_WardId: wardDropdown.value,
            Startdate: "",
            Enddate: "",
            Maxspeed: 0,
            Minspeed: 0,
            Fk_DistrictId: 0,
            Geoid: 0,
        });

        const kothiMasterList = response.data.GetKothiResult.KotiMasterList;

        for (const kothi of kothiMasterList) {
            const option = document.createElement("option");
            option.value = kothi.pk_kothiid;
            option.text = kothi.kothiname;
            kothiDropdown.appendChild(option);
            kothiDropdown.fstdropdown.rebind();
        }
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const populateSweeperDropdown = async () => {
    try {
        sweeperDropdown.innerHTML = '<option value="0">Select Sweeper</option>';

        const requestData = {
            storedProcedureName: "Proc_DeviceManagement",
            parameters: JSON.stringify({
                mode: 6,
                zoneid: zoneDropdown.value,
                wardid: wardDropdown.value,
                kothiid: kothiDropdown.value,
            }),
        };

        const response = await axios.post(commonApi, requestData);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let dropdownData = JSON.parse(commonReportMasterList);

        for (const data of dropdownData) {
            const option = document.createElement("option");
            option.value = data.VEHICLEID;
            option.text = data.NAME;
            sweeperDropdown.appendChild(option);
        }
        sweeperDropdown.fstdropdown.rebind();
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const populateImeiInput = async () => {
    try {
        const requestData = {
            storedProcedureName: "Proc_DeviceManagement",
            parameters: JSON.stringify({
                mode: 1,
                zoneid: zoneDropdown.value,
                wardid: wardDropdown.value,
                kothiid: kothiDropdown.value,
                vehicleid: sweeperDropdown.value,
            }),
        };

        const response = await axios.post(commonApi, requestData);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let data = JSON.parse(commonReportMasterList);
        console.log(data);

        imeiInput.value = data[0].IMEINO;
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const getData = async () => {
    try {
        const requestData = {
            storedProcedureName: "Proc_DeviceManagement",
            parameters: JSON.stringify({
                mode: 3,
                vehicleid: 0,
            }),
        };

        const response = await axios.post(commonApi, requestData);

        const tbody = table.querySelector("tbody");
        tbody.innerHTML = "";
        if (!response.data.CommonMethodResult.CommonReportMasterList) {
            tbody.innerHTML = `<tr>
                               <td colspan='50' class='text-danger'>
                                  <i class="fa-solid fa-triangle-exclamation mx-1"></i>
                                  No Data Found
                                </td>
                            </tr>`;
            return;
        }

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
              <td>${!data.ZONE ? "-" : data.ZONE}</td>
              <td>${!data.WARD ? "-" : data.WARD}</td>
              <td>${!data.KOTHI ? "-" : data.KOTHI}</td>
              <td>${!data.SWEEPERNAME ? "-" : data.SWEEPERNAME}</td>
	      <td>${!data.DATE ? "-" : data.DATE.split('T')[0]}</td>
              <td>${!data.IMEINO ? "-" : data.IMEINO}</td>
              <td>${!data.REASON ? "-" : data.REASON}</td>
              <td>${!data.ENGINEERNAME ? "-" : data.ENGINEERNAME}</td>
              <td><button type="button" class="btn btn-sm btn-info" onclick="handleReturn(${JSON.stringify(
                    data.VEHICLEID
                )})"><i class="fa-solid fa-rotate-left"></i></button></td>
          </tr>`;

            table.querySelector("tbody").appendChild(tr);
        }
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};
const getPrabhagData = async () => {
    try {
        const requestData = {
            storedProcedureName: "Proc_DeviceManagement",
            parameters: JSON.stringify({
                mode: 8,
                vehicleid: 0,
            }),
        };

        const response = await axios.post(commonApi, requestData);

        const tbody = table1.querySelector("tbody");
        tbody.innerHTML = "";
        if (!response.data.CommonMethodResult.CommonReportMasterList) {
            tbody.innerHTML = `<tr>
                               <td colspan='50' class='text-danger'>
                                  <i class="fa-solid fa-triangle-exclamation mx-1"></i>
                                  No Data Found
                                </td>
                            </tr>`;
            return;
        }

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let tableData1 = JSON.parse(commonReportMasterList);
        console.log(tableData1);

        setDataTable(table1);

        let srNo = 0;
        for (const data of tableData1) {
            srNo++;
            const tr = document.createElement("tr");
            tr.innerHTML = `<tr>
              <td>${srNo}</td>
              <td>${!data.ZONE ? "-" : data.ZONE}</td>
              <td>${!data.WARD ? "-" : data.WARD}</td>
              <td>${!data.PRABHAG ? "-" : data.PRABHAG}</td>
              <td>${!data.SWEEPERNAME ? "-" : data.SWEEPERNAME}</td>
	      <td>${!data.DATE ? "-" : data.DATE.split('T')[0]}</td>
              <td>${!data.IMEINO ? "-" : data.IMEINO}</td>
              <td>${!data.REASON ? "-" : data.REASON}</td>
              <td>${!data.ENGINEERNAME ? "-" : data.ENGINEERNAME}</td>
              <td><button type="button" class="btn btn-sm btn-info" onclick="handleReturn(${JSON.stringify(
                    data.VEHICLEID
                )})"><i class="fa-solid fa-rotate-left"></i></button></td>
          </tr>`;

            table1.querySelector("tbody").appendChild(tr);
        }
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};
const handleReturn = async (id) => {
    try {
        const requestData = {
            storedProcedureName: "Proc_DeviceManagement",
            parameters: JSON.stringify({
                mode: 4,
                vehicleid: id,
            }),
        };

        console.log("prev", requestData);
        const response = await axios.post(commonApi, requestData);
        console.log(response);
        await getData();
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const submitData = async () => {
    if (
        !zoneDropdown.value ||
        !wardDropdown.value ||
        !kothiDropdown.value ||
        !sweeperDropdown.value ||
        imeiInput.value === "" ||
        reasonInput.value === "" ||
        engineerNameInput.value === ""
    ) {
        Swal.fire({
            icon: "info",
            title: "Attention",
            text: "Please fill all the fields",
        });
        return;
    }
    try {
        const requestData = {
            storedProcedureName: "Proc_DeviceManagement",
            parameters: JSON.stringify({
                mode: 2,
                zoneid: zoneDropdown.value,
                wardid: wardDropdown.value,
                kothiid: kothiDropdown.value,
                vehicleid: sweeperDropdown.value,
                imeino: DOMPurify.sanitize(imeiInput.value),
                reason: DOMPurify.sanitize(reasonInput.value),
                engineer_name: DOMPurify.sanitize(engineerNameInput.value),
            }),
        };

        console.log("before", requestData);
        const response = await axios.post(commonApi, requestData);

        console.log(response);

        if (response.data.CommonMethodResult.Message === "success") {
            const commonReportMasterList =
                response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

            let tableData = JSON.parse(commonReportMasterList);

            if (tableData[0].result === "allready exists") {
                Swal.fire({
                    title: "Attention!",
                    text: "Device already at Command & Control",
                    icon: "info",
                });
                return;
            } else {
                Swal.fire({
                    title: "Done!",
                    text: "New entry created successfully",
                    icon: "success",
                });
                await getData();
                await getPrabhagData();
            }
        }

        // if (response.data.CommonMethodResult.Message === "success") {
        // }
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const handleZoneSelect = () => {
    populateWardDropdown();
};

const handleWardSelect = () => {
    populateKothiDropdown();
};

const handleKothiSelect = () => {
    populateSweeperDropdown();
};

const handleSweeperSelect = () => {
    populateImeiInput();
};

const clearAll = () => {
    zoneDropdown.fstdropdown.setValue('0');
    wardDropdown.fstdropdown.setValue('0');
    kothiDropdown.fstdropdown.setValue('0');
}

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
    await populateZoneDropdown();
    await getData();
    await getPrabhagData();
});
