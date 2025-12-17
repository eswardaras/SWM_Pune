const zoneDropdown = document.getElementById("zoneDropdown");
const wardDropdown = document.getElementById("wardDropdown");
const mechSweeperDropdown = document.getElementById("mechSweeperDropdown");
const startDate = document.getElementById("startDate");
const endDate = document.getElementById("endDate");

const dateSpan = document.getElementById("dateSpan");
const btnSearch = document.getElementById("btnSearch");

const table = document.getElementById("table");
//const loginId = 11401;

//const zoneApi = "http://13.200.33.105/SWMServiceLive/SWMService.svc/GetZone";
//const wardApi = "http://13.200.33.105/SWMServiceLive/SWMService.svc/GetWard";
//const commonApi =
//    "http://13.200.33.105/SWMServiceLive/SWMService.svc/CommonMethod";

const cityWiseChart = document.getElementById("cityWise");
const zoneWise = document.getElementById("zoneWise");
const cityRoute = document.getElementById("cityWiseRoute");
const zoneWiseRoute = document.getElementById("zoneWiseRoute");

const populateZoneDropdown = async () => {
    try {
        const response = await axios.post(zoneApi, {
            mode: 11,
            vehicleId: 0,
            AccId: loginId,
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
            AccId: loginId,
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

const populateMechSweeperDropdown = async () => {
    try {
        mechSweeperDropdown.innerHTML =
            '<option value="0">Select Mech. Sweeper Name</option>';

        const requestData = {
            storedProcedureName: "proc_MechanicalSweeperRouteCoverage",
            parameters: JSON.stringify({
                mode: 3,
                AdminID: 0,
                AccId: loginId,
                ZoneId: zoneDropdown.value,
                WardId: wardDropdown.value,
                MechSweeper: "All",
                RoleID: 0,
            }),
        };

        const response = await axios.post(commonApi, requestData);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let dropdownData = JSON.parse(commonReportMasterList);
        console.log(dropdownData);

        for (const data of dropdownData) {
            const option = document.createElement("option");
            option.value = data.pk_vehicleid;
            option.text = data.vehiclename;
            mechSweeperDropdown.appendChild(option);
            mechSweeperDropdown.fstdropdown.rebind();
        }
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const populateTable = async () => {
    try {
        const tbody = table.querySelector("tbody");
        tbody.innerHTML = `<tr>
                          <td colspan='50' class='text-danger'>Loading...</td>
                       </tr>`;

        const requestData = {
            storedProcedureName: "proc_MechanicalSweeperRouteCoverage",
            parameters: JSON.stringify({
                mode: 4,
                AdminID: 0,
                AccId: loginId,
                ZoneId: zoneDropdown.value,
                WardId: wardDropdown.value,
                startdate: startDate.value,
                enddate: endDate.value,
                MechSweeper: "All",
                RoleID: 0,
            }),
        };

        const response = await axios.post(commonApi, requestData);
        console.log(response);

        tbody.innerHTML = "";
        if (!response.data.CommonMethodResult.CommonReportMasterList) {
            // const tableBody = table1.querySelector("tbody");
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

        $("#dateSpan").text(
            `From ${formatDate(startDate.value)} to ${formatDate(endDate.value)}`
        );

        let tableData = JSON.parse(commonReportMasterList);
        console.log(tableData);

        setDataTable(table);

        for (const data of tableData) {
            const tr = document.createElement("tr");
            tr.innerHTML = `<tr>
      <td>${data.Date}</td>
      <td>${data.Zone}</td>
      <td>${data.Ward}</td>
      <td>${data.Route}</td>
      <td>${data["Mechanical Sweeper"]}</td>
      <td>${data["Work %"]}</td>
      <td>${data.ActualRouteMeter}</td>
      <td>${data.CoveredRouteMeter}</td>
      <td>${data.expectedcoverage}</td>
      <td>${data.CheckingTime}</td>
      <td>${data.AverageSpeed}</td>
      <td>${data.OverSpeed}</td>
      <td><button class='btn btn-sm text-white btn-info' value='${JSON.stringify(
                    data
                )}' onclick='handleViewHistory(event)'>View Route</button></td>
</tr>`;

            table.querySelector("tbody").appendChild(tr);
        }
    } catch (error) {
        console.error("An error occurred while populating the table:", error);
    }
};

const getChart1Data = async () => {
    try {
        const requestData = {
            storedProcedureName: "proc_MechanicalSweeperRouteCoverage",
            parameters: JSON.stringify({
                mode: 5,
                AdminID: 0,
                RoleID: 0,
                AccId: loginId,
                ZoneId: zoneDropdown.value,
                WardId: wardDropdown.value,
                startdate: startDate.value,
                enddate: endDate.value,
                MechSweeper: "All",
            }),
        };

        const response = await axios.post(commonApi, requestData);

        const commonReportMasterList1 =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        const commonReportMasterList2 =
            response.data.CommonMethodResult.CommonReportMasterList[1].ReturnValue;

        createPieChart(commonReportMasterList1, cityWiseChart);
        createLineChart(commonReportMasterList2, zoneWise);
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const getChart2Data = async () => {
    try {
        const requestData = {
            storedProcedureName: "proc_MechanicalSweeperRouteCoverage",
            parameters: JSON.stringify({
                mode: 6,
                AdminID: 0,
                RoleID: 0,
                AccId: loginId,
                ZoneId: zoneDropdown.value,
                WardId: wardDropdown.value,
                startdate: startDate.value,
                enddate: endDate.value,
                MechSweeper: "All",
            }),
        };

        const response = await axios.post(commonApi, requestData);

        const commonReportMasterList1 =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        const commonReportMasterList2 =
            response.data.CommonMethodResult.CommonReportMasterList[1].ReturnValue;

        createPieChartRoute(commonReportMasterList1, cityRoute);
        createLineChartRoute(commonReportMasterList2, zoneWiseRoute);
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

// Handlers

const handleZoneSelect = () => {
    populateWardDropdown();
};

const handleWardSelect = () => {
    populateMechSweeperDropdown();
};

const handleViewHistory = (event) => {
    const { value } = event.target;
    try {
        const parsedValue = JSON.parse(value);
        console.log(parsedValue);
        const dataToPass = {
            vehicleId: parsedValue.Pk_Vehicleid,
            date: parsedValue.Date,
            routeid: parsedValue.Routeid,
            vehiclename: parsedValue["Mechanical Sweeper"],
            zonename: parsedValue.Zone,
            wardname: parsedValue.Ward,
        };

        const jsonString = JSON.stringify(dataToPass); // Convert the new object to a JSON string
        const encodedData = encodeURIComponent(jsonString); // Encode the JSON string
        console.log(encodedData);
        window.open(`MechSweeperHistoryMap.aspx?data=${encodedData}`, "_blank");
    } catch (error) {
        console.error("Failed to process data", error);
    }
};

// Listeners

btnSearch.addEventListener("click", async (e) => {
    e.preventDefault();

    if (startDate.value > endDate.value) {
        $("#error_warning").modal("show");
        return;
    }

    $("#tableWrapper").slideDown("slow");
    await populateTable();
    await getChart1Data();
    await getChart2Data();
    $("#chartWrapper").slideDown("slow");
});

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
                    text: "Excel <i class='fas fa-file-excel'></i>",
                    title: document.title,
                    className: "btn btn-sm btn-success mb-2", // Add your Excel button class here
                },
                {
                    extend: "pdf",
                    text: "PDF <i class='fa-regular fa-file-pdf'></i>",
                    title: document.title,
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

            // use below code to disable sorting on first column
            order: [],
            columnDefs: [
                {
                    targets: "no-sort",
                    orderable: false,
                },
            ],

            // use below code to disable sorting on any column (0 based index/ use -1 for last column)
            // columnDefs: [{ orderable: false, targets: -1 }],
        });
    });
}

// Format date

function formatDate(input) {
    var datePart = input.match(/\d+/g),
        year = datePart[0],
        month = datePart[1],
        day = datePart[2];

    return day + "-" + month + "-" + year;
}

// Bootstrap

const toast = new bootstrap.Toast(document.getElementById("noDataToast"));

window.addEventListener("load", async () => {
    await populateZoneDropdown();
});

// Chart

const createPieChart = (chartData, canvasID) => {
    const pieChartData = JSON.parse(chartData);
    console.log("City Wise", pieChartData);
    let total = null;
    let cover = null;
    let uncover = null;
    let partiallyCover = null;

    pieChartData.forEach((data) => {
        total = data.Total;
        cover = data.Cover;
        uncover = data.UnCover;
        partiallyCover = data.PartiallyCover;
    });

    let labels = ["Cover", "Uncover", "Partially Cover"];
    let datasetData = [cover, uncover, partiallyCover];

    let existingChart = Chart.getChart(canvasID);
    if (existingChart) {
        existingChart.destroy(); // Destroy the existing chart instance
    }

    new Chart(canvasID, {
        type: "pie",
        data: {
            labels: labels,
            datasets: [
                {
                    //label: "City Wise",
                    data: datasetData,
                    borderWidth: 1,
                },
            ],
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: "right",
                    labels: {
                        generateLabels: function (chart) {
                            var data = chart.data;
                            if (data.labels.length && data.datasets.length) {
                                return data.labels.map(function (label, i) {
                                    var dataset = data.datasets[0];
                                    var value = dataset.data[i];
                                    return {
                                        text: label + ": " + value,
                                        fillStyle: dataset.backgroundColor[i],
                                        hidden: isNaN(dataset.data[i]), // Hide labels with NaN values (if any)
                                        index: i,
                                    };
                                });
                            }
                            return [];
                        },
                    },
                },
                title: {
                    display: true,
                    text: `Total ${total}`,
                    font: {
                        weight: "bold",
                        size: 20,
                    },
                    position: "bottom",
                },
            },
        },
    });
};

const createLineChart = (chartData, canvasID) => {
    const lineChartData = JSON.parse(chartData);
    console.log("Zone Wise Data", lineChartData);
    const labels = [];
    const cover = [];
    const uncover = [];
    const partiallyCover = [];

    lineChartData.forEach((data) => {
        labels.push(`${data.Zone}`);
        cover.push(data.Cover);
        uncover.push(data.UnCover);
        partiallyCover.push(data.PartiallyCover);
    });

    const totalCover = cover.reduce((total, value) => total + value, 0);
    const totalUncover = uncover.reduce((total, value) => total + value, 0);
    const totalPartiallyCover = partiallyCover.reduce((a, c) => a + c, 0);
    const total = totalCover + totalUncover + totalPartiallyCover;

    let existingChart = Chart.getChart(canvasID);
    if (existingChart) {
        existingChart.destroy(); // Destroy the existing chart instance
    }

    new Chart(canvasID, {
        type: "bar",
        data: {
            labels: labels,
            datasets: [
                {
                    label: "Cover",
                    data: cover,
                    backgroundColor: "rgba(54, 162, 235, 1)",
                },
                {
                    label: "Uncover",
                    data: uncover,
                    backgroundColor: "rgba(255, 99, 132, 1)",
                },
                {
                    label: "PartiallyCover",
                    data: partiallyCover,
                    backgroundColor: "rgba(255, 159, 64, 1)",
                },
            ],
        },
        options: {
            indexAxis: "y",
            plugins: {
                legend: {
                    position: "bottom",
                    labels: {
                        generateLabels: function (chart) {
                            const labels =
                                Chart.defaults.plugins.legend.labels.generateLabels(chart);
                            labels.forEach((label) => {
                                if (label.text === "Cover") {
                                    label.text = `Cover: ${totalCover}`;
                                } else if (label.text === "Uncover") {
                                    label.text = `Uncover: ${totalUncover}`;
                                } else if (label.text === "PartiallyCover") {
                                    label.text = `PartiallyCover ${totalPartiallyCover}`;
                                }
                            });
                            return labels;
                        },
                    },
                },
                title: {
                    display: true,
                    text: `Total ${total}`,
                    font: {
                        weight: "bold",
                        size: 20,
                    },
                    position: "bottom",
                    padding: {
                        top: 20,
                    },
                },
            },
            scales: {
                x: {
                    stacked: true,
                    barPercentage: 0.7,
                    categoryPercentage: 0.8,
                },
                y: {
                    stacked: true,
                },
            },
            responsive: true,
            layout: {
                padding: {
                    left: 10,
                    right: 10,
                },
            },
            barPercentage: 0.6,
            categoryPercentage: 0.8,
        },
    });
};

const createPieChartRoute = (chartData, canvasID) => {
    const pieChartData = JSON.parse(chartData);
    console.log("City Wise Route Covered (KM)", pieChartData);

    let total = null;
    let cover = null;
    let uncover = null;

    pieChartData.forEach((data) => {
        total = data.Total;
        cover = data.Cover;
        uncover = data.UnCover;
    });

    let labels = ["Cover", "Uncover"];
    let datasetData = [cover, uncover];

    let existingChart = Chart.getChart(canvasID);
    if (existingChart) {
        existingChart.destroy(); // Destroy the existing chart instance
    }

    new Chart(canvasID, {
        type: "pie",
        data: {
            labels: labels,
            datasets: [
                {
                    //label: "City Wise",
                    data: datasetData,
                    borderWidth: 1,
                },
            ],
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: "right",
                    labels: {
                        generateLabels: function (chart) {
                            var data = chart.data;
                            if (data.labels.length && data.datasets.length) {
                                return data.labels.map(function (label, i) {
                                    var dataset = data.datasets[0];
                                    var value = dataset.data[i];
                                    return {
                                        text: label + ": " + value + " KM",
                                        fillStyle: dataset.backgroundColor[i],
                                        hidden: isNaN(dataset.data[i]), // Hide labels with NaN values (if any)
                                        index: i,
                                    };
                                });
                            }
                            return [];
                        },
                    },
                },
                title: {
                    display: true,
                    text: `Total ${total} KM`,
                    font: {
                        weight: "bold",
                        size: 20,
                    },
                    position: "bottom",
                },
            },
        },
    });
};

const createLineChartRoute = (chartData, canvasID) => {
    const lineChartData = JSON.parse(chartData);
    console.log("Zone Wise Route Covered(KM)", lineChartData);
    const labels = [];
    const cover = [];
    const uncover = [];

    lineChartData.forEach((data) => {
        labels.push(`${data.Zone}`);
        cover.push(data.Cover);
        uncover.push(data.UnCover);
    });

    const totalCover = cover.reduce((total, value) => total + value, 0);
    const totalUncover = uncover.reduce((total, value) => total + value, 0);
    /*    const totalPartiallyCover = partiallyCover.reduce((a, c) => a + c, 0);*/
    const total = totalCover + totalUncover;

    let existingChart = Chart.getChart(canvasID);
    if (existingChart) {
        existingChart.destroy(); // Destroy the existing chart instance
    }

    new Chart(canvasID, {
        type: "bar",
        data: {
            labels: labels,
            datasets: [
                {
                    label: "Cover",
                    data: cover,
                    backgroundColor: "rgba(54, 162, 235, 1)",
                },
                {
                    label: "Uncover",
                    data: uncover,
                    backgroundColor: "rgba(255, 99, 132, 1)",
                },
            ],
        },
        options: {
            indexAxis: "y",
            plugins: {
                legend: {
                    position: "bottom",
                    labels: {
                        generateLabels: function (chart) {
                            const labels =
                                Chart.defaults.plugins.legend.labels.generateLabels(chart);
                            labels.forEach((label) => {
                                if (label.text === "Cover") {
                                    label.text = `Cover: ${totalCover} KM`;
                                } else if (label.text === "Uncover") {
                                    label.text = `Uncover: ${totalUncover} KM`;
                                }
                            });
                            return labels;
                        },
                    },
                },
                title: {
                    display: true,
                    text: `Total ${total} KM`,
                    font: {
                        weight: "bold",
                        size: 20,
                    },
                    position: "bottom",
                    padding: {
                        top: 20,
                    },
                },
            },
            scales: {
                x: {
                    stacked: true,
                    barPercentage: 0.7,
                    categoryPercentage: 0.8,
                },
                y: {
                    stacked: true,
                },
            },
            responsive: true,
            layout: {
                padding: {
                    left: 10,
                    right: 10,
                },
            },
            barPercentage: 0.6,
            categoryPercentage: 0.8,
        },
    });
};

const limitNumber = (number) => {
    return Math.ceil(number);
};
