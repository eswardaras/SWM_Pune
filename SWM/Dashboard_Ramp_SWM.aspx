<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard_Ramp_SWM.aspx.cs" Inherits="SWM.Dashboard_Ramp_SWM" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="card-sub-container">

<title>Integrated Ramp and Processing Dashboard</title>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.plot.ly/plotly-2.30.0.min.js"></script>

<style>
    body {
        font-family: Arial;
        background: linear-gradient(to bottom right, #3f51b5, #003366);
        color: #fff;
        margin: 0;
        padding: 0;
    }

    .header-bar {
        background-color: #0d47a1;
        padding: 15px 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-bottom: 1px solid rgba(255,255,255,0.2);
    }

    .dashboard-container { padding: 10px; }

    .grid-2-col, .grid-3-col {
        display: grid;
        gap: 10px;
        margin-bottom: 10px;
    }

    .grid-2-col { grid-template-columns: repeat(2,1fr); }
    .grid-3-col { grid-template-columns: repeat(3,1fr); }

    .chart-card {
        background: #fff;
        color: #000;
        border-radius: 8px;
        padding: 15px;
        height: 320px;
        position: relative;
        display: flex;
        flex-direction: column;
    }

    .plotly-chart { 
        flex-grow: 1; 
        visibility: hidden; /* Hidden until loader hides */
    }

    .chart-loader {
        width: 40px;
        height: 40px;
        position: absolute;
        top: 50%; left: 50%;
        transform: translate(-50%, -50%);
        background: url('/images/301.gif') center center no-repeat;
        background-size: contain;
        display: none;
        z-index: 100;
    }
</style>

<body>

<div id="form1">
<div class="header-bar">
    <h1>Integrated Ramp and Processing Dashboard</h1>

    <div style="background:#3f51b5;color:#FFFFFF;padding:8px 15px;border-radius:6px;
                font-size:14px;font-weight:bold;display:inline-flex;align-items:center;
                cursor:pointer"
         onclick="document.getElementById('hiddenDatePicker').showPicker()">

        <span id="dateDisplay"></span>
        <span style="margin-left:8px;font-size:16px;">&#128197;</span>

        <input type="date" id="hiddenDatePicker"
               onchange="handleDateChange(event)"
               style="position:absolute;visibility:hidden;width:0;height:0;">
    </div>
</div>


<div class="dashboard-container">

    <div class="grid-2-col">
        <div class="chart-card"><div class="chart-loader"></div><div id="rampGarbageSummaryChart" class="plotly-chart"></div></div>
        <div class="chart-card"><div class="chart-loader"></div><div id="dryGarbageProcessingChart" class="plotly-chart"></div></div>
    </div>

    <div class="grid-2-col">
        <div class="chart-card"><div class="chart-loader"></div><div id="postProcessingPlantChart" class="plotly-chart"></div></div>
        <div class="chart-card"><div class="chart-loader"></div><div id="bioGasProcessingPlantChart" class="plotly-chart"></div></div>
    </div>

    <div class="grid-2-col">
        <div class="chart-card"><div class="chart-loader"></div><div id="rampTypeSplitChart" class="plotly-chart"></div></div>
        <div class="chart-card"><div class="chart-loader"></div><div id="wetWasteProcessingChart" class="plotly-chart"></div></div>
    </div>

    <div class="grid-3-col">
        <div class="chart-card"><div class="chart-loader"></div><div id="dailyWasteCollectionChart" class="plotly-chart"></div></div>
        <div class="chart-card"><div class="chart-loader"></div><div id="legacyWasteChart" class="plotly-chart"></div></div>
        <div class="chart-card"><div class="chart-loader"></div><div id="legacySummaryChart" class="plotly-chart"></div></div>
    </div>

</div>
</div>

<script>

    // --------------- LOADER FUNCTION ---------------
    function toggleLoader(chartId, show) {
        const chartDiv = document.getElementById(chartId);
        const card = chartDiv.closest(".chart-card");
        const loader = card.querySelector(".chart-loader");

        if (show) {
            loader.style.display = "block";
            chartDiv.style.visibility = "hidden";
        } else {
            loader.style.display = "none";
            chartDiv.style.visibility = "visible";
        }
    }


    // --------------- BASE LAYOUT ---------------
    function getBaseLayout(title) {
        return {
            title: { text: "<b>" + title + "</b>", font: { size: 16, color: "#000" } },
            paper_bgcolor: "#fff",
            plot_bgcolor: "#fff",
            font: { color: "#000", size: 10 },
            margin: { l: 40, r: 20, t: 35, b: 40 }
        };
    }

    const BASE_URL = "http://localhost:57324/api/";
    const today = new Date().toISOString().split("T")[0];

    // Disable future dates
    $("#hiddenDatePicker").attr("max", today);


    // ----------- DATE UI -----------
    function updateDateUI(dateString) {
        const date = new Date(dateString);
        $("#dateDisplay").text(
            date.toLocaleDateString("en-GB")
        );
    }

    function handleDateChange(event) {
        updateDateUI(event.target.value);
        loadAllCharts();
    }

    function getSelectedDate() {
        let date = $("#hiddenDatePicker").val();
        if (!date) date = today;
        return { startDate: date, endDate: date };
    }


    // --------------- CHART FUNCTIONS WITH LOADER ENABLED ---------------
    function renderRampGarbageSummary() {
        const chartId = "rampGarbageSummaryChart";
        toggleLoader(chartId, true);

        $.get(BASE_URL + "RampGarbageSummaryMT", getSelectedDate(), api => {
            let layout = getBaseLayout("Ramp Garbage Summary (MT)");

            let traces = [
                { y: api.labels, x: api.datasets[0].data, name: api.datasets[0].label, type: "bar", orientation: "h" },
                { y: api.labels, x: api.datasets[1].data, name: api.datasets[1].label, type: "bar", orientation: "h" },
                { y: api.labels, x: api.datasets[2].data, name: api.datasets[2].label, type: "bar", orientation: "h" }
            ];

            Plotly.newPlot(chartId, traces, layout, { responsive: true });
            toggleLoader(chartId, false);
        });
    }

    function createBarChart(endpoint, chartId, title) {
        toggleLoader(chartId, true);

        $.get(BASE_URL + endpoint, getSelectedDate(), api => {
            let layout = getBaseLayout(title);
            let traces = api.datasets
                ? api.datasets.map(ds => ({ x: api.labels, y: ds.data, name: ds.label, type: "bar" }))
                : [{ x: api.labels, y: api.values, type: "bar" }];

            Plotly.newPlot(chartId, traces, layout, { responsive: true });
            toggleLoader(chartId, false);
        });
    }

    function renderDryGarbageProcessing() {
        createBarChart("ProcessingplantfordryGarbage", "dryGarbageProcessingChart", "Dry Garbage Processing");
    }

    function renderPostProcessingPlant() {
        createBarChart("PostprocessingPlantMT", "postProcessingPlantChart", "Post Processing Plant");
    }

    function renderBioGasProcessingPlant() {
        createBarChart("BioGasProcessingPlantKG", "bioGasProcessingPlantChart", "BioGas Processing (KG)");
    }

    function renderRampTypeSplit() {
        createBarChart("RampWiseGarbageTypeSplit", "rampTypeSplitChart", "Ramp Wise Garbage Type Split");
    }

    function renderWetWasteProcessing() {
        createBarChart("WetWasteProcessingPlantMT", "wetWasteProcessingChart", "Wet Waste Processing (MT)");
    }

    function renderDailyWasteCollection() {
        createBarChart("DailyWasteCollectionMT", "dailyWasteCollectionChart", "Daily Waste Collection (MT)");
    }

    function renderLegacyWaste() {
        createBarChart("LegacyWasteMT", "legacyWasteChart", "Legacy Waste (MT)");
    }

    function renderLegacySummary() {
        const chartId = "legacySummaryChart";
        toggleLoader(chartId, true);

        $.get(BASE_URL + "LegacyWasteSummaryMT", getSelectedDate(), api => {
            let layout = getBaseLayout("Legacy Waste Summary");
            let traces = [{
                labels: api.labels,
                values: api.values,
                type: "pie",
                hole: 0.5
            }];

            Plotly.newPlot(chartId, traces, layout, { responsive: true });
            toggleLoader(chartId, false);
        });
    }


    // --------------- LOAD ALL ---------------
    function loadAllCharts() {
        renderRampGarbageSummary();
        renderDryGarbageProcessing();
        renderPostProcessingPlant();
        renderBioGasProcessingPlant();
        renderRampTypeSplit();
        renderWetWasteProcessing();
        renderDailyWasteCollection();
        renderLegacyWaste();
        renderLegacySummary();
    }

    $(document).ready(function () {
        $("#hiddenDatePicker").val(today);
        updateDateUI(today);
        loadAllCharts();
    });

</script>
</body>
</div>
</asp:Content>
