<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GenerateBill.aspx.cs" Inherits="SWM.GenerateBill" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="css/sweeperAttendance.css" />
        <link rel="stylesheet" href="css/fstdropdown.css" />
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
        <link
            rel="stylesheet"
            href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css" />
        <script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
        <!-- Chosen Jquery Library Links -->
        <link href="css/chosen.css" rel="stylesheet" />
        <!-- Chosen Jquery Library Links End -->
        <style>
            input[type='text'],
            input[type='number'] {
                height: 34px;
            }
        </style>
        <!-- Bootstrap links end -->
        <title>Document</title>
    </head>
    <body>

        <section class="filters-section adhocForm container-fluid" id="mainForm">
            <div class="filters-container border-0">
                <div class="title d-flex justify-content-center p-0 border bg-light">
                    <div class="d-flex justify-content-between align-items-center mx-2">
                        <i class="fa-solid fa-book mx-1"></i>
                        <h3>Generate Bill</h3>
                    </div>
                    <button class="btn btn-light toggler__btn" type="button" style="visibility: hidden">
                        <i class="fa-solid fa-chevron-down"></i>
                    </button>
                </div>
                <div class="body border border-top-0 filters toggler__content">
                    <div class="row px-3 pb-3 justify-content-center">

                        <div class="col-md-3">
                            <div class="date-wrapper">
                                <label>Contract Name</label>
                                <asp:DropDownList ID="ddlContractName" runat="server" class="fstdropdown-select">
                                </asp:DropDownList>
                            </div>
                        </div>

                        <div class="col-md-auto">
                            <div class="d-flex align-items-end justify-content h-100">
                                <asp:Button class="btn btn-info" ID="btnSerch" runat="server" Text="Submit" OnClick="btnSerch_Click"/>
                            </div>
                        </div>

                    </div>
                </div>
            </div>

        </section>

        <asp:Panel ID="tableWrapper" runat="server" Visible="false">
            <div class="row p-0 m-0 justify-content-center">
                <div class="col-md-8">
                    <section class="sweeper-coverage-report-section">
                        <div class="title d-flex justify-content-between p-0 border bg-light">
                            <div class="d-flex justify-content-between align-items-center mx-2">
                                <i class="fa-solid fa-book mx-2"></i>
                                <h3>Contract Bill Generate</h3>
                            </div>
                            <button class="btn btn-light toggler__btn1" type="button">
                                <i class="fa-solid fa-chevron-down"></i>
                            </button>
                        </div>
                        <div class="sweeper-coverage-report">
                            <div class="collapse show" id="tableCollapse2">
                                <div class="body collapsible active toggler__content1 overflow-hidden">
                                    <form>
                                        <div class="row justify-content-center">
                                            <div class="col-md-12 mb-2">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <asp:Label ID="lblTendorNo" Text="Tendor No:" runat="server"></asp:Label>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <asp:TextBox ID="txtTendorNo" runat="server" CssClass="form-control"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-12 mb-2">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <asp:Label ID="Label1" Text="Contractor Name:" runat="server"></asp:Label>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <asp:TextBox ID="txtContractorName" runat="server" CssClass="form-control"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-12 mb-2">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <asp:Label ID="Label2" Text="Address Of Contractor:" runat="server"></asp:Label>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <asp:TextBox ID="txtAddressOfContractor" runat="server" CssClass="form-control"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-12 mb-2">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <asp:Label ID="Label3" Text="Budget Head:" runat="server"></asp:Label>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <asp:TextBox ID="txtBudgetHead" runat="server" CssClass="form-control"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-12 mb-2">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <asp:Label ID="Label4" Text="Budget Code:" runat="server"></asp:Label>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <asp:TextBox ID="txtBudgetCode" runat="server" CssClass="form-control"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-12 mb-2">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <asp:Label ID="Label5" Text="Total Budget Value:" runat="server"></asp:Label>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <asp:TextBox ID="txtTotalBudgetValue" runat="server" CssClass="form-control"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-12 mb-2">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <asp:Label ID="Label6" Text="Available budget Value:" runat="server"></asp:Label>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <asp:TextBox ID="txtAvailablebudgetValue" runat="server" CssClass="form-control"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-12 mb-2">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <asp:Label ID="Label7" Text="Bill For Period(From-To):" runat="server"></asp:Label>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <asp:TextBox ID="txtBillForPeriodfromto" runat="server" CssClass="form-control" required placeholder="Enter bill for the period"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-12 mb-2">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <asp:Label ID="Label8" Text="Total Bill Amount:" runat="server"></asp:Label>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <asp:TextBox ID="txtTotalBillAmount" runat="server" CssClass="form-control" required placeholder="Enter bill amount"
                                                            MaxLength="100"
                                                            oninput="this.value = this.value.replace(/[^0-9]/g, '').slice(0, 10);"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-12 mb-2 mt-4">
                                                <div class="d-flex align-items-end justify-content-center h-100">
                                                    <asp:Button class="btn btn-info" ID="btnLockBudget" runat="server" Text="Lock Budget" OnClick="btnLockBudget_Click" />
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
            </div>
        </asp:Panel>

        <script src="Scripts/fstdropdown.js"></script>
        <script>
            $(document).ready(function () {
                function collapseContent(button, content) {
                    $(button).click(function () {
                        $(content).slideToggle("fast");
                    });
                }

                collapseContent(".toggler__btn", ".toggler__content");
                collapseContent(".toggler__btn1", ".toggler__content1");
            });
        </script>
        <script>
            const dateInput = document.querySelectorAll('.filters input[type="date" ');
            const currentDate = new Date().toISOString().substr(0, 10);

            dateInput.forEach(input => {
                if (!input.value) {
                    input.value = currentDate;
                }
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
                    });
                }

                initializeDataTable(".adhoctable");
            });
        </script>
    </body>
</asp:Content>
