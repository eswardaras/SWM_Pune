<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MokadumHistoryMap_Mobile.aspx.cs" Inherits="SWM.MokadumHistoryMap_Mobile" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
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
    <!-- Leaftlet Links End -->
    <!-- Leaflet Map Full Screen Links -->
    <script src="https://api.mapbox.com/mapbox.js/plugins/leaflet-fullscreen/v1.0.1/Leaflet.fullscreen.min.js"></script>
    <link
        href="https://api.mapbox.com/mapbox.js/plugins/leaflet-fullscreen/v1.0.1/leaflet.fullscreen.css"
        rel="stylesheet" />
    <!-- Leaflet Map Full Screen Links End-->
    <!-- Sweet Aleart -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <!-- Sweet Aleart End -->
    <link rel="stylesheet" href="css/sweeperAttendance.css" />

    <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
    <script src="https://unpkg.com/@turf/turf@latest"></script>
    <script src="https://unpkg.com/@turf/turf@7.0.0/turf.min.js"></script>

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
    <title>Mokadum History Map</title>
</head>
<body>
    <div class="container-fluid my-3">
        <div
            class="border mx-2 d-flex justify-content-between align-items-center">
            <h3><i class="fa-solid fa-book mx-2"></i>Mokadum History Map</h3>
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
                    <label for="wardDropdown">Kothi</label>
                    <select
                        id="kothiDropdown"
                        class="fstdropdown-select"
                        onchange="handleKothiSelect(event)">
                        <option value="0">Select</option>
                    </select>
                </div>
                <div class="col-lg-2 col-md-3 mt-1">
                    <label for="mokadumDropdown">Mokadum Name</label>
                    <select id="mokadumDropdown" class="fstdropdown-select">
                        <option value="0">Select</option>
                    </select>
                </div>
                <div class="col-lg-2 col-md-3 mt-1 date-wrapper">
                    <label for="wardDropdown">Start Date</label>
                    <input type="datetime-local" class="form-control" id="startDate" />
                </div>
                <div class="col-lg-2 col-md-3 mt-1 date-wrapper">
                    <label for="wardDropdown">End Date</label>
                    <input type="datetime-local" class="form-control" id="endDate" />
                </div>
                <div class="col-lg-auto col-md-auto mt-1">
                    <div class="d-flex align-items-end h-100">
                        <button
                            class="btn btn-primary me-1"
                            type="submit"
                            id="btnShowRoute">
                            Show Kothi
                        </button>
                        <button
                            class="btn btn-success me-1 text-white"
                            type="submit"
                            id="btnPlay">
                            <i class="fa-regular fa-circle-play text-white"></i>
                            Play
                        </button>
                        <button
                            class="btn btn-warning text-white"
                            type="button"
                            id="btnRefresh">
                            Refresh
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
                $(button).parent().parent().next().slideToggle("fast");
            }

            $(".toggler__btn").click(function () {
                collapseContent(this);
            });
        });
    </script>
    <script defer src="js/MokadamHistoryMap.js"></script>
</body>
</html>
