<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UploadReport.aspx.cs" Inherits="SWM.UploadReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
      <%--<input type="file" name="fileUpload" id="fileUpload" />--%>
    <input type="submit" value="Upload" />
        <div>
            <h2>Excel Upload</h2>
            <asp:FileUpload ID="fileUpload" runat="server" />
            <asp:Button ID="btnUpload" runat="server" Text="Upload" OnClick="btnUpload_Click" />
            <div>
                <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>
            </div>
        </div>
   
</asp:Content>
