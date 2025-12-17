<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard_CW_SWM.aspx.cs" Inherits="SWM.Dashboard_CW_SWM" %>
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
        .header-date {
            font-weight: bold;
            font-size: 14px;
            padding: 5px 10px;
            background-color: #ffffff;
            color: #000;
            border-radius: 4px;
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
        ZONE_INNER: [
            "#00bcd4", // Cyan
            "#3f51b5", // Indigo
            "#cddc39", // Lime (Darkened slightly)
            "#ff9800", // Orange
            "#e91e63", // Pink
            "#673ab7", // Deep Purple
        ],
        // Specific dark colors for Attendance Statuses (Outer Ring)
        STATUS_OUTER: {
            "PRESENT": "#00897B",     // Dark Teal
            "ABSENT": "#F4511E",      // Deep Orange (Alert color)
            "LEAVE": "#FFC107",       // Amber (Warning color)
            "UNATTENDED": "#D84315",  // Darker Orange
            // Default for any other status
            "OTHER": "#455A64"        // Blue-Grey
        }
    };


    // --- 1. CW Attendance Overall (Doughnut) ---
    function renderCWOverall() {
        const url = "https://iswmpune.in/api/CWAttendanceChart";
        const targetId = 'cwOverallChart';
        const CHART_COLORS = ["#ff4d4d", "#3399ff", "#2ecc71", "#ff9800"];

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

                const layout = getBaseLayout('CW Attendance');
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
        const url = "https://iswmpune.in/api/CWAttendanceZoneWise";
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
        const url = "https://iswmpune.in/api/CWAttendanceWardWise";
        const targetId = 'cwWardWiseChart';

        toggleLoader(targetId, true); // SHOW LOADER

        // Increase Height for a better-looking Sunburst
        const chartHeight = 400;

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

                // --- Color Mapping using the defined DARK palette ---
                // The logic assigns distinct colors based on whether the slice is a Ward (inner) or a Status (outer).
                let colors = res.parents.map((p, i) => {
                    if (p === "") {
                        // Inner ring: Ward (cycle through ZONE_INNER colors)
                        return PLOTLY_COLORS.ZONE_INNER[i % PLOTLY_COLORS.ZONE_INNER.length];
                    }

                    let label = res.labels[i];
                    // Outer ring status is the last word (e.g., "WardName ABSENT" -> "ABSENT")
                    // NOTE: This assumes the API returns labels like "WardName Status"
                    let status = label.split(' ').pop().toUpperCase();

                    // Outer ring: Status (use the specific STATUS_OUTER color or a dark gray default)
                    return PLOTLY_COLORS.STATUS_OUTER[status] || PLOTLY_COLORS.STATUS_OUTER.OTHER;
                });
                // ------------------------------------

                const data = [{
                    type: "sunburst",
                    labels: res.labels,
                    parents: res.parents,
                    values: res.values,
                    branchvalues: "total",
                    maxdepth: 2,

                    // Keep label display for primary visual cue
                    textinfo: "label+percent parent",
                    insidetextorientation: "radial",

                    // Apply the new dark colors and white line for separation
                    marker: { colors: colors, line: { width: 1, color: "#FFFFFF" } },

                    hovertemplate: "<b>%{label}</b><br>Count: %{value:,}<br>Share of Ward: %{percentParent}<extra></extra>",
                    showlegend: false
                }];

                let layout = getBaseLayout("CW Attendance Ward Wise");

                // Adjust height for a larger Sunburst plot to fit more labels
                layout.height = chartHeight;

                layout.margin = { l: 10, r: 10, t: 35, b: 10 };
                layout.uniformtext = { minsize: 8, mode: "hide" };

                Plotly.react(targetId, data, layout, { responsive: true, displayModeBar: false });
                Plotly.Plots.resize(targetId);
            },
            error: function (xhr, status, error) {
                toggleLoader(targetId, false); // HIDE LOADER
                console.error(`Ward Wise Chart Error (${xhr.status}):`, error);
                // Display dark-themed error message
                $('#' + targetId).html(`<div style="text-align: center; padding-top: 50px; color: #FFEB3B;">Error ${xhr.status}: Failed to load CW ward data.</div>`);
            }
        });
    }

    // --- THE EXECUTION BLOCK ---
    $(document).ready(function () {
        renderCWOverall();
        renderCWZoneWise();
        renderCWWardWise();
    });
    
            $(document).ready(function () {

                // -------- ZONE --------
                $.ajax({
                    url: '/api/GetzoneAPI',
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
</body>
        </div>
</asp:Content>