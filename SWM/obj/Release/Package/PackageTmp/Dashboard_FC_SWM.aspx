<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard_FC_SWM.aspx.cs" Inherits="Dashboard_FC_SWM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card-sub-container">

    <title>Feeder Coverage Dashboard</title>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.plot.ly/plotly-2.30.0.min.js"></script>
    <style>
        /* --- Base & Background Styles --- */
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

        /* --- Filter Bar Styling (3-Column Grid) --- */
        .filter-bar {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 10px;
            padding: 10px 10px;
            background-color:transparent;
            border-radius: 4px;
            margin-bottom: 7px;
            align-items: center;
        }

        

        .filter-bar select {
            width: 100%;
            padding: 8px 12px;
            border-radius: 4px;
            
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
            padding: 10px;
        }

        /* Top row: 3 equal charts */
        .grid-3-col {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 7px;
            margin-bottom: 7px;
        }

        /* Middle/Bottom rows */
        .grid-1-col {
            margin-bottom: 7px;
        }

        /* --- Card and Chart Container Styling (White Background) --- */
        .chart-card, .table-card {
            background-color: #FFFFFF;
            color: #000;
            padding: 10px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
            min-height: 300px; 
            display: flex;
            flex-direction: column;
            position: relative; /* Added for loader positioning */
        }
        .plotly-chart {
            flex-grow: 1;
            min-height: 270px; 
        }
        
        /* --- Top 40 Chart Specific Styles --- */
        .top40-header {
            font-size: 18px;
            font-weight: bold;
            padding-bottom: 10px;
            border-bottom: 1px solid #ccc;
            margin-bottom: 5px;
        }
        #top40ChartContainer {
            min-height: 400px;
            height: 400px; 
        }
        
        /* NEW: Download Link Style */
        .download-link {
            text-align: right;
            padding-top: 5px;
            font-size: 14px;
        }
        .download-link a {
            color: #007AA3; /* Cyan blue for links */
            text-decoration: none;
            font-weight: bold;
            text-decoration: underline;
        }
        .download-link a:hover {
            text-decoration: underline;
        }

        /* --- Table Styling --- */
        .table-card { padding: 0; overflow-x: auto; }
        .table-title-bar { padding: 15px 15px 10px 15px; border-bottom: 1px solid #eee; }
        .data-table {
            width: 100%; border-collapse: collapse; text-align: left; font-size: 12px;
        }
        .data-table th, .data-table td {
            padding: 10px; border-bottom: 1px solid #eee; white-space: nowrap;
        }
        .data-table th { background-color: #3f51b5; font-weight: bold; text-transform: uppercase; }

        /* Footer/Bottom Bar Style */
        .table-footer {
            background-color: #e0f7fa; 
            padding: 10px; text-align: center; font-weight: bold; font-size: 14px; color: #007AA3;
            border-radius: 0 0 8px 8px;
        }
        
        /* NEW: Pagination Styles */
        .pagination {
            padding: 10px 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #f5f5f5;
            border-top: 1px solid #eee;
        }
        .pagination button {
            background-color: #0d47a1;
            color: #fff;
            border: none;
            padding: 5px 10px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 12px;
        }
        .pagination button:hover {
            background-color: #3f51b5;
        }
        .pagination span {
            font-size: 12px;
            color: #333;
        }

        /* --- Responsive Adjustments --- */
        @media (max-width: 1200px) {
            .grid-3-col {
                grid-template-columns: repeat(2, 1fr);
            }
        }
        @media (max-width: 768px) {
            .filter-bar {
                grid-template-columns: 1fr;
            }
            .grid-3-col {
                grid-template-columns: 1fr;
            }
            .chart-card, .table-card {
                min-height: 300px;
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
        <div class="header-bar">
            <h1>Feeder Coverage Dashboard</h1>
            <div>Settings | User Name</div>
        </div>

        <div class="dashboard-container">
            
            <div class="filter-bar">
                <div class="filter-group">
                    
                    <select id="selectZone">
                        <option value="all">Select Zones</option>
                        <option value="zone1">Zone 1</option>
                        <option value="zone2">Zone 2</option>
                        <option value="zone3">Zone 3</option>
                    </select>
                </div>
                
                <div class="filter-group">
                    
                    <select id="selectWard">
                        <option value="all">Select Wards</option>
                        <option value="wardA">Ward A</option>
                        <option value="wardB">Ward B</option>
                        <option value="wardC">Ward C</option>
                    </select>
                </div>
                
                <div class="filter-group">
                    
                    <select id="selectVehicle">
                        <option value="all">Select Vehicles Number</option>
                        <option value="truck001">Truck 001 - Tata Ace 2023</option>
                        <option value="loader002">Loader 002 - JCB 2024</option>
                        <option value="sweeper003">Sweeper 003 - Dulevo 6000</option>
                    </select>
                </div>
            </div>

            <div class="grid-3-col">
                <div class="chart-card">
                    <div class="chart-loader"></div> 
                    <div id="feederOverallChart" class="plotly-chart"></div>
                </div>

                <div class="chart-card">
                    <div class="chart-loader"></div> 
                    <div id="feederZoneWiseChart" class="plotly-chart"></div>
                </div>

                <div class="chart-card">
                    <div class="chart-loader"></div> 
                    <div id="feederWardWiseChart" class="plotly-chart"></div>
                </div>
            </div>

            <div class="grid-1-col">
                <div id="top40SummaryChart" class="chart-card">
                    <div class="top40-header">TOP 40 Feeder Coverage Summary</div>
                    <div class="chart-loader"></div> 
                    <div id="top40ChartContainer" class="plotly-chart"></div>
                    
                
                </div>
            </div>

            <div class="grid-1-col">
                <div class="table-card">
                    <div class="table-title-bar">
                        <span class="top40-header" style="border-bottom: none; margin-bottom: 0;">Last 5 Days Average Coverage by Vehicles</span>
                        <span style="font-size: 12px; float: right; color: #666;">(Pits Download Excel for Complete List)</span>
                            <div class="download-link">
          <a href="data/top40_coverage_export.xlsx" >
                Download Excel
          </a>
     </div>
                    </div>

                    
                    <div style="flex-grow: 1; overflow-x: auto;">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Feeder Name</th>
                                    <th>Zone</th>
                                    <th>Ward</th>
                                    <th>Feeder Tags</th>
                                    <th>2025-12-08</th>
                                    <th>2025-12-09</th>
                                    <th>2025-12-10</th>
                                    <th>2025-12-11</th>
                                    <th>2025-12-12</th>
                                    <th>Avg_Coverage</th>
                                    <th>Avg_Percentage</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
        <td>feeder284</td>
        <td>4</td>
        <td>Kondhwa (Bhawani)</td>
        <td>58ft road, pit pit, pit</td>
        <td>1</td>
        <td>1</td>
        <td>1</td>
        <td>1</td>
        <td>1</td>
        <td>1.00</td>
        <td>90%</td>
    </tr>
    <tr>
        <td>106</td>
        <td>4</td>
        <td>Kondhwa (Bhawani)</td>
        <td>58ft road, pit pit, pit</td>
        <td>0</td> <td>0</td> <td>0</td> <td>0</td> <td>0</td> <td>0.00</td>
        <td>0%</td>
    </tr>
    <tr>
        <td>117</td>
        <td>3</td>
        <td>Vidya Nagar</td>
        <td>58ft road, pit pit, pit</td>
        <td>1</td>
        <td>0</td> <td>1</td>
        <td>1</td>
        <td>1</td>
        <td>0.80</td>
        <td>80%</td>
    </tr>
    <tr>
        <td>119</td>
        <td>4</td>
        <td>Vidya Nagar</td>
        <td>58ft road, pit pit, pit</td>
        <td>1</td>
        <td>0</td> <td>1</td>
        <td>1</td>
        <td>1</td>
        <td>0.80</td>
        <td>80%</td>
    </tr>
    <tr>
        <td>feeder889</td>
        <td>3</td>
        <td>Kondhwa (Bhawani)</td>
        <td>58ft road, pit pit, pit</td>
        <td>1</td>
        <td>1</td>
        <td>1</td>
        <td>1</td>
        <td>1</td>
        <td>1.00</td>
        <td>90%</td>
    </tr>
    <tr>
        <td>feeder456</td>
        <td>4</td>
        <td>Nagpur Road, pit pit, pit</td>
        <td>Main Road, junction</td> <td>1</td>
        <td>1</td>
        <td>2</td>
        <td>2</td>
        <td>1</td>
        <td>1.40</td>
        <td>70%</td>
    </tr>
    <tr>
        <td>feeder789</td>
        <td>3</td>
        <td>Vidya Nagar</td> <td>58ft road, pit pit, pit</td>
        <td>1</td>
        <td>1</td>
        <td>1</td>
        <td>0</td> <td>1</td>
        <td>0.80</td>
        <td>80%</td>
    </tr>
    <tr>
        <td>feeder112</td>
        <td>3</td>
        <td>Kondhwa (Bhawani)</td> <td>Corner pit, junction</td> <td>1</td>
        <td>1</td>
        <td>1</td>
        <td>0</td> <td>1</td>
        <td>0.80</td>
        <td>80%</td>
    </tr>    <tr><td>feeder112</td><td>3</td><td>58ft road, pit pit, pit</td><td>1</td><td>1</td><td>1</td><td>-</td><td>1</td><td>0.80</td><td>80%</td></tr>
                            </tbody>
                        </table>
                    </div>

                    <div class="pagination">
                        <div>
                            Showing 1 to 8 of 45,670 entries
                        </div>
                        <div>
                            <button>Previous</button>
                            <span> Page 1 </span>
                            <button>Next</button>
                        </div>
                    </div>
                    <div class="table-footer">
                        Monthly Feeder Coverage Status
                    </div>
                </div>
            </div>

        </div>
    </div>

    <script type="text/javascript">

        const CHART_INNER_HEIGHT = 250;

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
                margin: { l: 30, r: 30, t: 30, b: 30 }
            };
        }

        // --- 1. Feeder Coverage Overall (Doughnut) ---
        function renderFeederOverall() {
            const chartId = 'feederOverallChart';
            toggleLoader(chartId, true); // Show loader

            $.ajax({
                type: "GET",
                url: "http://localhost:75/api/FeederCoverageOverall",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    toggleLoader(chartId, false); // Hide loader on success

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
                    var layout = getBaseLayout('Feeder Coverage Overall');
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
                },
                error: function (xhr) {
                    console.log("AJAX error:", xhr.responseText);
                    toggleLoader(chartId, false); // Hide loader on error
                }
            });

        }

        // --- 2. Feeder Coverage Zone Wise (Sunburst/Doughnut) ---
        function renderFeederZoneWise() {
            const chartId = 'feederZoneWiseChart';
            toggleLoader(chartId, true); // Show loader

            $.ajax({
                type: "GET",
                url: "http://localhost:75/api/FeederCoverageZoneWise",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    toggleLoader(chartId, false); // Hide loader on success

                    var labels = [];
                    var parents = [];
                    var values = [];
                    var colors = [];

                    // LEVEL 1 — ZONES
                    response.labels.forEach((zoneLabel, i) => {
                        labels.push(zoneLabel);
                        parents.push(""); // no parent (center)

                        const total =
                            response.values[i].covered +
                            response.values[i].uncovered +
                            response.values[i].unattended;

                        values.push(total);
                        colors.push('');
                    });

                    // LEVEL 2 — categories
                    const categories = ["covered", "uncovered", "unattended"];
                    const catLabels = ["COVERED", "UNCOVERED", "UN ATTENDED"];

                    response.labels.forEach((zoneLabel, i) => {
                        categories.forEach((cat, j) => {
                            labels.push(catLabels[j]);
                            parents.push(zoneLabel);
                            values.push(response.values[i][cat]);
                            colors.push('');
                        });
                    });

                    var data = [{
                        type: "sunburst",
                        labels: labels,
                        parents: parents,
                        values: values,
                        branchvalues: "total",
                        maxdepth: 3,
                        textinfo: "label+percent entry",
                        insidetextorientation: "auto",
                        marker: { colors: colors }
                    }];

                    var layout = {
                        title: { text: "Feeder Coverage Zone Wise", font: { size: 20 } },
                        margin: { l: 10, r: 10, t: 50, b: 10 },
                        sunburstcolorway: [
                            "#d62728", "#ff7f0e", "#2ca02c",
                            "#1f77b4", "#8c564b", "#17becf"
                        ],
                        extendsunburstcolorway: true
                    };

                    Plotly.newPlot(
                        chartId,
                        data,
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

        // --- 3. Feeder Coverage Ward Wise (Sunburst/Pie) ---
        function renderFeederWardWise() {
            const chartId = 'feederWardWiseChart';
            toggleLoader(chartId, true); // Show loader

            $.ajax({
                type: "GET",
                url: "http://localhost:75/api/FeederCoverageWardWise",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    toggleLoader(chartId, false); // Hide loader on success

                    var labels = [];
                    var parents = [];
                    var values = [];
                    var colors = [];

                    // LEVEL 1 — Wards (Mocking Ward structure using the same API as it simulates a tiered chart)
                    response.labels.forEach((wardLabel, i) => {
                        labels.push(wardLabel);
                        parents.push("");

                        const total =
                            response.values[i].covered +
                            response.values[i].uncovered +
                            response.values[i].unattended;

                        values.push(total);
                        colors.push('');
                    });

                    // LEVEL 2 — categories
                    const categories = ["covered", "uncovered", "unattended"];
                    const catLabels = ["COVERED", "UNCOVERED", "UN ATTENDED"];

                    response.labels.forEach((wardLabel, i) => {
                        categories.forEach((cat, j) => {
                            labels.push(catLabels[j]);
                            parents.push(wardLabel);
                            values.push(response.values[i][cat]);
                            colors.push('');
                        });
                    });

                    var data = [{
                        type: "sunburst",
                        labels: labels,
                        parents: parents,
                        values: values,
                        branchvalues: "total",
                        maxdepth: 3,
                        textinfo: "label+percent entry",
                        insidetextorientation: "auto",
                        marker: { colors: colors }
                    }];

                    var layout = {
                        title: { text: "Feeder Coverage Ward Wise", font: { size: 20 } },
                        margin: { l: 10, r: 10, t: 50, b: 10 },
                        sunburstcolorway: [
                            "#d62728", "#ff7f0e", "#2ca02c",
                            "#1f77b4", "#8c564b", "#17becf"
                        ],
                        extendsunburstcolorway: true
                    };

                    Plotly.newPlot(
                        chartId,
                        data,
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

        // --- 4. TOP 40 Feeder Coverage Summary (Grouped Bar) ---
        function renderTop40Chart() {
            const chartId = 'top40ChartContainer';
            toggleLoader(chartId, true); // Show loader

            $.ajax({
                type: "GET",
                url: "http://localhost:75/api/FeederCoverageWardWise",
                contentType: "application/json; charset=utf-8",
                dataType: "json",

                success: function (response) {
                    toggleLoader(chartId, false); // Hide loader on success

                    // Extract feeder names
                    // NOTE: Using response.labels for demo, in real life this API endpoint should be different
                    let feederNames = response.labels;

                    // Extract category-wise values
                    let covered = response.values.map(x => x.covered);
                    let uncovered = response.values.map(x => x.uncovered);
                    let unattended = response.values.map(x => x.unattended);

                    // Create bar traces
                    let traceCovered = {
                        x: feederNames,
                        y: covered,
                        name: "COVERED",
                        type: "bar",
                        marker: { color: "#17becf" } // blue
                    };

                    let traceUncovered = {
                        x: feederNames,
                        y: uncovered,
                        name: "UNCOVERED",
                        type: "bar",
                        marker: { color: "#2ca02c" } // green
                    };

                    let traceUnattended = {
                        x: feederNames,
                        y: unattended,
                        name: "UN ATTENDED",
                        type: "bar",
                        marker: { color: "#d62728" } // red
                    };

                    // Layout like your screenshot
                    let layout = {
                        title: {
                            text: "TOP 40 Feeder Coverage Summary",
                            font: { size: 20 }
                        },
                        height: 400, // Custom height for this chart
                        barmode: "group", // side-by-side bars
                        margin: { l: 40, r: 30, t: 50, b: 150 },
                        xaxis: {
                            title: "Feeder Name",
                            tickangle: -65,
                        },
                        yaxis: {
                            title: "Number of Pits"
                        },
                        legend: {
                            orientation: "v",
                            x: 1.05,
                            y: 1
                        }
                    };

                    Plotly.newPlot(chartId,
                        [traceCovered, traceUncovered, traceUnattended],
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

        // --- Execute All Chart Rendering on Page Load ---
        window.onload = function () {
            renderFeederOverall();
            renderFeederZoneWise();
            renderFeederWardWise();
            renderTop40Chart();
        };

    </script>
</body>
        </div>
</asp:Content>