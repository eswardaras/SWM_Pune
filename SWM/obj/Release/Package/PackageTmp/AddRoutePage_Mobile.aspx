<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddRoutePage_Mobile.aspx.cs" Inherits="SWM.AddRoutePage_Mobile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/leaflet@1.7.1/dist/leaflet.css" />
    <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
        crossorigin="anonymous" />
    <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" />
    <script src="https://cdn.jsdelivr.net/npm/leaflet@1.7.1/dist/leaflet.js"></script>
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
        rel="stylesheet"
        integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM"
        crossorigin="anonymous" />
    <script src="https://unpkg.com/xlsx/dist/xlsx.full.min.js"></script>
    <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
        crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/js/all.min.js"></script>
    <script src="http://bbecquet.github.io/Leaflet.PolylineDecorator/dist/leaflet.polylineDecorator.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <link rel="stylesheet" href="css/fstdropdown.css" />
    <script src="js/fstdropdown.js"></script>
    <link rel="stylesheet" href="css/sweeperAttendance.css" />
    <%--        <link rel="stylesheet" href="css/AddRoute.css" />--%>
    <script src="js/axios.js"></script>
    <!-- Leaflet Map Full Screen Links -->
    <script src="https://api.mapbox.com/mapbox.js/plugins/leaflet-fullscreen/v1.0.1/Leaflet.fullscreen.min.js"></script>
    <link
        href="https://api.mapbox.com/mapbox.js/plugins/leaflet-fullscreen/v1.0.1/leaflet.fullscreen.css"
        rel="stylesheet" />
    <!-- Leaflet Map Full Screen Links End-->
    <!-- For Modals -->
    <style>
        input[type="text"],
        input[type="file"] {
            height: 35px;
        }
    </style>
    <script type="text/javascript">
        var commonApi = '<%= ConfigurationManager.AppSettings["CommonApiUrl"]%>';
        var zoneApi = '<%= ConfigurationManager.AppSettings["ZoneApiUrl"]%>';
        var wardApi = '<%= ConfigurationManager.AppSettings["WardApiUrl"]%>';
        var kothiApi = '<%= ConfigurationManager.AppSettings["KothiApiUrl"]%>';
        var routeApi = '<%= ConfigurationManager.AppSettings["RouteApiUrl"]%>';
    </script>
    <script>
        let loginId;
        const currentURL = window.location.href;

        function getQueryParam(url, param) {
            const queryString = url.split('?')[1];
            if (!queryString) {
                return null;
            }
            const params = new URLSearchParams(queryString);
            return params.get(param);
        }

        const loginIdParam = getQueryParam(currentURL, 'loginId');

        if (loginIdParam) {
            try {
                const trimmedLoginId = loginIdParam.substring(2, loginIdParam.length - 2);
                loginId = trimmedLoginId;
                console.log(loginId);
            } catch (error) {
                console.error("Error occurred while trimming loginId:", error);
                // Redirect to the login page
                window.location.href = "Login.aspx";
            }
        } else {
            console.log("loginId parameter not found in the URL.");
        }
    </script>
    <title>Add Route</title>
