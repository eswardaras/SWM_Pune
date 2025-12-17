<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard_Drain_SWM.aspx.cs" Inherits="Dashboard_Drain_SWM" %>



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
                    color: #fff; /* Green text matching the Mokadam/Drainage style */
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
                        url: "https://iswmpune.in/api/DrainageworkerAttendence",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            toggleLoader(chartId, false);

                            var apiData = response;

                            // Convert API response → Plotly format
                            var plotlyData = [{
                                labels: apiData.labels,
                                values: apiData.values,
                                type: "pie",
                                hole: 0.4, // Doughnut chart

                                // CORRECTION: Set textinfo to 'none' to remove labels inside the slices
                                textinfo: "none",
                                insidetextorientation: "radial",

                                // Keep hovertemplate for displaying detailed data on mouseover
                                hovertemplate:
                                    "<b>%{label}</b><br>" +
                                    "Count: %{value}<br>" +
                                    "Percentage: %{percent}<extra></extra>"
                            }];

                            // Layout & Layout title
                            var layout = getBaseLayout('Drainage Worker Attendance');

                            // Assuming you want the legend to remain visible for a clean Doughnut chart
                            layout.showlegend = true;

                            // Adjust margins to account for the legend position
                            layout.margin = {
                                l: 20,
                                r: 120, // Space for the legend on the right
                                t: 40,
                                b: 20
                            };

                            // Define the legend position and style for the dark theme
                            layout.legend = {
                                x: 1.05,
                                y: 0.5,
                                bgcolor: 'rgba(0,0,0,0)', // Transparent background
                                font: { color: '#000' }
                            };

                            // Remove unnecessary annotations
                            layout.annotations = [];

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
                        url: "https://iswmpune.in/api/DrainageAttendanceZoneWise",
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
                        url: "https://iswmpune.in/api/DrainageAttendanceWardWise",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            toggleLoader(chartId, false);

                            var apiData = response;

                            // --- 1. PLOTLY DATA TRACE ADJUSTMENT ---
                            var plotlyData = [{
                                labels: apiData.labels,
                                values: apiData.values,
                                type: "pie",
                                hole: 0.4,

                                // CORRECTION 2: Set textinfo to 'none' or 'value' 
                                // to hide the full label and percentage inside the slice.
                                textinfo: "none",
                                insidetextorientation: "radial",

                                // Keep hovertemplate so users can see details on mouseover
                                hovertemplate:
                                    "<b>%{label}</b><br>" +
                                    "Count: %{value}<br>" +
                                    "Percentage: %{percent}<extra></extra>"
                            }];

                            // --- 2. PLOTLY LAYOUT ADJUSTMENT ---
                            var layout = getBaseLayout('Drainage Attendance WardWise');

                            // CORRECTION 1: Show the external legend
                            layout.showlegend = true;

                            // Revert margins to provide space for the legend, placed to the right
                            layout.margin = {
                                l: 20,
                                r: 80, // Space for the legend on the right
                                t: 40,
                                b: 20
                            };

                            // Define the legend position
                            layout.legend = {
                                x: 1.05,
                                y: 0.5,
                                bgcolor: 'rgba(0,0,0,0)', // Transparent background to blend with card
                                font: { color: '#000' }
                            };

                            layout.annotations = [];

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
