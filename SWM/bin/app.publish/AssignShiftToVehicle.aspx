<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AssignShiftToVehicle.aspx.cs" Inherits="SWM.AssignShiftToVehicle" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <head>
        <script src="js/jquery-3.3.1.min.js"></script>
        <!-- Select 2 -->
        <link
            href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css"
            rel="stylesheet" />

        <link
            rel="stylesheet"
            href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css" />
        <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/buttons/2.0.1/js/dataTables.buttons.min.js"></script>
        <script src="https://cdn.datatables.net/buttons/2.0.1/js/buttons.html5.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.6.0/jszip.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
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
                    <i class="fa-solid fa-book mx-2"></i>Assign Shift To Vehicles
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

                    <div class="col-lg-3 col-md-4 mt-1 content1">
                        <label for="">Select Shift</label>
                        <select  class="form-select" id="ShiftDropdown" multiple>  </select>
                    </div>
                    <div class="col-lg-3 col-md-4 mt-1 content1">
                        <label for="zoneDropdown">Select Vehicle</label>
                        <select class="form-select" id="vehicleDropdown" multiple></select>
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
                        <select class="form-select" id="vehicleDropdown1" multiple>
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

                <section class="sweeper-coverage-report-section" id="tableWrapper">
                    <div class="sweeper-coverage-report">
                        <div class="body collapsible active toggler__content">
                            <table class="table table-striped text-center" id="table">
                                <thead>
                                    <th>Sr.No</th>
                                    <th>Vehicle</th>
                                    <th>Shift Name</th>
                                    <th>Shift Time</th>
                                    <th>Edit</th>
                                </thead>
                                <tbody></tbody>
                            </table>
                        </div>
                    </div>
                </section>
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
        <script src="js/AssignShiftToVehicle.js"></script>
    </body>
</asp:Content>
