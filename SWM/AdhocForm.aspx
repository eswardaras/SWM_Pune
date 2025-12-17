<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdhocForm.aspx.cs" Inherits="SWM.AdhocForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <link href="css/adhocform.css" rel="stylesheet" />
    <link
      href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css"
      rel="stylesheet"
    />
      <link href="css/fstdropdown.css" rel="stylesheet" />

         <!-- Bootstrap links -->
         <link
         rel="stylesheet"
         href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
         integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
         crossorigin="anonymous"
       />
       <script
         src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
         integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
         crossorigin="anonymous"
       ></script>
       <script
         src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"
         integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut"
         crossorigin="anonymous"
       ></script>
       <script
         src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"
         integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k"
         crossorigin="anonymous"
       ></script>
    
       <script
         src="http://code.jquery.com/jquery-3.3.1.min.js"
         integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
         crossorigin="anonymous"
       ></script>
       <link
         rel="stylesheet"
         href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css"
       />
       <script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
       <!-- Bootstrap links end -->
    <title>Adoc-form</title>
  </head>
  <body>
    <div class="content-container">
      <div class="first-container">
        <div class="header dropdown-btn">
          <div class="header-content">
            <i class="bx bxs-user"></i>
            <h4>Adhoc Form (Special-Waste)</h4>
          </div>
          <div class="drop-down">
            <div class="arrow-box">
              <i class="bx bx-chevron-down"></i>
            </div>
          </div>
        </div>

        <div class="info-container dropdown-body active">
          <div class="info-section">
            <h3>Name</h3>
            <div class="input-container">
                <asp:TextBox ID="txboxName" runat="server"></asp:TextBox>
              
            </div>
          </div>

              <div class="info-box">
                <h3>Contact No</h3>
                <!-- <div class="input-container"> -->
                <%--<input type="text" />--%>
               <asp:TextBox ID="txtbxMobile" runat="server"></asp:TextBox>
              </div class='dropdown-body_1'>
              <!-- <div class="info-section">
                <h3>Entity Type</h3>
                <div class="drop-container dropdown-btn">
                  <span>Select</span>
                  <div class="drop-box">
                    <i class="bx bx-chevron-down"></i>
                  </div>
                </div>
                <div class="dropdown-body_1">
                    <div class="search-box">
                      <input type="search" />
                    </div>
                    <div class="select">
                      <ul>
                        <li>Select</li>
                        <li>Hotel</li>
                        <li>Garden</li>
                        <li>Slaughter House</li>
                        <li>Bio-Waste</li>
                      </ul>
                    </div>
                </div>
              </div> -->

   <%--           <div class="zone-section-wrapper">
                <label>Entity Type</label>
               <select class="fstdropdown-select">
                <option value="0">Select</option>
                <option value="1">Hotel</option>
                <option value="2">Garden</option>
                <option value="3">Slaughter House</option>
                <option value="4">Bio-Waste</option>
                <!-- <option value="5">5</option>
                <option value="6">DEFAULT</option> -->
               </select>
              </div>--%>

            <div class="zone-section-wrapper">
    <label>Entity Type</label>
    <asp:DropDownList ID="ddlEntityType" runat="server" CssClass="fstdropdown-select">
        <asp:ListItem Text="Select" Value="0"></asp:ListItem>
        <asp:ListItem Text="Hotel" Value="1"></asp:ListItem>
        <asp:ListItem Text="Garden" Value="2"></asp:ListItem>
        <asp:ListItem Text="Slaughter House" Value="3"></asp:ListItem>
        <asp:ListItem Text="Bio-Waste" Value="4"></asp:ListItem>
    </asp:DropDownList>
