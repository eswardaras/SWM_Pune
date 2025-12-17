<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SweeperAttendanceSummary.aspx.cs" Inherits="SWM.SweeperAttendanceSummary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <head>
        <script
            src="https://kit.fontawesome.com/e8c1c6e963.js"
            crossorigin="anonymous"></script>

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
        <link href="css/fstdropdown.css" rel="stylesheet" />
    </head>
    <body>

        <section class="filters-section">
            <div class="filters-container">
                <div class="title d-flex justify-content-between">
                    <div class="d-flex align-items-center">
                        <i class="fa-solid fa-book"></i>
                        <h3>Sweeper Attendance Summary</h3>
                    </div>
                </div>
                <div class="body">
                    <div class="px-2 d-none">
                        <asp:RadioButtonList runat="server">
                            <asp:ListItem Selected="True" Text="Monthly"></asp:ListItem>
                        </asp:RadioButtonList>
                    </div>
<%--                    <div class="row px-3">
                        <asp:RadioButtonList RepeatDirection="Horizontal" runat="server" ID="rbtAttendance" CssClass="w-auto asp_radioButtons">
                            <asp:ListItem Selected="True" Text="Sweeper"></asp:ListItem>
                            <asp:ListItem Text="Mokadam"></asp:ListItem>
                        </asp:RadioButtonList>
                    </div>--%>
                    <div class="row px-3 pb-3">
                        <div class="col-sm-2">
                            <label>Zone Name</label>
                            <asp:DropDownList ID="ddlZone" runat="server" AutoPostBack="true" class="fstdropdown-select" OnSelectedIndexChanged="ddlZone_SelectedIndexChanged">
                                <asp:ListItem Text="Select" Value="" />
                            </asp:DropDownList>
                        </div>
                        <div class="col-sm-2">
                            <label>Ward Name</label>
                            <asp:DropDownList ID="ddlWard" runat="server" class="fstdropdown-select" AutoPostBack="True" OnSelectedIndexChanged="ddlWard_SelectedIndexChanged">
                                <asp:ListItem Text="Select" Value="" />
                            </asp:DropDownList>
                        </div>
                        <div class="col-sm-2">
                            <label>Kothi Name</label>
                            <asp:DropDownList ID="ddlKothi" runat="server" class="fstdropdown-select" AutoPostBack="True" OnSelectedIndexChanged="ddlKothi_SelectedIndexChanged">
                                <asp:ListItem Text="Select" Value="" />
                            </asp:DropDownList>
                        </div>
                        <div class="col-sm-2">
                            <label>Sweeper Name</label>
                            <asp:DropDownList ID="ddlSweeper" runat="server" class="fstdropdown-select" AutoPostBack="True">
                                <asp:ListItem Text="Select" Value="" />
                            </asp:DropDownList>
                        </div>
                        <div class="col-sm-2">
                            <label>Month</label>
                            <asp:DropDownList ID="ddlMonth" runat="server" CssClass="fstdropdown-select" OnSelectedIndexChanged="ddlMonth_SelectedIndexChanged">
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
                            <label>Year</label>
                            <asp:DropDownList ID="ddlYear" runat="server" CssClass="fstdropdown-select">
                                <%--                                <asp:ListItem Value="0">2023</asp:ListItem>
                                <asp:ListItem Value="1" Selected="True">2024</asp:ListItem>--%>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="row px-3 pb-3">
                        <div class="col-sm-2">
                            <label>Employment Type</label>
                            <asp:DropDownList ID="ddlEmpType" runat="server" CssClass="fstdropdown-select">
                                <asp:ListItem Value="0">All</asp:ListItem>
                                <asp:ListItem Value="Permanent">Permanent</asp:ListItem>
                                <asp:ListItem Value="Contract">Contract</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-sm-2">
                            <div class="d-flex align-items-end h-100">
                                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-success float-right mr-2" OnClientClick="return validateDateModal()" OnClick="btnSearch_Click" />
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
                            <h3 id="hheader" runat="server" visible="false" class="text-danger">Attendace Summary Report <span>: From 
                                <asp:Label ID="lblFromDate" runat="server" Text="" CssClass="mx-1"></asp:Label>
                                to 
                                <asp:Label ID="lblEndDate" runat="server" Text="" CssClass="mx-1"></asp:Label></span></h3>
                            </div>
                        </div>
                        <div class="text-danger d-flex align-items-center">
                            <asp:Label ID="lblTotalCount" runat="server" CssClass="mr-2"></asp:Label>
                            <asp:Label ID="lblTotalWaste" runat="server"></asp:Label>
                        </div>
                        <div class="downloads d-flex align-items-center" id="divExport" runat="server" visible="true">
                            <asp:ImageButton ID="ImageButton1" src="Images/xls.png" runat="server" CssClass="mr-1" OnClick="ImageButton1_Click" />
                            <asp:ImageButton ID="ImgPDF" src="Images/pdf.png" runat="server" CssClass="mr-1" OnClick="ImgPDF_Click" />
                            <button type="button" class="btn btn-light toggler__btn p-1">
                                <i class="fa-solid fa-chevron-down"></i>
                            </button>
                        </div>
                    </div>

                    <div class="body collapsible active toggler__content">
                        <asp:GridView ID="grd_AttendanceSummary" runat="server" AutoGenerateColumns="true" CssClass="table-striped grd_AttendanceSummary">
                        </asp:GridView>
                    </div>
                </div>
            </section>

        </asp:Panel>

        <script>
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
                        columnDefs: [
                            { type: 'num', targets: [0, 1, 2] }, // Numeric sorting for columns 0 and 1.
                            { type: 'string', targets: [0, 1, 2] } // Alphanumeric sorting for columns 2 and 3.
                        ],
                        order: [0, 1, 2],
                    });
                }

                initializeDataTable(".grd_AttendanceSummary");
            });

            //$(document).ready(function () {
            //    function initializeDataTable(tableElement) {
            //        $(tableElement).prepend($("<thead></thead>").append($(tableElement).find("tr:first"))).DataTable({
            //            pageLength: 5,
            //            dom:
            //                "<'row'<'col-sm-12 col-md-6'B><'col-sm-12 col-md-6'f>>" +
            //                "<'row'<'col-sm-12'tr>>" +
            //                "<'row justify-content-between'<'col-sm-12 col-md-auto d-flex align-items-center'l><'col-sm-12 col-md-auto'i><'col-sm-12 col-md-auto'p>>",
            //            buttons: [
            //                {
            //                    extend: "excelHtml5",
            //                    text: "Excel <i class='fas fa-file-excel text-white'></i>",
            //                    title: document.title + ' - ' + getFormattedDate(),
            //                    className: "btn btn-sm btn-success mb-2", // Add your Excel button class here
            //                },
            //                {
            //                    extend: "pdf",
            //                    text: "PDF <i class='fa-regular fa-file-pdf text-white'></i>",
            //                    title: 'Sweeper Attendance Report' + ' - ' + getFormattedDate(),
            //                    className: "btn btn-sm btn-danger mb-2", // Add your Excel button class here
            //                    customize: function (doc) {
            //                        // Set custom page size (width x height)
            //                        doc.pageOrientation = "landscape"; // or "portrait" for portrait orientation
            //                        doc.pageSize = "A4"; // or an array: [width, height]

            //                        // Set custom margins (left, right, top, bottom)
            //                        doc.pageMargins = [20, 20, 20, 20];
            //                    },
            //                },
            //                // "pdf",
            //                // "csvHtml5",
            //            ],
            //            language: {
            //                lengthMenu: "_MENU_  records per page",
            //                sSearch: "<img src='Images/search.png' alt='search'>",
            //                paginate: {
            //                    first: "First",
            //                    last: "Last",
            //                    next: "Next &rarr;",
            //                    previous: "&larr; Previous",
            //                },
            //            },
            //            lengthMenu: [
            //                [5, 10, 25, 50, -1],
            //                [5, 10, 25, 50, "All"],
            //            ],
            //            order: [0, 1, 2],
            //        });
            //    }

            //    function getFormattedDate() {
            //        const today = new Date();
            //        const options = { year: 'numeric', month: 'short', day: 'numeric' };
            //        return today.toLocaleDateString('en-US', options);
            //    }

            //    initializeDataTable(".grd_AttendanceSummary");
            //});
        </script>
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
        <script src="Scripts/fstdropdown.js"></script>
    </body>
</asp:Content>
