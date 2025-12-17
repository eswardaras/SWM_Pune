using SWM.BAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;
using OfficeOpenXml;

namespace SWM
{
    public partial class FeederCoverageReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindLoad();
            }
        }
        void BindLoad()
        {
            BindDDLZone();
            BindDDLWard(12, 0, 11401, 0);
            // BindDDLRoute(24, 11401, 0, 104, 1026, txtSdate.Text, txtEdate.Text);
            BindDDLVehicle(3, 0, 0, 0, txtSdate.Text, txtEdate.Text, 11401, 0, 0);
        }
        void BindDDLZone()
        {
            try
            {
                BalFeederSummaryReport bAL = new BalFeederSummaryReport();
                FeederSummaryReport mAP = new FeederSummaryReport();
                //=====ZONE=====//
                //"begin tran t
                //exec proc_SweeperRouteCoverageReportNew @mode = 11,@vehicleId = 0,@AccId = 11401,@ZoneId = 0,@WardId = 0,@startdate = default,@enddate = default,@stime = default,@etime = default,@RptName = default,@Report = default,@Zone = default,@Ward = default,@WorkingType = default,@RouteId = 0,@AdminID = 0,@RoleID = 0
                //rollback tran t"
                //==sp ref==//
                DataSet ds = bAL.GetZone(11, 0, 11401);
                if (ds.Tables.Count > 0)
                {
                    // Add the "Select All" option to the DataTable
                    DataRow allOption = ds.Tables[0].NewRow();
                    allOption["zoneid"] = 0;
                    allOption["zonename"] = "Select All";
                    ds.Tables[0].Rows.InsertAt(allOption, 0);

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        // Set the dropdown list's data source and bind the data
                        ddlZone.DataSource = ds.Tables[0];
                        ddlZone.DataTextField = "zonename"; // Field to display as option text
                        ddlZone.DataValueField = "zoneid"; // Field to use as option value
                        ddlZone.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "Messanger.cs >> Method FeederCoverageReport_BindDDLZone()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }
        void BindDDLWard(int @mode, int @vehicleId, int @AccId, int @ZoneId)
        {
            try
            {
                BalFeederSummaryReport bAL = new BalFeederSummaryReport();
                FeederSummaryReport mAP = new FeederSummaryReport();
                //=====WARD=====//
                //exec proc_SweeperRouteCoverageReportNew @mode = 12,@vehicleId = 0,@AccId = 11401,@ZoneId = default
                DataSet dsGetWard = bAL.GetWard(@mode, @vehicleId, @AccId, @ZoneId);
                if (dsGetWard.Tables.Count > 0)
                {
                    DataRow allOption = dsGetWard.Tables[0].NewRow();
                    allOption["PK_wardId"] = 0;
                    allOption["wardName"] = "Select All";
                    dsGetWard.Tables[0].Rows.InsertAt(allOption, 0);
                    if (dsGetWard.Tables[0].Rows.Count > 0)
                    {
                        // Set the dropdown list's data source and bind the data
                        ddlWard.DataSource = dsGetWard.Tables[0];
                        ddlWard.DataTextField = "wardName"; // Field to display as option text 
                        ddlWard.DataValueField = "PK_wardId"; // Field to use as option value 
                        ddlWard.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "Messanger.cs >> Method FeederCoverageReport_BindDDLWard()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }
        void BindDDLVehicle(int @mode, int @FK_VehicleID, int @zoneId, int @WardId, string @sDate, string @eDate, int @UserID, int @zoneName, int @WardName)
        {
            try
            {
                BalFeederSummaryReport bAL = new BalFeederSummaryReport();
                FeederSummaryReport mAP = new FeederSummaryReport();
                //=====WARD=====//
                //exec Proc_VehicleMap @mode=3,@FK_VehicleID=0,@zoneId=0,@WardId=0,@sDate=default,@eDate=default,@UserID=11401,@zoneName=default,@WardName=default
                DataSet dsGetVehicle = bAL.GetVehicle(@mode, @FK_VehicleID, @zoneId, @WardId, @sDate, @eDate, @UserID, @zoneName, @WardName);
                if (dsGetVehicle.Tables.Count > 0)
                {
                    DataRow allOption = dsGetVehicle.Tables[0].NewRow();
                    allOption["PK_VehicleId"] = 0;
                    allOption["vehicleName"] = "Select All";
                    dsGetVehicle.Tables[0].Rows.InsertAt(allOption, 0);
                    if (dsGetVehicle.Tables[0].Rows.Count > 0)
                    {
                        // Set the dropdown list's data source and bind the data
                        ddlVehicle.DataSource = dsGetVehicle.Tables[0];
                        ddlVehicle.DataTextField = "vehicleName"; // Field to display as option text 
                        ddlVehicle.DataValueField = "PK_VehicleId"; // Field to use as option value 
                        ddlVehicle.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "Messanger.cs >> Method FeederCoverageReport_BindDDLVehicle()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }

        }
        protected void grd_Report_PageIndexChanging1(object sender, GridViewPageEventArgs e)
        {
            grd_Report.PageIndex = e.NewPageIndex;
            // Bind your data here
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            GrdBind();
            tableWrapper.Visible = true;
        }
        void GrdBind()
        {
            try
            {
                spnAll.InnerText = "0";
                spnEarly.InnerText = "0";
                spnLate.InnerText = "0";

                DateTime fromdate = DateTime.Parse(txtSdate.Text);
                DateTime todate = DateTime.Parse(txtEdate.Text);

                TimeSpan difference = todate - fromdate;

                BalFeederSummaryReport bAL = new BalFeederSummaryReport();
                FeederSummaryReport mAP = new FeederSummaryReport();

                //==sp ref==//
                //"begin tran t
                //exec proc_PerformanceVehicleReport @Mode=6,@Accid=11401,@zoneid=103,@wardid=0,@vehicleid=0,@StartDate=N'2023-05-17',@EndDate=N'2023-05-17'
                //rollback tran t"
                //==sp ref==//
                DataSet ds = bAL.GetFeederCoverageReport(2, Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value),
                    Convert.ToInt32(ddlVehicle.SelectedItem.Value), txtSdate.Text, txtEdate.Text);
                if (ds.Tables.Count > 0)
                {
                    if (difference.TotalDays > 31)
                    {
                        GenerateExcelDirectly(ds.Tables[0], "FeederSummaryReport_" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
                        string script = "alert('Data exported successfully!');";
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
                    }
                    else
                    {
                        hheader.Visible = true;
                        lblFromDate.Text = txtSdate.Text;
                        lblEndDate.Text = txtEdate.Text;
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            grd_Report.DataSource = ds.Tables[0];
                            grd_Report.DataBind();
                            // ViewState["GrdTable"] = ds.Tables[0];
                            spnAll.InnerText = ds.Tables[0].AsEnumerable().Count().ToString();
                            //spnEarly.InnerText = ds.Tables[0].AsEnumerable().Where(x => x["TimeDiff"].ToString().Contains("Early")).Count().ToString();
                            //spnLate.InnerText = ds.Tables[0].AsEnumerable().Where(x => x["TimeDiff"].ToString().Contains("Late")).Count().ToString();
                            spnEarly.InnerText = ds.Tables[0].AsEnumerable().Where(x => x["VEHICLESTATUS"].ToString().Contains("Early")).Count().ToString();
                            spnLate.InnerText = ds.Tables[0].AsEnumerable().Where(x => x["VEHICLESTATUS"].ToString().Contains("Late")).Count().ToString();
                            divExport.Visible = true;
                        }
                        else
                        {
                            grd_Report.DataSource = null;
                            grd_Report.DataBind();
                            ViewState["GrdTable"] = null;
                            divExport.Visible = false;
                        }
                        #region Late Early


                        #endregion
                    }




                }
            }
            catch (Exception ex)
            {
                throw (ex);
                //Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                //Logfile.TraceService("LogData", "Messanger.cs >> Method FeederCoverageReport_GrdBind()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                //Logfile.TraceService("LogData", "Message >> " + ex.Message);
                //Logfile.TraceService("LogData", "Source >> " + ex.Source);
                //Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                //Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                //Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                //Logfile.TraceService("LogData", ex.Message);
            }

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
        protected void imgxls_Click(object sender, ImageClickEventArgs e)
        {
            GenerateExcel(grd_Report, "FeederCoverageReport_" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
        }

        // Override the Render method to allow the GridView to be rendered
        public override void VerifyRenderingInServerForm(Control control)
        {
            // Required to avoid the "Control 'GridView1' must be placed inside a form tag with runat=server" error
        }
        protected void GenerateExcel(GridView gridView, string fileName)
        {
            ExcelPackage.LicenseContext = LicenseContext.NonCommercial; // Set the license context

            using (var package = new ExcelPackage())
            {
                var worksheet = package.Workbook.Worksheets.Add("Attendance Report");

                DataTable dt = new DataTable();
                // Populate dt with data from the GridView or your data source
                // For example: dt = GetDataFromGridView(gridView);
                BalFeederSummaryReport bAL = new BalFeederSummaryReport();
                DataSet ds = bAL.GetFeederCoverageReport(2, Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value),
                   Convert.ToInt32(ddlVehicle.SelectedItem.Value), txtSdate.Text, txtEdate.Text);
                if (ds.Tables.Count > 0)
                {
                    dt = ds.Tables[0];//; GetDataFromGridView(gridView);
                }
                // Write DataTable content to Excel worksheet
                worksheet.Cells["A1"].LoadFromDataTable(dt, true);

                Response.Clear();
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AddHeader("content-disposition", "attachment;filename=" + fileName + ".xlsx");
                Response.BinaryWrite(package.GetAsByteArray());
                Response.End();
            }
        }
        protected void GeneratePDF(GridView gridView, string fileName)
        {
            // Retrieve the DataTable from ViewState
            DataTable dt = null;//= ViewState["GrdTable"] as DataTable;

            BalFeederSummaryReport bAL = new BalFeederSummaryReport();
            DataSet ds = bAL.GetFeederCoverageReport(2, Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value),
               Convert.ToInt32(ddlVehicle.SelectedItem.Value), txtSdate.Text, txtEdate.Text);
            if (ds.Tables.Count > 0)
            {
                dt = ds.Tables[0];//; GetDataFromGridView(gridView);
            }

            if (dt != null)
            {
                Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 10f, 0f);
                PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
                pdfDoc.Open();

                // Add the logo to the header section
                string imagePath = Server.MapPath("~/Images/pmcsmart.png");
                iTextSharp.text.Image logo = iTextSharp.text.Image.GetInstance(imagePath);
                logo.Alignment = iTextSharp.text.Image.ALIGN_CENTER;
                pdfDoc.Add(logo);
                // Add any other content you want in the header section

                PdfPTable pdfTable = new PdfPTable(dt.Columns.Count);
                pdfTable.WidthPercentage = 100;

                // Add header cells to the PDF table
                foreach (DataColumn column in dt.Columns)
                {
                    PdfPCell pdfCell = new PdfPCell(new Phrase(column.ColumnName));
                    pdfTable.AddCell(pdfCell);
                }

                // Add data cells to the PDF table
                foreach (DataRow row in dt.Rows)
                {
                    foreach (object item in row.ItemArray)
                    {
                        PdfPCell pdfCell = new PdfPCell(new Phrase(item.ToString()));
                        pdfTable.AddCell(pdfCell);
                    }
                }

                pdfDoc.Add(pdfTable);
                pdfDoc.Close();

                //string fileName = "ExportedData";
                Response.ContentType = "application/pdf";
                Response.AddHeader("content-disposition", "attachment;filename=" + fileName + ".pdf");
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.Write(pdfDoc);
                Response.End();
            }
        }

        protected void imgpdf_Click(object sender, ImageClickEventArgs e)
        {
            GeneratePDF(grd_Report, "FeederCoverageReport_" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
        }
        protected void ddlZone_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                if (Convert.ToInt32(ddlZone.SelectedItem.Value) >= 0)
                {
                    BindDDLWard(12, 0, 11401, Convert.ToInt32(ddlZone.SelectedItem.Value));
                    BindDDLVehicle(3, 0, Convert.ToInt32(ddlZone.SelectedItem.Value), 0, txtSdate.Text, txtEdate.Text, 11401, 0, 0);
                    //BindDDLRoute(24, 11401, 0, Convert.ToInt32(ddlZone.SelectedItem.Value), 0, txtSdate.Text, txtEdate.Text);
                }
                else
                {
                    BindLoad();
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "Messanger.cs >> Method FeederCoverageReport_ddlZone_SelectedIndexChanged()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }
        protected void ddlWard_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                if (Convert.ToInt32(ddlWard.SelectedItem.Value) >= 0)
                {
                    BindDDLVehicle(3, 0, Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value), txtSdate.Text, txtEdate.Text, 11401, 0, 0);
                    //BindDDLRoute(24, 11401, 0, Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value), txtSdate.Text, txtEdate.Text);
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "Messanger.cs >> Method FeederCoverageReport_ddlWard_SelectedIndexChanged()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }

        protected void grd_Report_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grd_Report.PageIndex = e.NewPageIndex;
            // Bind your data here
            GrdBind();
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
                txtSdate.Text = firstDayOfMonth.ToString("yyyy-MM-dd");
                DateTime lastday = DateTime.Today;
                DateTime lastDayOfMonth = Convert.ToDateTime((DateTime.Today.ToString("yyyy") + "-" + ddlMonth.SelectedValue + "-" + DateTime.DaysInMonth(Convert.ToInt32(DateTime.Today.ToString("yyyy")), Convert.ToInt32(ddlMonth.SelectedValue))));// new DateTime(lastday.Year, lastday.Month, DateTime.DaysInMonth(lastday.Year, lastday.Month));
                ViewState["lastDayOfMonth"] = lastDayOfMonth.ToString("yyyy-MM-dd");
                txtEdate.Text = lastDayOfMonth.ToString("yyyy-MM-dd");

                ddlWeek.SelectedValue = "0";
            }
            else
            {
                DateTime today = DateTime.Today;

                ViewState["firstDayOfMonth"] = DateTime.Today.ToString("yyyy-MM-dd");
                txtSdate.Text = DateTime.Today.ToString("yyyy-MM-dd");

                ViewState["lastDayOfMonth"] = DateTime.Today.ToString("yyyy-MM-dd");
                txtEdate.Text = DateTime.Today.ToString("yyyy-MM-dd");

                ddlWeek.SelectedValue = "0";
            }
            //lastDayOfMonth1 = ddlYear.SelectedItem.Text + "-" + ddlMonth.SelectedValue + "-" + DateTime.DaysInMonth(Convert.ToInt32(ddlYear.SelectedItem.Text), Convert.ToInt32(ddlMonth.SelectedValue));
        }

        protected void ddlWeek_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlQuarterYearly.SelectedValue = "0";
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
                txtSdate.Text = firstDayOfMonth.ToString("yyyy-MM-dd");

                ViewState["lastDayOfMonth"] = lastDayOfMonth.ToString("yyyy-MM-dd");
                txtEdate.Text = lastDayOfMonth.ToString("yyyy-MM-dd");
            }
            else
            {
                DateTime today = DateTime.Today;

                ViewState["firstDayOfMonth"] = DateTime.Today.ToString("yyyy-MM-dd");
                txtSdate.Text = DateTime.Today.ToString("yyyy-MM-dd");

                ViewState["lastDayOfMonth"] = DateTime.Today.ToString("yyyy-MM-dd");
                txtEdate.Text = DateTime.Today.ToString("yyyy-MM-dd");
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

                txtSdate.Text = startDate.ToString("yyyy-MM-dd");
                txtEdate.Text = endDate.ToString("yyyy-MM-dd");
            }
            else
            {
                DateTime today = DateTime.Today;

                txtSdate.Text = DateTime.Today.ToString("yyyy-MM-dd");
                txtEdate.Text = DateTime.Today.ToString("yyyy-MM-dd");
            }
        }
    }
}