</div>

          <!-- <div class="info-box">
            <h3>Entity Name</h3>
           <div class="input-container"> -->
            <!-- <input type="text" />
          </div> -->

         <div class="info-container dropdown-body active">
          <div class="info-section">
            <h3>Entity Name</h3>
            <div class="input-container">
                <asp:TextBox ID="txtEntityName" runat="server"></asp:TextBox>
              
            </div>
          </div>


          <div class="remark-section">
            <label>Remark</label>
            <div class="remark-container">
              <textarea name="" id="" cols="30" rows="10"></textarea>
            </div>
          </div>

          <div class="info-radio">
            <h3>Request Type</h3>
            <!-- <div class="input-container"> -->
            <div class="radio-container">
              <input type="radio" />
              <span>Special Waste</span>
            </div>
          </div>

          <!-- <div class="info-section">
            <h3>Zone Name</h3>
            <div class="input-container dropdown-btn">
              <span>Select</span>
               <input type="text" /> 
              <i class="bx bx-chevron-down"></i>
            </div>
            <div class="dropdown-body_1">
                <div class="search-container-rec">
                  <input type="search" />
                </div>
                <div class="list-drop">
                  <ul>
                    <li>Select</li>
                    <li>1</li>
                    <li>2</li>
                    <li>3</li>
                    <li>4</li>
                    <li>5</li>
                    <li>DEFAULT</li>
                  </ul>
                </div>
            </div>
          </div> -->

          <div class="zone-section-wrapper">
           <%-- <label>Zone Name</label>
           <select class="fstdropdown-select">
            <option value="0">Select</option>
            <option value="1">Hotel</option>
            <option value="2">Garden</option>
            <option value="3">Slaughter House</option>
            <option value="4">Bio-Waste</option>
            <option value="5">5</option>
            <option value="6">DEFAULT</option>
           </select>--%>


        <div class="dropdown-wrapper d-block">
            <h5>Zone Name</h5>
            <asp:DropDownList ID="ddlZone" runat="server" AutoPostBack="true" class="fstdropdown-select" OnSelectedIndexChanged="ddlZone_SelectedIndexChanged">
            </asp:DropDownList>
        </div>

        <div class="dropdown-wrapper d-block">
            <h5>Ward Name</h5>
            <asp:DropDownList ID="ddlWard" runat="server" class="fstdropdown-select" AutoPostBack="True" OnSelectedIndexChanged="ddlWard_SelectedIndexChanged">
                                      
            </asp:DropDownList>
        </div>

        <div class="dropdown-wrapper d-block">
            <h5>Kothi Name</h5>
            <asp:DropDownList ID="ddlKothi" runat="server" class="fstdropdown-select" AutoPostBack="True" OnSelectedIndexChanged="ddlKothi_SelectedIndexChanged">
                                      
            </asp:DropDownList>
        </div>
     <div class="dropdown-wrapper d-block">
            <h5>Mukadam Name</h5>
            <asp:DropDownList ID="ddlMukadam" runat="server" class="fstdropdown-select" AutoPostBack="True" >
                                      
            </asp:DropDownList>
        </div>

        <div class="dropdown-wrapper d-block">
            <h5>Supervisor Name</h5>
            <asp:DropDownList ID="ddlsupervisor1" runat="server" class="fstdropdown-select" AutoPostBack="True" >
                                      
            </asp:DropDownList>
        </div>
      

          </div>

       
            <asp:Panel ID="pnlAssign" runat="server" Style="display: none;">
                  <div class="dropdown-wrapper d-block">
            <h5>Supervisor Name</h5>
            <asp:DropDownList ID="ddlsupervisor2" runat="server" class="fstdropdown-select" AutoPostBack="True" >
                                      
            </asp:DropDownList>
        </div>
         <div class="dropdown-wrapper d-block">
            <h5>Vehicle Name</h5>
            <asp:DropDownList ID="ddlvehicle" runat="server" class="fstdropdown-select" AutoPostBack="True" >
                                      
            </asp:DropDownList>
        </div>
            <asp:Button ID="ButtonAssign" runat="server" Text="Assign" OnClick ="ButtonAssign_Click" />


              
                </asp:Panel>


          <!-- <div class="info-section">
            <h3>Ward Name</h3>
            <div class="input-container dropdown-btn">
              <span>Undefined</span>
              <input type="text" /> 
              <i class="bx bx-chevron-down"></i>
            </div>
            <div class="dropdown-body_1">
                <div class="search-container-rec">
                  <input type="search" />
                </div>
                <div class="list">
                  <ul>
                    <li>No Matches found</li>
                  </ul>
                </div>
            </div>
          </div> -->



