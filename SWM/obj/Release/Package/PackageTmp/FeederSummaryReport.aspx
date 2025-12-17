<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FeederSummaryReport.aspx.cs" Inherits="SWM.FeederSummaryReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css"
            rel="stylesheet" />
        <link rel="stylesheet" href="css/fstdropdown.css">
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
        <title>Feeder Summary Report</title>
        <style>
            .alternate-row {
                background-color: #f2f2f2;
            }
        </style>
        <style>
            /* Loading animation styles */
            .loading-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                z-index: 9999;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .loading-spinner {
                border: 4px solid #f3f3f3;
                border-top: 4px solid #3498db;
                border-radius: 50%;
                width: 40px;
                height: 40px;
                animation: spin 1s linear infinite;
            }

            @keyframes spin {
                0% {
                    transform: rotate(0deg);
                }

                100% {
                    transform: rotate(360deg);
                }
            }
        </style>
        <link href="css/global.css" rel="stylesheet" />
    </head>
    <body>

        <section class="filters-section">
            <div class="filters-container">
                <div class="title d-flex justify-content-between">
                    <div class="d-flex align-items-center">
                        <i class="fa-solid fa-book"></i>
                        <h3>Feeder Summary Report</h3>
                    </div>
                    <%--<asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" CssClass="btn btn-primary btn-sm float-right mr-2" />--%>
                </div>
                <div class="body">
                    <%--<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>--%>
                    <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>--%>
                    <%--                    <asp:RadioButton ID="rbMetric" runat="server" GroupName="measurementSystem" Text="Weekly"></asp:RadioButton>--%>
                    <%--<div class="container-fluid">
                        <div class="row">
                            <div class="form-check">
                                <asp:CheckBox ID="chbxWeekly" runat="server" Text="Weekly" AutoPostBack="true" OnCheckedChanged="chbxWeekly_CheckedChanged"/>
                            </div>
                        </div>
                    </div>--%>
                    <div class="filters">
                        <div class="dropdown-wrapper d-block">
                            <h5>Zone Name</h5>
                            <asp:DropDownList ID="ddlZone" runat="server" AutoPostBack="true" class="fstdropdown-select" OnSelectedIndexChanged="ddlZone_SelectedIndexChanged">
                            </asp:DropDownList>
                        </div>

                        <div class="dropdown-wrapper d-block">
                            <h5>Ward Name</h5>
                            <asp:DropDownList ID="ddlWard" runat="server" class="fstdropdown-select" AutoPostBack="True" OnSelectedIndexChanged="ddlWard_SelectedIndexChanged">
                            </asp:DropDownList>
                        </div>

                        <div class="dropdown-wrapper d-block">
                            <h5>Route Name</h5>
                            <asp:DropDownList ID="ddlRoute" runat="server" class="fstdropdown-select" AutoPostBack="true" OnSelectedIndexChanged="ddlRoute_SelectedIndexChanged">
                            </asp:DropDownList>
                        </div>

                        <div class="dropdown-wrapper d-block">
                            <h5>Vehicle Name</h5>
                            <asp:DropDownList ID="ddlVehicle" runat="server" class="fstdropdown-select">
                            </asp:DropDownList>
                        </div>

                        <div class="date-wrapper">
                            <h5>FromDate</h5>
                            <%--<input type="date" />--%>
                            <asp:TextBox ID="txtSdate" runat="server" type="date"></asp:TextBox>
                        </div>

                        <div class="date-wrapper">
                            <h5>ToDate</h5>
                            <%--<input type="date" />--%>
                            <asp:TextBox ID="txtEdate" runat="server" type="date"></asp:TextBox>
                        </div>

                        <div class="dropdown-wrapper d-block">
                            <h5>Month</h5>
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

                        <div class="dropdown-wrapper d-block">
                            <h5>Week</h5>
                            <asp:DropDownList ID="ddlWeek" AutoPostBack="true" runat="server" CssClass="fstdropdown-select" OnSelectedIndexChanged="ddlWeek_SelectedIndexChanged">
                                <asp:ListItem Value="0">Select</asp:ListItem>
                                <asp:ListItem Value="1">1st Week</asp:ListItem>
                                <asp:ListItem Value="2">2nd Week</asp:ListItem>
                                <asp:ListItem Value="3">3rd Week</asp:ListItem>
                                <asp:ListItem Value="4">4th Week</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="dropdown-wrapper d-block">
                            <h5>Quarterly/Half Yearly/Yearly</h5>
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

                        <div class="date-wrapper">
                            <div class="d-flex align-items-end h-100">
                                <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" CssClass="btn btn-success float-right mr-2" OnClientClick="return validateDateModal()" />
                            </div>
                        </div>
                    </div>
                    <%--  </ContentTemplate>
                    </asp:UpdatePanel>--%>
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
                            </div>
                        </div>
                    </div>

                    <div class="body collapsible active toggler__content">
                        <asp:GridView ID="total_table" runat="server" AutoGenerateColumns="false" EmptyDataText="No data found."
                            ShowFooter="true" class="table-striped table-feeder total_table">
                            <Columns>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Sr. No">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID1" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Total Feeder">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID2" runat="server"
                                            Text='<%#Eval("TOTAL_FEEDER")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Cover Feeder">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID3" runat="server"
                                            Text='<%#Eval("COVER_FEEDER")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Uncover Feeder">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID4" runat="server"
                                            Text='<%#Eval("UNCOVER_FEEDER")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Unattended Feeder">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID5" runat="server"
                                            Text='<%#Eval("UNATTENDED_FEEDER")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Percentage (%)">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID6" runat="server"
                                            Text='<%#Eval("PERCENT_COVER")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
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
                            <h3 id="hheader" runat="server" visible="false" class="text-danger">Feeder Summary Report <span>: From 
                                <asp:Label ID="lblFromDate" runat="server" Text="" CssClass="mx-1"></asp:Label>
                                to 
                                <asp:Label ID="lblEndDate" runat="server" Text="" CssClass="mx-1"></asp:Label></span></h3>
                            </div>
                        </div>

                        <div class="downloads d-flex align-items-center" id="divExport" runat="server" visible="false">
                            <%-- <asp:ImageButton ID="imgxls" src="Images/xls.png" runat="server" OnClick="imgxls_Click" CssClass="mr-1" />
                            <asp:ImageButton ID="imgpdf" src="Images/pdf.png" runat="server" OnClick="imgpdf_Click" CssClass="mr-1" />--%>
                            <button type="button" class="btn btn-light toggler__btn p-1">
                                <i class="fa-solid fa-chevron-down"></i>
                            </button>
                        </div>
                    </div>

                    <div class="body collapsible active toggler__content">
                        <div class="container-fluid">
                            <div class="row mb-2 justify-content-between">
                                <div class="col-md-2">
                                    <button type="button" class="btn btn-sm btn-secondary position-relative">
                                        Total Feeder
                                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" id="totalFeederCount" runat="server">99+
                                            <span class="visually-hidden"></span>
                                        </span>
                                    </button>
                                </div>
                                <div class="col-md-2">
                                    <button type="button" class="btn btn-sm btn-secondary position-relative">
                                        Cover Feeder
                                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" id="coverFeederCount" runat="server">99+
                                            <span class="visually-hidden"></span>
                                        </span>
                                    </button>
                                </div>
                                <div class="col-md-2">
                                    <button type="button" class="btn btn-sm btn-secondary position-relative">
                                        Uncover Feeder
                                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" id="uncoverFeederCount" runat="server">99+
                                            <span class="visually-hidden"></span>
                                        </span>
                                    </button>
                                </div>
                                <div class="col-md-2">
                                    <button type="button" class="btn btn-sm btn-secondary position-relative">
                                        Unattended Feeder
                                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" id="unattendedFeederCount" runat="server">99+
                                            <span class="visually-hidden"></span>
                                        </span>
                                    </button>
                                </div>
                                <div class="col-md-2">
                                    <button type="button" class="btn btn-sm btn-secondary position-relative">
                                        Percentage %
                                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" id="percentageCount" runat="server">99+
                                            <span class="visually-hidden"></span>
                                        </span>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <asp:GridView ID="grd_Report1" runat="server" AutoGenerateColumns="false" EmptyDataText="No data found."
                            ShowFooter="true" class="table-striped table-feeder grd_Report1">
                            <Columns>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Sr. No">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID1" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Date">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID2" runat="server"
                                            Text='<%#Eval("DATE")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Zone">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID3" runat="server"
                                            Text='<%#Eval("ZONE")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Ward">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID4" runat="server"
                                            Text='<%#Eval("WARD")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Route">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID5" runat="server"
                                            Text='<%#Eval("ROUTE")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Vehicle">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID6" runat="server"
                                            Text='<%#Eval("VEHICLE")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Total Feeder">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID7" runat="server"
                                            Text='<%#Eval("TOTAL_FEEDER")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Cover Feeder">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID" runat="server"
                                            Text='<%#Eval("COVER_FEEDER")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Uncover Feeder">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID8" runat="server"
                                            Text='<%#Eval("UNCOVER_FEEDER")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Unattended Feeder">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID9" runat="server"
                                            Text='<%#Eval("UNATTENDED_FEEDER")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Cover %">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID10" runat="server"
                                            Text='<%#Eval("PERCENT_COVER")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="100px" HeaderText="View Route">
                                    <ItemTemplate>
                                        <asp:LinkButton CssClass="btn btn-sm btn-info" ID="LnkView" runat="server" Text="View Route" CommandName="ViewImages" OnClick="LnkView_Click"
                                            CommandArgument='<%# Eval("FK_VEHICLEID") + "|" + Eval("DATE") + "|" + Eval("FK_RID") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>

                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </section>
        </asp:Panel>

        <%-- Popup Modal Section --%>
        <section>
            <button type="button" id="modalBtn" hidden class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
                Launch demo modal
            </button>
            <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content w-100">
                        <div class="modal-header border-bottom-0 px-2 pb-0 pt-1">
                            <button type="button" class="close" style="outline: none;" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <center>
                                <p class="text-danger font-weight-bold">Warning:- <span class="text-dark">From Date cannot be greater than To Date</span></p>
                            </center>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <%-- Popup Modal Section End--%>

        <script src="Scripts/fstdropdown.js"></script>
        <script>
            $(document).ready(function () {
                function collapseContent(button, content) {
                    $(button).click(function () {
                        $(content).slideToggle("fast");
                    });
                }

                collapseContent(".toggler__btn", ".toggler__content");
            });
        </script>
        <script>

            //$(document).ready(function () {
            //    $(".grd_Report1").prepend($("<thead></thead>").append($(this).find("tr:first"))).DataTable({
            //        pageLength: 5,
            //        language: {
            //            lengthMenu: "_MENU_  records per page",
            //            sSearch: "<img src='Images/search.png' />",
            //            paginate: {
            //                first: "First",
            //                last: "Last",
            //                next: "Next &rarr;",
            //                previous: "&larr; Previous",
            //            },
            //        },
            //        lengthMenu: [
            //            [5, 10, 25, 50, -1],
            //            [5, 10, 25, 50, "All"],
            //        ],
            //        columnDefs: [
            //            { type: 'num', targets: [0, 2] }, // Numeric sorting for columns 0 and 1.
            //            { type: 'string', targets: [1, 3] } // Alphanumeric sorting for columns 2 and 3.
            //        ],
            //        order: [0, 1, 2, 3, 4, 5, 6],
            //        footerCallback: function (row, data, start, end, display) {
            //            // Remove the last row from the table footer (if it exists)
            //            var table = $(this);
            //            var lastRow = table.find("tfoot tr:last-child");
            //            if (lastRow.length > 0) {
            //                lastRow.remove();
            //            }
            //        },
            //    });
            //});

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
                                title: 'Feeder Summary Report' + ' - ' + getFormattedDate(),
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

                initializeDataTable(".grd_Report1");
                initializeDataTable(".total_table");
            });
        </script>
        <script>
            const dateInputs = document.querySelectorAll('.filters .date-wrapper input');
            const currentDate = new Date().toISOString().substr(0, 10);

            dateInputs.forEach(input => {
                if (!input.value) {
                    input.value = currentDate;
                }
            });
        </script>

        <script type="text/javascript">
            $(document).ready(function () {
                $("#ddlZone").change(function () {
                    var selectedValue = $(this).val();
                    var selectedText = $(this).find("option:selected").text();

                    // Perform AJAX request to handle the selection change
                    $.ajax({
                        type: "POST",
                        url: "FeederSummaryReport.aspx/HandleSelectionChange",
                        data: JSON.stringify({ value: selectedValue, text: selectedText }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            // Handle the response if needed
                        },
                        error: function (xhr, status, error) {
                            // Handle the error if needed
                        }
                    });
                });
            });
        </script>
        <%--        <script>
            $(document).ready(function () {
                $('#<%= btnSearch.ClientID %>').click(function () {
                    showLoadingOverlay();
                });
            });

            function showLoadingOverlay() {
                var loadingOverlay = document.createElement('div');
                loadingOverlay.className = 'loading-overlay';
                loadingOverlay.innerHTML = '<div class="loading-spinner"></div>';

                document.body.appendChild(loadingOverlay);
            }
        </script>--%>
        <script>
            function validateDateModal() {
                const fromDate = new Date(document.getElementById('<%= txtSdate.ClientID %>').value);
                const toDate = new Date(document.getElementById('<%= txtEdate.ClientID %>').value);

                if (fromDate > toDate) {
                    const modalBtn = document.getElementById('modalBtn').click();
                    return false;
                }

                return true;
            }
        </script>
    </body>
</asp:Content>
