<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FeederDashboard.aspx.cs" Inherits="SWM.FeederDashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <div class="card-sub-container">
      <%--scsserver--%>
       
          <iframe  id="myIframe" runat="server" scrolling="yes" frameborder="1"
            style="position: relative; height: 100%; width: 100%;">
            <span>iframe is not supported.</span>
        </iframe>
    </div>
</asp:Content>
