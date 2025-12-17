const populateZoneDropdown = async () => {
    try {
        const response = await axios.post(zoneApi, {
            mode: 11,
            vehicleId: 0,
            AccId: loginId,
        });

        console.log(response);

        const zoneMasterList = response.data.GetZoneResult.ZoneMasterList;

        $.each(zoneMasterList, function (index, zone) {
            const option = $("<option></option>")
                .val(zone.zoneid)
                .text(zone.zonename);
            $("#zoneDropdown").append(option);
        });
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const populateWardDropdown = async () => {
    try {
        $("#wardDropdown").html('<option value="0">Select Ward</option>');

        const response = await axios.post(wardApi, {
            mode: 12,
            vehicleId: 0,
            AccId: loginId,
            ZoneId: $("#zoneDropdown").val(),
        });

        const wardMasterList = response.data.GetWardResult.WardMasterList;

        $.each(wardMasterList, function (index, ward) {
            const option = $("<option></option>")
                .val(ward.PK_wardId)
                .text(ward.wardName);
            $("#wardDropdown").append(option);
        });
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const populateKothiDropdown = async () => {
    try {
        $("#kothiDropdown").html('<option value="0">Select Kothi</option>');

        const response = await axios.post(kothiApi, {
            mode: 356,
            Fk_accid: 11401,
            Fk_ambcatId: 0,
            Fk_divisionid: 0,
            FK_VehicleID: loginId,
            Fk_ZoneId: $("#zoneDropdown").val(),
            FK_WardId: $("#wardDropdown").val(),
            Startdate: "",
            Enddate: "",
            Maxspeed: 0,
            Minspeed: 0,
            Fk_DistrictId: 0,
            Geoid: 0,
        });

        const kothiMasterList = response.data.GetKothiResult.KotiMasterList;

        $.each(kothiMasterList, function (index, kothi) {
            const option = $("<option></option>")
                .val(kothi.pk_kothiid)
                .text(kothi.kothiname);
            $("#kothiDropdown").append(option);
        });
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const populateSweeperDropdown = async () => {
    try {
        $("#sweeperDropdown").html('<option value="0">Select Sweeper</option>');

        const sweeperRequestData = {
            storedProcedureName: "Proc_SweepersGroupMap",
            parameters: JSON.stringify({
                mode: 6,
                accid: loginId,
                zoneId: $("#zoneDropdown").val(),
                WardId: $("#wardDropdown").val(),
                Fk_KothiId: $("#kothiDropdown").val() || 0,
                FK_SweeperID: 0,
                sDate: "",
                eDate: "",
            }),
        };

        const response = await axios.post(commonApi, sweeperRequestData);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;
        const dropdownData = JSON.parse(commonReportMasterList);

        $.each(dropdownData, function (index, data) {
            const option = $("<option></option>")
                .val(data.PK_SweeperId)
                .text(data.SweeperName);
            $("#sweeperDropdown").append(option);
        });
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const populateTable = async () => {
    try {
        const requestData = {
            storedProcedureName: "GetSweeperAttendance_1",
            parameters: JSON.stringify({
                zoneid: $("#zoneDropdown").val(),
                wardid: $("#wardDropdown").val(),
                kothiid: $("#kothiDropdown").val(),
                EmpId: $("#sweeperDropdown").val(),
                fk_id: 11401,
                dateFrom: $("#startDate").val(),
                dateTo: $("#endDate").val(),
            }),
        };

        console.log(requestData);

        const response = await axios.post(commonApi, requestData);

        console.log(response);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let tableData = JSON.parse(commonReportMasterList);
        console.log(tableData);

        // Reset the table and set it up for new data
        setDataTable($("#table"));

        $("#dateDetails").text(
            `From ${$("#startDate").val()} to ${$("#endDate").val()}`
        );

        let srNo = 0;
        const $tableBody = $("#table tbody");
        $tableBody.empty(); // Clear previous table rows if any

        // Loop over tableData and populate rows
        $.each(tableData, function (index, data) {
            srNo++;
            const row = `<tr>
        <td>${srNo}</td>
        <td>${!data.Date ? "-" : data.Date.split('T')[0]}</td>
        <td>${!data["Sweeper Name"] ? "-" : data["Sweeper Name"]}</td>
        <td>${!data.Zone ? "-" : data.Zone}</td>
        <td>${!data.Ward ? "-" : data.Ward}</td>
        <td>${!data.Kothi ? "-" : data.Kothi}</td>
        <td>${!data.Status ? "-" : data.Status}</td>
        <td>${!data["Total Distance"] ? "-" : data["Total Distance"]}</td>
        <td>${!data["Covered Distance"] ? "-" : data["Covered Distance"]}</td>
        <td>${
                !data["Covered Percentage"] ? "-" : data["Covered Percentage"]
                }</td>
      </tr>`;

            // Append the row to the table body
            $tableBody.append(row);
        });

        // Show the table with a slide down effect
        $("#tableWrapper").slideDown("slow");
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const getData = async () => {
    await populateTable();
};

// Handlers
const handleZoneSelect = async () => {
    await populateWardDropdown();
};

const handleWardSelect = async () => {
    await populateKothiDropdown();
};

const handleKothiSelect = async () => {
    await populateSweeperDropdown();
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

// Format date

function formatDate(input) {
    var datePart = input.match(/\d+/g),
        year = datePart[0],
        month = datePart[1],
        day = datePart[2];

    return day + "-" + month + "-" + year;
}

window.addEventListener("load", async () => await populateZoneDropdown());

$(document).ready(function () {
    $("#zoneDropdown").select2({
        placeholder: "Select Zone",
        width: "100%",
    });
    $("#wardDropdown").select2({
        placeholder: "Select Ward",
        width: "100%",
    });
    $("#kothiDropdown").select2({
        placeholder: "Select Ward",
        width: "100%",
    });
    $("#sweeperDropdown").select2({
        placeholder: "Select Sweeper",
        width: "100%",
    });
});