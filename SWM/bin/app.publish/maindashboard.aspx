<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="maindashboard.aspx.cs" Inherits="SWM.maindashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <div class="card-sub-container">
      <%--scsserver--%>
       
          <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.plot.ly/plotly-2.30.0.min.js"></script>

<style>
    /* Global Styles to match the image's dark theme */
    body {
        font-family: Arial, sans-serif;
        background: linear-gradient(to right, #3f51b5, #003366);
        color: #FFFFFF;
        margin: 0;
        padding: 0;
        overflow-x: hidden; /* Prevent horizontal scroll */
    }

    /* --- Sidebar & Layout Containers --- */
    .sidebar-container {
        /*display: flex;*/ /* Flex container for the whole layout */
    }

    /* --- Sidebar Styling (Fixed & Responsive) --- */
    /*.sidebar {
        width: 250px;*/ /* Standard sidebar width */
        /*background-color: #fff;*/ /* Primary blue for sidebar */
        /*color: #000;
        padding-top: 20px;
        box-shadow: 2px 0 5px rgba(0, 0, 0, 0.5);
        height: 100vh;*/ /* Full height */
        /*position: fixed;*/ /* Fixed position */
        /*top: 0;
        left: 0;
        z-index: 1000;
        transform: translateX(0);*/ /* Default: visible on desktop */
        /*transition: transform 0.3s ease-in-out;
        overflow-y: auto;
    }*/

        /*.sidebar a {
            padding: 15px 20px;
            text-decoration: none;
            font-size: 14px;
            color: #000;
            border: 1px solid #000;
            display: block;
            transition: background-color 0.3s;
        }

            .sidebar a:hover, .sidebar .active-link {
                background-color: #1a5e9f;*/ /* Slightly darker hover/active */
                /*border-left: 5px solid #00BCD4;*/ /* Accent color indicator */
            /*}*/

    /* Menu for Phone/Tablet */
    @media (max-width: 1024px) {
        .sidebar {
            transform: translateX(-100%); /* Initially hidden on mobile/tablet */
            width: 50%; /* Half width on smaller screens */
            max-width: 250px; /* Optional: limit max size even on mobile */
        }

            .sidebar.open {
                transform: translateX(0); /* Slide open when active */
            }
    }

    /* --- Content Area Styling --- */
    .content-area {
        flex-grow: 1;
         /* Space for the fixed sidebar on desktop */
        transition: margin-left 0.3s ease-in-out;
        width: 100%;
    }

    /* Adjust content area for mobile/tablet when sidebar is hidden */
    @media (max-width: 1024px) {
        .content-area {
            margin-left: 0;
            width: 100%;
        }
    }


    /* --- Top Bar Styling (Adjusted for Sidebar presence) --- */
    .header-bar {
        background-color: #0d47a1; /* Primary blue for header */
        padding: 15px 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

        .header-bar h1 {
            margin: 0;
            font-size: 24px;
        }

    /* Menu Icon Styling (Only visible on mobile/tablet) */
    .menu-icon {
        font-size: 30px;
        cursor: pointer;
        display: none;
        padding-right: 15px;
    }

    @media (max-width: 1024px) {
        .menu-icon {
            display: block;
        }
    }

    /* Existing CSS below (Adjusted only for better integration) */

    /* --- Tab Navigation Styling --- */
    .tab-nav {
        display: flex;
        width: 100%;
        margin-top: 10px;
        padding: 0 20px;
    }

    .tab {
        flex-grow: 1;
        text-align: center;
        padding: 10px 25px;
        cursor: pointer;
        font-weight: bold;
        border-radius: 5px 5px 0 0;
        transition: background-color 0.3s;
    }

        .tab.active {
            background-color: #2b3e50; /* Active tab background */
            color: #00BCD4; /* Accent color for active text */
            border-bottom: 2px solid #00BCD4;
        }
        /* Universal INACTIVE Tab Style */
        .tab.inactive {
            background-color: #3f51b5; /* Inactive tab style */
            color: lightgray;
        }

    /* Dashboard Container and Grid System */
    .dashboard-container {
        padding: 20px;
    }

    /* DEFAULT: 3-column layout for large screens */
    .dashboard-grid {
        display: grid;
        grid-template-columns: repeat(3, 1fr); /* Three equal columns */
        gap: 7px;
    }
        /* Hidden state for inactive tabs */
        .dashboard-grid.inactive {
            display: none;
        }

    /* Style for the individual chart containers (enforcing 240px height) */
    .chart-container {
        background-color: #fff; /* Card background color */
        padding: 5px;
        border-radius: 12px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
        height: 240px;
        min-height: 240px;
    }

    .chart-container-2col {
        grid-column: span 1.5;
    }

    /* --- RESPONSIVENESS (Media Queries) --- */
    @media (max-width: 1024px) {
        .dashboard-grid {
            grid-template-columns: repeat(2, 1fr);
        }
        /* Reset 2-column containers to span 1 column on tablets (2-column grid) */
        .chart-container-2col {
            grid-column: span 1;
        }
    }

    @media (max-width: 600px) {
        .dashboard-grid {
            grid-template-columns: 1fr;
        }

        .tab-nav {
            flex-direction: column;
        }

        .tab {
            border-radius: 5px;
            margin-bottom: 5px;
        }
    }

   
    .chart-loader {
        width: 40px;
        height: 40px;
        border: 4px solid #ddd;
        border-top: 4px solid #4CAF50; /* green loader */
        border-radius: 50%;
        animation: spin 0.9s linear infinite;
        margin: 30px auto;
    }

    @keyframes spin {
        100% {
            transform: rotate(360deg);
        }
    }
</style>
    <div class="content-area">

    <div class="header-bar">
        <span class="menu-icon" onclick="toggleSidebar()">&#9776;</span>
        <h1>Master Dashboard</h1>
        <div style="background-color: #3f51b5; color: #FFFFFF; padding: 8px 15px; border-radius: 6px; font-size: 14px; font-weight: bold; display: inline-block; margin-right: 20px;">
            12/11/2025
        </div>
    </div>

    <div class="tab-nav">
        <div class="tab active" data-tab="tab-1" onclick="switchTab('tab-1', this)">
            SWEEPER / COLLECTION WORKER / VEHICLE COVERAGE
        </div>
        <div class="tab inactive" data-tab="tab-2" onclick="switchTab('tab-2', this)">
            GARBAGE / WASTE PROCESSING
        </div>
    </div>
    <div class="dashboard-container">
        <div id="dashboard-tab-1" class="dashboard-grid active">
            <div id="sweeperAttendanceChart" class="chart-container"></div>
            <div id="sweeperBeatCoverageChart" class="chart-container"></div>
            <div id="sweeperBeatCoverageKMChart" class="chart-container"></div>

            <div id="cwAttendanceChart" class="chart-container"></div>
            <div id="collectionWorkerPocketCoverageChart" class="chart-container"></div>
            <div id="urinalsCoverageChart" class="chart-container"></div>

            <div id="vehicleStatusChart" class="chart-container"></div>
            <div id="feederCoverageChart" class="chart-container"></div>
            <div id="mechanicalSweeperCoverageChart" class="chart-container"></div>
        </div>




        <div id="dashboard-tab-2" class="dashboard-grid inactive">

            <div id="rampWiseGarbageChart" class="chart-container  "></div>
            <div id="processingPlantDryGarbageChart" class="chart-container "></div>

            <div id="postProcessingPlantChart" class="chart-container"></div>
            <div id="wetWasteProcessingPlantChart" class="chart-container"></div>
            <div id="fineCollectionChart" class="chart-container"></div>

            <div id="bioGasProcessingChartKG" class="chart-container"></div>
            <div id="adhocSpecialWasteCDChart" class="chart-container"></div>
            <div id="adhocSpecialWasteChart" class="chart-container"></div>
        </div>
    </div>
</div>
    <script type="text/javascript">
    function showLoader(chartName) {
        $("#" + chartName + "_loader").show();
        $("#" + chartName + "Chart").hide();
    }

    function hideLoader(chartName) {
        $("#" + chartName + "_loader").hide();
        $("#" + chartName + "Chart").show();
    }


    const CHART_INNER_HEIGHT = 200;
    function toggleSidebar() {
        const sidebar = document.getElementById('mySidebar');
        sidebar.classList.toggle('open');
    }

    function getBaseLayout(titleText) {
        return {
            title: '<b>' + titleText + '</b>',
            height: CHART_INNER_HEIGHT,
            paper_bgcolor: '#fff',
            plot_bgcolor: '#fff',
            font: { color: '#000' },
            margin: { l: 40, r: 20, t: 40, b: 40 }
        };
    }
    function switchTab(tabId, clickedTab) {

        document.querySelectorAll('.tab').forEach(tab => {
            tab.classList.remove('active');
            tab.classList.add('inactive');
        });

        // Set the clicked tab as active
        clickedTab.classList.add('active');
        clickedTab.classList.remove('inactive');

        // Hide all dashboard grids
        document.querySelectorAll('.dashboard-grid').forEach(grid => {
            grid.classList.add('inactive');
        });

        const activeGrid = document.getElementById('dashboard-' + tabId);
        if (activeGrid) {
            activeGrid.classList.remove('inactive');
            if (tabId === 'tab-1') {
                renderTab1Charts();
            } else if (tabId === 'tab-2') {
                renderTab2Charts();
            }
        }
    }

    // --- 1. Sweeper Attendance Chart (Donut with Legend) ---
    function renderSweeperAttendance() {
         
        $.ajax({
            type: "GET",
            url: "http://localhost:75/api/chartdata",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                
                // API already returns JSON, no JSON.parse needed
                var apiData = response;

                // Convert API response → Plotly format
                var plotlyData = [{
                    labels: apiData.labels,
                    values: apiData.values,
                    type: "pie",
                    hole: 0.4, // if you want doughnut; remove if you want normal pie
                    textinfo: "label+percent",
                    insidetextorientation: "radial"
                }];

                // Layout & Lyout title
                var layout = getBaseLayout('Sweeper Attendance');
                layout.showlegend = true;
                layout.margin = { l: 20, r: 120, t: 40, b: 20 };

                layout.annotations = [{
                    font: { size: 20, color: '#000000' },
                    showarrow: false,
                    text: '',
                    x: 0.5,
                    y: 0.5
                }];

                Plotly.newPlot(
                    'sweeperAttendanceChart',
                    plotlyData,
                    layout,
                    { responsive: true, displayModeBar: false }
                );
            },
            error: function (xhr) {
                console.log("AJAX error:", xhr.responseText);
            }
        });

    }


    // --- 2. Sweeper Beat Coverage Chart (Donut) ---
    function renderSweeperBeatCoverage() {

        $.ajax({
            type: "GET",
            url: "http://localhost:75/api/SweeperBeatCoverage",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (apiData) {

                // Exact colors as per your screenshot
                const customColors = [
                    "#FFA000", // ABSENT/LEAVE
                    "#E91E63", // UNCOVERED
                    "#FBC02D", // PARTIALLY COVERED
                    "#00796B"  // COVERED
                ];

                // --- Doughnut chart trace ---
                var plotlyData = [{
                    labels: apiData.labels,
                    values: apiData.values,
                    type: "pie",
                    hole: 0.55,                     // thicker ring like screenshot
                    marker: { colors: customColors },
                    textinfo: "percent",            // only % text inside slices
                    textfont: { size: 14, color: "#fff" },
                    insidetextorientation: "auto",
                    hoverinfo: "label+value+percent"
                }];

                // --- Layout matching the screenshot ---
                var layout = getBaseLayout("Sweeper Beat Coverage");

                layout.showlegend = true;
                layout.legend = {
                    x: 1.1,
                    y: 0.5,
                    font: { size: 14 }
                };

                layout.margin = { l: 20, r: 150, t: 50, b: 20 };

                // Clean donut center
                layout.annotations = [];

                Plotly.newPlot(
                    "sweeperBeatCoverageChart",
                    plotlyData,
                    layout,
                    { responsive: true, displayModeBar: false }
                );
            },

            error: function (xhr) {
                console.log("AJAX error:", xhr.responseText);
            }
        });
    }


    // --- 3. Sweeper Beat Coverage KM Chart (Horizontal Bar - Matching Image) ---
    function renderSweeperBeatCoverageKM() {
        $.ajax({
            type: "GET",
            url: "http://localhost:75/api/SweeperBeatCoverageKM",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {

                var apiData = response;

                // Colors EXACTLY as in your screenshot
                const barColors = [
                    "#1B9E77", // COVERED (green)
                    "#FDAE61", // UNCOVER
                    "#67C5F5", // ROUTE DEVIATED (cyan)
                    "#F06292"  // ABSENT (pink)
                ];

                // Horizontal bars require x ↔ y swap
                var plotlyData = [{
                    x: apiData.values,     // KM values on X-axis
                    y: apiData.labels,     // Category labels on Y-axis
                    type: "bar",
                    orientation: "h",      // <<< IMPORTANT
                    marker: {
                        color: barColors,
                        line: { width: 1, color: "#ffffff" }
                    },
                    text: apiData.values,
                    textposition: "auto"
                }];

                // Layout to match screenshot
                var layout = getBaseLayout("Sweeper Beat Coverage KM");

                layout.showlegend = false;

                layout.margin = { l: 180, r: 40, t: 50, b: 80 };

                layout.xaxis = {
                    title: "Covered Points in KM",
                    showgrid: false,
                    zeroline: false
                };

                layout.yaxis = {
                    automargin: true
                };

                // Remove unwanted annotation area in center
                layout.annotations = [];

                Plotly.newPlot(
                    "sweeperBeatCoverageKMChart",
                    plotlyData,
                    layout,
                    { responsive: true, displayModeBar: false }
                );
            },
            error: function (xhr) {
                console.log("AJAX error:", xhr.responseText);
            }
        });
    }

    // --- 4. CW Attendance Chart (Donut) ---

    function renderCWAttendance() {

        $.ajax({
            type: "GET",
            url: "http://localhost:75/api/CWAttendance",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {

                // API already returns JSON, no JSON.parse needed
                var apiData = response;

                // Convert API response → Plotly format
                var plotlyData = [{
                    labels: apiData.labels,
                    values: apiData.values,
                    type: "pie",
                    hole: 0.4, // if you want doughnut; remove if you want normal pie
                    textinfo: "label+percent",
                    insidetextorientation: "radial"
                }];

                // Layout
                var layout = getBaseLayout('CW Attendance');
                layout.showlegend = true;
                layout.margin = { l: 20, r: 120, t: 40, b: 20 };

                layout.annotations = [{
                    font: { size: 20, color: '#000000' },
                    showarrow: false,
                    text: '',
                    x: 0.5,
                    y: 0.5
                }];

                Plotly.newPlot(
                    'cwAttendanceChart',
                    plotlyData,
                    layout,
                    { responsive: true, displayModeBar: false }
                );
            },
            error: function (xhr) {
                console.log("AJAX error:", xhr.responseText);
            }
        });

    }

    // --- 5. Collection Worker Pocket Coverage Chart (Donut) ---
    function renderPocketCoverage() {
        $.ajax({
            type: "GET",
            url: "http://localhost:75/api/CTPT",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {

                // API already returns JSON, no JSON.parse needed
                var apiData = response;

                // Convert API response → Plotly format
                var plotlyData = [{
                    labels: apiData.labels,
                    values: apiData.values,
                    type: "pie",
                    hole: 0.4, // if you want doughnut; remove if you want normal pie
                    textinfo: "label+percent",
                    insidetextorientation: "radial"
                }];

                // Layout
                var layout = getBaseLayout('Collection Worker Pocket Coverage');
                layout.showlegend = true;
                layout.margin = { l: 20, r: 120, t: 40, b: 20 };

                layout.annotations = [{
                    font: { size: 20, color: '#000000' },
                    showarrow: false,
                    text: '',
                    x: 0.5,
                    y: 0.5
                }];

                Plotly.newPlot(
                    'collectionWorkerPocketCoverageChart',
                    plotlyData,
                    layout,
                    { responsive: true, displayModeBar: false }
                );
            },
            error: function (xhr) {
                console.log("AJAX error:", xhr.responseText);
            }
        });

    }

    // --- 6. CT, PT and Urinals Coverage Chart (Pie) ---

    function renderUrinalsCoverage() {
        $.ajax({
            type: "GET",
            url: "http://localhost:75/api/CTPT",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {

                // API already returns JSON, no JSON.parse needed
                var apiData = response;

                // Convert API response → Plotly format
                var plotlyData = [{
                    labels: apiData.labels,
                    values: apiData.values,
                    type: "pie",
                    hole: 0.4, // if you want doughnut; remove if you want normal pie
                    textinfo: "label+percent",
                    insidetextorientation: "radial"
                }];

                // Layout
                var layout = getBaseLayout('CT, PT and Urinals Coverage');
                layout.showlegend = true;
                layout.margin = { l: 20, r: 120, t: 40, b: 20 };

                layout.annotations = [{
                    font: { size: 20, color: '#000000' },
                    showarrow: false,
                    text: '',
                    x: 0.5,
                    y: 0.5
                }];

                Plotly.newPlot(
                    'urinalsCoverageChart',
                    plotlyData,
                    layout,
                    { responsive: true, displayModeBar: false }
                );
            },
            error: function (xhr) {
                console.log("AJAX error:", xhr.responseText);
            }
        });


    }

    // --- 7. Vehicle Status Chart (Vertical Bar) ---
    function renderVehicleStatus() {
        $.ajax({
            type: "GET",
            url: "http://localhost:75/api/VehicleStatus",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {

                // API already returns JSON, no JSON.parse needed
                var apiData = response;

                // Convert API response → Plotly format
                var plotlyData = [{
                    x: apiData.labels,       // X-axis categories
                    y: apiData.values,       // Y-axis values
                    type: "bar",
                    text: apiData.values,    // Show values on bar
                    textposition: "auto",
                    marker: {
                        line: { width: 1 }
                    }
                }];


                // Layout
                var layout = getBaseLayout('Vehicle Status');
                layout.showlegend = false;
                layout.margin = { l: 40, r: 20, t: 40, b: 80 };


                layout.annotations = [{
                    font: { size: 20, color: '#000000' },
                    showarrow: false,
                    text: '',
                    x: 0.5,
                    y: 0.5
                }];

                Plotly.newPlot(
                    'vehicleStatusChart',
                    plotlyData,
                    layout,
                    { responsive: true, displayModeBar: false }
                );
            },
            error: function (xhr) {
                console.log("AJAX error:", xhr.responseText);
            }
        });

    }

    // --- 8. Feeder Cov Chart (Stacked Bar) ---
    function renderFeederCoverage() {
        $.ajax({
            type: "GET",
            url: "http://localhost:75/api/FeederCoverage",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {

                // API already returns JSON, no JSON.parse needed
                var apiData = response;

                // Convert API response → Plotly format
                var plotlyData = [{
                    x: apiData.labels,       // X-axis categories
                    y: apiData.values,       // Y-axis values
                    type: "bar",
                    text: apiData.values,    // Show values on bar
                    textposition: "auto",
                    marker: {
                        line: { width: 1 }
                    }
                }];


                // Layout
                var layout = getBaseLayout('Feeder Cov(Total: 1920, Cover: 1402) ');
                layout.showlegend = false;
                layout.margin = { l: 40, r: 20, t: 40, b: 80 };


                layout.annotations = [{
                    font: { size: 20, color: '#000000' },
                    showarrow: false,
                    text: '',
                    x: 0.5,
                    y: 0.5
                }];

                Plotly.newPlot(
                    'feederCoverageChart',
                    plotlyData,
                    layout,
                    { responsive: true, displayModeBar: false }
                );
            },
            error: function (xhr) {
                console.log("AJAX error:", xhr.responseText);
            }
        });

         
    }

    // --- 9. Mechanical Sweeper Coverage Chart (Matching Image Structure) ---
    function renderMechanicalSweeperCoverage() {
        $.ajax({
            type: "GET",
            url: "http://localhost:75/api/MechanicalSweeperCoverage",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {

                // API already returns JSON, no JSON.parse needed
                var apiData = response;

                // Convert API response → Plotly format
                var plotlyData = [{
                    x: apiData.labels,       // X-axis categories
                    y: apiData.values,       // Y-axis values
                    type: "bar",
                    text: apiData.values,    // Show values on bar
                    textposition: "auto",
                    marker: {
                        line: { width: 1 }
                    }
                }];


                // Layout
                var layout = getBaseLayout('Mechanical Sweeper Coverage');
                layout.showlegend = false;
                layout.margin = { l: 40, r: 20, t: 40, b: 80 };


                layout.annotations = [{
                    font: { size: 20, color: '#000000' },
                    showarrow: false,
                    text: '',
                    x: 0.5,
                    y: 0.5
                }];

                Plotly.newPlot(
                    'mechanicalSweeperCoverageChart',
                    plotlyData,
                    layout,
                    { responsive: true, displayModeBar: false }
                );
            },
            error: function (xhr) {
                console.log("AJAX error:", xhr.responseText);
            }
        });
        
    }
    function renderTab1Charts() {
        renderSweeperAttendance();
        renderSweeperBeatCoverage();
        renderSweeperBeatCoverageKM();
        renderCWAttendance();
        renderPocketCoverage();
        renderUrinalsCoverage();
        renderVehicleStatus();
        renderFeederCoverage();
        renderMechanicalSweeperCoverage();
    }
    function renderRampWiseGarbage() {

        const ramps = [
            'Rampur Khurd',
            'Dhuda Beat Rampuram',
            'Dhuda Road Ramp',
            'Kistriya Ramp',
            'Pipar Road Ramp',
            'Naulakha Ramp'
        ];

        // Data (Same as your screenshot)
        var traceDry = {
            x: ramps,
            y: [48.3, 72.4, 78.4, 5.0, 1.0, 1.54],
            name: 'Dry Waste',
            type: 'bar',
            marker: { color: '#29B6F6' }
        };

        var traceWet = {
            x: ramps,
            y: [71.15, 22.91, 137.97, 67.85, 96.46, 101.44],
            name: 'Wet Waste',
            type: 'bar',
            marker: { color: '#00BCD4' }
        };

        var traceInert = {
            x: ramps,
            y: [7.7, 11.05, 11.9, 3.0, 1.67, 2.44],
            name: 'Inert Waste',
            type: 'bar',
            marker: { color: '#FFA726' }
        };

        var traceLegacy = {
            x: ramps,
            y: [0, 0, 0, 0, 0, 0],
            name: 'Legacy Waste',
            type: 'bar',
            marker: { color: '#D4E157' }
        };

        // Combine all plots
        var plotlyData = [traceDry, traceWet, traceInert, traceLegacy];

        // Layout
        var layout = getBaseLayout('Ramp Wise Garbage Type Split');
        layout.barmode = 'group';                    // Important: Grouped Bars
        layout.showlegend = true;
        layout.margin = { l: 40, r: 40, t: 50, b: 90 };
        layout.font = { size: 12, color: "#000" };

        layout.xaxis = {
            tickangle: -45,                          // Same angle as screenshot
            automargin: true
        };

        layout.yaxis = {
            title: "Weight in MT",                   // Y-axis label from screenshot
            titlefont: { size: 14 }
        };

        Plotly.newPlot(
            "rampWiseGarbageChart",
            plotlyData,
            layout,
            { responsive: true, displayModeBar: false }
        );
    }

    function renderProcessingPlant() {

        // --- These are your sample data from the screenshot ---
        const plants = [
            "100 MTPD Green Waste Processing MRF-4",
            "100 MTPD Green Waste Processing MRF-10",
            "150 MTPD HYPO Biogas Waste Biorefinery MF-1",
            "57324 MTPD HYPO Biogas Waste Biorefinery ADGP-2",
            "57324 MTPD HYPO Biogas Waste Biorefinery ADGP-1",
            "100 MTPD Biomass Green Garden Waste"
        ];

        const plantCapacity = [100, 100, 150, 57324, 57324, 100];
        const incoming = [60, 80, 120, 50, 40, 70];

        // --- BAR TRACES (horizontal) ---
        var traceCapacity = {
            y: plants,
            x: plantCapacity,
            name: 'Plant Capacity',
            type: 'bar',
            orientation: 'h',
            marker: { color: '#29B6F6' }
        };

        var traceIncoming = {
            y: plants,
            x: incoming,
            name: 'Incoming',
            type: 'bar',
            orientation: 'h',
            marker: { color: '#00BCD4' }
        };

        var plotlyData = [traceCapacity, traceIncoming];

        // --- LAYOUT ---
        var layout = getBaseLayout('Processing Plant for Dry Garbage');
        layout.barmode = 'group';
        layout.showlegend = true;

        layout.margin = {
            l: 250,   // Wide left margin for long plant names
            r: 40,
            t: 60,
            b: 60
        };

        layout.font = { size: 12, color: "#000" };

        layout.xaxis = {
            title: "Tons",
            titlefont: { size: 14 },
            automargin: true
        };

        layout.yaxis = {
            automargin: true
        };

        Plotly.newPlot(
            'processingPlantDryGarbageChart',
            plotlyData,
            layout,
            { responsive: true, displayModeBar: false }
        );
    }

    function renderBioGasProcessingKG() {
        $.ajax({
            type: "GET",
            url: "http://localhost:75/api/data/BiogasProcessing",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {

                // API already returns JSON, no JSON.parse needed
                var apiData = response;

                // Convert API response → Plotly format
                var plotlyData = [{
                    x: apiData.labels,       // X-axis categories
                    y: apiData.values,       // Y-axis values
                    type: "bar",
                    text: apiData.values,    // Show values on bar
                    textposition: "auto",
                    marker: {
                        line: { width: 1 }
                    }
                }];


                // Layout
                var layout = getBaseLayout('Bio Gas Processing Plant (KG)');
                layout.showlegend = false;
                layout.margin = { l: 250, r: 20, t: 40, b: 40 };


                layout.annotations = [{
                    font: { size: 20, color: '#000000' },
                    showarrow: false,
                    text: '',
                    x: 0.5,
                    y: 0.5
                }];

                Plotly.newPlot(
                    'BioGasProcessingPlant(KG)Chart',
                    plotlyData,
                    layout,
                    { responsive: true, displayModeBar: false }
                );
            },
            error: function (xhr) {
                console.log("AJAX error:", xhr.responseText);
            }
        });

        //// Note: The plant names in the array are repetitive; keeping them as provided.
        //const plants = [
        //    '5 MTPD Biogas Engener Biogas Slopes 1',
        //    '10 MTPD Biogas Engener Biogas Slopes 2',
        //    '5 MTPD Biogas Engener Biogas Slopes 3',
        //    '5 MTPD Biogas Engener Biogas Slopes 4',
        //    '5 MTPD Biogas Engener Biogas Slopes 5',
        //    '5 MTPD Biogas Engener Biogas Slopes 6'
        //];

        //// Plant Capacity (The larger, background bar - using a lighter blue, opacity 0.7)
        //var tracePlantCapacity = {
        //    y: plants.slice(0, 6),
        //    x: [10, 10, 10, 10, 10, 10],
        //    name: 'Plant Capacity',
        //    orientation: 'h',
        //    type: 'bar',
        //    marker: { color: '#29B6F6', opacity: 0.7 }
        //};

        //// Incoming (The smaller, foreground bar - using a darker, solid blue)
        //var traceIncoming = {
        //    y: plants.slice(0, 6),
        //    x: [10, 5, 8, 7, 5, 5],
        //    name: 'Incoming',
        //    orientation: 'h',
        //    type: 'bar',
        //    marker: { color: '#007AA3' } // Darker blue for visibility
        //};

        //// Plotting [Capacity, Incoming] ensures Capacity is drawn first (in the background)
        //var data = [tracePlantCapacity, traceIncoming];

        //var layout = getBaseLayout('Bio Gas Processing Plant (KG)');

        //// Explicitly set barmode for clarity
        //layout.barmode = 'overlay';

        //layout.xaxis = {
        //    title: 'KG',
        //    range: [0, 12] // Set max range slightly above max capacity (10)
        //};

        //// Increase left margin for long plant names to prevent truncation
        //layout.margin = { l: 250, r: 20, t: 40, b: 40 };

        //// Adjust y-axis font size and auto-margin for better fit of plant names
        //layout.yaxis = {
        //    automargin: true,
        //    tickfont: { size: 10 }
        //};

        //Plotly.newPlot('bioGasProcessingChartKG', data, layout, { responsive: true, displayModeBar: false });
    }

    function renderPostProcessingPlant() {

        $.ajax({
            type: "GET",
            url: "http://localhost:75/api/data/PostProcessing",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (apiData) {

                // Expected API Output:
                // apiData.labels => ["250 MTPD SA INFRA WAGHOLI C&D"]
                // apiData.capacity => [250]
                // apiData.incoming => [711.13]

                // --- TRACES (two grouped vertical bars) ---
                var traceCapacity = {
                    x: apiData.labels,
                    y: apiData.capacity,
                    name: "Plant Capacity",
                    type: "bar",
                    marker: { color: "#004d66" },
                    text: apiData.capacity,
                    textposition: "outside"
                };

                var traceIncoming = {
                    x: apiData.labels,
                    y: apiData.incoming,
                    name: "Incoming",
                    type: "bar",
                    marker: { color: "#00e5ff" },
                    text: apiData.incoming,
                    textposition: "outside"
                };

                var plotlyData = [traceCapacity, traceIncoming];

                // --- LAYOUT (Same as your card) ---
                var layout = getBaseLayout("Post Processing Plant (MT)");
                layout.barmode = "group";
                layout.showlegend = true;

                layout.margin = { l: 40, r: 160, t: 60, b: 80 };

                layout.xaxis = {
                    automargin: true
                };

                layout.yaxis = {
                    title: "Tons",
                    titlefont: { size: 14 },
                    range: [0, Math.max(500) + 100]  // Add some headroom
                };

                layout.font = { size: 12, color: "#000" };

                Plotly.newPlot(
                    "postProcessingPlantChart",
                    plotlyData,
                    layout,
                    { responsive: true, displayModeBar: false }
                );
            },
            error: function (xhr) {
                console.log("AJAX error:", xhr.responseText);
            }
        });

    }


    function renderWetWasteProcessingPlant() {

        showLoader("wetWasteProcessingPlant");

        $.ajax({
            type: "GET",
            url: "http://localhost:75/api/data/Wetwasteprocessing",
            contentType: "application/json; charset=utf-8",
            dataType: "json",

            success: function (apiData) {

                hideLoader("wetWasteProcessingPlant");

                var traceCapacity = {
                    x: apiData.capacity,  // plant capacity
                    y: apiData.labels,    // labels left side
                    name: "Plant Capacity",
                    type: "bar",
                    orientation: "h",
                    marker: {
                        color: "#81D4FA"
                    },
                    text: apiData.capacity,
                    textposition: "auto"
                };

                var traceIncoming = {
                    x: apiData.incoming,  // incoming waste
                    y: apiData.labels,
                    name: "Incoming",
                    type: "bar",
                    orientation: "h",
                    marker: {
                        color: "#29B6F6"
                    },
                    text: apiData.incoming,
                    textposition: "auto"
                };

                var plotlyData = [traceCapacity, traceIncoming];

                var layout = getBaseLayout("Wet Waste Processing Plant (MT)");

                layout.barmode = "group";   // side-by-side bars
                layout.showlegend = true;

                layout.margin = {
                    l: 250,   // to fit long labels
                    r: 50,
                    t: 60,
                    b: 80
                };

                layout.xaxis = {
                    title: "MT",
                    showgrid: true,
                    zeroline: false
                };

                layout.yaxis = {
                    automargin: true
                };

                Plotly.newPlot(
                    "wetWasteProcessingPlantChart",
                    plotlyData,
                    layout,
                    { responsive: true, displayModeBar: false }
                );
            },

            error: function (xhr) {
                hideLoader("wetWasteProcessingPlant");
                console.log("AJAX error:", xhr.responseText);
            }
        });
    }


    function renderFineCollection() {
        const reasons = ['Dumping on Streets, Drain', 'Burning Garbage', 'Not using Litter Bins', 'Urine and spit in public', 'Spitting in Public Areas', 'Throwing garbage on railway track'];
        var data = [{
            x: reasons,
            y: [1, 2, 4, 3, 4, 0.5],
            type: 'bar',
            marker: { color: '#6A5ACD' }
        }];
        var layout = getBaseLayout('Fine Collection (Total Fines: ₹3500)');
        layout.yaxis = { title: 'Count' };
        layout.xaxis = { automargin: true };

        Plotly.newPlot('fineCollectionChart', data, layout, { responsive: true, displayModeBar: false });
    }

    function renderAdhocSpecialWasteCD() {
        const categories = ['Habitable Waste Collected', 'Medical Waste Collected', 'Garden Waste Collected', 'Dead Animals Collected', 'Domestic Hazardous Waste Collected'];
        var data = [{
            x: categories,
            y: [0.5, 0.2, 0.3, 0.1, 0.4],
            type: 'bar',
            marker: { color: '#FF7F50' }
        }];
        var layout = getBaseLayout('Adhoc Special Waste C & D');
        layout.yaxis = { title: '' };
        layout.xaxis = { automargin: true, tickangle: -45 };

        Plotly.newPlot('adhocSpecialWasteCDChart', data, layout, { responsive: true, displayModeBar: false });
    }

    function renderAdhocSpecialWaste() {
        const categories = ['Waste Collection Completed', 'Burning Incident Resolved', 'Unattended Pit Resolved', 'Illegal Dumping Resolved', 'Water Supply Restored'];
        var data = [{
            x: categories,
            y: [0.8, 0.4, 0.5, 0.7, 0.2],
            type: 'bar',
            marker: { color: '#FFA500' }
        }];
        var layout = getBaseLayout('Adhoc Special Waste');
        layout.yaxis = { title: '' };
        layout.xaxis = { automargin: true, tickangle: -45 };

        Plotly.newPlot('adhocSpecialWasteChart', data, layout, { responsive: true, displayModeBar: false });
    }

    function renderTab2Charts() {
        renderRampWiseGarbage();
        renderProcessingPlant();
        renderBioGasProcessingKG();
        renderPostProcessingPlant();
        renderWetWasteProcessingPlant();
        renderFineCollection();
        renderAdhocSpecialWasteCD();
        renderAdhocSpecialWaste();
    }

    // --- EXECUTE ALL CHART RENDERING ON PAGE LOAD ---
    window.onload = function () {
        // Execute the charts for the initially active tab (Tab 2: Garbage/Waste Processing)
        renderTab1Charts();
    };

    </script>
         
    </div>
</asp:Content>
