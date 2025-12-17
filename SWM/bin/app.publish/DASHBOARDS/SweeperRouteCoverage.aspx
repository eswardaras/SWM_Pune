<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SweeperRouteCoverage.aspx.cs" Inherits="SweeperRouteCoverage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card-sub-container">

    <title>Sweeper Route Coverage Report</title>
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <link rel="stylesheet"
          href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css" />

    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>

    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>

    <style>
        /* --- BASE & GLOBAL STYLES --- */
        :root {
            /* Theme Colors */
            --primary-dark: #1a3a66; /* Dark Blue */
            --primary-light: #4a63b9; /* Medium Blue */
            --accent-green: #06923E; /* Filter Label Green */
            --card-background: #FFFFFF;
            --text-dark: #333;
            --text-light: #FFFFFF;
            --sidebar-color-active: #003366;
            --sidebar-accent: #00BCD4; /* Light Blue/Cyan */
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to bottom right, var(--primary-light), var(--primary-dark));
            color: var(--text-light);
            margin: 0;
            padding: 0;
            min-height: 100vh;
            /*display: flex;*/ /* Enables sidebar layout */
            overflow-x: hidden;
        }

        /* -------------------------------------
         * --- SIDEBAR STYLES ---
         * ------------------------------------- */
        /*.sidebar {
            width: 250px;
            background-color: var(--card-background);
            color: var(--text-dark);
            padding-top: 20px;
            box-shadow: 2px 0 10px rgba(0, 0, 0, 0.4);
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            z-index: 1000;
            transform: translateX(0);
            transition: transform 0.3s ease-in-out;
            overflow-y: auto;
        }

            .sidebar a {
                padding: 15px 20px;
                text-decoration: none;
                font-size: 15px;
                color: var(--text-dark);
                display: block;
                transition: background-color 0.3s, color 0.3s, border-left 0.3s;
            }

                .sidebar a:hover, .sidebar .active-link {
                    background-color: var(--sidebar-color-active);
                    color: var(--text-light);
                    border-left: 5px solid var(--sidebar-accent);
                }
*/
        /* -------------------------------------
         * --- MAIN CONTENT ADJUSTMENTS ---
         * ------------------------------------- */
        .main-content {
            /*margin-left: 250px;*/
            width: 100%;
            display: grid;
            grid-template-rows: auto auto 1fr; /* Header | Filters | Content Grid */
            grid-template-columns: 1fr;
            min-height: 100vh;
            transition: margin-left 0.3s ease-in-out, width 0.3s ease-in-out;
        }

        /* Header */
        .header {
            background-color: rgba(0, 0, 0, 0.2);
            padding: 15px 20px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            grid-row: 1;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header-title {
            font-size: 28px;
            font-weight: bold;
            margin: 0;
        }

        .menu-toggle {
            display: none;
            font-size: 24px;
            cursor: pointer;
            padding: 5px 10px;
            color: var(--text-light);
        }

        /* --- FILTER SECTION: 4-column grid --- */
        .filter-bar {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); /* Use auto-fit for better responsiveness */
            gap: 15px;
            padding: 15px 20px;
            background-color: transparent;
            grid-row: 2;
            align-items: flex-end; /* Align select boxes to the bottom */
        }

            .filter-bar select {
                width: 100%;
                padding: 10px 12px;
                border-radius: 4px;
                background-color: var(--card-background);
                color: var(--text-dark);
                font-size: 14px;
                border: 1px solid #c0c0c0;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            }

            .filter-bar .filter-group {
                display: flex;
                flex-direction: column;
                min-width: 0; /* Fixes potential flex/grid overflow issue */
            }

                .filter-bar .filter-group label {
                    font-weight: bold;
                    color: var(--accent-green);
                    font-size: 14px;
                    display: block;
                    margin-bottom: 5px;
                    text-align: left;
                }

        /* --- DASHBOARD CONTENT CONTAINER (Charts & Tables) --- */
        .dashboard-content {
            padding: 20px;
            grid-row: 3;
            overflow-y: auto;
            /* Inner Grid for Charts and Tables: 3 columns */
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px; /* Increased gap for visual separation */
            align-content: start; /* Prevents stretching */
        }

        /* --- Card Styles --- */
        .chart-card, .table-card {
            background: var(--card-background);
            border-radius: 10px;
            color: var(--text-dark);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2); /* Stronger shadow */
            padding: 15px;
            display: flex;
            flex-direction: column;
            overflow: hidden; /* For table container's scrollbar */
            position: relative; /* IMPORTANT for loader centering */
        }

        .chart-card {
            height: 380px; /* Adjusted height for better chart fit */
            padding-bottom: 5px;
        }

        .title {
            text-align: center;
            font-size: 17px;
            font-weight: 600;
            padding-bottom: 10px;
            border-bottom: 1px solid #e0e0e0;
            margin-bottom: 10px;
            color: var(--sidebar-color-active);
        }

        .plotly-chart-container { /* Renamed for clarity in JS */
            flex-grow: 1;
            min-height: 250px;
            /* Ensure chart area is visible when loader is hidden */
            visibility: hidden; 
        }

        /* --- Table Card Styles (Spanning all 3 columns) --- */
        .table-card {
            grid-column: 1 / span 3;
            padding: 0;
            min-height: 300px;
        }

        .table-header {
            font-size: 18px;
            font-weight: bold;
            padding: 15px;
            color: var(--sidebar-color-active);
            border-bottom: 1px solid #eee;
        }

        .data-table-container {
            overflow-x: auto; /* Scroll for the table content only */
            padding: 0 15px 15px 15px;
        }
        
        .data-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 13px;
        }

            .data-table th, .data-table td {
                padding: 12px 15px;
                border-bottom: 1px solid #eee;
                text-align: left;
                white-space: nowrap;
            }

            .data-table thead th {
                background-color: var(--primary-light);
                font-weight: 600;
                color: var(--text-light);
                text-transform: uppercase;
                position: sticky;
                top: 0;
                z-index: 10;
            }
            /* Styling for the loading/error message in the table */
            .data-table tbody td.text-center {
                text-align: center;
                padding: 20px;
                color: #888;
            }
            
            /* Custom Legend for Overall Coverage Chart */
            .custom-legend {
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
                gap: 10px 15px;
                padding: 5px 10px;
                font-size: 12px;
                color: #666;
            }

                .custom-legend span {
                    display: flex;
                    align-items: center;
                }

                .custom-legend .color-box {
                    width: 12px;
                    height: 12px;
                    border-radius: 3px;
                    margin-right: 5px;
                }


        /* --- Responsive Adjustments --- */
        @media (max-width: 1024px) {
            .sidebar {
                transform: translateX(-100%);
            }

                .sidebar.open {
                    transform: translateX(0);
                }

            .main-content {
                margin-left: 0;
                width: 100%;
            }

            .menu-toggle {
                display: block;
            }

            .dashboard-content {
                grid-template-columns: repeat(2, 1fr);
            }

            .chart-card:nth-child(3) {
                grid-column: 1 / span 2;
            }

            .table-card {
                grid-column: 1 / span 2;
            }
        }

        @media (max-width: 768px) {
            .dashboard-content {
                grid-template-columns: 1fr;
            }

            .chart-card, .table-card {
                grid-column: 1;
                min-height: 350px;
            }

                .chart-card:nth-child(3) {
                    grid-column: 1;
                }
        }

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


