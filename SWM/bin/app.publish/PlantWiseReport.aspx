<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PlantWiseReport.aspx.cs" Inherits="SWM.PlantWiseReport" %>


    

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
                        <h3>Plant Wise Report</h3>
                    </div>
                    <asp:Button ID="btnSearch" runat="server" Text="Show" OnClick="btnSearch_Click" CssClass="btn btn-success" />
                </div>
                <div class="body">
                    <div class="row px-3 pb-3">
                        <div class="col-sm-2">
                            <label>Plant Name</label>
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
                            <label>Month</label>
                            <asp:DropDownList ID="ddlMonth" AutoPostBack="true" runat="server" CssClass="fstdropdown-select" OnSelectedIndexChanged="ddlMonth_SelectedIndexChanged">
                                <asp:ListItem Value="0">Select</asp:ListItem>
                                <asp:ListItem Value="1">January</asp:ListItem>
                                <asp:ListItem Value="2">February</asp:ListItem>
                                <asp:ListItem Value="3">March</asp:ListItem>
                                <asp:ListItem Value="4">April</asp:ListItem>
                                <asp:ListItem Value="5">May</asp:ListItem>
                                <asp:ListItem Value="6">June</asp:ListItem>
                                <asp:ListItem Value="7">July</asp:ListItem>
                                <asp:ListItem Value="8">August</asp:ListItem>
                                <asp:ListItem Value="9">September</asp:ListItem>
                                <asp:ListItem Value="10">October</asp:ListItem>
                                <asp:ListItem Value="11">November</asp:ListItem>
                                <asp:ListItem Value="12">December</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-sm-2">
                            <label>Week</label>
                            <asp:DropDownList ID="ddlWeek" AutoPostBack="true" runat="server" CssClass="fstdropdown-select" OnSelectedIndexChanged="ddlWeek_SelectedIndexChanged">
                                <asp:ListItem Value="0">Select</asp:ListItem>
                                <asp:ListItem Value="1">1st Week</asp:ListItem>
                                <asp:ListItem Value="2">2nd Week</asp:ListItem>
                                <asp:ListItem Value="3">3rd Week</asp:ListItem>
                                <asp:ListItem Value="4">4th Week</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-2">
                            <label>Quarterly/Half Yearly/Yearly</label>
                            <asp:DropDownList ID="ddlQuarterYearly" AutoPostBack="true" runat="server" CssClass="fstdropdown-select" OnSelectedIndexChanged="ddlQuarterYearly_SelectedIndexChanged">
                                <asp:ListItem Value="0">Select</asp:ListItem>
                                <asp:ListItem Value="1">1st Quarter of the year</asp:ListItem>
                                <asp:ListItem Value="2">2nd Quarter of the year</asp:ListItem>
                                <asp:ListItem Value="3">3rd Quarter of the year</asp:ListItem>
                                <asp:ListItem Value="4">4th Quarter of the year</asp:ListItem>
                                <asp:ListItem Value="5">1st Half of the year</asp:ListItem>
                                <asp:ListItem Value="6">2nd Half of the year</asp:ListItem>
                                <asp:ListItem Value="7">Yearly</asp:ListItem>
                            </asp:DropDownList>
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
                            <h3>PlantWise Report</h3>
                            </div>
                        </div>

                        <div class="downloads d-flex align-items-center" visible="true">
                            <asp:ImageButton ID="btnexcel1" src="Images/xls.png" runat="server" CssClass="mr-1" OnClick="btnexcel_Click" />
                            <asp:ImageButton ID="btnpdf1" src="Images/pdf.png" runat="server" CssClass="mr-1" OnClick="btnpdf_Click" />
                            <button class="btn btn-light btn-sm p-0 outline-none" type="button" data-toggle="collapse" data-target="#tableCollapse1" aria-expanded="false" aria-controls="tableCollapse1">
                                <i class="fa-solid fa-chevron-down"></i>
                            </button>
                        </div>
                    </div>

                    <div class="collapse show" id="tableCollapse1">
                        <div class="body collapsible active">
                            <asp:GridView ID="FirstTable" runat="server" CssClass="table-striped firstTable" AutoGenerateColumns="true">
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </section>


            <section class="sweeper-coverage-report-section">
                <div class="sweeper-coverage-report">
                    <div class="title dropdown-btn">
                        <div class="controls">
                            <div>
                                <h2>Pune Municipal Corporation</h2>
                                |
                            <h3>PlantWise Report (Incomming Weight Bifurcation)</h3>
                            </div>
                        </div>

                        <div class="downloads d-flex align-items-center" visible="true">
                            <asp:ImageButton ID="btnexcel2" src="Images/xls.png" runat="server" CssClass="mr-1" OnClick="btnexcel_Click" />
                            <asp:ImageButton ID="btnpdf2" src="Images/pdf.png" runat="server" CssClass="mr-1" OnClick="btnpdf_Click" />
                            <button class="btn btn-light btn-sm p-0 outline-none" type="button" data-toggle="collapse" data-target="#tableCollapse2" aria-expanded="false" aria-controls="tableCollapse2">
                                <i class="fa-solid fa-chevron-down"></i>
                            </button>
                        </div>
                    </div>

                    <div class="collapse show" id="tableCollapse2">
                        <div class="body collapsible active">
                            <asp:GridView ID="SecondTable" runat="server" CssClass="table-striped secondTable" AutoGenerateColumns="true">
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </section>

            <section class="sweeper-coverage-report-section">
                <div class="sweeper-coverage-report">
                    <div class="title dropdown-btn">
                        <div class="controls">
                            <div>
                                <h2>Pune Municipal Corporation</h2>
                                |
                            <h3>PlantWise Report (OutGoing Weight Bifurcation)</h3>
                            </div>
                        </div>

                        <div class="downloads d-flex align-items-center" visible="true">
                            <asp:ImageButton ID="btnexcel3" src="Images/xls.png" runat="server" CssClass="mr-1" OnClick="btnexcel_Click" />
                            <asp:ImageButton ID="btnpdf3" src="Images/pdf.png" runat="server" CssClass="mr-1" OnClick="btnpdf_Click" />
                            <button class="btn btn-light btn-sm p-0 outline-none" type="button" data-toggle="collapse" data-target="#tableCollapse3" aria-expanded="false" aria-controls="tableCollapse3">
                                <i class="fa-solid fa-chevron-down"></i>
                            </button>
                        </div>
                    </div>

                    <div class="collapse show" id="tableCollapse3">
                        <div class="body collapsible active">
                            <asp:GridView ID="ThirdTable" runat="server" CssClass="table-striped ThirdTable" AutoGenerateColumns="true">
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </section>


            <%--    <section class="sweeper-coverage-report-section">
                <div class="sweeper-coverage-report">
                    <div class="title dropdown-btn">
                        <div class="controls">
                            <div>
                                <h2>Pune Municipal Corporation</h2>
                                |
                            <h3>RampWise Report (Outgoing Weight Bifurcation)</h3>
                            </div>
                        </div>

                        <div class="downloads d-flex align-items-center" visible="true">
                            <asp:ImageButton ID="btnexcel3" src="Images/xls.png" runat="server" CssClass="mr-1" OnClick="btnexcel_Click" />
                            <asp:ImageButton ID="btnpdf3" src="Images/pdf.png" runat="server" CssClass="mr-1" OnClick="btnpdf_Click" />
                            <button class="btn btn-light btn-sm p-0 outline-none" type="button" data-toggle="collapse" data-target="#tableCollapse3" aria-expanded="false" aria-controls="tableCollapse3">
                                <i class="fa-solid fa-chevron-down"></i>
                            </button>
                        </div>
                    </div>

                    <div class="collapse show" id="tableCollapse3">
                        <div class="body collapsible active">
                            <asp:GridView ID="ThirdTable" runat="server" CssClass="table-striped thirdTable" AutoGenerateColumns="true">
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </section>


            <section class="sweeper-coverage-report-section">
                <div class="sweeper-coverage-report">
                    <div class="title dropdown-btn">
                        <div class="controls">
                            <div>
                                <h2>Pune Municipal Corporation</h2>
                                |
                            <h3>RampWise Report (Outgoing Weight Bifurcation PlantWise)</h3>
                            </div>
                        </div>

                        <div class="downloads d-flex align-items-center" visible="true">
                            <asp:ImageButton ID="btnexcel4" src="Images/xls.png" runat="server" CssClass="mr-1" OnClick="btnexcel_Click" />
                            <asp:ImageButton ID="btnpdf4" src="Images/pdf.png" runat="server" CssClass="mr-1" OnClick="btnpdf_Click" />
                            <button class="btn btn-light btn-sm p-0 outline-none" type="button" data-toggle="collapse" data-target="#tableCollapse4" aria-expanded="false" aria-controls="tableCollapse4">
                                <i class="fa-solid fa-chevron-down"></i>
                            </button>
                        </div> 
                    </div>

                    <div class="collapse show" id="tableCollapse4">
                        <div class="body collapsible active">
                            <asp:GridView ID="FourthTable" runat="server" CssClass="table-striped fourthTable" AutoGenerateColumns="true">
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </section>


            <section class="sweeper-coverage-report-section">
                <div class="sweeper-coverage-report">
                    <div class="title dropdown-btn">
                        <div class="controls">
                            <div>
                                <h2>Pune Municipal Corporation</h2>
                                |
                            <h3>Pune Municipal Corporation | RampWise Report (Incomming Details)</h3>
                            </div>
                        </div>

                        <div class="downloads d-flex align-items-center" visible="true">
                            <asp:ImageButton ID="btnexcel5" src="Images/xls.png" runat="server" CssClass="mr-1" OnClick="btnexcel_Click" />
                            <asp:ImageButton ID="btnpdf5" src="Images/pdf.png" runat="server" CssClass="mr-1" OnClick="btnpdf_Click" />
                            <button class="btn btn-light btn-sm p-0 outline-none" type="button" data-toggle="collapse" data-target="#tableCollapse5" aria-expanded="false" aria-controls="tableCollapse5">
                                <i class="fa-solid fa-chevron-down"></i>
                            </button>
                        </div>
                    </div>

                    <div class="collapse show" id="tableCollapse5">
                        <div class="body collapsible active">
                            <asp:GridView ID="FifthTable" runat="server" CssClass="table-striped fifthTable" AutoGenerateColumns="true">
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </section>


            <section class="sweeper-coverage-report-section">
                <div class="sweeper-coverage-report">
                    <div class="title dropdown-btn">
                        <div class="controls">
                            <div>
                                <h2>Pune Municipal Corporation</h2>
                                |
                            <h3>RampWise Report (Outgoing Details)</h3>
                            </div>
                        </div>

                        <div class="downloads d-flex align-items-center" visible="true">
                            <asp:ImageButton ID="btnexcel6" src="Images/xls.png" runat="server" CssClass="mr-1" OnClick="btnexcel_Click" />
                            <asp:ImageButton ID="btnpdf6" src="Images/pdf.png" runat="server" CssClass="mr-1" OnClick="btnpdf_Click" />
                            <button class="btn btn-light btn-sm p-0 outline-none" type="button" data-toggle="collapse" data-target="#tableCollapse6" aria-expanded="false" aria-controls="tableCollapse6">
                                <i class="fa-solid fa-chevron-down"></i>
                            </button>
                        </div>
                    </div>

                    <div class="collapse show" id="tableCollapse6">
                        <div class="body collapsible active">
                            <asp:GridView ID="SixthTable" runat="server" CssClass="table-striped sixthTable" AutoGenerateColumns="true">
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </section>--%>
        </asp:Panel>
       

        <script>
            const dateInput = document.querySelectorAll('.date-wrapper input');
            const currentDate = new Date().toISOString().substr(0, 10);

            dateInput.forEach(input => {
                if (!input.value) {
                    input.value = currentDate;
                }
            });
        </script>

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
        <%--        <script>
            $(document).ready(function () {
                function initializeDataTable(tableElement) {
                    $(tableElement).prepend($("<thead></thead>").append($(tableElement).find("tr:first"))).DataTable({
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
                }

                initializeDataTable(".firstTable");
                initializeDataTable(".secondTable");
                initializeDataTable(".ThirdTable");
                initializeDataTable(".fourthTable");
                initializeDataTable(".fifthTable");
                initializeDataTable(".sixthTable");
            });
        </script>--%>
        <script>
            $(document).ready(function () {
                function initializeDataTable(tableElement) {
                    $(tableElement).prepend($("<thead></thead>").append($(tableElement).find("tr:first"))).DataTable({
                        pageLength: 5,
                        dom:
                            "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
                            "<'row'<'col-sm-12'tr>>" +
                            "<'row justify-content-between'<'col-sm-12 col-md-auto'i><'col-sm-12 col-md-auto'p>>",
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

                function initializeDataTable1(tableElement) {
                    $(tableElement).prepend($("<thead></thead>").append($(tableElement).find("tr:first"))).DataTable({
                        pageLength: 5,
                        dom:
                            "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
                            "<'row'<'col-sm-12'tr>>" +
                            "<'row justify-content-between'<'col-sm-12 col-md-auto'i><'col-sm-12 col-md-auto'p>>",
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
                        order: [[2, "asc"]],
                    });
                }

                function getFormattedDate() {
                    const today = new Date();
                    const options = { year: "numeric", month: "short", day: "numeric" };
                    return today.toLocaleDateString("en-US", options);
                }

                initializeDataTable(".firstTable");
                initializeDataTable1(".secondTable");
                initializeDataTable1(".ThirdTable");
            });

        </script>
        <script src="Scripts/fstdropdown.js"></script>
    </body>
</asp:Content>
