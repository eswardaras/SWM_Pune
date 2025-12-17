<%@ Page Title="" EnableEventValidation="false" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="registernewdevice.aspx.cs" Inherits="SWM.registernewdevice" %>

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
        <!-- Bootstrap links end -->
        <link href="css/global.css" rel="stylesheet" />
        <link href="css/fstdropdown.css" rel="stylesheet" />
        <title>Document</title>
    </head>
    <body>
        <asp:Panel ID="formPanel_main" runat="server" Visible="true">
            <section class="filters-section adhocForm container-fluid pt-3" id="mainForm" runat="server">
                <div class="filters-container border-0">
                    <div class="title d-flex justify-content-between p-0 border">
                        <div class="d-flex justify-content-between align-items-center mx-1">
                            <i class="fa-solid fa-truck mx-2"></i>
                            <h3>Register New Device</h3>
                        </div>
                        <button class="btn btn-light" id="togglerBtn" type="button">
                            <i class="fa-solid fa-chevron-down"></i>
                        </button>
                    </div>
                    <div class="body border border-top-0 filters" id="togglerContent">
                        <div class="row px-3 pb-3">
                            <div class="col-md-2">
                                <div class="dropdown-wrapper">
                                    <label>IMEI</label>
                                    <asp:TextBox ID="txtimei" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="date-wrapper datepicker">
                                    <label>FromDate</label>
                                    <asp:TextBox ID="txtFromDate" TextMode="Date" runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="date-wrapper datepicker">
                                    <label>ToDate</label>
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
                            <div class="col-md-auto">
                                <div class="d-flex align-items-end h-100">
                                    <asp:Button
                                        type="button"
                                        ID="btn1"
                                        OnClick="btnSearch_Click"
                                        runat="server"
                                        Text="Search"
                                        CssClass="btn btn-success" />
                                    <asp:Button
                                        ID="btn2"
                                        type="button"
                                        runat="server"
                                        OnClick="btnCancel_Click"
                                        Text="Cancel"
                                        CssClass="btn btn-danger mx-2" />
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="d-flex align-items-end h-100">
                                    <asp:Button
                                        type="button"
                                        ID="newDeviceBtn"
                                        OnClick="addDevice_Click"
                                        runat="server"
                                        Text="Add New Device"
                                        CssClass="btn btn-info" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </asp:Panel>

        <asp:Panel ID='formPanel' runat="server" Visible="false">
            <form>
                <section
                    class="filters-section adhocForm container-fluid"
                    id="newDeviceForm" runat="server">
                    <%--style="display: none" >--%>
                    <div class="filters-container border-0">
                        <div class="title d-flex justify-content-between p-0 border">
                            <div class="d-flex justify-content-between align-items-center mx-1  ">
                                <i class="fa-solid fa-truck mx-2"></i>
                                <h3>Register New Device</h3>
                            </div>
                            <button class="btn btn-light toggler__btn" type="button">
                                <i class="fa-solid fa-chevron-down"></i>
                            </button>
                        </div>
                        <div class="body border border-top-0 filters toggler__content">
                            <div class="row px-3 pb-2">
                                <div class="col-md-2">
                                    <label>Account ID</label>
                                    <asp:DropDownList ID="ddlAccountId" runat="server" class="fstdropdown-select">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="row px-3 pb-2">
                                <div class="col-md-4">
                                    <label>New Vehicle ID</label>
                                    <asp:TextBox ID="txtVehicleName" runat="server" CssClass="form-control" required="true"></asp:TextBox>
                                    <span class="text-info example">ex: MH12AK1234</span>
                                </div>
                                <div class="col-md-4">
                                    <label>Frame Type</label>
                                    <asp:TextBox ID="txframetype" runat="server" CssClass="form-control" required="true"></asp:TextBox>
                                </div>
                                <div class="col-md-2">
                                    <label>PCB Version</label>
                                    <asp:DropDownList ID="ddlpcbtype" runat="server" CssClass="fstdropdown-select">
                                        <asp:ListItem Value="0">5.4</asp:ListItem>
                                        <asp:ListItem Value="1">5.3</asp:ListItem>
                                        <asp:ListItem Value="2">5.2</asp:ListItem>
                                        <asp:ListItem Value="3">5.1</asp:ListItem>
                                        <asp:ListItem Value="3">4.0</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="row px-3 pb-2">
                                <div class="col-md-4">
                                    <label>Vehicle Type</label>
                                    <asp:DropDownList ID="ddlVehicletype" runat="server" CssClass="fstdropdown-select">
                                    </asp:DropDownList>
                                    <span class="text-info example">Specify vehicle type, BUS, CAR, CAB, TRUCK etc</span>
                                </div>
                                <div class="col-md-4">
                                    <label>Device Company</label>
                                    <asp:DropDownList ID="ddlcompany" runat="server" CssClass="fstdropdown-select">
                                    </asp:DropDownList>
                                </div>

                                 <div class="col-md-2">
                                     <label>Vendor Name</label>
                                <asp:DropDownList ID="dllvendor" runat="server" CssClass="fstdropdown-select" EnableViewState="true">
                                </asp:DropDownList>
                                      </div>
                              
															<div class="col-md-2">
																<label>Employee Type</label>
																<asp:DropDownList ID="ddlEmployeeType" runat="server" CssClass="fstdropdown-select" EnableViewState="true">
																</asp:DropDownList>
															</div>

															<div class="col-md-2">
																<label>Worker Type</label>
																<asp:DropDownList ID="ddlWorkerType" runat="server" CssClass="fstdropdown-select" EnableViewState="true">
																</asp:DropDownList>
															</div>

                                <div class="col-md-2">
                                    <label>Device Type</label>
                                    <asp:DropDownList ID="ddlDevicetype" runat="server" CssClass="fstdropdown-select">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="row px-3 pb-2">
                                <div class="col-md-4">
                                    <label>IMEI Number</label>
                                    <asp:TextBox ID="txtInputImei" runat="server" CssClass="form-control" required="true"></asp:TextBox>
                                    <span class="text-info example">Device Unique ID</span>
                                </div>
                                <div class="col-md-4">
                                    <label>SIM Phone Number</label>
                                    <div class="d-flex">
                                        <asp:TextBox ID="txtSimPhone" runat="server" CssClass="form-control" required="true" type="number" MaxLength="10"></asp:TextBox>
                                        <button class="btn btn-sm btn-primary mx-2" type="button">
                                            <i class="fa fa-search text-light"></i>
                                        </button>
                                    </div>
                                    <span class="text-info example">10/13 digit SIM number without country code. ex: 9876543210</span>
                                </div>
                                <div class="col-md-2">
                                    <label>SIM Service Provider</label>
                                    <asp:DropDownList ID="ddlOperator" runat="server" CssClass="fstdropdown-select">
                                        <asp:ListItem Value="0">AIRTEL</asp:ListItem>
                                        <asp:ListItem Value="1">VODAFONE</asp:ListItem>
                                        <asp:ListItem Value="2">IDEA</asp:ListItem>
                                        <asp:ListItem Value="3">RELIANCE</asp:ListItem>
                                        <asp:ListItem Value="2">BSNL</asp:ListItem>
                                        <asp:ListItem Value="2">TATA_DOCOMO</asp:ListItem>
                                        <asp:ListItem Value="2">TELENOR</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="row px-3 pb-2">
                                <div class="col-md-4">
                                    <label>Vehicle Other Name</label>
                                    <asp:TextBox ID="txtVehicleothername" runat="server" CssClass="form-control"></asp:TextBox>
                                    <span class="text-info example">ex: MH01AK8888</span>
                                </div>
                               <div class="col-md-4">
    <label>Current Odometer</label>
    <asp:TextBox ID="txtCurrentOdo" runat="server" CssClass="form-control" type="number" required="required"></asp:TextBox>
    <span class="text-info example">Current Vehicle Odometer Reading</span>
