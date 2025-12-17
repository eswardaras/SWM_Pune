<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="SWM.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="card-sub-container">
        <iframe src="http://127.0.0.1:8000//" id="myIframe" scrolling="yes" frameborder="1"
            style="position: relative; height: 100%; width: 100%;">
            <span>iframe is not supported.</span>
        </iframe>
    </div>
</asp:Content>
