<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SweeperAttendance.aspx.cs" Inherits="SWM.SweeperAttendance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Sweeper Attendance Report</title>
        <link
            href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css"
            rel="stylesheet" />
        <link href="css/fstdropdown.css" rel="stylesheet" />

        <!-- Bootstrap links -->
        <link
            rel="stylesheet"
            href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
            integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
            crossorigin="anonymous" />
        <script
            src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
            integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
            crossorigin="anonymous"></script>
        <script
            src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"
            integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut"
            crossorigin="anonymous"></script>
        <script
            src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"
            integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k"
            crossorigin="anonymous"></script>

        <script
            src="https://code.jquery.com/jquery-3.3.1.min.js"
            integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
            crossorigin="anonymous"></script>
        <!-- Bootstrap links end -->
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
    </head>

    <body>
        <section class="filters-section byProduct">
            <div class="filters-container">
                <div class="title d-flex justify-content-between">
                    <div class="d-flex align-items-center">
                        <i class="fa-solid fa-book"></i>
                        <h3>Sweeper Attendance</h3>
                    </div>
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-success btn-sm float-right mr-2" OnClientClick="return validateDateModal()" OnClick="btnSearch_Click" />
                </div>
                <div class="body">
                    <div class="row px-3">
                        <asp:RadioButtonList RepeatDirection="Horizontal" runat="server" ID="rbtAttendance" CssClass="w-auto asp_radioButtons">
                            <asp:ListItem Selected="True" Text="Sweeper"></asp:ListItem>
                            <asp:ListItem Text="Mokadam"></asp:ListItem>
                        </asp:RadioButtonList>
                    </div>
                    <div class="row px-3 pb-3">
                        <div class="col-sm-2">
                            <label>Zone Name</label>
                            <asp:DropDownList ID="ddlZone" runat="server" AutoPostBack="true" class="fstdropdown-select" OnSelectedIndexChanged="ddlZone_SelectedIndexChanged">
                            </asp:DropDownList>
                        </div>
                        <div class="col-sm-2">
                            <label>Ward Name</label>
                            <asp:DropDownList ID="ddlWard" runat="server" class="fstdropdown-select" AutoPostBack="True" OnSelectedIndexChanged="ddlWard_SelectedIndexChanged">
                            </asp:DropDownList>
                        </div>
                        <div class="col-sm-2">
                            <label>Kothi Name</label>
                            <asp:DropDownList ID="ddlKothi" runat="server" class="fstdropdown-select">
                            </asp:DropDownList>
                        </div>
                        <div class="col-sm-2 date-wrapper">
                            <label>From Date</label>
                            <asp:TextBox ID="txtSdate" runat="server" type="date"></asp:TextBox>
                        </div>
                        <div class="col-sm-2 date-wrapper">
                            <label>To Date</label>
                            <asp:TextBox ID="txtEdate" runat="server" type="date"></asp:TextBox>
                        </div>
                        <div class="col-md-2">
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
                        <div class="col-md-2">
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
                        <div class="col-md-2">
                            <label>Report Type</label>
                            <asp:DropDownList ID="ddlReportType" AutoPostBack="true" runat="server" CssClass="fstdropdown-select">
                                <asp:ListItem Value="0">Overall Report</asp:ListItem>
                                <asp:ListItem Value="1">Wardwise Report</asp:ListItem>
                                <asp:ListItem Value="2">Kothiwise Report</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <%--                        <div class="col-sm-2">
                            <div class="d-flex align-items-end h-100">
                                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-success btn-sm float-right mr-2" OnClientClick="return validateDateModal()" OnClick="btnSearch_Click" />
                            </div>
                        </div>--%>
                    </div>
                </div>
            </div>
        </section>

        <%--        <section class="filters-section">
            <div class="filters-container">
                <div class="title d-flex justify-content-between">
                    <div class="d-flex align-items-center">
                        <i class="fa-solid fa-book"></i>
                        <h3>Sweeper Attendance</h3>

                    </div>


                </div>
                <div class="body">
                    <div class="mx-2">

                    </div>
                    <div class="filters">

                        <div class="dropdown-wrapper d-block">
                            <h5>Zone Name</h5>

                        </div>

                        <div class="dropdown-wrapper d-block">
                            <h5>Ward Name</h5>

                        </div>

                        <div class="dropdown-wrapper d-block">
                            <h5>Kothi Name</h5>

                        </div>

                        <div class="date-wrapper">
                            <h5>FromDate</h5>
                        </div>

                        <div class="date-wrapper">
                            <h5>ToDate</h5>

                        </div>
                    </div>
                </div>
            </div>
        </section>--%>

        <asp:HiddenField ID="hiddenFielddataTableJsonZoneWise" runat="server" />
        <asp:HiddenField ID="hiddenFielddataTableJsonTotal" runat="server" />

        <asp:Panel ID="chartWrapper" runat="server" Visible="false">
            <%--<div class="container mt-2">
                <div class="row border rounded">
                    <div class="col-sm-6">
                        <div class="row">
                            <div class="col-12 bg-light border">
                                <h2 class="text-center text-secondary">City Wise</h2>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-12 border">
                                <div style="height: 400px" class="d-flex justify-content-center align-items-center position-relative">
                                    <canvas id="cityWise"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="row">
                            <div class="col-12 bg-light border">
                                <h2 class="text-center text-secondary">Zone Wise</h2>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-12 border">
                                <div style="height: 400px" class="d-flex justify-content-center align-items-center position-relative">
                                    <canvas id="zoneWise"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>--%>
        </asp:Panel>

        <asp:Panel ID="tableWrapper1" runat="server" Visible="false">
            <section class="sweeper-coverage-report-section">
                <div class="sweeper-coverage-report">
                    <div class="title dropdown-btn">
                        <div class="controls">
                            <div>
                                <h3 id="h1" runat="server">Ward Wise Attendance</h3>
                            </div>
                        </div>
                        <div class="text-danger d-flex align-items-center">
                            <asp:Label ID="Label3" runat="server" CssClass="mr-2"></asp:Label>
                            <asp:Label ID="Label4" runat="server"></asp:Label>
                        </div>
                        <div class="downloads d-flex align-items-center" id="div1" runat="server" visible="true">
                            <button type="button" class="btn btn-light toggler__btn p-1">
                                <i class="fa-solid fa-chevron-down"></i>
                            </button>
                        </div>
                    </div>

                    <div class="body collapsible active toggler__content">
                        <asp:GridView ID="grd_WardWise" runat="server" AutoGenerateColumns="true" CssClass="table-striped grd_WardWise">
                        </asp:GridView>
                    </div>
                </div>
            </section>
        </asp:Panel>

        <asp:Panel ID="tableWrapper2" runat="server" Visible="false">
            <section class="sweeper-coverage-report-section">
                <div class="sweeper-coverage-report">
                    <div class="title dropdown-btn">
                        <div class="controls">
                            <div>
                                <h3 id="h2" runat="server">Kothi Wise Attendance</h3>
                            </div>
                        </div>
                        <div class="text-danger d-flex align-items-center">
                            <asp:Label ID="Label1" runat="server" CssClass="mr-2"></asp:Label>
                            <asp:Label ID="Label2" runat="server"></asp:Label>
                        </div>
                        <div class="downloads d-flex align-items-center" id="div2" runat="server" visible="true">
                            <%--                            <asp:ImageButton ID="ImageButton1" src="Images/xls.png" runat="server" CssClass="mr-1" OnClick="ImgExl_Click" />
                            <asp:ImageButton ID="ImageButton2" src="Images/pdf.png" runat="server" CssClass="mr-1" OnClick="ImgPDF_Click" />--%>
                            <button type="button" class="btn btn-light toggler__btn p-1">
                                <i class="fa-solid fa-chevron-down"></i>
                            </button>
                        </div>
                    </div>

                    <div class="body collapsible active toggler__content">
                        <asp:GridView ID="grd_KothiWise" runat="server" AutoGenerateColumns="true" CssClass="table-striped grd_KothiWise">
                        </asp:GridView>
                    </div>
                </div>
            </section>
        </asp:Panel>

        <asp:Panel ID="tableWrapper3" runat="server" Visible="false">
            <section class="sweeper-coverage-report-section">
                <div class="sweeper-coverage-report">
                    <div class="title dropdown-btn">
                        <div class="controls">
                            <div>
                                <%-- <h2>Pune Municipal Corporation</h2>|--%>
                                <%--<h3 id="hheader" runat="server" visible="false" class="text-danger">Attendace Report <span>: From 
                                <asp:Label ID="lblFromDate" runat="server" Text="" CssClass="mx-1"></asp:Label>
                                to 
                                <asp:Label ID="lblEndDate" runat="server" Text="" CssClass="mx-1"></asp:Label></span></h3>--%>
                                <%--                                <asp:Button ButtonType="Button" ID="lblTotal" runat="server" Text="Total" CssClass="btn btn-info btn-sm float-right mr-2" />
                                <asp:Button ButtonType="Button" ID="lblPresent" runat="server" Text="Present" CssClass="btn btn-warning btn-sm float-right mr-2" />
                                <asp:Button ButtonType="Button" ID="lblRouteDeviated" runat="server" Text="Route Deviated" CssClass="btn btn-success btn-sm float-right mr-2" />
                                <asp:Button ButtonType="Button" ID="lblLeave_Holiday" runat="server" Text="Leave/Holiday" CssClass="btn btn-danger btn-sm float-right mr-2" />
                                <asp:Button ButtonType="Button" ID="lblAbsent" runat="server" Text="Absent" CssClass="btn btn-secondary text-white btn-sm float-right mr-2" />--%>
                                <%--<asp:Button ID="totalBtn" runat="server" CssClass="btn btn-secondary" />--%>
                                <%--<asp:Button ID="presentBtn" runat="server" CssClass="btn btn-secondary" />--%>
                                <%--<asp:Button ID="routeDeviatedBtn" runat="server" CssClass="btn btn-secondary" />--%>
                                <%--<asp:Button ID="leaveHolidayBtn" runat="server" CssClass="btn btn-secondary" />--%>
                                <%--<asp:Button ID="absentBtn" runat="server" CssClass="btn btn-secondary" />--%>
                            </div>
                        </div>
                        <%--                        <div class="text-danger d-flex align-items-center">
                            <asp:Label ID="lblTotalCount" runat="server" CssClass="mr-2"></asp:Label>
                            <asp:Label ID="lblTotalWaste" runat="server"></asp:Label>
                        </div>--%>
                        <div class="downloads d-flex align-items-center" id="divExport" runat="server" visible="true">
                            <%--                            <asp:ImageButton ID="ImgExl" src="Images/xls.png" runat="server" CssClass="mr-1" OnClick="ImgExl_Click" />
                            <asp:ImageButton ID="ImgPDF" src="Images/pdf.png" runat="server" CssClass="mr-1" OnClick="ImgPDF_Click" />--%>
                            <%--                            <button type="button" class="btn btn-light toggler__btn p-1">
                                <i class="fa-solid fa-chevron-down"></i>
                            </button>--%>
                        </div>

                        <div class="container-fluid P-0">
                            <div class="row">
                                <div class="col-md-auto">
                                    <h3>Pune Municipal Corporation</h3>
                                </div>
                                <div class="col-md-auto">
                                    <h3 id="hheader" runat="server" visible="false" class="text-danger">Attendace Report <span>: From 
                                <asp:Label ID="lblFromDate" runat="server" Text="" CssClass="mx-1"></asp:Label>
                                        to 
                                <asp:Label ID="lblEndDate" runat="server" Text="" CssClass="mx-1"></asp:Label></span></h3>
                                </div>
                                <div class="col-md-auto ml-auto">
                                        <asp:Button ID="totalBtn" runat="server" CssClass="btn btn-secondary btn-sm" Enabled="false" Text="Total:- 0" />
                                        <asp:Button ID="presentBtn" runat="server" CssClass="btn btn-secondary btn-sm" Enabled="false" Text="Present:- 0" />
                                        <asp:Button ID="routeDeviatedBtn" runat="server" CssClass="btn btn-secondary btn-sm" Enabled="false" Text="Route Deviated:- 0" />
                                        <asp:Button ID="leaveHolidayBtn" runat="server" CssClass="btn btn-secondary btn-sm" Enabled="false" Text="Leave/ Holiday:- 0" />
                                        <asp:Button ID="absentBtn" runat="server" CssClass="btn btn-secondary btn-sm" Enabled="false" Text="Absent:- 0" />
                                    <button type="button" class="btn btn-light toggler__btn1 p-1">
                                        <i class="fa-solid fa-chevron-down"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="body collapsible active toggler__content1">
                        <asp:GridView ID="grd_AttendanceReport" runat="server" AutoGenerateColumns="true" CssClass="table-striped grd_AttendanceReport">
                        </asp:GridView>
                    </div>
                </div>
            </section>
        </asp:Panel>

        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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

                initializeDataTable(".grd_AttendanceReport");
                initializeDataTable(".grd_KothiWise");
                initializeDataTable(".grd_WardWise");
            });
        </script>
        <script>
            $(document).ready(function () {
                function collapseContent(button) {
                    $(button).parent().parent().next().slideToggle("fast");
                }

                $(".toggler__btn").click(function () {
                    collapseContent(this);
                });

                $(".toggler__btn1").click(function () {
                    $('.toggler__content1').slideToggle('fast');
                });
            });
        </script>
        <script src="Scripts/fstdropdown.js"></script>
        <script>
            const dateInput = document.querySelectorAll('.date-wrapper input');
            const currentDate = new Date().toISOString().substr(0, 10);

            dateInput.forEach(input => {
                if (!input.value) {
                    input.value = currentDate;
                }
            });
        </script>
        <script src="Scripts/sweeperAttendanceChart.js"></script>
    </body>

</asp:Content>
