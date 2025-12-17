<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Collectionworkerroutecoveregereport.aspx.cs" Inherits="SWM.Collectionworkerroutecoveregereport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
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
            src="http://code.jquery.com/jquery-3.3.1.min.js"
            integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
            crossorigin="anonymous"></script>
        <link rel="stylesheet"
            href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css" />
        <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
        <!-- Bootstrap links end -->

        <link href="css/global.css" rel="stylesheet" />
        <title>Adoc-form</title>
    </head>
    <body>

        <section class="filters-section adhocForm">
            <div class="filters-container">
                <div class="title d-flex justify-content-between">
                    <div class="d-flex align-items-center">
                        <i class="fa-solid fa-book"></i>
                        <h3>C.W Pocket Coverage Report</h3>
                    </div>
                </div>
                <div class="body">
                    <div class="row px-3 pb-3">
                        <div class="col-md-2">
                            <label>Zone Name</label>
                            <asp:DropDownList ID="ddlZone" runat="server" AutoPostBack="true" class="fstdropdown-select" OnSelectedIndexChanged="ddlZone_SelectedIndexChanged">
                            </asp:DropDownList>
                        </div>
                        <div class="col-sm-2">
                            <label>Ward Name</label>
                            <asp:DropDownList ID="ddlWard" runat="server" class="fstdropdown-select" AutoPostBack="True" OnSelectedIndexChanged="ddlWard_SelectedIndexChanged">
                                <asp:ListItem Text="Select" Value="" />
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-2 d-none">
                            <label>Kothi Name</label>
                            <asp:DropDownList ID="ddlKothi" runat="server" class="fstdropdown-select" AutoPostBack="True">
                                <asp:ListItem Text="Select" Value="" />
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-2">
                            <label>Prabhag Name</label>
                            <asp:DropDownList ID="ddlPrabhag" runat="server" class="fstdropdown-select" AutoPostBack="True">
                                <asp:ListItem Text="Select" Value="0" />
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-2">
                            <div class="date-wrapper">
                                <label>From Date</label>
                                <asp:TextBox ID="txtFromDate" TextMode="Date" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="date-wrapper">
                                <label>To Date</label>
                                <asp:TextBox ID="txtToDate" TextMode="Date" runat="server"></asp:TextBox>
                            </div>
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
                            <div class="h-100 d-flex align-items-end">
                                <asp:Button ID="Submitt" runat="server" Text="Submit" OnClick="ButtonSubmitt_Click" CssClass="btn btn-sm btn-success" OnClientClick="return validateDateModal()" />
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
                            <h3>C.W Pocket Coverage Report</h3>
                                <span>: From 
                                <asp:Label ID="lblFromDate" runat="server" Text="" CssClass="mx-1"></asp:Label>
                                    to 
                                <asp:Label ID="lblEndDate" runat="server" Text="" CssClass="mx-1"></asp:Label></span>
                            </div>
                        </div>

                        <div class="downloads d-flex align-items-center" visible="true">
                            <asp:ImageButton ID="ImageButton1" src="Images/xls.png" runat="server" CssClass="mr-1" />
                            <asp:ImageButton ID="ImageButton2" src="Images/pdf.png" runat="server" CssClass="mr-1" />
                            <button class="btn btn-light btn-sm p-0 outline-none" type="button" data-toggle="collapse" data-target="#tableCollapse" aria-expanded="false" aria-controls="tableCollapse">
                                <i class="fa-solid fa-chevron-down"></i>
                            </button>
                        </div>
                    </div>

                    <div class="collapse show" id="tableCollapse">
                        <div class="body collapsible active">
                            <asp:GridView ID="gvwardwise" runat="server" AutoGenerateColumns="false" OnRowCommand="yourGridView_RowCommand" CssClass="table table-striped gvwardwise">
                                <Columns>
                                    <asp:BoundField DataField="Date" HeaderText="Date" />
                                    <asp:BoundField DataField="Zone" HeaderText="Zone" />
                                    <asp:BoundField DataField="Ward" HeaderText="Ward Name" />
                                    <asp:BoundField DataField="Prabhag" HeaderText="Prabhag" />
                                    <asp:BoundField DataField="Name" HeaderText="Name" />
                                    <asp:BoundField DataField="TotalDTDC" HeaderText="Total DTDC" />
                                    <asp:BoundField DataField="CoveredDTDC" HeaderText="Covered DTDC" />
                                    <asp:BoundField DataField="UncoverDtdc" HeaderText="Uncovered DTDC" />
                                    <asp:BoundField DataField="TotalComm" HeaderText="Total Commercial" />
                                    <asp:BoundField DataField="CoveredComm" HeaderText="Covered Commercial" />
                                    <asp:BoundField DataField="UncoverComm" HeaderText="Uncovered Commercial" />
                                    <asp:BoundField DataField="Totalslum" HeaderText="Total Slum" />
                                    <asp:BoundField DataField="Coveredslum" HeaderText="Covered Slum" />
                                    <asp:BoundField DataField="UncoverSlum" HeaderText="Uncovered Slum" />
                                    <asp:BoundField DataField="TotalGateColl" HeaderText="Total Gate Collection" />
                                    <asp:BoundField DataField="CoveredGateColl" HeaderText="Covered Gate Collection" />
                                    <asp:BoundField DataField="UncoverGate" HeaderText="Uncovered Gate Collection" />
                                    <asp:BoundField DataField="TotalSRA" HeaderText="Total SRA" />
                                    <asp:BoundField DataField="CoveredSRA" HeaderText="Covered SRA" />
                                    <asp:BoundField DataField="UncoverSRA" HeaderText="Uncovered SRA" />
                                    <asp:BoundField DataField="TotalSociety" HeaderText="Total Society" />
                                    <asp:BoundField DataField="CoveredSociety" HeaderText="Covered Society" />
                                    <asp:BoundField DataField="UncoverSOC" HeaderText="Uncovered Society" />
                                    <%--                                    <asp:BoundField DataField="RouteId" HeaderText="Route ID" />
                                    <asp:BoundField DataField="Pk_VehicleId" HeaderText="Vehicle ID" />--%>
                                    <asp:TemplateField HeaderText="ViewPocket">
                                        <ItemTemplate>
                                            <asp:Button ID="btnComplete" runat="server" Text="View route" CommandName="ViewPocket" CommandArgument='<%# Container.DataItemIndex %>' CssClass="btn btn-sm btn-info" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>

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

        <script src="Scripts/fstdropdown.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
            crossorigin="anonymous"></script>
        <script>


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
            $(document).ready(function () {
                $(".gvwardwise").prepend($("<thead></thead>").append($(this).find("tr:first"))).DataTable({
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
                const fromDate = new Date(document.getElementById('<%= txtFromDate.ClientID %>').value);
                const toDate = new Date(document.getElementById('<%= txtToDate.ClientID %>').value);

                if (fromDate > toDate) {
                    const modalBtn = document.getElementById('modalBtn').click();
                    return false;
                }

                return true;
            }
        </script>
    </body>
</asp:Content>
