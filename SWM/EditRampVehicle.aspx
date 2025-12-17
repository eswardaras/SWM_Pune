<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EditRampVehicle.aspx.cs" Inherits="SWM.EditRampVehicle" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <head>
        <script src="js/jquery-3.3.1.min.js"></script>

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
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
        <script src="Scripts/fstdropdown.js"></script>
        <link href="css/fstdropdown.css" rel="stylesheet" />
        <!-- Sweet Alert End -->
        <title>Edit Ramp Vehicles</title>
    </head>

    <style>
        .edit-btn {
            background: none; /* Remove background */
            border: none; /* Remove border */
            padding: 0; /* Remove padding */
            cursor: pointer; /* Change cursor to pointer */
            color: #007bff; /* Set color for the pencil icon */
            font-size: 16px; /* Set the font size */
        }

            .edit-btn:hover {
                color: #0056b3; /* Change color when hovered */
            }
    </style>
    <body>
        <input type="hidden" id="hiddenVCMID">
        <section class="filters-section">
            <div class="filters-container">
                <div class="title d-flex justify-content-between">
                </div>
                <div class="body">
                    <div class="row px-2 pb-2">
                        <div class="col-sm-4">
                            <button class="btn btn-primary" id="btnAdd" type="button" onclick="toggleEmployeeForm()">
                                Add Ramp Vehicle
                            </button>
                        </div>

                    </div>
                </div>
            </div>
        </section>


        <div class="container-fluid my-3" id="addVehicleFormContainer" style="display: none;">
            <div class="border mx-2 d-flex justify-content-between align-items-center">
                <h6 class="mb-0">
                    <i class="fa-solid fa-car mx-2"></i>Add Ramp Vehicle
                </h6>
                <button type="button" class="btn btn-light h-100 toggler__btn">
                    <i class="fa-solid fa-chevron-down"></i>
                </button>
            </div>
            <div class="toggler__content">
                <div class="container-fluid">
                    <div class="row"></div>
                </div>
                <div class="row border border-top-0 mx-2 py-2">
                    <form id="addVehicleForm">
                        <div class="row">
                            <!-- Vehicle Type -->
                            <div class="col-lg-3 col-md-4 mt-1 content1">
                                <label for="ddlVTM">Select Vehicle Type</label>
                                <select class="form-select" id="ddlVTM">
                                    <!-- Populate options dynamically -->
                                </select>
                            </div>

                            <!-- Depot Number -->
                            <div class="col-lg-3 col-md-4 mt-1 content1">
                                <label for="txtDepotNo" class="form-label">Depo Number</label>
                                <input type="text" class="form-control" id="txtDepotNo" />
                            </div>

                            <!-- Tare Weight -->
                            <div class="col-lg-3 col-md-4 mt-1 content1">
                                <label for="txtTareWeight" class="form-label">Tare Weight</label>
                                <input type="number" class="form-control" id="txtTareWeight" />
                            </div>

                            <!-- RTO Number -->
                            <div class="col-lg-3 col-md-4 mt-1 content1">
                                <label for="txtRTO" class="form-label">RTO Number</label>
                                <input type="text" class="form-control" id="txtRTO" />
                            </div>

                            <!-- Compartment -->
                            <div class="col-lg-3 col-md-4 mt-1 content1">
                                <label for="txtCompartment" class="form-label">Compartment</label>
                                <input type="text" class="form-control" id="txtCompartment" />
                            </div>



                            <!-- Register/Cancel Buttons -->
                            <div class="col-12 d-flex justify-content-center mt-3">
                                <button id="btnAddVehicle" type="button" class="btn btn-success mx-2" onclick="AddRampVehicle()">Add Ramp Vehicle</button>
                                <button id="btnCancel" type="button" class="btn btn-secondary mx-2" onclick="CancelRampVehicle()">Cancel</button>
                            </div>

                        </div>
                    </form>
                </div>
            </div>
        </div>



        <div class="container-fluid my-3" id="EditVehicleFormContainer" style="display: none;">
            <div
                class="border mx-2 d-flex justify-content-between align-items-center">
                <h6 class="mb-0">
                   <i class="fa-solid fa-car mx-2"></i>Edit Ramp Vehicle
                </h6>
                <button type="button" class="btn btn-light h-100 toggler__btn">
                    <i class="fa-solid fa-chevron-down"></i>
                </button>
            </div>
            <div class="toggler__content">
                <div class="container-fluid">
                    <div class="row"></div>
                </div>
                <div class="row border border-top-0 mx-2 py-2">

                    <form id="UpdateRampVehicle">
                        <div class="row  ">
                            <!-- Vehicle Type -->
                            <div class="col-lg-3 col-md-4 mt-1 content1">
                                <label for="EditddlVTM">Select Vehicle Type</label>
                                <select class="form-select" id="EditddlVTM">
                                    <!-- Populate options dynamically -->
                                </select>
                            </div>
                            <!-- Depot Number -->
                            <div class="col-lg-3 col-md-4 mt-1 content1">
                                <label for="EditDepotNo" class="form-label">Depo Number</label>
                                <input type="text" class="form-control" id="EditDepotNo" />
                            </div>

                            <!-- Tare Weight -->
                            <div class="col-lg-3 col-md-4 mt-1 content1">
                                <label for="EditTareWeight" class="form-label">Tare Weight</label>
                                <input type="number" class="form-control" id="EditTareWeight" />
                            </div>

                            <!-- RTO Number -->
                            <div class="col-lg-3 col-md-4 mt-1 content1">
                                <label for="EditRTO" class="form-label">RTO Number</label>
                                <input type="text" class="form-control" id="EditRTO" />
                            </div>

                            <!-- Compartment -->
                            <div class="col-lg-3 col-md-4 mt-1 content1">
                                <label for="EditCompartment" class="form-label">Compartment</label>
                                <input type="text" class="form-control" id="EditCompartment" />
                            </div>




                            <!-- Save and Cancel Buttons -->
                            <div class="col-12 text-center mt-3">
                                <button type="button" class="btn btn-success" onclick="UpdateVehicle()">Save Changes</button>
                                 <button id="EditbtnCancel" type="button" class="btn btn-secondary mx-2" onclick="EditCancelRampVehicle()">Cancel</button>
                            </div>

                        </div>
                    </form>


                </div>

            </div>

        </div>

        <div class="container-fluid my-3" id="gvRampVehicles">
            <div
                class="border mx-2 d-flex justify-content-between align-items-center">
                <h6 class="mb-0">
                  <i class="fa-solid fa-car mx-2"></i>Ramp Vehicles Details
                </h6>
                <button type="button" class="btn btn-light h-100 toggler__btn">
                    <i class="fa-solid fa-chevron-down"></i>
                </button>
            </div>
            <div class="toggler__content">
                <div class="container-fluid">
                    <div class="row">
                    </div>

                    <section class="sweeper-coverage-report-section" id="tableWrapper">
                        <div class="sweeper-coverage-report">
                            <div class="body collapsible active toggler__content">
                                <table class="table table-striped text-center" id="table">
                                    <thead align="center">
                                        <th>Sr.No</th>
                                     
                                        <th>Vehicle Type</th>
                                        <th>DEPO NO</th>

                                        <th>TARE WEIGHT</th>


                                        <th>RTO NO</th>
                                        <th>COMPARTMENT</th>

                                        <th>Edit</th>

                                    </thead>
                                    <tbody></tbody>
                                </table>
                            </div>
                        </div>
                    </section>

                </div>

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
        <script src="js/EditRampVehicle.js"></script>
    </body>


</asp:Content>
