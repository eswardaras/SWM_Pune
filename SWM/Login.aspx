<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="SWM.Login" Async="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="css/global.css" />
    <script
        src="https://kit.fontawesome.com/29598b743f.js"
        crossorigin="anonymous"></script>
    <!-- Bootstrap links -->
    <link
        rel="stylesheet"
        href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
        integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
        crossorigin="anonymous" />
    <script
        src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
        integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
    <script
        src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"
        integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut"
        crossorigin="anonymous"></script>
    <script
        src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"
        integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k"
        crossorigin="anonymous"></script>
    <script src="js/jquery-3.3.1.min.js"></script>
    <!-- Bootstrap links end -->
    <link
        rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
    <title>Login</title>
</head>
<body>
    <form runat="server">
        <div class="container-fluid login_page pb-2 d-flex justify-content-center align-items-center">
            <div
                class="container text-center d-flex justify-content-center align-items-center">
                <div class="form-col">
                    <div class="animate__animated animate__slideInDown">
                        <div class="row d-flex justify-content-center align-items-center mt-2">
                            <div class="col-3 login__companylogo1">
                                <img src="Images/pmcsmart.png" alt="">
                            </div>
                            <div class="col-3 login__companylogo2">
                                <img src="Images/pmc_logo.png" alt="">
                            </div>
                            <div class="col-auto login__companylogo3">
                                <img src="Images/logo.png" alt="">
                            </div>
                        </div>
                        <h2>Lets build a</h2>
                        <h1 class="text-nowrap">Clean India Digitally</h1>
                        <div class="row justify-content-center">
                            <div class="col-2">
                                <img
                                    src="Images/truck_icon.png"
                                    class="swm_icons"
                                    alt="truck icon" />
                            </div>
                            <div class="col-2">
                                <img
                                    src="Images/garbage_throw.png"
                                    class="swm_icons"
                                    alt="person throwing garbage in trash can icon" />
                            </div>
                            <div class="col-2">
                                <img
                                    src="Images/broom_icon.png"
                                    class="swm_icons"
                                    alt="broom icon" />
                            </div>
                            <div class="col-2">
                                <img
                                    src="Images/hand_icon.png"
                                    class="swm_icons"
                                    alt="hand icon" />
                            </div>
                            <div class="col-2">
                                <img
                                    src="Images/mask_icon.png"
                                    class="swm_icons"
                                    alt="mask icon" />
                            </div>
                        </div>
                        <div
                            class="py-1 my-sm-4 d-flex justify-content-center align-items center">
                            <h2 class="m-0 title_banner">Pune Municipal Corporation</h2>
                        </div>
                    </div>
                    <div
                        class="form-container bg-light rounded px-lg-5 px-3 py-3 mx-lg-4 mx-sm-0 animate__animated animate__zoomIn">

                        <h2 class="mt-1 mb-3">Login</h2>

                        <div
                            class="d-flex align-items-center border-green rounded pl-2 mb-3">
                            <i class="fa-solid fa-user"></i>
                            <%--<input type="text" class="form-control border-0" value="scstech@gmail.com" />--%>
                            <asp:TextBox ID="txtUser" runat="server" class="form-control border-0" placeholder="Enter Username" value="scstech@gmail.com"></asp:TextBox>
                        </div>
                        <div class="d-flex align-items-center border-green rounded pl-2 mb-3">
                            <i class="fa-solid fa-lock cursor-pointer" onclick="showPass()"></i>
                            <%--<input type="password" class="form-control border-0" value="iswmpune22" />--%>
                            <asp:TextBox ID="txtPassward" runat="server" class="form-control border-0" type="password" placeholder="Enter Password" value="iswm_admin@2025"></asp:TextBox>

                        </div>
                        <div class="d-flex align-items-center border-green rounded pl-2">
                            <span id="captchaContainer" runat="server" class="fw-bold"></span>
                            <%--<input type="password" class="form-control border-0" value="iswmpune22" />--%>
                            <asp:TextBox ID="captchaTxt" runat="server" class="form-control border-0" type="text" placeholder="Enter captcha"></asp:TextBox>
                            <asp:LinkButton ID="reloadCaptchaButton" runat="server" OnClick="ReloadCaptcha_Click">
                                <i class="fa-solid fa-rotate-right mr-2 cursor-pointer"></i>
                            </asp:LinkButton>
                        </div>
                        <div class="d-flex justify-content-end">
                            <a href="">Forgot Password?</a>
                        </div>
                        <div class="d-flex justify-content-start align-items-center mb-2">
                            <input type="checkbox" id="rememberChbx" checked />
                            <label class="mb-0 ml-1" for="rememberChbx">Remember me</label>
                        </div>
                        <div class="d-flex justify-content-center my-3">
                            <%--<button class="btn btn-success px-4" type="button" data-bs-toggle="modal" data-bs-target="#exampleModal">Login</button>--%>
                            <asp:Button ID="btnLogin" runat="server" Text="Submit" OnClick="btnLogin_Click" class="btn btn-success px-4" />
                             <%--<input type="hidden" name="CsrfToken" value="<%= CsrfToken %>" />--%>
                        </div>
                        
 
                        <p class="mt-sm-3 mt-lg-3">
                            Disclaimer:The content available on the website is provided Pune
                            Municipal Corporation and all the information available on this
                            website is authentic. Copyright © 2018
                            <a href="https://pmc.gov.in/mr/swm" target="_blank">Pune Municipal Corporation </a>. All Rights Reserved. Designed & Developed By:
                            <a href="https://www.scstechindia.com/" target="_blank">SCS Tech India Pvt. Ltd.</a>
                        </p>

                    </div>
                </div>
            </div>
        </div>
    </form>
    <script
        src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
        integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
        crossorigin="anonymous"></script>
    <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"
        integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+"
        crossorigin="anonymous"></script>
    <script>
        const showPass = () => {
            const passInput = document.getElementById('<%= txtPassward.ClientID  %>');
            if (passInput.type === 'password') {
                passInput.type = 'text';
            } else {
                passInput.type = 'password';
            }
        }
    </script>
</body>

</html>



