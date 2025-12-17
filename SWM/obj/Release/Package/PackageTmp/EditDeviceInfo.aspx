<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EditDeviceInfo.aspx.cs" Inherits="SWM.EditDeviceInfo" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <head>
        <title>Edit Device Info</title>
        <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
        <script src="js/jquery-3.3.1.min.js"></script>
        <link href="css/fstdropdown.css" rel="stylesheet" />
        <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet" />
    </head>

    <body>
        <div class="container-fluid my-3" id="EditDevice">
            <div class="border mx-2 d-flex justify-content-between align-items-center">
                <h6 class="mb-0">
                    <i class="fa-solid fa-book mx-2"></i>Edit Device
                </h6>
                <button type="button" class="btn btn-light h-100 toggler__btn"></button>
            </div>

            <div class="toggler__content">
                <div class="container-fluid">
                    <div class="row border border-top-0 mx-2 py-2">
                        <div id="UpdateDeviceContainer">
                            <form id="UpdateDevice">
                                <div class="row">
                                    <div class="col-md-3">
                                        <label for="accountID">Account ID</label>
                                        <select id="accountID" class="form-select" disabled></select>
                                    </div>

                                    <div class="col-md-3">
                                        <label for="vehicleName">Vehicle Name</label>
                                        <input type="text" id="vehicleName" class="form-control" >
                                    </div>
                                    <div class="col-lg-2 col-md-3 mt-1">
                                        <label for="vehicleType">Vehicle Type</label>
                                        <select id="vehicleType" class="form-select">
                                            <option value="0">Select</option>
                                            <!-- This will be overwritten if selected -->
                                        </select>
                                    </div>

																	<div class="col-lg-2 col-md-3 mt-1">
																		<label for="VendorName">Vendor Name</label>
																		<select id="VendorName" class="form-select">
																			<option value="0">Select</option>
																			<!-- This will be overwritten if selected -->
																		</select>
																	</div>

																	<div class="col-lg-2 col-md-3 mt-1">
																		<label for="ddlEmployeeType">Employee Type</label>
																		<select id="ddlEmployeeType" class="form-select">
																			<option value="0">Select</option>

																			<!-- This will be overwritten if selected -->
																		</select>
																	</div>

																	<div class="col-lg-2 col-md-3 mt-1">
																		<label for="ddlWorkerType">Worker Type</label>
																		<select id="ddlWorkerType" class="form-select">
																			<option value="0">Select</option>
																			<!-- This will be overwritten if selected -->
																		</select>
																	</div>
																	

                                    <div class="col-md-3">
                                        <label for="deviceCompany">Device Company</label>
																		  	<select id="deviceCompany" class="form-select" >
																				<option value="0">Select</option>
																				<!-- This will be overwritten if selected -->
																			</select>
                                    </div>

                                    <div class="col-md-3">
                                        <label for="deviceType">Device Type</label>
																			  <select id="deviceType" class="form-select">
																				<option value="0">Select</option>
																				<!-- This will be overwritten if selected -->
																		   	</select>
                                    </div>

                                    <div class="col-md-3">
                                        <label for="pcbVersion">PCB Version</label>
                                        <select id="pcbVersion" class="form-select">
                                            <option>Select</option>
                                        </select>
                                    </div>
                                    <div class="col-md-3">
                                        <label for="imeiNumber">IMEI Number</label>
                                        <input type="text" id="imeiNumber" class="form-control" >
                                    </div>
                                    <div class="col-md-3">
                                        <label for="simPhoneNumber">SIM Phone Number</label>
                                        <input type="text" id="simPhoneNumber" class="form-control" >
                                    </div>


                                    <div class="col-md-3">
                                        <label for="simProvider">SIM Provider</label>
                                        <select id="simProvider" class="form-select">
                                            <option>IDEA</option>
                                            <option>VODAFONE</option>
                                            <option>TELENOR</option>
                                            <option>BSNL</option>
                                            <option>AIRTEL</option>
                                            <option>AIRCEL</option>
                                        </select>
                                    </div>
                                    <div class="col-md-3">
                                        <label for="ActiveStatus">Active Status</label>
                                        <select id="ActiveStatus" class="form-select" >
                                            <option>Active</option>
                                            <option>Inactive</option>
                                        </select>
                                    </div>
                                    <div class="col-md-3">
                                        <label for="currentOdometer">Current Odometer</label>
                                        <input type="number" id="currentOdometer" class="form-control">
                                    </div>
                                    <div class="col-md-3">
                                        <label for="expiryDate">Registration Date</label>
                                        <input type="date" id="expiryDate" class="form-control">
                                    </div>
                                    <div class="col-md-3">
                                        <label for="installationDate">Installation Date</label>
                                        <input type="date" id="installationDate" class="form-control">
                                    </div>

                                    <div class="col-md-2">
                                        <label>Fuel Voltage</label><br />
                                        <input type="radio" id="fuel5Volt" name="fuelVoltage" value="5">
                                        <label for="fuel5Volt">5 Volt</label>
                                        <input type="radio" id="fuel9Volt" name="fuelVoltage" value="9">
                                        <label for="fuel9Volt">9 Volt</label>
                                    </div>
                                    <div class="col-md-2">
                                        <label>Voltage Type</label><br />
                                        <input type="radio" id="voltageNormal" name="voltageType" value="0">
                                        <label for="voltageNormal">Normal</label>
                                        <input type="radio" id="voltageReverse" name="voltageType" value="1">
                                        <label for="voltageReverse">Reverse</label>
                                    </div>
                                    <div class="col-md-2">
                                        <label for="fuelTank">Fuel Tank</label>
                                        <input type="number" id="fuelTank" class="form-control">
                                    </div>

                                    <div class="col-md-2">
                                        <label for="fuelFactor">Fuel Factor</label>
                                        <input type="number" id="fuelFactor" class="form-control">
                                    </div>

                                    <div class="col-md-2">
                                        <label for="vehicleMileage">Vehicle Mileage (KM Wise)</label>
                                        <input type="number" id="vehicleMileage" class="form-control">
                                    </div>


                                    <div class="col-md-2">
                                        <label for="LastCheckin">Last Checkin</label>
                                        <input type="text" id="LastCheckin" class="form-control" placeholder="HH:MM:SS">
                                    </div>

                                    <div class="col-md-2">
                                        <label for="InDays">Days</label>
                                        <input type="text" id="InDays" class="form-control" placeholder="HH:MM:SS">
                                    </div>

                                    <div class="col-md-12 mt-3 text-end">
                                        <button type="button" id="btnCancel" class="btn btn-secondary me-2">Cancel</button>
                                        <button type="button" id="btnSave" class="btn btn-primary">Save</button>
                                    </div>

                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>


    </body>
    <script src="js/axios.js"></script>
    <script src="Scripts/fstdropdown.js"></script>
    <script src="js/EditDeviceInfo.js"></script>

</asp:Content>