<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard_MKD_SWM.aspx.cs" Inherits="SWM.Dashboard_MKD_SWM" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card-sub-container">

    <title>Mokadam Attendance Dashboard</title>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.plot.ly/plotly-2.30.0.min.js"></script>

    <style>
        /* --- Base & Background Styles (Matching Feeder/Mokadam UI) --- */
        body {
            font-family: Arial, sans-serif;
            /* Gradient from light blue (top-left) to dark blue (bottom-right) */
            background: linear-gradient(to bottom right, #3f51b5, #003366);
            color: #FFFFFF;
            margin: 0;
            padding: 0;
            overflow-x: hidden;
            min-height: 100vh;
        }

        /* -------------------------------------
         * --- NEW SIDEBAR STYLES ---
         * ------------------------------------- */
        /*.sidebar {
            width: 250px;
            background-color: #fff;
            color: #000;
            padding-top: 20px;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.5);
            height: 100vh;
            position: fixed;*/ /* Fixed position */
            /*top: 0;
            left: 0;
            z-index: 1000;
            transform: translateX(0);
            transition: transform 0.3s ease-in-out;
            overflow-y: auto;
        }

        .sidebar a {
            padding: 15px 20px;
            text-decoration: none;
            font-size: 14px;
            color: #000;
            display: block;
            transition: background-color 0.3s;
        }

        .sidebar a:hover, .sidebar .active-link {
            background-color: #1a5e9f;
            color: #fff;
            border-left: 5px solid #00BCD4;
        }*/

        /* -------------------------------------
         * --- MAIN CONTENT ADJUSTMENTS ---
         * ------------------------------------- */
        .main-content {
            /*margin-left: 250px;*/ /* Offset for the fixed sidebar width */
            padding: 0;
            width: 100%; /* Adjust width */
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

        /* --- Filter Bar Styling (4-Column Grid for Mokadam Page) --- */
        .filter-bar {
            /* Use Grid to enforce four equal columns for filters */
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
            color: #06923E; /* Green text matching screenshot label color */
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

        .filter-group {
            display: block;
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
        .chart-card {
            background-color: #FFFFFF;
            color: #000;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
            /* Set fixed height 300px for better visualization of circular charts */
            height: 300px;
            min-height: 250px;
            display: flex;
            flex-direction: column;
            position: relative; /* IMPORTANT for loader positioning */
        }
        .plotly-chart {
            flex-grow: 1;
            /* Increased min-height for better chart visibility */
            min-height: 280px;
        }

        /* --- Responsive Adjustments --- */
        @media (max-width: 1200px) {
            .grid-3-col {
                grid-template-columns: repeat(2, 1fr);
            }
            .filter-bar {
                grid-template-columns: repeat(2, 1fr);
            }
        }
        @media (max-width: 1024px) {
            /* Sidebar hidden by default on small screens */
            .sidebar {
                transform: translateX(-100%);
                width: 50%;
                max-width: 250px;
            }
            .sidebar.open {
                transform: translateX(0);
            }
            /* Main content takes full width when sidebar is hidden/off-screen */
            .main-content {
                margin-left: 0;
                width: 100%;
            }
        }
        @media (max-width: 768px) {
            .filter-bar {
                grid-template-columns: 1fr;
            }
            .grid-3-col {
                grid-template-columns: 1fr;
            }
            .chart-card {
                min-height: 350px;
                height: auto;
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
            <a href="#">Kothi Status</a>
            <a href="#">Reports</a>
        </div>

        <div class="main-content">
            <div class="header-bar">
                <h1>Mokadam Attendance Dashboard</h1>
                <div class="header-date">12/12/2025</div>
            </div>

            <div class="dashboard-container">

                <div class="filter-bar">

                    <div class="filter-group">
                        <label for="selectZone"> Zone</label>
                        <select id="selectZone">
                            <option value="all">Select Zone (leave blank to include all)</option>
                            <option value="zone1">Zone 1</option>
                            <option value="zone2">Zone 2</option>
                        </select>
                    </div>

                    <div class="filter-group">
                        <label for="selectWard"> Ward</label>
                        <select id="selectWard">
                            <option value="all">Select Ward (leave blank to include all)</option>
                            <option value="wardA">Ward A</option>
                            <option value="wardB">Ward B</option>
                        </select>
                    </div>

                    <div class="filter-group">
                        <label for="selectKothi"> Kothi</label>
                        <select id="selectKothi">
                            <option value="all">Select Kothi (leave blank to include all)</option>
                            <option value="kothiA">Kothi A</option>
                            <option value="kothiB">Kothi B</option>
                        </select>
                    </div>

                    <div class="filter-group">
                        <label for="selectMokadam"> Mokadam</label>
                        <select id="selectMokadam">
                            <option value="all">Select Mokadam (leave blank to include all)</option>
                            <option value="mokadam1">Mokadam 1</option>
                            <option value="mokadam2">Mokadam 2</option>
                        </select>
                    </div>
                </div>
                <div class="grid-3-col">
                    <div class="chart-card">
                         <div class="chart-loader"></div>
                        <div id="mokadamOverallChart" class="plotly-chart"></div>
                    </div>

                    <div class="chart-card">
                        <div class="chart-loader"></div>
                        <div id="mokadamZoneWiseChart" class="plotly-chart"></div>
                    </div>

                    <div class="chart-card">
                        <div class="chart-loader"></div>
                        <div id="mokadamWardWiseChart" class="plotly-chart"></div>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <script type="text/javascript">

        const CHART_INNER_HEIGHT = 260;

        // --- LOADER TOGGLE FUNCTION ---
        function toggleLoader(chartId, show) {
            const chartDiv = document.getElementById(chartId);
            // Locate the parent .chart-card or #top40SummaryChart
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
                // Increased margin for general chart safety
                margin: { l: 25, r: 25, t: 25, b: 25 }
            };
        }

        // --- 1. Mokadam Attendance Overall (Doughnut) ---
        function renderMokadamOverall() {
            const chartId = 'mokadamOverallChart';
            toggleLoader(chartId, true); // Show loader

            $.ajax({
                type: "GET",
                url: "http://localhost:75/api/MokadamAttendence",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (apiData) {
                    toggleLoader(chartId, false); // Hide loader on success

                    // ✅ Read correct API structure
                    var labels = apiData.labels;
                    var values = apiData.datasets[0].data;
                    var colors = apiData.datasets[0].backgroundColor;
                    var total = apiData.total;

                    // ✅ Plotly Donut Chart
                    var plotlyData = [{
                        labels: labels,
                        values: values,
                        type: "pie",
                        hole: 0.4,
                        marker: {
                            colors: colors
                        },
                        textinfo: "label+percent",
                        insidetextorientation: "radial"
                    }];

                    // ✅ Layout
                    var layout = getBaseLayout('Mokadam Attendance (Total: ' + total + ')');
                    layout.showlegend = true;
                    layout.margin = { l: 20, r: 120, t: 60, b: 20 };

                    // ✅ Center text (optional)
                    layout.annotations = [{
                        font: { size: 22, color: '#000000' },
                        showarrow: false,
                        text: total,
                        x: 0.5,
                        y: 0.5
                    }];

                    Plotly.newPlot(
                        chartId,
                        plotlyData,
                        layout,
                        { responsive: true, displayModeBar: false }
                    );
                },
                error: function (xhr) {
                    console.log("AJAX error:", xhr.responseText);
                    toggleLoader(chartId, false); // Hide loader on error
                }
            });


        }

        // --- 2. Mokadam Attendance Zone Wise (Sunburst - Multi-Level) ---
        function renderMokadamZoneWise() {
            const chartId = 'mokadamZoneWiseChart';
            toggleLoader(chartId, true); // Show loader

            // Data structure approximated from the complex image_d6ad02.png style
            $.ajax({
                type: "GET",
                url: "http://localhost:75/api/MokadamAttendanceZoneWise",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (apiData) {
                    toggleLoader(chartId, false); // Hide loader on success

                    var labels = [];
                    var parents = [];
                    var values = [];
                    var colors = [];

                    var zoneColors = ["#C62828", "#1565C0", "#F9A825", "#2E7D32", "#00695C"];
                    var absentColor = "#80CBC4";
                    var presentColor = "#FFE082";

                    // ---------- INNER RING (Zones) ----------
                    apiData.zones.forEach(function (zone, i) {

                        var zoneTotal =
                            apiData.datasets[0].data[i] +
                            apiData.datasets[1].data[i];

                        labels.push("Zone " + zone);
                        parents.push("");
                        values.push(zoneTotal);
                        colors.push(zoneColors[i % zoneColors.length]);
                    });

                    // ---------- OUTER RING (Attendance) ----------
                    apiData.zones.forEach(function (zone, i) {

                        // ABSENT
                        labels.push("ABSENT");
                        parents.push("Zone " + zone);
                        values.push(apiData.datasets[0].data[i]);
                        colors.push(absentColor);

                        // PRESENT
                        labels.push("PRESENT");
                        parents.push("Zone " + zone);
                        values.push(apiData.datasets[1].data[i]);
                        colors.push(presentColor);
                    });

                    var plotlyData = [{
                        type: "sunburst",
                        labels: labels,
                        parents: parents,
                        values: values,
                        branchvalues: "total",
                        marker: { colors: colors },
                        textinfo: "label+percent parent"
                    }];

                    var layout = getBaseLayout(
                        "Mokadam Attendance Zone Wise (Total: " + apiData.total + ")"
                    );

                    layout.margin = { l: 10, r: 10, t: 60, b: 10 };

                    Plotly.newPlot(
                        chartId,
                        plotlyData,
                        layout,
                        { responsive: true, displayModeBar: false }
                    );
                },
                error: function (xhr) {
                    console.log("AJAX error:", xhr.responseText);
                    toggleLoader(chartId, false); // Hide loader on error
                }
            });



        }

        // --- 3. Mokadam Attendance Ward Wise (Sunburst - Multi-Level) ---
        function renderMokadamWardWise() {
            const chartId = 'mokadamWardWiseChart';
            toggleLoader(chartId, true); // Show loader

            // Highly detailed pie chart is approximated with many small slices
            $.ajax({
                type: "GET",
                url: "http://localhost:75/api/MokadamAttendanceWardWise",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (apiData) {
                    toggleLoader(chartId, false); // Hide loader on success

                    var labels = [];
                    var parents = [];
                    var values = [];
                    var colors = [];

                    var wardColors = [
                        "#C62828", "#1565C0", "#F9A825",
                        "#2E7D32", "#6A1B9A", "#00838F",
                        "#EF6C00", "#455A64"
                    ];

                    var absentColor = "#80CBC4";
                    var presentColor = "#FFE082";

                    // ---------- INNER RING (WARDS) ----------
                    apiData.wards.forEach(function (ward, i) {

                        var wardTotal =
                            apiData.datasets[0].data[i] +
                            apiData.datasets[1].data[i];

                        labels.push(ward);
                        parents.push("");
                        values.push(wardTotal);
                        colors.push(wardColors[i % wardColors.length]);
                    });

                    // ---------- OUTER RING (Attendance) ----------
                    apiData.wards.forEach(function (ward, i) {

                        // ABSENT
                        labels.push("ABSENT");
                        parents.push(ward);
                        values.push(apiData.datasets[0].data[i]);
                        colors.push(absentColor);

                        // PRESENT
                        labels.push("PRESENT");
                        parents.push(ward);
                        values.push(apiData.datasets[1].data[i]);
                        colors.push(presentColor);
                    });

                    var plotlyData = [{
                        type: "sunburst",
                        labels: labels,
                        parents: parents,
                        values: values,
                        branchvalues: "total",
                        textinfo: "label+percent parent",
                        marker: { colors: colors }
                    }];

                    var layout = getBaseLayout(
                        "Mokadam Attendance Ward Wise (Total: " + apiData.total + ")"
                    );

                    layout.margin = { l: 5, r: 5, t: 60, b: 5 };

                    Plotly.newPlot(
                        chartId,
                        plotlyData,
                        layout,
                        { responsive: true, displayModeBar: false }
                    );
                },
                error: function (xhr) {
                    console.log("AJAX error:", xhr.responseText);
                    toggleLoader(chartId, false); // Hide loader on error
                }
            });


        }


        // --- Execute All Chart Rendering on Page Load (and after filters change) ---
        function renderAllCharts() {
            renderMokadamOverall();
            renderMokadamZoneWise();
            renderMokadamWardWise();
        }

        window.onload = function () {
            renderAllCharts();

            // Re-render charts when filter changes (optional, but good practice for dashboards)
            $('#selectZone, #selectWard, #selectKothi, #selectMokadam').on('change', renderAllCharts);
        };

    </script>
</body>
</asp:Content>