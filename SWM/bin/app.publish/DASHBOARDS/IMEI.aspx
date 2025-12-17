<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="IMEI.aspx.cs" Inherits="SWM.IMEI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card-sub-container">
    
    <title>IMEI Ping Status Dashboard</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.plot.ly/plotly-2.30.0.min.js"></script>

    <style>
        /* --- Base & Background Styles (Matching IMEI Theme) --- */
        body {
            font-family: Arial, sans-serif;
            /* Dark Blue/Purple gradient matching image.png */
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
            justify-content: center; /* Center the title */
            align-items: center;
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            position: relative;
        }
        .header-bar h1 {
            margin: 0;
            font-size: 28px;
            font-weight: lighter;
            color: #fff;
        }
        .refresh-icon {
            position: absolute;
            right: 20px;
            font-size: 24px;
            cursor: pointer;
            color: #fff;
        }

        /* --- Filter Bar Styling (6-Column Grid for IMEI) --- */
        .filter-bar {
            /* Use Grid to enforce six equal columns for filters */
            display: grid;
            grid-template-columns: repeat(6, 1fr); 
            gap: 7px;
            
            padding: 10px 20px;
          
            border-radius: 5px;
            margin-bottom: 7px;
            align-items: center;
        }

        .filter-bar label {
            /* Labels are placeholder text above the selects in the image, hidden here */
            display: none; 
        }

        .filter-bar select {
            width: 100%;
            padding: 8px 12px;
            border-radius: 5px;
            border: 1px solid #FFFFFF; /* Purple border */
            background-color: #FFFFFF; /* Purple background */
            color: #000;
            font-size: 14px;
            cursor: pointer;
        
        }
        
        /* --- Dashboard Grid Layout --- */
        .dashboard-container {
            padding: 20px;
        }

        /* Two main columns for the charts */
        .grid-2-col {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 7px;
            margin-bottom: 7px;
        }

        /* --- Card and Chart Container Styling (White Background) --- */
        .chart-card {
            background-color: #FFFFFF;
            color: #000;
            padding: 10px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
            height: 400px; 
            min-height: 380px; 
            display: flex;
            flex-direction: column;
            position: relative; /* IMPORTANT for loader positioning */
        }
        .plotly-chart {
            flex-grow: 1;
            min-height: 350px; 
        }
        
        /* --- Responsive Adjustments --- */
        @media (max-width: 1200px) {
            .grid-2-col {
                grid-template-columns: 1fr; /* Stack columns vertically on smaller screens */
            }
            .filter-bar {
                grid-template-columns: repeat(3, 1fr);
            }
        }
        @media (max-width: 768px) {
            .filter-bar {
                grid-template-columns: 1fr;
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
            <h1>IMEI Ping Status Dashboard</h1>
            <span class="refresh-icon">&#x21BB;</span> </div>

        <div class="dashboard-container">
            
            <div class="filter-bar">
                
                <div class="filter-group">
                    <label>Name</label>
                    <select id="selectName1">
                        <option value="all">Name (leave blank to include all)</option>
                    </select>
                </div>
                
                <div class="filter-group">
                    <label>Name</label>
                    <select id="selectName2">
                        <option value="all">Name (leave blank to include all)</option>
                    </select>
                </div>

                <div class="filter-group">
                    <label>Name</label>
                    <select id="selectName3">
                        <option value="all">Name (leave blank to include all)</option>
                    </select>
                </div>

                <div class="filter-group">
                    <label>Name</label>
                    <select id="selectName4">
                        <option value="all">Name (leave blank to include all)</option>
                    </select>
                </div>

                <div class="filter-group">
                    <label>Type</label>
                    <select id="selectType">
                        <option value="all">Type (leave blank to include all)</option>
                    </select>
                </div>

                <div class="filter-group">
                    <label>IMEI</label>
                    <select id="selectIMEI">
                        <option value="all">IMEI (leave blank to include all)</option>
                    </select>
                </div>
            </div>
            <div class="grid-2-col">
                <div class="chart-card">
                    <div class="chart-loader"></div>
                    <div id="lastPingChart" class="plotly-chart"></div>
                </div>

                <div class="chart-card">
                    <div class="chart-loader"></div>
                    <div id="hourWisePingChart" class="plotly-chart"></div>
                </div>
            </div>

        </div>
    </div>

    <script type="text/javascript">

        const CHART_INNER_HEIGHT = 350;

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
                font: { color: '#000', size: 10 },
                margin: { l: 40, r: 20, t: 30, b: 20 }
            };
        }

        // --- 1. Devices Last Ping (Vertical Bar Chart) ---
        function renderLastPingChart() {
            const chartId = "lastPingChart";
            toggleLoader(chartId, true); // Show loader

            $.ajax({
                type: "GET",
                url: "http://localhost:75/api/DevicesLastPing",
                dataType: "json",
                success: function (apiData) {
                    toggleLoader(chartId, false); // Hide loader on success

                    // ✅ Direct API binding
                    var labels = apiData.labels;
                    var values = apiData.datasets[0].data;

                    // 🎨 Single color (same as screenshot)
                    var barColors = values.map(() => "#6A7BFF");

                    // 📊 Plotly bar chart
                    var plotlyData = [{
                        x: labels,
                        y: values,
                        type: "bar",
                        text: values,
                        textposition: "auto",
                        marker: {
                            color: barColors
                        }
                    }];

                    var grandTotal = values.reduce((a, b) => a + b, 0);

                    var layout = {
                        title: {
                            text: `Devices Last Ping (Total IMEI: ${grandTotal})`,
                            font: { size: 20 }
                        },
                        xaxis: {
                            title: "Last Ping Status",
                            tickangle: -30
                        },
                        yaxis: {
                            title: "IMEI Counts",
                            gridcolor: "#E5E5E5"
                        },
                        showlegend: false,
                        margin: {
                            l: 60,
                            r: 20,
                            t: 60,
                            b: 100
                        }
                    };

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

        // --- 2. Hour Wise Ping for Today (Vertical Bar Chart) ---
        function renderHourWisePingChart() {
            const chartId = "hourWisePingChart";
            toggleLoader(chartId, true); // Show loader

            $.ajax({
                type: "GET",
                url: "http://localhost:75/api/HourWisePingforToday",
                dataType: "json",
                success: function (apiData) {
                    toggleLoader(chartId, false); // Hide loader on success

                    var labels = apiData.labels;
                    var values = apiData.datasets[0].data;

                    var plotlyData = [{
                        x: labels,
                        y: values,
                        type: "bar",
                        text: values,
                        textposition: "auto",
                        marker: {
                            color: "#6A7BFF"
                        }
                    }];

                    var layout = {
                        title: {
                            text: "Hour Wise Ping for Today",
                            font: { size: 20 }
                        },
                        xaxis: {
                            title: "Last Ping Hour",
                            dtick: 1
                        },
                        yaxis: {
                            title: "IMEI Counts",
                            gridcolor: "#E5E5E5"
                        },
                        showlegend: false,
                        margin: {
                            l: 60,
                            r: 20,
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
                },
                error: function (xhr) {
                    console.log("AJAX error:", xhr.responseText);
                    toggleLoader(chartId, false); // Hide loader on error
                }
            });
        }


        // --- Execute All Chart Rendering on Page Load ---
        window.onload = function () {
            renderLastPingChart();
            renderHourWisePingChart();
        };

    </script>
</body>
        </div>
</asp:Content>