<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddTypeOfEndProcessingUnit.aspx.cs" Inherits="SWM.AddTypeOfEndProcessingUnit" %>

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
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="js/purify.min.js"></script>
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
        <title>Add Type Of End Processing Unit</title>
    </head>
    <body>
        <div class="container-fluid my-3">
            <div
                class="border mx-2 d-flex justify-content-between align-items-center">
                <h6 class="mb-0">
                    <i class="fa-solid fa-book mx-2"></i>Add Type Of End Processing Unit
                </h6>
                <button type="button" class="btn btn-light h-100 toggler__btn">
                    <i class="fa-solid fa-chevron-down"></i>
                </button>
            </div>
            <div class="toggler__content">
                <div class="row border border-top-0 mx-2 py-2">
                    <div class="col-lg-2 col-md-3 mt-1">
                        <label for="">Plant Type</label>
                        <input type="text" class="form-control" id="plantTypeInput" />
                    </div>
                    <div class="col-lg-2 col-md-3 mt-1">
                        <label for="">Plant Name</label>
                        <input type="text" class="form-control" id="plantNameInput" />
                    </div>
                    <div class="col-lg-3 col-md-5 mt-1">
                        <label for="userDropdown">Location</label>
                        <textarea
                            name=""
                            id="locationInput"
                            cols="30"
                            rows="2"
                            class="form-control"></textarea>
                    </div>
                    <div class="col-lg-2 col-md-2 mt-1">
                        <div class="d-flex align-items-end h-100">
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
                                id="btnSearch"
                                onclick="handleCancel()">
                                Cancel
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <section class="sweeper-coverage-report-section" id="tableWrapper">
            <div class="sweeper-coverage-report">
                <div class="title dropdown-btn">
                    <div class="controls">
                        <div>
                            <div class="form-check">
                                <input
                                    class="form-check-input me-1"
                                    type="checkbox"
                                    value=""
                                    id="selectAllCheckbox"
                                    oninput="handleSelectAll(event)" />
                                <label class="form-check-label" for="selectAllCheckbox">
                                    Check All
                                </label>
                            </div>
                            <button
                                type="button"
                                class="btn btn-sm btn-danger mx-3"
                                onclick="handleDelete()">
                                Delete
                            </button>
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
                            <th>Select</th>
                            <th>Sr. No</th>
                            <th>Plant Type</th>
                            <th>Plant Name</th>
                            <th>Location</th>
                            <th>Edit</th>
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
        <script src="js/addTypeOfEndProcessingUnit.js"></script>
    </body>
</asp:Content>
