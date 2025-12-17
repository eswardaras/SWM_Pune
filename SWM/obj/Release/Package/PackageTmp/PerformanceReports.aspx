<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PerformanceReports.aspx.cs" Inherits="SWM.PerformanceReports" %>

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

        <script src="http://code.jquery.com/jquery-3.3.1.min.js"
            integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
            crossorigin="anonymous"></script>
        <link rel="stylesheet"
            href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css" />
        <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
        <!-- Bootstrap links end -->
        <title>Performance Reports</title>
        <%--<link rel="stylesheet" href="css/coveragereport.css">--%>
        <link href="css/global.css" rel="stylesheet" />
    </head>
    <body>

        <section class="filters-section">
            <div class="filters-container">
                <div class="title d-flex justify-content-between">
                    <div class="d-flex align-items-center">
                        <i class="fa-solid fa-book"></i>
                        <h3>Performance Report</h3>
                    </div>
                </div>
                <div class="body">
                    <div class="row px-3 pb-3">
                        <div class="col-sm-2">
                            <label>Reports Name</label>
                            <asp:DropDownList ID="ddlReportsName" runat="server" class="fstdropdown-select">
                                <asp:ListItem Text="Daily Odometer"></asp:ListItem>
                                <asp:ListItem Text="Drive Summary"></asp:ListItem>
                                <asp:ListItem Text="Trip"></asp:ListItem>
                                <asp:ListItem Text="Vehicle Summary"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
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
                    </div>
                    <div class="row px-3 pb-3">
                        <div class="col-sm-2">
                            <label>Start Time</label>
                            <asp:DropDownList ID="ddlSTime" runat="server" class="fstdropdown-select">
                                <asp:ListItem Selected="True" Text="01:00"></asp:ListItem>
                                <asp:ListItem Text="02:00"></asp:ListItem>
                                <asp:ListItem Text="03:00"></asp:ListItem>
                                <asp:ListItem Text="04:00"></asp:ListItem>
                                <asp:ListItem Text="05:00"></asp:ListItem>
                                <asp:ListItem Text="06:00"></asp:ListItem>
                                <asp:ListItem Text="07:00"></asp:ListItem>
                                <asp:ListItem Text="08:00"></asp:ListItem>
                                <asp:ListItem Text="09:00"></asp:ListItem>
                                <asp:ListItem Text="10:00"></asp:ListItem>
                                <asp:ListItem Text="11:00"></asp:ListItem>
                                <asp:ListItem Text="12:00"></asp:ListItem>
                                <asp:ListItem Text="13:00"></asp:ListItem>
                                <asp:ListItem Text="14:00"></asp:ListItem>
                                <asp:ListItem Text="15:00"></asp:ListItem>
                                <asp:ListItem Text="16:00"></asp:ListItem>
                                <asp:ListItem Text="17:00"></asp:ListItem>
                                <asp:ListItem Text="18:00"></asp:ListItem>
                                <asp:ListItem Text="19:00"></asp:ListItem>
                                <asp:ListItem Text="20:00"></asp:ListItem>
                                <asp:ListItem Text="21:00"></asp:ListItem>
                                <asp:ListItem Text="22:00"></asp:ListItem>
                                <asp:ListItem Text="23:00"></asp:ListItem>
                                <asp:ListItem Text="24:00"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-sm-2">
                            <label>End Time</label>
                            <asp:DropDownList ID="ddlETime" runat="server" class="fstdropdown-select">
                                <asp:ListItem Text="01:00"></asp:ListItem>
                                <asp:ListItem Text="02:00"></asp:ListItem>
                                <asp:ListItem Text="03:00"></asp:ListItem>
                                <asp:ListItem Text="04:00"></asp:ListItem>
                                <asp:ListItem Text="05:00"></asp:ListItem>
                                <asp:ListItem Text="06:00"></asp:ListItem>
                                <asp:ListItem Text="07:00"></asp:ListItem>
                                <asp:ListItem Text="08:00"></asp:ListItem>
                                <asp:ListItem Text="09:00"></asp:ListItem>
                                <asp:ListItem Text="10:00"></asp:ListItem>
                                <asp:ListItem Text="11:00"></asp:ListItem>
                                <asp:ListItem Text="12:00"></asp:ListItem>
                                <asp:ListItem Text="13:00"></asp:ListItem>
                                <asp:ListItem Text="14:00"></asp:ListItem>
                                <asp:ListItem Text="15:00"></asp:ListItem>
                                <asp:ListItem Text="16:00"></asp:ListItem>
                                <asp:ListItem Text="17:00"></asp:ListItem>
                                <asp:ListItem Text="18:00"></asp:ListItem>
                                <asp:ListItem Text="19:00"></asp:ListItem>
                                <asp:ListItem Text="20:00"></asp:ListItem>
                                <asp:ListItem Text="21:00"></asp:ListItem>
                                <asp:ListItem Text="22:00"></asp:ListItem>
                                <asp:ListItem Text="23:00"></asp:ListItem>
                                <asp:ListItem Selected="True" Text="24:00"></asp:ListItem>
                            </asp:DropDownList>
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
                        <div class="col-sm-2">
                            <div class="d-flex align-items-end h-100">
                                <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" CssClass="btn btn-success float-right mr-2" OnClientClick="return validateDateModal()" />
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
                            <h3 id="hheader" runat="server" visible="false" class="text-danger">
                                <asp:Label ID="lblReportName" runat="server" Text=""></asp:Label>
                                <span>: From 
                                <asp:Label ID="lblFromDate" runat="server" Text="" CssClass="mx-1"></asp:Label>
                                    to 
                                <asp:Label ID="lblEndDate" runat="server" Text="" CssClass="mx-1"></asp:Label></span></h3>
                            </div>
                        </div>

                        <div class="downloads d-flex align-items-center" id="divExport" runat="server" visible="false">
                            <asp:ImageButton ID="imgxls" src="Images/xls.png" runat="server" OnClick="imgxls_Click" CssClass="mr-1" />
                            <asp:ImageButton ID="imgpdf" src="Images/pdf.png" runat="server" OnClick="imgpdf_Click" CssClass="mr-1" />
                            <button type="button" class="btn btn-light toggler__btn p-1">
                                <i class="fa-solid fa-chevron-down"></i>
                            </button>
                        </div>
                    </div>

                    <div class="body collapsible active toggler__content">
                        <asp:GridView ID="grd_DailyOdometer" runat="server" AutoGenerateColumns="false" OnRowDataBound="grd_DailyOdometer_RowDataBound" ShowFooter="true" class="table-striped dailyOdometer" Visible="false">
                            <Columns>
                            </Columns>
                        </asp:GridView>

                        <asp:GridView ID="grd_DriveSummary" runat="server" AutoGenerateColumns="false" ShowFooter="true" class="table-striped driveSummary" Visible="false" EmptyDataText="No Data Found">
                            <Columns>
                                <%-- <asp:TemplateField ItemStyle-Width="30px" HeaderText="Sr.No">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID" runat="server"
                                            Text="1"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>--%>

                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Drive No">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID" runat="server"
                                            Text='<%#Eval("Drive No")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Vehicle Name">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID" runat="server"
                                            Text='<%#Eval("Vehicle Name")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Start Location">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID" runat="server"
                                            Text='<%#Eval("Start Location")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="End Location">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID" runat="server"
                                            Text='<%#Eval("End Location")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="StartTime">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID" runat="server"
                                            Text='<%#Eval("StartTime")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="EndTime">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID" runat="server"
                                            Text='<%#Eval("EndTime")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Duration">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID" runat="server"
                                            Text='<%#Eval("Duration")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Kms Travelled">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID" runat="server"
                                            Text='<%#Eval("Kms Travelled")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Ideal Time">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID" runat="server"
                                            Text='<%#Eval("Ideal Time")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                            </Columns>
                        </asp:GridView>

                        <asp:GridView ID="grid_Trip" runat="server" AutoGenerateColumns="false" ShowFooter="true" class="table-striped table-trip gridTrip" Visible="false" EmptyDataText="No Data Found">
                            <Columns>
                                <%-- <asp:TemplateField ItemStyle-Width="30px" HeaderText="Sr.No">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID" runat="server"
                                            Text="1"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>--%>

                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Date">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID" runat="server"
                                            Text='<%#Eval("Date")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Vehicle">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID" runat="server"
                                            Text='<%#Eval("Vehicle")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Trip No.">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID" runat="server"
                                            Text='<%#Eval("Trip No.")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Start Time">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID" runat="server"
                                            Text='<%#Eval("Start Time")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Start Location">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID" runat="server"
                                            Text='<%#Eval("Start Location")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="End Location">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID" runat="server"
                                            Text='<%#Eval("End Location")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Total Km">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID" runat="server"
                                            Text='<%#Eval("Total Km")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Working Hours">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID" runat="server"
                                            Text='<%#Eval("Working Hours")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Total Feeders">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID" runat="server"
                                            Text='<%#Eval("Total Feeders")%>'></asp:Label>
                                    </ItemTemplate>

                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Covered Feeder">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID" runat="server"
                                            Text='<%#Eval("Covered Feeder")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Covered Feeder Name">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID" runat="server"
                                            Text='<%#Eval("Covered Feeder Name")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Wt Collected">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID" runat="server"
                                            Text='<%#Eval("Wt Collected")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                            </Columns>
                        </asp:GridView>

                        <asp:GridView ID="grd_VehicleSummary" runat="server" AutoGenerateColumns="false" ShowFooter="true" class="table-striped vehicleSummary" Visible="false" EmptyDataText="No Data Found">
                            <HeaderStyle CssClass="thead-dark" />
                            <Columns>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Sr.No">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Date">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID" runat="server"
                                            Text='<%#Eval("Date")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Vehicle">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID" runat="server"
                                            Text='<%#Eval("Vehicle")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Start At">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID" runat="server"
                                            Text='<%#Eval("Start At")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Start Time">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID" runat="server"
                                            Text='<%#Eval("Start Time")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Running Time">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID" runat="server"
                                            Text='<%#Eval("Running Time")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Waiting Time">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID" runat="server"
                                            Text='<%#Eval("Waiting Time")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Engine Off Time">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID" runat="server"
                                            Text='<%#Eval("Engine Off Time")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Engine On Time">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID" runat="server"
                                            Text='<%#Eval("Engine On Time")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Max Speed">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID" runat="server"
                                            Text='<%#Eval("Max Speed")%>'></asp:Label>
                                    </ItemTemplate>

                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="End At">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID" runat="server"
                                            Text='<%#Eval("End At")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="End Time">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID" runat="server"
                                            Text='<%#Eval("End Time")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Total Kms">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID" runat="server"
                                            Text='<%#Eval("Total Kms")%>'></asp:Label>
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

                initializeDataTable(".dailyOdometer");
                initializeDataTable(".driveSummary");
                initializeDataTable(".gridTrip");
                initializeDataTable(".vehicleSummary");
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
    </body>
</asp:Content>
