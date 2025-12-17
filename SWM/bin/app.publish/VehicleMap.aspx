<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="VehicleMap.aspx.cs" Inherits="SWM.VehicleMap" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
      <div class="card-sub-container">      
          <iframe src="http://192.168.0.100:8508//" id="myIframe" scrolling="yes" frameborder="1"
            style="position: relative; height: 100%; width: 100%;">
            <span>iframe is not supported.</span>
        </iframe>
    </div>
</asp:Content>
