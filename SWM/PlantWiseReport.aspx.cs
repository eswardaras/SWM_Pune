using System;
using SWM.BAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.IO;
using OfficeOpenXml;
using SWM.MODEL;

namespace SWM
{
    public partial class PlantWiseReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {

                if (!IsPostBack)
                {
                    BindRamp();
                    //string csrfToken = Request.Form["CsrfToken"];

                    //if (CsrfTokenManager.ValidateCsrfToken(csrfToken))
                    //{
                    //    // CSRF token is valid, proceed with the action
                    //    BindRamp();
                    //}
                    //else
                    //{
                    //    // Invalid CSRF token, handle the error
                    //    Response.Redirect("Login.aspx");
                    //}

                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "RampWiseReport.cs >> Method Page_Load()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }

       
        private void BindRamp()
        {
            try
            {
                RampBAL bAL = new RampBAL();
                DatewiseWeightReport mAP = new DatewiseWeightReport();
                //=====ZONE=====//
                //"begin tran t
                //exec proc_SweeperRouteCoverageReportNew @mode = 11,@vehicleId = 0,@AccId = 11401,@ZoneId = 0,@WardId = 0,@startdate = default,@enddate = default,@stime = default,@etime = default,@RptName = default,@Report = default,@Zone = default,@Ward = default,@WorkingType = default,@RouteId = 0,@AdminID = 0,@RoleID = 0
                //rollback tran t"
                //==sp ref==//
                DataSet ds = bAL.GetPlant(11, 0, 11401);
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        // Set the dropdown list's data source and bind the data


                        ddlRamp.DataSource = ds.Tables[0];
                        ddlRamp.DataTextField = "RMM_NAME"; // Field to display as option text
                        ddlRamp.DataValueField = "RMM_ID"; // Field to use as option value
                        ddlRamp.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "RampWiseReport.cs >> Method Page_Load()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {

            try
            {
                if (Convert.ToDateTime(txtFromDate.Text) > Convert.ToDateTime(txtToDate.Text))
                {
                    string script = "alert('ToDate cannot be less than FromDate');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "Warning Message", script, true);
                    return;
                }
                FirstTable.DataSource = null;
                FirstTable.DataBind();
                SecondTable.DataSource = null;
                SecondTable.DataBind();
                ThirdTable.DataSource = null;
                ThirdTable.DataBind();
                // Example dates (replace these with your actual dates)
                DateTime fromdate = DateTime.Parse(txtFromDate.Text);
                DateTime todate = DateTime.Parse(txtToDate.Text);

                // Calculate the difference between the two dates
                TimeSpan difference = todate - fromdate;

                RampBAL bAL = new RampBAL();
                DatewiseWeightReport mAP = new DatewiseWeightReport();
                //=====ZONE=====//
                //"begin tran t
                //exec proc_SweeperRouteCoverageReportNew @mode = 11,@vehicleId = 0,@AccId = 11401,@ZoneId = 0,@WardId = 0,@startdate = default,@enddate = default,@stime = default,@etime = default,@RptName = default,@Report = default,@Zone = default,@Ward = default,@WorkingType = default,@RouteId = 0,@AdminID = 0,@RoleID = 0
                //rollback tran t"
                //==sp ref==//
                DataSet ds = bAL.GetOnlyplantReport(Convert.ToInt32(ddlRamp.SelectedValue), Convert.ToDateTime(txtFromDate.Text), Convert.ToDateTime(txtToDate.Text));
                if (ds.Tables.Count > 0)
                {
                    if (difference.TotalDays > 31)
                    {
                        string script = "alert('Data exported successfully!');";
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
                        GenerateExcelDirectly(ds.Tables[0], "PlantWiseTripReport" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
                    }
                    else
                    {
                        if (ds.Tables[0].Rows.Count > 0)
                        {

                            FirstTable.DataSource = ds.Tables[0];
                            FirstTable.DataBind();
                            SecondTable.DataSource = ds.Tables[1];
                            SecondTable.DataBind();
                            ThirdTable.DataSource = ds.Tables[2];
                            ThirdTable.DataBind();
                        }

                    }

                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "RampWiseReport.cs >> Method btnSearch_Click()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
            tableWrapper.Visible = true;
        }

        protected void GenerateExcelDirectly(DataTable dataTable, string fileName)
        {
            ExcelPackage.LicenseContext = LicenseContext.NonCommercial; // Set the license context

            using (var package = new ExcelPackage())
            {
                var worksheet = package.Workbook.Worksheets.Add("Attendance Report");

                DataTable dt = new DataTable();
                // Populate dt with data from the GridView or your data source
                // For example: dt = GetDataFromGridView(gridView);
                dt = dataTable;//; GetDataFromGridView(gridView);
                // Write DataTable content to Excel worksheet
                worksheet.Cells["A1"].LoadFromDataTable(dt, true);

                Response.Clear();
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AddHeader("content-disposition", "attachment;filename=" + fileName + ".xlsx");
                Response.BinaryWrite(package.GetAsByteArray());
                Response.End();
            }
        }
        protected void btnpdf_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                if (((System.Web.UI.Control)sender).ID == "btnpdf1")
                {
                    if (FirstTable.Rows.Count > 0)
                        GeneratePDF(FirstTable, "PlantWise Report" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
                }
                if (((System.Web.UI.Control)sender).ID == "btnpdf2")
                {
                    if (SecondTable.Rows.Count > 0)
                        GeneratePDF(SecondTable, "PlantWise Report (Incomming Weight Bifurcation)" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
                }
                if (((System.Web.UI.Control)sender).ID == "btnpdf3")
                {
                    if (SecondTable.Rows.Count > 0)
                        GeneratePDF(ThirdTable, "PlantWise Report (OutGoing Weight Bifurcation)" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
                }
                //if (((System.Web.UI.Control)sender).ID == "btnpdf3")
                //{
                //    if (ThirdTable.Rows.Count > 0)
                //        GeneratePDF(ThirdTable, "RampWise Report (Outgoing Weight Bifurcation PlantWise)" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
                //}
                //if (((System.Web.UI.Control)sender).ID == "btnpdf4")
                //{
                //    if (FourthTable.Rows.Count > 0)
                //        GeneratePDF(FourthTable, "RampWise Report (Outgoing Weight Bifurcation PlantWise)" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
                //}
                //if (((System.Web.UI.Control)sender).ID == "btnpdf5")
                //{
                //    if (FifthTable.Rows.Count > 0)
                //        GeneratePDF(FifthTable, "RampWise Report (Incomming Details)" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
                //}
                //if (((System.Web.UI.Control)sender).ID == "btnpdf6")
                //{
                //    if (SixthTable.Rows.Count > 0)
                //        GeneratePDF(SixthTable, "RampWise Report (Outgoing Details)" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
                //}
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "PlantWiseReport.cs >> Method btnpdf_Click()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }

        protected void btnexcel_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                if (((System.Web.UI.Control)sender).ID == "btnexcel1")
                {
                    if (FirstTable.Rows.Count > 0)
                        GenerateExcel(FirstTable, "PlantWise Report" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
                }
                if (((System.Web.UI.Control)sender).ID == "btnexcel2")
                {
                    if (SecondTable.Rows.Count > 0)
                        GenerateExcel(SecondTable, "PlantWise Report (Incomming Weight Bifurcation)" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
                }
                if (((System.Web.UI.Control)sender).ID == "btnexcel3")
                {
                    if (SecondTable.Rows.Count > 0)
                        GenerateExcel(ThirdTable, "PlantWise Report (Outgoing Weight Bifurcation)" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
                }
                //if (((System.Web.UI.Control)sender).ID == "btnexcel3")
                //{
                //    if (ThirdTable.Rows.Count > 0)
                //        GenerateExcel(ThirdTable, "RampWise Report (Outgoing Weight Bifurcation PlantWise)" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
                //}
                //if (((System.Web.UI.Control)sender).ID == "btnexcel4")
                //{
                //    if (FourthTable.Rows.Count > 0)
                //        GenerateExcel(FourthTable, "RampWise Report (Outgoing Weight Bifurcation PlantWise)" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
                //}
                //if (((System.Web.UI.Control)sender).ID == "btnexcel5")
                //{
                //    if (FifthTable.Rows.Count > 0)
                //        GenerateExcel(FifthTable, "RampWise Report (Incomming Details)" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
                //}
                //if (((System.Web.UI.Control)sender).ID == "btnexcel6")
                //{
                //    if (SixthTable.Rows.Count > 0)
                //        GenerateExcel(SixthTable, "RampWise Report (Outgoing Details)" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
                //}
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "PlantWiseReport.cs >> Method btnexcel_Click()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }

        void GenerateExcel(GridView grd_Report, string filename)
        {
            try
            {
                if (grd_Report.Rows.Count > 0)
                {
                    Response.Clear();
                    Response.Buffer = true;
                    Response.AddHeader("content-disposition", "attachment;filename=" + filename + ".xls");
                    Response.Charset = "";
                    Response.ContentType = "application/vnd.ms-excel";

                    using (StringWriter sw = new StringWriter())
                    {
                        using (HtmlTextWriter htw = new HtmlTextWriter(sw))
                        {
                            // Create a table with the same number of columns as the GridView
                            Table table = new Table();
                            TableRow headerRow = new TableRow();
                            foreach (TableCell cell in grd_Report.HeaderRow.Cells)
                            {
                                headerRow.Cells.Add(new TableCell { Text = cell.Text });
                            }
                            table.Rows.Add(headerRow);

                            //foreach (TableCell cell in grd_Report.HeaderRow.Cells)
                            //{
                            //    table.Rows[0].Cells.Add(new TableCell { Text = cell.Text });
                            //}

                            // Add table data
                            foreach (GridViewRow row in grd_Report.Rows)
                            {
                                TableRow tableRow = new TableRow();
                                foreach (TableCell cell in row.Cells)
                                {
                                    tableRow.Cells.Add(new TableCell { Text = cell.Text });
                                }
                                table.Rows.Add(tableRow);
                            }

                            // Render the table control to the HtmlTextWriter
                            table.RenderControl(htw);

                            Response.Write(sw.ToString());
                            Response.Flush();
                            Response.End();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "PlantWiseReport.cs >> Method GenerateExcel()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }
        void GeneratePDF(GridView grd_Report, string filename)
        {
            try
            {
                Response.ContentType = "application/pdf";
                Response.AddHeader("content-disposition", "attachment;filename=" + filename + ".pdf");
                Response.Cache.SetCacheability(HttpCacheability.NoCache);

                // Create a new PDF document
                Document document = new Document();
                PdfWriter writer = PdfWriter.GetInstance(document, Response.OutputStream);
                document.Open();

                // Create a table with the same number of columns as the GridView
                //PdfPTable table = new PdfPTable(grd_Report.Columns.Count);
                PdfPTable table = new PdfPTable(grd_Report.Columns.Count == 0 ? grd_Report.Rows[0].Cells.Count : 0);
                // Set table width to 100% of page width
                table.WidthPercentage = 100;

                // Add table headers
                foreach (TableCell cell in grd_Report.HeaderRow.Cells)
                {
                    table.AddCell(cell.Text);
                }

                // Add table data
                foreach (GridViewRow row in grd_Report.Rows)
                {
                    foreach (TableCell cell in row.Cells)
                    {
                        // Check if the cell contains controls or nested elements
                        if (cell.Controls.Count > 0)
                        {
                            // Iterate through the cell controls to extract the inner text
                            foreach (Control control in cell.Controls)
                            {
                                if (control is Label label)
                                {
                                    // Handle Label control
                                    table.AddCell(label.Text);
                                }
                                //else if (control is LiteralControl literal)
                                //{
                                //    // Handle LiteralControl (e.g., plain text)
                                //    table.AddCell(literal.Text);
                                //}
                                // Add more conditions for other control types as needed
                            }
                        }
                        else
                        {
                            // If the cell doesn't contain controls, use the cell's text directly
                            table.AddCell(cell.Text);
                        }
                    }
                }
                // Add the table to the document
                document.Add(table);

                // Close the PDF document
                document.Close();
                Response.Write(document);
                Response.End();
                Response.End();
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "PlantWiseReport.cs >> Method GeneratePDF()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }

        protected void ddlMonth_SelectedIndexChanged(object sender, EventArgs e)
        {
            DateAssign();
        }

        void DateAssign()
        {
            if (Convert.ToInt32(ddlMonth.SelectedItem.Value) != 0)
            {
                DateTime today = DateTime.Today;
                DateTime firstDayOfMonth = Convert.ToDateTime((DateTime.Today.ToString("yyyy") + "-" + ddlMonth.SelectedValue + "-" + 1));
                ViewState["firstDayOfMonth"] = firstDayOfMonth.ToString("yyyy-MM-dd");
                txtFromDate.Text = firstDayOfMonth.ToString("yyyy-MM-dd");
                DateTime lastday = DateTime.Today;
                DateTime lastDayOfMonth = Convert.ToDateTime((DateTime.Today.ToString("yyyy") + "-" + ddlMonth.SelectedValue + "-" + DateTime.DaysInMonth(Convert.ToInt32(DateTime.Today.ToString("yyyy")), Convert.ToInt32(ddlMonth.SelectedValue))));// new DateTime(lastday.Year, lastday.Month, DateTime.DaysInMonth(lastday.Year, lastday.Month));
                ViewState["lastDayOfMonth"] = lastDayOfMonth.ToString("yyyy-MM-dd");
                txtToDate.Text = lastDayOfMonth.ToString("yyyy-MM-dd");

                ddlWeek.SelectedValue = "0";
            }
            else
            {
                DateTime today = DateTime.Today;

                ViewState["firstDayOfMonth"] = DateTime.Today.ToString("yyyy-MM-dd");
                txtFromDate.Text = DateTime.Today.ToString("yyyy-MM-dd");

                ViewState["lastDayOfMonth"] = DateTime.Today.ToString("yyyy-MM-dd");
                txtToDate.Text = DateTime.Today.ToString("yyyy-MM-dd");

                ddlWeek.SelectedValue = "0";
            }
            //lastDayOfMonth1 = ddlYear.SelectedItem.Text + "-" + ddlMonth.SelectedValue + "-" + DateTime.DaysInMonth(Convert.ToInt32(ddlYear.SelectedItem.Text), Convert.ToInt32(ddlMonth.SelectedValue));
        }

        protected void ddlWeek_SelectedIndexChanged(object sender, EventArgs e)
        {
            DateTime firstDayOfMonth = DateTime.Now;
            DateTime lastDayOfMonth = DateTime.Now;
            if (ddlWeek.SelectedValue != "0")
            {
                if (ddlMonth.SelectedValue != "0")
                {
                    int selectedMonth = Convert.ToInt32(ddlMonth.SelectedValue);
                    int selectedYear = DateTime.Today.Year; // You might want to get the selected year from another dropdown or source

                    firstDayOfMonth = new DateTime(selectedYear, selectedMonth, 1);

                    if (ddlWeek.SelectedValue == "1")
                    {
                        lastDayOfMonth = firstDayOfMonth.AddDays(6);
                    }
                    else if (ddlWeek.SelectedValue == "2")
                    {
                        firstDayOfMonth = firstDayOfMonth.AddDays(7);
                        lastDayOfMonth = firstDayOfMonth.AddDays(6);
                    }
                    else if (ddlWeek.SelectedValue == "3")
                    {
                        firstDayOfMonth = firstDayOfMonth.AddDays(14);
                        lastDayOfMonth = firstDayOfMonth.AddDays(6);
                    }
                    else if (ddlWeek.SelectedValue == "4")
                    {
                        firstDayOfMonth = firstDayOfMonth.AddDays(21);
                        lastDayOfMonth = new DateTime(firstDayOfMonth.Year, firstDayOfMonth.Month, DateTime.DaysInMonth(firstDayOfMonth.Year, firstDayOfMonth.Month));
                    }
                }
                else
                {
                    // Handle the case when no month is selected
                    //firstDayOfMonth = DateTime.Today;
                    //lastDayOfMonth = DateTime.Today;

                    int currentMonth = DateTime.Now.Month;
                    int currentYear = DateTime.Now.Year;

                    firstDayOfMonth = new DateTime(currentYear, currentMonth, 1);

                    if (ddlWeek.SelectedValue == "1")
                    {
                        lastDayOfMonth = firstDayOfMonth.AddDays(6);
                    }
                    else if (ddlWeek.SelectedValue == "2")
                    {
                        firstDayOfMonth = firstDayOfMonth.AddDays(7);
                        lastDayOfMonth = firstDayOfMonth.AddDays(6);
                    }
                    else if (ddlWeek.SelectedValue == "3")
                    {
                        firstDayOfMonth = firstDayOfMonth.AddDays(14);
                        lastDayOfMonth = firstDayOfMonth.AddDays(6);
                    }
                    else if (ddlWeek.SelectedValue == "4")
                    {
                        firstDayOfMonth = firstDayOfMonth.AddDays(21);
                        lastDayOfMonth = new DateTime(firstDayOfMonth.Year, firstDayOfMonth.Month, DateTime.DaysInMonth(firstDayOfMonth.Year, firstDayOfMonth.Month));
                    }
                }

                ViewState["firstDayOfMonth"] = firstDayOfMonth.ToString("yyyy-MM-dd");
                txtFromDate.Text = firstDayOfMonth.ToString("yyyy-MM-dd");

                ViewState["lastDayOfMonth"] = lastDayOfMonth.ToString("yyyy-MM-dd");
                txtToDate.Text = lastDayOfMonth.ToString("yyyy-MM-dd");
            }
            else
            {
                DateTime today = DateTime.Today;

                ViewState["firstDayOfMonth"] = DateTime.Today.ToString("yyyy-MM-dd");
                txtFromDate.Text = DateTime.Today.ToString("yyyy-MM-dd");

                ViewState["lastDayOfMonth"] = DateTime.Today.ToString("yyyy-MM-dd");
                txtToDate.Text = DateTime.Today.ToString("yyyy-MM-dd");
            }
        }

        protected void ddlQuarterYearly_SelectedIndexChanged(object sender, EventArgs e)
        {
            DateTime startDate = DateTime.Today;
            DateTime endDate = DateTime.Today;

            if (ddlQuarterYearly.SelectedValue != "0")
            {
                int selectedYear = DateTime.Today.Year; // You might want to get the selected year from another dropdown or source

                if (ddlQuarterYearly.SelectedValue == "1")
                {
                    startDate = new DateTime(selectedYear, 1, 1);
                    endDate = new DateTime(selectedYear, 3, 31);
                }
                else if (ddlQuarterYearly.SelectedValue == "2")
                {
                    startDate = new DateTime(selectedYear, 4, 1);
                    endDate = new DateTime(selectedYear, 6, 30);
                }
                else if (ddlQuarterYearly.SelectedValue == "3")
                {
                    startDate = new DateTime(selectedYear, 7, 1);
                    endDate = new DateTime(selectedYear, 9, 30);
                }
                else if (ddlQuarterYearly.SelectedValue == "4")
                {
                    startDate = new DateTime(selectedYear, 10, 1);
                    endDate = new DateTime(selectedYear, 12, 31);
                }
                else if (ddlQuarterYearly.SelectedValue == "5")
                {
                    startDate = new DateTime(selectedYear, 1, 1);
                    endDate = new DateTime(selectedYear, 6, 30);
                }
                else if (ddlQuarterYearly.SelectedValue == "6")
                {
                    startDate = new DateTime(selectedYear, 7, 1);
                    endDate = new DateTime(selectedYear, 12, 31);
                }
                else if (ddlQuarterYearly.SelectedValue == "7")
                {
                    startDate = new DateTime(selectedYear, 1, 1);
                    endDate = new DateTime(selectedYear, 12, 31);
                }

                txtFromDate.Text = startDate.ToString("yyyy-MM-dd");
                txtToDate.Text = endDate.ToString("yyyy-MM-dd");
            }
            else
            {
                DateTime today = DateTime.Today;

                txtFromDate.Text = DateTime.Today.ToString("yyyy-MM-dd");
                txtToDate.Text = DateTime.Today.ToString("yyyy-MM-dd");
            }
        }
    }
}