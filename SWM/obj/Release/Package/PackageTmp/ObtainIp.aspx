<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ObtainIp.aspx.cs" Inherits="SWM.ObtainIp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <title>Fetch IP</title>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-3">
            <div class="row">
                <div class="col-md-2">
                    <asp:Button ID="btnFetch" runat="server" CssClass="btn btn-primary" Text="fetch Ip" OnClick="btnFetch_Click" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>
