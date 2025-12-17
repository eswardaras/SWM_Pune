<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GISDashboard.aspx.cs" Inherits="SWM.GISDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="css/fstdropdown.css" />
        <script src="js/fstdropdown.js"></script>
        <script
            src="https://kit.fontawesome.com/e8c1c6e963.js"
            crossorigin="anonymous"></script>
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
            crossorigin="anonymous" />
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
            crossorigin="anonymous"></script>
        <script src="js/jquery-3.3.1.min.js"></script>
        <!-- Leaftlet Links -->
        <link
            rel="stylesheet"
            href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"
            integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY="
            crossorigin="" />
        <script
            src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"
            integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo="
            crossorigin=""></script>
        <script src="js/Leaflet.Marker.SlideTo.js"></script>
        <script src="js/leaflet.polylineDecorator.js"></script>

        <!-- Leaftlet Links End -->
        <!-- Leaflet Map Full Screen Links -->
        <script src="https://api.mapbox.com/mapbox.js/plugins/leaflet-fullscreen/v1.0.1/Leaflet.fullscreen.min.js"></script>
        <link
            href="https://api.mapbox.com/mapbox.js/plugins/leaflet-fullscreen/v1.0.1/leaflet.fullscreen.css"
            rel="stylesheet" />
        <!-- Leaflet Map Full Screen Links End-->
        <!-- Leaflet Map print/pdf download End-->
        <script src="js/leaflet.browser.print.min.js"></script>
        <!-- Leaflet download map end-->

        <!-- Sweet Aleart -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <!-- Sweet Aleart End -->

        <script src="js/leaflet.label.js"></script>
        <link rel="stylesheet" href="css/leaflet.label.css" />

        <link rel="stylesheet" href="css/sweeperAttendance.css" />
        <link rel="stylesheet" href="css/startIcon.css" />
        <title>GIS Dashboard</title>
	        <style>
            .transparent-tooltip {
                background-color: transparent !important;
                border: none !important;
                box-shadow: none !important;
                color: black; /* Adjust the text color as needed */
                font-size: 5px;
            }

                .transparent-tooltip::before,
                .transparent-tooltip::after {
                    background: transparent !important;
                    border: none !important;
                    box-shadow: none !important;
                }
        </style>
    </head>
    <body>
        <div class="container-fluid my-3">
            <div
                class="border mx-2 d-flex justify-content-between align-items-center">
                <h3><i class="fa-solid fa-earth-americas mx-2"></i>GIS Dashboard</h3>
                <button type="button" class="btn btn-light h-100 toggler__btn">
                    <i class="fa-solid fa-chevron-down"></i>
                </button>
            </div>
            <div class="toggler__content">
                <div class="row border border-top-0 mx-2 py-3">
                    <div class="col-lg-2 col-md-3 mt-1">
                        <label for="zoneDropdown">Zone</label>
                        <select
                            id="zoneDropdown"
                            class="fstdropdown-select"
                            onchange="handleZoneSelect(event)">
                            <option value="0">Select Zone</option>
                        </select>
                    </div>
                    <div class="col-lg-2 col-md-3 mt-1">
                        <label for="wardDropdown">Ward</label>
                        <select
                            id="wardDropdown"
                            class="fstdropdown-select"
                            onchange="handleWardSelect(event)">
                            <option value="">Select Ward</option>
                        </select>
                    </div>
          	<div class="col-lg-2 col-md-3 mt-1">
            		<label for="kothiDropdown">Kothi</label>
            	<select
              id="kothiDropdown"
              class="fstdropdown-select"
              onchange="handleKothiSelect(event)"
            >
              <option value="0">Select</option>
            </select>
          </div>
                    <div
                        class="col-lg-2 col-md-3 mt-1 date-wrapper"
                        style="display: none">
                        <label for="startdate">startdate</label>
                        <input
                            type="date"
                            class="form-control"
                            id="startdate"
                            onchange="handleStartDateSelect()" />
                    </div>
                    <div
                        class="col-lg-2 col-md-3 mt-1 date-wrapper"
                        style="display: none">
                        <label for="enddate">enddate</label>
                        <input
                            type="date"
                            class="form-control"
                            id="enddate"
                            onchange="handleEndDateSelect()" />
                    </div>
                    <!-- <div class="col-lg-2 col-md-3 mt-1">
            <label for="wardDropdown">Kothi</label>
            <select
              id="kothiDropdown"
              class="fstdropdown-select"
              onchange="handleKothiSelect(event)"
            >
              <option value="0">Select</option>
            </select>
          </div> -->
                    <div class="col-md-auto mt-1 d-flex align-items-end">
                        <div class="form-check">
                            <input
                                class="form-check-input"
                                type="checkbox"
                                id="liveKothi"
                                onchange="handleLiveKothiSelect()" />
                            <label class="form-check-label" for="liveKothi">
                                Live Kothi
                            </label>
                        </div>
                    </div>
                    <!-- <div class="col-md-auto mt-1 d-flex align-items-end">
            <div class="form-check">
              <input class="form-check-input" type="radio" id="liveCT" />
              <label class="form-check-label" for="liveCT">
                Live CT/PT/Urinal
              </label>
            </div>
          </div> -->
                    <div class="col-md-auto mt-1 d-flex align-items-end">
                        <div class="form-check">
                            <input
                                class="form-check-input"
                                type="checkbox"
                                id="liveFeeder"
                                onchange="handleLiveFeederSelect()" />
                            <label class="form-check-label" for="liveFeeder">
                                Live Feeder
                            </label>
                        </div>
                    </div>
                    <div class="col-md-auto mt-1 d-flex align-items-end">
                        <div class="form-check">
                            <input
                                class="form-check-input"
                                type="checkbox"
                                id="liveSweeperRoute"
                                onchange="handleLiveSweeperSelect()" />
                            <label class="form-check-label" for="liveSweeperRoute">
                                Live Sweeper
                            </label>
                        </div>
                    </div>
                    <div class="col-md-auto mt-1 d-flex align-items-end">
                        <div class="form-check">
                            <input
                                class="form-check-input"
                                type="checkbox"
                                id="liveMechSweeperRoute"
                                onchange="handleLiveMechSweeperSelect()" />
                            <label class="form-check-label" for="liveMechSweeperRoute">
                                Live Mech Sweeper
                            </label>
                        </div>
                    </div>
                    <!-- <div class="col-md-auto mt-1 d-flex align-items-end">
            <div class="form-check">
              <input class="form-check-input" type="radio" id="livePT" />
              <label class="form-check-label" for="livePT"> Live PT </label>
            </div>
          </div>
          <div class="col-md-auto mt-1 d-flex align-items-end">
            <div class="form-check">
              <input class="form-check-input" type="radio" id="liveUrinal" />
              <label class="form-check-label" for="liveUrinal">
                Live Urinal
              </label>
            </div>
          </div> -->
                </div>
            </div>
        </div>

        <div class="container-fluid">
            <div class="row justify-content-center">
                <div class="col-12">
                    <div
                        id="map"
                        style="height: 70dvh"
                        class="w-100 border border-secondary">
                    </div>
                </div>
            </div>
        </div>

        <!-- <button class="btn btn-primary" onclick="handleDownload()">Download Map</button> -->

        <!-- Toast -->
        <div class="toast-container position-absolute top-0 end-0 p-3">
            <div
                id="noDataToast"
                class="toast text-bg-danger"
                role="alert"
                aria-live="assertive"
                aria-atomic="true">
                <div class="toast-header">
                    <strong class="me-auto">Attention</strong>
                    <small class="text-muted">Just Now</small>
                    <button
                        type="button"
                        class="btn-close"
                        data-bs-dismiss="toast"
                        aria-label="Close">
                    </button>
                </div>
                <div class="toast-body">Nothing Found!</div>
            </div>
        </div>
        <!-- Toast End -->

        <script
            src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
            integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
            crossorigin="anonymous"></script>
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"
            integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+"
            crossorigin="anonymous"></script>
        <script src="js/axios.js"></script>
        <script>
            $(document).ready(function () {
                function collapseContent(button) {
                    $(button).parent().next().slideToggle("fast");
                }

                $(".toggler__btn").click(function () {
                    collapseContent(this);
                });
            });
        </script>
        <script src="js/gisDashboard.js"></script>
    </body>
</asp:Content>
