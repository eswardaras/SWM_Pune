<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SWEEPERMaster.aspx.cs" Inherits="SWM.SWEEPERMaster" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <!-- Other meta tags, styles, and scripts -->
    <meta http-equiv="refresh" content="180">
    <title>Sweeper Details</title>
</head>
<body>
    <form id="form1" runat="server">
         <section class="sweeper-coverage-report-section">
                <div class="sweeper-coverage-report">
                    <div class="title dropdown-btn">
                        <div class="controls">
                            <div>
                                <h2>Pune Municipal Corporation</h2>
                                
                            <h3>Sweeper Details</h3>
                            </div>
                        </div>

                    <%--    <div class="downloads d-flex align-items-center" visible="true">
                            <asp:ImageButton ID="btnexcel2" src="Images/xls.png" runat="server" CssClass="mr-1" OnClick="btnexcel_Click" />
                            <asp:ImageButton ID="btnpdf2" src="Images/pdf.png" runat="server" CssClass="mr-1" OnClick="btnpdf_Click" />
                            <button class="btn btn-light btn-sm p-0 outline-none" type="button" data-toggle="collapse" data-target="#tableCollapse2" aria-expanded="false" aria-controls="tableCollapse2">
                                <i class="fa-solid fa-chevron-down"></i>
                            </button>
                        </div>--%>
                    </div>

                    <div class="collapse show" id="tableCollapse2">
                        <div class="body collapsible active">
                            <asp:GridView ID="grdData" runat="server" CssClass="table-striped secondTable" AutoGenerateColumns="true" OnRowDataBound="grdData_RowDataBound">
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </section>

    </form>
</body>
</html>
