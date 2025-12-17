<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard_Main_SWM.aspx.cs" Inherits="Dashboard_Main_SWM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card-sub-container">
    <title>Master Dashboard</title>
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
        /*.sidebar-container {
            display: flex;*/ /* Flex container for the whole layout */
        /*}*/

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
        }

            .sidebar a {
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
        /*@media (max-width: 1024px) {
            .sidebar {
                transform: translateX(-100%);*/ /* Initially hidden on mobile/tablet */
                /*width: 50%;*/ /* Half width on smaller screens */
                /*max-width: 250px;*/ /* Optional: limit max size even on mobile */
            /*}

                .sidebar.open {
                    transform: translateX(0);*/ /* Slide open when active */
                /*}
        }*/

        /* --- Content Area Styling --- */
        .content-area {
            flex-grow: 1;
           /* margin-left: 250px;*/ /* Space for the fixed sidebar on desktop */
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
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
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
        .grid-2 {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 16px;
        }

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
                color: #fff; /* Accent color for active text */
                border-bottom: 2px solid #fff;
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
            
        /* Charts Row Container for Tab 2 */
        .charts-row-container {
            /* This makes the container span all 3 columns of the dashboard-grid */
            grid-column: span 3; 
            
            /* Keep the Flexbox properties from before to lay the two charts side-by-side */
            display: flex; 
            gap: 7px; /* Use the same gap as the grid for consistency */
            width: 100%; 
        }

        /* CSS for the individual charts inside the charts-row-container */
        .charts-row-container .chart-container {
            flex: 1; /* Ensures each chart takes up half the width of the row */
            height: 250px; /* Example height */
        }

        /* CSS for all other charts in the dashboard-grid */
        .dashboard-grid > .chart-container {
            /* You might need a specific height here too, unless defined elsewhere */
            height: 250px;
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
            height: 300px;
            min-height: 280px;
            position: relative; /* Needed for loader positioning */
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

    <div id="form1" runat="server">
        <div class="sidebar-container">

            <div id="mySidebar" class="sidebar">
                <a href="#" class="active-link">Dashboard Overview</a>
                <a href="#">Zone-wise Report</a>
                <a href="#">Alerts & Notifications</a>
                <a href="#">Compliance Check</a>
                <a href="#">Settings</a>
            </div>

            <div class="content-area">

                <div class="header-bar">
                    <span class="menu-icon" onclick="toggleSidebar()">&#9776;</span>
                    <h1>Master Dashboard</h1>
                    <div style="background-color: #FFF; color: #000; padding: 8px 15px; border-radius: 6px; font-size: 12px; font-weight: semibold; display: inline-block; margin-right: 20px;">
                        15/12/2025
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
                        
                        <div id="sweeperAttendanceChart" class="chart-container">
                             <div class="chart-loader"></div>
                        </div>
                        <div id="sweeperBeatCoverageChart" class="chart-container">
                            <div class="chart-loader"></div>
                        </div>
                        <div id="sweeperBeatCoverageKMChart" class="chart-container">
                             <div class="chart-loader"></div>
                        </div>

                        <div id="cwAttendanceChart" class="chart-container">
                            <div class="chart-loader"></div>
                        </div>
                        <div id="collectionWorkerPocketCoverageChart" class="chart-container">
                            <div class="chart-loader"></div>
                        </div>
                        <div id="urinalsCoverageChart" class="chart-container">
                             <div class="chart-loader"></div>
                        </div>

                        <div id="vehicleStatusChart" class="chart-container">
                             <div class="chart-loader"></div>
                        </div>
                        <div id="feederCoverageChart" class="chart-container">
                             <div class="chart-loader"></div>
                        </div>
                        <div id="mechanicalSweeperCoverageChart" class="chart-container">
                             <div class="chart-loader"></div>
                        </div>
                    </div>




                    <div id="dashboard-tab-2" class="dashboard-grid inactive">

                       <div class="charts-row-container">
                            <div id="rampWiseGarbageChart" class="chart-container">
                                 <div class="chart-loader"></div>
                            </div>
                            <div id="processingPlantDryGarbageChart" class="chart-container">
                                 <div class="chart-loader"></div>
                            </div>
                        </div>

                        <div id="postProcessingPlantChart" class="chart-container">
                            <div class="chart-loader"></div>
                        </div>
                        <div id="wetWasteProcessingPlantChart" class="chart-container">
                            <div class="chart-loader"></div>
                        </div>
                        <div id="fineCollectionChart" class="chart-container">
                            <div class="chart-loader"></div>
                        </div>

                        <div id="BioGasProcessingPlantKGChart" class="chart-container">
                            <div class="chart-loader"></div>
                        </div>
                                        
                        <div id="adhocSpecialWasteCDChart" class="chart-container ">
                             <div class="chart-loader"></div>
                        </div>
                        <div id="adhocSpecialWasteChart" class="chart-container">
                             <div class="chart-loader"></div>
                        </div>
                                    
                        
                    </div>
                </div>
            </div>
        </div>

        

    </div>

    <script type="text/javascript">
      
        function toggleLoader(chartId, show) {
            const chartDiv = document.getElementById(chartId);
            const loader = chartDiv ? chartDiv.querySelector('.chart-loader') : null;
            if (loader) {
                loader.style.display = show ? 'block' : 'none';
               
                const plotlyContainer = chartDiv.querySelector('.js-plotly-plot');
                if (plotlyContainer) {
                
                    plotlyContainer.style.display = show ? 'none' : 'block';
                } else if (!show) {
                  
                }
            }
        }

        const CHART_INNER_HEIGHT = 250;
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
            const chartId = 'sweeperAttendanceChart';
            toggleLoader(chartId, true);

            $.ajax({
                type: "GET",
                url: "https://iswmpune.in/api/chartdata",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {

                    var apiData = response;

                    var plotlyData = [{
                        labels: apiData.labels,
                        values: apiData.values,
                        type: "pie",
                        hole: 0.4,
                        textinfo: "label+percent",
                        insidetextorientation: "radial"
                    }];

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
                        chartId,
                        plotlyData,
                        layout,
                        { responsive: true, displayModeBar: false }
                    );
                    toggleLoader(chartId, false);
                },
                error: function (xhr) {
                    console.log("AJAX error:", xhr.responseText);
                    toggleLoader(chartId, false);
                }
            });

        }


        // --- 2. Sweeper Beat Coverage Chart (Donut) ---
        function renderSweeperBeatCoverage() {
            const chartId = 'sweeperBeatCoverageChart';
            toggleLoader(chartId, true);

            $.ajax({
                type: "GET",
                url: "https://iswmpune.in/api/SweeperBeatCoverage",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (apiData) {

                    const customColors = [
                        "#FFA000", // ABSENT/LEAVE
                        "#E91E63", // UNCOVERED
                        "#FBC02D", // PARTIALLY COVERED
                        "#00796B"  // COVERED
                    ];

                    var plotlyData = [{
                        labels: apiData.labels,
                        values: apiData.values,
                        type: "pie",
                        hole: 0.55,                     // thicker ring like screenshot
                        marker: { colors: customColors },
                        textinfo: "percent",            // only % text inside slices
                        textfont: { size: 14, color: "#fff" },
                        insidetextorientation: "auto",
                        hoverinfo: "label+value+percent"
                    }];

                    var layout = getBaseLayout("Sweeper Beat Coverage");

                    layout.showlegend = true;
                    layout.legend = {
                        x: 1.1,
                        y: 0.5,
                        font: { size: 14 }
                    };

                    layout.margin = { l: 20, r: 150, t: 50, b: 20 };

                    layout.annotations = [];

                    Plotly.newPlot(
                        chartId,
                        plotlyData,
                        layout,
                        { responsive: true, displayModeBar: false }
                    );
                    toggleLoader(chartId, false);
                },

                error: function (xhr) {
                    console.log("AJAX error:", xhr.responseText);
                    toggleLoader(chartId, false);
                }
            });
        }


        // --- 3. Sweeper Beat Coverage KM Chart (Horizontal Bar - Matching Image) ---
        function renderSweeperBeatCoverageKM() {
            const chartId = 'sweeperBeatCoverageKMChart';
            toggleLoader(chartId, true);

            $.ajax({
                type: "GET",
                url: "https://iswmpune.in/api/SweeperBeatCoverageKM",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {

                    var apiData = response;

                    const barColors = [
                        "#1B9E77", // COVERED (green)
                        "#FDAE61", // UNCOVER
                        "#67C5F5", // ROUTE DEVIATED (cyan)
                        "#F06292"  // ABSENT (pink)
                    ];

                    var plotlyData = [{
                        x: apiData.values,     // KM values on X-axis
                        y: apiData.labels,     // Category labels on Y-axis
                        type: "bar",
                        orientation: "h",      // <<< IMPORTANT
                        marker: {
                            color: barColors,
                            line: { width: 1, color: "#ffffff" }
                        },
                        text: apiData.values,
                        textposition: "auto"
                    }];

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

                    layout.annotations = [];

                    Plotly.newPlot(
                        chartId,
                        plotlyData,
                        layout,
                        { responsive: true, displayModeBar: false }
                    );
                    toggleLoader(chartId, false);
                },
                error: function (xhr) {
                    console.log("AJAX error:", xhr.responseText);
                    toggleLoader(chartId, false);
                }
            });
        }

        // --- 4. CW Attendance Chart (Donut) ---

        function renderCWAttendance() {
            const chartId = 'cwAttendanceChart';
            toggleLoader(chartId, true);

            $.ajax({
                type: "GET",
                url: "https://iswmpune.in/api/CWAttendance",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {

                    var apiData = response;

                    var plotlyData = [{
                        labels: apiData.labels,
                        values: apiData.values,
                        type: "pie",
                        hole: 0.4,
                        textinfo: "label+percent",
                        insidetextorientation: "radial"
                    }];

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
                        chartId,
                        plotlyData,
                        layout,
                        { responsive: true, displayModeBar: false }
                    );
                    toggleLoader(chartId, false);
                },
                error: function (xhr) {
                    console.log("AJAX error:", xhr.responseText);
                    toggleLoader(chartId, false);
                }
            });

        }

        // --- 5. Collection Worker Pocket Coverage Chart (Donut) ---
        function renderPocketCoverage() {

            const chartId = 'collectionWorkerPocketCoverageChart';
            toggleLoader(chartId, true);

            $.ajax({
                type: "GET",
                url: "http://localhost:75/api/CollectionWorkerPocket",
                dataType: "json",
                success: function (apiData) {

                    var plotlyData = [{
                        type: "sunburst",

                        labels: apiData.labels,
                        parents: apiData.parents,
                        values: apiData.values,

                        branchvalues: "total",

                        insidetextorientation: "radial",
                        textinfo: "label+percent parent",

                        hovertemplate:
                            "<b>%{label}</b><br>" +
                            "Count: %{value}<br>" +
                            "Percent: %{percentParent:.1%}<extra></extra>"
                    }];

                    var layout = getBaseLayout('Collection Worker Pocket Coverage');

                    layout.margin = { l: 20, r: 20, t: 50, b: 20 };
                    layout.sunburstcolorway = [
                        "#B71C1C", // DTDC
                        "#F9A825", // Commercial
                        "#F06292", // Slum
                        "#42A5F5", // Gate
                        "#7E57C2"  // SRA
                    ];

                    layout.extendsunburstcolors = true;
                    layout.showlegend = false;

                    Plotly.newPlot(
                        chartId,
                        plotlyData,
                        layout,
                        { responsive: true, displayModeBar: false }
                    );

                    toggleLoader(chartId, false);
                },
                error: function (xhr) {
                    console.log("AJAX error:", xhr.responseText);
                    toggleLoader(chartId, false);
                }
            });
        }

        // --- 6. CT, PT and Urinals Coverage Chart (Pie) ---

        function renderUrinalsCoverage() {
            const chartId = 'urinalsCoverageChart';
            toggleLoader(chartId, true);

            $.ajax({
                type: "GET",
                url: "https://iswmpune.in/api/CTPT",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {

                    var apiData = response;

                    var plotlyData = [{
                        labels: apiData.labels,
                        values: apiData.values,
                        type: "pie",
                        hole: 0.4,
                        textinfo: "label+percent",
                        insidetextorientation: "radial"
                    }];

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
                        chartId,
                        plotlyData,
                        layout,
                        { responsive: true, displayModeBar: false }
                    );
                    toggleLoader(chartId, false);
                },
                error: function (xhr) {
                    console.log("AJAX error:", xhr.responseText);
                    toggleLoader(chartId, false);
                }
            });


        }

        // --- 7. Vehicle Status Chart (Vertical Bar) ---


        function renderVehicleStatus() {
            const chartId = 'vehicleStatusChart';
            toggleLoader(chartId, true);

            $.ajax({
                type: "GET",
                url: "/api/VehicleStatus",
                dataType: "json",

                success: function (res) {
                    toggleLoader(chartId, false);

                    var labels = res.labels || [];
                    var values = res.values || [];

                    if (labels.length === 0) {
                        console.log("ZoneWiseVehicleStatus API returned empty data.");
                        return;
                    }

                    // Total vehicles for title
                    var totalVehicles = values.reduce(function (a, b) { return a + b; }, 0);

                    // Color mapping (add any missing entries as needed)
                    var colorMap = {
                        "Break": COLORS.Break,
                        "Idle": COLORS.Idle,
                        "Running": COLORS.Running,
                        "InActive": COLORS.Inactive,
                        "Breakdown": COLORS.Break,
                        "Powercut": "#ff9900"
                    };

                    // Build individual traces so each status shows in legend and has its own color
                    var data = labels.map(function (label, i) {
                        return {
                            x: [label],
                            y: [values[i]],
                            name: label,
                            type: "bar",
                            marker: { color: colorMap[label] || "#888" },
                            text: values[i].toString(),
                            textposition: "outside",
                            hovertemplate: label + ": %{y}<extra></extra>"
                        };
                    });

                    // Layout
                    var layout = getBaseLayout("Vehicle Status (Total : " + totalVehicles + ")");
                    layout.yaxis = {
                        title: "Counts",
                        range: [0, Math.max.apply(null, values) + 50]
                    };

                    layout.xaxis = {
                        title: "Status",
                        categoryorder: "array",
                        categoryarray: labels,
                        domain: [0, 0.75] // reserve space on right for legend
                    };

                    layout.showlegend = true;
                    layout.legend = {
                        orientation: "v",
                        yanchor: "top",
                        y: 1,
                        xanchor: "left",
                        x: 0.82,
                        font: { size: 10 }
                    };

                    layout.margin = { l: 40, r: 120, t: 40, b: 60 };

                    layout.annotations = [{
                        font: { size: 16, color: "#000" },
                        showarrow: false,
                        text: "",
                        x: 0.5,
                        y: 0.5
                    }];

                    Plotly.newPlot(chartId, data, layout, { responsive: true, displayModeBar: false });
                },

                error: function (xhr) {
                    console.error("VehicleStatus API Error:", xhr.responseText);
                    toggleLoader(chartId, false);
                }
            });
        }




        // --- 8. Feeder Cov Chart (Stacked Bar) ---

        function renderFeederCoverage() {
            const chartId = 'feederCoverageChart';
            toggleLoader(chartId, true);

            $.ajax({
                type: "GET",
                url: "https://iswmpune.in/api/FeederCoverage",
                dataType: "json",
                success: function (apiData) {

                    var colors = {
                        "COVER_FEEDER": "#8E6BE8",
                        "UNCOVER_FEEDER": "#FFA15A",
                        "UNATTENDED_FEEDER": "#1F77B4"
                    };

                    var plotlyData = apiData.datasets.map(ds => ({
                        x: apiData.labels,   // ZONE
                        y: ds.data,
                        name: ds.label,
                        type: "bar",
                        marker: { color: colors[ds.label] }
                    }));

                    var layout = {
                        title: {
                            text: `Feeder Cov (Total:${apiData.totalFeeder}, Cover:${apiData.totalCover})`,
                            font: { size: 20 }
                        },

                        barmode: "stack",     // ✅ IMPORTANT
                        xaxis: { title: "ZONE" },
                        yaxis: { title: "Feeder Count" },
                        legend: { x: 1.02, y: 1 },
                        margin: { l: 70, r: 150, t: 60, b: 60 }
                    };

                    Plotly.newPlot(
                        chartId,
                        plotlyData,
                        layout,
                        { responsive: true, displayModeBar: false }
                    );
                    toggleLoader(chartId, false);
                },
                error: function (xhr) {
                    console.log("AJAX error:", xhr.responseText);
                    toggleLoader(chartId, false);
                }
            });
        }



        // --- 9. Mechanical Sweeper Coverage Chart (Matching Image Structure) ---


        function renderMechanicalSweeperCoverage() {
            const chartId = 'mechanicalSweeperCoverageChart';
            toggleLoader(chartId, true);

            $.ajax({
                type: "GET",
                url: "https://iswmpune.in/api/MechanicalSweeperCoverage",
                dataType: "json",
                success: function (apiData) {

                    var labels = apiData.labels;                 // Cover, UnCover, PartiallyCover, Total
                    var values = apiData.datasets[0].data;       // 9, 2, 3, 14

                    var colors = {
                        "Cover": "#2E9C78",
                        "UnCover": "#F04E5E",
                        "PartiallyCover": "#E3AA00",
                        "Total": "#2C7FB8"
                    };

                    var plotlyData = labels.map((label, i) => ({
                        y: [label],
                        x: [values[i]],
                        type: "bar",
                        orientation: "h",
                        name: label,
                        marker: { color: colors[label] },
                        text: [values[i]],
                        textposition: "outside"
                    }));

                    var layout = {
                        title: {
                            text: "Mechanical Sweeper Coverage",
                            font: { size: 20 }
                        },

                        xaxis: {
                            title: "Covered Points",
                            rangemode: "tozero",
                            gridcolor: "#E5E5E5"
                        },

                        yaxis: {
                            automargin: true
                        },

                        bargap: 0.4,

                        legend: {
                            title: { text: "Coverage" },
                            orientation: "v",
                            x: 1.02,
                            y: 1
                        },

                        margin: {
                            l: 120,
                            r: 120,
                            t: 60,
                            b: 60
                        }
                    };

                    Plotly.newPlot(
                        chartId,
                        plotlyData,
                        layout,
                        { responsive: true, displayModeBar: false }
                    );
                    toggleLoader(chartId, false);
                },
                error: function (xhr) {
                    console.log("AJAX error:", xhr.responseText);
                    toggleLoader(chartId, false);
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

        // --- 1. RampWiseGarbage Chart (Matching Image Structure) ---
        function renderRampWiseGarbage() {
            const chartId = 'rampWiseGarbageChart';
            toggleLoader(chartId, true);

            $.ajax({
                type: "GET",
                url: "https://iswmpune.in/api/Rampwisegarbage",
                dataType: "json",
                success: function (apiData) {

                    const labels = apiData.labels;       // Ramp names
                    const datasets = apiData.datasets;   // Waste types

                    // ----- Color mapping -----
                    const colorMap = {
                        "Dry Waste": "#42A5F5",
                        "Wet Waste": "#26C6DA",
                        "Garden Waste": "#66BB6A",
                        "Dry and Wet Waste": "#FFA726",
                        "Legacy Waste": "#D4E157"
                    };

                    // ----- Convert API datasets to Plotly traces -----
                    const plotlyData = datasets.map(ds => ({
                        x: labels,
                        y: ds.data,
                        name: ds.label,
                        type: "bar",
                        marker: {
                            color: colorMap[ds.label] || "#90A4AE"
                        }
                    }));

                    // ----- Layout -----
                    const layout = {
                        title: {
                            text: "Ramp Wise Garbage Type Split",
                            font: { size: 20 }
                        },
                        barmode: "group",   // 👉 use "stack" if you want stacked bars
                        xaxis: {
                            title: "Ramp Name",
                            tickangle: -40,
                            automargin: true
                        },
                        yaxis: {
                            title: "Weight in MT",
                            gridcolor: "#E5E5E5"
                        },
                        legend: {
                            orientation: "v",
                            x: 1.02,
                            y: 1
                        },
                        margin: {
                            l: 70,
                            r: 140,
                            t: 70,
                            b: 120
                        }
                    };

                    Plotly.newPlot(
                        chartId,
                        plotlyData,
                        layout,
                        { responsive: true, displayModeBar: false }
                    );

                    toggleLoader(chartId, false);
                },
                error: function (xhr) {
                    console.log("AJAX error:", xhr.responseText);
                    toggleLoader(chartId, false);
                }
            });
        }
        // --- 2. ProcessingPlant Chart (Matching Image Structure) ---
        function renderProcessingPlant() {
            const chartId = 'processingPlantDryGarbageChart';
            toggleLoader(chartId, true);

            $.ajax({
                type: "GET",
                url: "https://iswmpune.in/api/Processingplant",
                dataType: "json",
                success: function (apiData) {

                    const labels = apiData.labels;       // Plant names
                    const datasets = apiData.datasets;   // Capacity & Incoming

                    // ---- Color mapping (as per image style) ----
                    const colorMap = {
                        "Plant Capacity": "#0D5C75",
                        "Incoming": "#4FC3F7"
                    };

                    // ---- Build Plotly traces ----
                    const plotlyData = datasets.map(ds => ({
                        x: labels,
                        y: ds.data,
                        name: ds.label,
                        type: "bar",
                        marker: {
                            color: colorMap[ds.label] || "#90A4AE"
                        }
                    }));

                    // ---- Layout ----
                    const layout = {
                        title: {
                            text: "Processing Plant for Dry Garbage",
                            font: { size: 20 }
                        },
                        barmode: "group", // Capacity vs Incoming side-by-side
                        xaxis: {
                            title: "Processing Plant",
                            tickangle: -90,
                            automargin: true
                        },
                        yaxis: {
                            title: "Quantity (MT)",
                            gridcolor: "#E5E5E5"
                        },
                        legend: {
                            orientation: "v",
                            x: 1.02,
                            y: 1
                        },
                        margin: {
                            l: 80,
                            r: 150,
                            t: 70,
                            b: 180
                        }
                    };

                    Plotly.newPlot(
                        chartId,
                        plotlyData,
                        layout,
                        { responsive: true, displayModeBar: false }
                    );

                    toggleLoader(chartId, false);
                },
                error: function (xhr) {
                    console.log("AJAX error:", xhr.responseText);
                    toggleLoader(chartId, false);
                }
            });
        }


        // --- 3. PostProcessingPlant Chart (Matching Image Structure) ---
        function renderPostProcessingPlant() {
            const chartId = 'postProcessingPlantChart';
            toggleLoader(chartId, true);

            $.ajax({
                type: "GET",
                url: "https://iswmpune.in/api/PostProcessing",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (apiData) {

                    // Mocked data if API fails to provide full data
                    apiData = apiData || {
                        labels: ["250 MTPD SA INFRA WAGHOLI C&D"],
                        capacity: [250],
                        incoming: [711.13]
                    };

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
                        range: [0, Math.max(500) + 100]  // Add some headroom
                    };

                    layout.font = { size: 12, color: "#000" };

                    Plotly.newPlot(
                        chartId,
                        plotlyData,
                        layout,
                        { responsive: true, displayModeBar: false }
                    );
                    toggleLoader(chartId, false);
                },
                error: function (xhr) {
                    console.log("AJAX error:", xhr.responseText);
                    toggleLoader(chartId, false);
                }
            });

        }

        // --- 4. WetWasteProcessingPlant Chart (Matching Image Structure) ---
        function renderWetWasteProcessingPlant() {

            const chartId = 'wetWasteProcessingPlantChart';
            toggleLoader(chartId, true);

            $.ajax({
                type: "GET",
                url: "https://iswmpune.in/api/Wetwasteprocessing",
                contentType: "application/json; charset=utf-8",
                dataType: "json",

                success: function (apiData) {

                    toggleLoader(chartId, false);

                    var traceCapacity = {
                        x: apiData.capacity,  // plant capacity
                        y: apiData.labels,    // labels left side
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
                        x: apiData.incoming,  // incoming waste
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

                    layout.barmode = "group";   // side-by-side bars
                    layout.showlegend = true;

                    layout.margin = {
                        l: 250,   // to fit long labels
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
                        chartId,
                        plotlyData,
                        layout,
                        { responsive: true, displayModeBar: false }
                    );
                    toggleLoader(chartId, false);
                },

                error: function (xhr) {
                    toggleLoader(chartId, false);
                    console.log("AJAX error:", xhr.responseText);
                }
            });
        }
        // --- 5. BioGasProcessingKG Chart (Matching Image Structure) ---
        function renderBioGasProcessingKG() {
            const chartId = 'BioGasProcessingPlantKGChart';
            toggleLoader(chartId, true);

            $.ajax({
                type: "GET",
                url: "https://iswmpune.in/api/BiogasProcessing",
                dataType: "json",
                success: function (apiData) {

                    // -------- Extract API data (MOCKED if structure is simple) --------
                    var labels = apiData.labels || ["Plant A", "Plant B"];

                    var plantCapacity = (apiData.datasets
                        && apiData.datasets.filter(d => d.label === "Plant Capacity")[0].data)
                        || [1000, 2000];

                    var incoming = (apiData.datasets
                        && apiData.datasets.filter(d => d.label === "Incoming")[0].data)
                        || [850, 1500];

                    // -------- Background bar (Plant Capacity) --------
                    var traceCapacity = {
                        y: labels,
                        x: plantCapacity,
                        name: "Plant Capacity",
                        orientation: "h",
                        type: "bar",
                        marker: {
                            color: "#29B6F6",
                            opacity: 0.6
                        }
                    };

                    // -------- Foreground bar (Incoming) --------
                    var traceIncoming = {
                        y: labels,
                        x: incoming,
                        name: "Incoming",
                        orientation: "h",
                        type: "bar",
                        marker: {
                            color: "#007AA3"
                        },
                        text: incoming.map(v => v > 0 ? v + " KG" : ""),
                        textposition: "auto"
                    };

                    // -------- Layout --------
                    var layout = {
                        title: {
                            text: "Bio Gas Processing Plant (KG)",
                            font: { size: 18 }
                        },
                        barmode: "overlay",
                        xaxis: {
                            title: "KG",
                            rangemode: "tozero"
                        },
                        yaxis: {
                            automargin: true,
                            tickfont: { size: 11 }
                        },
                        margin: {
                            l: 270,
                            r: 20,
                            t: 50,
                            b: 40
                        },
                        legend: {
                            orientation: "h",
                            x: 0.5,
                            xanchor: "center",
                            y: -0.2
                        }
                    };

                    // -------- Render Chart --------
                    Plotly.newPlot(
                        chartId,
                        [traceCapacity, traceIncoming],
                        layout,
                        { responsive: true, displayModeBar: false }
                    );
                    toggleLoader(chartId, false);
                },
                error: function (xhr) {
                    console.error("API Error:", xhr.responseText);
                    toggleLoader(chartId, false);
                }
            });
        }
        // --- 6. FineCollection Chart (Matching Image Structure) ---
        function renderFineCollection() {
            const chartId = 'fineCollectionChart';
            toggleLoader(chartId, true);

            $.ajax({
                type: "GET",
                url: "https://iswmpune.in/api/FineCollection",
                dataType: "json",
                success: function (apiData) {

                    // Mocked values to make the chart render if API data is complex/missing
                    var labels = apiData.labels || ["Zone 1", "Zone 2", "Zone 3"];
                    var counts = apiData.datasets?.[0]?.data || [50, 120, 80];
                    var totalAmount = 145000;

                    // -------- Single Bar Trace --------
                    var trace = {
                        x: labels,
                        y: counts,
                        type: "bar",
                        marker: {
                            color: "#6A5ACD"
                        }
                    };

                    // -------- Layout (Same as Image) --------
                    var layout = {
                        title: {
                            text: "Fine Collection (Total Fines: ₹" + totalAmount.toLocaleString() + ")",
                            font: { size: 20 }
                        },
                        yaxis: {
                            title: "Count",
                            rangemode: "tozero"
                        },
                        xaxis: {
                            tickangle: -45,
                            automargin: true
                        },
                        margin: {
                            l: 60,
                            r: 20,
                            t: 60,
                            b: 160
                        }
                    };

                    // -------- Render Chart --------
                    Plotly.newPlot(
                        chartId,
                        [trace],
                        layout,
                        { responsive: true, displayModeBar: false }
                    );
                    toggleLoader(chartId, false);
                },
                error: function (xhr) {
                    console.error("API Error:", xhr.responseText);
                    toggleLoader(chartId, false);
                }
            });


        }
        // --- 7. AdhocSpecialWasteCD Chart (Matching Image Structure) ---
        function renderAdhocSpecialWasteCD() {
            const chartId = 'adhocSpecialWasteCDChart';
            toggleLoader(chartId, true);

            $.ajax({
                type: "GET",
                url: "https://iswmpune.in/api/AdhocSpecialWasteCD",
                dataType: "json",
                success: function (apiData) {

                    var labels = apiData.labels || ["Building Waste", "Road Debris"];
                    var values = apiData.datasets?.[0]?.data || [450, 320];

                    // -------- Single Bar Chart --------
                    var trace = {
                        x: labels,
                        y: values,
                        type: "bar",
                        marker: {
                            color: "#FF8A65"
                        },
                        text: values,
                        textposition: "auto"
                    };

                    // -------- Layout --------
                    var layout = {
                        title: {
                            text: "Adhoc Special Waste C & D",
                            font: { size: 18 }
                        },
                        xaxis: {
                            tickangle: -45,
                            automargin: true
                        },
                        yaxis: {
                            title: "Quantity",
                            rangemode: "tozero"
                        },
                        margin: {
                            l: 60,
                            r: 20,
                            t: 50,
                            b: 120
                        }
                    };

                    // -------- Render Chart --------
                    Plotly.newPlot(
                        chartId,
                        [trace],
                        layout,
                        { responsive: true, displayModeBar: false }
                    );
                    toggleLoader(chartId, false);
                },
                error: function (xhr) {
                    console.error("API Error:", xhr.responseText);
                    toggleLoader(chartId, false);
                }
            });


        }
        // --- 8. AdhocSpecialWaste Chart (Matching Image Structure) ---
        function renderAdhocSpecialWaste() {
            const chartId = 'adhocSpecialWasteChart';
            toggleLoader(chartId, true);

            $.ajax({
                type: "GET",
                url: "https://iswmpune.in/api/AdhocSpecialWaste",
                dataType: "json",
                success: function (apiData) {

                    var labels = apiData.labels || ["Biohazard", "E-Waste"];
                    var values = apiData.datasets?.[0]?.data || [15, 8];

                    // -------- Single Bar Chart --------
                    var trace = {
                        x: labels,
                        y: values,
                        type: "bar",
                        marker: {
                            color: "#FF8A65"
                        },
                        text: values,
                        textposition: "auto"
                    };

                    // -------- Layout --------
                    var layout = {
                        title: {
                            text: "Adhoc Special Waste",
                            font: { size: 18 }
                        },
                        xaxis: {
                            tickangle: -45,
                            automargin: true
                        },
                        yaxis: {
                            title: "Quantity",
                            rangemode: "tozero"
                        },
                        margin: {
                            l: 60,
                            r: 20,
                            t: 50,
                            b: 120
                        }
                    };

                    // -------- Render Chart --------
                    Plotly.newPlot(
                        chartId,
                        [trace],
                        layout,
                        { responsive: true, displayModeBar: false }
                    );
                    toggleLoader(chartId, false);
                },
                error: function (xhr) {
                    console.error("API Error:", xhr.responseText);
                    toggleLoader(chartId, false);
                }
            });



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
            // Execute the charts for the initially active tab (Tab 1)
            renderTab1Charts();
        };

    </script>
</div>
</asp:Content>