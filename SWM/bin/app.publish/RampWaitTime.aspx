<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RampWaitTime.aspx.cs" Inherits="SWM.RampWaitTime" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <head>
        <script src="js/jquery-3.3.1.min.js"></script>
        <link href="css/fstdropdown.css" rel="stylesheet" />
        <!-- Select 2 -->
        <link
            href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css"
            rel="stylesheet" />
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
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <!-- Sweet Aleart End -->
        <title>Show Ramp Wait Time </title>
    </head>

    <body>


        <section class="filters-section">
            <div class="filters-container">
                <div class="title d-flex justify-content-between">
                    <div class="d-flex align-items-center">
                        <i class="fa-solid fa-book"></i>
                        <h3>Ramp Wait Time</h3>
                    </div>
                    <%--<asp:Button ID="btnSearch" runat="server" Text="Show" CssClass="btn btn-success" />--%>
                    <button class="btn btn-success" id="btnSearch" onclick="populateDataGrid()" type="button">Search</button>
                </div>
                <div class="body">
                    <div class="row px-4 pb-4">
                        <div class="col-sm-4">
                            <label>Ramp Name</label>
                            <select class="fstdropdown-select" id="ddlRamp"></select>
                        </div>
                        <div class="col-sm-4 date-wrapper">
                            <label>Date</label>
                            <input type="date" id="Date" class="form-control"/>
                        </div>

                    </div>
                </div>
            </div>
        </section>



        <div class="container-fluid my-3" id="editPanel">
            <div
                class="border mx-2 d-flex justify-content-between align-items-center">
                <h6 class="mb-0">
                    <i class="fa-solid fa-book mx-2"></i>Ramp Wait Time
                </h6>
                <button type="button" class="btn btn-light h-100 toggler__btn">
                    <i class="fa-solid fa-chevron-down"></i>
                </button>
            </div>
            <div class="toggler__content">
                <div class="container-fluid">
                    <div class="row"></div>
                </div>

                <section class="sweeper-coverage-report-section" id="tableWrapper">
                    <div class="sweeper-coverage-report">
                        <div class="body collapsible active toggler__content">
                            <table class="table table-striped text-center" id="table">
                                <thead>
                                    <tr>
                                        <th>Sr.No</th>
                                       
                                        <th>Vehicle Depo No</th>
                                        <th>Vehicle Name</th>
                                        <th>Vehicle Type</th>
                                        <th>Net Weight</th>
                                        <th>Gross Weight</th>
                                        <th>Tare Weight</th>
                                        <th>Gate Entry Time</th>
                                        <th>Ramp Entry Date</th>
                                        <th>Gate Exit Time</th>
                                        <th>Wait Time</th>

                                    </tr>
                                </thead>
                                <tbody></tbody>
                            </table>
                        </div>
                    </div>
                </section>
            </div>
        </div>

        <script src="js/axios.js"></script>
        <script src="Scripts/fstdropdown.js"></script>
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
        <script>
            const dateInput = document.querySelectorAll('.date-wrapper input');
            const currentDate = new Date().toISOString().substr(0, 10);

            dateInput.forEach(input => {
                if (!input.value) {
                    input.value = currentDate;
                }
            });
        </script>
        <script src="js/RampWaitTime.js"></script>
    </body>
</asp:Content>