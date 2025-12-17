<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CTPTUrinals.aspx.cs" Inherits="SWM.CTPTUrinals" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card-sub-container">
<head >
    <title>CT, PT, & Urinals Dashboard</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet"
      href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css" />

<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    
    <script src="https://cdn.plot.ly/plotly-2.30.0.min.js"></script>

    <style>
        /* --- Base & Background Styles --- */
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to bottom right, #3f51b5, #003366); 
            color: #FFFFFF;
            margin: 0;
            padding: 0;
            overflow-x: hidden;
            min-height: 100vh;
        }

        /* --- Header/Title Bar --- */
        .header-bar {
            background-color: rgba(0, 0, 0, 0.1);
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
        }
        .header-bar h1 {
            margin: 0;
            font-size: 28px;
            font-weight: lighter;
        }
        .header-date {
            font-weight: bold;
            font-size: 14px;
            padding: 5px 10px;
            background-color: #ffffff;
            color: #000;
            border-radius: 4px;
        }

        /* --- Filter Bar Styling (4-Column Grid for CTPT) --- */
        .filter-bar {
            display: grid;
            grid-template-columns: repeat(4, 1fr); 
            gap: 7px;
            padding: 10px 10px;
            border-radius: 5px;
            margin-bottom: 7px;
            align-items: center;
        }

        .filter-bar label {
            font-weight: bold;
            color: #06923E; 
            font-size: 14px;
            display: block; 
            margin-bottom: 5px;
            text-align: center;
        }

        .filter-bar select {
            width: 100%;
            padding: 8px 12px;
            border-radius: 5px;
            border: 1px solid #ffffff; 
            background-color: #fff; 
            color: #000;
            font-size: 14px;
            cursor: pointer;
          
        }
        
        /* --- Dashboard Grid Layout --- */
        .dashboard-container {
            padding: 20px;
        }

        /* Top row: 3 equal charts */
        .grid-3-col {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 7px;
            margin-bottom: 7px;
        }

        /* --- Card and Chart Container Styling (White Background) --- */
        .chart-card, .table-card {
            background-color: #FFFFFF;
            color: #000;
            padding: 10px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
            height: 350px; 
            min-height: 300px; 
            display: flex;
            flex-direction: column;
            position: relative; /* IMPORTANT for loader positioning */
        }
        .plotly-chart {
            flex-grow: 1;
            min-height: 300px; 
        }

        /* --- Table Styling --- */
        .table-card { height: auto; min-height: 200px; padding: 0; overflow-x: auto; margin-top: 20px; }
        .table-header { padding: 15px 15px 10px 15px; font-size: 18px; font-weight: bold; }
        .data-table { width: 100%; border-collapse: collapse; text-align: left; font-size: 12px; }
        .data-table th, .data-table td { padding: 10px; border-bottom: 1px solid #eee; white-space: nowrap; }
        .data-table th { background-color: #3f51b5; font-weight: bold; text-transform: uppercase; }
        .pagination-bar { padding: 10px 15px; display: flex; justify-content: flex-end; background-color: #f5f5f5; }
        
        /* --- Responsive Adjustments --- */
        @media (max-width: 1200px) {
            .grid-3-col {
                grid-template-columns: repeat(2, 1fr);
            }
            .filter-bar {
                 grid-template-columns: repeat(2, 1fr);
            }
        }
        @media (max-width: 768px) {
            .filter-bar, .grid-3-col {
                grid-template-columns: 1fr;
            }
        }
        .data-table th {
            background-color: #3f51b5; /* Light gray */
            font-weight: bold;
            text-transform: uppercase;
        }

        /* --- LOADER STYLES (CORRECTED: Guaranteed Circular Dots with Blue Shades) --- */
      .chart-card, .box, .dashboard-chart {
    /* Ensure parent container is relative for loader centering */
    position: relative !important; 
}


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
<body>
    <div id="form1" >
        <div class="header-bar">
            <h1>CT, PT & Urinals Dashboard</h1>
            <div class="header-date">12/12/2025</div>
        </div>

        <div class="dashboard-container">
            
            <div class="filter-bar">
                
                <div class="filter-group">
                    <label for="selectBlock">Block</label>
                    <select id="selectBlock">
                        <option value="all">Select Block</option>
                        <option value="CT">CT</option>
                        <option value="PT">PT</option>
                    </select>
                </div>
                
                <div class="filter-group">
                    <label for="selectMokadam">Mokadam</label>
                    <select id="selectMokadam">
                        <option value="all">Select Mokadam</option>
                        <option value="mok1">Siddharth Bagul</option>
                    </select>
                </div>

                <div class="filter-group">
                    <label for="selectZone">Zone Name</label>
                    <select id="selectZone">
                        <option value="all">Select Zone</option>
                        <option value="zone2">Zone 2</option>
                    </select>
                </div>

                <div class="filter-group">
                    <label for="selectWard">Ward Name</label>
                    <select id="selectWard">
                        <option value="all">Select Ward</option>
                        <option value="wardA">Ambil Odha</option>
                    </select>
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
                <div style="flex-grow: 1; overflow-x: auto;">
                    <table class="data-table" id="tblCTPT">
                        <thead>
                            <tr>
                               <th>BLOCK</th>
            <th>MOKADAM</th>
            <th>ZONENAME</th>
            <th>WARDNAME</th>
            <th>KOTHINAME</th>
            <th>TOTAL</th>
            <th>VISITED</th>
            <th>INVALID</th>
            <th>UNVISITED</th>
            <th>PERCENT_VISITED</th>
                            </tr>
                        </thead>
                        <tbody>
    <tr><td colspan="8" class="text-center">Loading data...</td></tr>
</tbody>
                    </table>
                </div>
                <div class="pagination-bar">
                    <div style="font-size: 12px; color: #666;">Page 1 of 10 ></div>
                </div>
            </div>

        </div>
    </div>

    <script type="text/javascript">

        const CHART_INNER_HEIGHT = 300;

        // --- LOADER TOGGLE FUNCTION ---
        function toggleLoader(chartId, show) {
            const chartDiv = document.getElementById(chartId);
            // Locate the parent .chart-card 
            const cardElement = chartDiv ? chartDiv.closest('.chart-card') : null;
            if (!cardElement) return;

            const loader = cardElement.querySelector('.chart-loader');

            if (loader) {
                loader.style.display = show ? 'block' : 'none';

                // Toggle visibility of the Plotly container
                // We toggle visibility rather than display to reserve space, preventing layout shift
                chartDiv.style.visibility = show ? 'hidden' : 'visible';
            }
        }
        // --- END LOADER TOGGLE FUNCTION ---


        function getBaseLayout(titleText) {
            return {
                title: {
                    text: '<b>' + titleText + '</b>',
                    font: { size: 16, color: '#000' }
                },
                height: CHART_INNER_HEIGHT,
                paper_bgcolor: '#fff',
                plot_bgcolor: '#fff',
                font: { color: '#000' },
                margin: { l: 20, r: 20, t: 30, b: 20 }
            };
        }
        // Helper function to display loading or error messages in containers
        function showLoadingMessage(targetSelector, message, isTable = true, colspan = 8) {

            // Check if the selector is a table selector and if it's currently a DataTable
            if (isTable && $.fn.DataTable.isDataTable(targetSelector)) {
                try {
                    // Attempt to destroy the DataTable instance gracefully
                    $(targetSelector).DataTable().destroy();
                } catch (e) {
                    // Ignore errors if destruction fails
                    console.warn("Could not destroy DataTable:", e);
                }
                // Clear out the HTML structure inserted by DataTable
                $(targetSelector).empty();
                // Re-add basic table structure before inserting the loading row
                $(targetSelector).append('<thead><tr><th colspan="' + colspan + '"></th></tr></thead><tbody></tbody>');
            }


            const $tbody = $(targetSelector).find('tbody');

            if ($tbody.length === 0) {
                // Fallback for non-table chart containers
                $(targetSelector).html('<div style="text-align:center; padding: 20px; color: #888;">' + message + '</div>');
                return;
            }

            const color = message.includes("Error") ? "#D32F2F" : "#455A64";

            $tbody.html(`
        <tr>
            <td colspan="${colspan}" 
                style="text-align:center; padding:15px; color:${color}; font-weight:600;">
                ${message}
            </td>
        </tr>
    `);
        }
        // --- 1. Overall Coverage (Nested Doughnut: PT/CT/Urinals) ---

        function renderOverallCoverage() {
            const chartId = "overallCoverageChart";
            toggleLoader(chartId, true);

            $.ajax({
                type: "GET",
                url: "http://localhost:75/api/OverallCoverage",
                dataType: "json",
                success: function (apiData) {
                    toggleLoader(chartId, false);

                    var labels = [];
                    var parents = [];
                    var values = [];
                    var colors = [];

                    // -------- Colors --------
                    var blockColors = {
                        "CT": "#C62828",
                        "PT": "#FBC02D",
                        "Urinals": "#2E7D32"
                    };

                    var statusColors = {
                        "Visited": "#EF5350",
                        "Unvisited": "#90A4AE",
                        "Invalid": "#FB8C00"
                    };

                    // -------- Totals --------
                    var overallTotal = apiData.innerRing.values.reduce((a, b) => a + b, 0);

                    var statusTotals = {};
                    apiData.outerRing.labels.forEach(function (s, i) {
                        statusTotals[s] = apiData.outerRing.values[i];
                    });

                    // -------- ROOT --------
                    labels.push("Overall");
                    parents.push("");
                    values.push(overallTotal);
                    colors.push("#B71C1C");

                    // -------- BLOCK LEVEL (INNER RING) --------
                    apiData.innerRing.labels.forEach(function (block, i) {

                        if (!block || block.trim() === "") return;

                        labels.push(block);
                        parents.push("Overall");
                        values.push(apiData.innerRing.values[i]);
                        colors.push(blockColors[block] || "#BDBDBD");
                    });

                    // -------- STATUS LEVEL (OUTER RING) --------
                    apiData.innerRing.labels.forEach(function (block, i) {

                        if (!block || block.trim() === "") return;

                        var blockTotal = apiData.innerRing.values[i];

                        apiData.outerRing.labels.forEach(function (status) {

                            var proportionalValue =
                                (statusTotals[status] / overallTotal) * blockTotal;

                            labels.push(status);
                            parents.push(block);
                            values.push(Math.round(proportionalValue));
                            colors.push(statusColors[status]);
                        });
                    });

                    var data = [{
                        type: "sunburst",
                        labels: labels,
                        parents: parents,
                        values: values,
                        branchvalues: "total",
                        marker: {
                            colors: colors,
                            line: { color: "#fff", width: 1 }
                        },
                        textinfo: "label+percent parent",
                        insidetextorientation: "radial"
                    }];

                    var layout = {
                        title: {
                            text: "Overall Coverage",
                            font: { size: 20 }
                        },
                        margin: { l: 10, r: 10, t: 60, b: 10 }
                    };

                    Plotly.newPlot(
                        chartId,
                        data,
                        layout,
                        { responsive: true, displayModeBar: false }
                    );
                },
                error: function (xhr) {
                    console.error("AJAX error:", xhr.responseText);
                    toggleLoader(chartId, false);
                }
            });
        }


        function renderZoneWiseSplit() {
            const chartId = "zoneWiseSplitChart";
            toggleLoader(chartId, true);

            // Data structure expanded to include Zones 4 and 5, matching the five-zone structure
            // visible in the screenshot (image (8).jpg, Zone Wise Coverage Split).
            $.ajax({
                type: "GET",
                url: "http://localhost:75/api/ZoneWiseCoverageSplit",
                dataType: "json",
                success: function (apiData) {
                    toggleLoader(chartId, false);

                    var labels = [];
                    var parents = [];
                    var values = [];
                    var colors = [];

                    // -------- Colors --------
                    var zoneColors = {
                        "1": "#B71C1C",
                        "2": "#F9A825",
                        "3": "#2E7D32",
                        "4": "#26A69A",
                        "5": "#1565C0"
                    };

                    var statusColors = {
                        "Visited": "#FFB74D",
                        "Unvisited": "#90A4AE",
                        "Invalid": "#EF5350"
                    };

                    // -------- ROOT --------
                    labels.push("Overall");
                    parents.push("");
                    values.push(apiData.innerRing.values.reduce((a, b) => a + b, 0));
                    colors.push("#263238");

                    // -------- ZONE LEVEL (INNER RING) --------
                    apiData.innerRing.labels.forEach(function (zone, i) {
                        labels.push(zone);
                        parents.push("Overall");
                        values.push(apiData.innerRing.values[i]);
                        colors.push(zoneColors[zone] || "#BDBDBD");
                    });

                    // -------- STATUS LEVEL (OUTER RING) --------
                    apiData.outerRing.labels.forEach(function (label, i) {

                        // "2 - Visited" → ["2", "Visited"]
                        var parts = label.split(" - ");
                        var zone = parts[0];
                        var status = parts[1];

                        labels.push(status);
                        parents.push(zone);
                        values.push(apiData.outerRing.values[i]);
                        colors.push(statusColors[status] || "#CCCCCC");
                    });

                    var data = [{
                        type: "sunburst",
                        labels: labels,
                        parents: parents,
                        values: values,
                        branchvalues: "total",
                        marker: { colors: colors },
                        textinfo: "label+percent parent",
                        insidetextorientation: "radial"
                    }];

                    var layout = {
                        title: {
                            text: "Zone Wise Coverage Split",
                            font: { size: 20 }
                        },
                        margin: { l: 10, r: 10, t: 60, b: 10 }
                    };

                    Plotly.newPlot(
                        chartId,
                        data,
                        layout,
                        { responsive: true, displayModeBar: false }
                    );
                },
                error: function (xhr) {
                    console.error("AJAX error:", xhr.responseText);
                    toggleLoader(chartId, false);
                }
            });


        }

        // --- 3. Ward Wise Coverage Split (Sunburst Chart) ---
        function renderWardWiseSplit() {
            const chartId = "wardWiseSplitChart";
            toggleLoader(chartId, true);

            // Note: Data is structured as Ward -> Status (Visited, Unvisited, Invalid).
            // Ward Names (Parents) are approximated from the CTPT image.
            $.ajax({
                type: "GET",
                url: "http://localhost:75/api/WardWiseCoverageSplit",
                dataType: "json",
                success: function (apiData) {
                    toggleLoader(chartId, false);

                    var labels = [];
                    var parents = [];
                    var values = [];
                    var colors = [];

                    // -------- Status Colors --------
                    var statusColors = {
                        "Visited": "#FFB74D",
                        "Unvisited": "#90A4AE",
                        "Invalid": "#EF5350"
                    };

                    // -------- ROOT --------
                    labels.push("Overall");
                    parents.push("");
                    values.push(apiData.innerRing.values.reduce((a, b) => a + b, 0));
                    colors.push("#263238");

                    // -------- INNER RING (WARDS) --------
                    apiData.innerRing.labels.forEach(function (ward, i) {
                        labels.push(ward);
                        parents.push("Overall");
                        values.push(apiData.innerRing.values[i]);
                        colors.push("#BDBDBD"); // neutral color for wards
                    });

                    // -------- OUTER RING (STATUS SPLIT) --------
                    apiData.outerRing.labels.forEach(function (fullLabel, i) {

                        // ✅ Split from LAST " - "
                        var lastDash = fullLabel.lastIndexOf(" - ");
                        var ward = fullLabel.substring(0, lastDash);
                        var status = fullLabel.substring(lastDash + 3);

                        labels.push(status);
                        parents.push(ward);
                        values.push(apiData.outerRing.values[i]);
                        colors.push(statusColors[status] || "#CCCCCC");
                    });

                    var data = [{
                        type: "sunburst",
                        labels: labels,
                        parents: parents,
                        values: values,
                        branchvalues: "total",
                        marker: { colors: colors },
                        textinfo: "label+percent parent",
                        insidetextorientation: "radial"
                    }];

                    var layout = {
                        title: {
                            text: "Ward Wise Coverage Split",
                            font: { size: 20 }
                        },
                        margin: { l: 10, r: 10, t: 60, b: 10 }
                    };

                    Plotly.newPlot(
                        chartId,
                        data,
                        layout,
                        { responsive: true, displayModeBar: false }
                    );
                },
                error: function (xhr) {
                    console.error("AJAX error:", xhr.responseText);
                    toggleLoader(chartId, false);
                }
            });


        }

        function renderCTPTTable() {
            const tableSelector = "#tblCTPT";
            const apiUrl = "http://localhost:75/api/MonthlyCTPTCoverageStatus";
            const headerText = "Monthly CTPT Coverage Status";
            const colspan = 10;

            showLoadingMessage(tableSelector, 'Loading ' + headerText + ' data...', true, colspan);

            $.ajax({
                url: apiUrl,
                type: "GET",
                dataType: "json",
                success: function (data) {

                    if (!Array.isArray(data) || data.length === 0) {
                        showLoadingMessage(
                            tableSelector,
                            'No ' + headerText + ' data available.',
                            true,
                            colspan
                        );
                        return;
                    }

                    // Destroy existing DataTable
                    if ($.fn.DataTable.isDataTable(tableSelector)) {
                        $(tableSelector).DataTable().clear().destroy();
                    }

                    // Initialize DataTable
                    $(tableSelector).DataTable({
                        data: data,
                        paging: true,
                        pageLength: 10,
                        searching: true,
                        ordering: true,
                        info: true,
                        autoWidth: false,
                        scrollX: true,

                        columns: [
                            { data: "BLOCK", title: "Block" },
                            { data: "MOKADAM", title: "Mokadam" },
                            { data: "ZONENAME", title: "Zone" },
                            { data: "WARDNAME", title: "Ward" },
                            { data: "KOTHINAME", title: "Kothi Name" },
                            {
                                data: "TOTAL",
                                title: "Total",
                                className: "text-right"
                            },
                            {
                                data: "VISITED",
                                title: "Visited",
                                className: "text-right"
                            },
                            {
                                data: "INVALID",
                                title: "Invalid",
                                className: "text-right"
                            },
                            {
                                data: "UNVISITED",
                                title: "Unvisited",
                                className: "text-right"
                            },
                            {
                                data: "PERCENT_VISITED",
                                title: "% Visited",
                                className: "text-right",
                                render: function (d) {
                                    const pct = parseFloat(d);
                                    if (isNaN(pct)) return "0.00 %";

                                    let color =
                                        pct >= 75 ? "green" :
                                            pct >= 50 ? "orange" :
                                                "red";

                                    return `<span style="color:${color};font-weight:600">
                                    ${pct.toFixed(2)} %
                                    </span>`;
                                }
                            }
                        ],

                        order: [[9, "desc"]] // sort by % Visited
                    });
                },

                error: function (xhr) {
                    console.error("AJAX Error for " + headerText + ":", xhr.responseText);

                    showLoadingMessage(
                        tableSelector,
                        'Error loading data. Check API status (Status: ' + xhr.status + ')',
                        true,
                        colspan
                    );
                }
            });

        }

        // Overrides the existing one to allow non-table messages
        function showLoadingMessage(targetSelector, message, isTable = false, colspan = 8) {

            if (isTable) {
                // Logic for data table (uses custom HTML messaging)
                const $tbody = $(targetSelector + " tbody");
                const color = message.includes("Error") ? "#D32F2F" : "#455A64";
                $tbody.html(`
                    <tr>
                        <td colspan="${colspan}" 
                            style="text-align:center; padding:15px; color:${color}; font-weight:600;">
                            ${message}
                        </td>
                    </tr>
                `);
            } else {
                // Logic for regular chart containers (used before Plotly renders)
                $(targetSelector).html('<div style="text-align:center; padding: 20px; color: #888;">' + message + '</div>');
            }
        }

        // --- Execute All Chart Rendering on Page Load ---
        window.onload = function () {
            renderOverallCoverage();
            renderZoneWiseSplit();
            renderWardWiseSplit();
            // Tables
            renderCTPTTable();
        };

    </script>
</body>
        </div>
</asp:Content>