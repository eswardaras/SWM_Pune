<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CTPTInsertEdit.aspx.cs" Inherits="SWM.CTPTInsertEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
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

        <script
            src="http://code.jquery.com/jquery-3.3.1.min.js"
            integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
            crossorigin="anonymous"></script>
        <link rel="stylesheet"
            href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css" />
        <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
        <!-- Bootstrap links end -->

        <link href="css/global.css" rel="stylesheet" />
        <link href="css/fstdropdown.css" rel="stylesheet" />
        <title>CTPT Data</title>
    </head>
    <body>

        <section class="filters-section adhocForm">
            <div class="filters-container">
                <div class="title d-flex justify-content-between border-bottom">
                    <div class="d-flex align-items-center">
                        <i class="fa-sharp fa-solid fa-road"></i>
                        <h3>CTPT Data</h3>
                    </div>
                    <button class="btn btn-light btn-sm p-0 outline-none" type="button" data-toggle="collapse" data-target="#tableCollapse" aria-expanded="false" aria-controls="tableCollapse">
                        <i class="fa-solid fa-chevron-down"></i>
                    </button>
                </div>

                <div class="collapse show" id="tableCollapse">
                    <div class="body">
                        <div class="row px-3 pb-3 mt-2">

                            <div class="col-sm-3">
                                <label>Zone Name<span class="required">*</span></label>
                                <asp:DropDownList ID="ddlZone" runat="server" AutoPostBack="true" class="fstdropdown-select" OnSelectedIndexChanged="ddlZone_SelectedIndexChanged">
                                </asp:DropDownList>
                            </div>
                            <div class="col-sm-3">
                                <label>Ward Name<span class="required">*</span></label>
                                <asp:DropDownList ID="ddlWard" runat="server" class="fstdropdown-select" AutoPostBack="True" OnSelectedIndexChanged="ddlWard_SelectedIndexChanged">
                                    <asp:ListItem Text="Select" Value="" />
                                </asp:DropDownList>
                            </div>
                            <div class="col-sm-3">
                                <label>Kothi Name<span class="required">*</span></label>
                                <asp:DropDownList ID="ddlKothi" runat="server" class="fstdropdown-select" AutoPostBack="True" OnSelectedIndexChanged="ddlKothi_SelectedIndexChanged">
                                    <asp:ListItem Text="Select" Value="" />
                                </asp:DropDownList>
                            </div>


                            <div class="col-sm-3">
                                <label>CTPT Name<span class="required">*</span></label>
                                <asp:TextBox ID="txboxCTPTName" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>


                            <div class="col-sm-3">
                                <label>CTPT Type<span class="required">*</span></label>
                                <asp:DropDownList ID="ddlCTPTType" runat="server" CssClass="fstdropdown-select">
                                    <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="CT" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="PT" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="Urinals" Value="3"></asp:ListItem>
                                </asp:DropDownList>
                            </div>



                            <div class="col-sm-3">
                                <label>No. of Seats</label>
                                <asp:TextBox ID="txtNos" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <%--<div class="col-sm-3">
                            <label>Remark</label>
                            <textarea class="form-control adhoc-textarea" rows="3" runat="server"></textarea>
                        </div>
                        <div class="col-sm-3">
                            <label>Request Type</label>
                            <div>
                                <asp:RadioButton ID="rbCD" runat="server" Text="C &amp; D Waste" AutoPostBack="true" OnCheckedChanged="RadioButton_CheckedChanged" GroupName="RequestTypeGroup" Checked="true" />
                            </div>
                            <div>
                                <asp:RadioButton ID="rbSW" runat="server" Text="Special-Waste" AutoPostBack="true" OnCheckedChanged="RadioButton_CheckedChanged" GroupName="RequestTypeGroup" />
                            </div>
                        </div>--%>

                            <div class="col-sm-3">
                                <label>Mukadam Name<span class="required">*</span></label>
                                <asp:DropDownList ID="ddlMukadam" runat="server" class="fstdropdown-select" AutoPostBack="True">
                                    <asp:ListItem Text="Select" Value="" />
                                </asp:DropDownList>
                            </div>
                            <div class="col-sm-3">
                                <label>SI<span class="required">*</span></label>
                                <asp:DropDownList ID="ddlSI" runat="server" class="fstdropdown-select" AutoPostBack="True">
                                    <asp:ListItem Text="Select" Value="" />
                                </asp:DropDownList>
                            </div>

                            <div class="col-sm-3">
                                <label>DSI<span class="required">*</span></label>
                                <asp:DropDownList ID="ddlDSI" runat="server" class="fstdropdown-select" AutoPostBack="True">
                                    <asp:ListItem Text="Select" Value="" />
                                </asp:DropDownList>
                            </div>


                            <div class="col-sm-3">
                                <label>Lattitude<span class="required">*</span></label>
                                <asp:TextBox ID="txtLattitude" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>

                            <div class="col-sm-3">
                                <label>Longitude<span class="required">*</span></label>
                                <asp:TextBox ID="txtlongitude" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>

                            <div class="col-sm-3">
                                <label>Address</label>
                                <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>

                            <div class="col-sm-3">
                                <div class="h-100 d-flex align-items-end">
                                    <asp:Button ID="btSubmitt" runat="server" Text="Add CTPT" OnClick="ButtonSubmitt_Click" CssClass="btn btn-info mt-2" OnClientClick="return validateInsertEdit()" />
                                    <asp:Button ID="btncancel" runat="server" Text="Cancel" OnClick="btncancel_Click" CssClass="btn btn-warning text-white mt-2 mx-2" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

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
                                <p class="text-danger font-weight-bold">Warning:- <span class="text-dark">Make sure to fill Zone name/ Ward name/ Kothi name/ CTPT name/ CTPT Type/ Mukadam Name/ SI/ DSI/ Lattitude/ Longitude</span></p>
                            </center>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <%-- Popup Modal Section End--%>

        <section class="filters-section adhocForm" style="padding: 0 20px">
            <asp:Panel ID="pnlAssign" runat="server" Style="display: none;">
                <div class="filters-container">
                    <div class="body px-3 pb-3">
                        <div class="row">
                            <div class="col-sm-3">
                                <label>Supervisor Name</label>
                                <asp:DropDownList ID="ddlsupervisor2" runat="server" class="fstdropdown-select" AutoPostBack="True">
                                </asp:DropDownList>
                            </div>
                            <div class="col-sm-3">
                                <label>Vehicle Number</label>
                                <asp:DropDownList ID="ddlvehicle" runat="server" class="fstdropdown-select" AutoPostBack="True"></asp:DropDownList>
                            </div>
                            <div class="col-sm-3">
                                <div class="h-100 d-flex align-items-end">
                                    <asp:Button ID="ButtonAssign" runat="server" Text="Assign" OnClick="ButtonAssign_Click" CssClass="btn btn-success" />
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </asp:Panel>
        </section>

        <section class="sweeper-coverage-report-section">
            <div class="sweeper-coverage-report">
                <div class="body collapsible active">
                    <asp:GridView ID="adhocTable" runat="server" CssClass="table-striped adhocTable" AutoGenerateColumns="false">
                        <Columns>
                            <asp:BoundField DataField="zonename" HeaderText="Zone Name" />
                            <asp:BoundField DataField="wardname" HeaderText="Ward Name" />
                            <asp:BoundField DataField="kothiname" HeaderText="Kothi Name" />
                            <asp:BoundField DataField="blockname" HeaderText="Block Name" />
                            <asp:BoundField DataField="type" HeaderText="Type" />
                            <asp:BoundField DataField="latitude" HeaderText="Latitude" />
                            <asp:BoundField DataField="longitude" HeaderText="Longitude" />
                            <asp:BoundField DataField="address" HeaderText="Address" />
                            <asp:BoundField DataField="Mokadam" HeaderText="Mokadam" />
                            <asp:BoundField DataField="si" HeaderText="SI" />
                            <asp:BoundField DataField="dsi" HeaderText="DSI" />
                            <asp:BoundField DataField="NoOfSeats" HeaderText="No. of Seats" />
                            <asp:TemplateField HeaderText="Edit">
                                <ItemTemplate>
                                    <asp:Button ID="btnEdit" runat="server" Text="Edit" CommandName="Assign" CommandArgument='<%# Container.DataItemIndex %>' OnClick="btnEdit_Click" CssClass="btn btn-sm btn-secondary" />

                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Delete">
                                <ItemTemplate>
                                    <asp:Button ID="btnDelete" runat="server" Text="Delete" CommandName="Delete" CommandArgument='<%# Container.DataItemIndex %>' OnClick="btnDelete_Click" CssClass="btn btn-sm btn-danger" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </section>

        <script src="Scripts/fstdropdown.js"></script>
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
            function validateInsertEdit() {
                const wardName = document.getElementById('<%= ddlWard.ClientID %>').value;
                const kothiName = document.getElementById('<%= ddlKothi.ClientID %>').value;
                const ctptName = document.getElementById('<%= txboxCTPTName.ClientID %>').value;
                const ctptType = document.getElementById('<%= ddlCTPTType.ClientID %>').value;
                const mokadum = document.getElementById('<%= ddlMukadam.ClientID %>').value;
                const si = document.getElementById('<%= ddlSI.ClientID %>').value;
                const dsi = document.getElementById('<%= ddlDSI.ClientID %>').value;
                const latitude = document.getElementById('<%= txtLattitude.ClientID %>').value;
                const longitude = document.getElementById('<%= txtlongitude.ClientID %>').value;

                if (!wardName || !kothiName || !ctptName || !ctptType || !mokadum || !si || !dsi || !latitude || !longitude) {
                    const modalBtn = document.getElementById('modalBtn').click();
                    return false;
                }
                return true;
            }
        </script>
    </body>
</asp:Content>