<body>
    <div id="form1" >

        <div id="mySidebar" class="sidebar">
            <a href="#" class="active-link">Dashboard Overview</a>
            <a href="#">Attendance Details</a>
            <a href="#">Zone Summary</a>
            <a href="#">Ward Performance</a>
            <a href="#">Reports</a>
        </div>

        <div class="main-content" id="mainContent">
            <div class="header">
                <div class="menu-toggle" onclick="toggleSidebar()">&#9776;</div>
                <div class="header-title">Sweeper Route Coverage Report</div>
                <div class="header-info">Date: 2023-12-12</div>
            </div>

            <div class="filter-bar">
                <div class="filter-group">
                    <label for="selectZone">Zone</label>
                    <select id="selectZone"><option value="all">Select Zone</option></select>
                </div>
                <div class="filter-group">
                    <label for="selectWard">Ward</label>
                    <select id="selectWard"><option value="all">Select Ward</option></select>
                </div>
                <div class="filter-group">
                    <label for="selectKothi">Kothi</label>
                    <select id="selectKothi"><option value="all">Select Kothi</option></select>
                </div>
                <div class="filter-group">
                    <label for="selectSupervisor">Supervisor</label>
                    <select id="selectSupervisor"><option value="all">Select Supervisor</option></select>
                </div>
            </div>

            <div class="dashboard-content">

                <div class="chart-card">
                    <div class="chart-loader"></div>
                    <div id="sweeperAttendanceChart" class="plotly-chart-container"></div>
                    <div class="custom-legend">
                        <span><div class="color-box" style="background-color: #5B7CFA;"></div>Present</span>
                        <span><div class="color-box" style="background-color: #FF7043;"></div>Absent</span>
                        <span><div class="color-box" style="background-color: #26A69A;"></div>Leave</span>
                    </div>
                </div>

                <div class="chart-card">
                    <div class="chart-loader"></div>
                    <div id="sweeperAttandanceZoneWise" class="plotly-chart-container"></div>
                </div>

                <div class="chart-card">
                    <div class="chart-loader"></div>
                    <div id="sweeperAttendanceChartWardWise" class="plotly-chart-container"></div>
                </div>

                <div class="table-card">
                    <div class="table-header">
                        Top 10 Sweepers with Highest Route Distance Coverage
                    </div>
                    <div class="data-table-container">
                        <table id="GridTopSweeper" class="display data-table">
                            <thead>
                                <tr>
                                    <th>Sweeper Name</th>
                                    <th>Zone</th>
                                    <th>Ward</th>
                                    <th>Kothi</th>
                                    <th>Date</th>
                                    <th>Total Distance (M)</th>
                                    <th>Covered Distance (M)</th>
                                    <th>Covered %</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr><td colspan="8" class="text-center">Loading data...</td></tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="table-card">
                    <div class="table-header">
                        Bottom 10 Sweepers with Lowest Route Distance Coverage
                    </div>
                    <div class="data-table-container">
                        <table id="GridBottomSweeper" class="display data-table">
                            <thead>
                                <tr>
                                    <th>Sweeper Name</th>
                                    <th>Zone</th>
                                    <th>Ward</th>
                                    <th>Kothi</th>
                                    <th>Date</th>
                                    <th>Total Distance (M)</th>
                                    <th>Covered Distance (M)</th>
                                    <th>Covered %</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr><td colspan="8" class="text-center">Loading data...</td></tr>
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>
        </div>

        <script>
            // --- LOADER TOGGLE FUNCTION (Controls the visible charts) ---
            function toggleLoader(chartId, show) {
                const chartDiv = document.getElementById(chartId);
                // Locate the nearest parent container for the loader (.chart-card, .box, or .dashboard-chart)
                const cardElement = chartDiv ? chartDiv.closest('.chart-card, .box, .dashboard-chart') : null;
                if (!cardElement) return;

                const loader = cardElement.querySelector('.chart-loader');

                if (loader) {
                    loader.style.display = show ? 'block' : 'none';

                    // Toggle visibility of the actual chart container
                    chartDiv.style.visibility = show ? 'hidden' : 'visible';
                }
            }
            // ----------------------------------------

            // --- UI/UX Helper Function ---
            function toggleSidebar() {
                const sidebar = document.getElementById('mySidebar');
                sidebar.classList.toggle('open');
            }

            // --- UTILITY FUNCTIONS ---

            // Helper function to format date (needed for tables)
            const formatDate = (dateString) => {
                try {
                    if (!dateString) return "";
                    // Attempt to parse various date strings
                    const date = new Date(dateString);
                    if (isNaN(date)) return dateString; // Return original if invalid date
                    const year = date.getFullYear();
                    const month = String(date.getMonth() + 1).padStart(2, '0');
                    const day = String(date.getDate()).padStart(2, '0');
                    return `${year}-${month}-${day}`;
                } catch (e) {
                    return dateString;
                }
            };

            // Helper function to display loading or error messages in containers
            function showLoadingMessage(targetSelector, message, isTable = true, colspan = 8) {
                const isError = message.toLowerCase().includes("error");

                if (isTable) {
                    // Handle DataTable: Destroy existing instance first
                    if ($.fn.DataTable.isDataTable(targetSelector)) {
                        $(targetSelector).DataTable().clear().destroy();
                    }
                    const color = isError ? "red" : "#888";
                    $(targetSelector).find('tbody').html(`<tr><td colspan="${colspan}" class="text-center" style="color: ${color};">${message}</td></tr>`);
                } else {
                    // Handle Plotly container (simple message)
                    const color = isError ? "red" : "#888";
                    $(targetSelector).html(`<div style="text-align:center; padding: 20px; color: ${color};">${message}</div>`);
                    // Ensure the loader is hidden if we are showing a permanent message
                    if (isError) {
                        const chartId = targetSelector.replace('#', '');
                        toggleLoader(chartId, false);
                    }
                }
            }


            // --- COLOR CONSTANTS (Centralized and adapted for Plotly) ---
            const PLOTLY_COLORS = {
                // Overall Coverage (SWCoverage)
                OVERALL_COVERAGE: ["#5B7CFA", "#FF7043", "#26A69A"],

                // Zone Wise Sunburst Inner Ring
                ZONE_WISE_INNER: ["#5B7CFA", "#26A69A", "#FF7043", "#FBC02D", "#9575CD"],

                // Ward Wise Sunburst Inner Ring (more colors for more wards)
                WARD_WISE_INNER: ["#5B7CFA", "#26A69A", "#FF7043", "#FBC02D", "#9575CD", "#4DD0E1", "#AED581", "#FF8A65", "#90CAF9", "#CE93D8"],

                // Sunburst Outer Ring Coverage ranges
                COVERAGE_OUTER: {
                    "0-30%": "#FF9F9B",    // Light Red
                    "31-70%": "#FFD166",   // Light Orange
                    "71-100%": "#6ED0B5"   // Light Teal/Green
                }
            };


            /* ---------------------- CHART 1: Overall Coverage (Donut) ---------------------- */
            function renderOverallCoverage() {
                const url = "http://localhost:75/api/SWCoverage";
                const targetId = 'sweeperAttendanceChart';

                toggleLoader(targetId, true);

                $.ajax({
                    type: "GET",
                    url: url,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (apiData) {
                        toggleLoader(targetId, false);

                        if (!apiData || !apiData.datasets || apiData.datasets.length === 0) {
                            showLoadingMessage('#' + targetId, 'No chart data available.', false);
                            return;
                        }

                        var values = apiData.datasets[0].data;
                        var total = values.reduce((a, b) => a + b, 0);

                        var plotlyData = [{
                            labels: apiData.labels,
                            values: values,
                            type: "pie",
                            hole: 0.5,
                            textinfo: "percent",
                            insidetextorientation: "radial",
                            marker: {
                                colors: PLOTLY_COLORS.OVERALL_COVERAGE
                            },
                            showlegend: false
                        }];

                        var layout = {
                            title: {
                                text: "<b>SW Coverage (On Route)</b> (Total: " + total + ")",
                                font: { size: 14, color: '#003366' }
                            },
                            height: 350,
                            margin: { l: 20, r: 20, t: 50, b: 20 },
                            annotations: [{
                                font: { size: 18, color: '#000000' },
                                showarrow: false,
                                text: total.toString(),
                                x: 0.5,
                                y: 0.5
                            }],
                            plot_bgcolor: '#FFFFFF',
                            paper_bgcolor: '#FFFFFF'
                        };

                        Plotly.react(
                            targetId,
                            plotlyData,
                            layout,
                            { responsive: true, displayModeBar: false }
                        );
                    },
                    error: function (xhr) {
                        toggleLoader(targetId, false);
                        console.error("AJAX error for Overall Coverage:", xhr.responseText);
                        showLoadingMessage('#' + targetId, 'Error loading chart. Check API status (Status: ' + xhr.status + ')', false);
                    }
                });
            }





            /* ---------------------- CHART 2: Zone Wise Coverage (Sunburst) ---------------------- */
            function renderZoneWiseCoverage() {
                const url = "http://localhost:75/api/SweeperCoverageZoneWise";
                const targetId = 'sweeperAttandanceZoneWise';

                toggleLoader(targetId, true);

                $.ajax({
                    type: "GET",
                    url: url,
                    dataType: "json",
                    success: function (res) {
                        toggleLoader(targetId, false);

                        if (!res || !res.zones || res.zones.length === 0) {
                            showLoadingMessage('#' + targetId, 'No chart data available.', false);
                            return;
                        }

                        var labels = [];
                        var parents = [];
                        var values = [];
                        var text = [];
                        var colors = [];

                        const grandTotal = res.zones.reduce((sum, zone) => sum + zone.total, 0);

                        res.zones.forEach(function (zone_data, zi) {

                            var zoneName = 'Zone ' + zone_data.zone;
                            var zoneTotal = zone_data.total;
                            var zonePercent = Math.round((zoneTotal / grandTotal) * 100);

                            // 🔸 INNER RING (ZONE)
                            labels.push(zoneName.toString());
                            parents.push("");
                            values.push(zoneTotal);
                            text.push('<b>' + zoneName + '</b><br>' + zonePercent + '%');
                            colors.push(PLOTLY_COLORS.ZONE_WISE_INNER[zi % PLOTLY_COLORS.ZONE_WISE_INNER.length]);

                            // 🔸 OUTER RING (COVERAGE BUCKETS)
                            zone_data.buckets.forEach(function (bucket) {

                                var range = bucket.range;
                                var val = bucket.count;
                                var pct = (zoneTotal > 0) ? Math.round((val / zoneTotal) * 100) : 0;

                                labels.push(range + ' - ' + zoneName); // Unique label for Plotly
                                parents.push(zoneName.toString());
                                values.push(val);
                                text.push(range + "<br>" + pct + "%");
                                colors.push(PLOTLY_COLORS.COVERAGE_OUTER[range] || '#888888');
                            });
                        });

                        var data = [{
                            type: "sunburst",
                            labels: labels,
                            parents: parents,
                            values: values,
                            text: text,
                            textinfo: "text",
                            hoverinfo: 'text+value',
                            insidetextorientation: "radial",
                            branchvalues: "total",
                            sort: false,
                            maxdepth: 2,
                            marker: { colors: colors, line: { width: 1, color: "#ffffff" } }
                        }];

                        var layout = {
                            title: {
                                text: "<b>Sweeper Coverage Zone Wise</b> (Total: " + grandTotal + ")",
                                font: { size: 14, color: '#003366' }
                            },
                            height: 350,
                            margin: { t: 50, l: 10, r: 10, b: 10 },
                            plot_bgcolor: '#FFFFFF',
                            paper_bgcolor: '#FFFFFF'
                        };

                        Plotly.react(targetId, data, layout, { responsive: true, displayModeBar: false });
                    },
                    error: function (xhr) {
                        toggleLoader(targetId, false);
                        console.error("AJAX Error for Zone Wise Chart:", xhr.responseText);
                        showLoadingMessage('#' + targetId, 'Error loading chart. Check API status (Status: ' + xhr.status + ')', false);
                    }
                });
            }


            /* ---------------------- CHART 3: Ward Wise Coverage (Sunburst) ---------------------- */
            function renderWardWiseCoverage() {
                const url = "http://localhost:75/api/SweeperCoverageWardWise";
                const targetId = 'sweeperAttendanceChartWardWise';

                toggleLoader(targetId, true);

                $.ajax({
                    type: "GET",
                    url: url,
                    dataType: "json",
                    success: function (res) {
                        toggleLoader(targetId, false);

                        if (!res || !res.dataset || res.dataset.length === 0) {
                            showLoadingMessage('#' + targetId, 'No chart data available.', false);
                            return;
                        }

                        var labels = [];
                        var parents = [];
                        var values = [];
                        var text = [];
                        var colors = [];
                        var grandTotal = 0;

                        res.dataset.forEach(function (wardObj, wi) {
                            var wardName = wardObj.label || 'Ward ' + (wi + 1);
                            var wardTotal = wardObj.data.reduce((a, b) => a + b, 0);
                            grandTotal += wardTotal;

                            // ---------- INNER RING (Ward) ----------
                            labels.push(wardName);
                            parents.push("");
                            values.push(wardTotal);
                            text.push('<b>' + wardName + '</b><br>' + wardTotal + ' Total');
                            colors.push(PLOTLY_COLORS.WARD_WISE_INNER[wi % PLOTLY_COLORS.WARD_WISE_INNER.length]);

                            // ---------- OUTER RING (Coverage Buckets) ----------
                            res.labels.forEach(function (range, ri) {

                                var val = wardObj.data[ri];
                                if (val === 0) return;

                                var pct = (wardTotal > 0) ? Math.round((val / wardTotal) * 100) : 0;

                                labels.push(range + ' - ' + wardName);
                                parents.push(wardName);
                                values.push(val);
                                text.push(range + "<br>" + pct + "%");
                                colors.push(PLOTLY_COLORS.COVERAGE_OUTER[range] || '#888888');
                            });
                        });

                        Plotly.react(
                            targetId,
                            [{
                                type: "sunburst",
                                labels: labels,
                                parents: parents,
                                values: values,
                                text: text,
                                textinfo: "text",
                                hoverinfo: 'text+value',
                                insidetextorientation: "radial",
                                branchvalues: "total",
                                sort: false,
                                maxdepth: 2,
                                marker: {
                                    colors: colors,
                                    line: { width: 1, color: "#ffffff" }
                                }
                            }],
                            {
                                title: {
                                    text: "<b>Sweeper Coverage Ward Wise</b> (Total: " + grandTotal + ")",
                                    font: { size: 14, color: '#003366' }
                                },
                                height: 350,
                                margin: { t: 50, l: 10, r: 10, b: 10 },
                                plot_bgcolor: '#FFFFFF',
                                paper_bgcolor: '#FFFFFF'
                            },
                            { responsive: true, displayModeBar: false }
                        );
                    },
                    error: function (xhr) {
                        toggleLoader(targetId, false);
                        console.error("AJAX Error for Ward Wise Chart:", xhr.responseText);
                        showLoadingMessage('#' + targetId, 'Error loading chart. Check API status (Status: ' + xhr.status + ')', false);
                    }
                });
            }


            /* ---------------------- TABLE 1: Top 10 Sweepers ---------------------- */
            function renderTop10Table() {
                const tableSelector = "#GridTopSweeper";
                const apiUrl = "http://localhost:75/api/Top10Sweepers";
                const headerText = "Top 10 Sweepers";
                const colspan = 8;

                showLoadingMessage(tableSelector, 'Loading ' + headerText + ' data...', true, colspan);

                $.ajax({
                    url: apiUrl,
                    type: "GET",
                    dataType: "json",
                    success: function (data) {

                        if (!Array.isArray(data) || data.length === 0) {
                            showLoadingMessage(tableSelector, 'No ' + headerText + ' data available.', true, colspan);
                            return;
                        }

                        // Destroy existing table
                        if ($.fn.DataTable.isDataTable(tableSelector)) {
                            $(tableSelector).DataTable().clear().destroy();
                        }

                        $(tableSelector).DataTable({
                            data: data,
                            paging: false,
                            searching: false,
                            ordering: true,
                            info: false,
                            autoWidth: false,
                            scrollX: true,
                            columns: [
                                { data: "SweeperName" },
                                { data: "Zone" },
                                { data: "Ward" },
                                { data: "Kothi" },
                                {
                                    data: "Date",
                                    render: function (d) { return formatDate(d); }
                                },
                                {
                                    data: "TotalDistanceInMeter",
                                    className: "text-right" // Align distance numbers
                                },
                                {
                                    data: "CoveredDistance",
                                    className: "text-right" // Align distance numbers
                                },
                                {
                                    data: "CoveredPercentage",
                                    type: "num-fmt",
                                    className: "text-right", // Align percentage numbers
                                    render: function (d) {
                                        const coveredPct = parseFloat(d);
                                        return isNaN(coveredPct) ? "N/A" : coveredPct.toFixed(2) + " %";
                                    }
                                }
                            ]
                        });
                    },
                    error: function (xhr) {
                        console.error("AJAX Error for " + headerText + ":", xhr.responseText);
                        showLoadingMessage(tableSelector, 'Error loading data. Check API status (Status: ' + xhr.status + ')', true, colspan);
                    }
                });
            }


            /* ---------------------- TABLE 2: Bottom 10 Sweepers ---------------------- */
            function renderBottom10Table() {
                const tableSelector = "#GridBottomSweeper";
                const apiUrl = "http://localhost:75/api/Bottom10Sweepers";
                const headerText = "Bottom 10 Sweepers";
                const colspan = 8;

                showLoadingMessage(tableSelector, 'Loading ' + headerText + ' data...', true, colspan);

                $.ajax({
                    url: apiUrl,
                    type: "GET",
                    dataType: "json",
                    success: function (data) {

                        if (!Array.isArray(data) || data.length === 0) {
                            showLoadingMessage(tableSelector, 'No ' + headerText + ' data available.', true, colspan);
                            return;
                        }

                        // Destroy existing table instance using the correct ID before re-initialization
                        if ($.fn.DataTable.isDataTable(tableSelector)) {
                            $(tableSelector).DataTable().clear().destroy();
                        }

                        $(tableSelector).DataTable({
                            data: data,
                            paging: false,
                            searching: false,
                            ordering: true,
                            info: false,
                            autoWidth: false,
                            scrollX: true,
                            columns: [
                                { data: "SweeperName" },
                                { data: "Zone" },
                                { data: "Ward" },
                                { data: "Kothi" },
                                {
                                    data: "Date",
                                    render: function (d) { return formatDate(d); }
                                },
                                {
                                    data: "TotalDistanceInMeter",
                                    className: "text-right"
                                },
                                {
                                    data: "CoveredDistance",
                                    className: "text-right"
                                },
                                {
                                    data: "CoveredPercentage",
                                    type: "num-fmt",
                                    className: "text-right",
                                    render: function (d) {
                                        const coveredPct = parseFloat(d);
                                        return isNaN(coveredPct) ? "N/A" : coveredPct.toFixed(2) + " %";
                                    }
                                }
                            ]
                        });
                    },
                    error: function (xhr) {
                        console.error("AJAX Error for " + headerText + ":", xhr.responseText);
                        showLoadingMessage(tableSelector, 'Error loading data. Check API status (Status: ' + xhr.status + ')', true, colspan);
                    }
                });
            }


            // --- MAIN EXECUTION ---
            function loadData() {
                // Charts
                renderOverallCoverage();
                renderZoneWiseCoverage();
                renderWardWiseCoverage();

                // Tables
                renderTop10Table();
                renderBottom10Table();
            }

            $(document).ready(function () {
                loadData();
            });
        </script>
    </div>
</body>
        </div>
</asp:Content>