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

namespace SWM
{
    public partial class tripreportcanddandspecialwaste : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //BindGrid();
                BindAllDropDown();
                //BindDDLVehicle();
            }
        }

        private void BindAllDropDown()
        {
            BindDDLZone();
            // BindSupervisorZone();

        }

        protected void RadioButton_CheckedChanged(object sender, EventArgs e)
        {

        }

        private bool IsColumnExists(string columnName, GridView gridView)
        {
            foreach (DataControlField column in gridView.Columns)
            {
                if (column.HeaderText.Equals(columnName, StringComparison.OrdinalIgnoreCase))
                {
                    return true;
                }
            }
            return false;
        }
        protected void ButtonSubmitt_Click(object sender, EventArgs e)
        {
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
            DataSet ds  = bAL.GetTripReport(Convert.ToInt16(ddlZone.SelectedValue == ""?"0":ddlZone.SelectedValue), Convert.ToInt16(ddlWard.SelectedValue == ""?"0":ddlWard.SelectedValue), Convert.ToInt16(ddlKothi.SelectedValue == ""?"0":ddlKothi.SelectedValue), Convert.ToDateTime(txtFromDate.Text), Convert.ToDateTime(txtToDate.Text));
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

                        adhoctable.DataSource = ds.Tables[0];
                        adhoctable.DataBind();
                        //ddlRamp.DataSource = ds.Tables[0];
                        //ddlRamp.DataTextField = "RMM_NAME"; // Field to display as option text
                        //ddlRamp.DataValueField = "RMM_ID"; // Field to use as option value
                        //ddlRamp.DataBind();
                    }

                }
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
        protected void ShowImage_Click(object sender, EventArgs e)
        {
            ImageButton btnImage = (ImageButton)sender;
            string imageUrl = btnImage.ImageUrl;

            // Show the image using the imageUrl (e.g., in a modal popup, new page, etc.)
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
                Logfile.TraceService("LogData", "Messanger.cs >> Method FeederSummaryReport_BindDDLZone()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
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
                Logfile.TraceService("LogData", "Messanger.cs >> Method FeederSummaryReport_BindDDLWard()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }

        void BindDDLKothi(int @mode, int @Fk_accid, int @Fk_ambcatId, int @Fk_divisionid, int @FK_VehicleID, int @Fk_ZoneId, int @FK_WardId, string @Startdate, string @Enddate,
        int @Maxspeed, int @Minspeed, int @Fk_DistrictId, int @Geoid)
        {
            try
            {
                BalFeederSummaryReport bAL = new BalFeederSummaryReport();
                FeederSummaryReport mAP = new FeederSummaryReport();
                //=====WARD=====//
                //exec Proc_VehicleMapwithRoute @mode=56,@Fk_accid=11401,@Fk_ambcatId=0,@Fk_divisionid=0,@FK_VehicleID=0,@Fk_ZoneId=0,@FK_WardId=1024,@Startdate=default,@Enddate=default,
                //@Maxspeed =0,@Minspeed=0,@Fk_DistrictId=0,@Geoid=0
                DataSet dsGetKothi = bAL.GetKothi(@mode, @Fk_accid, @Fk_ambcatId, @Fk_divisionid, @FK_VehicleID, @Fk_ZoneId, @FK_WardId, @Startdate, @Enddate, @Maxspeed, @Minspeed, @Fk_DistrictId, @Geoid);
                if (dsGetKothi.Tables.Count > 0)
                {
                    DataRow allOption = dsGetKothi.Tables[0].NewRow();
                    allOption["pk_kothiid"] = 0;
                    allOption["kothiname"] = "Select All";
                    dsGetKothi.Tables[0].Rows.InsertAt(allOption, 0);
                    if (dsGetKothi.Tables[0].Rows.Count > 0)
                    {
                        // Set the dropdown list's data source and bind the data
                        ddlKothi.DataSource = dsGetKothi.Tables[0];
                        ddlKothi.DataTextField = "kothiname"; // Field to display as option text  
                        ddlKothi.DataValueField = "pk_kothiid"; // Field to use as option value  
                        ddlKothi.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "Messanger.cs >> Method PerformanceReports_BindDDLKothi()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }
        protected void ddlZone_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                if (Convert.ToInt32(ddlZone.SelectedItem.Value) >= 0)
                {
                    BindDDLWard(12, 0, 11401, Convert.ToInt32(ddlZone.SelectedItem.Value));
                    //BindDDLVehicle(3, 0, Convert.ToInt32(ddlZone.SelectedItem.Value), 0, txtSdate.Text, txtEdate.Text, 11401, 0, 0);
                    //BindDDLRoute(24, 11401, 0, Convert.ToInt32(ddlZone.SelectedItem.Value), 0, txtSdate.Text, txtEdate.Text);
                }
                else
                {
                    //BindLoad();
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "Messanger.cs >> Method FeederSummaryReport_ddlZone_SelectedIndexChanged()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
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
                    // BindDDLVehicle(3, 0, Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value), DateTime.Now.Date.ToString(), DateTime.Now.Date.ToString(), 11401, 0, 0);
                    BindDDLKothi(56, 11401, 0, 0, Convert.ToInt32(ddlWard.SelectedItem.Value), Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value),
                      DateTime.Now.Date.ToString(), DateTime.Now.Date.ToString(), 0, 0, 0, 0);
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "Messanger.cs >> Method PerformanceReports_ddlWard_SelectedIndexChanged()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }

        protected void btnpdf_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                if (adhoctable.Rows.Count > 0)
                    GeneratePDF(adhoctable, "PlantWiseTripReport" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "AdhocRequestReport.cs >> Method btnpdf_Click()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
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
                GenerateExcel(adhoctable, "PlantWiseTripReport_" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "AdhocRequestReport.cs >> Method btnexcel_Click()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
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
                Logfile.TraceService("LogData", "PlantWiseTripReport.cs >> Method GenerateExcel()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
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
                PdfPTable table = new PdfPTable(grd_Report.Columns.Count);

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
                Logfile.TraceService("LogData", "PlantWiseTripReport.cs >> Method GeneratePDF()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
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