<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="VehicleWiseTripsReport.aspx.cs" Inherits="SWM.VehicleWiseTripsReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <%--<link href="css/date.css" rel="stylesheet" />--%>

        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <title>Datewise</title>
        <!-- Bootstrap links -->
        <link rel="stylesheet"
            href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
            integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
            crossorigin="anonymous" />
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
            integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
            crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"
            integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut"
            crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"
            integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k"
            crossorigin="anonymous"></script>

        <script src="http://code.jquery.com/jquery-3.3.1.min.js"
            integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
            crossorigin="anonymous"></script>
        <link rel="stylesheet"
            href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css" />
        <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
        <!-- Bootstrap links end -->
        <link href="css/global.css" rel="stylesheet" />
        <link href="css/fstdropdown.css" rel="stylesheet" />
    </head>
    <body>
        <div class="main-container">
        </div>

        <section class="filters-section">
            <div class="filters-container">
                <div class="title d-flex justify-content-between">
                    <div class="d-flex align-items-center">
                        <i class="fa-solid fa-book"></i>
                        <h3>Vehicle Wise Trip Report</h3>
                    </div>
                </div>
                <div class="body">
                    <div class="row px-3 pb-3">
                        <div class="col-sm-2">
                            <label>Ramp Name</label>
                            <asp:DropDownList class="fstdropdown-select" ID="ddlRamp" runat="server"></asp:DropDownList>
                        </div>
                        <div class="col-sm-2 date-wrapper">
                            <label>From Date</label>
                            <asp:TextBox ID="txtFromDate" TextMode="Date" runat="server"></asp:TextBox>
                        </div>
                        <div class="col-sm-2 date-wrapper">
                            <label>To Date</label>
                            <asp:TextBox ID="txtToDate" TextMode="Date" runat="server"></asp:TextBox>
                        </div>
                        <div class="col-sm-2">
                            <div class="d-flex align-items-end h-100">
                            <asp:Button ID="btnSearch" runat="server" Text="Show" OnClick="btnSearch_Click" CssClass="btn btn-success btn-sm" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <asp:Panel ID="tableWrapper" runat="server" Visible="false">
            <section class="sweeper-coverage-report-section">
                <div class="sweeper-coverage-report">
                    <div class="title dropdown-btn">
                        <div class="controls">
                            <div>
                                <h2>Pune Municipal Corporation</h2>
                                |
                            <h3>Vehicle Wise Trip Report</h3>
                            </div>
                        </div>

                        <div class="downloads d-flex align-items-center" visible="true">
                            <asp:ImageButton ID="ImageButton1" src="Images/xls.png" runat="server" CssClass="mr-1" OnClick="btnexcel_Click" />
                            <asp:ImageButton ID="ImageButton2" src="Images/pdf.png" runat="server" CssClass="mr-1" OnClick="btnpdf_Click" />
                            <button class="btn btn-light btn-sm p-0 outline-none" type="button" data-toggle="collapse" data-target="#tableCollapse" aria-expanded="false" aria-controls="tableCollapse">
                                <i class="fa-solid fa-chevron-down"></i>
                            </button>
                        </div>
                    </div>

                    <div class="collapse show" id="tableCollapse">
                        <div class="body collapsible active">
                            <asp:GridView ID="adhocTable" runat="server" AutoGenerateColumns="true" CssClass="table-striped vehicleWise">
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </section>
        </asp:Panel>

        <script>
            const dateInput = document.querySelectorAll('.date-wrapper input');
            const currentDate = new Date().toISOString().substr(0, 10);

            dateInput.forEach(input => {
                input.value = currentDate;
            });
        </script>
        <script>
            $(document).ready(function () {
                $(".vehicleWise").prepend($("<thead></thead>").append($(this).find("tr:first"))).DataTable({
                    pageLength: 5,
                    language: {
                        lengthMenu: "_MENU_  records per page",
                        sSearch: "<img src='Images/search.png' />",
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
                });
            });
        </script>
        <script src="fstdropdown.js"></script>

        <script>
            $(document).ready(function () {
                $('#searchBtn').click(function () {
                    // Button click event logic here
                    alert('Button clicked!');
                    // You can add your desired functionality or perform an action
                    // when the button is clicked.
                });
            });
        </script>
        <script src="Scripts/fstdropdown.js"></script>
    </body>
</asp:Content>
