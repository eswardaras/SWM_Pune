<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MyVehicles.aspx.cs" Inherits="SWM.MyVehicles" %>

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
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/spinkit/1.2.5/spinkit.min.css" />

        <!-- Sweet Alert End -->
        <title>My Vehicles</title>
    </head>

    <style>
        #paginationWrapper {
            display: flex;
            justify-content: flex-end; /* Align buttons to the left */
            align-items: center;
            gap: 5px;
            margin-top: 20px;
            margin-right: 10px; /* Add some left margin if needed */
        }

            #paginationWrapper button {
                background-color: #f8f9fa;
                border: 1px solid #ddd;
                padding: 5px 10px;
                cursor: pointer;
                border-radius: 3px;
                font-size: 14px;
                color: #007bff;
            }

                #paginationWrapper button.active {
                    background-color: #2c6b97;
                    color: #fff;
                    font-weight: bold;
                }

                #paginationWrapper button[disabled] {
                    background-color: #f2f2f2;
                    cursor: not-allowed;
                }

                #paginationWrapper button:disabled {
                    color: #ccc;
                    cursor: not-allowed;
                }

                #paginationWrapper button:hover:not(:disabled):not(.active) {
                    background-color: #e9ecef;
                }

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
      <input type="hidden" id="accIdHidden" value="11401" />
        <div class="container-fluid my-3" id="EditDevice" style="display: none;">
            <div
                class="border mx-2 d-flex justify-content-between align-items-center">
                <h6 class="mb-0">
                    <i class="fa-solid fa-book mx-2"></i>Edit Device
                </h6>
                <button type="button" class="btn btn-light h-100 toggler__btn">
                </button>
            </div>
            <div class="toggler__content">
                <div class="container-fluid">
                    <div class="row"></div>
                </div>
                <div class="row border border-top-0 mx-2 py-2">
              <div id="UpdateDeviceContainer" style="display: none;">
                    <form id="UpdateDevice">
                        <div class="row  ">

                            <div class="ccol-lg-3 col-md-4 mt-1 content1">
                                <label for="accountID">Account ID</label>
                                <select id="accountID" class="form-select" disabled>
                                    <option>PUNEISWM</option>
                                </select>
                            </div>

                            <div class="col-md-4">
                                <label for="vehicleName">Vehicle/Sweeper Name</label>
                                <input type="text" id="vehicleName" class="form-control" value="">
                            </div>

                            <div class="col-md-4">
                                <label for="vehicleType">Vehicle Type</label>
                                <input type="text" id="vehicleType" class="form-control" value="">
                            </div>

                            <div class="col-md-4">
                                <label for="deviceCompany">Device Company</label>
                                <input type="text" id="deviceCompany" class="form-control" value="">
                            </div>

                            <div class="col-md-4">
                                <label for="deviceType">Device Type</label>
                                <input type="text" id="deviceType" class="form-control" value="">
                            </div>

                            <div class="col-md-4">
                                <label for="pcbVersion">PCB Version</label>
                                <select id="pcbVersion" class="form-select">
                                    <option>Select</option>
                                    <!-- Add PCB options dynamically -->
                                </select>
                            </div>

                            <div class="col-md-4">
                                <label for="simPhoneNumber">SIM Phone Number</label>
                                <input type="text" id="simPhoneNumber" class="form-control" value="">
                            </div>

                            <div class="col-md-4">
                                <label for="imeiNumber">IMEI Number</label>
                                <input type="text" id="imeiNumber" class="form-control" value="">
                            </div>

                            <div class="col-md-4">
                                <label for="simProvider">SIM Service Provider</label>
                                <input type="text" id="simProvider" class="form-control" value="">
                            </div>

                            <div class="col-md-4">
                                <label for="ActiveStatus">Active</label>
                                <select id="ActiveStatus" class="form-select" disabled>
                                    <option>Active</option>
                                    <option>Inactive</option>
                                </select>
                            </div>


                            <div class="col-md-4">
                                <label for="voltageType">Voltage Type</label><br>
                                <input type="radio" id="voltageNormal" name="voltageType" value="" checked>
                                <label for="voltageNormal">Normal</label>
                                <input type="radio" id="voltageReverse" name="voltageType" value="">
                                <label for="voltageReverse">Reverse</label>
                            </div>

                            <div class="col-md-4">
                                <label for="fuelVoltage">Fuel Voltage</label><br>
                                <input type="radio" id="fuel5Volt" name="fuelVoltage" value="" checked>
                                <label for="fuel5Volt"></label>
                                <input type="radio" id="fuel9Volt" name="fuelVoltage" value="">
                                <label for="fuel9Volt"></label>
                            </div>

                            <div class="col-md-4">
                                <label for="currentOdometer">Current Odometer</label>
                                <input type="number" id="currentOdometer" class="form-control" value="">
                            </div>

                            <div class="col-md-4">
                                <label for="fuelTank">Fuel Tank</label>
                                <input type="number" id="fuelTank" class="form-control" value="">
                            </div>

                            <div class="col-md-4">
                                <label for="fuelFactor">Fuel Factor</label>
                                <input type="number" id="fuelFactor" class="form-control" value="">
                            </div>

                            <div class="col-md-4">
                                <label for="vehicleMileage">Vehicle Mileage</label>
                                <input type="number" id="vehicleMileage" class="form-control" value="">
                            </div>
                            <div class="col-md-4">
                                <label for="installationDate">Set Device Installation Date</label>
                                <input type="date" id="installationDate" class="form-control" value="">
                            </div>
                            <div class="col-md-4">
                                <label for="expiryDate">Set Device Expiry Date</label>
                                <input type="date" id="expiryDate" class="form-control" value="">
                            </div>

                            <div class="col-md-4">
                                <label for="LastCheckin">Last Checkin</label>
                              <input type="text" id="LastCheckin" class="form-control" placeholder="HH:MM:SS">

                            </div>

                            <div class="col-md-12 mt-2">
                                <span class="text-muted small">Device Expiry date will deactivate the device on this date.
                    </span>
                            </div>

                            <!-- Save and Cancel Buttons -->
                            <div class="col-12 text-center mt-3">
                                <button type="button" class="btn btn-success" onclick="SaveDevice()">Save Changes</button>
                                <button type="button" class="btn btn-danger" onclick="cancelDevice()">Cancel</button>
                            </div>

                        </div>
                    </form>

    </div>
                </div>

            </div>

        </div>

        <div class="container-fluid my-3" id="gvVehicles">
            <div
                class="border mx-2 d-flex justify-content-between align-items-center">
                <h6 class="mb-0">
                    <i class="fa-solid fa-book mx-2"></i>My Vehicles
                </h6>
                <button type="button" class="btn btn-light h-100 toggler__btn">
                    <i class="fa-solid fa-chevron-down"></i>
                </button>
            </div>
            <div class="toggler__content">
                <div class="container-fluid">
                    <div class="row"></div>
                </div>
                <div class="row mb-3">


                    <div class="col-12">
                        <button
                            type="button"
                            class="btn btn-success ms-3 mt-2"
                            id="showVehicleListBtn"
                            onclick="populateDataGrid()">
                            <i class="fa-solid"></i>Display Account Vehicles
                        </button>
                    </div>

                  <!-- Spinner container -->
