<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CreateGeofence.aspx.cs" Inherits="SWM.CreateGeofence" %>

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
        <script src="https://unpkg.com/leaflet-control-geocoder/dist/Control.Geocoder.js"></script>
        <script src="https://unpkg.com/leaflet-control-geocoder/dist/Control.Geocoder.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet.draw/0.4.2/leaflet.draw.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Turf.js/6.5.0/turf.min.js"></script>

        <link
            rel="stylesheet"
            href="https://unpkg.com/leaflet-control-geocoder/dist/Control.Geocoder.css" />
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/leaflet.draw/0.4.2/leaflet.draw.css" />
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/Leaflet.awesome-markers/2.0.2/leaflet.awesome-markers.css" />
        <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/gh/python-visualization/folium/folium/templates/leaflet.awesome.rotate.min.css" />
        <!-- Leaftlet Links End -->
        <!-- Leaflet Map Full Screen Links -->
        <script src="https://api.mapbox.com/mapbox.js/plugins/leaflet-fullscreen/v1.0.1/Leaflet.fullscreen.min.js"></script>
        <link
            href="https://api.mapbox.com/mapbox.js/plugins/leaflet-fullscreen/v1.0.1/leaflet.fullscreen.css"
            rel="stylesheet" />
        <!-- Leaflet Map Full Screen Links End-->
        <link rel="stylesheet" href="css/sweeperAttendance.css" />
        <style>
            input[type="text"] {
                height: 35px !important;
            }
        </style>
        <title>Geofence</title>
    </head>
    <body>
        <div class="container-fluid my-3">
            <div
                class="border mx-2 d-flex justify-content-between align-items-center">
                <h3><i class="fa-solid fa-book mx-2"></i>Geofence</h3>
                <button type="button" class="btn btn-light h-100 toggler__btn">
                    <i class="fa-solid fa-chevron-down"></i>
                </button>
            </div>
            <div class="toggler__content">
                <div class="row border border-top-0 border-bottom-0 mx-2 pb-1">
                    <div class="col-lg-2 col-md-3 mt-1">
                        <label for="geofenceDropdown">Geofence</label>
                        <select id="geofenceDropdown" class="fstdropdown-select">
                            <option value="0">Select Geofence</option>
                        </select>
                    </div>
                    <div class="col-lg-2 col-md-3 mt-1">
                        <div class="d-flex align-items-end h-100">
                            <button
                                type="button"
                                class="btn btn-primary me-1"
                                id="btnShowGeofence"
                                onclick="showGeofenceonMap()">
                                Show Geofence
                            </button>
                        </div>
                    </div>
                </div>
                <div class="row border border-top-0 mx-2 pb-3">
                    <div class="col-lg-2 col-md-3 mt-1">
                        <label for="geoNameInput">Geo Name</label>
                        <input type="text" class="form-control" id="geoNameInput" />
                    </div>
                    <div class="col-lg-2 col-md-3 mt-1 d-none">
                        <label for="shapeTypeDropdown">Shape Type</label>
                        <select
                            id="shapeTypeDropdown"
                            class="fstdropdown-select"
                            onchange="handleShapeTypeSelect(event)">
                            <option value="0">Select Shape</option>
                            <option value="1">Point</option>
                            <option value="2">Line</option>
                            <option value="3">Polygon</option>
                        </select>
                    </div>
                    <div class="col-lg-2 col-md-3 mt-1">
                        <label for="latitudeInput">Latitude</label>
                        <input type="text" class="form-control" id="latitudeInput" />
                    </div>
                    <div class="col-lg-2 col-md-3 mt-1">
                        <label for="longitudeInput">Longitude</label>
                        <input type="text" class="form-control" id="longitudeInput" />
                    </div>
                    <div class="col-lg-2 col-md-3 mt-1">
                        <label for="radiusInput">Radius</label>
                        <input type="text" class="form-control" id="radiusInput" />
                    </div>
                    <div class="col-lg-2 col-md-3 mt-1">
                        <div class="d-flex align-items-end h-100">
                            <button
                                class="btn btn-success me-1"
                                type="button"
                                id="btnSaveShape"
                                onclick="saveShape(event)">
                                Save Shape
                            </button>
                        </div>
                    </div>
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

        <div class="toast-container position-absolute top-0 end-0 p-3">
            <div
                id="successToast"
                class="toast text-bg-success"
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
                <div class="toast-body">Shape Saved Successfully!</div>
            </div>
        </div>

        <div class="toast-container position-absolute top-0 end-0 p-3">
            <div
                id="validationToast"
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
                <div class="toast-body">Please fill all the fields</div>
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
        <script src="js/createGeofence.js"></script>
    </body>
</asp:Content>
