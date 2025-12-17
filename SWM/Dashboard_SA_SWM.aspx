<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard_SA_SWM.aspx.cs" Inherits="SWM.Dashboard_SA_SWM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="card-sub-container">

    <title>Sweeper Attendance Dashboard</title>
    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
        /* --- BASE & GLOBAL STYLES --- */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            /* Slightly softer blue gradient */
            background: linear-gradient(to bottom right, #4a63b9, #1a3a66);
            color: #FFFFFF;
            margin: 0;
            padding: 0;
            overflow-x: hidden;
            min-height: 100vh;
        }

        /* -------------------------------------
         * --- SIDEBAR STYLES ---
         * ------------------------------------- */
       /* .sidebar {
            width: 250px;
            background-color: #fff;
            color: #000;
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
            color: #333;
            display: block;
            transition: background-color 0.3s, color 0.3s;
        }

        .sidebar a:hover, .sidebar .active-link {
            background-color: #003366;
            color: #fff;
            border-left: 5px solid #00BCD4;
        }*/

        /* -------------------------------------
         * --- MAIN CONTENT ADJUSTMENTS ---
         * ------------------------------------- */
        .main-content {
            /*margin-left: 250px;*/ /* Offset for the fixed sidebar width */
            width: 100%;
            /* Grid for Header, Filters, and Content Area */
            display: grid;
            grid-template-rows: auto auto 1fr;
            grid-template-columns: 1fr;
            min-height: 100vh;
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
        .header-info {
            font-size: 14px;
            font-weight: normal;
        }
        .menu-toggle {
            display: none; /* Hidden by default */
            font-size: 24px;
            cursor: pointer;
            padding: 5px 10px;
            color: #fff;
        }

        /* --- FILTER SECTION: Transparent/Subtle Background --- */
        .filter-bar {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 15px;
            padding: 15px 10px;
            background-color: transparent; /* Floating effect */
            grid-row: 2;
        }
                .date-picker-wrapper {
    background-color: #3f51b5; 
    color: #FFFFFF;
    padding: 8px 15px;
    border-radius: 6px;
    font-size: 14px;
    font-weight: bold;
    display: inline-flex;
    align-items: center;
    cursor: pointer;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
}
        .filter-bar select {
            width: 100%;
            padding: 8px 12px;
            border-radius: 4px;
            background-color: #fff;
            color: #000;
            font-size: 14px;
            border: 1px solid #c0c0c0; /* Lighter border */
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }
        .filter-bar label {
            font-weight: bold;
            color: #fff;
            font-size: 14px;
            display: block;
            margin-bottom: 5px;
            text-align: center;
        }

        /* --- DASHBOARD CONTENT CONTAINER --- */
        .dashboard-content-container {
            padding: 20px;
            grid-row: 3;
            display: grid;
            /* Defines 3 equal columns for the first row of charts */
            grid-template-columns: repeat(3, 1fr); 
            /* First row: 400px height for boxes, Second row: auto (or specifically for the trend chart) */
            grid-template-rows: 400px auto; 
            gap: 15px; /* Increased gap for better separation */
            overflow-y: auto;
        }

        /* Chart Box Styles: Softer shadows and no borders */
        .box, .dashboard-chart {
            background: #FFFFFF;
            padding: 15px;
            border-radius: 10px;	
            border: none;
            color: #333;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15); /* Stronger shadow */
            display: flex;
            flex-direction: column;
            position: relative; /* IMPORTANT for loader positioning */
        }

        .title {
            text-align: center;
            font-size: 16px;	
            font-weight: 700;
            padding-bottom: 5px;
            
            margin-bottom: 10px;
            color: #000;
        }

        /* Trend Section (Spans all columns on the second row) */
        .dashboard-chart {
            /* Explicitly span all 3 columns */
            grid-column: 1 / span 3; 
            /* Start on the second grid row */
            grid-row: 2; 
            width: 100%;
            height: 450px;
        }

        .chart-area {
            width: 100%;
            height: 400px;
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
            .dashboard-content-container {
                /* Change to 2 columns on medium screens */
                grid-template-columns: repeat(2, 1fr);
            }
            /* The third box (Ward Wise) now spans both columns */
            .box:nth-child(3) {
                grid-column: 1 / span 2;
            }
            /* Ensure trend chart spans both columns */
            .dashboard-chart {
                grid-column: 1 / span 2;
            }
            .filter-bar {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            .filter-bar {
                grid-template-columns: 1fr;
            }
            .dashboard-content-container {
                /* Change to 1 column on small screens */
                grid-template-columns: 1fr;
                /* Adjust to give 4 rows, each 400px (or auto) */
                grid-template-rows: repeat(4, auto); 
                height: auto;
            }
            .box, .dashboard-chart {
                /* All elements now span 1 column */
                grid-column: 1;
                height: 350px;
            }
            .dashboard-chart {
                height: 450px;
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
            <div class="header-bar">
               
                <h1>Sweeper Attendance Dashboard</h1>
                 <div class="date-picker-wrapper"
    onclick="document.getElementById('hiddenDatePicker').showPicker()">

    <%-- Visible date display (DD/MM/YYYY format) --%>
    <span id="dateDisplay">--/--/----</span>

    <%-- Calendar Icon (HTML entity for calendar) --%>
    <span style="margin-left: 8px; font-size: 16px;">&#128197;</span>

    <%-- Hidden date picker input --%>
    <input type="date"
        id="hiddenDatePicker"
        onchange="handleDateChange(event)"
        style="position: absolute; visibility: hidden; width: 0; height: 0;">
</div>
            </div>

            <div class="dashboard-container">
                <div class="filter-bar">
                    <div class="filter-group">
                        <label for="selectZone">Zone</label>
                        <select id="selectZone">
                            <option value="all">Select Zones</option>
                        </select>
                    </div>
                    
                    <div class="filter-group">
                        <label for="selectWard">Ward</label>
                        <select id="selectWard">
                            <option value="all">Select Wards</option>
                        </select>
                    </div>
                    
                    <div class="filter-group">
                        <label for="selectKothi">Kothi</label>
                        <select id="selectKothi">
                            <option value="all">Select Kothi</option>
                        </select>
                    </div>

                    <div class="filter-group">
                        <label for="selectSupervisor">SweeperName</label>
                        <select id="selectSweeper">
                            <option value="all">Select SweeperName</option>
                        </select>
                    </div>
                </div>

                <div class="dashboard-content-container">

                    <div class="box" id="renderOverallChart">
                        <div class="chart-loader"></div>
                        <div id="chart1" class="chart"></div>
                    </div>

                   <div class="box" id="zoneWiseChartCard">
                        <div class="chart-loader"></div>
                        <div id="sweeperAttandanceZoneWise" class="chart"></div>
                    </div>

                    <div class="box" id="wardWiseChartCard">
                       <div class="chart-loader"></div>
                        <div class="title">Sweeper Attendance Ward Wise</div>
                        <div id="chart3" class="chart"></div>
                    </div>

                    <div class="dashboard-chart">
                        <div class="chart-loader"></div>
                        <div id="trendChart" class="chart-area"></div>
                    </div>
                </div>
            </div>
        </div>

        <script>

            // 🚨 START DATE PICKER LOGIC 🚨
            const dateDisplayDiv = document.getElementById('dateDisplay');
            const dateInput = document.getElementById('hiddenDatePicker');

            function getTodayDateString() {
                const today = new Date();
                const year = today.getFullYear();
                const month = String(today.getMonth() + 1).padStart(2, '0');
                const day = String(today.getDate()).padStart(2, '0');
                return `${year}-${month}-${day}`;
            }

            function initDatePicker() {
                if (!dateInput || !dateDisplayDiv) {
                    console.error("Date picker elements missing");
                    return;
                }

                const today = getTodayDateString();

                dateInput.max = today;
                dateInput.value = today;

                updateDateUI(today);
            }

            function updateDateUI(dateString) {
                if (!dateString) return;

                const date = new Date(dateString + 'T00:00:00');
                const formattedDate = date.toLocaleDateString('en-GB', {
                    day: '2-digit',
                    month: '2-digit',
                    year: 'numeric'
                });

                dateDisplayDiv.textContent = formattedDate;
            }

            function handleDateChange(event) {
                const newDate = event.target.value;
                updateDateUI(newDate);

                const activeTabElement = document.querySelector('.tab.active');
                if (activeTabElement) {
                    const tabId = activeTabElement.dataset.tab;
                    if (tabId === 'tab-1') renderTab1Charts();
                    if (tabId === 'tab-2') renderTab2Charts();
                }
            }

            function getSelectedDate() {
                return dateInput.value || getTodayDateString();
            }

            // ✅ THIS WAS MISSING
            document.addEventListener("DOMContentLoaded", function () {
                initDatePicker();
            });
            // 🚨 END DATE PICKER LOGIC 🚨

            // --- UI/UX Helper Function ---
            function toggleSidebar() {
                const sidebar = document.getElementById('mySidebar');
                sidebar.classList.toggle('open');
            }

            // --- LOADER TOGGLE FUNCTION (Controls the visible charts) ---
            function toggleLoader(chartId, show) {
                const chartDiv = document.getElementById(chartId);
                // Locate the nearest parent container with position: relative for the loader
                const cardElement = chartDiv ? chartDiv.closest('.box, .dashboard-chart') : null;
                if (!cardElement) return;

                const loader = cardElement.querySelector('.chart-loader');

                if (loader) {
                    loader.style.display = show ? 'block' : 'none';

                    // Toggle visibility of the actual chart container
                    chartDiv.style.visibility = show ? 'hidden' : 'visible';
                }
            }
            // ----------------------------------------

            // --- Placeholder for non-Plotly loading message, adapted to clear Plotly on error ---
            function showLoadingMessage(selector, message, isError) {
                const element = $(selector);
                const color = isError ? "#DC3545" : "#888"; // Red for error, Gray for loading

                // Clear existing Plotly chart if attempting to show a message/error after a previous render
                try {
                    Plotly.purge(selector);
                } catch (e) {
                    // Ignore if chart doesn't exist yet
                }

                element.html(`<div style="text-align: center; padding: 20px; color: ${color}; font-style: italic;">${message}</div>`);
            }


            // --- COLOR CONSTANTS (Approximated from image (2).jpg) ---
            const COLORS = {
                ABSENT: '#DC3545',	// Red
                PRESENT: '#28A745',	// Green
                LDP: '#FFC107',	    // Yellow/Orange (LOP in previous code)
                PING: '#36A2EB',	// Blue
                ML: '#4BC0C0',	    // Cyan
                CL: '#FF6384',	    // Pink
                EL: '#9370DB',	    // Purple
                OutDuty: '#A9A9A9',	// Gray
                Compoff: '#FFA500',	// Dark Orange
                WO: '#7FFFD4',	    // Light Cyan
                OTHER_GREEN: '#5cb85c',
                OTHER_RED: '#d9534f',
                PING_LIGHT: '#8ecae6',
                CL_LIGHT: '#ffc8dd',
                ML_LIGHT: '#90e0ef',
                ZONE_WISE_INNER: ['#1f77b4', '#ff7f0e', '#2ca02c', '#d62728', '#9467bd', '#8c564b', '#e377c2', '#7f7f7f', '#bcbd22', '#17becf'], // Example palette
                COVERAGE_OUTER: { // Assuming 'range' maps to a color
                    '0-25%': '#f8d7da',	// Light Red
                    '25-50%': '#fff3cd', // Light Yellow
                    '50-75%': '#d1ecf1', // Light Cyan
                    '75-100%': '#d4edda' // Light Green
                }
            };



            function renderOverallChart() {

                const url = "https://iswmpune.in/api/SweeperAttendance";
                const targetId = "chart1"; // Corrected from "sweeperAttendanceChart" to "chart1"

                toggleLoader(targetId, true); // Show loader

                $.ajax({
                    type: "GET",
                    url: url,
                    dataType: "json",
                    success: function (apiData) {
                        toggleLoader(targetId, false); // Hide loader on success

                        // ✅ Validate response
                        if (!apiData || !apiData.labels || !apiData.data) {
                            showLoadingMessage('#' + targetId, 'No chart data available.', true);
                            return;
                        }

                        const labels = apiData.labels;
                        const values = apiData.data;
                        const total = apiData.total;

                        // ✅ Plotly donut chart
                        const plotlyData = [{
                            labels: labels,
                            values: values,
                            type: "pie",
                            hole: 0.5,
                            textinfo: "percent",
                            insidetextorientation: "radial",
                            marker: {
                                colors: [
                                    COLORS.PRESENT, // PRESENT
                                    COLORS.ABSENT, // ABSENT
                                    COLORS.PING, // PING
                                    COLORS.WO, // WO
                                    COLORS.OutDuty, // OUT DUTY
                                    COLORS.EL, // EL
                                    COLORS.LDP, // LOP
                                    COLORS.ML, // ML
                                    COLORS.CL, // CL
                                    COLORS.Compoff	// COMPOFF
                                ]
                            }
                        }];

                        const layout = {
                            title: {
                                text: `<b>Sweeper Attendance</b> (Total: ${total})`,
                                font: { size: 16 }
                            },
                            height: 320,
                            showlegend: true,
                            margin: { l: 20, r: 20, t: 50, b: 20 },
                            annotations: [{
                                text: total.toString(),
                                font: { size: 18, color: "#000" },
                                showarrow: false,
                                x: 0.5,
                                y: 0.5
                            }]
                        };

                        Plotly.newPlot(
                            targetId,
                            plotlyData,
                            layout,
                            { responsive: true, displayModeBar: false }
                        );
                    },
                    error: function (xhr) {
                        console.error("Chart Error:", xhr.responseText);
                        toggleLoader(targetId, false); // Hide loader on error
                        showLoadingMessage('#' + targetId, 'Error loading chart', true);
                    }
                });
            }




            /* ---------------------- CHART 2 (Zone Sunburst) ---------------------- */
            function renderZoneWiseChart() {
                // *** ENSURE THIS ID MATCHES THE HTML CONTAINER ID! ***
                const targetId = 'sweeperAttandanceZoneWise';
                const url = "https://iswmpune.in/api/SweeperCoverageZoneWise";

                toggleLoader(targetId, true); // Show loader

                $.ajax({
                    type: "GET",
                    url: url,
                    dataType: "json",
                    success: function (res) {
                        toggleLoader(targetId, false); // Hide loader on success

                        // CRUCIAL CHECK: Use 'zones' array from your API response
                        if (!res || !res.zones || res.zones.length === 0) {
                            showLoadingMessage('#' + targetId, 'No chart data available.', true);
                            return;
                        }

                        var labels = [];
                        var parents = [];
                        var values = [];
                        var text = [];
                        var colors = [];

                        // Calculate the grand total of all sweepers across all zones
                        const grandTotal = res.zones.reduce((sum, zone) => sum + zone.total, 0);

                        // Process each zone
                        res.zones.forEach(function (zone_data, zi) {

                            var zoneName = 'Zone ' + zone_data.zone;
                            var zoneTotal = zone_data.total;
                            // Ensure grandTotal is not zero before calculating percentage
                            var zonePercent = (grandTotal > 0) ? Math.round((zoneTotal / grandTotal) * 100) : 0;

                            // 🔸 INNER RING (ZONE) - Represents the Zone's total contribution to the Grand Total
                            labels.push(zoneName.toString());
                            parents.push(""); // Root level item
                            values.push(zoneTotal);
                            text.push(zoneName + "<br>" + zonePercent + "%");
                            // Use ZONE_WISE_INNER color for the zone
                            colors.push(COLORS.ZONE_WISE_INNER[zi % COLORS.ZONE_WISE_INNER.length]);

                            // 🔸 OUTER RING (COVERAGE BUCKETS) - Represents coverage distribution within that specific zone
                            zone_data.buckets.forEach(function (bucket) {

                                var range = bucket.range;
                                var val = bucket.count;
                                // Calculate percentage relative to the ZONE's total (not the Grand Total)
                                var pct = (zoneTotal > 0) ? Math.round((val / zoneTotal) * 100) : 0;

                                labels.push(range + ' - ' + zoneName); // Unique label for Plotly: e.g., '75-100% - Zone 1'
                                parents.push(zoneName.toString()); // Parent is the zone
                                values.push(val); // Value is the count in this bucket
                                text.push(range + "<br>" + pct + "%");
                                // Use COVERAGE_OUTER color mapped by range
                                colors.push(COLORS.COVERAGE_OUTER[range] || '#888888'); // Use a fallback color
                            });
                        });

                        var data = [{
                            type: "sunburst",
                            labels: labels,
                            parents: parents,
                            values: values,
                            text: text,
                            textinfo: "text", // Display the text array (Name and %) on the slices
                            hoverinfo: 'text+value', // Display the text and raw value on hover
                            insidetextorientation: "radial",
                            branchvalues: "total", // Inner ring represents the total of its children (default behavior)
                            sort: false,
                            maxdepth: 2, // Show only two levels: Zone (Inner) and Coverage Bucket (Outer)
                            marker: { colors: colors, line: { width: 2, color: "#ffffff" } }
                        }];

                        var layout = {
                            title: {
                                text: "<b>Sweeper Coverage Zone Wise</b>",
                                font: { size: 16, color: '#000' }
                            },
                            height: 350,
                            margin: { t: 50, l: 10, r: 10, b: 10 },
                        };

                        Plotly.newPlot(targetId, data, layout, { responsive: true, displayModeBar: false });
                    },
                    error: function (xhr) {
                        console.error("AJAX Error for Zone Wise Chart:", xhr.responseText);
                        toggleLoader(targetId, false); // Hide loader on error
                        showLoadingMessage('#' + targetId, 'Error loading chart. Check API status (Status: ' + xhr.status + ')', true);
                    }
                });
            }
            /* ---------------------- CHART 3 (Ward Sunburst) ---------------------- */
            function getWardParentColor(index) {
                // 15 distinct, vibrant colors
                const colorSequence = [
                    '#36A2EB', '#DC3545', '#FFC107', '#28A745', '#FF6384', '#A9A9A9', '#4BC0C0',
                    '#9370DB', '#FFA500', '#7FFFD4', '#90EE90', '#F08080', '#00FFFF', '#BDB76B',
                    '#D2B48C'
                ];
                return colorSequence[index % colorSequence.length];
            }

            // =====================================================================
            // === 2. Main Chart Rendering Function
            // =====================================================================

            /**
              * Renders the Ward Wise Sunburst Chart using jQuery AJAX and Plotly.
              * Transforms the API's 'datasets' structure into Plotly's Sunburst format.
              */
            function renderWardWiseChart() {

                // --- Configuration ---
                const url = "https://iswmpune.in/api/SweeperAttendanceWardWise";
                const targetId = "chart3";

                toggleLoader(targetId, true); // Show loader

                // --- AJAX Data Fetch ---
                $.ajax({
                    type: "GET",
                    url: url,
                    dataType: "json",

                    success: function (apiData) {
                        toggleLoader(targetId, false); // Hide loader on success

                        // Function to get Status Colors
                        function getWardColor(label) {
                            // Attendance Status Colors
                            if (label.toUpperCase().includes("ABSENT")) return COLORS.ABSENT;
                            if (label.toUpperCase().includes("PRESENT")) return COLORS.PRESENT;
                            if (label.toUpperCase().includes("LOP")) return COLORS.LDP;
                            if (label.toUpperCase().includes("PING")) return COLORS.PING;
                            if (label.toUpperCase().includes("OUT DUTY")) return COLORS.OutDuty;
                            if (label.toUpperCase().includes("CL")) return COLORS.CL;
                            if (label.toUpperCase().includes("ML")) return COLORS.ML;
                            if (label.toUpperCase().includes("EL")) return COLORS.EL;
                            if (label.toUpperCase().includes("WO")) return COLORS.WO;
                            if (label.toUpperCase().includes("COMPOFF")) return COLORS.Compoff;
                            // Fallback for "Other" or unknown status
                            return COLORS.OTHER || '#cccccc';
                        }


                        // ✅ Validate response
                        if (!apiData || !apiData.labels || !apiData.datasets || apiData.labels.length === 0) {
                            showLoadingMessage('#' + targetId, 'No chart data available.', true);
                            return;
                        }

                        // --- 1. Data Transformation for Plotly Sunburst ---
                        const ids = [];
                        const labels = [];
                        const parents = [];
                        const values = [];

                        const wardNames = apiData.labels;
                        const totalEmployeesPerWard = new Array(wardNames.length).fill(0);

                        // Step 1: Calculate Total Employees per Ward and Collect Child Data (Outer Ring)
                        apiData.datasets.forEach(dataset => {
                            const statusLabel = dataset.label.toUpperCase();
                            const statusData = dataset.data;

                            statusData.forEach((count, wardIndex) => {
                                const wardId = wardNames[wardIndex];

                                // Add to total count for the parent ward
                                totalEmployeesPerWard[wardIndex] += count;

                                // Only add child nodes if count is greater than zero
                                if (count > 0) {
                                    ids.push(`${wardId}-${statusLabel}`);
                                    labels.push(`${statusLabel} (${count})`);
                                    parents.push(wardId); // Parent is the Ward Name ID
                                    values.push(count);
                                }
                            });
                        });

                        // Step 2: Add Parent Ward Entries (Inner Ring)
                        wardNames.forEach((wardId, wardIndex) => {
                            const total = totalEmployeesPerWard[wardIndex];

                            // Only add the parent if it has children (total > 0)
                            if (total > 0) {
                                ids.push(wardId);
                                labels.push(`${wardId} (Total: ${total})`); // Label includes the total count
                                parents.push(""); // Top-level parent
                                values.push(total); // Total count determines the slice size
                            }
                        });

                        // --- 3. Define Color Map for Plotly ---
                        const markerColors = labels.map((label, index) => {
                            const parentId = parents[index];

                            if (parentId === "") {
                                // It's a parent node (Ward), find its original index
                                const wardIndex = wardNames.findIndex(name => name === ids[index]);
                                return getWardParentColor(wardIndex);
                            } else if (parentId) {
                                // It's a child node (Status), use status color
                                return getWardColor(label);
                            }
                            return '#cccccc';
                        });

                        // --- 4. Render Plotly Chart ---
                        Plotly.newPlot(targetId, [{
                            type: "sunburst",
                            ids: ids,
                            labels: labels,
                            parents: parents,
                            values: values,
                            marker: {
                                colors: markerColors,
                                line: { color: '#fff', width: 1 }
                            },

                            // ✅ Shows text on the chart slices (Ward Name/Total & Status/Count)
                            textinfo: "label+value",

                            insidetextorientation: 'radial',
                            // Sets the color to black and size to 8
                            insidetextfont: { size: 8, color: '#000' },

                            // ✅ Shows the same information in a tooltip box on hover
                            hoverinfo: 'label+value',

                            branchvalues: 'total'
                        }], {
                            height: 330,
                            margin: { t: 5, b: 5, l: 5, r: 5 },
                            showlegend: false,
                            // Ensures text is hidden if it doesn't fit the min size of 8
                            uniformtext: { minsize: 8, mode: 'hide' }
                        }, { responsive: true, displayModeBar: false });
                    },

                    error: function (xhr) {
                        console.error("Chart AJAX Error:", xhr.responseText);
                        toggleLoader(targetId, false); // Hide loader on error
                        showLoadingMessage('#' + targetId, 'Error loading chart', true);
                    }
                });
            }
            /* ---------------------- CHART 4 (Attendance Trend) ---------------------- */


            function renderTrendChart() {

                // --- Configuration ---
                const url = "https://iswmpune.in/api/SweeperAttendanceTrend";
                const targetId = "trendChart";

                toggleLoader(targetId, true); // Show loader

                // --- AJAX Data Fetch ---
                $.ajax({
                    type: "GET",
                    url: url,
                    dataType: "json",

                    success: function (apiData) {
                        toggleLoader(targetId, false); // Hide loader on success

                        // ✅ Validate response
                        if (!apiData || !apiData.labels || !apiData.datasets || apiData.labels.length === 0) {
                            showLoadingMessage('#' + targetId, 'No chart data available.', true);
                            return;
                        }

                        // --- 1. Data Extraction and Transformation ---
                        const dates = apiData.labels; // Array of dates (e.g., ["Nov 26", "Nov 27", ...])
                        const trendData = []; // Array to hold Plotly trace objects

                        // Process each dataset (each attendance status) into a Plotly trace
                        apiData.datasets.forEach(dataset => {
                            const statusName = dataset.label.toUpperCase();
                            const statusData = dataset.data; // Array of counts for each date

                            // --- Define Trace Style based on Status ---
                            let lineColor = COLORS[statusName] || '#A9A9A9'; // Default to grey
                            let lineDash = 'solid';
                            let opacity = 1;

                            // Normalize LOP to LDP since the API response uses LOP for leave/pay status
                            if (statusName === 'LOP') {
                                lineColor = COLORS.LDP;
                            }

                            if (['LOP', 'PING'].includes(statusName)) {
                                lineDash = 'dot';
                            } else if (!['PRESENT', 'ABSENT'].includes(statusName)) {
                                opacity = 0.5; // Less dominant for smaller categories
                            }

                            // Create the Plotly trace object
                            trendData.push({
                                name: statusName,
                                type: "scatter",
                                mode: "lines+markers",
                                // The 'x' values are implicitly 0, 1, 2... but we can use the original indices
                                x: dates.map((_, index) => index),
                                y: statusData,
                                line: {
                                    color: lineColor,
                                    width: 2,
                                    dash: lineDash,
                                    opacity: opacity
                                }
                            });
                        });

                        // --- 2. Plotly Layout Configuration ---
                        const layout = {
                            title: {
                                text: '<b>Daily Sweeper Attendance Trend</b>',
                                font: { size: 16 }
                            },
                            xaxis: {
                                // Map the implicit indices (0, 1, 2...) back to readable dates
                                tickvals: dates.map((_, index) => index),
                                ticktext: dates,
                                showgrid: false,
                                title: 'Date',
                                tickangle: -45,
                                automargin: true,
                            },
                            yaxis: {
                                title: 'Attendance (Count)', // Y-axis title based on counts from API
                                showgrid: true,
                                gridcolor: '#eee',
                            },
                            height: 400,
                            margin: { t: 50, r: 20, b: 80, l: 50 },
                            showlegend: true,
                            legend: { orientation: 'h', y: 1.05, x: 0, font: { size: 10 } }
                        };

                        // --- 3. Render Chart ---
                        Plotly.newPlot(
                            targetId,
                            trendData, // Use the dynamically created trendData
                            layout,
                            { responsive: true, displayModeBar: false }
                        );
                    },

                    error: function (xhr) {
                        console.error("Chart AJAX Error:", xhr.responseText);
                        toggleLoader(targetId, false); // Hide loader on error
                        showLoadingMessage('#' + targetId, 'Error loading trend chart', true);
                    }
                });
            }
            window.onload = function () {
                renderOverallChart();
                renderZoneWiseChart();
                renderWardWiseChart();
                renderTrendChart();
            };

            //Masters ADDED ON 15.12.2025

            $(document).ready(function () {

                // -------- ZONE --------
                $.ajax({
                    url: 'https://iswmpune.in/api/GetzoneAPI',
                    type: "GET",
                    dataType: "json",
                    success: function (json) {

                        $("#selectZone").empty()
                            .append('<option value="">Select Zone</option>');

                        if (json && json.labels) {
                            for (var i = 0; i < json.labels.length; i++) {
                                $("#selectZone").append(
                                    '<option value="' + json.values[i] + '">' +
                                    json.labels[i] +
                                    '</option>'
                                );
                            }
                        }
                    },
                    error: function () {
                        console.log("Zone data not found");
                    }
                });

                // -------- WARD --------
                $("#selectZone").change(function () {

                    var id = $(this).val();

                    $("#selectWard").empty().append('<option value="">Select Ward</option>');
                    $("#selectKothi").empty().append('<option value="">Select Kothi</option>');

                    if (!id) return;

                    $.ajax({
                        url: '/api/GetWardAPI',
                        type: "GET",
                        data: { ZoneId: id },
                        dataType: "json",
                        success: function (json) {

                            if (json && json.labels) {
                                for (var i = 0; i < json.labels.length; i++) {
                                    $("#selectWard").append(
                                        '<option value="' + json.values[i] + '">' +
                                        json.labels[i] +
                                        '</option>'
                                    );
                                }
                            }
                        }
                    });
                });

                // -------- KOTHI --------
                $("#selectWard").change(function () {

                    var id = $(this).val();

                    $("#selectKothi").empty().append('<option value="">Select Kothi</option>');

                    if (!id) return;

                    $.ajax({
                        url: '/api/GetKothiAPI',
                        type: "GET",
                        data: { WardId: id },
                        dataType: "json",
                        success: function (json) {

                            if (json && json.labels) {
                                for (var i = 0; i < json.labels.length; i++) {
                                    $("#selectKothi").append(
                                        '<option value="' + json.values[i] + '">' +
                                        json.labels[i] +
                                        '</option>'
                                    );
                                }
                            }
                        }
                    });
                });


                //---------------------------------- SWEEPER -------------------------------
                $("#selectKothi").change(function () {

                    var zoneId = $("#selectZone").val();
                    var wardId = $("#selectWard").val();
                    var kothiId = $(this).val();

                    $("#selectSweeper").empty()
                        .append('<option value="">Select Sweeper</option>');

                    if (!zoneId || !wardId || !kothiId) return;

                    $.ajax({
                        url: '/api/GetsweeperNameAPI',
                        type: "GET",
                        data: {
                            zoneId: zoneId,
                            wardId: wardId,
                            kothiId: kothiId
                        },
                        dataType: "json",
                        success: function (data) {

                            if (data && data.labels) {
                                for (var i = 0; i < data.labels.length; i++) {
                                    $("#selectSweeper").append(
                                        '<option value="' + data.labels[i] + '">' +
                                        data.labels[i] +
                                        '</option>'
                                    );
                                }
                            }
                        },
                        error: function () {
                            console.log("Sweeper data not found");
                        }
                    });
                });

            });

            



        </script>
    </div>
</body>
    </div>
</asp:Content>