<%--          <div class="zone-section-wrapper">
            <label>Kothi Name</label>
           <select class="fstdropdown-select">
            <option value="0">Undefined</option>
            <option value="1">No Matches Found</option>
            <!-- <option value="2">Garden</option>
            <option value="3">Slaughter House</option>
            <option value="4">Bio-Waste</option> -->
            <!-- <option value="5">5</option>
            <option value="6">DEFAULT</option> -->
           </select>
          </div>

          <div class="zone-section-wrapper">
            <label>Mokadum Name</label>
           <select class="fstdropdown-select">
            <option value="0">Undefined</option>
            <option value="1">No Matches Found</option>
            <!-- <option value="2">Garden</option>
            <option value="3">Slaughter House</option>
            <option value="4">Bio-Waste</option> -->
            <!-- <option value="5">5</option>
            <option value="6">DEFAULT</option> -->
           </select>
          </div>

          <div class="zone-section-wrapper">
            <label>Supervisor Name</label>
           <select class="fstdropdown-select">
            <option value="0">Undefined</option>
            <option value="1">No Matches Found</option>
            <!-- <option value="2">Garden</option>
            <option value="3">Slaughter House</option>
            <option value="4">Bio-Waste</option> -->
            <!-- <option value="5">5</option>
            <option value="6">DEFAULT</option> -->
           </select>
          </div>--%>

          

          <div class="btn-box">
                 <asp:Button ID="btSubmitt" runat="server" Text="Submitt" OnClick ="ButtonSubmitt_Click" />
          </div>
        </div>
      </div>
        <div class="second-container">
        <div class="header-one dropdown-btn">
          <div class="header-content">
            <i class="bx bxs-book"></i>
            <h4>Adhoc Request Details (Last 15 days)</h4>
          </div>
          <!-- <div class="drop-down">
              <div class="arrow-box">
                <i class="bx bx-chevron-down"></i>
              </div>
            </div> -->
        </div>
        <div class="table-container">

<asp:GridView ID="adhocTable" runat="server" CssClass="table-striped" AutoGenerateColumns="false">
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
                <asp:Button ID="btnComplete" runat="server" Text="Complete" CommandName="Complete" CommandArgument='<%# Container.DataItemIndex %>' OnClick="btnWorkStatus_Click" />
                <asp:Button ID="btnIncomplete" runat="server" Text="Incomplete" CommandName="Incomplete" CommandArgument='<%# Container.DataItemIndex %>' OnClick="btnWorkStatus_Click" />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Assign">
            <ItemTemplate>
              <asp:Button ID="btnAssign" runat="server" Text="Assign" CommandName="Assign" CommandArgument='<%# Container.DataItemIndex %>' OnClick="btnSaveAssignment_Click" />
            </ItemTemplate>
         </asp:TemplateField>
              <asp:TemplateField HeaderText="Delete">
            <ItemTemplate>
              <asp:Button ID="btnDelete" runat="server" Text="Delete" CommandName="Delete" CommandArgument='<%# Container.DataItemIndex %>' OnClick="btnDeleteRequest_Click" />
          
<%--                <asp:Panel ID="pnlAssignment" runat="server" Visible="false">
                    <!-- Controls inside the expanded panel -->
                    <asp:TextBox ID="txtAssignment" runat="server"></asp:TextBox>
                    <asp:Button ID="btnSaveAssignment" runat="server" Text="Save" CommandName="Save" CommandArgument='<%# Container.DataItemIndex %>' OnClick="btnSaveAssignment_Click" />
                </asp:Panel>--%>
            </ItemTemplate>
         </asp:TemplateField>
    </Columns>
