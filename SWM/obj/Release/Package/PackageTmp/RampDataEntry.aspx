<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RampDataEntry.aspx.cs" Inherits="SWM.RampDataEntry" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <!-- Other meta tags, styles, and scripts -->
    <meta http-equiv="refresh" content="60">
    <script
        src="https://kit.fontawesome.com/e8c1c6e963.js"
        crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script
        src="http://code.jquery.com/jquery-3.3.1.min.js"
        integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
        crossorigin="anonymous"></script>
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

    <link href="css/global.css" rel="stylesheet" />
    <title>RampDataEntry</title>
</head>
<body>
    <form id="form1" runat="server">
        <%--        <section class="sweeper-coverage-report-section">
            <div class="sweeper-coverage-report">
                <div class="title dropdown-btn">
                    <div class="controls">
                        <div>
                            <h2>Pune Municipal Corporation</h2>

                            <h3>RampDataEntry</h3>
                        </div>
                    </div>

                </div>

                <div class="collapse show" id="tableCollapse2">
                    <div class="body collapsible active">
                    </div>
                </div>

                <br />
                <br />
                <h3>PlantDataEntry</h3>
                <div class="collapse show" id="tableCollapse3">
                    <div class="body collapsible active">
                    </div>
                </div>
            </div>
        </section>--%>

        <div class="container-fluid">
            <div class="row my-3">
                <div class="col-12" >
                    <h2 class="fs-3 border p-2 rounded-2">Pune Municipal Corporation</h2>
                </div>
                <div class="col-12 overflow-x-auto mb-3">
                    <h3 class="fs-4 mb-2">Ramp Data Entry:-</h3>
                    <asp:GridView ID="grdData" runat="server" CssClass="table table-striped grdData text-center" AutoGenerateColumns="true" OnRowDataBound="grdData_RowDataBound">
                    </asp:GridView>
                </div>
                <div class="col-12 overflow-x-auto">
                    <h3 class="fs-4 mb-2">Plant Data Entry:-</h3>
                    <asp:GridView ID="grd_PlantData" runat="server" CssClass="table table-striped grd_PlantData text-center" AutoGenerateColumns="true" OnRowDataBound="grd_PlantData_RowDataBound">
                    </asp:GridView>
                </div>
            </div>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>

    <script>
        $(document).ready(function () {
            function initializeDataTable(tableElement) {
                $(tableElement).prepend($("<thead></thead>").append($(tableElement).find("tr:first"))).DataTable({
                    pageLength: 5,
                    dom:
                        "<'row'<'col-sm-12 col-md-6'B><'col-sm-12 col-md-6'f>>" +
                        "<'row'<'col-sm-12'tr>>" +
                        "<'row justify-content-between'<'col-sm-12 col-md-auto d-flex align-items-center'l><'col-sm-12 col-md-auto'i><'col-sm-12 col-md-auto'p>>",
                    buttons: [
                        {
                            extend: "excelHtml5",
                            text: "Excel <i class='fas fa-file-excel text-white'></i>",
                            title: document.title + ' - ' + getFormattedDate(),
                            className: "btn btn-sm btn-success mb-2", // Add your Excel button class here
                        },
                        {
                            extend: "pdf",
                            text: "PDF <i class='fa-regular fa-file-pdf text-white'></i>",
                            title: 'Sweeper Attendance Report' + ' - ' + getFormattedDate(),
                            className: "btn btn-sm btn-danger mb-2", // Add your Excel button class here
                            customize: function (doc) {
                                // Set custom page size (width x height)
                                doc.pageOrientation = "landscape"; // or "portrait" for portrait orientation
                                doc.pageSize = "A4"; // or an array: [width, height]

                                // Set custom margins (left, right, top, bottom)
                                doc.pageMargins = [20, 20, 20, 20];
                            },
                        },
                        // "pdf",
                        // "csvHtml5",
                    ],
                    language: {
                        lengthMenu: "_MENU_  records per page",
                        sSearch: "<img src='Images/search.png' alt='search'>",
                        paginate: {
                            first: "First",
                            last: "Last",
                            next: "Next &rarr;",
                            previous: "&larr; Previous",
                        },
                    },
                    lengthMenu: [
                        [5, 10, 25, 50, -1],
                        [5, 10, 25, 50, "All"],
                    ],
                    order: [0, 1, 2],
                });
            }

            function getFormattedDate() {
                const today = new Date();
                const options = { year: 'numeric', month: 'short', day: 'numeric' };
                return today.toLocaleDateString('en-US', options);
            }

            initializeDataTable(".grdData");
            initializeDataTable(".grd_PlantData");
        });
    </script>
</body>
</html>
