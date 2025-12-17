<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddVehicleInformation.aspx.cs" Inherits="SWM.AddVehicleInformation" %>

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
        <link rel="stylesheet" href="css/sweeperAttendance.css" />
        <title>Add Vehicle Information</title>
        <style>
            input[type="text"] {
                height: 35px;
                border-radius: 4px;
            }
        </style>
    </head>
    <body>
        <div class="container-fluid my-3" style="display: none" id="editContainer">
            <div
                class="border mx-2 d-flex justify-content-between align-items-center">
                <h6 class="mb-0">
                    <i class="fa-solid fa-book mx-2"></i>Add Vehicle Information
                </h6>
                <button type="button" class="btn btn-light h-100 toggler__btn">
                    <i class="fa-solid fa-chevron-down"></i>
                </button>
            </div>
            <div class="toggler__content">
                <div class="row border border-top-0 mx-2 py-2">
                    <div class="col-lg-3 col-md-4 mt-1">
                        <label for="vehicleNumberDropdown">Vehicle Number</label>
                        <select id="vehicleNumberDropdown" class="fstdropdown-select">
                            <option value="0">Select</option>
                        </select>
                    </div>
                    <div class="col-lg-3 col-md-4 mt-1">
                        <label for="vehicleTypeDropdown">Vehicle Type</label>
                        <select id="vehicleTypeDropdown" class="fstdropdown-select">
                            <option value="0">Select</option>
                        </select>
                    </div>
                    <div class="col-lg-3 col-md-4 mt-1">
                        <label for="vehicleModelDropdown">Vehicle Model Type</label>
                        <select id="vehicleModelDropdown" class="fstdropdown-select">
                            <option value="0">Select</option>
                        </select>
                    </div>
                    <div class="col-lg-3 col-md-4 mt-1">
                        <label for="chassieNumberInput">Chassie Number</label>
                        <input type="text" class="form-control" id="chassieNumberInput" />
                    </div>
                    <div class="col-lg-3 col-md-4 mt-1">
                        <label for="vehicleMilageInput">Vehicle Milage</label>
                        <input type="text" class="form-control" id="vehicleMilageInput" />
                    </div>
                    <div class="col-lg-3 col-md-4 mt-1">
                        <label for="voltageTypeDropdown">Voltage Type</label>
                        <select id="voltageTypeDropdown" class="fstdropdown-select">
                            <option value="0">Select</option>
                        </select>
                    </div>
                    <div class="col-lg-3 col-md-4 mt-1">
                        <label for="vehicleMilage">PUC Number</label>
                        <input type="text" class="form-control" id="pucNumberInput" />
                    </div>
                    <div class="col-lg-3 col-md-4 mt-1">
                        <label for="vehicleMilage">PUC Date</label>
                        <input type="date" class="form-control" id="pucDate" />
                    </div>
                    <div class="col-lg-3 col-md-4 mt-1">
                        <label for="vehicleMilage">PUC Exp Date</label>
                        <input type="date" class="form-control" id="expiryDate" />
                    </div>
                    <div class="col-lg-3 col-md-4 mt-1">
                        <label for="insuranceCompanyInput">Insurance Company</label>
                        <input
                            type="text"
                            class="form-control"
                            id="insuranceCompanyInput" />
                    </div>
                    <div class="col-lg-3 col-md-4 mt-1">
                        <label for="insuranceNameInput">Insurance Name</label>
                        <input type="text" class="form-control" id="insuranceNameInput" />
                    </div>
                    <div class="col-lg-3 col-md-4 mt-1">
                        <label for="insuranceNumberInput">Insurance Number</label>
                        <input type="text" class="form-control" id="insuranceNumberInput" />
                    </div>
                    <div class="col-lg-3 col-md-4 mt-1">
                        <label for="insuranceDate">Insurance Date</label>
                        <input type="date" class="form-control" id="insuranceDate" />
                    </div>
                    <div class="col-lg-3 col-md-4 mt-1">
                        <label for="insuranceExpiryDate">Insurance Expiry Date</label>
                        <input type="date" class="form-control" id="insuranceExpiryDate" />
                    </div>
                    <div class="col-lg-3 col-md-4 mt-1">
                        <label for="servicingDate">Servicing Date</label>
                        <input type="date" class="form-control" id="servicingDate" />
                    </div>
                    <div class="col-lg-3 col-md-4 mt-1">
                        <label for="expectedServicingDate">Expected Servicing Date</label>
                        <input
                            type="date"
                            class="form-control"
                            id="expectedServicingDate" />
                    </div>
                    <div class="col-lg-3 col-md-4 mt-1">
                        <label for="sevicingMonthsInput">Servicing Months</label>
                        <input type="text" class="form-control" id="sevicingMonthsInput" />
                    </div>
                    <div class="col-lg-3 col-md-4 mt-1">
                        <label for="beforeServicingInput">Before Servicing KM</label>
                        <input type="text" class="form-control" id="beforeServicingInput" />
                    </div>
                    <div class="col-lg-3 col-md-4 mt-1">
                        <label for="expectedServicingInput">Expected Servicing KM</label>
                        <input
                            type="text"
                            class="form-control"
                            id="expectedServicingInput" />
                    </div>
                    <div class="col-lg-3 col-md-4 mt-1">
                        <label for="fuelFactorInput">Fuel Factor</label>
                        <input type="text" class="form-control" id="fuelFactorInput" />
                    </div>
                    <div class="col-lg-3 col-md-4 mt-1">
                        <label for="fuelSubfactoryInput">Fuel SubFactor</label>
                        <input type="text" class="form-control" id="fuelSubfactoryInput" />
                    </div>
                    <div class="col-lg-3 col-md-4 mt-1">
                        <label for="fuelTankCapacityInput">Fuel Tank Capacity</label>
                        <input
                            type="text"
                            class="form-control"
                            id="fuelTankCapacityInput" />
                    </div>
                    <div class="col-lg-3 col-md-4 mt-1">
                        <label for="statusDropdown">Status</label>
                        <select id="statusDropdown" class="fstdropdown-select">
                            <option value="0">Select</option>
                        </select>
                    </div>
                    <div class="col-12 mt-4">
                        <div class="d-flex justify-content-center align-items-end h-100">
                            <button
                                class="btn btn-success me-2"
                                type="button"
                                id="btnSearch"
                                onclick="handleSubmit()">
                                Update
                            </button>
                            <button
                                class="btn btn-danger"
                                type="button"
                                onclick="handleCancel()">
                                Cancel
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="container-fluid my-3">
            <div class="row">
                <div class="col-12">
                    <button
                        class="btn btn-primary"
                        onclick="handleShowForm()"
                        id="btnAddVehicleInfo">
                        Add Vehicle Info
                    </button>
                </div>
            </div>
        </div>

        <section class="sweeper-coverage-report-section" id="tableWrapper">
            <div class="sweeper-coverage-report">
                <div class="title dropdown-btn">
                    <div class="controls">
                        <div>
                            <h2>Vehicle Information</h2>
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
                            <th>Sr.No</th>
                            <th>Vehicle Name</th>
                            <th>IMEI</th>
                            <th>Vehicle Type</th>
                            <th>Edit</th>
                        </thead>
                        <tbody>
                            <tr>
                                <td colspan="5" class="text-success">Loading...</td>
                            </tr>
                        </tbody>
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
        <script src="js/AddVehicleInformation.js"></script>
    </body>
</asp:Content>
