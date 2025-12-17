<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GroupReport.aspx.cs" Inherits="SWM.GroupReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
      <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css"
            rel="stylesheet" />
        <link rel="stylesheet" href="css/fstdropdown.css">


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

        <script src="http://code.jquery.com/jquery-3.3.1.min.js"
            integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
            crossorigin="anonymous"></script>
        <link rel="stylesheet"
            href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css" />
        <script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
        <!-- Bootstrap links end -->
        <title>View Reports</title>
        <link rel="stylesheet" href="css/coveragereport.css">
    </head>
    <body>
        <div class="main-container">
            <div class="heading">
                <div class="heading-content">
                    <i class='bx bxs-book'></i>
                    <h4>View Reports</h4>
                </div>
                <div class="search-btn">
                    <i class='bx bx-search'></i>
                    <%-- <span>Search</span>--%><asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" CssClass="search-btn" />
                </div>
            </div>
            <div class="zone-section-container">
                <div class="zone-section-wrapper">
                    <div class="zone-section">
                        <label>Reports Name</label>
                        <asp:DropDownList ID="ddlReportsName" runat="server" class="fstdropdown-select">
                            <asp:ListItem Text="Breakdown"></asp:ListItem>
                            <asp:ListItem Text="Odometer"></asp:ListItem>
                          
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="zone-section">
                    <label>Zone Name</label>
                    <asp:DropDownList ID="ddlZoneName" runat="server" class="fstdropdown-select">
                        <asp:ListItem Text="All Zone"></asp:ListItem>
                        <asp:ListItem Text="1"></asp:ListItem>
                        <asp:ListItem Text="2"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="zone-section-wrapper">
                    <label>Ward Name</label>
                    <asp:DropDownList ID="ddlWard" runat="server" class="fstdropdown-select">
                        <asp:ListItem Text="All Ward"></asp:ListItem>
                        <asp:ListItem Text="1"></asp:ListItem>
                        <asp:ListItem Text="2"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="zone-section-wrapper">
                    <label>Vehicle Name</label>
                    <asp:DropDownList ID="ddlVehicle" runat="server" class="fstdropdown-select">
                        <asp:ListItem Text="All Vehicle"></asp:ListItem>
                        <asp:ListItem Text="1"></asp:ListItem>
                        <asp:ListItem Text="2"></asp:ListItem>
                    </asp:DropDownList>

                </div>
               
                <div class="duration-section">
                    <div class="from">
                        <div class="name-section">
                            <label>From Date</label>
                        </div>
                        <input type="date">
                    </div>
                    <div class="from">
                        <div class="name-section">
                            <label>To Date</label>
                        </div>
                        <input type="date">
                    </div>
                </div>
                <div class="zone-section-wrapper">
                    <label>Start Time</label>
                    <asp:DropDownList ID="ddlStartTime" runat="server" class="fstdropdown-select">
                        <asp:ListItem Text="1"></asp:ListItem>
                        <asp:ListItem Text="2"></asp:ListItem>
                    </asp:DropDownList>

                </div>
                <div class="zone-section-wrapper">
                    <label>End Time</label>
                    <asp:DropDownList ID="ddlEndTime" runat="server" class="fstdropdown-select">
                        <asp:ListItem Text="1"></asp:ListItem>
                        <asp:ListItem Text="2"></asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>


            <div class="table-rec">
                <div class="table-head">
                    <div class="text">
                        <div class="text-one">
                            <h1>Pune Municipal Corporation |</h1>
                            <h2 id="hheader" runat="server" visible="false">
                                <asp:Label ID="lblReportName" runat="server" Text=""></asp:Label>
                                <span>: From &nbsp; 
                                <asp:Label ID="lblFromDate" runat="server" Text=""></asp:Label>&nbsp; 
                                to &nbsp; 
                                <asp:Label ID="lblEndDate" runat="server" Text=""></asp:Label></span></h2>

                        </div>
                   
                        <div class="image-icon" id="divExport" runat="server" visible="false">
                            <asp:ImageButton ID="imgxls" src="Images/xls.png" runat="server" OnClick="imgxls_Click" />
                            <asp:ImageButton ID="imgpdf" src="Images/pdf.png" runat="server" OnClick="imgpdf_Click" />
                        </div>
                    </div>
                </div>
                <div class="table-container">

                    <table id="grd_Report1" class="table-striped">
                        <asp:GridView ID="grd_Odometer" runat="server" AutoGenerateColumns="false" ShowFooter="true" class="table-striped table-feeder" Visible="false">
                            <Columns>
                            </Columns>
                        </asp:GridView>

                        <asp:GridView ID="grd_Breakdown" runat="server" AutoGenerateColumns="false" ShowFooter="true" class="table-striped table-feeder" Visible="false">
                            <Columns>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Date">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID" runat="server"
                                            Text='<%#Eval("DATE")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Vehicle">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID" runat="server"
                                            Text='<%#Eval("Vehicle")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="Status">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID" runat="server"
                                            Text='<%#Eval("Status")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="30px" HeaderText="User">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID" runat="server"
                                            Text='<%#Eval("User")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>                               
                            </Columns>
                        </asp:GridView>

                    </table>
                </div>
            </div>
        </div>

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
                $(".table-feeder").prepend($("<thead></thead>").append($(this).find("tr:first"))).DataTable();
            });

        </script>
        <script src="Scripts/fstdropdown.js"></script>

    </body>
</asp:Content>
