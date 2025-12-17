<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AssignZoneWardToEmployee.aspx.cs" Inherits="SWM.AssignZoneWardToEmployee" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <head>
        <script src="js/jquery-3.3.1.min.js"></script>
        <!-- Select 2 -->
        <link
            href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css"
            rel="stylesheet" />
        <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
        <!-- Select 2 end -->
        <!-- Sweet Aleart -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <!-- Sweet Aleart End -->
        <title>Assign Zone Ward Vehicle To Employee</title>
    </head>
    <body>
        <div class="container-fluid my-3" id="editPanel">
            <div
                class="border mx-2 d-flex justify-content-between align-items-center">
                <h6 class="mb-0">
                    <i class="fa-solid fa-book mx-2"></i>Assign Zone Ward Vehicle To
          Employee
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
                    <div class="col-12">
                        <div class="form-check form-check-inline">
                            <input
                                class="form-check-input"
                                type="radio"
                                name="radioButton"
                                id="zoneWardKothiRadio"
                                value="option1"
                                checked />
                            <label class="form-check-label" for="zoneWardKothiRadio">
                                Zone-Ward-Kothi</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input
                                class="form-check-input"
                                type="radio"
                                name="radioButton"
                                id="vehicleRadio"
                                value="option2" />
                            <label class="form-check-label" for="vehicleRadio">Vehicle</label>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-4 mt-1">
                        <label for="">Select Employee</label>
                        <select
                            class="form-select"
                            id="employeeDropdown"
                            onchange="handleEmpSelect(event)">
                            <option value="0">Select</option>
                        </select>
                    </div>
                    <div class="col-lg-3 col-md-4 mt-1 content1">
                        <label for="zoneDropdown">Select Zone</label>
                        <select class="form-select" id="zoneDropdown" multiple></select>
                    </div>
                    <div class="col-lg-3 col-md-4 mt-1 content1">
                        <label for="wardDropdown">Select Ward</label>
                        <select class="form-select" id="wardDropdown" multiple></select>
                    </div>
                    <div class="col-lg-3 col-md-4 mt-1 content1">
                        <label for="">Select Kothi</label>
                        <select class="form-select" id="kothiDropdown" multiple>
                            <option value="0">Select</option>
                        </select>
                    </div>
                    <div class="col-lg-3 col-md-4 mt-1 content1">
                        <label for="">Select Prabhag</label>
                        <select class="form-select" id="prabhagDropdown" multiple>
                            <option value="0">Select</option>
                        </select>
                    </div>
                    <div class="col-auto mt-1 content2" style="display: none">
                        <label for="">Select Status</label>
                        <div>
                            <div class="form-check form-check-inline">
                                <input
                                    class="form-check-input"
                                    type="radio"
                                    name="radioButton1"
                                    id="personalRadio"
                                    checked />
                                <label class="form-check-label" for="personalRadio">
                                    Personal</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input
                                    class="form-check-input"
                                    type="radio"
                                    name="radioButton1"
                                    id="generalRadio" />
                                <label class="form-check-label" for="generalRadio">
                                    General</label>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-4 mt-1 content2" style="display: none">
                        <label for="">Select Vehicle</label>
                        <select class="form-select" id="vehicleDropdown" multiple>
                            <option value="0">Select Vehicle</option>
                        </select>
                    </div>
                    <div class="col-lg-2 col-md-2 mt-1">
                        <div class="d-flex align-items-end h-100">
                            <button
                                class="btn btn-success me-2"
                                type="button"
                                id="btnSearch"
                                onclick="handleAssign()">
                                Assign
                            </button>
                            <!-- <button
                class="btn btn-warning me-2"
                type="button"
                onclick="handleDelete()"
              >
                Delete
              </button> -->
                            <button
                                class="btn btn-danger"
                                type="button"
                                id="btnSearch"
                                onclick="clearAllControls()">
                                Clear All
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

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
        <script src="js/AssignZoneWardToEmployee.js"></script>
    </body>
</asp:Content>
