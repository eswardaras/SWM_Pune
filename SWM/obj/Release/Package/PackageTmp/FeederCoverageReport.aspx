<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FeederCoverageReport.aspx.cs" Inherits="SWM.FeederCoverageReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css"
            rel="stylesheet" />
        <link rel="stylesheet" href="css/fstdropdown.css">
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
        <!-- Bootstrap links -->
        <%--   <link rel="stylesheet"
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
        <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>--%>
        <!-- Bootstrap links end -->
        <title>Feeder Coverage Report</title>
        <%--<link rel="stylesheet" href="css/coveragereport.css">--%>
        <link href="css/global.css" rel="stylesheet" />
    </head>

    <section class="filters-section">
        <div class="filters-container">
            <div class="title d-flex justify-content-between">
                <div class="d-flex align-items-center">
                    <i class="fa-solid fa-book"></i>
                    <h3>Feeder Coverage Report</h3>
                </div>
            </div>
            <div class="body">
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
                        <label>Vehicle Name</label>
                        <asp:DropDownList ID="ddlVehicle" runat="server" class="fstdropdown-select">
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
                        <div class="d-flex align-items-end h-100">
                            <asp:Button ID="Button1" runat="server" Text="Search" OnClick="btnSearch_Click" CssClass="btn btn-success float-right mr-2" OnClientClick="return validateDateModal()" />
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
                            <h3 id="hheader" runat="server" visible="false" class="text-danger">Feeder Coverage Report <span>: From 
                                <asp:Label ID="lblFromDate" runat="server" Text="" CssClass="mx-1"></asp:Label>
                                to 
                                <asp:Label ID="lblEndDate" runat="server" Text="" CssClass="mx-1"></asp:Label></span></h3>

                            <button type="button" class="btn btn-primary mx-2">
                                All <span id="spnAll" runat="server" class="badge badge-light">9</span>
                            </button>
                            <button type="button" class="btn btn-success">
                                Early <span id="spnEarly" runat="server" class="badge badge-light">9</span>
                            </button>
                            <button type="button" class="btn btn-danger mx-2">
                                Late <span id="spnLate" runat="server" class="badge badge-light">9</span>
                            </button>
                        </div>
                    </div>

                    <div class="downloads d-flex align-items-center" id="divExport" runat="server">
                        <asp:ImageButton ID="ImageButton1" src="Images/xls.png" runat="server" OnClick="imgxls_Click" CssClass="mr-1" />
                        <asp:ImageButton ID="ImageButton2" src="Images/pdf.png" runat="server" OnClick="imgpdf_Click" CssClass="mr-1" />
                        <button type="button" class="btn btn-light toggler__btn p-1">
                            <i class="fa-solid fa-chevron-down"></i>
                        </button>
                    </div>

                </div>

                <div class="body collapsible active toggler__content">
                    <%--  <asp:GridView ID="grd_Report" runat="server" AutoGenerateColumns="false" ShowFooter="true" CssClass="table-striped feederCoverage" EmptyDataText="No data found.">
                        <HeaderStyle CssClass="thead-dark" />
                        <Columns>
                            <asp:TemplateField ItemStyle-Width="30px" HeaderText="Sr.No">

                                <ItemTemplate>
                                    <asp:Label ID="lblID" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField ItemStyle-Width="100px" HeaderText="Date">
                                <ItemTemplate>
                                    <asp:Label ID="lblDate" runat="server" Text='<%#Eval("date")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-Width="100px" HeaderText="Zone Name">
                                <ItemTemplate>
                                    <asp:Label ID="lblZoneName" runat="server" Text='<%#Eval("zonename")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-Width="100px" HeaderText="Ward Name">
                                <ItemTemplate>
                                    <asp:Label ID="lblWardName" runat="server" Text='<%#Eval("wardname")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-Width="100px" HeaderText="Vehicle Name">
                                <ItemTemplate>
                                    <asp:Label ID="lblVehicleName" runat="server" Text='<%#Eval("Vehiclename")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-Width="100px" HeaderText="Total Feeder">
                                <ItemTemplate>
                                    <asp:Label ID="lblTotalFeeder" runat="server" Text='<%#Eval("Count")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-Width="100px" HeaderText="Expected Feeder">
                                <ItemTemplate>
                                    <asp:Label ID="lblExpectedFeeder" runat="server" Text='<%#Eval("Count")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-Width="100px" HeaderText="Status">
                                <ItemTemplate>
                                    <asp:Label ID="lblStatus" runat="server" Text='<%#Eval("Status")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>

                    </asp:GridView>--%>
                    <%--  <asp:GridView ID="grd_WardWise" runat="server" AutoGenerateColumns="true" CssClass="table-striped grd_WardWise">
                        </asp:GridView>--%>
                    <%--  <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="true" ShowFooter="true" CssClass="table-striped feederCoverage" EmptyDataText="No data found.">
                        <HeaderStyle CssClass="thead-dark" />
                    </asp:GridView>--%>
                    <%--                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" AllowPaging="True" PageSize="20" EmptyDataText="No data found." OnPageIndexChanging="grd_Report_PageIndexChanging" CssClass="grdReport">--%>
                    <asp:GridView ID="grd_Report" runat="server" AutoGenerateColumns="false" CssClass="grdReport">
                        <Columns>
                            <asp:BoundField DataField="DATE" HeaderText="Date" />
                            <asp:BoundField DataField="ZONENAME" HeaderText="ZoneName" />
                            <asp:BoundField DataField="WARDNAME" HeaderText="Wardname" />
                            <asp:BoundField DataField="ROUTENAME" HeaderText="RouteName" />
                            <asp:BoundField DataField="VEHICLENAME" HeaderText="VehicleName" />
                            <asp:BoundField DataField="FEEDERNAME" HeaderText="FeederName" />
                            <asp:BoundField DataField="EXPECTEDTIME" HeaderText="ExpectedTime" />
                            <asp:BoundField DataField="ACTUALTIME" HeaderText="ActualTime" />
                            <asp:BoundField DataField="TIMEDIFF" HeaderText="timediff" />
                            <asp:BoundField DataField="STATUS" HeaderText="status" />
                        </Columns>
                    </asp:GridView>
                    <%-- <asp:GridView ID="grd_Report" runat="server" AutoGenerateColumns="true" ShowFooter="true" AllowPaging="True" PageSize="20" EmptyDataText="No data found.">
                        <HeaderStyle CssClass="thead-dark" />
                    </asp:GridView>--%>
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
                            title: 'Feeder Coverage Report' + ' - ' + getFormattedDate(),
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

            initializeDataTable(".grdReport");
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

</asp:Content>
