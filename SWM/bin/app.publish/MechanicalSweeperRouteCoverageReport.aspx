<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MechanicalSweeperRouteCoverageReport.aspx.cs" Inherits="SWM.MechanicalSweeperRouteCoverageReport" %>

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
        <title>Mechanical Sweeper Route Coverage Report</title>
        <link href="css/global.css" rel="stylesheet" />
    </head>

    <body>

        <asp:HiddenField ID="hiddenFielddataTableJsonCityWise" runat="server" />
        <asp:HiddenField ID="hiddenFielddataTableJsonZoneWise" runat="server" />
        <asp:HiddenField ID="hiddenFielddataTableJsonCityWiseRouteCovered" runat="server" />
        <asp:HiddenField ID="hiddenFielddataTableJsonZoneWiseRouteCovered" runat="server" />

        <section class="filters-section">
            <div class="filters-container">
                <div class="title d-flex justify-content-between">
                    <div class="d-flex align-items-center">
                        <i class="fa-solid fa-book"></i>
                        <h3>Mechanical Sweeper Route Coverage Report</h3>
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
                            <label>Mechanical Sweeper</label>
                            <asp:DropDownList ID="ddlMechanical" runat="server" class="fstdropdown-select">
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
                            <div class="d-flex align-items-end h-100">
                                <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" CssClass="btn btn-success btn-sm float-right mr-2" OnClientClick="return validateDateModal()" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <asp:Panel ID="chartWrapper" runat="server" Visible="false">
            <div class="container mt-2">
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
                <div class="row border rounded mt-3">
                    <div class="col-sm-6">
                        <div class="row">
                            <div class="col-12 bg-light border">
                                <h2 class="text-center text-secondary">City Wise Route Covered(KM)</h2>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-12 border">
                                <div style="height: 400px" class="d-flex justify-content-center align-items-center position-relative">
                                    <canvas id="cityWiseRoute"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="row">
                            <div class="col-12 bg-light border">
                                <h2 class="text-center text-secondary">Zone Wise Route Covered(KM)</h2>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-12 border">
                                <div style="height: 400px" class="d-flex justify-content-center align-items-center position-relative">
                                    <canvas id="zoneWiseRoute"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </asp:Panel>

        <asp:Panel ID="tableWrapper" runat="server" Visible="false">
            <section class="sweeper-coverage-report-section">
                <div class="sweeper-coverage-report">
                    <div class="title dropdown-btn">
                        <div class="controls">
                            <div class="controls">
                                <div>
                                    <h2>Pune Municipal Corporation</h2>
                                    |
                            <h3 id="hheader" runat="server" visible="false" class="text-danger">Mechanical Sweeper Route Coverage Report <span>: From 
                                <asp:Label ID="lblFromDate" runat="server" Text="" CssClass="mx-1"></asp:Label>
                                to 
                                <asp:Label ID="lblEndDate" runat="server" Text="" CssClass="mx-1"></asp:Label></span></h3>
                                </div>
                            </div>
                        </div>

                        <div class="downloads d-flex align-items-center" id="divExport" runat="server" visible="false">
                            <asp:ImageButton ID="ImageButton1" src="Images/xls.png" runat="server" OnClick="imgxls_Click" CssClass="mr-1" />
                            <asp:ImageButton ID="ImageButton2" src="Images/pdf.png" runat="server" OnClick="imgpdf_Click" CssClass="mr-1" />
                            <button type="button" class="btn btn-light toggler__btn p-1">
                                <i class="fa-solid fa-chevron-down"></i>
                            </button>
                        </div>
                    </div>

                    <div class="body collapsible active toggler__content">
                        <asp:GridView ID="grd_Report" runat="server" AutoGenerateColumns="false" ShowFooter="true" CssClass="table-striped table-feeder grd_Report" EmptyDataText="No Data Found">
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
                                <asp:TemplateField ItemStyle-Width="100px" HeaderText="Zone">
                                    <ItemTemplate>
                                        <asp:Label ID="lblZoneName" runat="server" Text='<%#Eval("Zone")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="100px" HeaderText="Ward">
                                    <ItemTemplate>
                                        <asp:Label ID="lblWardName" runat="server" Text='<%#Eval("Ward")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="100px" HeaderText="Route">
                                    <ItemTemplate>
                                        <asp:Label ID="lblVehicleName" runat="server" Text='<%#Eval("Route")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="100px" HeaderText="Mechanical Sweeper">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTotalFeeder" runat="server" Text='<%#Eval("Mechanical Sweeper")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="100px" HeaderText="Work %">
                                    <ItemTemplate>
                                        <asp:Label ID="lblExpectedFeeder" runat="server" Text='<%#Eval("Work %")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="100px" HeaderText="Actual Route Mtr">
                                    <ItemTemplate>
                                        <asp:Label ID="lbl1" runat="server" Text='<%#Eval("ActualRouteMeter")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="100px" HeaderText="Covered Route Mtr">
                                    <ItemTemplate>
                                        <asp:Label ID="lbl2" runat="server" Text='<%#Eval("CoveredRouteMeter")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="100px" HeaderText="Exp.Coverage">
                                    <ItemTemplate>
                                        <asp:Label ID="lbl3" runat="server" Text='<%#Eval("expectedcoverage")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="100px" HeaderText="CheckingTime">
                                    <ItemTemplate>
                                        <asp:Label ID="lbl4" runat="server" Text='<%#Eval("CheckingTime")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="100px" HeaderText="CheckOutTime">
                                    <ItemTemplate>
                                        <asp:Label ID="lbl5" runat="server" Text='<%#Eval("CheckOutTime")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="100px" HeaderText="AverageSpeed">
                                    <ItemTemplate>
                                        <asp:Label ID="lbl6" runat="server" Text='<%#Eval("AverageSpeed")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="100px" HeaderText="View Route">
                                    <ItemTemplate>
                                        <asp:LinkButton CssClass="btn btn-sm btn-info" ID="LnkView" runat="server" Text="View Route" CommandName="ViewImages" OnClick="LnkView_Click"
                                            CommandArgument='<%# Eval("Pk_Vehicleid") + "|" + Eval("Date") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%--<asp:TemplateField ItemStyle-Width="100px" HeaderText="View Route">
                                <ItemTemplate>
                                    <asp:Label ID="Label3" runat="server" Text='<%#Eval("View Route")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>--%>
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
                    <div class="modal-content">
                        <div class="modal-header border-bottom-0 px-3 pb-0 pt-3">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
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



        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script src="Scripts/mechCharts.js"></script>
        <script>
            const dateInput = document.querySelectorAll('.date-wrapper input');
            const currentDate = new Date();

            const previousDate = new Date(currentDate - 86400000).toISOString().substr(0, 10);

            dateInput.forEach(input => {
                if (!input.value) {
                    input.value = previousDate;
                }
            });
        </script>
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
                $(".grd_Report").prepend($("<thead></thead>").append($(this).find("tr:first"))).DataTable({
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
                        { type: 'num', targets: [0, 1, 2, 6, 7, 8, 12] }, // Numeric sorting for columns 0 and 1.
                        { type: 'string', targets: [3, 4, 5, 9, 10, 11] } // Alphanumeric sorting for columns 2 and 3.
                    ],
                    order: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
                });
            });
        </script>
        <script src="Scripts/fstdropdown.js"></script>
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
