<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Feeder_Summary_Report.aspx.cs" Inherits="SWM.Feeder_Summary_Report" %>

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
        <title>Feeder Summary Report</title>
    </head>
    <body>
        <div class="filters-section">
            <div class="filters-container">
                <div class="title d-flex justify-content-between">
                    <div class="d-flex align-items-center">
                        <i class="fa-solid fa-book"></i>
                        <h3>Feeder Summary Report</h3>
                    </div>
                </div>
                <div class="body">
                    <form action="">
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
                                <label for="">Ward</label>
                                <select
                                    name=""
                                    id="wardDropdown"
                                    class="fstdropdown-select"
                                    onchange="handleWardSelect(event)">
                                    <option value="">Select Ward</option>
                                </select>
                            </div>
                            <div class="col-sm-2">
                                <label for="">Route</label>
                                <select
                                    name=""
                                    id="routeDropdpown"
                                    class="fstdropdown-select"
                                    onchange="handleRouteSelect(event)">
                                    <option value="">Select Route</option>
                                </select>
                            </div>
                            <div class="col-sm-2">
                                <label for="">Vehicle</label>
                                <select
                                    name=""
                                    id="vehicleDropdpown"
                                    class="fstdropdown-select">
                                    <option value="">Select Vehicle</option>
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
                            <div class="col-sm-2 mt-1">
                                <label for="">Month</label>
                                <select
                                    name=""
                                    id="monthDropdown"
                                    class="fstdropdown-select"
                                    onchange="handleMonthSelect(event)">
                                    <option value="0">Select Month</option>
                                    <option value="1">January</option>
                                    <option value="2">February</option>
                                    <option value="3">March</option>
                                    <option value="4">April</option>
                                    <option value="5">May</option>
                                    <option value="6">June</option>
                                    <option value="7">July</option>
                                    <option value="8">August</option>
                                    <option value="9">September</option>
                                    <option value="10">October</option>
                                    <option value="11">November</option>
                                    <option value="12">December</option>
                                </select>
                            </div>
                            <div class="col-sm-2 mt-1">
                                <label for="">Week</label>
                                <select
                                    name=""
                                    id="weekDropdown"
                                    class="fstdropdown-select"
                                    onchange="handleWeekSelect(event)">
                                    <option value="0">Select Week</option>
                                    <option value="1">1st Week</option>
                                    <option value="2">2nd Week</option>
                                    <option value="3">3rd Week</option>
                                    <option value="4">4th Week</option>
                                </select>
                            </div>
                            <div class="col-sm-2 mt-1">
                                <div class="d-flex align-items-end h-100">
                                    <button class="btn btn-success" type="button" id="btnSearch">
                                        Search
                                    </button>
                                </div>
                            </div>
                        </div>
                    </form>
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
                    </div>
                    <div class="text-danger d-flex align-items-center"></div>
                    <div
                        class="downloads d-flex align-items-center"
                        id="div1"
                        runat="server"
                        visible="true">
                        <button type="button" class="btn btn-light toggler__btn p-1">
                            <i class="fa-solid fa-chevron-down"></i>
                        </button>
                    </div>
                </div>

                <div class="body collapsible active toggler__content">
                    <table class="table table-striped text-center" id="table1">
                        <thead>
                            <tr>
                                <th>Sr. No</th>
                                <th>Total Feeder</th>
                                <th>Cover Feeder</th>
                                <th>Uncover Feeder</th>
                                <th>Unattended Feeder</th>
                                <th>Percentage (%)</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>

            <div class="sweeper-coverage-report">
                <div class="title dropdown-btn">
                    <div class="controls">
                        <div>
                            <h2>Pune Municipal Corporation</h2>
                            <h3 id="dateSpan" class="alert alert-danger p-1"></h3>
                        </div>
                    </div>
                    <div class="text-danger d-flex align-items-center"></div>
                    <div
                        class="downloads d-flex align-items-center"
                        id="div2"
                        runat="server"
                        visible="true">
                        <button type="button" class="btn btn-light toggler__btn p-1">
                            <i class="fa-solid fa-chevron-down"></i>
                        </button>
                    </div>
                </div>

                <div class="body collapsible active toggler__content">
                    <div class="container-fluid mb-2">
                        <div class="row justify-content-between">
                            <div class="col-md-auto">
                                <button
                                    type="button"
                                    class="btn btn-sm btn-secondary position-relative">
                                    Total Feeder
                  <span
                      class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger"
                      id="btnTotalFeeder">0
                  </span>
                                </button>
                            </div>
                            <div class="col-md-auto">
                                <button
                                    type="button"
                                    class="btn btn-sm btn-secondary position-relative">
                                    Cover Feeder
                  <span
                      class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger"
                      id="btnCoverFeeder">0
                  </span>
                                </button>
                            </div>
                            <div class="col-md-auto">
                                <button
                                    type="button"
                                    class="btn btn-sm btn-secondary position-relative">
                                    Uncover Feeder
                  <span
                      class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger"
                      id="btnUncoverFeeder">0
                  </span>
                                </button>
                            </div>
                            <div class="col-md-auto">
                                <button
                                    type="button"
                                    class="btn btn-sm btn-secondary position-relative">
                                    Unattended Feeder
                  <span
                      class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger"
                      id="btnUnattendedFeeder">0
                  </span>
                                </button>
                            </div>
                            <div class="col-md-auto">
                                <button
                                    type="button"
                                    class="btn btn-sm btn-secondary position-relative">
                                    Percentage %
                  <span
                      class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger"
                      id="btnPercentage">0
                  </span>
                                </button>
                            </div>
                        </div>
                    </div>
                    <table class="table table-striped text-center" id="table2">
                        <thead>
                            <tr>
                                <th>Sr. No</th>
                                <th>Date</th>
                                <th>Zone</th>
                                <th>Ward</th>
                                <th>Route</th>
                                <th>Vehicle</th>
                                <th>Total Feeder</th>
                                <th>Cover Feeder</th>
                                <th>Uncover Feeder</th>
                                <th>Unattended Feeder</th>
                                <th>Cover %</th>
                                <th>View Route</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>
        </section>

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
                <div class="toast-body">No GPS Found!</div>
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
        <script></script>
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
        <script src="js/FeederSummaryReport.js"></script>
    </body>
</asp:Content>

