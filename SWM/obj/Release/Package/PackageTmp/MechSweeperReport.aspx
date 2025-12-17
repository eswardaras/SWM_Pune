<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MechSweeperReport.aspx.cs" Inherits="SWM.MechSweeperReport" %>

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
            src="http://code.jquery.com/jquery-3.3.1.min.js"
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
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <link rel="stylesheet" href="css/sweeperAttendance.css" />
        <title>Mechanical Sweeper Route Coverage</title>
    </head>
    <body>
        <div class="filters-section">
            <div class="filters-container">
                <div class="title d-flex justify-content-between">
                    <div class="d-flex align-items-center">
                        <i class="fa-solid fa-book"></i>
                        <h3>Mechanical Sweeper Route Coverage</h3>
                    </div>
                </div>
                <div class="body">
                    <form action="">
                        <div class="row px-3 pb-3">
                            <div class="col-md-2">
                                <label for="">Zone</label>
                                <select
                                    id="zoneDropdown"
                                    class="fstdropdown-select"
                                    onchange="handleZoneSelect()">
                                    <option value="">Select Zone</option>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <label for="">Ward</label>
                                <select
                                    id="wardDropdown"
                                    class="fstdropdown-select"
                                    onchange="handleWardSelect()">
                                    <option value="">Select Ward</option>
                                </select>
                            </div>
                            <div class="col-md-auto">
                                <label for="">Mechanical Sweeper</label>
                                <select id="mechSweeperDropdown" class="fstdropdown-select">
                                    <option value="">Select Mechanical Sweeper</option>
                                </select>
                            </div>
                            <div class="col-md-2 date-wrapper">
                                <label for="">From Date</label>
                                <input type="date" class="form-control" id="startDate" />
                            </div>
                            <div class="col-md-2 date-wrapper">
                                <label for="">To Date</label>
                                <input type="date" class="form-control" id="endDate" />
                            </div>
                            <div class="col-md-auto">
                                <div class="d-flex align-items-end h-100">
                                    <button class="btn btn-success" type="submit" id="btnSearch">
                                        Search
                                    </button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="container mt-2" id="chartWrapper" style="display: none">
            <div class="row border rounded">
                <div class="col-sm-6">
                    <div class="row">
                        <div class="col-12 bg-light border">
                            <h2 class="text-center text-secondary">City Wise</h2>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12 border">
                            <div
                                style="height: 400px"
                                class="d-flex justify-content-center align-items-center position-relative">
                                <canvas id="cityWise"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="row">
                        <div class="col-12 bg-light border">
                            <h2 class="text-center text-secondary">Zone Wise</h2>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12 border">
                            <div
                                style="height: 400px"
                                class="d-flex justify-content-center align-items-center position-relative">
                                <canvas id="zoneWise"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row border rounded mt-3">
                <div class="col-sm-6">
                    <div class="row">
                        <div class="col-12 bg-light border">
                            <h2 class="text-center text-secondary">City Wise Route Covered(KM)
                            </h2>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12 border">
                            <div
                                style="height: 400px"
                                class="d-flex justify-content-center align-items-center position-relative">
                                <canvas id="cityWiseRoute"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="row">
                        <div class="col-12 bg-light border">
                            <h2 class="text-center text-secondary">Zone Wise Route Covered(KM)
                            </h2>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12 border">
                            <div
                                style="height: 400px"
                                class="d-flex justify-content-center align-items-center position-relative">
                                <canvas id="zoneWiseRoute"></canvas>
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
                            <h2>Mech. Sweeper Route Coverage Report</h2>
                            <h3 id="dateSpan" class="alert alert-danger p-1"></h3>
                        </div>
                    </div>
                    <div class="text-danger d-flex align-items-center"></div>
                    <div class="downloads d-flex align-items-center">
                        <button type="button" class="btn btn-light toggler__btn p-1">
                            <i class="fa-solid fa-chevron-down"></i>
                        </button>
                    </div>
                </div>

                <div class="body collapsible active toggler__content">
                    <table class="table table-striped text-center" id="table">
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Zone</th>
                                <th>Ward</th>
                                <th>Route</th>
                                <th>Mechanical Sweeper</th>
                                <th>Work (%)</th>
                                <th>Actual Route Mtr</th>
                                <th>Covered Route Mtr</th>
                                <th>Exp. Coverage</th>
                                <th>Checking Time</th>
                                <th>Average Speed</th>
                                <th>Overspeed</th>
                                <th>View Route</th>
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
            const currentDate = new Date();
            const previousDate = new Date(currentDate);
            previousDate.setDate(currentDate.getDate() - 1);
            const formattedPreviousDate = previousDate.toISOString().substr(0, 10);

            dateInput.forEach((input) => {
                if (!input.value) {
                    input.value = formattedPreviousDate;
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
        <script src="js/mechSweeperReport.js"></script>
    </body>
</asp:Content>
