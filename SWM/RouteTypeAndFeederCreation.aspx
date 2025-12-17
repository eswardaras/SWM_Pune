<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RouteTypeAndFeederCreation.aspx.cs" Inherits="SWM.RouteTypeAndFeederCreation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
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
        <link rel="stylesheet" href="css/fstdropdown.css" />
        <script src="js/fstdropdown.js"></script>
        <link href="css/global.css" rel="stylesheet" />
        <title>Route and Feeder Creation Details</title>
    </head>
    <body>
        <div class="container-fluid my-3">
            <div
                class="border mx-2 d-flex justify-content-between align-items-center">
                <h6 class="mb-0">
                    <i class="fa-solid fa-book mx-2"></i>Route and Feeder Creation Details
                </h6>
                <button type="button" class="btn btn-light h-100 toggler__btn">
                    <i class="fa-solid fa-chevron-down"></i>
                </button>
            </div>
            <div class="toggler__content">
                <div class="row border border-top-0 mx-2 py-3">
                    <div class="col-lg-2 col-md-3 mt-1">
                        <label for="">Zone</label>
                        <select
                            name=""
                            id="zoneDropdown"
                            class="fstdropdown-select"
                            onchange="handleZoneSelect(event)">
                            <option value="">Select Zone</option>
                        </select>
                    </div>
                    <div class="col-lg-2 col-md-3 mt-1">
                        <label for="">Ward</label>
                        <select name="" id="wardDropdown" class="fstdropdown-select">
                            <option value="">Select Ward</option>
                        </select>
                    </div>
                    <div class="col-lg-2 col-md-3 mt-1">
                        <label for="userDropdown">User Name</label>
                        <select name="" id="userDropdown" class="fstdropdown-select">
                            <option value="">Select User Name</option>
                        </select>
                    </div>
                    <div class="col-lg-2 col-md-3 mt-1 date-wrapper">
                        <label for="">From Date</label>
                        <input type="date" class="form-control" id="startDate" />
                    </div>
                    <div class="col-lg-2 col-md-3 mt-1 date-wrapper">
                        <label for="">To Date</label>
                        <input type="date" class="form-control" id="endDate" />
                    </div>
                    <div class="col-md-2">
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

        <section
            class="sweeper-coverage-report-section"
            style="display: none"
            id="tableWrapper1">
            <div class="sweeper-coverage-report">
                <div class="title dropdown-btn">
                    <div class="controls">
                        <div>
                            <h3 id="dateSpan1" class="alert alert-danger p-1"></h3>
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
                    <table class="table table-striped text-center" id="table1">
                        <thead>
                            <th>Sr.No</th>
                            <th>Date</th>
                            <th>Zone Name</th>
                            <th>Ward Name</th>
                            <th>Route Name</th>
                            <th>RouteKilomtr</th>
                            <th>Employee Name</th>
                            <th>Mobile No.</th>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>
        </section>

        <section
            class="sweeper-coverage-report-section"
            style="display: none"
            id="tableWrapper2">
            <div class="sweeper-coverage-report">
                <div class="title dropdown-btn">
                    <div class="controls">
                        <div>
                            <h3 id="dateSpan2" class="alert alert-danger p-1"></h3>
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
                    <table class="table table-striped text-center" id="table2">
                        <thead>
                            <th>Sr.No</th>
                            <th>Date</th>
                            <th>Zone Name</th>
                            <th>Ward Name</th>
                            <th>Route Name</th>
                            <th>RouteKilomtr</th>
                            <th>Employee Name</th>
                            <th>Mobile No.</th>
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
                    $(button).parent().parent().next().slideToggle("fast");
                }

                $(".toggler__btn").click(function () {
                    collapseContent(this);
                });
            });
        </script>
        <script>
            const dateInput = document.querySelectorAll("input[type='date']");
            const sDate = document.getElementById("startDate");
            const eDate = document.getElementById("endDate");
            const cDate = new Date();
            const currentDate = new Date().toISOString().substr(0, 10);

            dateInput.forEach((input) => {
                if (!input.value) {
                    input.value = currentDate;
                }
            });
        </script>
        <script src="js/RouteTypeAndFeederCreation.js"></script>
    </body>
</asp:Content>