</div>
                                <div class="col-md-2">
                                    <label>Voltage Type</label>
                                    <div>
                                        <asp:RadioButton ID="rbNormalRadioButton" runat="server" Text="Normal" GroupName="VoltageType" Checked="True" />
                                        <asp:RadioButton ID="rbReverseRadioButton" runat="server" Text="Reverse" GroupName="VoltageType" />
                                    </div>
                                </div>
                            </div>
                            <div class="row px-3 pb-2">
                                <div class="col-md-4">
                                    <div class="row">
                                        <div class="col-md-8">
                                            <label>Fuel Factor</label>
                                            <span class="text-info example">(Multiply with actual device fuel value)</span>
                                            <asp:TextBox ID="txtFuelFactor" runat="server" CssClass="form-control" Text="1" type="number" value="1"></asp:TextBox>
                                        </div>
                                        <div class="col-md-3 d-flex align-items-end">
                                            <asp:DropDownList ID="ddlYesNo" runat="server" CssClass="fstdropdown-select">
                                                <asp:ListItem Value="0">Yes</asp:ListItem>
                                                <asp:ListItem Value="1" Selected>No</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <label>Fuel Tank</label>
                                    <asp:TextBox ID="txtFuelTank" runat="server" CssClass="form-control" type="number"></asp:TextBox>
                                </div>
                                <div class="col-md-2">
                                    <label>Fuel Voltage</label>
                                    <div>
                                        <asp:RadioButton ID="rb5Volts" runat="server" Text="5 Volts" GroupName="FuelVoltageGroup" Checked="True" />
                                        <asp:RadioButton ID="rb9Volt" runat="server" Text="9 Volts" GroupName="FuelVoltageGroup" />
                                    </div>
                                </div>
                            </div>
                            <div class="row px-3 pb-2">
                                <div class="col-md-4">
                                    <label>Vehicle Mileage Type</label>
                                    <div>
                                        <asp:RadioButton ID="rbKmwise" runat="server" Text="Km.Wise" GroupName="VehicleMileage" Checked="True" />
                                        <asp:RadioButton ID="rbHrwise" runat="server" Text="Hr.Wise" GroupName="VehicleMileage" />
                                        <asp:RadioButton ID="rbBoth" runat="server" Text="Both" GroupName="VehicleMileage" />
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <label>Vehicle Mileage</label>
                                    <asp:TextBox ID="txtvehiclMileage" runat="server" CssClass="form-control" type="number"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row px-3 pb-2">
                                <div class="col-md-2">
                                    <div class="date-wrapper datepicker">
                                        <label>Set Device Installation Date</label>

                                        <asp:TextBox ID="txInstallationdate" TextMode="Date" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="date-wrapper end_datepicker">
                                        <label>Set Device Expiry</label>
                                        <asp:TextBox ID="txexpirydate" TextMode="Date" runat="server"></asp:TextBox>
                                        <span class="text-info example text-nowrap">Device Expiry date will deactive the device on this date.</span>
                                    </div>
                                </div>
                            </div>
                            <div class="row px-3 pb-2">
                                <div class="col-md-12 d-flex justify-content-center">
                                    <asp:Button
                                        ID="Button1"
                                        type="button"
                                        OnClick="BtnSaveDevice_Click"
                                        runat="server"
                                        Text="Save Changes"
                                        CssClass="btn btn-success mx-2" />
                                    <asp:Button
                                        ID="Button2"
                                        type="button"
                                        OnClick="btnCancel_Click"
                                        runat="server"
                                        Text="Cancel"
                                        CssClass="btn btn-danger"
                                        CausesValidation="false" />
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </form>
        </asp:Panel>

        <asp:Panel ID='tableWrapper' runat="server" Visible="false">
            <section class="sweeper-coverage-report-section">
                <div class="sweeper-coverage-report">
                    <div class="collapse show" id="tableCollapse2">
                        <div class="body collapsible active">
                            <asp:GridView
                                ID="gvDevices"
                                runat="server"
                                CssClass="table-striped adhoctable"
                                AutoGenerateColumns="false">
                                <Columns>
                                    <asp:BoundField DataField="imei" HeaderText="IMEI" />
                                    <asp:BoundField DataField="device" HeaderText="Device Type" />
                                    <asp:BoundField DataField="softverID" HeaderText="softver" />
                                    <asp:BoundField DataField="TIME" HeaderText="Date Time" />
                                    <asp:BoundField DataField="ping" HeaderText="Ping Time" />
                                    <asp:TemplateField HeaderText="Register">
                                        <ItemTemplate>
                                            <asp:Button ID="btnRegister" type="button" runat="server" Text="Register" OnClick="btnRegister_Click" CommandName="ViewRoute" CommandArgument='<%# Container.DataItemIndex %>' CssClass="btn btn-sm btn-primary" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </section>
        </asp:Panel>

        <script>
            const dateInput = document.querySelectorAll('.filters .date-wrapper.datepicker input');
            const currentDate = new Date().toISOString().substr(0, 10);

            dateInput.forEach(input => {
                if (!input.value) {
                    input.value = currentDate;
                }
            });
        </script>
        <script>
            const dateInput1 = document.querySelectorAll('.filters .date-wrapper.end_datepicker input');
            const currentDate1 = new Date();
            currentDate1.setFullYear(currentDate1.getFullYear() + 1);
            const oneYearAhead = currentDate1.toISOString().substr(0, 10);

            dateInput1.forEach(input => {
                if (!input.value) {
                    input.value = oneYearAhead;
                }
            });
        </script>
        <script>
            $(document).ready(function () {
                $("#togglerBtn").click(function () {
                    $("#togglerContent").slideToggle("fast");
                });

                function collapseContent(button, content) {
                    $(button).click(function () {
                        $(content).slideToggle("fast");
                    });
                }

                collapseContent(".toggler__btn", ".toggler__content");
            });
        </script>
        <script src="Scripts/fstdropdown.js"></script>
        <script>
            $(document).ready(function () {
                $(".adhoctable")
                    .prepend($("<thead></thead>").append($(this).find("tr:first")))
                    .DataTable({
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
