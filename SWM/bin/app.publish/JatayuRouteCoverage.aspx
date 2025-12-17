<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="JatayuRouteCoverage.aspx.cs" Inherits="SWM.JatayuRouteCoverage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <head>
        <link href="css/styles.css" rel="stylesheet" />

        <%--    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.7.1/leaflet.css" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.7.1/leaflet.js"></script>--%>

        <link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css" />
        <script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"></script>

        <%-- <link rel="stylesheet" href="path/to/leaflet.css" />
        <script src="path/to/leaflet.js"></script>--%>
        <style type="text/css">
            .popup {
                display: none;
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background-color: #fff;
                padding: 20px;
                border: 1px solid #ccc;
            }
        </style>

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
        <title>Jatayu Route Coverage Report</title>
        <%--<link rel="stylesheet" href="css/coveragereport.css">--%>
        <link href="css/global.css" rel="stylesheet" />
    </head>

    <%--<section class="filters-section">
        <div class="filters-container">
            <div class="title d-flex justify-content-between">
                <div class="d-flex align-items-center">
                    <i class="fa-solid fa-book"></i>
                    <h3>Jatayu Route Coverage Report</h3>
                </div>
                <asp:Button ID="Button1" runat="server" Text="Search" OnClick="btnSearch_Click" CssClass="btn btn-success btn-sm float-right mr-2" OnClientClick="return validateDateModal()" />
            </div>
            <div class="body">
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
                        <h5>Jayatu Name</h5>
                        <asp:DropDownList ID="ddlJatayu" runat="server" class="fstdropdown-select">
                        </asp:DropDownList>
                    </div>

                    <div class="date-wrapper">
                        <h5>FromDate</h5>
                        <asp:TextBox ID="txtSdate" runat="server" type="date"></asp:TextBox>
                    </div>

                    <div class="date-wrapper">
                        <h5>ToDate</h5>
                        <asp:TextBox ID="txtEdate" runat="server" type="date"></asp:TextBox>
                    </div>

                </div>
            </div>
        </div>
    </section>--%>

    <section class="filters-section">
        <div class="filters-container">
            <div class="title d-flex justify-content-between">
                <div class="d-flex align-items-center">
                    <i class="fa-solid fa-book"></i>
                    <h3>Jatayu Route Coverage Report</h3>
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
                        <label>Jatayu Name</label>
                        <asp:DropDownList ID="ddlJatayu" runat="server" class="fstdropdown-select">
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
                            <h3 id="hheader" runat="server" visible="false" class="text-danger">Jatayu Route Coverage Report <span>: From 
                                <asp:Label ID="lblFromDate" runat="server" Text="" CssClass="mx-1"></asp:Label>
                                to 
                                <asp:Label ID="lblEndDate" runat="server" Text="" CssClass="mx-1"></asp:Label></span></h3>
                        </div>
                    </div>
                    <div class="text-danger d-flex align-items-center">
                        <asp:Label ID="lblTotalCount" runat="server" CssClass="mr-2"></asp:Label>
                        <asp:Label ID="lblTotalWaste" runat="server"></asp:Label>
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
                    <asp:GridView ID="grd_Report" runat="server" AutoGenerateColumns="false" ShowFooter="true" EmptyDataText="No data found." CssClass="table-striped table-feeder grd_Report">
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
                                    <asp:Label ID="lblZoneName" runat="server" Text='<%#Eval("zonename")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-Width="100px" HeaderText="Ward">
                                <ItemTemplate>
                                    <asp:Label ID="lblWardName" runat="server" Text='<%#Eval("wardname")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-Width="100px" HeaderText="Jatayu">
                                <ItemTemplate>
                                    <asp:Label ID="lblVehicleName" runat="server" Text='<%#Eval("vehiclename")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-Width="100px" HeaderText="Visited Chronic Spot">
                                <ItemTemplate>
                                    <asp:Label ID="lblVisitedCronicSpot" runat="server" Text='<%#Eval("VisitedCronicSpot")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-Width="100px" HeaderText="Waste Collected %">
                                <ItemTemplate>
                                    <asp:Label ID="lblTotalWaste" runat="server" Text='<%#Eval("TotalWaste")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-Width="100px" HeaderText="Image">
                                <ItemTemplate>
                                    <asp:LinkButton CssClass="btn btn-sm btn-secondary" ID="LinkButton2" runat="server" Text="View Images" CommandName="ViewImages" OnClick="LinkButton1_Click"
                                        CommandArgument='<%# Eval("fk_vehicleid") + "|" + Eval("date") + "|" + Eval("Wardid") %> ' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-Width="100px" HeaderText="View History">
                                <ItemTemplate>
                                    <asp:LinkButton CssClass="btn btn-sm btn-info" ID="LnkView" runat="server" Text="View Map" CommandName="ViewImages" OnClick="LnkView_Click"
                                        CommandArgument='<%# Eval("fk_vehicleid") + "|" + Eval("date") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>

            </div>
        </section>
    </asp:Panel>

    <!-- Popup content Image -->
    <div id="popup" class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Image Gallery</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="overflow-auto">
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-striped">
                            <Columns>
                                <asp:TemplateField HeaderText="Date Time">
                                    <ItemTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("optime") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Spot Name">
                                    <ItemTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("cronic_spot_name") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Before Image">
                                    <ItemTemplate>
                                        <asp:Image ID="Image1" runat="server" ImageUrl='<%# GetCustomImageUrl(Eval("beforeimg").ToString())  %>' Style="max-height: 30vh" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="After Image">
                                    <ItemTemplate>
                                        <asp:Image ID="Image1" runat="server" ImageUrl='<%# GetCustomImageUrl(Eval("afterimg").ToString()) %>' Style="max-height: 30vh" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Popup content View Map -->
    <div id="popupmap" class="modal fade" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Map</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div id="map" style="width: 100%; height: 700px;"></div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

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


    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
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
                    { type: 'num', targets: [0] }, // Numeric sorting for columns 0 and 1.
                    { type: 'string', targets: [1, 2, 3, 4, 5, 6] } // Alphanumeric sorting for columns 2 and 3.
                ],
                order: [0, 1, 2, 3, 4, 5, 6],
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

    <script>
        //Image
        function showPopup() {
            $('#popup').modal('show');
        }
        //Map
        function showPopupmap(vehicleName, latitude, longitude) {
            // Initialize the map
            var map = L.map('map').setView([latitude, longitude], 12);

            // Add a tile layer (e.g., OpenStreetMap)
            L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                attribution: 'Map data © OpenStreetMap contributors',
            }).addTo(map);

            // Create a marker
            var marker = L.marker([latitude, longitude]).addTo(map);

            // Create a popup
            marker.bindPopup("<b>" + vehicleName + "</b>").openPopup();

            // Create a LatLngBounds object with the marker's coordinates
            var markerBounds = L.latLngBounds([marker.getLatLng()]);

            // Fit the map bounds to include the marker
            map.fitBounds(markerBounds);


            // Pan the map towards the right
            //var panAmount = -1000; // Adjust the pan amount as needed
            //map.panBy([panAmount, 0], { animate: false });
            $('#popupmap').modal('show');

        }

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