</asp:GridView>
<%--          <table id="adhoc-table" class="table-striped">
            <thead>
              <tr>
                <th>Sr. No</th>
                <th>Date</th>
                <th>Zone</th>
                <th>Ward</th>
                <th>Kothi</th>
                <th>Name</th>
                <th>Entity Type</th>
                <th>Entity Name</th>
                <th>Mokadum/ <br />Supervisor</th>
                <th>Assign Status</th>
                <th>Work Status</th>
                <th>
                  Assign <br />
                  Vehicle
                </th>
                <th>Delete <br>  Request</th>
                <th>Platform</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <th>1</th>
                <th>27 Apr <br />2023</th>
                <th>3</th>
                <th>Sinhgad <br />Road</th>
                <th>Sun City <br />Aarogya <br />kothi</th>
                <th>NA</th>
                <th>Garden</th>
                <th>jalpujan soc <br />ektanagari</th>
                <th>Avinash/ <br />Pokale</th>
                <th>Pending</th>
                <th>
                  <div class="green">Completed</div>
                  <div class="red">In-Completed</div>
                </th>
                <th><i class="bx bx-edit"></i></th>
                <th><i class="bx bx-trash"></i></th>
                <th>Android</th>
              </tr>

              <tr>
                <th>2</th>
                <th>27 Apr <br />2023</th>
                <th>3</th>
                <th>Sinhgad <br />Road</th>
                <th>Sun City <br />Aarogya <br />kothi</th>
                <th>NA</th>
                <th>Garden</th>
                <th>jalpujan soc <br />ektanagari</th>
                <th>Avinash/ <br />Pokale</th>
                <th>Pending</th>
                <th>
                  <div class="green">Completed</div>
                  <div class="red">In-Completed</div>
                </th>
                <th><i class="bx bx-edit"></i></th>
                <th><i class="bx bx-trash"></i></th>
                <th>Android</th>
              </tr>

              <tr>
                <th>3</th>
                <th>27 Apr <br />2023</th>
                <th>3</th>
                <th>Sinhgad <br />Road</th>
                <th>Sun City <br />Aarogya <br />kothi</th>
                <th>NA</th>
                <th>Garden</th>
                <th>jalpujan soc <br />ektanagari</th>
                <th>Avinash/ <br />Pokale</th>
                <th>Pending</th>
                <th>
                  <div class="green">Completed</div>
                  <div class="red">In-Completed</div>
                </th>
                <th><i class="bx bx-edit"></i></th>
                <th><i class="bx bx-trash"></i></th>
                <th>Android</th>
              </tr>

              <tr>
                <th>4</th>
                <th>27 Apr <br />2023</th>
                <th>3</th>
                <th>Sinhgad <br />Road</th>
                <th>Sun City <br />Aarogya <br />kothi</th>
                <th>NA</th>
                <th>Garden</th>
                <th>jalpujan soc <br />ektanagari</th>
                <th>Avinash/ <br />Pokale</th>
                <th>Pending</th>
                <th>
                  <div class="green">Completed</div>
                  <div class="red">In-Completed</div>
                </th>
                <th><i class="bx bx-edit"></i></th>
                <th><i class="bx bx-trash"></i></th>
                <th>Android</th>
              </tr>

              <tr>
                <th>5</th>
                <th>27 Apr <br />2023</th>
                <th>3</th>
                <th>Sinhgad <br />Road</th>
                <th>Sun City <br />Aarogya <br />kothi</th>
                <th>NA</th>
                <th>Garden</th>
                <th>jalpujan soc <br />ektanagari</th>
                <th>Avinash/ <br />Pokale</th>
                <th>Pending</th>
                <th>
                  <div class="green">Completed</div>
                  <div class="red">In-Completed</div>
                </th>
                <th><i class="bx bx-edit"></i></th>
                <th><i class="bx bx-trash"></i></th>
                <th>Android</th>
              </tr>
            </tbody>--%>
      </div>

      </div>


      </div>



      </div>




      </div>





</asp:Content>
