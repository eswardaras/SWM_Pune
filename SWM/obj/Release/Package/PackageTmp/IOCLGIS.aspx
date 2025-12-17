<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="IOCLGIS.aspx.cs" Inherits="SWM.IOCLGIS" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
        <style>
        .logo_main {
            /*-webkit-filter: drop-shadow(1px 1px 0 black) drop-shadow(-1px -1px 0 black);
            filter: drop-shadow(1px 1px 0 black) drop-shadow(-1px -1px 0 white);*/
        }
    </style>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid pt-2">
            <div class="d-flex align-items-center justify-content-between border-0 rounded" style="background: #0071C6">
                <div class="mx-2">
                    <a href="IOCLDash.aspx" class="d-flex align-items-center text-decoration-none">
                        <img src="Images/indianOilLogo.png" style="width: 30px" class="my-1 logo_main"/>
                        <p class="mx-3 mb-0 text-white" style="font-weight: bold">>Go to - Multimedia Dashboard</p>
                    </a>
                </div>
                <div>
                    <a href="https://www.scstechindia.com/" target="_blank">
                        <img src="Images/logo.png" style="width: 100px" class="logo_main"/>
                    </a>
                </div>
            </div>
        </div>
        <div>
            <div class="card-sub-container" style="height: calc(100vh - 72px)">
                <iframe id="myIframe" scrolling="yes" frameborder="1" runat="server"
                    style="position: relative; height: 100%; width: 100%;" class="border-0">
                    <span>iframe is not supported.</span>
                </iframe>
            </div>
        </div>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
</body>
</html>
