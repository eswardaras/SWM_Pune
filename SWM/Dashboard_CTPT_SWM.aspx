<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard_CTPT_SWM.aspx.cs" Inherits="SWM.Dashboard_CTPT_SWM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card-sub-container">
        <head>
            <title>CT, PT, & Urinals Dashboard</title>
            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
            <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css" />
            <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
            <script src="https://cdn.plot.ly/plotly-2.30.0.min.js"></script>

            <style>
                /* --- BASE & BACKGROUND STYLES (DARK) --- */
                body {
                    font-family: Arial, sans-serif;
                    background: linear-gradient(to bottom right, #3f51b5, #003366); /* Dark Blue Background */
                    color: #FFFFFF;
                    margin: 0;
                    padding: 0;
                    overflow-x: hidden;
                    min-height: 100vh;
                }

                .header-bar {
                    background-color: #0d47a1;
                    color: #fff;
                    padding: 15px 20px;
                    display: flex;
                    border: 1px solid rgba(255, 255, 255, 0.2);
                    justify-content: space-between;
                    align-items: center;
                }

                    .header-bar h1 {
                        margin: 0;
                        font-size: 24px;
                    }

                /* Date indicator in the header */
                .header-date-box {
                    background-color: #fff;
                    color: #000;
                    padding: 8px 15px;
                    border-radius: 6px;
                    font-size: 12px;
                    font-weight: lighter;
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
                /* --- FILTER BAR STYLING (MATCHING CARD BACKGROUND) --- */
                .filter-bar {
                    display: grid;
                    grid-template-columns: repeat(4, 1fr);
                    gap: 15px; /* Increased gap */
                    padding: 20px;
                    margin-bottom: 10px;
                    align-items: flex-end; /* Align inputs to the bottom */
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
                        border: 1px solid #ccc;
                        background-color: #fff;
                        color: #000;
                        font-size: 14px;
                    }

                /* --- DASHBOARD GRID LAYOUT --- */
                .dashboard-container {
                    padding: 20px;
                }

                .grid-3-col {
                    display: grid;
                    grid-template-columns: repeat(3, 1fr);
                    gap: 10px;
                    margin-bottom: 10px;
                }

                /* --- CHART AND TABLE CARD STYLING (WHITE/LIGHT THEME) --- */
                .chart-card, .table-card {
                    background-color: #FFFFFF; /* White Card Background */
                    color: #000;
                    padding: 15px;
                    border-radius: 8px;
                    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
                    height: 350px;
                    min-height: 300px;
                    display: flex;
                    flex-direction: column;
                    position: relative;
                }

                .table-card {
                    height: auto;
                    min-height: 200px;
                    padding: 0; /* Remove padding here, add it to wrapper elements */
                    overflow-x: auto;
                    margin-top: 20px;
                }

                .plotly-chart {
                    flex-grow: 1;
                    min-height: 300px;
                    /* Used by JS loader: */
                    visibility: hidden;
                }

                /* --- TABLE STYLING --- */
                .table-header {
                    padding: 15px;
                    font-size: 18px;
                    font-weight: bold;
                    color: #000;
                }

                /* DataTable Header (The Blue Bar) */
                .data-table th {
                    background-color: #3f51b5; /* Dark Blue Header */
                    color: #fff;
                    font-weight: bold;
                    text-transform: uppercase;
                    padding: 10px;
                    white-space: nowrap;
                    border-bottom: none !important;
                }

                /* DataTable Body Rows */
                .data-table td {
                    padding: 10px;
                    border-bottom: 1px solid #eee;
                    white-space: nowrap;
                    color: #333;
                }

                /* --- DATA TABLES THEME OVERRIDES (CRITICAL FIXES) --- */
                .dataTables_wrapper {
                    padding: 0 15px 15px 15px; /* Add internal padding for controls and bottom */
                }

                    /* Top bar: Length changer and Search Filter */
                    .dataTables_wrapper .top {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        padding: 10px 0;
                        color: #333;
                        font-size: 14px;
                    }

                    .dataTables_wrapper .bottom {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        padding-top: 10px;
                        color: #333;
                        font-size: 14px;
                    }

                /* Input and Select styling for Search and Length */
                .dataTables_filter input[type="search"],
                .dataTables_length select {
                    background-color: #fff;
                    border: 1px solid #ccc;
                    padding: 5px 10px;
                    border-radius: 4px;
                    color: #000;
                    margin-left: 5px;
                }

                /* Pagination Button Styles */
                .dataTables_wrapper .dataTables_paginate .paginate_button {
                    background-color: #0d47a1; /* Dark Blue button background */
                    color: #fff !important;
                    border: 1px solid #1a237e !important;
                    border-radius: 4px;
                    margin: 0 2px;
                    padding: 6px 10px;
                    cursor: pointer;
                    transition: background-color 0.2s;
                }

                    .dataTables_wrapper .dataTables_paginate .paginate_button:hover {
                        background-color: #3f51b5 !important;
                    }

                    .dataTables_wrapper .dataTables_paginate .paginate_button.current,
                    .dataTables_wrapper .dataTables_paginate .paginate_button.current:hover {
                        background-color: #5c6bc0 !important; /* Lighter blue for active page */
                        color: #fff !important;
                        box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
                    }

                /* --- RESPONSIVENESS --- */
                @media (max-width: 1200px) {
                    .grid-3-col {
                        grid-template-columns: repeat(2, 1fr);
                    }

                    .filter-bar {
                        grid-template-columns: repeat(2, 1fr);
                    }
                }

                @media (max-width: 768px) {
                    .filter-bar, .grid-3-col {
                        grid-template-columns: 1fr;
                    }
                }
            </style>
        </head>
       
            <div id="form1">
                <div class="header-bar">
                    <h1>CT, PT & Urinals Dashboard</h1>
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
                            <label for="selectBlock">Block</label>
                            <select id="selectBlock">
                                <option value="all">Select Block</option>
                                <option value="CT">CT</option>
                                <option value="PT">PT</option>
                            </select>
                        </div>
                        <div class="filter-group">
                            <label for="selectMokadam">Mokadam</label>
                            <select id="selectMokadam">
                                <option value="all">Select Mokadam</option>
                                <option value="mok1">Siddharth Bagul</option>
                            </select>
                        </div>
                        <div class="filter-group">
                            <label for="selectZone">Zone Name</label>
                            <select id="selectZone">
                                <option value="all">Select Zone</option>
                                <option value="zone2">Zone 2</option>
                            </select>
                        </div>
                        <div class="filter-group">
                            <label for="selectWard">Ward Name</label>
                            <select id="selectWard">
                                <option value="all">Select Ward</option>
                                <option value="wardA">Ambil Odha</option>
                            </select>
                        </div>
                    </div>

                    <div class="grid-3-col">
                        <div class="chart-card">
                            <div class="chart-loader"></div>
                            <div id="overallCoverageChart" class="plotly-chart"></div>
                        </div>

                        <div class="chart-card">
                            <div class="chart-loader"></div>
                            <div id="zoneWiseSplitChart" class="plotly-chart"></div>
                        </div>

                        <div class="chart-card">
                            <div class="chart-loader"></div>
                            <div id="wardWiseSplitChart" class="plotly-chart"></div>
                        </div>
                    </div>

                    <div class="table-card">
                        <div class="table-header">Monthly CTPT Coverage Status</div>
                        <div style="flex-grow: 1; overflow-x: auto;">
                            <table class="data-table" id="tblCTPT">
                                <thead>
                                    <tr>
                                        <th>BLOCK</th>
                                        <th>MOKADAM</th>
                                        <th>ZONENAME</th>
                                        <th>WARDNAME</th>
                                        <th>KOTHINAME</th>
                                        <th class="text-right">TOTAL</th>
                                        <th class="text-right">VISITED</th>
                                        <th class="text-right">INVALID</th>
                                        <th class="text-right">UNVISITED</th>
                                        <th class="text-right">PERCENT_VISITED</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td colspan="10" class="text-center">Loading data...</td>
                                    </tr>
                                </tbody>
                            </table>
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

                const CHART_INNER_HEIGHT = 300;

                // --- LOADER TOGGLE FUNCTION (Uses visibility for smooth transition) ---
                function toggleLoader(chartId, show) {
                    const chartDiv = document.getElementById(chartId);
                    const cardElement = chartDiv ? chartDiv.closest('.chart-card') : null;
                    if (!cardElement && chartId !== '#tblCTPT') return;

                    const loader = cardElement ? cardElement.querySelector('.chart-loader') : null;

                    if (loader) {
                        loader.style.display = show ? 'block' : 'none';
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
                        margin: { l: 20, r: 20, t: 30, b: 20 }
                    };
                }

                // Helper function to manage loading/error messages, particularly for the table
                function showLoadingMessage(targetSelector, message, isTable = true, colspan = 8) {

                    if (isTable && $.fn.DataTable.isDataTable(targetSelector)) {
                        try {
                            $(targetSelector).DataTable().destroy();
                        } catch (e) {
                            console.warn("Could not destroy DataTable:", e);
                        }
                    }

                    // Re-add basic table structure if needed (ensure thead is present for CSS to apply)
                    if (isTable) {
                        if ($(targetSelector).find('thead').length === 0) {
                            $(targetSelector).append('<thead></thead>');
                        }
                        if ($(targetSelector).find('tbody').length === 0) {
                            $(targetSelector).append('<tbody></tbody>');
                        }
                    }

                    const $tbody = $(targetSelector).find('tbody');
                    if ($tbody.length === 0) {
                        $(targetSelector).html('<div style="text-align:center; padding: 20px; color: #888;">' + message + '</div>');
                        return;
                    }

                    // Using dark theme colors for status messages (visible on white table background)
                    const color = message.includes("Error") ? "#D32F2F" : "#455A64";

                    $tbody.html(`
                        <tr>
                            <td colspan="${colspan}" 
                                style="text-align:center; padding:15px; color:${color}; font-weight:600;">
                                ${message}
                            </td>
                        </tr>
                    `);
                }
                // --- END HELPER FUNCTIONS ---


                // --- 1. Overall Coverage (Nested Doughnut: PT/CT/Urinals) ---
                function renderOverallCoverage() {
                    const chartId = "overallCoverageChart";
                    toggleLoader(chartId, true);

                    // Colors suitable for light theme
                    var blockColors = { "CT": "#EF5350", "PT": "#FFC107", "Urinals": "#66BB6A" };
                    var statusColors = { "Visited": "#4CAF50", "Unvisited": "#90A4AE", "Invalid": "#FF7043" };

                    $.ajax({
                        type: "GET",
                        url: "https://iswmpune.in/api/OverallCoverage",
                        dataType: "json",
                        success: function (apiData) {
                            toggleLoader(chartId, false);

                            var labels = [];
                            var parents = [];
                            var values = [];
                            var colors = [];

                            // 1. CLEAN DATA: Filter out empty block labels to ensure math consistency
                            var cleanInnerLabels = [];
                            var cleanInnerValues = [];
                            apiData.innerRing.labels.forEach((label, i) => {
                                if (label && label.trim() !== "") {
                                    cleanInnerLabels.push(label);
                                    cleanInnerValues.push(apiData.innerRing.values[i]);
                                }
                            });

                            // Calculate total based only on visible blocks
                            var overallTotal = cleanInnerValues.reduce((a, b) => a + b, 0);

                            // 2. ROOT NODE
                            labels.push("Overall");
                            parents.push("");
                            values.push(overallTotal);
                            colors.push("#42A5F5");

                            // 3. BLOCK LEVEL (INNER RING)
                            cleanInnerLabels.forEach(function (block, i) {
                                labels.push(block);
                                parents.push("Overall");
                                values.push(cleanInnerValues[i]);
                                colors.push(blockColors[block] || "#BDBDBD");
                            });

                            // 4. STATUS LEVEL (OUTER RING)
                            var statusTotals = {};
                            apiData.outerRing.labels.forEach(function (s, i) {
                                statusTotals[s] = apiData.outerRing.values[i];
                            });

                            // Calculate total sum of status values to get weights
                            var totalStatusSum = apiData.outerRing.values.reduce((a, b) => a + b, 0);

                            cleanInnerLabels.forEach(function (block, i) {
                                var blockTotal = cleanInnerValues[i];
                                var runningSumForBlock = 0;

                                apiData.outerRing.labels.forEach(function (status, j) {
                                    var finalVal;

                                    // Logic: If it's the last status item, use subtraction to avoid rounding errors
                                    if (j === apiData.outerRing.labels.length - 1) {
                                        finalVal = blockTotal - runningSumForBlock;
                                    } else {
                                        // Calculate weight based on the status's global share
                                        var weight = statusTotals[status] / totalStatusSum;
                                        finalVal = Math.round(weight * blockTotal);
                                        runningSumForBlock += finalVal;
                                    }

                                    labels.push(status + " (" + block + ")");
                                    parents.push(block);
                                    values.push(finalVal);
                                    colors.push(statusColors[status] || "#CCCCCC");
                                });
                            });

                            // 5. PLOTLY CONFIGURATION
                            var data = [{
                                type: "sunburst",
                                labels: labels,
                                parents: parents,
                                values: values,
                                branchvalues: "total",
                                marker: {
                                    colors: colors,
                                    line: { color: "#000", width: 1 }
                                },
                                textinfo: "label+percent parent",
                                insidetextorientation: "radial",
                                hoverinfo: "label+value+percent entry"
                            }];

                            var layout = getBaseLayout("Overall Coverage");
                            layout.margin = { l: 10, r: 10, t: 60, b: 10 };

                            Plotly.newPlot(chartId, data, layout, { responsive: true, displayModeBar: false });
                        },
                        error: function (xhr) {
                            console.error("AJAX error:", xhr.responseText);
                            toggleLoader(chartId, false);
                        }
                    });
                }

                // --- 2. Zone Wise Split (Sunburst Chart) ---
                function renderZoneWiseSplit() {
                    const chartId = "zoneWiseSplitChart";
                    toggleLoader(chartId, true);

                    // Colors suitable for light theme
                    var zoneColors = { "1": "#FF7043", "2": "#FFC107", "3": "#66BB6A", "4": "#42A5F5", "5": "#7E57C2" };
                    var statusColors = { "Visited": "#4CAF50", "Unvisited": "#FFB74D", "Invalid": "#EF5350" };

                    $.ajax({
                        type: "GET",
                        url: "https://iswmpune.in/api/ZoneWiseCoverageSplit",
                        dataType: "json",
                        success: function (apiData) {
                            toggleLoader(chartId, false);

                            var labels = [];
                            var parents = [];
                            var values = [];
                            var colors = [];

                            // ROOT
                            labels.push("Overall"); parents.push("");
                            values.push(apiData.innerRing.values.reduce((a, b) => a + b, 0)); colors.push("#90A4AE");

                            // ZONE LEVEL (INNER RING)
                            apiData.innerRing.labels.forEach(function (zone, i) {
                                labels.push(zone); parents.push("Overall");
                                values.push(apiData.innerRing.values[i]);
                                colors.push(zoneColors[zone] || "#BDBDBD");
                            });

                            // STATUS LEVEL (OUTER RING)
                            apiData.outerRing.labels.forEach(function (label, i) {
                                var parts = label.split(" - ");
                                var zone = parts[0];
                                var status = parts[1];

                                labels.push(status); parents.push(zone);
                                values.push(apiData.outerRing.values[i]);
                                colors.push(statusColors[status] || "#CCCCCC");
                            });

                            var data = [{
                                type: "sunburst", labels: labels, parents: parents, values: values, branchvalues: "total",
                                marker: { colors: colors }, textinfo: "label+percent parent", insidetextorientation: "radial"
                            }];

                            var layout = getBaseLayout("Zone Wise Coverage Split");
                            layout.margin = { l: 10, r: 10, t: 60, b: 10 };

                            Plotly.newPlot(chartId, data, layout, { responsive: true, displayModeBar: false });
                        },
                        error: function (xhr) {
                            console.error("AJAX error:", xhr.responseText);
                            toggleLoader(chartId, false);
                        }
                    });
                }

                // --- 3. Ward Wise Split (Sunburst Chart) ---
                function renderWardWiseSplit() {
                    const chartId = "wardWiseSplitChart";
                    toggleLoader(chartId, true);

                    // Colors suitable for light theme
                    var statusColors = { "Visited": "#4CAF50", "Unvisited": "#FFB74D", "Invalid": "#EF5350" };

                    $.ajax({
                        type: "GET",
                        url: "https://iswmpune.in/api/WardWiseCoverageSplit",
                        dataType: "json",
                        success: function (apiData) {
                            toggleLoader(chartId, false);

                            var labels = [];
                            var parents = [];
                            var values = [];
                            var colors = [];

                            // ROOT
                            labels.push("Overall"); parents.push("");
                            values.push(apiData.innerRing.values.reduce((a, b) => a + b, 0)); colors.push("#90A4AE");

                            // INNER RING (WARDS)
                            apiData.innerRing.labels.forEach(function (ward, i) {
                                labels.push(ward); parents.push("Overall");
                                values.push(apiData.innerRing.values[i]);
                                colors.push("#BDBDBD"); // neutral color for wards
                            });

                            // OUTER RING (STATUS SPLIT)
                            apiData.outerRing.labels.forEach(function (fullLabel, i) {
                                var lastDash = fullLabel.lastIndexOf(" - ");
                                var ward = fullLabel.substring(0, lastDash);
                                var status = fullLabel.substring(lastDash + 3);

                                labels.push(status); parents.push(ward);
                                values.push(apiData.outerRing.values[i]);
                                colors.push(statusColors[status] || "#CCCCCC");
                            });

                            var data = [{
                                type: "sunburst", labels: labels, parents: parents, values: values, branchvalues: "total",
                                marker: { colors: colors }, textinfo: "label+percent parent", insidetextorientation: "radial"
                            }];

                            var layout = getBaseLayout("Ward Wise Coverage Split");
                            layout.margin = { l: 10, r: 10, t: 60, b: 10 };

                            Plotly.newPlot(chartId, data, layout, { responsive: true, displayModeBar: false });
                        },
                        error: function (xhr) {
                            console.error("AJAX error:", xhr.responseText);
                            toggleLoader(chartId, false);
                        }
                    });
                }

                // --- 4. CTPT DataTables (With Search/Pagination Fix) ---
                function renderCTPTTable() {
                    const tableSelector = "#tblCTPT";
                    const apiUrl = "https://iswmpune.in/api/MonthlyCTPTCoverageStatus";
                    const headerText = "Monthly CTPT Coverage Status";
                    const colspan = 10;

                    showLoadingMessage(tableSelector, 'Loading ' + headerText + ' data...', true, colspan);

                    $.ajax({
                        url: apiUrl,
                        type: "GET",
                        dataType: "json",
                        success: function (data) {

                            if (!Array.isArray(data) || data.length === 0) {
                                showLoadingMessage(tableSelector, 'No ' + headerText + ' data available.', true, colspan);
                                return;
                            }

                            if ($.fn.DataTable.isDataTable(tableSelector)) {
                                $(tableSelector).DataTable().clear().destroy();
                            }

                            // Re-initialize the table with full headers before DataTable runs
                            $(tableSelector).html(`
                                <thead>
                                    <tr>
                                        <th>BLOCK</th><th>MOKADAM</th><th>ZONENAME</th><th>WARDNAME</th><th>KOTHINAME</th>
                                        <th class="text-right">TOTAL</th><th class="text-right">VISITED</th><th class="text-right">INVALID</th>
                                        <th class="text-right">UNVISITED</th><th class="text-right">PERCENT_VISITED</th>
                                    </tr>
                                </thead>
                                <tbody></tbody>
                            `);


                            // Initialize DataTable
                            $(tableSelector).DataTable({
                                data: data,
                                paging: true,
                                pageLength: 10,
                                searching: true,
                                ordering: true,
                                info: true,
                                autoWidth: false,
                                scrollX: true,

                                // CRITICAL FIX: Custom DOM structure for controls
                                // lf: Length changer and Filter (Search) in the 'top' wrapper (left and right aligned)
                                // rt: processing and Table
                                // ip: Info and Pagination in the 'bottom' wrapper (left and right aligned)
                                dom: '<"top"lf>rt<"bottom"ip><"clear">',

                                columns: [
                                    { data: "BLOCK", title: "BLOCK" },
                                    { data: "MOKADAM", title: "MOKADAM" },
                                    { data: "ZONENAME", title: "ZONE" },
                                    { data: "WARDNAME", title: "WARD" },
                                    { data: "KOTHINAME", title: "KOTHI NAME" },
                                    { data: "TOTAL", title: "TOTAL", className: "text-right" },
                                    { data: "VISITED", title: "VISITED", className: "text-right" },
                                    { data: "INVALID", title: "INVALID", className: "text-right" },
                                    { data: "UNVISITED", title: "UNVISITED", className: "text-right" },
                                    {
                                        data: "PERCENT_VISITED",
                                        title: "% VISITED",
                                        className: "text-right",
                                        render: function (d) {
                                            const pct = parseFloat(d);
                                            if (isNaN(pct)) return "0.00 %";

                                            let color =
                                                pct >= 75 ? "#4CAF50" :
                                                    pct >= 50 ? "#FFC107" :
                                                        "#F44336";

                                            return `<span style="color:${color};font-weight:600">
                                            ${pct.toFixed(2)} %
                                            </span>`;
                                        }
                                    }
                                ],

                                order: [[9, "desc"]]
                            });
                        },

                        error: function (xhr) {
                            console.error("AJAX Error for " + headerText + ":", xhr.responseText);
                            showLoadingMessage(tableSelector, 'Error loading data. Check API status (Status: ' + xhr.status + ')', true, colspan);
                        }
                    });
                }

                // --- Execute All Chart Rendering on Page Load ---
                window.onload = function () {
                    renderOverallCoverage();
                    renderZoneWiseSplit();
                    renderWardWiseSplit();
                    renderCTPTTable();
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
