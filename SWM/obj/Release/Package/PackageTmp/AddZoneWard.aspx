<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddZoneWard.aspx.cs" Inherits="SWM.AddZoneWard" %>

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
        <title>Add Zone Ward</title>
    </head>
    <body>
        <div class="container-fluid my-3">
            <div
                class="border mx-2 d-flex justify-content-between align-items-center">
                <h6 class="mb-0"><i class="fa-solid fa-book m-2"></i>Add Zone Ward</h6>
            </div>
            <div class="toggler__content">
                <div class="row border border-top-0 border-bottom-0 mx-2 py-2">
                    <div class="col-auto mt-1">
                        <div class="form-check form-check-inline">
                            <input
                                class="form-check-input"
                                type="radio"
                                id="zoneRadio"
                                name="radio"
                                checked />
                            <label class="form-check-label" for="zoneRadio">Zone</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input
                                class="form-check-input"
                                type="radio"
                                id="wardRadio"
                                name="radio" />
                            <label class="form-check-label" for="wardRadio">Ward</label>
                        </div>
                    </div>
                </div>
                <div class="row border border-top-0 mx-2 py-2">
                    <div class="col-lg-2 col-md-3 mt-1 stateDropdownWrapper">
                        <label for="">State</label>
                        <select
                            id="stateDropdown"
                            class="fstdropdown-select"
                            onchange="handleStateSelect()">
                            <option value="0">Select</option>
                        </select>
                    </div>
                    <div class="col-lg-2 col-md-3 mt-1 areaDropdownWrapper">
                        <label for="">Area</label>
                        <select id="areaDropdown" class="fstdropdown-select">
                            <option value="0">Select</option>
                        </select>
                    </div>
                    <div class="col-lg-2 col-md-3 mt-1 zoneNameInputWrapper">
                        <label for="">Zone Name</label>
                        <input type="text" class="form-control" style="height: 35px" id="zoneNameInput" />
                    </div>
                    <div
                        class="col-lg-2 col-md-3 mt-1 zoneDropdownWrapper"
                        style="display: none">
                        <label for="">Zone</label>
                        <select id="zoneDropdown" class="fstdropdown-select">
                            <option value="0">Select</option>
                        </select>
                    </div>
                    <div
                        class="col-lg-2 col-md-3 mt-1 wardNameInputWrapper"
                        style="display: none">
                        <label for="">Ward Name</label>
                        <input type="text" class="form-control" style="height: 35px" id="wardNameInput" />
                    </div>
                    <div class="col-lg-2 col-md-2 mt-1">
                        <div class="d-flex align-items-end h-100">
                            <button
                                class="btn btn-success me-2"
                                type="button"
                                id="btnSearch"
                                onclick="submitZone()">
                                Submit
                            </button>
                            <button
                                class="btn btn-warning"
                                type="button"
                                onclick="handleCancel()">
                                Cancel
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <section class="sweeper-coverage-report-section" id="tableWrapper1">
            <div class="sweeper-coverage-report">
                <div class="body collapsible active toggler__content">
                    <table class="table table-striped text-center" id="table1">
                        <thead>
                            <th>Sr.No</th>
                            <th>Zone Name</th>
                            <th>Edit</th>
                            <th>Delete</th>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>
        </section>

        <section
            class="sweeper-coverage-report-section"
            id="tableWrapper2"
            style="display: none">
            <div class="sweeper-coverage-report">
                <div class="body collapsible active toggler__content">
                    <table class="table table-striped text-center" id="table2">
                        <thead>
                            <th>Sr.No</th>
                            <th>Zone Name</th>
                            <th>Ward Name</th>
                            <th>Edit</th>
                            <th>Delete</th>
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
        <script src="js/AddZoneWard.js"></script>
    </body>
</asp:Content>
