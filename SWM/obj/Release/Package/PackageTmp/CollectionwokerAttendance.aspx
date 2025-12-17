<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CollectionwokerAttendance.aspx.cs" Inherits="SWM.CollectionwokerAttendance" %>

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
        <!-- DataTable Links -->
        <link
            rel="stylesheet"
            href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css" />
        <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/buttons/2.0.1/js/dataTables.buttons.min.js"></script>
        <script src="https://cdn.datatables.net/buttons/2.0.1/js/buttons.html5.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.6.0/jszip.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
        <!-- DataTable Links End -->
        <link href="css/global.css" rel="stylesheet" />
        <title>Collection Worker Attendance</title>
    </head>

    <body>
        <section class="filters-section adhocForm">
            <div class="filters-container">
                <div class="title d-flex justify-content-between">
                    <div class="d-flex align-items-center">
                        <i class="bx bxs-user"></i>
                        <h3>Collection Worker Attendance</h3>
                    </div>
                </div>
                <div class="body">
                    <div class="row px-3 pb-3">
                        <div class="col-sm-2">
                            <label>Zone Name</label>
                            <asp:DropDownList ID="ddlZone" runat="server" AutoPostBack="true" class="fstdropdown-select" OnSelectedIndexChanged="ddlZone_SelectedIndexChanged">
                                <asp:ListItem Text="Select" Value="" />
                            </asp:DropDownList>
                        </div>
                        <div class="col-sm-2">
                            <label>Ward Name</label>
                            <asp:DropDownList ID="ddlWard" runat="server" class="fstdropdown-select" AutoPostBack="True" OnSelectedIndexChanged="ddlWard_SelectedIndexChanged">
                                <asp:ListItem Text="Select" Value="" />
                            </asp:DropDownList>
                        </div>
                        <div class="col-sm-2">
                            <label>Prabhag Name</label>
                            <asp:DropDownList ID="ddlPrabhag" runat="server" class="fstdropdown-select" AutoPostBack="True">
                                <asp:ListItem Text="Select" Value="" />
                            </asp:DropDownList>
                        </div>
                        <div class="col-sm-2 d-none">
                            <label>Kothi Name</label>
                            <asp:DropDownList ID="ddlKothi" runat="server" class="fstdropdown-select" AutoPostBack="True">
                                <asp:ListItem Text="Select" Value="" />
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
                        <div class="col-md-2">
                            <label>Quarterly/Half Yearly/Yearly</label>
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
                        <div class="col-sm-auto">
                            <div class="h-100 d-flex align-items-end">
                                <asp:Button ID="Submitt" runat="server" Text="Search" OnClick="ButtonSubmitt_Click" CssClass="btn btn-success" OnClientClick="return validateDateModal()" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <input type="hidden" id="CitywisePresent" runat="server" />
        <input type="hidden" id="CitywiseAbsent" runat="server" />
        <input type="hidden" id="ZonewisePresent" runat="server" />
        <input type="hidden" id="ZonewiseAbsent" runat="server" />
        <input type="hidden" id="Zonewisepercent" runat="server" />

        <input type="hidden" id="cityWiseChartData" runat="server" />
        <input type="hidden" id="zoneWiseChartData" runat="server" />
        <input type="hidden" id="zonewisetable" runat="server" />
        <asp:Panel ID="chartWrapper" runat="server" Visible="false">
            <div class="container mt-2 d-none">
                <div class="row border rounded">
                    <div class="col-sm-6">
                        <div class="row">
                            <div class="col-12 bg-light border">
                                <h2 class="text-center text-secondary">City Wise</h2>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-12 border">
                                <div style="height: 400px" class="d-flex justify-content-center align-items-center position-relative">
                                    <canvas runat="server" id="cityWise"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="row">
                            <div class="col-12 bg-light border">
                                <h2 class="text-center text-secondary">Zone Wise</h2>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-12 border">
                                <div style="height: 400px" class="d-flex justify-content-center align-items-center position-relative">
                                    <canvas runat="server" id="zoneWise"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <section class="sweeper-coverage-report-section">
                <div class="sweeper-coverage-report">
                    <div class="title dropdown-btn">
                        <div class="controls">
                            <div>
                                <h2>Wardwise Attendance</h2>
                            </div>
                        </div>

                        <div class="downloads d-flex align-items-center" visible="true">
                            <button class="btn btn-light btn-sm p-0 outline-none" type="button" data-toggle="collapse" data-target="#tableCollapse" aria-expanded="false" aria-controls="tableCollapse">
                                <i class="fa-solid fa-chevron-down"></i>
                            </button>
                        </div>
                    </div>


                    <div class="collapse show" id="tableCollapse">
                        <div class="body collapsible active">
                            <div class="table-responsive">
                                <asp:GridView ID="gvwardwise" runat="server" AutoGenerateColumns="False" CssClass="table table-striped gvwardwise">
                                    <Columns>
                                        <asp:BoundField DataField="Date" HeaderText="Date" />
                                        <asp:BoundField DataField="Zone" HeaderText="Zone" />
                                        <asp:BoundField DataField="ward" HeaderText="Ward" />
                                        <asp:BoundField DataField="Total" HeaderText="Total" />
                                        <asp:BoundField DataField="Present" HeaderText="Present" />
                                        <asp:BoundField DataField="Absent" HeaderText="Absent" />
                                        <asp:BoundField DataField="Ping" HeaderText="Ping" />
                                        <asp:BoundField DataField="Leave/Holiday" HeaderText="Leave/Holiday" />
                                        <asp:BoundField DataField="Present Percent" HeaderText="Present Percent" />
                                        <asp:BoundField DataField="Device Percent Excluding Leave/Holiday" HeaderText="Device Percent Excluding Leave/Holiday" />

                                        <%-- <asp:BoundField DataField="Percent" HeaderText="Percent" />--%>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <section class="sweeper-coverage-report-section">
                <div class="sweeper-coverage-report">
                    <div class="title dropdown-btn">
                        <div class="controls">
                            <div>
                                <h2>Prabhagwise Attendance</h2>
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
                            <div>
                                <asp:GridView ID="gvPrabhag" runat="server" AutoGenerateColumns="False" CssClass="table table-striped gvPrabhag">
                                    <Columns>
                                        <asp:BoundField DataField="Date" HeaderText="Date" />
                                        <asp:BoundField DataField="Zone" HeaderText="Zone" />
                                        <asp:BoundField DataField="ward" HeaderText="Ward" />
                                        <asp:BoundField DataField="Prabhag" HeaderText="Prabhag" />
                                        <asp:BoundField DataField="Total" HeaderText="Total" />
                                        <asp:BoundField DataField="Present" HeaderText="Present" />
                                        <asp:BoundField DataField="Absent" HeaderText="Absent" />
                                        <asp:BoundField DataField="Ping" HeaderText="Ping" />
                                        <asp:BoundField DataField="Leave/Holiday" HeaderText="Leave/Holiday" />
                                        <asp:BoundField DataField="Present Percent" HeaderText="Present Percent" />
                                        <asp:BoundField DataField="Device Percent Excluding Leave/Holiday" HeaderText="Device Percent Excluding Leave/Holiday" />

                                        <%-- <asp:BoundField DataField="Percent" HeaderText="Percent" /> --%>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <section class="sweeper-coverage-report-section">
                <div class="sweeper-coverage-report">
                    <div class="title dropdown-btn">
                        <div class="controls">
                            <div>
                                <h2>Attendance Report</h2>
                            </div>
                        </div>

                        <div class="downloads d-flex align-items-center" visible="true">
                            <asp:ImageButton ID="btnexcel" src="Images/xls.png" runat="server" CssClass="mr-1" OnClick="btnexcel_Click" />
                            <asp:ImageButton ID="btnpdf" src="Images/pdf.png" runat="server" CssClass="mr-1" OnClick="btnpdf_Click" />


                            <button class="btn btn-light btn-sm p-0 outline-none" type="button" data-toggle="collapse" data-target="#tableCollapse_2" aria-expanded="false" aria-controls="tableCollapse_2">
                                <i class="fa-solid fa-chevron-down"></i>
                            </button>
                        </div>
                    </div>

                    <div class="collapse show" id="tableCollapse_2">
                        <div class="body collapsible active">
                            <div>
                                <%--<asp:GridView ID="gvAttendance" runat="server" AutoGenerateColumns="False" OnRowDataBound="YourGridView_RowDataBound" OnRowCommand="yourGridView_RowCommand" AllowPaging="true" AllowSorting="true" OnPageIndexChanging="OnPaging">--%>
                                <%--CssClass="table table-striped gvAttendance">--%>
                                <%--<Columns>
                                        <asp:BoundField DataField="Zone" HeaderText="Zone" />
                                        <asp:BoundField DataField="ward" HeaderText="Ward" />
                                        <asp:BoundField DataField="Prabhag" HeaderText="Prabhag" />
                                        <asp:BoundField DataField="Date" HeaderText="Date" />
                                        <asp:BoundField DataField="Name" HeaderText="Name" />
                                        <asp:BoundField DataField="EmpType" HeaderText="EmpType" />
                                        <asp:BoundField DataField="IMEI" HeaderText="IMEI" />
                                        <asp:BoundField DataField="InTime" HeaderText="InTime" />
                                        <asp:BoundField DataField="OutTime" HeaderText="OutTime" />
                                        <asp:BoundField DataField="Work Percentage" HeaderText="Work Percentage" />
                                        <asp:BoundField DataField="Status" HeaderText="Status" />
                                        <asp:TemplateField HeaderText="Viewroute">
                                            <ItemTemplate>
                                                <asp:Button ID="btnComplete" runat="server" Text="View route" CommandName="ViewRoute" CommandArgument='<%# String.Format("{0},{1},{2},{3},{4}", Eval("pk_vehicleid"), Eval("routeid"),Eval("Kothi_id"),Eval("Intime"),Eval("outtime")) %>' CssClass="btn btn-sm btn-info" />
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:BoundField DataField="pk_vehicleid" HeaderText="pk_vehicleid" Visible="false" />
                                        <asp:BoundField DataField="routeid" HeaderText="routeid" Visible="false" />


                                    </Columns>
                                </asp:GridView>--%>

                                <asp:GridView ID="gvAttendance" runat="server" AutoGenerateColumns="False"
                                    CssClass="table table-striped gvAttendance">
                                    <Columns>
                                        <asp:BoundField DataField="Zone" HeaderText="Zone" />
                                        <asp:BoundField DataField="ward" HeaderText="Ward" />
                                        <asp:BoundField DataField="Prabhag" HeaderText="Prabhag" />
                                        <asp:BoundField DataField="Date" HeaderText="Date" />
                                        <asp:BoundField DataField="Name" HeaderText="Name" />
                                        <asp:BoundField DataField="EmpType" HeaderText="EmpType" />
                                        <asp:BoundField DataField="IMEI" HeaderText="IMEI" />
                                        <asp:BoundField DataField="InTime" HeaderText="InTime" />
                                        <asp:BoundField DataField="OutTime" HeaderText="OutTime" />
                                        <asp:BoundField DataField="Work Percentage" HeaderText="Work Percentage" />
                                        <asp:BoundField DataField="Status" HeaderText="Status" />
                                        <asp:TemplateField HeaderText="Viewroute">
                                            <ItemTemplate>
                                                <asp:Button ID="btnComplete" runat="server" Text="View route" CommandName="ViewRoute" CommandArgument='<%# String.Format("{0},{1},{2},{3},{4}", Eval("pk_vehicleid"), Eval("routeid"),Eval("Kothi_id"),Eval("Intime"),Eval("outtime")) %>' CssClass="btn btn-sm btn-info" />
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:BoundField DataField="pk_vehicleid" HeaderText="pk_vehicleid" Visible="false" />
                                        <asp:BoundField DataField="routeid" HeaderText="routeid" Visible="false" />


                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </asp:Panel>


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
                                <p class="text-danger font-weight-bold">Warning:- <span class="text-dark">From Date cannot be greater than To Date</span></p>
                            </center>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <%-- Popup Modal Section End--%>

        <%-- Toast Section --%>
        <div class="toast" role="alert" aria-live="assertive" aria-atomic="true" id="element">
            <div class="toast-header">
                <img src="..." class="rounded mr-2" alt="...">
                <strong class="mr-auto">Bootstrap</strong>
                <small>11 mins ago</small>
                <button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="toast-body">
                Hello, world! This is a toast message.
            </div>
        </div>
        <%-- Toast Section End--%>

        <script src="Scripts/fstdropdown.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
            crossorigin="anonymous"></script>
        <script>


            function showPopupmap(vehicleName, latitude, longitude) {
                // Initialize the map
                var map = L.map('map').setView([latitude, longitude], 12);

                // Add a tile layer (e.g., OpenStreetMap)
                L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                    attribution: 'Map data © OpenStreetMap contributors',
                }).addTo(map);

                // Create a marker
                var marker = L.marker([latitude, longitude]).addTo(map);

                // Create a popup
                marker.bindPopup("<b>" + vehicleName + "</b>").openPopup();

                // Create a LatLngBounds object with the marker's coordinates
                var markerBounds = L.latLngBounds([marker.getLatLng()]);

                // Fit the map bounds to include the marker
                map.fitBounds(markerBounds);

                // Pan the map towards the right
                //var panAmount = -1000; // Adjust the pan amount as needed
                //map.panBy([panAmount, 0], { animate: false });
                $('#popupmap').modal('show');

            }

        </script>
        <script>
            var cityWiseData = document.getElementById("MainContent_cityWiseChartData").value;

            // Parse the chart data
            var cityLabels = ["Present", "Absent"];
            var cityValues = cityWiseData.split(",").map(Number);
            const cityWiseTotalAttendance = cityValues.reduce((a, c) => a + c, 0);

            const ctx = document.getElementById("MainContent_cityWise");

            new Chart(ctx, {
                type: "pie",
                data: {
                    labels: cityLabels,
                    datasets: [
                        {
                            //label: "City Wise",
                            data: cityValues,
                            borderWidth: 1,
                        },
                    ],
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            position: "right",
                            labels: {
                                generateLabels: function (chart) {
                                    var data = chart.data;
                                    if (data.labels.length && data.datasets.length) {
                                        return data.labels.map(function (label, i) {
                                            var dataset = data.datasets[0];
                                            var value = dataset.data[i];
                                            return {
                                                text: label + ": " + value,
                                                fillStyle: dataset.backgroundColor[i],
                                                hidden: isNaN(dataset.data[i]), // Hide labels with NaN values (if any)
                                                index: i,
                                            };
                                        });
                                    }
                                    return [];
                                },
                            },
                        },
                        title: {
                            display: true,
                            text: `Total ${cityWiseTotalAttendance}`,
                            font: {
                                weight: 'bold',
                                size: 20,
                            },
                            position: 'bottom',
                            padding: {
                                top: 20,
                            },
                        },
                    },
                },
            });
        </script>
        <script>
            const zoneWise = document.getElementById("<%= zoneWise.ClientID %>");
            const zoneWiseAttendance = document.getElementById('<%= zonewisetable.ClientID %>').value;

            //var zoneLabels = ["Present", "Absent"];
            //var zoneValues = zoneWiseData.split(",").map(Number);
            //const zoneWiseTotalAttendance = zoneValues.reduce((a, c) => a + c, 0);

            //new Chart(zoneWise, {
            //    type: "bar",
            //    data: {
            //        labels: ["Attendance"],
            //        datasets: [
            //            {
            //                label: "Present",
            //                data: [zoneValues[0]],
            //                backgroundColor: "rgba(54, 162, 235, 1)",
            //            },
            //            {
            //                label: "Absent",
            //                data: [zoneValues[1]],
            //                backgroundColor: "rgba(255, 99, 132, 1)",
            //            },
            //        ],
            //    },
            //    options: {
            //        indexAxis: "y",
            //        scales: {
            //            x: {
            //                beginAtZero: true,
            //                display: false,
            //            },
            //            y: {
            //                stacked: true,
            //                /*display: false,*/
            //            },
            //        },
            //        responsive: true,
            //        plugins: {
            //            legend: {
            //                position: "bottom",
            //                labels: {
            //                    generateLabels: function (chart) {
            //                        var data = chart.data;
            //                        if (data.labels.length && data.datasets.length) {
            //                            return data.datasets.map(function (dataset, i) {
            //                                var value = dataset.data[0];
            //                                return {
            //                                    text: dataset.label + ": " + value,
            //                                    fillStyle: dataset.backgroundColor,
            //                                    hidden: isNaN(value), // Hide labels with NaN values (if any)
            //                                    index: i,
            //                                };
            //                            });
            //                        }
            //                        return [];
            //                    },
            //                },
            //            },
            //            title: {
            //                display: true,
            //                text: `Total ${zoneWiseTotalAttendance}`,
            //                font: {
            //                    weight: 'bold',
            //                    size: 20,
            //                },
            //                position: 'top',
            //                padding: {
            //                    top: 20,
            //                },
            //            },
            //        },
            //        layout: {
            //            padding: {
            //                left: 10,
            //                right: 10,
            //            },
            //        },
            //        barPercentage: 0.2,
            //        categoryPercentage: 0.4,
            //    },
            //});

            function createLineChart(chartData) {
                const zoneWiseAttendanceData = JSON.parse(chartData);
                console.log(zoneWiseAttendanceData);

                const labels = [];
                const presentData = [];
                const absentData = [];
                let ultimateTotalZoneWise = null;

                zoneWiseAttendanceData.forEach(zoneData => {
                    labels.push(`Zone ${zoneData.Zone}`);
                    presentData.push(zoneData.Present);
                    absentData.push(zoneData.Absent);
                });

                const totalPresent = presentData.reduce((total, value) => total + value, 0);
                const totalAbsent = absentData.reduce((total, value) => total + value, 0);
                const totalZoneWise = totalPresent + totalAbsent;

                new Chart(zoneWise, {
                    type: "bar",
                    data: {
                        labels: labels,
                        datasets: [
                            {
                                label: "Present",
                                data: presentData,
                                backgroundColor: "rgba(54, 162, 235, 1)",
                            },
                            {
                                label: "Absent",
                                data: absentData,
                                backgroundColor: "rgba(255, 99, 132, 1)",
                            },
                        ],
                    },
                    options: {
                        indexAxis: "y",
                        plugins: {
                            legend: {
                                position: 'bottom',
                                labels: {
                                    generateLabels: function (chart) {
                                        const labels = Chart.defaults.plugins.legend.labels.generateLabels(chart);
                                        labels.forEach(label => {
                                            if (label.text === 'Present') {
                                                label.text = `Present: ${totalPresent}`;
                                            } else if (label.text === 'Absent') {
                                                label.text = `Absent: ${totalAbsent}`;
                                            }
                                        });
                                        return labels;
                                    },
                                },
                            },
                            title: {
                                display: true,
                                text: `Total ${totalZoneWise}`,
                                font: {
                                    weight: 'bold',
                                    size: 20,
                                },
                                position: 'bottom',
                                padding: {
                                    top: 20,
                                },
                            },
                        },
                        scales: {
                            x: {
                                stacked: true,
                                barPercentage: 0.7,
                                categoryPercentage: 0.8,
                            },
                            y: {
                                stacked: true,
                            },
                        },
                        responsive: true,
                        layout: {
                            padding: {
                                left: 10,
                                right: 10,
                            },
                        },
                        barPercentage: 0.6,
                        categoryPercentage: 0.8,
                    },
                });

            }

            if (zoneWiseAttendance) {
                createLineChart(zoneWiseAttendance);
            }
        </script>
        <script>
            $(document).ready(function () {
                function initializeDataTable(tableElement) {
                    $(tableElement).prepend($("<thead></thead>").append($(tableElement).find("tr:first"))).DataTable({
                        pageLength: 5,
                        dom:
                            "<'row'<'col-sm-12 col-md-6'B><'col-sm-12 col-md-6'f>>" +
                            "<'row'<'col-sm-12'tr>>" +
                            "<'row justify-content-between'<'col-sm-12 col-md-auto d-flex align-items-center'l><'col-sm-12 col-md-auto'i><'col-sm-12 col-md-auto'p>>",
                        buttons: [
                            {
                                extend: "excelHtml5",
                                text: "Excel <i class='fas fa-file-excel text-white'></i>",
                                title: document.title + ' - ' + getFormattedDate(),
                                className: "btn btn-sm btn-success mb-2", // Add your Excel button class here
                            },
                            {
                                extend: "pdf",
                                text: "PDF <i class='fa-regular fa-file-pdf text-white'></i>",
                                title: 'Collection Worker Attendance Report' + ' - ' + getFormattedDate(),
                                className: "btn btn-sm btn-danger mb-2", // Add your Excel button class here
                                customize: function (doc) {
                                    // Set custom page size (width x height)
                                    doc.pageOrientation = "landscape"; // or "portrait" for portrait orientation
                                    doc.pageSize = "A4"; // or an array: [width, height]

                                    // Set custom margins (left, right, top, bottom)
                                    doc.pageMargins = [20, 20, 20, 20];
                                },
                            },
                            // "pdf",
                            // "csvHtml5",
                        ],
                        language: {
                            lengthMenu: "_MENU_  records per page",
                            sSearch: "<img src='Images/search.png' alt='search'>",
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
                        order: [0, 1, 2],
                    });
                }

                function getFormattedDate() {
                    const today = new Date();
                    const options = { year: 'numeric', month: 'short', day: 'numeric' };
                    return today.toLocaleDateString('en-US', options);
                }

                initializeDataTable(".gvPrabhag");
                initializeDataTable(".gvwardwise");
                initializeDataTable(".gvAttendance");
            });
        </script>
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
            function validateDateModal() {
                const fromDate = new Date(document.getElementById('<%= txtFromDate.ClientID %>').value);
                const toDate = new Date(document.getElementById('<%= txtToDate.ClientID %>').value);

                if (fromDate > toDate) {
                    const modalBtn = document.getElementById('modalBtn').click();
                    return false;
                }

                return true;
            }
        </script>
    </body>
</asp:Content>
