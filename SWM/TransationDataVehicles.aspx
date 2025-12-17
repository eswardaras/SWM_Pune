<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TransationDataVehicles.aspx.cs" Inherits="SWM.TransationDataVehicles" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="css/fstdropdown.css" />
        <script src="Scripts/fstdropdown.js"></script>
        <script src="https://kit.fontawesome.com/e8c1c6e963.js"
            crossorigin="anonymous"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
            crossorigin="anonymous" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
            crossorigin="anonymous"></script>
        <script src="js/jquery-3.3.1.min.js"></script>
        <!-- DataTable Links -->
        <link rel="stylesheet"
            href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css" />
        <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/buttons/2.0.1/js/dataTables.buttons.min.js"></script>
        <script src="https://cdn.datatables.net/buttons/2.0.1/js/buttons.html5.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.6.0/jszip.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
        <!-- DataTable Links End -->
        <!-- Sweet Aleart -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <!-- Sweet Aleart End -->
        <link rel="stylesheet" href="css/global.css" />
        <title>Transactional Data of Vehicles</title>
    </head>
    <body>
        <div class="filters-section">
            <div class="filters-container">
                <div class="title d-flex justify-content-between">
                    <div class="d-flex align-items-center">
                        <i class="fa-solid fa-book"></i>
                        <h3>Transactional Data of Vehicles</h3>
                    </div>
                    <button type="button" class="btn btn-light toggler__btn p-1">
                        <i class="fa-solid fa-chevron-down"></i>
                    </button>
                </div>
                <div class="body toggler__content">
                    <form action="">
                        <div class="row px-3 pb-3">
                            <div class="col-sm-4">
                                <label for="">Preventive maintenance</label>
                                <textarea id="preventiveInput"
                                    rows="3"
                                    class="form-control"
                                    maxlength="500"
                                    ></textarea>
                            </div>
                            <div class="col-sm-4">
                                <label for="">Breakdown maintenance</label>
                                <textarea id="breakdownMaintananceInput"
                                    rows="3"
                                    class="form-control"
                                    maxlength="500"></textarea>
                            </div>
                            <div class="col-sm-4">
                                <label for="">RTO passing alerts</label>
                                <textarea id="rtoPassInput"
                                    rows="3"
                                    class="form-control"
                                    maxlength="500"></textarea>
                            </div>
                        </div>
                        <div class="row px-3 pb-3">
                            <h3><u>Vehicle History Such As:-</u></h3>
                            <div class="col-sm-3">
                                <label for="">Purchase year</label>
                                <textarea id="purchageYearInput"
                                    rows="3"
                                    class="form-control"
                                    maxlength="500"></textarea>
                            </div>
                            <div class="col-sm-3">
                                <label for="">Cost</label>
                                <textarea id="constInput"
                                    rows="3"
                                    class="form-control"
                                    maxlength="500"></textarea>
                            </div>
                            <div class="col-sm-3">
                                <label for="">Depreciation</label>
                                <textarea id="depreciationInput"
                                    rows="3"
                                    class="form-control"
                                    maxlength="500"></textarea>
                            </div>
                            <div class="col-sm-3">
                                <label for="">Insurance </label>
                                <textarea id="insuranceInput"
                                    rows="3"
                                    class="form-control"
                                    maxlength="500"></textarea>
                            </div>
                        </div>
                        <div class="row px-3 pb-3">
                            <div class="col-sm-3">
                                <label for="">Vehicle Number </label>
                                <textarea id="vehicleNumberInput"
                                    rows="3"
                                    class="form-control"
                                    maxlength="500"></textarea>
                            </div>
                            <div class="col-sm-3">
                                <label for="">Alert Type</label>
                                <select id="alertDropdown"
                                    class="fstdropdown-select">
                                    <option value="Painting">Painting</option>
                                    <option value="Washing">Washing</option>
                                    <option value="Cleaning Schedules">Cleaning Schedules</option>
                                </select>
                            </div>
                            <div class="col-sm-5">
                                <label for="">Other vehicle data related management</label>
                                <textarea id="otherVehicleInput"
                                    rows="3"
                                    class="form-control"
                                    maxlength="500"></textarea>
                            </div>
                            <div class="col-sm-auto">
                                <label for="">
                                    Fuel data consumption monitoring and analytics for the
                                same
                                </label>
                                <textarea id="fuelDataInput"
                                    rows="3"
                                    class="form-control"
                                    maxlength="500"></textarea>
                            </div>
                            <div class="col-sm-auto">
                                <label for="">Daily utilization Data management for Backhole loaders</label>
                                <textarea id="dailyInput"
                                    rows="3"
                                    class="form-control"
                                    maxlength="500"></textarea>
                            </div>
                        </div>
                        <div class="row px-3 pb-3 justify-content-center mt-3">
                            <div class="col-sm-auto">
                                <div class="d-flex align-items-end h-100">
                                    <button class="btn btn-sm btn-primary"
                                        onclick="getData()"
                                        type="button"
                                        id="btnView">
                                        View Report
                                    </button>
                                </div>
                            </div>
                            <div class="col-sm-auto">
                                <div class="d-flex align-items-end h-100">
                                    <button class="btn btn-sm btn-success"
                                        id="btnSubmit"
                                        type="button"
                                        onclick="handleSubmit()">
                                        Submit
                                    </button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <section class="sweeper-coverage-report-section"
            style="display: none"
            id="tableWrapper">
            <div class="sweeper-coverage-report">
                <div class="title dropdown-btn">
                    <div class="controls">
                        <div>
                            <h2>Pune Municipal Corporation</h2>
                            <!-- <h3 id="dateSpan" class="alert alert-danger p-1"></h3> -->
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
                                <th>Sr.No</th>
                                <th>Preventive Maintenance</th>
                                <th>Breakdown Maintenance</th>
                                <th>RTO Passing Alerts</th>
                                <th>Purchase Year</th>
                                <th>Cost</th>
                                <th>Depreciation</th>
                                <th>Insurance</th>
                                <th>Vehicle Number</th>
                                <th>AlertType</th>
                                <th>OtherVehicle</th>
                                <th>Fuel Data Consumption</th>
                                <th>Daily Utilization Data BackhoeLoaders</th>
                                <th>Edit</th>
                                <th>Delete</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>
        </section>

        <!-- Message Modal -->
        <div class="modal" tabindex="-1" id="message_modal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Message</h5>
                        <button type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close">
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="alert alert-success" role="alert">
                            Created a new entry Successfully!
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Message Modal End -->

        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
            integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
            crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"
            integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+"
            crossorigin="anonymous"></script>
        <script></script>
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
        <script src="js/TransationDataVehicles.js"></script>
    </body>
</asp:Content>
