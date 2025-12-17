<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard_IMEI_SWM.aspx.cs" Inherits="SWM.Dashboard_IMEI_SWM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card-sub-container">
        
        <title>IMEI Ping Status Dashboard</title>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.plot.ly/plotly-2.30.0.min.js"></script>

        <style>
            /* --- Base & Background Styles (Matching IMEI Theme) --- */
            body {
                font-family: Arial, sans-serif;
                background: linear-gradient(to bottom right, #3f51b5, #003366);
                color: #FFFFFF;
                margin: 0;
                padding: 0;
                overflow-x: hidden;
                min-height: 100vh;
            }

            /* --- Header/Title Bar --- */
            .header-bar {
                background-color: #0d47a1;
                padding: 15px 20px;
                display: flex;
                border-bottom: 1px solid rgba(255, 255, 255, 0.2);
                justify-content: space-between;
                align-items: center;
            }

            .header-bar h1 {
                margin: 0;
                font-size: 24px;
                font-weight: bold;
                color: #fff;
            }

            /* --- Filter Bar Styling (6-Column Grid for IMEI) --- */
            .filter-bar {
                display: grid;
                grid-template-columns: repeat(6, 1fr);
                gap: 7px;
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
                border: 1px solid #FFFFFF;
                background-color: #FFFFFF;
                color: #000;
                font-size: 14px;
                cursor: pointer;
            }

            /* --- Dashboard Grid Layout --- */
            .dashboard-container {
                padding: 20px;
            }

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
                position: relative;
            }

            .plotly-chart {
                flex-grow: 1;
                min-height: 350px;
            }

            .chart-card, .box, .dashboard-chart {
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

            /* --- Responsive Adjustments --- */
            @media (max-width: 1200px) {
                .grid-2-col {
                    grid-template-columns: 1fr;
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
        </style>


        <div id="form1">
            <div class="header-bar">
                <h1>IMEI Ping Status Dashboard</h1>
                <div style="background-color: #fff; color: #000; padding: 8px 15px; border-radius: 6px; font-size: 12px; font-weight: semibold; display: inline-block; margin-right: 20px;">
                    15/12/2025
                </div>
            </div>

            <div class="dashboard-container">

                <div class="filter-bar">

                    <div class="filter-group">
                        <label>Zone</label>
                        <select id="selectZone">
                            <option value="all">Zone (leave blank to include all)</option>
                        </select>
                    </div>

                    <div class="filter-group">
                        <label>Ward</label>
                        <select id="selectWard">
                            <option value="all">Ward</option>
                        </select>
                    </div>

                    <div class="filter-group">
                        <label>Kothi</label>
                        <select id="selectKothi">
                            <option value="all">Kothi </option>
                        </select>
                    </div>

                    <div class="filter-group">
                        <label>Name</label>
                        <select id="selectName">
                            <option value="all">Name</option>
                        </select>
                    </div>

                    <div class="filter-group">
                        <label>Type</label>
                        <select id="selectType">
                            <option value="all">Type </option>
                        </select>
                    </div>

                    <div class="filter-group">
                        <label>IMEI</label>
                        <select id="selectIMEI">
                            <option value="all">IMEI </option>
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
                const cardElement = chartDiv ? chartDiv.closest('.chart-card') : null;
                if (!cardElement) return;

                const loader = cardElement.querySelector('.chart-loader');

                if (loader) {
                    loader.style.display = show ? 'block' : 'none';
                    chartDiv.style.visibility = show ? 'hidden' : 'visible';
                }
            }
            // --- END LOADER TOGGLE FUNCTION ---


            // --- 1. Devices Last Ping (Vertical Bar Chart) - FIXED LOGIC ---
            function renderLastPingChart() {
                const chartId = "lastPingChart";
                toggleLoader(chartId, true);

                // Get the current value from the IMEI dropdown
                var selectedIMEI = $("#selectIMEI").val();

                $.ajax({
                    type: "GET",
                    url: "api/DevicesLastPing",
                    data: {
                        // FIX: If the value is "all" or the default empty string (""), send null to get aggregated data.
                        // Otherwise, send the specific IMEI.
                        IMEI: (selectedIMEI === "" || selectedIMEI === "all") ? null : selectedIMEI
                    },
                    dataType: "json",
                    success: function (apiData) {
                        toggleLoader(chartId, false);

                        var labels = apiData.labels || [];
                        var values = (apiData.datasets && apiData.datasets.length > 0)
                            ? apiData.datasets[0].data
                            : [];

                        // Safety check
                        if (labels.length === 0 || values.length === 0) {
                            Plotly.purge(chartId);
                            return;
                        }

                        var plotlyData = [{
                            x: labels,
                            y: values,
                            type: "bar",
                            text: values,
                            textposition: "auto",
                            marker: { color: "#6A7BFF" }
                        }];

                        var total = values.reduce((a, b) => a + b, 0);

                        var layout = {
                            title: {
                                text: (selectedIMEI !== "" && selectedIMEI !== "all")
                                    ? `<b>Devices Last Ping (IMEI: ${selectedIMEI})</b>`
                                    : `<b>Devices Last Ping (Total IMEI: ${total})</b>`,
                                font: { size: 16 }
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
                                l: 60, r: 20, t: 60, b: 100
                            }
                        };

                        Plotly.react(
                            chartId,
                            plotlyData,
                            layout,
                            { responsive: true, displayModeBar: false }
                        );
                    },
                    error: function (xhr) {
                        console.error("AJAX error:", xhr.responseText);
                        toggleLoader(chartId, false);
                    }
                });
            }


            // --- 2. Hour Wise Ping for Today (Vertical Bar Chart) ---
            function renderHourWisePingChart() {
                const chartId = "hourWisePingChart";
                toggleLoader(chartId, true);

                // 1. Get the selected IMEI, similar to the other chart
                var selectedIMEI = $("#selectIMEI").val();

                $.ajax({
                    type: "GET",
                    url: "api/HourWisePingforToday",
                    data: {
                        // 2. Pass the selected IMEI to the API
                        // Use the same robust logic: send null if "all" or "" is selected.
                        IMEI: (selectedIMEI === "" || selectedIMEI === "all") ? null : selectedIMEI
                    },
                    dataType: "json",
                    success: function (apiData) {
                        toggleLoader(chartId, false);

                        var labels = apiData.labels;
                        var values = apiData.datasets?.[0]?.data || [];

                        // Safety check for no data
                        if (labels.length === 0 || values.length === 0) {
                            Plotly.purge(chartId);
                            return;
                        }

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

                        var total = values.reduce((a, b) => a + b, 0);
                        var layout = {
                            title: {
                                // 3. Update the title to reflect the filter
                                text: selectedIMEI && selectedIMEI !== "all"
                                    // Ensure the dynamic text is wrapped in <b> tags for bolding
                                    ? `<b>Hour Wise Ping Today (IMEI: ${selectedIMEI})</b>`
                                    : `<b>Hour Wise Ping Today (Total Pings: ${total})</b>`,
                                font: {
                                    size: 16, // Set font size to 16
                                }
                            },
                            xaxis: {
                                title: "Last Ping Hour",
                                dtick: 1
                            },
                            yaxis: {
                                title: "Ping Counts", // Changed from IMEI Counts to Ping Counts for clarity
                                gridcolor: "#E5E5E5"
                            },
                            showlegend: false,
                            margin: {
                                l: 60, r: 20, t: 60, b: 60
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
                        toggleLoader(chartId, false);
                    }
                });
            }

            // --------------------------------------------------------------------------------------
            // --- FILTER LOADING FUNCTIONS ---
            // --------------------------------------------------------------------------------------

            // IMEI Loading (Calls initial chart render)
            function loadVehicleIMEI() {
                $("#selectIMEI").empty()
                    .append('<option value="all">IMEI (All)</option>'); // Set default to 'all' for clarity

                $.ajax({
                    url: 'api/GetIMENoAPI',
                    type: "GET",
                    dataType: "json",
                    success: function (data) {

                        if (data && data.labels) {
                            for (var i = 0; i < data.labels.length; i++) {
                                $("#selectIMEI").append(
                                    '<option value="' + data.labels[i] + '">' +
                                    data.labels[i] +
                                    '</option>'
                                );
                            }
                        }

                        // CRITICAL: Initial Chart RENDER AFTER FILTERS ARE LOADED
                        renderLastPingChart();
                        renderHourWisePingChart();
                    },
                    error: function () {
                        console.log("IMEI data not found");
                    }
                });
            }

            // Name Loading
            function loadVehicleNames() {
                $("#selectName").empty()
                    .append('<option value="all">Select Vehicle Name</option>');

                $.ajax({
                    url: 'api/GetIMENameAPI',
                    type: "GET",
                    dataType: "json",
                    success: function (data) {

                        if (data && data.labels) {
                            for (var i = 0; i < data.labels.length; i++) {
                                $("#selectName").append(
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

            // Type Loading
            function loadVehicleType() {
                $("#selectType").empty()
                    .append('<option value="all">Select TYPE</option>');

                $.ajax({
                    url: 'api/GetIMEVehicleTypeAPI',
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

            // Zone Loading
            $.ajax({
                url: '/api/GetzoneAPI',
                type: "GET",
                dataType: "json",
                success: function (json) {
                    $("#selectZone").empty()
                        .append('<option value="all">Select Zone</option>');

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


            // --------------------------------------------------------------------------------------
            // --- INITIALIZATION AND EVENT HANDLING ---
            // --------------------------------------------------------------------------------------

            $(document).ready(function () {

                // Load dependent filters
                loadVehicleIMEI();
                loadVehicleNames();
                loadVehicleType();


                // 🚀 CRITICAL FIX: Add the Change Event Listener for IMEI
                $("#selectIMEI").on('change', function () {
                    renderLastPingChart();
                    renderHourWisePingChart();// Call the function to re-fetch data and render
                });

                // --- Zone/Ward/Kothi Change Handlers ---

                // -------- WARD (Triggers on Zone change) --------
                $("#selectZone").change(function () {
                    var id = $(this).val();

                    $("#selectWard").empty().append('<option value="">Select Ward</option>');
                    $("#selectKothi").empty().append('<option value="">Select Kothi</option>');

                    if (!id || id === "all") return;

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

                // -------- KOTHI (Triggers on Ward change) --------
                $("#selectWard").change(function () {
                    var id = $(this).val();

                    $("#selectKothi").empty().append('<option value="">Select Kothi</option>');

                    if (!id || id === "all") return;

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


            });

        </script>

    </div>
</asp:Content>
