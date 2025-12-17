<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Tagregrestrationagdelhi_vehicles.aspx.cs" Inherits="SWM.Tagregrestrationagdelhi_vehicles" %>

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

        <script
            src="http://code.jquery.com/jquery-3.3.1.min.js"
            integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
            crossorigin="anonymous"></script>
        <link rel="stylesheet"
            href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css" />
        <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>

        <link href="css/global.css" rel="stylesheet" />
        <style>
            table thead th {
                text-transform: capitalize;
            }
        </style>
        <link href="css/fstdropdown.css" rel="stylesheet" />
    </head>

    <body>
        <section class="filters-section byProduct">
            <div class="filters-container">
                <div class="title d-flex justify-content-between">
                    <div class="d-flex align-items-center">
                        <i class="fa-solid fa-book"></i>
                        <h3>RFID Tag Read Report</h3>
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
                            <label>Vehicle</label>
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
                                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-success float-right mr-2" OnClientClick="return validateDateModal()" OnClick="btnSearch_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <asp:Panel ID="tableWrapper1" runat="server" Visible="false">
            <section class="sweeper-coverage-report-section">
                <div class="sweeper-coverage-report">
                    <div class="title dropdown-btn">
                        <div class="controls">
                            <div>
                                <h3 id="h1" runat="server">Vehicle RFID Trip Count | Pune Municipal Corporation | Compacter</h3>
                            </div>
                        </div>
                        <div class="text-danger d-flex align-items-center">
                            <asp:Label ID="Label3" runat="server" CssClass="mr-2"></asp:Label>
                            <asp:Label ID="Label4" runat="server"></asp:Label>
                        </div>
                        <div class="downloads d-flex align-items-center" id="div2" runat="server" visible="true">
                            <asp:ImageButton ID="ImageEXl1" src="Images/xls.png" runat="server" CssClass="mr-1" OnClick="ImageEXl1_Click" />
                            <asp:ImageButton ID="ImagePDF1" src="Images/pdf.png" runat="server" CssClass="mr-1" OnClick="ImagePDF1_Click" />
                            <button type="button" class="btn btn-light toggler__btn p-1">
                                <i class="fa-solid fa-chevron-down"></i>
                            </button>
                        </div>
                    </div>

                    <div class="body collapsible active toggler__content">
                        <asp:GridView ID="grd_Tripcount" runat="server" AutoGenerateColumns="true" CssClass="table-striped grd_Tripcount">
                        </asp:GridView>
                    </div>

                </div>
            </section>
        </asp:Panel>

       <asp:Panel ID="tableWrapper4" runat="server" Visible="false">
    <section class="sweeper-coverage-report-section">
        <div class="sweeper-coverage-report">
            <div class="title dropdown-btn">
                <div class="controls">
                    <div>
                        <h3 id="h3" runat="server">Vehicle RFID Trip Count | Pune Municipal Corporation | Primary Vehicle</h3>
                    </div>
                </div>
                <div class="text-danger d-flex align-items-center">
                    <asp:Label ID="Label1" runat="server" CssClass="mr-2"></asp:Label>
                    <asp:Label ID="Label2" runat="server"></asp:Label>
                </div>
                <div class="downloads d-flex align-items-center" id="div1" runat="server" visible="true">
                    <asp:ImageButton ID="ImageButton3" src="Images/xls.png" runat="server" CssClass="mr-1" OnClick="ImageEXl1_Click" />
                    <asp:ImageButton ID="ImageButton4" src="Images/pdf.png" runat="server" CssClass="mr-1" OnClick="ImagePDF1_Click" />
                    <button type="button" class="btn btn-light toggler__btn p-1">
                        <i class="fa-solid fa-chevron-down"></i>
                    </button>
                </div>
            </div>
            <div class="body collapsible active toggler__content">
       <asp:GridView ID="grd_PrimaryVehicleTripCount" runat="server" 
    AutoGenerateColumns="True" 
    CssClass="table table-bordered grd_PrimaryVehicleTripCount">
 
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
                                <h3 id="h2" runat="server">Vehicle RFID Trip Count | Pune Municipal Corporation</h3>
                            </div>
                        </div>
                        <div class="downloads d-flex align-items-center" id="div4" runat="server" visible="true">
                            <asp:ImageButton ID="ImageButton1" src="Images/xls.png" runat="server" CssClass="mr-1" OnClick="ImageEXl1_Click" />
                            <asp:ImageButton ID="ImageButton2" src="Images/pdf.png" runat="server" CssClass="mr-1" OnClick="ImagePDF1_Click" />
                            <button type="button" class="btn btn-light toggler__btn p-1">
                                <i class="fa-solid fa-chevron-down"></i>
                            </button>
                        </div>
                    </div>
                      <div class="body collapsible active toggler__content">
                        <asp:GridView ID="grd_TripcountVehicle" runat="server" AutoGenerateColumns="true" CssClass="table-striped grd_TripcountVehicle">
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
                                <h2>Vehicle RFID Tag Report | Pune Municipal Corporation</h2>
                                <h3 id="hheader" runat="server" visible="false" class="text-danger"><span>From 
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
                            <asp:ImageButton ID="ImgExl" src="Images/xls.png" runat="server" CssClass="mr-1" OnClick="ImgExl_Click" />
                            <asp:ImageButton ID="ImgPDF" src="Images/pdf.png" runat="server" CssClass="mr-1" OnClick="ImgPDF_Click" />
                            <button type="button" class="btn btn-light toggler__btn p-1">
                                <i class="fa-solid fa-chevron-down"></i>
                            </button>
                        </div>
                    </div>

                    <div class="body collapsible active toggler__content">
                        <asp:GridView ID="grd_TagReport" runat="server" AutoGenerateColumns="true" CssClass="table-striped grd_TagReport">
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

        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <%--    <script>
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

                initializeDataTable(".grd_Tripcount");
                initializeDataTable(".grd_TripcountVehicle");
              initializeDataTable(".grd_TagReport");
              //initializeDataTable(".grd_PrimaryVehicleTripCount");




							// 🔑 Just override for PrimaryVehicleTripCount (only 2 columns)
							initializeDataTable(".grd_PrimaryVehicleTripCount",
								[
									{ type: 'string', targets: [0] },  // Primary Vehicle
									{ type: 'num', targets: [1] }      // No. Of Trips
								],
								[[1, 'desc']] // Sort by No. Of Trips by default
              );

            });
				</script>--%>

      <script>
				$(document).ready(function () {
					function initializeDataTable(tableElement, columnDefsOverride, orderOverride) {
						// Ensure <thead> exists so DataTables won't break
						if ($(tableElement).find("thead").length === 0) {
							$(tableElement).prepend($("<thead></thead>").append($(tableElement).find("tr:first")));
						}

						$(tableElement).DataTable({
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
							columnDefs: columnDefsOverride || [],
							order: orderOverride || []
						});
					}

					initializeDataTable(".grd_Tripcount");
					initializeDataTable(".grd_TripcountVehicle");
					initializeDataTable(".grd_TagReport");

					// ✅ FIX: Tell DataTables that this grid has 2 columns only
					initializeDataTable(".grd_PrimaryVehicleTripCount", [
						{ type: 'string', targets: 0 },  // Primary Vehicle
						{ type: 'num', targets: 1 }      // No. Of Trips
					], [[1, 'desc']]); // Sort by No. Of Trips
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
