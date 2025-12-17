<%@ Page Title="FleetMap" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FleetMap.aspx.cs" Inherits="SWM.FleetMap" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <div class="card-sub-container">      
          <iframe  id="myIframe" scrolling="yes" frameborder="1" runat="server"
            style="position: relative; height: 100%; width: 100%;">
            <span>iframe is not supported.</span>
        </iframe>
    </div>
</asp:Content>
