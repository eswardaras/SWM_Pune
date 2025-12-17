<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CollectionWorker.aspx.cs" Inherits="SWM.CollectionWorker" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card-sub-container">
<head>
    <title>Collection Worker Attendance Dashboard</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.plot.ly/plotly-2.30.0.min.js"></script>

    <style>
        /* --- Base & Background Styles (Matching UI Theme) --- */
        body {
            font-family: Arial, sans-serif;
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

        /* --- Filter Bar Styling (3-Column Grid) --- */
        .filter-bar {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 15px;
            padding: 10px 10px;

            border-radius: 5px;
            margin-bottom: 7px;
            align-items: center;
        }

        .filter-bar label {
            font-weight: bold;
            color: #FFFFFF; /* Changed color to white for better contrast on background */
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
        .chart-card {
            background-color: #FFFFFF;
            color: #000;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
            height: 350px;
            min-height: 300px;
            display: flex;
            flex-direction: column;
            position: relative; /* IMPORTANT: Required for loader absolute positioning */
        }
        .plotly-chart {
            flex-grow: 1;
            min-height: 300px;
        }

        /* --- Responsive Adjustments --- */
        @media (max-width: 1200px) {
            .grid-3-col {
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
            .filter-bar, .grid-3-col {
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
        /* --- END LOADER STYLES --- */
    </style>
</head>
<body>
    <div id="form1">
        <div id="mySidebar" class="sidebar">
            <a href="#" class="active-link">Dashboard Overview</a>
            <a href="#">Attendance Details</a>
            <a href="#">Zone Summary</a>
            <a href="#">Mokadam Performance</a>
            <a href="#">Reports</a>
        </div>

        <div class="main-content">
            <div class="header-bar">
                <h1>Collection Worker Attendance Dashboard</h1>
                <div class="header-date">12/12/2025</div>
            </div>

            <div class="dashboard-container">

                <div class="filter-bar">

                    <div class="filter-group">
                        <label>Zone</label>
                        <select id="selectZone">
                            <option value="all">Select (leave blank to include all)</option>
                        </select>
                    </div>

                    <div class="filter-group">
                        <label>Ward</label>
                        <select id="selectWard">
                            <option value="all">Select (leave blank to include all)</option>
                        </select>
                    </div>

                    <div class="filter-group">
                        <label>Mokadam</label>
                        <select id="selectMokadam">
                            <option value="all">Select (leave blank to include all)</option>
                        </select>
                    </div>
                </div>
                <div class="grid-3-col">
                    <div class="chart-card">
                        <div class="chart-loader"></div>
                        <div id="cwOverallChart" class="plotly-chart"></div>
                    </div>

                    <div class="chart-card">
                        <div class="chart-loader"></div>
                        <div id="cwZoneWiseChart" class="plotly-chart"></div>
                    </div>

                    <div class="chart-card">
                        <div class="chart-loader"></div>
                        <div id="cwWardWiseChart" class="plotly-chart"></div>
                    </div>
                </div>

            </div>
        </div>
    </div>

<script type="text/javascript">

    // --- GLOBAL CONSTANTS AND HELPERS ---
    const CHART_INNER_HEIGHT = 350;

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
                font: { size: 16, color: '#003366' }
            },
            height: CHART_INNER_HEIGHT,
            paper_bgcolor: '#fff',
            plot_bgcolor: '#fff',
            font: { color: '#000' },
            margin: { l: 20, r: 20, t: 30, b: 20 }
        };
    }

    // Color constants for Sunburst charts
    const PLOTLY_COLORS = {
        // Colors for inner rings (Zones/Wards)
        ZONE_INNER: ["#d9534f", "#f0ad4e", "#135c5c", "#348e6c", "#367fa9", "#708090"],
        // Colors for attendance statuses (Outer Rings)
        STATUS_OUTER: {
            "ABSENT": "#e77a76",    // Lighter Red
            "PRESENT": "#6ED0B5",   // Light Teal/Green
            "PING": "#90CAF9",       // Light Blue
            "Device at CC": "#ffc107",
            "PRESENT (ON ROUTE)": "#38c172"
        }
    };


    // --- 1. CW Attendance Overall (Doughnut) ---
    function renderCWOverall() {
        const url = "http://localhost:75/api/CWAttendanceChart";
        const targetId = 'cwOverallChart';
        const CHART_COLORS = ["#ff4d4d", "#3399ff", "#2ecc71", "#ffcc00"];

        toggleLoader(targetId, true); // SHOW LOADER

        $.ajax({
            type: "GET",
            url: url,
            dataType: "json",
            success: function (apiData) {
                toggleLoader(targetId, false); // HIDE LOADER

                if (!apiData || !apiData.labels || !apiData.datasets?.length) return;

                const labels = apiData.labels;
                const values = apiData.datasets[0].data.map(v => Number(v) || 0);
                const total = values.reduce((a, b) => a + b, 0);

                const plotlyData = [{
                    type: "pie", hole: 0.6, labels: labels, values: values,
                    sort: false, direction: "clockwise", textinfo: "percent",
                    textposition: "inside", insidetextorientation: "horizontal",
                    hovertemplate: "<b>%{label}</b><br>Count: %{value:,}<br>Percentage: %{percent}<extra></extra>",
                    marker: { colors: CHART_COLORS, line: { color: "#ffffff", width: 1 } },
                    showlegend: true
                }];

                const layout = {
                    title: { text: `<b>CW Attendance</b> (Total : ${total.toLocaleString()})`, font: { size: 14 } },
                    annotations: [{
                        text: `<b>${total.toLocaleString()}</b>`, x: 0.5, y: 0.5, showarrow: false, font: { size: 18, color: "#000" }
                    }],
                    height: 340, margin: { l: 10, r: 10, t: 45, b: 35 },
                    legend: { orientation: "h", x: 0.5, xanchor: "center", y: -0.1, font: { size: 10 } },
                    plot_bgcolor: "#ffffff", paper_bgcolor: "#ffffff"
                };

                Plotly.react(targetId, plotlyData, layout, { responsive: true, displayModeBar: false });
                Plotly.Plots.resize(targetId);
            },
            error: function (xhr, status, error) {
                toggleLoader(targetId, false); // HIDE LOADER
                console.error(`CW Attendance Chart Error (${xhr.status}):`, error);
                $('#' + targetId).html(`<div style="text-align: center; padding-top: 50px; color: red;">Error ${xhr.status}: Failed to load chart data.</div>`);
            }
        });
    }

    // --- 2. CW Attendance Zone Wise (Sunburst) ---
    function renderCWZoneWise() {
        const url = "http://localhost:75/api/CWAttendanceZoneWise";
        const targetId = 'cwZoneWiseChart';

        toggleLoader(targetId, true); // SHOW LOADER

        $.ajax({
            type: "GET",
            url: url,
            dataType: "json",
            success: function (res) {
                toggleLoader(targetId, false); // HIDE LOADER

                if (!res || !res.labels || res.labels.length === 0) {
                    $('#' + targetId).html('<div style="text-align: center; padding-top: 50px;">No zone data available.</div>');
                    return;
                }

                // --- Color Mapping for Flat Data (Placeholder logic, should match your actual API's format) ---
                let colors = res.parents.map((p, i) => {
                    if (p === "") return PLOTLY_COLORS.ZONE_INNER[i % PLOTLY_COLORS.ZONE_INNER.length];
                    let status = res.labels[i];
                    return PLOTLY_COLORS.STATUS_OUTER[status] || "#999999";
                });
                // ------------------------------------

                // --- Plotly Data Transformation (Simplified for display) ---
                var data = [{
                    type: "sunburst",
                    labels: res.labels,
                    parents: res.parents,
                    values: res.values,
                    branchvalues: "total",
                    maxdepth: 2,
                    textinfo: "label+percent parent",
                    insidetextorientation: "radial",
                    marker: { colors: colors, line: { width: 1, color: "#ffffff" } },
                    hovertemplate: "<b>%{label}</b><br>Count: %{value:,}<br>%{percentParent} of Zone<extra></extra>",
                    showlegend: false
                }];

                var layout = getBaseLayout('CW Attendance Zone Wise');
                layout.margin = { l: 10, r: 10, t: 30, b: 10 }; layout.height = 350; layout.uniformtext = { minsize: 8, mode: 'hide' };

                Plotly.react(targetId, data, layout, { responsive: true, displayModeBar: false });
                Plotly.Plots.resize(targetId);
            },
            error: function (xhr, status, error) {
                toggleLoader(targetId, false); // HIDE LOADER
                console.error(`Zone Wise Chart Error (${xhr.status}):`, error);
                $('#' + targetId).html(`<div style="text-align: center; padding-top: 50px; color: red;">Error ${xhr.status}: Failed to load zone data.</div>`);
            }
        });
    }


    // --- 3. CW Attendance Ward Wise (Sunburst) ---
    function renderCWWardWise() {
        const url = "http://localhost:75/api/CWAttendanceWardWise";
        const targetId = 'cwWardWiseChart';

        toggleLoader(targetId, true); // SHOW LOADER

        $.ajax({
            type: "GET",
            url: url,
            dataType: "json",
            success: function (res) {
                toggleLoader(targetId, false); // HIDE LOADER

                if (!res || !res.labels || res.labels.length === 0) {
                    $('#' + targetId).html('<div style="text-align: center; padding-top: 50px;">No ward data available.</div>');
                    return;
                }

                // --- Color Mapping for Flat Data (Placeholder logic, should match your actual API's format) ---
                let colors = res.parents.map((p, i) => {
                    if (p === "") return PLOTLY_COLORS.ZONE_INNER[i % PLOTLY_COLORS.ZONE_INNER.length]; // Inner ring (Ward)

                    let label = res.labels[i];
                    // Outer ring status is the last word (e.g., "WardName ABSENT" -> "ABSENT")
                    let status = label.split(' ').pop();

                    return PLOTLY_COLORS.STATUS_OUTER[status] || "#999999";
                });
                // ------------------------------------

                const data = [{
                    type: "sunburst",
                    labels: res.labels,
                    parents: res.parents,
                    values: res.values,
                    branchvalues: "total",
                    maxdepth: 2,
                    textinfo: "label+percent parent",
                    insidetextorientation: "radial",
                    marker: { colors: colors, line: { width: 1, color: "#ffffff" } },
                    hovertemplate: "<b>%{label}</b><br>Count: %{value:,}<br>Share of Ward: %{percentParent}<extra></extra>",
                    showlegend: false
                }];

                let layout = getBaseLayout("CW Attendance Ward Wise");
                layout.height = 360; layout.margin = { l: 10, r: 10, t: 35, b: 10 };
                layout.uniformtext = { minsize: 8, mode: "hide" };

                Plotly.react(targetId, data, layout, { responsive: true, displayModeBar: false });
                Plotly.Plots.resize(targetId);
            },
            error: function (xhr, status, error) {
                toggleLoader(targetId, false); // HIDE LOADER
                console.error(`Ward Wise Chart Error (${xhr.status}):`, error);
                $('#' + targetId).html(`<div style="text-align: center; padding-top: 50px; color: red;">Error ${xhr.status}: Failed to load ward data.</div>`);
            }
        });
    }


    // --- THE EXECUTION BLOCK ---
    $(document).ready(function () {
        renderCWOverall();
        renderCWZoneWise();
        renderCWWardWise();
    });
</script>
</body>
        </div>
</asp:Content>