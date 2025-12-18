<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard_CTPT_SWM.aspx.cs" Inherits="SWM.Dashboard_CTPT_SWM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card-sub-container">
        <head>
            <title>CT, PT, & Urinals Dashboard</title>
            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
            <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css" />
            <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
            <script src="https://cdn.plot.ly/plotly-2.30.0.min.js"></script>

            <style>
                body {
                    font-family: Arial, sans-serif;
                    background: linear-gradient(to bottom right, #3f51b5, #003366);
                    color: #FFFFFF;
                    margin: 0; padding: 0; overflow-x: hidden; min-height: 100vh;
                }
                .header-bar {
                background-color: #0d47a1;
                padding: 15px 20px;
                display: flex;
                border: 1px solid rgb(255,255,255,0.2);
                justify-content: space-between;
                align-items: center;
            }

                .header-bar h1 {
                    margin: 0;
                    font-size: 24px;
                }
                .date-picker-wrapper {
                    background-color: #3f51b5; color: #FFFFFF; padding: 8px 15px;
                    border-radius: 6px; font-size: 14px; font-weight: bold;
                    display: inline-flex; align-items: center; cursor: pointer;
                    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
                }
                .filter-bar {
                    display: grid; grid-template-columns: repeat(4, 1fr);
                    gap: 15px; padding: 20px; margin-bottom: 10px; align-items: flex-end;
                }
                .filter-group label {
                    font-weight: bold; color: #fff; font-size: 14px;
                    display: block; margin-bottom: 5px; text-align: center;
                }
                .filter-group select {
                    width: 100%; padding: 8px 12px; border-radius: 5px;
                    border: 1px solid #ccc; background-color: #fff; color: #000;
                }
                .dashboard-container { padding: 20px; }
                .grid-3-col { display: grid; grid-template-columns: repeat(3, 1fr); gap: 10px; margin-bottom: 10px; }
                .chart-card, .table-card {
                    background-color: #FFFFFF; color: #000; padding: 15px;
                    border-radius: 8px; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
                    height: 350px; display: flex; flex-direction: column; position: relative;
                }
                .table-card { height: auto; min-height: 200px; padding: 0; overflow-x: auto; margin-top: 20px; }
                .plotly-chart { flex-grow: 1; min-height: 300px; visibility: hidden; }
                .table-header { padding: 10px; font-size: 16px; font-weight: bold; color: #000; }
                .data-table th { background-color: #3f51b5; color: #fff; font-weight: bold; text-transform: uppercase; padding: 10px; }
                .data-table td { padding: 10px; border-bottom: 1px solid #eee; color: #333; }
                .text-right { text-align: right; }
                
                /* Loader Styles */
             .chart-loader {
     width: 40px;
     height: 40px;
     position: absolute;
     top: 50%;
     left: 50%;
     transform: translate(-50%, -50%);
     background: url('/images/301.gif') center center no-repeat;
     background-size: contain;
     display: none;
     z-index: 100;
     border-radius: 0;
     box-shadow: none;
     animation: none;
 }


     .chart-loader:before {
         content: none;
     }


 @keyframes dot-spin {
     100% {
         transform: rotate(360deg);
     }
 }
            </style>
        </head>

        <div id="form1">
            <div class="header-bar">
                <h1>CT, PT & Urinals Dashboard</h1>
                <div class="date-picker-wrapper" onclick="document.getElementById('hiddenDatePicker').showPicker()">
                    <span id="dateDisplay">--/--/----</span>
                    <span style="margin-left: 8px; font-size: 16px;">&#128197;</span>
                    <input type="date" id="hiddenDatePicker" onchange="handleDateChange(event)" style="position: absolute; visibility: hidden; width: 0; height: 0;">
                </div>
            </div>

            <div class="dashboard-container">
                <div class="filter-bar">
                    <div class="filter-group">
                        <label for="selectZone">Zone Name</label>
                        <select id="selectZone"><option value="">Select Zone</option></select>
                    </div>
                    <div class="filter-group">
                        <label for="selectWard">Ward Name</label>
                        <select id="selectWard"><option value="">Select Ward</option></select>
                    </div>
                    <div class="filter-group">
                        <label for="selectBlock">Block</label>
                        <select id="selectBlock">
                            <option value="">Select Block</option>
                            <option value="CT">CT</option>
                            <option value="PT">PT</option>
                            <option value="Urinals">Urinals</option>
                        </select>
                    </div>
                    <div class="filter-group">
                        <label for="selectMokadam">Mokadam</label>
                        <select id="selectMokadam"><option value="">Select Mokadam</option></select>
                    </div>
                </div>

                <div class="grid-3-col">
                    <div class="chart-card">
                        <div class="chart-loader"></div>
                        <div id="overallCoverageChart" class="plotly-chart"></div>
                    </div>
                    <div class="chart-card">
                        <div class="chart-loader"></div>
                        <div id="zoneWiseSplitChart" class="plotly-chart"></div>
                    </div>
                    <div class="chart-card">
                        <div class="chart-loader"></div>
                        <div id="wardWiseSplitChart" class="plotly-chart"></div>
                    </div>
                </div>

                <div class="table-card">
                    <div class="table-header">Monthly CTPT Coverage Status</div>
                    <div style="flex-grow: 1; overflow-x: auto; padding: 10px;">
                        <table class="data-table" id="tblCTPT" style="width:100%">
                            <thead>
                                <tr>
                                    <th>BLOCK</th><th>MOKADAM</th><th>ZONENAME</th><th>WARDNAME</th><th>KOTHINAME</th>
                                    <th class="text-right">TOTAL</th><th class="text-right">VISITED</th>
                                    <th class="text-right">INVALID</th><th class="text-right">UNVISITED</th>
                                    <th class="text-right">PERCENT_VISITED</th>
                                </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <script type="text/javascript">
            // --- CONSTANTS & HELPERS ---
            const CHART_INNER_HEIGHT = 300;

            function getTodayDateString() {
                const today = new Date();
                return today.getFullYear() + '-' + String(today.getMonth() + 1).padStart(2, '0') + '-' + String(today.getDate()).padStart(2, '0');
            }

            function getSelectedDate() {
                return document.getElementById('hiddenDatePicker').value || getTodayDateString();
            }

            function toggleLoader(chartId, show) {
                const chartDiv = document.getElementById(chartId);
                const card = chartDiv ? chartDiv.closest('.chart-card') : null;
                if (card) {
                    const loader = card.querySelector('.chart-loader');
                    loader.style.display = show ? 'block' : 'none';
                    chartDiv.style.visibility = show ? 'hidden' : 'visible';
                }
            }

            function getBaseLayout(titleText) {
                return {
                    title: { text: '<b>' + titleText + '</b>', font: { size: 16, color: '#000' } },
                    height: CHART_INNER_HEIGHT, paper_bgcolor: '#fff', plot_bgcolor: '#fff',
                    font: { color: '#000' }, margin: { l: 10, r: 10, t: 60, b: 10 }
                };
            }

            // --- REFRESH ALL DATA ---
            function refreshAllData() {
                const filters = {
                    zoneId: $("#selectZone").val(),
                    wardId: $("#selectWard").val(),
                    blockId: $("#selectBlock").val(),
                    mokadamId: $("#selectMokadam").val(),
                    date: getSelectedDate()
                };

                renderOverallCoverage(filters);
                renderZoneWiseSplit(filters);
                renderWardWiseSplit(filters);
                renderCTPTTable(filters);
            }

            // --- 1. OVERALL COVERAGE  ---
            function renderOverallCoverage(f) {
                const chartId = "overallCoverageChart";
                toggleLoader(chartId, true);
                var blockColors = { "CT": "#EF5350", "PT": "#FFC107", "Urinals": "#66BB6A" };
                var statusColors = { "Visited": "#4CAF50", "Unvisited": "#90A4AE", "Invalid": "#FF7043" };

                $.ajax({
                    type: "GET", url: "https://iswmpune.in/api/OverallCoverage", data: f, dataType: "json",
                    success: function (apiData) {
                        toggleLoader(chartId, false);
                        var labels = [], parents = [], values = [], colors = [];
                        var cleanInnerLabels = [], cleanInnerValues = [];

                        apiData.innerRing.labels.forEach((label, i) => {
                            if (label && label.trim() !== "") {
                                cleanInnerLabels.push(label);
                                cleanInnerValues.push(apiData.innerRing.values[i]);
                            }
                        });

                        var overallTotal = cleanInnerValues.reduce((a, b) => a + b, 0);
                        labels.push("Overall"); parents.push(""); values.push(overallTotal); colors.push("#42A5F5");

                        cleanInnerLabels.forEach((block, i) => {
                            labels.push(block); parents.push("Overall"); values.push(cleanInnerValues[i]);
                            colors.push(blockColors[block] || "#BDBDBD");
                        });

                        var statusTotals = {};
                        apiData.outerRing.labels.forEach((s, i) => statusTotals[s] = apiData.outerRing.values[i]);
                        var totalStatusSum = apiData.outerRing.values.reduce((a, b) => a + b, 0);

                        cleanInnerLabels.forEach((block, i) => {
                            var blockTotal = cleanInnerValues[i], runningSumForBlock = 0;
                            apiData.outerRing.labels.forEach((status, j) => {
                                var finalVal = (j === apiData.outerRing.labels.length - 1)
                                    ? blockTotal - runningSumForBlock
                                    : Math.round((statusTotals[status] / totalStatusSum) * blockTotal);
                                runningSumForBlock += finalVal;
                                labels.push(status + " (" + block + ")"); parents.push(block);
                                values.push(finalVal); colors.push(statusColors[status] || "#CCCCCC");
                            });
                        });

                        var data = [{
                            type: "sunburst", labels: labels, parents: parents, values: values, branchvalues: "total",
                            marker: { colors: colors, line: { color: "#fff", width: 1 } },
                            textinfo: "label+percent parent", insidetextorientation: "radial"
                        }];
                        Plotly.newPlot(chartId, data, getBaseLayout("Overall Coverage"), { responsive: true, displayModeBar: false });
                    }
                });
            }

            // --- 2. ZONE WISE SPLIT  ---
            function renderZoneWiseSplit(f) {
                const chartId = "zoneWiseSplitChart";
                toggleLoader(chartId, true);
                var zoneColors = { "1": "#FF7043", "2": "#FFC107", "3": "#66BB6A", "4": "#42A5F5", "5": "#7E57C2" };
                var statusColors = { "Visited": "#4CAF50", "Unvisited": "#FFB74D", "Invalid": "#EF5350" };

                $.ajax({
                    type: "GET",
                    url: "https://iswmpune.in/api/ZoneWiseCoverageSplit",
                    data: f,
                    dataType: "json",
                    success: function (apiData) {
                        toggleLoader(chartId, false);
                        var labels = [], parents = [], values = [], colors = [];

                        labels.push("Overall");
                        parents.push("");
                        values.push(apiData.innerRing.values.reduce((a, b) => a + b, 0));
                        colors.push("#90A4AE");

                        apiData.innerRing.labels.forEach((zone, i) => {
                            labels.push(zone);
                            parents.push("Overall");
                            values.push(apiData.innerRing.values[i]);
                            colors.push(zoneColors[zone] || "#BDBDBD");
                        });

                        apiData.outerRing.labels.forEach((label, i) => {
                            var parts = label.split(" - "), zone = parts[0], status = parts[1];
                            labels.push(status);
                            parents.push(zone);
                            values.push(apiData.outerRing.values[i]);
                            colors.push(statusColors[status] || "#CCCCCC");
                        });

                        // UPDATED CONFIGURATION HERE
                        var data = [{
                            type: "sunburst",
                            labels,
                            parents,
                            values,
                            branchvalues: "total",
                            marker: { colors }
                        }];

                        var layout = getBaseLayout("Zone Wise Coverage Split");

                        // Config object removes the toolbar and the logo
                        var config = {
                            displayModeBar: false, // This removes the download button and the whole toolbar
                            responsive: true
                        };

                        Plotly.newPlot(chartId, data, layout, config);
                    }
                });
            }

            // --- 3. WARD WISE SPLIT  ---
            function renderWardWiseSplit(f) {
                const chartId = "wardWiseSplitChart";
                toggleLoader(chartId, true);

                var statusColors = { "Visited": "#4CAF50", "Unvisited": "#FFB74D", "Invalid": "#EF5350" };

                var wardPalette = [
                    "#7E57C2", "#26A69A", "#EC407A", "#AB47BC",
                    "#42A5F5", "#FFA726", "#8D6E63", "#78909C",
                    "#5C6BC0", "#66BB6A", "#FFEE58", "#26C6DA"
                ];

                $.ajax({
                    type: "GET",
                    url: "https://iswmpune.in/api/WardWiseCoverageSplit",
                    data: f,
                    dataType: "json",
                    success: function (apiData) {
                        toggleLoader(chartId, false);
                        var labels = [], parents = [], values = [], colors = [];

                        labels.push("Overall");
                        parents.push("");
                        values.push(apiData.innerRing.values.reduce((a, b) => a + b, 0));
                        colors.push("#90A4AE");

                        apiData.innerRing.labels.forEach((ward, i) => {
                            labels.push(ward);
                            parents.push("Overall");
                            values.push(apiData.innerRing.values[i]);
                            colors.push(wardPalette[i % wardPalette.length]);
                        });

                        apiData.outerRing.labels.forEach((fullLabel, i) => {
                            var lastDash = fullLabel.lastIndexOf(" - "),
                                ward = fullLabel.substring(0, lastDash),
                                status = fullLabel.substring(lastDash + 3);

                            labels.push(status);
                            parents.push(ward);
                            values.push(apiData.outerRing.values[i]);
                            colors.push(statusColors[status] || "#CCCCCC");
                        });

                        var data = [{
                            type: "sunburst",
                            labels,
                            parents,
                            values,
                            branchvalues: "total",
                            marker: { colors, line: { color: "#fff", width: 1 } },
                            // --- VERTICAL/RADIAL LABEL SETTING ---
                            insidetextorientation: 'radial',
                            insidetextfont: { size: 12, color: "#fff" },
                            textinfo: "label+percent parent"
                        }];

                        var layout = getBaseLayout("Ward Wise Coverage Split");

                        // --- SIZE SETTINGS ---
                        layout.height = 300;
                        layout.margin = { l: 0, r: 0, b: 0, t: 50 };

                        var config = {
                            displayModeBar: false,
                            responsive: true
                        };

                       
                        Plotly.newPlot(chartId, data, layout, config);
                    }
                });
            }

            // --- 4. DATATABLE ---
            function renderCTPTTable(f) {
                const tableSelector = "#tblCTPT";
                $.ajax({
                    url: "https://iswmpune.in/api/MonthlyCTPTCoverageStatus", data: f, type: "GET", dataType: "json",
                    success: function (data) {
                        if ($.fn.DataTable.isDataTable(tableSelector)) { $(tableSelector).DataTable().clear().destroy(); }
                        $(tableSelector).DataTable({
                            data: data, paging: true, pageLength: 10, searching: true, ordering: true, info: true, scrollX: true,
                            dom: '<"top"lf>rt<"bottom"ip><"clear">',
                            columns: [
                                { data: "BLOCK" }, { data: "MOKADAM" }, { data: "ZONENAME" }, { data: "WARDNAME" }, { data: "KOTHINAME" },
                                { data: "TOTAL", className: "text-right" }, { data: "VISITED", className: "text-right" },
                                { data: "INVALID", className: "text-right" }, { data: "UNVISITED", className: "text-right" },
                                {
                                    data: "PERCENT_VISITED", className: "text-right",
                                    render: function (d) {
                                        const pct = parseFloat(d);
                                        let color = pct >= 75 ? "#4CAF50" : pct >= 50 ? "#FFC107" : "#F44336";
                                        return `<span style="color:${color};font-weight:500;font-size:10px;">${pct.toFixed(2)}%</span>`;
                                    }
                                }
                            ],
                            order: [[9, "desc"]]
                        });
                    }
                });
            }

            // --- 5. INITIALIZATION & DROPDOWNS ---
            function updateDateUI(dateString) {
                const date = new Date(dateString + 'T00:00:00');
                document.getElementById('dateDisplay').textContent = date.toLocaleDateString('en-GB');
            }

            function handleDateChange(event) {
                updateDateUI(event.target.value);
                refreshAllData();
            }

            $(document).ready(function () {
                const today = getTodayDateString();
                document.getElementById('hiddenDatePicker').value = today;
                updateDateUI(today);

                // Initial load
                refreshAllData();

                // Load Zones
                $.ajax({
                    url: '/api/GetzoneAPI', type: "GET", dataType: "json",
                    success: function (json) {
                        $("#selectZone").empty().append('<option value="">Select Zone</option>');
                        if (json && json.labels) {
                            json.labels.forEach((l, i) => $("#selectZone").append(`<option value="${json.values[i]}">${l}</option>`));
                        }
                    }
                });

                // Zone Change
                $("#selectZone").change(function () {
                    var id = $(this).val();
                    $("#selectWard").empty().append('<option value="">Select Ward</option>');
                    if (!id) return;
                    $.ajax({
                        url: '/api/GetWardAPI', data: { ZoneId: id }, type: "GET", dataType: "json",
                        success: function (json) {
                            if (json && json.labels) {
                                json.labels.forEach((l, i) => $("#selectWard").append(`<option value="${json.values[i]}">${l}</option>`));
                            }
                        }
                    });
                });

                // Ward or Block Change -> Populate Mokadam
                $("#selectWard, #selectBlock").change(function () {
                    var zoneId = $("#selectZone").val(), wardId = $("#selectWard").val(), blockId = $("#selectBlock").val();
                    $("#selectMokadam").empty().append('<option value="">Select Mokadam</option>');
                    if (wardId && blockId) {
                        $.ajax({
                            url: '/api/GetMokadamAPI', type: "GET", dataType: "json",
                            data: { ZoneId: zoneId, WardId: wardId, BlockId: blockId },
                            success: function (json) {
                                if (json && json.labels) {
                                    json.labels.forEach((l, i) => $("#selectMokadam").append(`<option value="${json.values[i]}">${l}</option>`));
                                }
                            }
                        });
                    }
                });

                // --- THE TRIGGER ---
                $("#selectMokadam").change(function () {
                    refreshAllData();
                });
            });
        </script>
    </div>
</asp:Content>