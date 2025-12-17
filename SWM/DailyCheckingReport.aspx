<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DailyCheckingReport.aspx.cs" Inherits="SWM.DailyCheckingReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.7.1/leaflet.js"></script>

        <link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css" />
        <script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"></script>

        <title>Daily Checking Reports</title>
        <!-- Bootstrap links -->
        <link rel="stylesheet"
            href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
            integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
            crossorigin="anonymous" />
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
            integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
            crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"
            integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut"
            crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"
            integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k"
            crossorigin="anonymous"></script>

        <script src="js/jquery-3.3.1.min.js"></script>
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
        <!-- Bootstrap links end -->
        <link href="css/global.css" rel="stylesheet" />
        <link href="css/fstdropdown.css" rel="stylesheet" />
    </head>
    <body>
        <section class="filters-section byProduct">
            <div class="filters-container">
                <div class="title d-flex justify-content-between">
                    <div class="d-flex align-items-center">
                        <i class="fa-solid fa-book"></i>
                        <h3>Daily Checking Report</h3>
                    </div>
                </div>
                <div class="body">
                    <div class="row px-3 pb-3">
                        <div class="col-md-2">
                            <label>Block Type</label>
                            <asp:DropDownList ID="ddlOptions" runat="server" CssClass="fstdropdown-select">
                                <asp:ListItem Value="0">Allblock</asp:ListItem>
                                <asp:ListItem Value="1">CT</asp:ListItem>
                                <asp:ListItem Value="2">PT</asp:ListItem>
                                <asp:ListItem Value="3">Urinals</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-2">
                            <label>Zone Name</label>
                            <asp:DropDownList ID="ddlZone" runat="server" AutoPostBack="true" class="fstdropdown-select" OnSelectedIndexChanged="ddlZone_SelectedIndexChanged">
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-2">
                            <label>Ward Name</label>
                            <asp:DropDownList ID="ddlWard" runat="server" class="fstdropdown-select" AutoPostBack="True" OnSelectedIndexChanged="ddlWard_SelectedIndexChanged">
                                <asp:ListItem Text="Select" Value="" />
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-2">
                            <label>Kothi Name</label>
                            <asp:DropDownList ID="ddlKothi" runat="server" class="fstdropdown-select" AutoPostBack="True">
                                <asp:ListItem Text="Select" Value="" />
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-2">
                            <div class="date-wrapper">
                                <label>From Date:</label>
                                <asp:TextBox ID="txtFromDate" TextMode="Date" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="date-wrapper">
                                <label>To Date:</label>
                                <asp:TextBox ID="txtToDate" TextMode="Date" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-2">
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
                        <div class="col-md-2">
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
                        <div class="col-md-auto">
                            <div class="d-flex h-100 align-items-end">
                                <asp:Button ID="Submitt" runat="server" Text="Submit" OnClick="ButtonSubmitt_Click" CssClass="btn btn-primary" />
                            </div>
                        </div>
                        <div class="col-md-auto">
                            <div class="d-flex h-100 align-items-end">
                                <asp:Button ID="btnAll" runat="server" Text="All" CssClass="btn btn-sm btn-info mt-3 mr-1" />
                                <asp:Button ID="btnVisited" runat="server" Text="Visited" CssClass="btn btn-sm btn-success mt-3 mr-1" />
                                <asp:Button ID="btnInvalid" runat="server" Text="Invalid" CssClass="btn btn-sm btn-warning text-white mt-3 mr-1" />
                                <asp:Button ID="btnUnvisited" runat="server" Text="Unvisited" CssClass="btn btn-sm btn-danger mt-3 mr-1" />
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
                                <h3>Summary Table :</h3>
                            </div>
                        </div>
                        <div class="downloads d-flex align-items-center" visible="true">
                            <button class="btn btn-light btn-sm p-0 outline-none" type="button" data-toggle="collapse" data-target="#tableCollapse" aria-expanded="false" aria-controls="tableCollapse">
                                <i class="fa-solid fa-chevron-down"></i>
                            </button>
                        </div>
                    </div>

                    <div class="collapse show" id="tableCollapse10">
                        <div class="body collapsible active">
                            <asp:GridView ID="SummaryTable" runat="server" AutoGenerateColumns="true" CssClass="table table-striped gvSummary">
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </section>

            <section class="sweeper-coverage-report-section">
                <div class="sweeper-coverage-report">
                    <div class="title dropdown-btn">
                        <div class="controls">
                            <div>
                                <h3>Wardwise Details :</h3>
                            </div>
                        </div>
                        <div class="downloads d-flex align-items-center" visible="true">
                            <button class="btn btn-light btn-sm p-0 outline-none" type="button" data-toggle="collapse" data-target="#tableCollapse" aria-expanded="false" aria-controls="tableCollapse">
                                <i class="fa-solid fa-chevron-down"></i>
                            </button>
                        </div>
                    </div>

                    <div class="collapse show" id="tableCollapse3">
                        <div class="body collapsible active">
                            <asp:GridView ID="WardWiseTable" runat="server" AutoGenerateColumns="false" CssClass="table table-striped WardWiseTable">
                                <Columns>
                                    <asp:BoundField DataField="Date" HeaderText="Date" />
                                    <asp:BoundField DataField="zone" HeaderText="zone" />
                                    <asp:BoundField DataField="ward" HeaderText="ward" />
                                    <asp:BoundField DataField="Total" HeaderText="total" />
                                    <asp:BoundField DataField="Cover" HeaderText="cover" />
                                    <asp:BoundField DataField="Uncover" HeaderText="uncover" />
                                    <asp:BoundField DataField="Invalid" HeaderText="invalid" />
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </section>

            <section class="sweeper-coverage-report-section">
                <div class="sweeper-coverage-report">
                    <div class="title dropdown-btn">
                        <div class="controls">
                            <div>
                                <h3>Kothiwise Details :</h3>
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
                            <asp:GridView ID="gvkothiwise" runat="server" AutoGenerateColumns="false" CssClass="table table-striped gvkothiwise">
                                <Columns>
                                    <asp:BoundField DataField="Date" HeaderText="Date" />
                                    <asp:BoundField DataField="zone" HeaderText="Zone" />
                                    <asp:BoundField DataField="ward" HeaderText="Ward" />
                                    <asp:BoundField DataField="Kothi" HeaderText="Kothi" />
                                    <asp:BoundField DataField="mokadam" HeaderText="Mokadam" />
                                    <asp:BoundField DataField="totalctpt" HeaderText="Total CTPT" />
                                    <asp:BoundField DataField="cover" HeaderText="Cover" />
                                    <asp:BoundField DataField="uncover" HeaderText="Uncover" />
                                    <asp:BoundField DataField="invalid" HeaderText="Invalid" />
                                    <asp:BoundField DataField="percentage" HeaderText="Percentage" />
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </section>

            <section class="sweeper-coverage-report-section">
                <div class="sweeper-coverage-report">
                    <div class="title dropdown-btn">
                        <div class="controls">
                            <div>
                                <h2>Pune Municipal Corporation</h2>
                                |
                            <h3>Daily Checking Report:</h3>
                            </div>
                        </div>

                        <div class="downloads d-flex align-items-center" visible="true">
                            <asp:Panel Visible="false" runat="server">
                                <asp:ImageButton ID="ImageButton1" src="Images/xls.png" runat="server" CssClass="mr-1" OnClick="btnexcel_Click" />
                                <asp:ImageButton ID="ImageButton2" src="Images/pdf.png" runat="server" CssClass="mr-1" OnClick="btnpdf_Click" />
                            </asp:Panel>
                            <button class="btn btn-light btn-sm p-0 outline-none" type="button" data-toggle="collapse" data-target="#tableCollapse1" aria-expanded="false" aria-controls="tableCollapse1">
                                <i class="fa-solid fa-chevron-down"></i>
                            </button>
                        </div>
                    </div>

                    <div class="collapse show" id="tableCollapse1">
                        <div class="body collapsible active">
                            <asp:GridView ID="gvdailychein" runat="server" AutoGenerateColumns="false" EmptyDataText="No data found." CssClass="gvdailychein" 
                                EnableViewState="false">
                                <Columns>
                                    <asp:BoundField DataField="ZoneName" HeaderText="ZoneName" />
                                    <asp:BoundField DataField="wardName" HeaderText="WardName" />
                                    <asp:BoundField DataField="BlockName" HeaderText="BlockName" />
                                    <asp:BoundField DataField="KothiName" HeaderText="KothiName" />
                                    <asp:BoundField DataField="Date" HeaderText="Date" />
                                    <asp:BoundField DataField="cleaningfrequency" HeaderText="Cleaning Frequency" />
                                    <asp:BoundField DataField="wateravalibility" HeaderText="Water Availability" />
                                    <asp:BoundField DataField="floorcleananddry" HeaderText="Floor Clean and Dry" />
                                    <asp:BoundField DataField="litterbinsavaliable" HeaderText="Litter Bins Available" />
                                    <asp:BoundField DataField="cleaningequipments" HeaderText="Cleaning Equipments" />
                                    <asp:BoundField DataField="sanitarynapkins" HeaderText="Sanitary Napkins" />
                                    <asp:BoundField DataField="logbookupdate" HeaderText="Logbook Update" />
                                    <asp:BoundField DataField="Status" HeaderText="Status" />
                                    <asp:BoundField DataField="location" HeaderText="Location" />
                                    <asp:BoundField DataField="Address" HeaderText="Address" />
                                    <asp:TemplateField HeaderText="Image">
                                        <ItemTemplate>
                                            <asp:Image ID="imgImage" runat="server" ImageUrl='<%# GetModifiedImageUrl(Eval("Image")) %>' Width="100px" Height="100px" CssClass="checking_image" data-toggle="modal" data-target="#exampleModal" />
                                            <%-- <asp:ImageButton type="button" data-toggle="modal" data-target="#exampleModalCenter" ID="imgImage" runat="server" ImageUrl='<%# Eval("image") %>' OnClientClick="return ShowImagePopup(this);" />--%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <%--                            <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="#exampleModalCenter" aria-hidden="true">
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
                            </div>--%>
                        </div>
                    </div>
                </div>
            </section>
        </asp:Panel>

        <%-- Image Pop up Modal --%>
        <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Image</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body d-flex justify-content-center align-items-center" id="imageWrapper">
                    </div>
                </div>
            </div>
        </div>
        <%-- Image Pop up Modal End --%>

        <script src="Scripts/fstdropdown.js"></script>
        <script>
            // PERFORMANCE OPTIMIZATION: Client-side validation to warn before fetching ALL data
            function validateBeforeSubmit() {
                var zoneId = $('#<%= ddlZone.ClientID %>').val();
                var wardId = $('#<%= ddlWard.ClientID %>').val() || '0';
                var kothiId = $('#<%= ddlKothi.ClientID %>').val() || '0';
                var fromDate = $('#<%= txtFromDate.ClientID %>').val();
                var toDate = $('#<%= txtToDate.ClientID %>').val();
                
                // Check if no filters are selected
                var noFilters = (zoneId == '0' || zoneId == '') && (wardId == '0' || wardId == '') && (kothiId == '0' || kothiId == '');
                
                if (noFilters && fromDate && toDate) {
                    var from = new Date(fromDate);
                    var to = new Date(toDate);
                    var daysDiff = Math.ceil((to - from) / (1000 * 60 * 60 * 24));
                    
                    if (daysDiff > 7) {
                        return confirm('WARNING: You are about to fetch data for ALL zones, wards, and kothis for ' + daysDiff + ' days.\n\nThis may take a very long time (2+ minutes).\n\nFor better performance:\n- Select a Zone, Ward, or Kothi\n- Limit date range to 7 days or less\n\nDo you want to continue?');
                    } else if (daysDiff > 3) {
                        return confirm('INFO: You are fetching data for ALL zones/wards/kothis for ' + daysDiff + ' days.\n\nThis may take longer. Consider selecting a Zone, Ward, or Kothi for faster results.\n\nDo you want to continue?');
                    }
                }
                
                return true; // Allow submission
            }
            
            $(document).ready(function () {
                // OPTIMIZED: Remove existing handlers before attaching to prevent duplicates
                // Attach validation to submit button (only once)
                $('#<%= Submitt.ClientID %>').off('click').on('click', function(e) {
                    if (!validateBeforeSubmit()) {
                        e.preventDefault();
                        return false;
                    }
                });
                
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
                                title: 'Daily Checking Report' + ' - ' + getFormattedDate(),
                                className: "btn btn-sm btn-success mb-2", // Add your Excel button class here
                            },
                            {
                                extend: "pdf",
                                text: "PDF <i class='fa-regular fa-file-pdf text-white'></i>",
                                title: 'Daily Checking Report' + ' - ' + getFormattedDate(),
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

                initializeDataTable(".gvkothiwise");
                initializeDataTable(".gvdailychein");
                initializeDataTable(".gvSummary");
                initializeDataTable(".WardWiseTable");
            });
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
            crossorigin="anonymous"></script>
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
            const dropdownBtn = document.querySelectorAll(".dropdown-btn");

            dropdownBtn.forEach((btn) => {
                btn.addEventListener("click", () => {
                    const body = btn.nextElementSibling;
                    body.classList.toggle("active");
                });
            });
        </script>
        <script>
            // OPTIMIZED: Use event delegation instead of attaching handlers to each image
            // This prevents multiple event handlers and improves performance
            $(document).ready(function() {
                const imageWrapper = document.getElementById('imageWrapper');
                
                // Use event delegation - attach handler once to document, works for all images
                $(document).off('click', '.checking_image').on('click', '.checking_image', function(e) {
                    e.preventDefault();
                    const img = this;
                    const currentImage = document.createElement('img');
                    currentImage.src = img.src;
                    if (imageWrapper) {
                        imageWrapper.innerHTML = '';
                        currentImage.style.width = '100%';
                        imageWrapper.appendChild(currentImage);
                    }
                });
            });
        </script>
    </body>
</asp:Content>
