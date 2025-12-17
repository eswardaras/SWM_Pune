<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RampProcessing.aspx.cs" Inherits="SWM.RampProcessing" %>
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
            padding: 15px 20px;
            background: rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
        }
        .dashboard-container { padding: 20px; }
        .grid-2-col {
            display: grid;
            grid-template-columns: repeat(2,1fr);
            gap: 10px;
            margin-bottom: 10px;
        }
        .grid-3-col {
            display: grid;
            grid-template-columns: repeat(3,1fr);
            gap: 10px;
            margin-bottom: 10px;
        }
        .chart-card {
            background: #fff;
            color: #000;
            border-radius: 8px;
            padding: 15px;
            height: 320px;
            display: flex;
            flex-direction: column;
            position: relative; /* IMPORTANT for loader positioning */
        }
        .plotly-chart { 
            flex-grow: 1; 
            /* Ensure chart area is visible when loader is hidden */
            visibility: hidden; 
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
</head>

<body>
<div id="form1" >
    <div class="header-bar">
        <h1>Integrated Ramp and Processing Dashboard</h1>
        <div class="header-date">12/12/2025</div>
    </div>

    <div class="dashboard-container">

        <div class="grid-2-col">
            <div class="chart-card">
                <div class="chart-loader"></div>
                <div id="rampGarbageSummaryChart" class="plotly-chart"></div>
            </div>
            <div class="chart-card">
                <div class="chart-loader"></div>
                <div id="dryGarbageProcessingChart" class="plotly-chart"></div>
            </div>
        </div>

        <div class="grid-2-col">
            <div class="chart-card">
                <div class="chart-loader"></div>
                <div id="postProcessingPlantChart" class="plotly-chart"></div>
            </div>
            <div class="chart-card">
                <div class="chart-loader"></div>
                <div id="bioGasProcessingPlantChart" class="plotly-chart"></div>
            </div>
        </div>

        <div class="grid-2-col">
            <div class="chart-card">
                <div class="chart-loader"></div>
                <div id="rampTypeSplitChart" class="plotly-chart"></div>
            </div>
            <div class="chart-card">
                <div class="chart-loader"></div>
                <div id="wetWasteProcessingChart" class="plotly-chart"></div>
            </div>
        </div>

        <div class="grid-3-col">
            <div class="chart-card">
                <div class="chart-loader"></div>
                <div id="dailyWasteCollectionChart" class="plotly-chart"></div>
            </div>
            <div class="chart-card">
                <div class="chart-loader"></div>
                <div id="legacyWasteChart" class="plotly-chart"></div>
            </div>
            <div class="chart-card">
                <div class="chart-loader"></div>
                <div id="legacySummaryChart" class="plotly-chart"></div>
            </div>
        </div>

    </div>
</div>

<script>

    const BASE_URL = "http://localhost:75/api/";

    // --- LOADER TOGGLE FUNCTION ---
    function toggleLoader(chartId, show) {
        const chartDiv = document.getElementById(chartId);
        // Locate the nearest parent container with position: relative for the loader
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

    // COMMON LAYOUT
    function getBaseLayout(title) {
        return {
            title: { text: "<b>" + title + "</b>", font: { size: 16, color: "#000" } },
            paper_bgcolor: "#fff",
            plot_bgcolor: "#fff",
            font: { color: "#000", size: 10 },
            margin: { l: 40, r: 20, t: 35, b: 40 }
        };
    }

    /* ======================================================
      1) Ramp Garbage Summary MT
    ======================================================*/
    function renderRampGarbageSummary() {
        const chartId = "rampGarbageSummaryChart";
        toggleLoader(chartId, true);

        $.ajax({
            url: BASE_URL + "RampGarbageSummaryMT",
            type: "GET",
            success: function (api) {
                toggleLoader(chartId, false);
                let layout = getBaseLayout("Ramp Garbage Summary (MT)");
                layout.barmode = "stack";

                let traces = [
                    { y: api.labels, x: api.datasets[0].data, name: api.datasets[0].label, type: "bar", orientation: "h", marker: { color: "#DC3545" } },
                    { y: api.labels, x: api.datasets[1].data, name: api.datasets[1].label, type: "bar", orientation: "h", marker: { color: "#28A745" } },
                    { y: api.labels, x: api.datasets[2].data, name: api.datasets[2].label, type: "bar", orientation: "h", marker: { color: "#00BCD4" } }
                ];

                Plotly.newPlot(chartId, traces, layout, { responsive: true, displayModeBar: false });
            },
            error: function () {
                toggleLoader(chartId, false);
            }
        });
    }

    /* ======================================================
      2) Processing Dry Garbage
    ======================================================*/
    function renderDryGarbageProcessing() {
        const chartId = "dryGarbageProcessingChart";
        toggleLoader(chartId, true);

        $.ajax({
            url: BASE_URL + "ProcessingplantfordryGarbage",
            type: "GET",
            success: function (api) {
                toggleLoader(chartId, false);
                let layout = getBaseLayout("Processing Plant for Dry Garbage");
                layout.barmode = "group";

                let traces = [
                    { x: api.labels, y: api.datasets[0].data, name: "Plant Capacity", type: "bar", marker: { color: "#005F7A" } },
                    { x: api.labels, y: api.datasets[1].data, name: "Incoming", type: "bar", marker: { color: "#00BCD4" } }
                ];

                Plotly.newPlot(chartId, traces, layout, { responsive: true, displayModeBar: false });
            },
            error: function () {
                toggleLoader(chartId, false);
            }
        });
    }

    /* ======================================================
      3) Post Processing Plant
    ======================================================*/
    function renderPostProcessingPlant() {
        const chartId = "postProcessingPlantChart";
        toggleLoader(chartId, true);

        $.ajax({
            url: BASE_URL + "PostprocessingPlantMT",
            type: "GET",
            success: function (api) {
                toggleLoader(chartId, false);
                let layout = getBaseLayout("Post Processing Plant (MT)");
                layout.barmode = "group";

                let traces = [
                    { x: api.labels, y: api.datasets[0].data, name: "Plant Capacity", type: "bar", marker: { color: "#005F7A" } },
                    { x: api.labels, y: api.datasets[1].data, name: "Incoming", type: "bar", marker: { color: "#00BCD4" } }
                ];

                Plotly.newPlot(chartId, traces, layout, { responsive: true, displayModeBar: false });
            },
            error: function () {
                toggleLoader(chartId, false);
            }
        });
    }

    /* ======================================================
      4) Bio Gas Processing Plant
    ======================================================*/
    function renderBioGasProcessingPlant() {
        const chartId = "bioGasProcessingPlantChart";
        toggleLoader(chartId, true);

        $.ajax({
            url: BASE_URL + "BioGasProcessingPlantKG",
            type: "GET",
            success: function (api) {
                toggleLoader(chartId, false);
                let layout = getBaseLayout("Bio Gas Processing Plant (KG)");
                layout.barmode = "group";

                let traces = [
                    { x: api.labels, y: api.datasets[0].data, name: "Plant Capacity", type: "bar", marker: { color: "#005F7A" } },
                    { x: api.labels, y: api.datasets[1].data, name: "Incoming", type: "bar", marker: { color: "#00BCD4" } }
                ];

                Plotly.newPlot(chartId, traces, layout, { responsive: true, displayModeBar: false });
            },
            error: function () {
                toggleLoader(chartId, false);
            }
        });
    }

    /* ======================================================
      5) Ramp Wise Garbage Type Split
    ======================================================*/
    function renderRampTypeSplit() {
        const chartId = "rampTypeSplitChart";
        toggleLoader(chartId, true);

        $.ajax({
            url: BASE_URL + "RampWiseGarbageTypeSplit",
            type: "GET",
            success: function (api) {
                toggleLoader(chartId, false);
                let layout = getBaseLayout("Ramp Wise Garbage Type Split");
                layout.barmode = "stack";

                let traces = api.datasets.map(ds => ({
                    x: api.labels,
                    y: ds.data,
                    name: ds.label,
                    type: "bar"
                }));

                Plotly.newPlot(chartId, traces, layout, { responsive: true, displayModeBar: false });
            },
            error: function () {
                toggleLoader(chartId, false);
            }
        });
    }

    /* ======================================================
      6) Wet Waste Processing Plant
    ======================================================*/
    function renderWetWasteProcessing() {
        const chartId = "wetWasteProcessingChart";
        toggleLoader(chartId, true);

        $.ajax({
            url: BASE_URL + "WetWasteProcessingPlantMT",
            type: "GET",
            success: function (api) {
                toggleLoader(chartId, false);
                let layout = getBaseLayout("Wet Waste Processing Plant (MT)");
                layout.barmode = "group";

                let traces = [
                    { x: api.labels, y: api.datasets[0].data, name: "Plant Capacity", type: "bar", marker: { color: "#005F7A" } },
                    { x: api.labels, y: api.datasets[1].data, name: "Incoming", type: "bar", marker: { color: "#00BCD4" } }
                ];

                Plotly.newPlot(chartId, traces, layout, { responsive: true, displayModeBar: false });
            },
            error: function () {
                toggleLoader(chartId, false);
            }
        });
    }

    /* ======================================================
      7) Daily Waste Collection
    ======================================================*/
    function renderDailyWasteCollection() {
        const chartId = "dailyWasteCollectionChart";
        toggleLoader(chartId, true);

        $.ajax({
            url: BASE_URL + "DailyWasteCollectionMT",
            type: "GET",
            success: function (api) {
                toggleLoader(chartId, false);

                let layout = getBaseLayout("Daily Waste Collection (MT)");

                let trace = {
                    x: api.labels,
                    y: api.datasets[0].data,
                    type: "bar",
                    marker: { color: "#36A2EB" }
                };

                Plotly.newPlot(chartId, [trace], layout, { responsive: true, displayModeBar: false });
            },
            error: function () {
                toggleLoader(chartId, false);
            }
        });
    }

    /* ======================================================
      8) Legacy Waste MT
    ======================================================*/
    function renderLegacyWaste() {
        const chartId = "legacyWasteChart";
        toggleLoader(chartId, true);

        $.ajax({
            url: BASE_URL + "LegacyWasteMT",
            type: "GET",
            success: function (api) {
                toggleLoader(chartId, false);
                let layout = getBaseLayout("Legacy Waste (MT)");

                let trace = {
                    x: api.labels,
                    y: api.values,
                    type: "bar",
                    marker: { color: "#36A2EB" }
                };

                Plotly.newPlot(chartId, [trace], layout, { responsive: true, displayModeBar: false });
            },
            error: function () {
                toggleLoader(chartId, false);
            }
        });
    }

    /* ======================================================
      9) Legacy Summary MT
    ======================================================*/
    function renderLegacySummary() {
        const chartId = "legacySummaryChart";
        toggleLoader(chartId, true);

        $.ajax({
            url: BASE_URL + "LegacyWasteSummaryMT",
            type: "GET",
            success: function (api) {
                toggleLoader(chartId, false);
                let trace = {
                    values: api.values,
                    labels: api.labels,
                    type: "pie",
                    hole: 0.5
                };

                let layout = getBaseLayout("Legacy Summary (MT)");

                Plotly.newPlot(chartId, [trace], layout, { responsive: true, displayModeBar: false });
            },
            error: function () {
                toggleLoader(chartId, false);
            }
        });
    }

    /* ======================================================
      LOAD ALL CHARTS ON PAGE LOAD
    ======================================================*/
    $(document).ready(function () {
        renderRampGarbageSummary();
        renderDryGarbageProcessing();
        renderPostProcessingPlant();
        renderBioGasProcessingPlant();
        renderRampTypeSplit();
        renderWetWasteProcessing();
        renderDailyWasteCollection();
        renderLegacyWaste();
        renderLegacySummary();
    });

</script>
</body>
    </div>
</asp:Content>