<div id="loadingSpinner" class="spinner_container">
  <div class="sk-chase">
    <div class="sk-chase-dot"></div>
    <div class="sk-chase-dot"></div>
    <div class="sk-chase-dot"></div>
    <div class="sk-chase-dot"></div>
    <div class="sk-chase-dot"></div>
    <div class="sk-chase-dot"></div>
  </div>
  <div style="margin-top: 10px;">Loading data, please wait...</div>
</div>



                    <div class="col-12 mb-2">
                        <!-- Radio Buttons -->
                        <label class="me-2">
                            <input type="radio" name="searchType" value="IMEI" checked onchange="updatePlaceholder()">
                            IMEI
                        </label>
                        <label class="me-2">
                            <input type="radio" name="searchType" value="VehicleName" onchange="updatePlaceholder()">
                            Vehicle Name
                        </label>
                        <label>
                            <input type="radio" name="searchType" value="SimNumber" onchange="updatePlaceholder()">
                            Sim Number
                        </label>

                        <!-- Search Input -->
                        <input
                            type="text"
                            class="form-control d-inline-block ms-2"
                            placeholder="Enter last digits of IMEI"
                            style="width: 250px;"
                            id="searchInput" />

                        <!-- View Button -->
                        <button
                            type="button"
                            class="btn btn-primary ms-2"
                            id="filterBtn">
                            View
                        </button>

                        <!-- Excel Icon -->
                        <i class="fa fa-file-excel-o ms-2" style="font-size: 32px; color: green;"></i>
                    </div>


                </div>

                <section class="sweeper-coverage-report-section" id="tableWrapper">


                    <div class="sweeper-coverage-report">
                        <div class="body collapsible active toggler__content">

                            <table class="table table-striped text-center" id="table">
                                <thead>
                                    <tr>
                                        <th>Sr.No</th>
                                        <th>Type
                                        </th>
                                        <th>Vehicle ID
                                        </th>
                                        <th>Account
                                        </th>
                                        <th>IMEI / Sim / Operator
                                        </th>
                                        <th>Device Type
                                        </th>

                                        <th>Active
                                        </th>

                                        <th>Installation Date
                                        </th>

                                        <th>Expiry Date
                                        </th>
                                       <%-- <th>Remark
                                        </th>--%>
                                        <th>Last Checkin
                                        </th>
                                        <th>Day
                                        </th>
                                        <th>Edit
                                        </th>
                                    </tr>
                                </thead>
                                <tbody></tbody>
                            </table>

                            <!-- Pagination Wrapper -->
                            <div id="paginationWrapper" class="pagination"></div>
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
        <script src="js/MyVehicles.js" defer></script>
    </body>


</asp:Content>
