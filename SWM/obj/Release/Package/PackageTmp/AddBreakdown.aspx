<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddBreakdown.aspx.cs" Inherits="SWM.AddBreakdown" %>

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
        <link rel="stylesheet"
            href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css" />
        <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
        <!-- Bootstrap links end -->
        <title>Vehicle Breakdown</title>
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
        <%--<link rel="stylesheet" href="css/coveragereport.css">--%>
        <link href="css/global.css" rel="stylesheet" />
    </head>
    <body>

        <section class="filters-section">
            <div class="filters-container">
                <div class="title d-flex justify-content-between">
                    <div class="d-flex align-items-center">
                        <i class="fa-solid fa-book"></i>
                        <h3>Breakdown Report</h3>
                    </div>
                    <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" CssClass="btn btn-success btn-sm float-right mr-2" OnClientClick="return validateBreakdown()" />
                </div>
                <div class="px-3">
                    <asp:RadioButtonList ID="rbllist" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal">
                        <asp:ListItem Text="Mark_Breakdown" Value="Mark_Breakdown" style="margin-right: 10px;"></asp:ListItem>
                        <asp:ListItem Text="View_Report" Value="View_Report" Selected="True"></asp:ListItem>
                    </asp:RadioButtonList>
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

                        <div class="dropdown-wrapper d-block divAddvehicle" id="divAddvehicle" runat="server">
                            <h5>Vehicle Name</h5>
                            <asp:DropDownList ID="ddlVehicle" runat="server" class="fstdropdown-select">
                            </asp:DropDownList>
                        </div>

                        <div class="dropdown-wrapper d-block divAddvehicle2" id="divAddvehicle2">
                            <h5>Replace Vehicle Name</h5>
                            <asp:DropDownList ID="ddlReplaceVehicle" runat="server" class="fstdropdown-select">
                            </asp:DropDownList>
                        </div>
                        <div class="dropdown-wrapper d-block divAddvehicle3" id="divAddvehicle3">
                            <h5>Remark</h5>
                            <asp:TextBox ID="txtRemark" runat="server" Text="" CssClass="form-control" Style="height: 35px;"></asp:TextBox>
                        </div>

                        <div class="date-wrapper">
                            <h5>FromDate</h5>
                            <asp:TextBox ID="txtSdate" runat="server" type="date"></asp:TextBox>
                        </div>
                        <div class="date-wrapper">
                            <h5>ToDate</h5>
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

                        <div class="h-100 d-flex align-items-end divAddvehicle4">
                            <asp:Button ID="btnMarkBKD" runat="server" OnClick="btnMarkBKD_Click" Text="Mark_Breakdown" CssClass="btn btn-success mr-2" OnClientClick="return validateDateModal()" />
                            <asp:Button ID="btnCancel" runat="server" OnClick="btnCancel_Click" Text="Cancel" CssClass="btn btn-warning text-white" />
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
                            <h3 id="hheader" runat="server" visible="false" class="text-danger">Vehicle Breakdown <span>: From 
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

                    <%--Vehiclename Zonename    Wardname Breakdown_Date  Expected_Recovery_Date Breakdown_Period    ReplaceVehicleName Mark_By Remark Actual_Recovery_Date--%>
                    <div class="body collapsible active toggler__content">
                        <asp:Panel ID="tableWrapper1" runat="server" Visible="false">
                            <asp:GridView ID="grd_Report1" runat="server" AutoGenerateColumns="false" EmptyDataText="No data found." ShowFooter="true" CssClass="table-striped grd_Report1">
                                <Columns>
                                    <asp:TemplateField ItemStyle-Width="30px" HeaderText="Sr. No">
                                        <ItemTemplate>
                                            <asp:Label ID="lblID1" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-Width="30px" HeaderText="VehicleName">
                                        <ItemTemplate>
                                            <asp:Label ID="lblID2" runat="server"
                                                Text='<%#Eval("Vehiclename")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-Width="30px" HeaderText="ZoneName">
                                        <ItemTemplate>
                                            <asp:Label ID="lblID3" runat="server"
                                                Text='<%#Eval("Zonename")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-Width="30px" HeaderText="WardName">
                                        <ItemTemplate>
                                            <asp:Label ID="lblID4" runat="server"
                                                Text='<%#Eval("Wardname")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-Width="30px" HeaderText="Breakdown_Date">
                                        <ItemTemplate>
                                            <asp:Label ID="lblID5" runat="server"
                                                Text='<%#Eval("Breakdown_Date")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-Width="30px" HeaderText="Expected_Recovery_Date">
                                        <ItemTemplate>
                                            <asp:Label ID="lblID6" runat="server"
                                                Text='<%#Eval("Expected_Recovery_Date")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField ItemStyle-Width="30px" HeaderText="Breakdown_Period">
                                        <ItemTemplate>
                                            <asp:Label ID="lblID7" runat="server"
                                                Text='<%#Eval("Breakdown_Period")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-Width="30px" HeaderText="ReplaceVehicleName">
                                        <ItemTemplate>
                                            <asp:Label ID="lblID" runat="server"
                                                Text='<%#Eval("ReplaceVehicleName")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-Width="30px" HeaderText="Mark_By">
                                        <ItemTemplate>
                                            <asp:Label ID="lblID8" runat="server"
                                                Text='<%#Eval("Mark_By")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-Width="30px" HeaderText="Remark">
                                        <ItemTemplate>
                                            <asp:Label ID="lblID9" runat="server"
                                                Text='<%#Eval("Remark")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-Width="30px" HeaderText="Actual_Recovery_Date">
                                        <ItemTemplate>
                                            <asp:Label ID="lblID10" runat="server"
                                                Text='<%#Eval("Actual_Recovery_Date")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                </Columns>
                            </asp:GridView>
                        </asp:Panel>
                        <asp:Panel ID="tableWrapper2" runat="server" Visible="false">
                            <asp:GridView ID="grd_AddReport" runat="server" AutoGenerateColumns="false" EmptyDataText="No data found." ShowFooter="true" CssClass="table-striped grd_AddReport">
                                <Columns>
                                    <asp:TemplateField ItemStyle-Width="30px" HeaderText="Sr. No">
                                        <ItemTemplate>
                                            <asp:Label ID="lblID11" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-Width="30px" HeaderText="VehicleName">
                                        <ItemTemplate>
                                            <asp:Label ID="lblID12" runat="server"
                                                Text='<%#Eval("Vehiclename")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField ItemStyle-Width="30px" HeaderText="Breakdown_Date">
                                        <ItemTemplate>
                                            <asp:Label ID="lblID13" runat="server"
                                                Text='<%#Eval("Breakdown_Date")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-Width="30px" HeaderText="Expected_Recovery_Date">
                                        <ItemTemplate>
                                            <asp:Label ID="lblID14" runat="server"
                                                Text='<%#Eval("Expected_Recovery_Date")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField ItemStyle-Width="30px" HeaderText="Breakdown_Period">
                                        <ItemTemplate>
                                            <asp:Label ID="lblID15" runat="server"
                                                Text='<%#Eval("Breakdown_Period")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField ItemStyle-Width="30px" HeaderText="Mark_By">
                                        <ItemTemplate>
                                            <asp:Label ID="lblID16" runat="server"
                                                Text='<%#Eval("Mark_By")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-Width="30px" HeaderText="Remark">
                                        <ItemTemplate>
                                            <asp:Label ID="lblID17" runat="server"
                                                Text='<%#Eval("Remark")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-Width="30px" HeaderText="ReplaceVehicle">
                                        <ItemTemplate>
                                            <asp:Label ID="lblID18" runat="server"
                                                Text='<%#Eval("ReplaceVehName")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField ItemStyle-Width="100px" HeaderText="Remove_Breakdown">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnRemoveBreakdown" runat="server" Text="Remove Breakdown" CommandName="ViewImages" OnClick="btnRemoveBreakdown_Click"
                                                CommandArgument='<%# Eval("pk_ReplaceId") + "|" + Eval("Breakdown_Date") %>' CssClass="" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-Width="30px" HeaderText="Edit">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnEditBreakdown" runat="server" Text="Edit Breakdown" CommandName="EditImages" OnClick="btnEditBreakdown_Click"
                                                CommandArgument='<%# Eval("pk_ReplaceId") + "|" + Eval("Breakdown_Date") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </asp:Panel>
                    </div>

                </div>
            </section>
        </asp:Panel>


        <%-- Validation Modal Section --%>
        <section>
            <button type="button" id="modalBtn" hidden class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
                Launch demo modal</button>
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
                // Retrieve the saved state from localStorage (if available)
                const selectedOption = localStorage.getItem('selectedOption');

                function updateVisibility(option) {
                    if (option === 'Mark_Breakdown') {
                        $('.divAddvehicle').show().addClass('d-block');
                        $('.divAddvehicle2').show().addClass('d-block');
                        $('.divAddvehicle3').show().addClass('d-block');
                        $('.divAddvehicle4').show().addClass('d-flex');
                        // $('#MainContent_btnSearch').hide();
                    } else {
                        $('.divAddvehicle').hide().removeClass('d-block');
                        $('.divAddvehicle2').hide().removeClass('d-block');
                        $('.divAddvehicle3').hide().removeClass('d-block');
                        $('.divAddvehicle4').hide().removeClass('d-flex');
                        $('#MainContent_btnSearch').show();
                    }
                }

                // Check if a previously selected option is available
                if (selectedOption) {
                    // Apply the saved visibility settings
                    updateVisibility(selectedOption);
                    // Set the appropriate radio button as checked
                    $('#MainContent_rbllist input[value="' + selectedOption + '"]').prop('checked', true);
                } else {
                    // By default, apply the visibility settings based on the initially checked radio button
                    const defaultOption = $('#MainContent_rbllist input:checked').val();
                    updateVisibility(defaultOption);
                }

                // Handle radio button click event
                $('#MainContent_rbllist input[type="radio"]').click(function () {
                    const selectedOption = $(this).val();
                    // Save the selected option to localStorage
                    localStorage.setItem('selectedOption', selectedOption);
                    // Apply the visibility settings based on the selected option
                    updateVisibility(selectedOption);
                });
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

                initializeDataTable(".grd_Report1");
                initializeDataTable(".grd_AddReport");
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
        <script>
            function validateDateModal() {
                const fromDate = new Date(document.getElementById('<%= txtSdate.ClientID %>').value);
                const toDate = new Date(document.getElementById('<%= txtEdate.ClientID %>').value);

                if (fromDate > toDate) {
                    const modalBtn = document.getElementById('modalBtn').click();
                    return false;
                }

            }

        </script>
    </body>

</asp:Content>
