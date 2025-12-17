<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="JatayuReport.aspx.cs" Inherits="SWM.JatayuReport" %>

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
        <script
            src="https://code.jquery.com/jquery-3.3.1.min.js"
            integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
            crossorigin="anonymous"></script>
        <!-- DataTable Links -->
        <link
            rel="stylesheet"
            href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css" />
        <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/buttons/2.0.1/js/dataTables.buttons.min.js"></script>
        <script src="https://cdn.datatables.net/buttons/2.0.1/js/buttons.html5.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.6.0/jszip.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
        <!-- DataTable Links End -->
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
        <title>Jatayu Report</title>
    </head>
    <body>
        <div class="filters-section">
            <div class="filters-container">
                <div class="title d-flex justify-content-between">
                    <div class="d-flex align-items-center">
                        <i class="fa-solid fa-book"></i>
                        <h3>Jatayu Report</h3>
                    </div>
                </div>
                <div class="body">
                    <div class="row px-3 pb-3">
                        <div class="col-sm-2">
                            <label for="">Zone</label>
                            <select
                                name=""
                                id="zoneDropdown"
                                class="fstdropdown-select"
                                onchange="handleZoneSelect(event)">
                                <option value="">Select Zone</option>
                            </select>
                        </div>
                        <div class="col-sm-2">
                            <label for="">Ward Name</label>
                            <select
                                name=""
                                id="wardDropdown"
                                class="fstdropdown-select"
                                onchange="handleWardSelect(event)">
                                <option value="">Select Ward</option>
                            </select>
                        </div>
                        <div class="col-sm-2">
                            <label for="">Jatayu Name</label>
                            <select
                                name=""
                                id="jatayuNameDropdown"
                                class="fstdropdown-select">
                                <option value="">Select Jatayu Name</option>
                            </select>
                        </div>
                        <div class="col-sm-2 date-wrapper">
                            <label for="">From Date</label>
                            <input type="date" class="form-control" id="startDate" />
                        </div>
                        <div class="col-sm-2 date-wrapper">
                            <label for="">To Date</label>
                            <input type="date" class="form-control" id="endDate" />
                        </div>
                        <div class="col-sm-2">
                            <div class="d-flex align-items-end h-100">
                                <button
                                    class="btn btn-sm btn-success"
                                    type="submit"
                                    id="btnSearch">
                                    Search
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <section
            class="sweeper-coverage-report-section"
            style="display: none"
            id="tableWrapper">
            <div class="sweeper-coverage-report">
                <div class="title dropdown-btn">
                    <div class="controls">
                        <div>
                            <h2>Pune Municipal Corporation</h2>
                            <h3 id="dateSpan" class="alert alert-danger p-1"></h3>
                        </div>
                    </div>
                    <div class="d-flex align-items-center">
                        <div id="countWrapper" class="mx-2" style="display: none">
                            <button type="button" class="btn btn-primary btn-sm text-white">
                                Total Cronic Spot
                <span class="badge bg-light text-dark" id="cronicSpot">0</span>
                            </button>
                            <button type="button" class="btn btn-primary btn-sm">
                                Total Waste Collected
                <span class="badge bg-light text-dark" id="wasteCollected">0</span>
                            </button>
                        </div>
                        <div class="downloads d-flex align-items-center">
                            <button type="button" class="btn btn-light toggler__btn p-1">
                                <i class="fa-solid fa-chevron-down"></i>
                            </button>
                        </div>
                    </div>
                </div>

                <div class="body collapsible active toggler__content">
                    <table class="table table-striped text-center" id="table">
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Zone</th>
                                <th>Ward Name</th>
                                <th>Jatayu Name</th>
                                <th>Visited Chronic Spot</th>
                                <th>Waste Collected</th>
                                <th>Image</th>
                                <th>View History</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>
        </section>

        <!-- Error Modal -->
        <div class="modal" tabindex="-1" id="error_warning">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Warning</h5>
                        <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close">
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="alert alert-danger" role="alert">
                            From date can not be greater than to date
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Error Modal End -->

        <!--Jatayu Photo -->
        <div class="modal" tabindex="-1" id="photo">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="photoTitle">Image Gallery</h5>
                        <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close">
                        </button>
                    </div>
                    <div class="modal-body overflow-auto">
                        <table
                            class="table table-striped text-center table-bordered border border-top"
                            id="imageTable">
                            <thead>
                                <tr>
                                    <th>Date</th>
                                    <th>Time</th>
                                    <th>Spot Name</th>
                                    <th>Before Image</th>
                                    <th>After Image</th>
                                </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <!--Jatayu Photo End -->

        <!-- Map -->
        <div class="modal" tabindex="-1" id="mapModal">
            <div class="modal-dialog modal-lg modal-fullscreen">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalTitle"></h5>
                        <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close">
                        </button>
                    </div>
                    <div class="modal-body overflow-auto">
                        <div id="map" style="height: 80dvh" class="w-100"></div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Map End -->

        <script
            src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
            integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
            crossorigin="anonymous"></script>
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"
            integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+"
            crossorigin="anonymous"></script>
        <script></script>
        <script src="js/axios.js"></script>
        <script>
            const dateInput = document.querySelectorAll("input[type='date']");
            const sDate = document.getElementById("startDate");
            const eDate = document.getElementById("endDate");
            const currentDate = new Date().toISOString().substr(0, 10);

            dateInput.forEach((input) => {
                if (!input.value) {
                    input.value = currentDate;
                }
            });
        </script>
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
        <script src="js/jatayuReport.js"></script>
    </body>
</asp:Content>