</head>
<body>
    <div class="container-fluid my-2">
        <div class="container-fluid">
            <div class="row border justify-content-between align-items-center">
                <div class="col-auto">
                    <h5 class="m-1">Add Route</h5>
                </div>
                <div class="col-auto">
                    <i class="fa-solid fa-chevron-down"></i>
                </div>
            </div>
            <div class="row py-2 border border-bottom-0 border-top-0">
                <div class="col-md-2">
                    <label class="fw-bold">Select</label>
                </div>
                <div class="col-md-auto">
                    <div class="form-check">
                        <input
                            class="form-check-input"
                            type="radio"
                            name="radioSelect"
                            id="viewRepDelRadio"
                            checked />
                        <label class="form-check-label" for="viewRepDelRadio">
                            View Replace Delete Route On Map
                        </label>
                    </div>
                </div>
                <div class="col-md-auto">
                    <div class="form-check">
                        <input
                            class="form-check-input"
                            type="radio"
                            name="radioSelect"
                            id="createRouteRadio"
                            oninput="handleUI()" />
                        <label class="form-check-label" for="createRouteRadio">
                            Create Route Point On Map</label>
                    </div>
                </div>
                <!-- <div class="col-md-2">
            <div class="form-check">
              <input
                class="form-check-input"
                type="radio"
                name="radioSelect"
                id="uploadRouteRadio"
              />
              <label class="form-check-label" for="uploadRouteRadio"
                >Upload Route Points File</label
              >
            </div>
          </div> -->
                <div class="col-md-auto">
                    <div class="form-check">
                        <input
                            class="form-check-input"
                            type="radio"
                            name="radioSelect"
                            id="uploadKmlRadio" />
                        <label class="form-check-label" for="uploadKmlRadio">
                            Upload Route KML File</label>
                    </div>
                </div>
                <div class="col-md-auto ms-auto">
                    <button class="btn btn-success btn-sm" onclick="handleRefresh()">
                        Refresh
                    </button>
                </div>
            </div>
            <div class="row border border-top-0 py-3">
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
                        <option value="0">Select Ward</option>
                    </select>
                </div>
                <div
                    class="col-lg-2 col-md-3 mt-1 view-replace-component route-component">
                    <label for="routeDropdown">Route</label>
                    <select
                        id="routeDropdown"
                        class="fstdropdown-select"
                        onchange="handleRouteSelect(event)">
                        <option value="0" selected>Select Route</option>
                    </select>
                </div>
                <div class="col-lg-2 col-md-3 mt-1 vehicle-component">
                    <label for="vehicleDropdown">Vehicle</label>
                    <select
                        id="vehicleDropdown"
                        class="fstdropdown-select"
                        onchange="handleVehicleSelect(event)">
                        <option value="0">Select Vehicle</option>
                    </select>
                </div>
                <div class="col-lg-4 col-md-auto mt-1 view-replace-component">
                    <div class="container-fluid h-100">
                        <div class="row align-items-end h-100">
                            <div class="col-auto mt-1">
                                <button
                                    type="button"
                                    class="btn btn-success btn-sm"
                                    onclick="getRouteData()">
                                    Show
                                </button>
                            </div>
                            <div class="col-auto mt-1" id="btnReplaceWrapper"
                                style="display: none">
                                <button
                                    type="button"
                                    class="btn btn-warning btn-sm"
                                    onclick="handleReplace()">
                                    Replace
                                </button>
                            </div>
                            <div class="col-auto mt-1">
                                <button
                                    type="button"
                                    class="btn btn-danger btn-sm"
                                    onclick="handleDelete()">
                                    Delete
                                </button>
                            </div>
                            <div class="col-auto mt-1">
                                <button
                                    type="button"
                                    class="btn btn-info btn-sm"
                                    onclick="handleDrawRoute()">
                                    Draw Route
                                </button>
                            </div>
                            <!-- <div class="col-auto mt-1">
                  <button class="btn btn-info btn-sm">Show Route</button>
                </div> -->
                        </div>
                    </div>
                </div>
                <div class="col-auto mt-1 replace-with-kml-component">
                    <label for="">
                        Select KML Route File
              <a href="https://earth.google.com/web/" target="_blank">Click Here</a></label>
                    <input
                        id="fileInputKmlReplace"
                        type="file"
                        class="form-control"
                        onchange="handleKmlReplace(event)" />
                </div>
                <!-- <div
            class="col-lg-auto col-md-3 mt-1 date-wrapper create-route-component"
          >
            <div class="d-flex align-items-end">
              <div>
                <label for="wardDropdown">Date</label>
                <input type="date" />
              </div>
              <button class="btn btn-sm btn-warning ms-2">View</button>
            </div>
          </div> -->
                <div class="col-lg-2 col-md-3 mt-1 common-component">
                    <label for="wardDropdown">New Route Name</label>
                    <input type="text" class="form-control" id="newRouteInput" />
                </div>
                <div class="col-lg-auto col-md-auto mt-1 create-route-component">
                    <div class="d-flex align-items-end h-100">
                        <button
                            type="button"
                            class="btn btn-success btn-sm me-2"
                            onclick="handleCreate()">
                            Create
                        </button>
                        <button
                            type="button"
                            class="btn btn-warning btn-sm me-2"
                            onclick="undoSelection()">
                            Undo
                        </button>
                        <button class="btn btn-info btn-sm me-2" type="button">Show Route</button>
                    </div>
                </div>
                <!-- <div class="col-lg-2 col-md-3 mt-1 upload-route-component">
            <label for="wardDropdown"
              >Dwnl .xls File Format <a href="">Click Here</a></label
            >
            <input type="file" class="form-control" />
          </div> -->
                <!-- <div class="col-lg-2 col-md-3 mt-1 upload-route-component">
            <div class="d-flex align-items-end h-100">
              <button class="btn btn-sm btn-info">Import Route</button>
            </div>
          </div> -->
                <div class="col-lg-2 col-md-3 mt-1 upload-kml-component">
                    <label for="wardDropdown">
                        Create KML Route File
              <a href="https://earth.google.com/web/" target="_blank">Click Here</a></label>
                    <input
                        id="fileInputImport"
                        type="file"
                        class="form-control"
                        onchange="handleFile(event)" />
                </div>
                <div class="col-lg-2 col-md-3 mt-1 upload-kml-component">
                    <div class="d-flex align-items-end h-100">
                        <button class="btn btn-sm btn-info" onclick="handleUploadKML()" type="button">
                            Import Route
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="container-fluid my-3">
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
    <script>
        const handleUI = () => {
            if ($("#viewRepDelRadio").prop("checked")) {
                $(".view-replace-component").show();
                $(".create-route-component").hide();
                $(".upload-route-component").hide();
                $(".upload-kml-component").hide();
                $(".common-component").hide();
                $(".vehicle-component").show();
                $(".replace-with-kml-component").show();
            } else if ($("#createRouteRadio").prop("checked")) {
                Swal.fire({
                    position: "top-end",
                    title: "Hold Ctrl and left click to add points on map",
                    allowOutsideClick: true,
                    showConfirmButton: false,
                    timer: 2000,
                });
                $(".view-replace-component").hide();
                $(".create-route-component").show();
                $(".upload-route-component").hide();
                $(".upload-kml-component").hide();
                $(".replace-with-kml-component").hide();
                $(".common-component").show();
                $(".vehicle-component").show();
            } else if ($("#uploadKmlRadio").prop("checked")) {
                $(".view-replace-component").hide();
                $(".create-route-component").hide();
                $(".upload-route-component").hide();
                $(".replace-with-kml-component").hide();
                $(".upload-kml-component").show();
                $(".common-component").show();
                $(".vehicle-component").hide();
            }
        };

        $(document).ready(function () {
            handleUI();
        });
        $("input[type='radio']").on("change", handleUI);
    </script>
    <%--<script src="js/addRoute.js"></script>--%>
    <script defer src="js/AddRoute.js"></script>
</body>
</html>
