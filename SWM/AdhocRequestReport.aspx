<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdhocRequestReport.aspx.cs" Inherits="SWM.AdhocRequestReport" %>

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
                        <h3>Adhoc Request Report</h3>
                    </div>
                </div>
                <div class="body">
                    <div class="row px-3 pb-3">
                        <div class="col-sm-3">
                            <label>Request Type</label>
                            <div class="row">
                                <div class="col-sm-5">
                                    <asp:RadioButton ID="rbCD" Checked="true" runat="server" Text="C &amp; D Waste" AutoPostBack="true" OnCheckedChanged="RadioButton_CheckedChanged" GroupName="RequestTypeGroup" />
                                </div>
                                <div class="col-sm-5">
                                    <asp:RadioButton ID="rbSW" runat="server" Text="Special-Waste" AutoPostBack="true" OnCheckedChanged="RadioButton_CheckedChanged" GroupName="RequestTypeGroup" />
                                </div>
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
                                <asp:ListItem Text="Select" Value="0" />
                            </asp:DropDownList>
                        </div>
                        <div class="col-sm-3">
                            <label>Kothi Name</label>
                            <asp:DropDownList ID="ddlKothi" runat="server" class="fstdropdown-select" AutoPostBack="True">
                                <asp:ListItem Text="Select" Value="0" />
                            </asp:DropDownList>
                        </div>
                        <div class="col-sm-2">
                            <div class="date-wrapper">
                                <label>From Date</label>
                                <asp:TextBox ID="txtFromDate" TextMode="Date" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-sm-2">
                            <div class="date-wrapper">
                                <label>To Date</label>
                                <asp:TextBox ID="txtToDate" TextMode="Date" runat="server"></asp:TextBox>
                            </div>
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
                        <div class="col-sm-2">
                            <div class="h-100 d-flex align-items-end">
                                <asp:Button ID="Submitt" runat="server" Text="Search" OnClick="ButtonSubmitt_Click" CssClass="btn btn-success" />
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
                            <h3 id="requestType">Adhoc-Request Report</h3>
                            </div>
                        </div>
                        <div class="downloads d-flex align-items-center" visible="true">
                            <asp:ImageButton ID="ImageButton1" src="Images/xls.png" runat="server" CssClass="mr-1" OnClick="btnexcel_Click" />
                            <asp:ImageButton ID="ImageButton2" src="Images/pdf.png" runat="server" CssClass="mr-1" OnClick="btnpdf_Click" />
                            <button class="btn btn-light btn-sm p-0 outline-none" type="button" data-toggle="collapse" data-target="#tableCollapse" aria-expanded="false" aria-controls="tableCollapse">
                                <i class="fa-solid fa-chevron-down"></i>
                            </button>
                        </div>
                    </div>

                    <div class="collapse show" id="tableCollapse">
                        <div class="body collapsible active">
                            <asp:GridView ID="adhoctable" runat="server" AutoGenerateColumns="false" CssClass="adhoctable table-striped">
                                <Columns>
                                    <asp:BoundField DataField="zonename" HeaderText="Zone Name" />
                                    <asp:BoundField DataField="wardname" HeaderText="Ward Name" />
                                    <asp:BoundField DataField="kothiname" HeaderText="Kothi Name" />
                                    <asp:BoundField DataField="mokadam" HeaderText="Mokadam" />
                                    <asp:BoundField DataField="Supervisor" HeaderText="Supervisor" />
                                    <asp:BoundField DataField="remark" HeaderText="Remark" />
                                    <asp:BoundField DataField="entitytype" HeaderText="Entity Type" />
                                    <asp:BoundField DataField="status" HeaderText="Status" />
                                    <asp:BoundField DataField="vehiclename" HeaderText="Vehicle Name" />
                                    <%--<asp:BoundField DataField="platform" HeaderText="Platform" />--%>
                                    <asp:TemplateField HeaderText="Image" Visible="false">
                                        <ItemTemplate>
                                            <%-- <asp:ImageButton ID="btnImage" runat="server" ImageUrl='<%# Eval("image") %>' OnClick="ShowImage_Click" />--%>
                                            <asp:Button type="button" data-toggle="modal" data-target="#exampleModalCenter" ID="btnImage" runat="server" ImageUrl='<%# Eval("image") %>' Text="view" CssClass="btn btn-info btn-sm" OnClientClick="return ShowImagePopup(this);" Enabled='<%# !Eval("image").ToString().Equals("NA") %>' />
                                            <%--  <asp:Button runat="server" CssClass="btn btn-info btn-sm" text="View"/>--%>
                                            <%-- <asp:Button ID="btnImage" data-toggle="modal" data-target="#exampleModalCenter" runat="server" Text="View Image" OnClick="ShowImage_Click" OnClientClick="return ShowImagePopup(this);" cssClass="btn btn-sm btn-info"/>--%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Workstatus" HeaderText="Work Status" />
                                </Columns>
                            </asp:GridView>
                            <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="#exampleModalCenter" aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered" role="document">
                                    <div class="modal-content">
                                        <div class="modal-body">
                                            <div class="w-100 h-100 d-flex justify-content-center align-items-center">
                                                <img id="popupImage" style="width: 300px;" src="#" alt="Image" />
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-sm btn-secondary" data-dismiss="modal"><i class="fa-solid fa-xmark text-white"></i></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </asp:Panel>

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
            $(document).ready(function () {
                $(".adhoctable").prepend($("<thead></thead>").append($(this).find("tr:first"))).DataTable({
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
            function ShowImagePopup(button) {
                var imageUrl = button.src;
                var popupImage = document.getElementById('popupImage');
                popupImage.src = imageUrl;

                return false;
            }

        //function CloseImagePopup() {
        //    var imagePopup = document.getElementById('imagePopup');
        //    imagePopup.style.display = 'none';
        //}
        </script>
    </body>
</asp:Content>
