<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SweeperBeatCoverageReport.aspx.cs" Inherits="SWM.SweeperBeatCoverageReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <head>
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
        <link rel="stylesheet" href="css/sweeperAttendance.css" />
        <!-- Sweet Aleart -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <!-- Sweet Aleart End -->
        <!-- Select 2 -->
        <link
            href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css"
            rel="stylesheet" />
        <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
        <!-- Select 2 end -->
        <title>Sweeper Beat Coverage Report</title>
    </head>
    <body>
        <div class="filters-section">
            <div class="filters-container">
                <div class="title d-flex justify-content-between">
                    <div class="d-flex align-items-center">
                        <i class="fa-solid fa-book"></i>
                        <h3>Sweeper Beat Coverage Report</h3>
                    </div>
                </div>
                <div class="body">
                    <div class="row px-3 pb-3">
                        <div class="col-md-3 col-lg-2">
                            <label for="zoneDropdown">Zone</label>
                            <select
                                id="zoneDropdown"
                                class="form-control"
                                onchange="handleZoneSelect(event)">
                                <option value="0">Select Zone</option>
                            </select>
                        </div>
                        <div class="col-md-3 col-lg-2">
                            <label for="wardDropdown">Ward</label>
                            <select
                                id="wardDropdown"
                                class="form-control"
                                onchange="handleWardSelect(event)">
                                <option value="0">Select Ward</option>
                            </select>
                        </div>
                        <div class="col-md-3 col-lg-2">
                            <label for="kothiDropdown">Kothi</label>
                            <select
                                id="kothiDropdown"
                                class="form-control"
                                onchange="handleKothiSelect(event)">
                                <option value="0">Select Kothi</option>
                            </select>
                        </div>
                        <div class="col-md-3 col-lg-2">
                            <label for="sweeperDropdown">Sweeper Name</label>
                            <select id="sweeperDropdown" class="form-control">
                                <option value="0">Select Sweeper</option>
                            </select>
                        </div>
                        <div class="col-md-3 col-lg-2 date-wrapper">
                            <label for="">From Date</label>
                            <input type="date" class="form-control" id="startDate" />
                        </div>
                        <div class="col-md-3 col-lg-2 date-wrapper">
                            <label for="">To Date</label>
                            <input type="date" class="form-control" id="endDate" />
                        </div>
                        <div class="col-md-3 col-lg-2 mt-1">
                            <div class="d-flex align-items-end h-100">
                                <button
                                    class="btn btn-success"
                                    type="button"
                                    id="btnSearch"
                                    onclick="getData()">
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
            <div class="sweeper-coverage-report mb-5">
                <div class="title dropdown-btn">
                    <div class="controls">
                        <div>
                            <h2>Pune Municipal Corporation</h2>
                        </div>
                        <div class="alert alert-danger mb-0 p-1 " id="dateDetails"></div>
                    </div>
                    <div class="downloads d-flex" id="div1" visible="true">
                        <button type="button" class="btn btn-light toggler__btn p-1">
                            <i class="fa-solid fa-chevron-down"></i>
                        </button>
                    </div>
                </div>

                <div class="body collapsible active toggler__content">
                    <table class="table table-striped text-center" id="table">
                        <thead>
                            <tr>
                                <th>Sr. No</th>
                                <th>Date</th>
                                <th>Sweeper Name</th>
                                <th>Zone</th>
                                <th>Ward</th>
                                <th>Kothi</th>
                                <th>Status</th>
                                <th>Total Distance in Meter</th>
                                <th>Covered Distance</th>
                                <th>Covered Percentage(%)</th>
                            </tr>
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
            const dateInput = document.querySelectorAll("input[type='date']");
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
        <script src="https://cdn.jsdelivr.net/npm/xlsx@0.16.9/dist/xlsx.full.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.6.0/jszip.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/2.0.5/FileSaver.min.js"></script>
        <script src="js/SweeperBeatCoverageReport.js"></script>
    </body>
</asp:Content>
