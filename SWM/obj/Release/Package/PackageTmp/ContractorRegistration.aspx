<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ContractorRegistration.aspx.cs" Inherits="SWM.ContractorRegistration" %>

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
                        <h3>Contractor / Vendor Registration</h3>
                    </div>
                    <button class="btn btn-light toggler__btn" type="button">
                        <i class="fa-solid fa-chevron-down"></i>
                    </button>
                </div>
                <div class="body border border-top-0 filters toggler__content">
                    <form>
                        <div class="row px-3 pb-3">

                            <div class="col-md-3">
                                <div class="date-wrapper">
                                    <label>Contractor/Vendor Name<span class="required">*</span></label>
                                    <asp:TextBox
                                        ID="txtContractorName"
                                        runat="server"
                                        CssClass="form-control"
                                        type="text"
                                        required
                                        MaxLength="500"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="date-wrapper">
                                    <label>Firm/Contractor Owner Name<span class="required">*</span></label>
                                    <asp:TextBox
                                        ID="txtFirmContractorOwnerName"
                                        runat="server"
                                        CssClass="form-control"
                                        required
                                        type="text"
                                        MaxLength="500"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="date-wrapper">
                                    <label>Mobile No<span class="required">*</span></label>
                                    <asp:TextBox
                                        ID="txtMobile"
                                        runat="server"
                                        CssClass="form-control"
                                        type="tel"
                                        required
                                        MinLength="10"
                                        MaxLength="10"
                                       oninput="this.value = this.value.replace(/[^0-9]/g, '').slice(0, 10);">
                                    </asp:TextBox>
                                    <asp:CustomValidator
                                        ID="cvMobile"
                                        runat="server"
                                        ControlToValidate="txtMobile"
                                        ErrorMessage="Mobile number must be at least 10 digits long."
                                        Display="Dynamic"
                                        ClientValidationFunction="validateMobileLength"
                                        ValidateEmptyText="true"
                                        SetFocusOnError="true">
                                    </asp:CustomValidator>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="date-wrapper">
                                    <label>Landline No<span class="required">*</span></label>
                                    <asp:TextBox
                                        ID="txtLandline"
                                        runat="server"
                                        CssClass="form-control"
                                        type="tel"
                                        MinLength="8"
                                        MaxLength="10"  
                                        required
                                        oninput="this.value = this.value.replace(/[^0-9]/g, '').slice(0, 10);">
                                    </asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row px-3 pb-3">

                            <div class="col-md-3">
                                <div class="date-wrapper">
                                    <label>Vendor Registration Number<span class="required">*</span></label>
                                    <asp:TextBox
                                        ID="txtVendorRegistrationNumber"
                                        runat="server"
                                        CssClass="form-control"
                                        type="text"
                                        required
                                        MaxLength="500"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="date-wrapper">
                                    <label>Contractor Registered Address<span class="required">*</span></label>
                                    <asp:TextBox
                                        ID="txtContractorRegisteredAddress"
                                        runat="server"
                                        CssClass="form-control" TextMode="MultiLine"
                                        type="text"
                                        required
                                        MaxLength="500"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <div class="row px-3 pb-3">
                            <div class="col-md-3">
                                <div class="date-wrapper">
                                    <label>GSTN<span class="required">*</span></label>
                                    <asp:TextBox
                                        ID="txtGSTN"
                                        runat="server"
                                        CssClass="form-control"
                                        type="text"
                                        MaxLength="15"
                                        MinLength="15"
                                        required>
                                    </asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="date-wrapper">
                                    <label>PAN No<span class="required">*</span></label>
                                    <asp:TextBox
                                        ID="txtPANNo"
                                        runat="server"
                                        CssClass="form-control"
                                        type="text"
                                        MaxLength="10"
                                        MinLength="10"
                                        required>
                                    </asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="date-wrapper">
                                    <label>Bank Account No<span class="required">*</span></label>
                                    <asp:TextBox
                                        ID="txtBankAccountNo"
                                        runat="server"
                                        CssClass="form-control"
                                        type="text"
                                        MaxLength="18"
                                        required></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="date-wrapper">
                                    <label>Name Of Account Holder<span class="required">*</span></label>
                                    <asp:TextBox
                                        ID="txtNameOfAccountHolder"
                                        runat="server"
                                        CssClass="form-control"
                                        type="text"
                                        required
                                        MaxLength="500"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row px-3 pb-3">
                            <div class="col-md-3">
                                <div class="date-wrapper">
                                    <label>ISFC <span class="required">*</span></label>
                                    <asp:TextBox
                                        ID="txtISFC"
                                        runat="server"
                                        CssClass="form-control"
                                        type="text"
                                        MaxLength="11"
                                        required></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="date-wrapper">
                                    <label>Branch <span class="required">*</span></label>
                                    <asp:TextBox
                                        ID="txtBranch"
                                        runat="server"
                                        CssClass="form-control"
                                        type="text"
                                        required
                                        MaxLength="500"></asp:TextBox>
                                </div>
                            </div>

                        </div>

                        <div class="row px-3 pb-3 justify-content-center">
                            <div class="col-md-2">
                                <%--<button class="btn btn-info">Create Campaign</button>--%>
                                <asp:Button class="btn btn-info" ID="btnContractor" runat="server" Text="Submit" OnClick="btnContractor_Click1" />
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
                                            CommandArgument='<%# Eval("Pk_ContractorId") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                  <asp:TemplateField ItemStyle-Width="30px" HeaderText="Delete" >
                                    <ItemTemplate>
                                        <asp:LinkButton CssClass="btn btn-sm btn-danger" ID="btnDelete" runat="server" Text="Delete" CommandName="DeleteImages" OnClick="btnDelete_Click"
                                            CommandArgument='<%# Eval("Pk_ContractorId") %>' />
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

        <%--<script src="Scripts/jquery-3.2.1.min.js"></script>--%>
        <script>
            function initializeChosen(selector) {
                $(selector).chosen({
                    allow_single_deselect: true,
                    width: "100%",
                    placeholder_text_multiple: "Enter tags...",
                    no_results_text: "No matching tags",
                });
            }

        </script>
        <!-- Chosen Jquery Library Script End -->
        <script type="text/javascript">
            function validateMobileLength(sender, args) {
                args.IsValid = args.Value.length >= 10;
            }
        </script>
    </body>


</asp:Content>
