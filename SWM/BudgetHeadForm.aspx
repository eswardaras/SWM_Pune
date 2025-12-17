<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BudgetHeadForm.aspx.cs" Inherits="SWM.BudgetHeadForm" %>

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
        <link rel="stylesheet"
            href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css" />
        <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
        <!-- Chosen Jquery Library Links -->
        <link href="css/chosen.css" rel="stylesheet" />
        <!-- Chosen Jquery Library Links End -->
        <style>
            .tag {
                display: inline-block;
                background-color: #3498db;
                color: white;
                padding: 5px 10px;
                margin: 5px;
                border-radius: 5px;
                cursor: pointer;
            }

            .tag-remove {
                margin-left: 5px;
            }
        </style>
        <!-- Bootstrap links end -->
        <title>Document</title>
    </head>
    <body>

        <section class="filters-section adhocForm container-fluid" id="mainForm">
            <div class="filters-container border-0">
                <div class="title d-flex justify-content-between p-0 border bg-light">
                    <div class="d-flex justify-content-between align-items-center mx-2">
                        <i class="fa-solid fa-truck mx-2"></i>
                        <h3>Budget Head Form</h3>
                    </div>
                    <button class="btn btn-light toggler__btn" type="button">
                        <i class="fa-solid fa-chevron-down"></i>
                    </button>
                </div>
                <div class="body border border-top-0 toggler__content">
                    <form>
                        <div class="row px-3 pb-3">

                            <div class="col-md-4">
                                <div class="date-wrapper">
                                    <label>Budget Head<span class="required">*</span></label>
                                    <asp:TextBox
                                        ID="txtBudgetHead"
                                        runat="server"
                                        CssClass="form-control"
                                        type="text"
                                        MaxLength="100"
                                        required></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="date-wrapper">
                                    <label>Budget Head Code</label>
                                    <asp:TextBox
                                        ID="txtBudgetHeadCode"
                                        runat="server"
                                        CssClass="form-control"
                                        type="text"
                                        MaxLength="100"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="date-wrapper">
                                    <label>Total Budget Value<span class="required">*</span></label>
                                    <asp:TextBox
                                        ID="txtTotalBudgetValue"
                                        runat="server"
                                        CssClass="form-control"
                                        type="number"
                                        required></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <div class="row px-3 pb-3">

                            <div class="col-md-3">
                                <div class="date-wrapper">
                                    <label>Date of Approval</label>
                                    <asp:TextBox
                                        ID="txtDateofApproval"
                                        TextMode="Date"
                                        CssClass="form-control"
                                        runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="date-wrapper">
                                    <label>Previous Sanctioned Value</label>
                                    <asp:TextBox
                                        ID="txtPreviousSanctionedValue"
                                        CssClass="form-control"
                                        runat="server"
                                        MaxLength="100"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="date-wrapper">
                                    <label>Previous Sanctioned Year</label>
                                    <asp:TextBox
                                        ID="txtPreviousSanctionedYear"
                                        TextMode="Date"
                                        CssClass="form-control"
                                        runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="date-wrapper">
                                    <label>Sanctioning Authority</label>
                                    <asp:DropDownList ID="ddlSanctioningAuthority" runat="server" class="fstdropdown-select">
                                        <asp:ListItem Text="Standing"></asp:ListItem>
                                        <asp:ListItem Text="GB"></asp:ListItem>
                                        <asp:ListItem Text="Comissioner"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>

                        <div class="row px-3 pb-3">
                            <div class="col-md-3">
                                <div class="date-wrapper">
                                    <label>Sanction No</label>
                                    <%--<asp:TextBox
                                        ID="txtSanctionNo"
                                        TextMode="Date"
                                        CssClass="form-control"
                                        runat="server"></asp:TextBox>--%>
                                    <asp:TextBox
                                        ID="txtSanctionNo"
                                        runat="server"
                                        CssClass="form-control"
                                        type="text"
                                        MaxLength="100"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="date-wrapper">
                                    <label>Available Budget Value</label>
                                    <asp:TextBox
                                        ID="txtAvailableBudgetValue"
                                        runat="server"
                                        CssClass="form-control"
                                        type="text"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="date-wrapper">
                                    <label>Available Budget Year</label>
                                    <asp:TextBox
                                        ID="txtAvailableBudgetYear"
                                        runat="server"
                                        TextMode="Date"
                                        CssClass="form-control"
                                        type="number"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="date-wrapper">
                                    <label>Sanctioned By FinanceComittee</label>
                                    <asp:RadioButtonList ID="rbtSanctionedByFinanceComittee" runat="server" RepeatDirection="Horizontal">
                                        <asp:ListItem Text="Yes" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                            </div>
                        </div>

                        <div class="row px-3 pb-3 justify-content-center">
                            <div class="col-md-2">
                                <%--<button class="btn btn-info">Create Campaign</button>--%>
                                <asp:Button class="btn btn-info" ID="btnBudgetHead" runat="server" Text="Save" OnClick="btnBudgetHead_Click" />
                            </div>
                        </div>
                    </form>
                </div>
            </div>

        </section>

        <section class="sweeper-coverage-report-section">
            <div class="title d-flex justify-content-between p-0 border bg-light">
                <div class="d-flex justify-content-between align-items-center mx-2">
                    <i class="fa-solid fa-truck mx-2"></i>
                    <h3>Contractor / Vendor Details</h3>
                </div>
                <button class="btn btn-light toggler__btn1" type="button">
                    <i class="fa-solid fa-chevron-down"></i>
                </button>
            </div>
            <div class="sweeper-coverage-report">
                <div class="collapse show" id="tableCollapse2">
                    <div class="body collapsible active toggler__content1">
                        <asp:GridView ID="grdData" runat="server" CssClass="table-striped adhoctable" AutoGenerateColumns="true">
                            <Columns>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Edit">
                                    <ItemTemplate>
                                        <asp:LinkButton CssClass="btn btn-sm btn-info" ID="btnEdit" runat="server" Text="Edit" CommandName="EditImages" OnClick="btnEdit_Click"
                                            CommandArgument='<%# Eval("pk_BudgetHeadId") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Delete">
                                    <ItemTemplate>
                                        <asp:LinkButton CssClass="btn btn-sm btn-danger" ID="btnDelete" runat="server" Text="Delete" CommandName="DeleteImages" OnClick="btnDelete_Click"
                                            CommandArgument='<%# Eval("pk_BudgetHeadId") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <%-- <asp:GridView ID="grd_AttendanceSummary" runat="server" AutoGenerateColumns="true" CssClass="table-striped grd_AttendanceSummary">
                        </asp:GridView>--%>
                    </div>
                </div>
            </div>
        </section>

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
        <%--        <script>
            const dateInput = document.querySelectorAll('.filters input[type="date" ');
            const currentDate = new Date().toISOString().substr(0, 10);

            dateInput.forEach(input => {
                if (!input.value) {
                    input.value = currentDate;
                }
            });
        </script>--%>
    </body>
</asp:Content>
