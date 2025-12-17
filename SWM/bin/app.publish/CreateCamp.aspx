<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CreateCamp.aspx.cs" Inherits="SWM.CreateCamp" Async="true" %>

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
                        <h3>Register New Campaign</h3>
                    </div>
                    <button class="btn btn-light toggler__btn" type="button">
                        <i class="fa-solid fa-chevron-down"></i>
                    </button>
                </div>
                <div class="body border border-top-0 filters toggler__content">
                    <div class="row px-3 pb-3">
                        <div class="col-md-3">
                            <div class="dropdown-wrapper">
                                <label>Select<span class="required">*</span></label>
                                <div>
                                    <asp:RadioButtonList ID="rdblist" runat="server" GroupName="CreateCampaignGroup" RepeatDirection="Horizontal"
                                        AutoPostBack="true" OnSelectedIndexChanged="rdblist_SelectedIndexChanged">
                                        <asp:ListItem Text="CityWise" Value="City" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="ZoneWise" Value="Zone"></asp:ListItem>
                                        <asp:ListItem Text="WardWise" Value="Ward"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <%--<asp:RadioButton
                                        ID="rbCW"
                                        runat="server"
                                        Text="CityWise"
                                        AutoPostBack="true"
                                        GroupName="CreateCampaignGroup" />
                                    <asp:RadioButton
                                        ID="rbZW"
                                        runat="server"
                                        Text="ZoneWise"
                                        AutoPostBack="true"
                                        GroupName="CreateCampaignGroup" />
                                    <asp:RadioButton
                                        ID="rbWW"
                                        runat="server"
                                        Text="WardWise"
                                        AutoPostBack="true"
                                        GroupName="CreateCampaignGroup" />--%>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="date-wrapper">
                                <label>Campaign Name<span class="required">*</span></label>
                                <asp:TextBox
                                    ID="txtCampaignName"
                                    runat="server"
                                    CssClass="form-control"
                                    type="text"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="">
                                <label>FromDate<span class="required">*</span></label>
                                <asp:TextBox
                                    ID="txtFromDate"
                                    TextMode="Date"
                                    CssClass="form-control"
                                    runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="">
                                <label>ToDate<span class="required">*</span></label>
                                <asp:TextBox
                                    ID="txtToDate"
                                    TextMode="Date"
                                    CssClass="form-control"
                                    runat="server"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="row px-3 pb-3">
                        <div class="col-md-3">
                            <div class="dropdown-wrapper">
                                <label>Campaign Type:<span class="required">*</span></label>
                                <asp:DropDownList
                                    ID="ddlCampaignType"
                                    runat="server"
                                    class="chosen-select"
                                    multiple>
                                    <%-- <asp:ListItem Text="Select" Value="" />
                                        <asp:ListItem Text="Add New" Value="" />
                                        <asp:ListItem Text="Wet Waste" Value="" />
                                        <asp:ListItem Text="Garden Waste" Value="" />
                                        <asp:ListItem
                                            Text="Criteria for details of closure of earth filling operations and completion of earth filing"
                                            Value="" />
                                        <asp:ListItem
                                            Text="Standards for Treatment and Processing of Solid Waste"
                                            Value="" />
                                        <asp:ListItem
                                            Text="Closure and Rehabilitation of Old Dumps"
                                            Value="" />
                                        <asp:ListItem
                                            Text="Criteria for Prevention of Pollution from Landfill Operations"
                                            Value="" />
                                        <asp:ListItem Text="Sources of Solid Waste" Value="" />
                                        <asp:ListItem Text="Dry Waste" Value="" />
                                        <asp:ListItem Text="anbl libbering campaign" Value="" />
                                        <asp:ListItem Text="Plastic Waste" Value="" />--%>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-5">
                            <div class="">
                                <label>Campaign Rules:<span class="required">*</span></label>
                                <asp:TextBox
                                    ID="txtCampaignRules"
                                    runat="server"
                                    CssClass="form-control"
                                    type="text"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="date-wrapper">
                                <label>Description</label>
                                <asp:TextBox ID="txtDescription" runat="server" Rows="2" class="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="row px-3 pb-3">
                        <div class="col-md-4">
                            <div class="date-wrapper">
                                <label>Objective:</label>
                                <%--   <textarea rows="2" class="form-control"></textarea>--%>
                                <asp:TextBox ID="txtObjective" runat="server" Rows="2" class="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="date-wrapper">
                                <label>Location:</label>
                                <asp:TextBox ID="txtLocation" runat="server" Rows="2" class="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="date-wrapper">
                                <label>Activity <span class="required">*</span></label>
                                <asp:DropDownList
                                    ID="ddlActivity"
                                    runat="server"
                                    class="chosen-select"
                                    multiple>
                                    <%-- <asp:ListItem Text="Add New" Value="" />
                                        <asp:ListItem Text="Youth Rally" Value="" />
                                        <asp:ListItem Text="School Rally" Value="" />
                                        <asp:ListItem Text="Poster/Film/Essay Competition" Value="" />
                                        <asp:ListItem Text="Plogathon" Value="" />
                                        <asp:ListItem Text="Cycle Rally" Value="" />
                                        <asp:ListItem
                                            Text="Waste Collection Drive - Plastic/E-Waste etc"
                                            Value="" />
                                        <asp:ListItem Text="Street Plays" Value="" />
                                        <asp:ListItem Text="Plastic Waste Management" Value="" />
                                        <asp:ListItem
                                            Text="Tranceperancy Plastic Waste Management"
                                            Value="" />
                                        <asp:ListItem Text="Tranceperancy" Value="" />--%>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="row px-3 pb-3">
                        <div class="col-md-4">
                            <div class="date-wrapper">
                                <label>Penality Rules:</label>
                                <asp:DropDownList
                                    ID="ddlPenalityRules"
                                    runat="server"
                                    class="chosen-select"
                                    multiple>
                                    <%--  <asp:ListItem Text="Add New" Value="" /> 
                                        <asp:ListItem
                                            Text="A fine of Rs 500 will be imposed for defecating on the street"
                                            Value="" />
                                        <asp:ListItem
                                            Text="A fine of Rs 100 will be imposed if burn garbage, drains, lakes, ghats"
                                            Value="" />
                                        <asp:ListItem
                                            Text="A Fine of Rs 300 will be imposed for throwing garbage on roads/public places"
                                            Value="" />--%>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="date-wrapper">
                                <label>Reward Parameter:</label>
                                <%--<textarea rows="2" class="form-control"></textarea>--%>
                                <asp:TextBox ID="txtReward" runat="server" Rows="2" class="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="date-wrapper">
                                <label>Participants: <span class="required">*</span></label>
                                <asp:DropDownList
                                    ID="ddlParticipants"
                                    runat="server"
                                    class="chosen-select"
                                    multiple>
                                    <%-- <asp:ListItem Text="1" Value="" />
                                    <asp:ListItem Text="2" Value="" />
                                    <asp:ListItem Text="3" Value="" />
                                    <asp:ListItem Text="4" Value="" />
                                    <asp:ListItem Text="5" Value="" />
                                    <asp:ListItem Text="Default" Value="" />--%>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="row px-3 pb-3">
                        <div class="col-md-auto">
                            <div class="date-wrapper">
                                <label>Upload CampaignRule PDF:</label>
                                <input type="file" class="d-block" />
                            </div>
                        </div>
                        <div class="col-md-auto">
                            <div class="date-wrapper">
                                <label>Upload Brochure:</label>
                                <input type="file" class="d-block" accept=".pdf, .doc, .docx"/>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="date-wrapper">
                                <label>Upload Google Form Link:</label>
                                <asp:TextBox
                                    ID="txtUploadGoogleFormLink"
                                    runat="server"
                                    CssClass="form-control"
                                    type="text"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="row px-3 pb-3 justify-content-center">
                        <div class="col-md-2">
                            <%--<button class="btn btn-info">Create Campaign</button>--%>
                            <asp:Button class="btn btn-info" ID="btnCampaign" runat="server" Text="Create Campaign" OnClick="btnCampaign_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="sweeper-coverage-report-section">
            <div class="sweeper-coverage-report">
                <div class="collapse show" id="tableCollapse2">
                    <div class="body collapsible active">
                        <asp:GridView ID="grdData" runat="server" CssClass="table-striped adhoctable" AutoGenerateColumns="true">
                            <Columns>
                              <asp:TemplateField ItemStyle-Width="30px" HeaderText="Edit">
                                    <ItemTemplate>
                                        <asp:LinkButton CssClass="btn btn-sm btn-info" ID="btnEdit" runat="server" Text="Edit" CommandName="EditImages" OnClick="btnEdit_Click"
                                            CommandArgument='<%# Eval("pk_campid") %>' />
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
                        columnDefs: [
                            { type: 'num', targets: [0, 1, 2] }, // Numeric sorting for columns 0 and 1.
                            { type: 'string', targets: [0, 1, 2] } // Alphanumeric sorting for columns 2 and 3.
                        ],
                        order: [0, 1, 2],
                    });
                }

                initializeDataTable(".adhoctable");
            });
        </script>
        <!-- Chosen Jquery Library Script -->
        <%-- <script src="Scripts/jquery-3.2.1.min.js"></script>--%>
        <script src="Scripts/chosen.jquery.js"></script>
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

            $(document).ready(function () {
                initializeChosen("#<%= ddlCampaignType.ClientID %>");
                initializeChosen("#<%= ddlParticipants.ClientID %>");
                initializeChosen("#<%= ddlPenalityRules.ClientID %>");
                initializeChosen("#<%= ddlActivity.ClientID %>");
            });
        </script>
        <!-- Chosen Jquery Library Script End -->
    </body>

</asp:Content>
