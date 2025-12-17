<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ByproductsGenerationAndSalesRevenue.aspx.cs" Inherits="SWM.ByproductsGenerationAndSalesRevenue" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <script src="https://kit.fontawesome.com/c56ffbbf41.js" crossorigin="anonymous"></script>

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

        <title>By-Product</title>
    </head>
    <body>

        <section class="filters-section byProduct">
            <div class="filters-container">
                <div class="title d-flex justify-content-between">
                    <div class="d-flex align-items-center">
                        <i class="fa-brands fa-bitbucket"></i>
                        <h3>By Products Generation And Sales Revenue</h3>
                    </div>
                </div>
                <div class="body">
                    <div class="row px-3 pb-3">
                        <div class="col-sm-3">
                            <label>Type Of Waste Generated<span class="required">*</span></label>
                            <asp:TextBox ID="txtTypeofWasteGenerated" runat="server" CssClass="form-control" type="text" placeholder="Alphabets Only"></asp:TextBox>
                        </div>
                        <div class="col-sm-3">
                            <label>Type Of Waste Generated In Tones<span class="required">*</span></label>
                            <asp:TextBox ID="txtTypeofwasteInTones" runat="server" CssClass="form-control" type="number" placeholder="Numbers Only"></asp:TextBox>
                        </div>
                        <div class="col-sm-3">
                            <label>Type Of By product Generated<span class="required">*</span></label>
                            <asp:TextBox ID="txtTypeOfByproductGenrated" runat="server" CssClass="form-control" type="text" placeholder=""></asp:TextBox>
                        </div>
                        <div class="col-sm-3">
                            <label>By Product sale In Tones<span class="required">*</span></label>
                            <asp:TextBox ID="txtByProductsaleInTones" runat="server" CssClass="form-control" type="number" placeholder="Numbers Only"></asp:TextBox>
                        </div>
                        <div class="col-sm-3">
                            <label>Revenue Generated (In Rs.)<span class="required">*</span></label>
                            <asp:TextBox ID="txtRevenueGenerated" runat="server" CssClass="form-control" type="number" placeholder="Numbers Only"></asp:TextBox>
                        </div>
                        <div class="col-sm-3">
                            <label>Authorised By<span class="required">*</span></label>
                            <asp:TextBox ID="txtAuthorisedBy" runat="server" CssClass="form-control" type="text" placeholder="Alphabets Only"></asp:TextBox>
                        </div>
                        <div class="col-sm">
                            <div class="d-flex align-items-end h-100">
                                <asp:Button ID="Buttonsubmitt" runat="server" Text="Submit" OnClick="ButtonSubmitt_Click" CssClass="btn btn-success mr-2" />
                                <asp:Button ID="ButtonCancel" runat="server" Text="Cancel" OnClick="ButtonCancel_Click" CssClass="btn btn-warning text-white" />
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </section>

        <asp:Panel ID="tableWrapper" runat="server" Visible="false">
            <section class="sweeper-coverage-report-section">
                <div class="sweeper-coverage-report">

                    <div class="body collapsible active">
                        <asp:Button ID="Button1" runat="server" Text="Delete" OnClick="ButtonDelete_Click" CssClass="btn btn-danger mb-2" />

                        <asp:GridView ID="adhocTable" runat="server" CssClass="table-striped adhocTable" AutoGenerateColumns="false">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="CheckBoxSelect" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="pk_Id" HeaderText="PK ID" />
                                <asp:BoundField DataField="TypeOfWasteGenratedInTones" HeaderText="Type of Waste Generated (in Tones)" />
                                <asp:BoundField DataField="TypeOfByproductGenrated" HeaderText="Type of Byproduct Generated" />
                                <asp:BoundField DataField="ByProductsaleInTones" HeaderText="Byproduct Sale (in Tones)" />
                                <asp:BoundField DataField="RevenueGenrated" HeaderText="Revenue Generated" />
                                <asp:BoundField DataField="AuthorisedBy" HeaderText="Authorised By" />
                                <asp:BoundField DataField="IsEnable" HeaderText="Is Enable" />
                                <asp:BoundField DataField="Optime" HeaderText="Optime" />
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Button ID="ButtonEdit" runat="server" Text="Edit" OnClick="btnEditRequest_Click" CssClass="btn btn-secondary btn-sm" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </section>

        </asp:Panel>

        <script>
            const dropdownBtn = document.querySelectorAll(".dropdown-btn");

            dropdownBtn.forEach((btn) => {
                btn.addEventListener("click", () => {
                    const body = btn.nextElementSibling;
                    body.classList.toggle("active");
                });
            });
        </script>

        <script>
            $(document).ready(function () {
                $(".adhocTable").prepend($("<thead></thead>").append($(this).find("tr:first"))).DataTable({
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
            window.addEventListener('DOMContentLoaded', function () {
                var submitButton = document.getElementById('<%= Buttonsubmitt.ClientID %>');

                submitButton.addEventListener('click', function (e) {
                    e.preventDefault();

                    var txtTypeofWasteGenerated = document.getElementById('<%= txtTypeofWasteGenerated.ClientID %>');
                    var txtTypeofwasteInTones = document.getElementById('<%= txtTypeofwasteInTones.ClientID %>');
                    var txtTypeOfByproductGenrated = document.getElementById('<%= txtTypeOfByproductGenrated.ClientID %>');
                    var txtByProductsaleInTones = document.getElementById('<%= txtByProductsaleInTones.ClientID %>');
                    var txtRevenueGenerated = document.getElementById('<%= txtRevenueGenerated.ClientID %>');
                    var txtAuthorisedBy = document.getElementById('<%= txtAuthorisedBy.ClientID %>');

                    var inputs = [txtTypeofWasteGenerated, txtTypeOfByproductGenrated, txtAuthorisedBy];
                    var numericInputs = [txtTypeofwasteInTones, txtByProductsaleInTones, txtRevenueGenerated];

                    for (var i = 0; i < inputs.length; i++) {
                        if (i === 0 || i === inputs.length - 1) {
                            if (!inputs[i].value.trim().match(/^[a-zA-Z\s]*$/)) {
                                alert('Only alphabetic characters are allowed for the first, third and last inputs.');
                                return;
                            }
                        } else {
                            if (!numericInputs[i - 1].value.trim().match(/^\d+(\.\d+)?$/)) {
                                alert('Only numeric values (with decimals) are allowed for the middle inputs.');
                                return;
                            }
                        }
                    }

                    __doPostBack('<%= Buttonsubmitt.UniqueID %>', '');
                });
            });
        </script>

    </body>
</asp:Content>
