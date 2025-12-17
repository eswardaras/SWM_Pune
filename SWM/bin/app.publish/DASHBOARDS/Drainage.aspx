<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Drainage.aspx.cs" Inherits="Drainage" %>



<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card-sub-container">

    <title>Drainage Worker Attendance Dashboard</title>

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
        .header-date {
            font-weight: bold;
            font-size: 14px;
            padding: 5px 10px;
            background-color: #ffffff;
            color: #000;
            border-radius: 4px;
        }

        /* --- Filter Bar Styling (Matching the 4-column layout of the image) --- */
        .filter-bar {
            /* Use Grid to enforce four equal columns for filters */
            display: grid;
            grid-template-columns: repeat(4, 1fr); 
            gap: 7px;
            
            padding: 10px 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            align-items: center;
        }

        .filter-bar label {
            font-weight: bold;
            color: #06923E; /* Green text matching the Mokadam/Drainage style */
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
            gap: 15px;
            margin-bottom: 20px;
        }

        /* --- Card and Chart Container Styling (White Background) --- */
        .chart-card {
            background-color: #FFFFFF;
            color: #000;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
            height: 300px; 
            min-height: 250px; 
            display: flex;
            flex-direction: column;
            position: relative; /* IMPORTANT for loader positioning */
        }
        .plotly-chart {
            flex-grow: 1;
            min-height: 270px; 
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
    <div id="form1">
        <div class="header-bar">
            <h1>Drainage Worker Attendance Dashboard</h1>
            <div class="header-date">12/12/2025</div>
        </div>

        <div class="dashboard-container">
            
            <div class="filter-bar">
                
                <div class="filter-group">
                    <label for="selectZone">Zone</label>
                    <select id="selectZone">
                        <option value="all">Select Zone (leave blank to include all)</option>
                        <option value="zone1">Zone 1</option>
                    </select>
                </div>
                
                <div class="filter-group">
                    <label for="selectWard">Ward</label>
                    <select id="selectWard">
                        <option value="all">Select Ward (leave blank to include all)</option>
                        <option value="wardA">Ward A</option>
                    </select>
                </div>

                <div class="filter-group">
                    <label for="selectSection">Section</label>
                    <select id="selectSection">
                        <option value="all">Select Section (leave blank to include all)</option>
                        <option value="sectA">North</option>
                    </select>
                </div>

                <div class="filter-group">
                    <label for="selectSupervisor">Supervisor</label>
                    <select id="selectSupervisor">
                        <option value="all">Select Supervisor (leave blank to include all)</option>
                        <option value="sup1">Supervisor 1</option>
                    </select>
                </div>
            </div>
            <div class="grid-3-col">
                <div class="chart-card">
                    <div class="chart-loader"></div>
                    <div id="drainageOverallChart" class="plotly-chart"></div>
                </div>

                <div class="chart-card">
                    <div class="chart-loader"></div>
                    <div id="drainageZoneWiseChart" class="plotly-chart"></div>
                </div>

                <div class="chart-card">
                    <div class="chart-loader"></div>
                    <div id="drainageWardWiseChart" class="plotly-chart"></div>
                </div>
            </div>

        </div>
    </div>

    <script type="text/javascript">

        const CHART_INNER_HEIGHT = 260;

        // --- LOADER TOGGLE FUNCTION (Corrected and Robust) ---
        function toggleLoader(chartId, show) {
            const chartDiv = document.getElementById(chartId);
            // Locate the nearest parent container for the loader (.chart-card is set to position: relative)
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
                margin: { l: 20, r: 20, t: 20, b: 10 }
            };
        }

        // --- 1. Drainage Attendance Overall (Doughnut) ---
        function renderDrainageOverall() {
            const chartId = "drainageOverallChart";
            toggleLoader(chartId, true);

            $.ajax({
                type: "GET",
                url: "http://localhost:75/api/DrainageworkerAttendence",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    toggleLoader(chartId, false);

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
                    var layout = getBaseLayout('Drainage Worker Attendance');
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
                    toggleLoader(chartId, false);
                }
            });

        }

        // --- 2. Drainage Attendance Zone Wise (Pie Chart - Zone focus in center) ---
        function renderDrainageZoneWise() {
            const chartId = "drainageZoneWiseChart";
            toggleLoader(chartId, true);

            $.ajax({
                type: "GET",
                url: "http://localhost:75/api/DrainageAttendanceZoneWise",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    toggleLoader(chartId, false);

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
                    var layout = getBaseLayout('Drainage Attendance ZoneWise');
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
                    toggleLoader(chartId, false);
                }
            });

        }


        // --- 3. Drainage Attendance Ward Wise (Pie Chart) ---
        function renderDrainageWardWise() {
            const chartId = "drainageWardWiseChart";
            toggleLoader(chartId, true);

            $.ajax({
                type: "GET",
                url: "http://localhost:75/api/DrainageAttendanceWardWise",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    toggleLoader(chartId, false);

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
                    var layout = getBaseLayout('Drainage Attendance WardWise');
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
                    toggleLoader(chartId, false);
                }
            });

        }

        // --- Execute All Chart Rendering on Page Load ---
        window.onload = function () {
            renderDrainageOverall();
            renderDrainageZoneWise();
            renderDrainageWardWise();
        };

    </script>
</body>
        </div>
</asp:Content>