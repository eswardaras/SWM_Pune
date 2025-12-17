<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EmailManagement.aspx.cs" Inherits="SWM.EmailManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <head>
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
        <!-- Sweet Aleart -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <!-- Sweet Aleart End -->
        <style>
            .cursor-pointer {
                cursor: pointer;
            }
        </style>
        <title>Email Management</title>
    </head>
    <body>
        <div class="container-fluid my-3">
            <div
                class="border mx-2 d-flex justify-content-between align-items-center">
                <h6 class="mb-0">
                    <i class="fa-solid fa-book m-2"></i>Email Management
                </h6>
                <%--                <button type="button" class="btn btn-light h-100 toggler__btn">
                    <i class="fa-solid fa-chevron-down"></i>
                </button>--%>
            </div>
            <div class="toggler__content" id="editPanel" style="display: none">
                <div class="row border border-top-0 mx-2 py-2">
                    <div class="col-lg-2 col-md-3 mt-1">
                        <label for="zoneDropdown">Zone</label>
                        <select
                            id="zoneDropdown"
                            class="fstdropdown-select"
                            onchange="handleZoneSelect()">
                            <option value="0">Select Zone</option>
                        </select>
                    </div>
                    <div class="col-lg-2 col-md-3 mt-1">
                        <label for="wardDropdown">Ward</label>
                        <select
                            id="wardDropdown"
                            class="fstdropdown-select">
                            <option value="0">Select Ward</option>
                        </select>
                    </div>
                    <div class="col-lg-3 col-md-4 mt-1">
                        <label for="deskEngineerNameInput">Desk Engineer Name</label>
                        <input
                            type="text"
                            class="form-control"
                            id="deskEngineerNameInput" />
                    </div>
                    <div class="col-lg-3 col-md-4 mt-1">
                        <label for="deskEngineerContactInput">Contact Number</label>
                        <input
                            type="number"
                            class="form-control"
                            id="deskEngineerContactInput" />
                    </div>
                    <div class="col-lg-3 col-md-4 mt-1">
                        <label for="deskEngineerEmailInput">Desk Engineer Email ID</label>
                        <input
                            type="email"
                            class="form-control"
                            id="deskEngineerEmailInput" />
                    </div>
                    <div class="col-lg-3 col-md-4 mt-1">
                        <label for="fieldEngineerNameInput">Field Engineer Name</label>
                        <input
                            type="text"
                            class="form-control"
                            id="fieldEngineerNameInput" />
                    </div>
                    <div class="col-lg-3 col-md-4 mt-1">
                        <label for="fieldEngineerContactInput">
                            Field Engineer Contact Number</label>
                        <input
                            type="number"
                            class="form-control"
                            id="fieldEngineerContactInput" />
                    </div>
                    <div class="col-lg-3 col-md-4 mt-1">
                        <label for="fieldEngineerEmailInput">Field Engineer Email ID</label>
                        <input
                            type="text"
                            class="form-control"
                            id="fieldEngineerEmailInput" />
                    </div>
                    <div class="col-lg-3 col-md-4 mt-1">
                        <label for="deskEngineerNameInput">Ward Officer</label>
                        <input
                            type="text"
                            class="form-control"
                            id="wardOfficerInput" />
                    </div>
                    <div class="col-lg-3 col-md-4 mt-1">
                        <label for="juniorEngineerNameInput">Junior Engineer Name</label>
                        <input
                            type="text"
                            class="form-control"
                            id="juniorEngineerNameInput" />
                    </div>
                    <div class="col-lg-3 col-md-4 mt-1">
                        <label for="juniorEngineerEmailInput">Junior Engineer Email ID</label>
                        <input
                            type="text"
                            class="form-control"
                            id="juniorEngineerEmailInput" />
                    </div>
                    <div class="col-lg-3 col-md-4 mt-1">
                        <label for="juniorEngineerContactInput">
                            Junior Engineer Contact Number</label>
                        <input
                            type="number"
                            class="form-control"
                            id="juniorEngineerContactInput" />
                    </div>
                    <div class="col-lg-3 col-md-4 mt-1">
                        <label for="dsiNameInput">DSI Name</label>
                        <input
                            type="text"
                            class="form-control"
                            id="dsiNameInput" />
                    </div>
                    <div class="col-lg-3 col-md-4 mt-1">
                        <label for="dsiEmailInput">DSI Email ID</label>
                        <input
                            type="text"
                            class="form-control"
                            id="dsiEmailInput" />
                    </div>
                    <div class="col-lg-3 col-md-4 mt-1">
                        <label for="dsiContactInput">DSI Contact Number</label>
                        <input
                            type="number"
                            class="form-control"
                            id="dsiContactInput" />
                    </div>
                    <div class="col-lg-3 col-md-4 mt-1">
                        <label for="siNameInput">SI Name</label>
                        <input
                            type="text"
                            class="form-control"
                            id="siNameInput" />
                    </div>
                    <div class="col-lg-3 col-md-4 mt-1">
                        <label for="siEmailInput">SI Email ID</label>
                        <input
                            type="text"
                            class="form-control"
                            id="siEmailInput" />
                    </div>
                    <div class="col-lg-3 col-md-4 mt-1">
                        <label for="siContactIput">SI Contact Number</label>
                        <input
                            type="number"
                            class="form-control"
                            id="siContactIput" />
                    </div>
                    <div class="col-lg-2 col-md-2 mt-1">
                        <div class="d-flex align-items-start mt-4 h-100">
                            <button
                                class="btn btn-success me-2"
                                type="button"
                                id="btnSearch"
                                onclick="handleSubmit()">
                                Submit
                            </button>
                            <button
                                class="btn btn-danger"
                                type="button"
                                onclick="handleCancel()">
                                Clear
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <section class="sweeper-coverage-report-section" id="tableWrapper">
            <div class="sweeper-coverage-report">
                <div class="body collapsible active toggler__content">
                    <table class="table table-striped text-center" id="table">
                        <thead>
                            <th>Sr.No</th>
                            <th>Edit</th>
                            <th>Zone</th>
                            <th>Ward</th>
                            <th>Desk Engineer Name</th>
                            <th>Desk Contact Number</th>
                            <th>Desk Mail ID</th>
                            <th>Field Engineer Name</th>
                            <th>Field Contact Number</th>
                            <th>Field Mail ID</th>
                            <th>Ward Officer</th>
                            <th>Junior Engineer Engineer Name</th>
                            <th>Junior Engineer Mail ID</th>
                            <th>Junior Engineer Contact Number</th>
                            <th>DSI Engineer Engineer Name</th>
                            <th>DSI Engineer Contact Number</th>
                            <th>DSI Engineer Mail ID</th>
                            <th>SI Engineer Engineer Name</th>
                            <th>SI Engineer Contact Number</th>
                            <th>SI Engineer Mail ID</th>
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
                    $(button).parent().next().slideToggle("fast");
                }

                $(".toggler__btn").click(function () {
                    collapseContent(this);
                });
            });
        </script>
        <script src="js/EmailManagement.js"></script>
    </body>
</asp:Content>
