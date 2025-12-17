<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="VehicleStatusReport.aspx.cs" Inherits="SWM.VehicleStatusReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <head>
        <script src="js/jquery-3.3.1.min.js"></script>
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
        <link rel="stylesheet" href="css/fstdropdown.css" />
        <script src="js/fstdropdown.js"></script>
        <link rel="stylesheet" href="css/sweeperAttendance.css" />
        <!-- Sweet Aleart -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <!-- Sweet Aleart End -->
        <style>
            .cursor-pointer {
                cursor: pointer;
            }
        </style>
        <title>Vehicle Status Report</title>
    </head>
    <body>
        <div class="container-fluid my-3" id="editPanel">
            <div
                class="border mx-2 d-flex justify-content-between align-items-center">
                <h6 class="mb-0">
                    <i class="fa-solid fa-book mx-2"></i>Vehicle Status Report
                </h6>
                <button type="button" class="btn btn-light h-100 toggler__btn">
                    <i class="fa-solid fa-chevron-down"></i>
                </button>
            </div>
            <div class="toggler__content">
                <div class="row border border-top-0 mx-2 py-2">
                    <div class="col-lg-2 col-md-3 mt-1">
                        <label for="zoneDropdown">Zone</label>
                        <select
                            id="zoneDropdown"
                            class="fstdropdown-select"
                            onchange="handleZoneSelect()">
                            <option value="0">Select Zone</option>
                        </select>
                    </div>
                    <div class="col-lg-2 col-md-3 mt-1">
                        <label for="wardDropdown">Ward</label>
                        <select
                            id="wardDropdown"
                            class="fstdropdown-select"
                            onchange="handleWardSelect()">
                            <option value="0">Select Ward</option>
                        </select>
                    </div>
                    <div class="col-lg-2 col-md-2 mt-1">
                        <div class="d-flex align-items-start mt-4 h-100">
                            <button
                                class="btn btn-success me-2"
                                type="button"
                                id="btnSearch"
                                onclick="populateTable()">
                                Submit
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <section class="sweeper-coverage-report-section" id="tableWrapper" style="display: none">
            <div class="sweeper-coverage-report">
                <div class="body collapsible active toggler__content">
                    <table class="table table-striped text-center" id="table">
                        <thead>
                            <th>Sr.No</th>
                            <th>Status as on</th>
                            <th>Zone</th>
                            <th>Ward</th>
                            <th>Vehicle Name</th>
                            <th>IMEI</th>
                            <th>Vehicle Type</th>
                            <th>Vendor Name</th>
                            <th>Current Status</th>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>
        </section>

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
        <script src="js/VehicleStatusReport.js"></script>
    </body>
</asp:Content>
