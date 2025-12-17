<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdhocForm_CandD.aspx.cs" Inherits="SWM.AdhocForm_CandD" %>

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

        <script src="js/jquery-3.3.1.min.js"></script>
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
                        <i class="bx bxs-user"></i>
                        <h3>Adhoc Form</h3>
                    </div>
                    <button class="btn btn-light btn-sm p-0 outline-none" type="button" data-toggle="collapse" data-target="#tableCollapse" aria-expanded="false" aria-controls="tableCollapse">
                        <i class="fa-solid fa-chevron-down"></i>
                    </button>
                </div>

                <div class="collapse show" id="tableCollapse">
                    <div class="body">
                        <div class="row px-3 pb-3">
                            <div class="col-sm-3">
                                <label>Name</label>
                                <asp:TextBox ID="txboxName" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="col-sm-3">
                                <label>Contact No</label>
                                <asp:TextBox ID="txtbxMobile" runat="server" CssClass="form-control" type="number"></asp:TextBox>
                            </div>
                            <div class="col-sm-3">
                                <label>Entity Type</label>
                                <asp:DropDownList ID="ddlEntityType" runat="server" CssClass="fstdropdown-select">
                                    <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="Hotel" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Garden" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="Slaughter House" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="Bio-Waste" Value="4"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-sm-3">
                                <label>Entity Name</label>
                                <asp:TextBox ID="txtEntityName" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="col-sm-3">
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
                            </div>
                            <div class="col-sm-3">
                                <label>Zone Name</label>
                                <asp:DropDownList ID="ddlZone" runat="server" AutoPostBack="true" class="fstdropdown-select" OnSelectedIndexChanged="ddlZone_SelectedIndexChanged">
                                </asp:DropDownList>
                            </div>
                            <div class="col-sm-3">
                                <label>Ward Name</label>
                                <asp:DropDownList ID="ddlWard" runat="server" class="fstdropdown-select" AutoPostBack="True" OnSelectedIndexChanged="ddlWard_SelectedIndexChanged">
                                    <asp:ListItem Text="Select" Value="" />
                                </asp:DropDownList>
                            </div>
                            <div class="col-sm-3">
                                <label>Kothi Name</label>
                                <asp:DropDownList ID="ddlKothi" runat="server" class="fstdropdown-select" AutoPostBack="True" OnSelectedIndexChanged="ddlKothi_SelectedIndexChanged">
                                    <asp:ListItem Text="Select" Value="" />
                                </asp:DropDownList>
                            </div>
                            <div class="col-sm-3">
                                <label>Mukadam Name</label>
                                <asp:DropDownList ID="ddlMukadam" runat="server" class="fstdropdown-select" AutoPostBack="True">
                                    <asp:ListItem Text="Select" Value="" />
                                </asp:DropDownList>
                            </div>
                            <div class="col-sm-3">
                                <label>Supervisor Name</label>
                                <asp:DropDownList ID="ddlsupervisor1" runat="server" class="fstdropdown-select" AutoPostBack="True">
                                    <asp:ListItem Text="Select" Value="" />
                                </asp:DropDownList>
                            </div>
                            <div class="col-sm-3">
                                <div class="h-100 d-flex align-items-end">
                                    <asp:Button ID="btSubmitt" runat="server" Text="Submit" OnClick="ButtonSubmitt_Click" CssClass="btn btn-info mt-2" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </section>

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
                <div class="title dropdown-btn">
                    <div class="controls">
                        <div>
                            <h2>Adhoc Request Details</h2>
                        </div>
                    </div>
                    <div class="downloads d-flex align-items-center" visible="true">
                        <button class="btn btn-light btn-sm p-0 outline-none" type="button" data-toggle="collapse" data-target="#tableCollapse_1" aria-expanded="false" aria-controls="tableCollapse_1">
                            <i class="fa-solid fa-chevron-down"></i>
                        </button>
                    </div>
                </div>

                <div class="collapse show" id="tableCollapse_1">
                    <div class="body collapsible active">
                        <asp:GridView ID="adhocTable" runat="server" CssClass="table-striped adhocTable" AutoGenerateColumns="false" OnRowDeleting="adhocTable_RowDeleting">
                            <Columns>
                                <%--        <asp:BoundField DataField="SrNo" HeaderText="Sr. No" />--%>
                                <asp:BoundField DataField="Pk_AdhocReqId" HeaderText="AdhocReqId" />
                                <asp:BoundField DataField="date" HeaderText="Date" />
                                <asp:BoundField DataField="zonename" HeaderText="Zone" />
                                <asp:BoundField DataField="wardname" HeaderText="Ward" />
                                <asp:BoundField DataField="kothiname" HeaderText="Kothi" />
                                <asp:BoundField DataField="name" HeaderText="Name" />
                                <asp:BoundField DataField="RequestType" HeaderText="Request Type" />
                                <asp:BoundField DataField="entityname" HeaderText="Entity Name" />
                                <asp:BoundField DataField="entitytype" HeaderText="Entity Type" />
                                <asp:BoundField DataField="status" HeaderText="Status" />
                                <asp:TemplateField HeaderText="Work Status">
                                    <ItemTemplate>
                                        <asp:Button ID="btnComplete" runat="server" Text="Complete" CommandName="Completed" CommandArgument='<%# Container.DataItemIndex %>' OnClick="btnWorkStatus_Click" CssClass="btn btn-outline-success btn-sm" />
                                        <asp:Button ID="btnIncomplete" runat="server" Text="Incomplete" CommandName="InCompleted" CommandArgument='<%# Container.DataItemIndex %>' OnClick="btnWorkStatus_Click" CssClass="btn btn-outline-danger btn-sm" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Assign">
                                    <ItemTemplate>
                                        <asp:Button ID="btnAssign" runat="server" Text="Assign" CommandName="Assign" CommandArgument='<%# Container.DataItemIndex %>' OnClick="btnSaveAssignment_Click" CssClass="btn btn-primary btn-sm" />

                                        <%--                <asp:Panel ID="pnlAssignment" runat="server" Visible="false">
                    <!-- Controls inside the expanded panel -->
                    <asp:TextBox ID="txtAssignment" runat="server"></asp:TextBox>
                    <asp:Button ID="btnSaveAssignment" runat="server" Text="Save" CommandName="Save" CommandArgument='<%# Container.DataItemIndex %>' OnClick="btnSaveAssignment_Click" />
                </asp:Panel>--%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Delete">
                                    <ItemTemplate>
                                        <asp:Button ID="btnDelete" runat="server" Text="Delete" CommandName="Delete" CommandArgument='<%# Container.DataItemIndex %>' OnClick="btnDeleteRequest_Click" CssClass="btn btn-danger btn-sm" />

                                        <%--                <asp:Panel ID="pnlAssignment" runat="server" Visible="false">
                    <!-- Controls inside the expanded panel -->
                    <asp:TextBox ID="txtAssignment" runat="server"></asp:TextBox>
                    <asp:Button ID="btnSaveAssignment" runat="server" Text="Save" CommandName="Save" CommandArgument='<%# Container.DataItemIndex %>' OnClick="btnSaveAssignment_Click" />
                </asp:Panel>--%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
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
    </body>
</asp:Content>
