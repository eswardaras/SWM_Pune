<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DashBoard_Vehicle_SWM.aspx.cs" Inherits="SWM.DashBoard_Vehicle_SWM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card-sub-container">

    <title>Vehicle Dashboard</title>

    <script src="https://cdn.plot.ly/plotly-2.30.0.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
        /* --- Base & Background Styles (Matching Vehicle Theme) --- */
        body {
            font-family: Arial, sans-serif;
            /* Blue/Purple gradient matching image.jpg */
            background: linear-gradient(to bottom right, #3f51b5, #5e35b1); 
            color: #FFFFFF;
            margin: 0;
            padding: 0;
            overflow-x: hidden;
            min-height: 100vh;
        }

        /* --- Header/Title Bar --- */
      .header-bar {
            background-color: #0d47a1; /* Primary blue for header */
            padding: 15px 20px;
            display: flex;
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            justify-content: space-between;
            align-items: center;
        }
       
         .header-bar h1 {
                margin: 0;
                font-size: 24px;
            }
        .refresh-icon {
            font-size: 24px;
            cursor: pointer;
            color: #fff;
        }

        /* --- Filter Bar Styling (6-Column Grid for Vehicle Filters) --- */
        .filter-bar {
            display: grid;
            grid-template-columns: repeat(6, 1fr); 
            gap: 10px;
            padding: 10px 10px;
        
            border-radius: 5px;
            margin-bottom: 7px;
            align-items: center;
        }

      .filter-bar label {
            font-weight: bold;
            color: #fff;
            font-size: 14px;
            display: block;
            margin-bottom: 5px;
            text-align: center;
        }

        .filter-bar select {
            width: 100%;
            padding: 8px 12px;
            border-radius: 5px;
            border: 1px solid #7E57C2; 
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
            gap: 10px;
            margin-bottom: 7px;
        }
        
        /* Full width row for the Vehicle Type chart */
        .grid-1-col {
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
             position: relative; /* IMPORTANT for loader positioning */
        }
        .plotly-chart {
            flex-grow: 1;
            min-height: 350px; 
        }
        
        /* --- Responsive Adjustments --- */
        @media (max-width: 1200px) {
            .grid-3-col {
                grid-template-columns: repeat(2, 1fr);
            }
            .filter-bar {
                grid-template-columns: repeat(3, 1fr);
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
    </style>
<body>
    <div id="form1" >
        <div class="header-bar">
            <h1>Vehicle Dashboard</h1>
            <%--<div style="background-color: #fff; color: #000; padding: 8px 15px; border-radius: 6px; font-size: 12px; font-weight: semibold; display: inline-block; margin-right: 20px;">
                        15/12/2025
                    </div>--%>
        </div>

        <div class="dashboard-container">
            
            <div class="filter-bar">
                
                <div class="filter-group">
                    <label>Zone</label>
                    <select id="selectZone">
                        <option value="all">Zone </option>
                    </select>
                </div>
                
                <div class="filter-group">
                    <labe>Ward</labe>
                    <select id="selectWard">
                        <option value="all">Ward</option>
                    </select>
                </div>

                <div class="filter-group">
                    <label>Vehicle</label>
                    <select id="selectVehicle">
                        <option value="all">Vehicle Name</option>
                    </select>
                </div>

                <div class="filter-group">
                    <label>Vendor</label>
                    <select id="SelectVendor">
                        <option value="all">Vendor Name </option>
                    </select>
                </div>

                <div class="filter-group">
                    <label>Status</label>
                    <select id="VehicleStatus">
                        <option value="all">Vehicle Status</option>
                        <option value="COVERED">COVERED</option>
                        <option value="UNCOVERED">UNCOVERED</option>
                        <option value="UN_ATTENDED">UN_ATTENDED</option>
                    </select>
                </div>

                <div class="filter-group">
                    <label>Type</label>
                    <select id="selectType">
                        <option value="all">Vehicle Type </option>
                    </select>
                </div>
            </div>
            <div class="grid-3-col">
                <div class="chart-card">
                    <div class="chart-loader"></div>
                    <div id="vehicleStatusChart" class="plotly-chart"></div>
                </div>

                <div class="chart-card">
                    <div class="chart-loader"></div>
                    <div id="zoneWiseVehicleChart" class="plotly-chart"></div>
                </div>

                <div class="chart-card">
                    <div class="chart-loader"></div>
                    <div id="vendorWiseVehicleChart" class="plotly-chart"></div>
                </div>
            </div>
            
            <div class="grid-1-col">
                <div class="chart-card" style="height: 450px;">
                    <div class="chart-loader"></div>
                    <div id="vehicleTypeWiseStatusChart" class="plotly-chart" style="min-height: 400px;"></div>
                </div>
            </div>

        </div>
    </div>
<script type="text/javascript">

    const CHART_INNER_HEIGHT = 300;
    const COLORS = {
        Break: '#36A2EB',    // Blue
        Idle: '#FFA500',    // Orange
        Running: '#28A745',  // Green
        Inactive: '#90EE90'  // Light Gray
    };

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

        };
    }

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
            chartDiv.style.visibility = show ? 'hidden' : 'visible';
        }
    }
    // --- END LOADER TOGGLE FUNCTION ---

    // --- 1. Vehicle Status (Total Vehicles: 1065) - Vertical Bar ---
    function renderVehicleStatus() {
        const chartId = "vehicleStatusChart";
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



    //---2. Zone wise Vehicle Status(vertical bar) ----
    function renderZoneWiseVehicleStatus() {
        const chartId = "zoneWiseVehicleChart";
        toggleLoader(chartId, true);

        $.ajax({
            type: "GET",
            url: "https://iswmpune.in/api/ZoneWiseVehicleStatus",
            contentType: "application/json; charset=utf-8",
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
                var layout = getBaseLayout("Zone Wise Vehicle Status (Total : " + totalVehicles + ")");
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
                console.log("ZoneWiseVehicleStatus AJAX Error:", xhr.responseText);
                toggleLoader(chartId, false);
            }
        });
    }



    // --- 3. Vendor Wise Vehicle Status - Vertical Stacked Bar ---
    function renderVendorWiseVehicleStatus() {
        const chartId = "vendorWiseVehicleChart";
        toggleLoader(chartId, true);

        $.ajax({
            type: "GET",
            url: "https://iswmpune.in/api/VendorwiseVehicleStatus",
            contentType: "application/json; charset=utf-8",
            dataType: "json",

            success: function (res) {
                toggleLoader(chartId, false);

                var labels = res.labels || [];
                var values = res.values || [];

                if (labels.length === 0) {
                    console.log("VendorwiseVehicleStatus API returned empty data.");
                    return;
                }

                // Total Vehicles
                var total = values.reduce((a, b) => a + b, 0);

                // Map colors to labels
                var colorMap = {
                    "Idle": COLORS.Idle,
                    "Running": COLORS.Running,
                    "InActive": COLORS.Inactive,
                    "Breakdown": COLORS.Break,
                    "Powercut": "#ff9900" // custom color
                };

                // Build bar traces (each label is a separate bar)
                var plotData = labels.map((label, i) => ({
                    x: [label],
                    y: [values[i]],
                    name: label,
                    type: "bar",
                    marker: { color: colorMap[label] || "#999" },
                    text: values[i].toString(),
                    textposition: "outside"
                }));

                // Layout
                var layout = getBaseLayout("Vendor Wise Vehicle Status (Total : " + total + ")");
                layout.yaxis = {
                    title: "Counts",
                    range: [0, Math.max(...values) + 50]
                };
                layout.xaxis = {
                    title: "Status",
                    categoryorder: "array",
                    categoryarray: labels,
                    domain: [0, 0.75] // space for legend
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

                Plotly.newPlot(
                    chartId,
                    plotData,
                    layout,
                    { responsive: true, displayModeBar: false }
                );
            },

            error: function (xhr) {
                console.log("VendorwiseVehicleStatus API Error:", xhr.responseText);
                toggleLoader(chartId, false);
            }
        });

    }




    // --- 4. Vehicle Type Wise Status (Vertical Stacked Bar) ---
    function renderVehicleTypeWiseStatus() {
        const chartId = "vehicleTypeWiseStatusChart";
        toggleLoader(chartId, true);

        $.ajax({
            type: "GET",
            url: "https://iswmpune.in/api/VehicleTypewiseStatus",
            dataType: "json",

            success: function (res) {
                toggleLoader(chartId, false);

                if (!res || !res.labels || !res.datasets) {
                    console.error("Invalid API response", res);
                    return;
                }

                // ----- Color mapping -----
                const COLORS = {
                    Running: "#2e7d32",
                    Idle: "#f9a825",
                    InActive: "#9ccc65",
                    Breakdown: "#1565c0",
                    Powercut: "#ef6c00"
                };

                // ----- Build stacked traces -----
                const traces = res.datasets.map(ds => ({
                    x: res.labels,
                    y: (ds.data || []).map(v => Number(v) || 0),
                    name: ds.label,
                    type: "bar",
                    marker: {
                        color: COLORS[ds.label] || "#999"
                    }
                }));

                // ----- Calculate Y max safely -----
                // This logic needs to calculate the stacked max height per column.
                // Assuming max height is 400 for demonstration or calculating true max sum per column
                const allSums = res.labels.map((_, i) =>
                    res.datasets.reduce((sum, ds) => sum + (Number(ds.data[i]) || 0), 0)
                );

                const maxValue = allSums.length > 0
                    ? Math.max(...allSums) * 1.1 // 10% padding
                    : 100;


                // ----- Layout -----
                const layout = {
                    title: {
                        text: "Vehicle Type Wise Status",
                        font: { size: 18 }
                    },
                    height: 400, // Explicitly set height for the container
                    barmode: "stack",
                    xaxis: {
                        title: "Vehicle Type",
                        tickangle: -30
                    },
                    yaxis: {
                        title: "Count",
                        range: [0, maxValue]
                    },
                    legend: {
                        orientation: "h",
                        x: 0.5,
                        xanchor: "center",
                        y: -0.3
                    },
                    margin: { l: 50, r: 30, t: 60, b: 120 }
                };

                // ----- Render -----
                Plotly.newPlot(
                    chartId,
                    traces,
                    layout,
                    { responsive: true, displayModeBar: false }
                );
            },

            error: function (xhr) {
                console.error("VehicleTypeStatus API Error:", xhr.responseText);
                toggleLoader(chartId, false);
            }
        });

    }



    // --- Execute All Chart Rendering on Page Load ---
    window.onload = function () {
        renderVehicleStatus();
        renderZoneWiseVehicleStatus();
        renderVendorWiseVehicleStatus();
        renderVehicleTypeWiseStatus();
    };

    //Masters ADDED ON 15.12.2025

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



        loadVehicleNames();

        function loadVehicleNames() {

            $("#selectVehicle").empty()
                .append('<option value="">Select Vehicle Name</option>');

            $.ajax({
                url: 'api/GetIMENameAPI',   // API should return all vehicle names
                type: "GET",
                dataType: "json",
                success: function (data) {

                    if (data && data.labels) {
                        for (var i = 0; i < data.labels.length; i++) {
                            $("#selectVehicle").append(
                                '<option value="' + data.labels[i] + '">' +
                                data.labels[i] +
                                '</option>'
                            );
                        }
                    }
                },
                error: function () {
                    console.log("Vehicle name data not found");
                }
            });
        }


        loadVehicleType();
        function loadVehicleType() {

            $("#selectType").empty()
                .append('<option value="">Select TYPE</option>');

            $.ajax({
                url: 'api/GetIMEVehicleTypeAPI',   // API should return all vehicle names
                type: "GET",
                dataType: "json",
                success: function (data) {

                    if (data && data.labels) {
                        for (var i = 0; i < data.labels.length; i++) {
                            $("#selectType").append(
                                '<option value="' + data.labels[i] + '">' +
                                data.labels[i] +
                                '</option>'
                            );
                        }
                    }
                },
                error: function () {
                    console.log("Vehicle Type data not found");
                }
            });
        }

        loadVehicleVendor();
        function loadVehicleVendor() {

            $("#SelectVendor").empty()
                .append('<option value="">Select</option>');

            $.ajax({
                url: 'api/GetVendorAPI',   // API should return all vehicle names
                type: "GET",
                dataType: "json",
                success: function (data) {

                    if (data && data.labels) {
                        for (var i = 0; i < data.labels.length; i++) {
                            $("#SelectVendor").append(
                                '<option value="' + data.labels[i] + '">' +
                                data.labels[i] +
                                '</option>'
                            );
                        }
                    }
                },
                error: function () {
                    console.log("Vendor data not found");
                }
            });
        }

    });


</script>
</body>
        </div>
</asp:Content>