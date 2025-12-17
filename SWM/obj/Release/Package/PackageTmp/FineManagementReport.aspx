<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FineManagementReport.aspx.cs" Inherits="SWM.FineManagementReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link
            href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css"
            rel="stylesheet" />

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
        <link href="css/fstdropdown.css" rel="stylesheet" />
        <link href="css/global.css" rel="stylesheet" />
        <title>Fine Collection Report</title>
    </head>
    <body>

        <section class="filters-section byProduct">
            <div class="filters-container">
                <div class="title d-flex justify-content-between">
                    <div class="d-flex align-items-center">
                        <i class="fa-solid fa-book"></i>
                        <h3>Fine Collection Report</h3>
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
                            <asp:DropDownList ID="ddlWard" runat="server" class="fstdropdown-select" AutoPostBack="True">
                                <asp:ListItem Text="Select" Value="0" />
                            </asp:DropDownList>
                        </div>
                        <div class="col-sm-2">
                            <label>Fine Type</label>
                            <asp:DropDownList ID="ddlFine" runat="server" class="fstdropdown-select" AutoPostBack="True">
                                <asp:ListItem Text="Select" Value="0" />
                            </asp:DropDownList>
                        </div>
                        <div class="col-sm-2 date-wrapper">
                            <label>FromDate</label>
                            <asp:TextBox ID="txtFromDate" TextMode="Date" runat="server"></asp:TextBox>
                        </div>
                        <div class="col-sm-2 date-wrapper">
                            <label>ToDate</label>
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
                        <div class="col-sm-2">
                            <div class="d-flex align-items-end h-100">
                                <asp:Button ID="Submitt" runat="server" Text="Search" OnClick="ButtonSubmitt_Click" CssClass="btn btn-success" OnClientClick="return validateDateModal()" />
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
                            </div>
                        </div>

                        <div class="downloads d-flex align-items-center" visible="true">
                            <asp:Label ID="TotalFineLabel" runat="server" Text="" CssClass="alert alert-danger py-0 mb-0"/>
                            <button class="btn btn-light btn-sm p-0 outline-none" type="button" data-toggle="collapse" data-target="#tableCollapse" aria-expanded="false" aria-controls="tableCollapse">
                                <i class="fa-solid fa-chevron-down"></i>
                            </button>
                        </div>
                    </div>

                    <div class="collapse show" id="tableCollapse">
                        <div class="body collapsible active">
                            <asp:GridView ID="adhoctable" runat="server" AutoGenerateColumns="false" CssClass="table-striped fineManagementTable">
                                <Columns>
                                    <asp:BoundField DataField="ID" HeaderText="ID" />
                                    <asp:BoundField DataField="ZoneName" HeaderText="Zone Name" />
                                    <asp:BoundField DataField="wardName" HeaderText="Ward Name" />
                                    <asp:BoundField DataField="Officer" HeaderText="Officer" />
                                    <asp:BoundField DataField="Offender Info" HeaderText="Offender Info" />
                                    <asp:BoundField DataField="Mobile" HeaderText="Mobile" />
                                    <asp:BoundField DataField="Fine Info" HeaderText="Fine Info" />
                                    <asp:BoundField DataField="Frequency" HeaderText="Frequency" />
                                    <asp:BoundField DataField="Expected Fine" HeaderText="Expected Fine" />
                                    <asp:BoundField DataField="Fine Paid" HeaderText="Fine Paid" />
                                    <asp:BoundField DataField="Date" HeaderText="Date" />
                                    <asp:TemplateField HeaderText="Offender Photo">
                                        <ItemTemplate>
                                            <asp:Button ID="ViewOffender" runat="server" Text="View" CommandName="Assign" CommandArgument='<%# Container.DataItemIndex %>' OnClick="ViewOffender_Click" CssClass="btn btn-sm btn-info" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="E-Challan Photo">
                                        <ItemTemplate>
                                            <asp:Button ID="ViewChallan" runat="server" Text="View" CommandName="Assign" CommandArgument='<%# Container.DataItemIndex %>' OnClick="ViewChallan_Click" CssClass="btn btn-sm btn-info" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </section>
        </asp:Panel>

        <%-- Modal For Offender Photo --%>
        <button type="button" hidden class="btn btn-primary" id="viewOffenderBtn" data-toggle="modal" data-target="#exampleModalCenter">
            Launch demo modal
        </button>
        <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle">Offender Photo</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <img id="offender__image" runat="server" class="w-100"  />
                    </div>
                </div>
            </div>
        </div>
        <%-- End of Modal For Offender Photo --%>

        <%-- Modal For Challan Photo --%>
        <button type="button" hidden class="btn btn-primary" id="viewChallanBtn" data-toggle="modal" data-target="#exampleModalCenter1">
            Launch demo modal
        </button>
        <div class="modal fade" id="exampleModalCenter1" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle1">Challan Photo</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <img id="challan__image" runat="server" class="w-100" />
                    </div>
                </div>
            </div>
        </div>
        <%-- End of Modal For Challan Photo --%>

        <%-- Validation Modal Section --%>
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
                                    <p class="text-danger font-weight-bold">Warning:- <span class="text-dark validation__text"></span></p>
                                </center>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <%-- Validation Modal Section End--%>

        <script src="Scripts/fstdropdown.js"></script>
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
                                title: 'Fine Collection Report' + ' - ' + getFormattedDate(),
                                className: "btn btn-sm btn-success mb-2", // Add your Excel button class here
                            },
                            {
                                extend: "pdf",
                                text: "PDF <i class='fa-regular fa-file-pdf text-white'></i>",
                                title: 'Fine Collection Report' + ' - ' + getFormattedDate(),
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

                initializeDataTable(".fineManagementTable");
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
            function viewOffenderPhoto() {
                document.getElementById('viewOffenderBtn').click();
            }
        </script>
        <script>
            function viewChallanPhoto() {
                document.getElementById('viewChallanBtn').click();
            }
        </script>
        <script>
            function validateDateModal() {
                const fromDate = new Date(document.getElementById('<%= txtFromDate.ClientID %>').value);
                const toDate = new Date(document.getElementById('<%= txtToDate.ClientID %>').value);
                const wardName = document.getElementById('<%= ddlWard.ClientID %>').value;

                if (fromDate > toDate) {
                    const modalBtn = document.getElementById('modalBtn').click();
                    const validationText = document.querySelector('.validation__text').innerText = 'From Date cannot be greater than To Date';
                    return false;
                }
                //if (!wardName) {
                //    const modalBtn = document.getElementById('modalBtn').click();
                //    const validationText = document.querySelector('.validation__text').innerText = 'Please select ward name';
                //    return false;
                //}

                return true;
            }
        </script>
    </body>
</asp:Content>
