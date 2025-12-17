using iTextSharp.text;
using iTextSharp.text.pdf;
using OfficeOpenXml;
using SWM.BAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SWM
{
    public partial class PerformanceReports : System.Web.UI.Page
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
            //exec Proc_VehicleMapwithRoute @mode=56,@Fk_accid=11401,@Fk_ambcatId=0,@Fk_divisionid=0,@FK_VehicleID=0,@Fk_ZoneId=0,@FK_WardId=1024,@Startdate=default,@Enddate=default,
            //@Maxspeed =0,@Minspeed=0,@Fk_DistrictId=0,@Geoid=0
            BindDDLKothi(56, 11401, 0, 0, 0, Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value), txtSdate.Text, txtEdate.Text, 0, 0, 0, 0);
            BindDDLVehicle(3, 0, Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value), txtSdate.Text, txtEdate.Text, 11401, 0, 0);
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
                Logfile.TraceService("LogData", "Messanger.cs >> Method PerformanceReports_BindDDLZone()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
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
                Logfile.TraceService("LogData", "Messanger.cs >> Method PerformanceReports_BindDDLWard()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
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
                    //DataRow allOption = dsGetVehicle.Tables[0].NewRow();
                    //allOption["PK_VehicleId"] = 0;
                    //allOption["vehicleName"] = "Select All";
                    //dsGetVehicle.Tables[0].Rows.InsertAt(allOption, 0);
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
                Logfile.TraceService("LogData", "Messanger.cs >> Method PerformanceReports_BindDDLVehicle()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
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
            //try
            //{
            //    BalFeederSummaryReport bAL = new BalFeederSummaryReport();
            //    FeederSummaryReport mAP = new FeederSummaryReport();
            //    //=====WARD=====//
            //    //exec Proc_VehicleMapwithRoute @mode=56,@Fk_accid=11401,@Fk_ambcatId=0,@Fk_divisionid=0,@FK_VehicleID=0,@Fk_ZoneId=0,@FK_WardId=1024,@Startdate=default,@Enddate=default,
            //    //@Maxspeed =0,@Minspeed=0,@Fk_DistrictId=0,@Geoid=0
            //    DataSet dsGetKothi = bAL.GetKothi(@mode, @Fk_accid, @Fk_ambcatId, @Fk_divisionid, @FK_VehicleID, @Fk_ZoneId, @FK_WardId, @Startdate, @Enddate, @Maxspeed, @Minspeed, @Fk_DistrictId, @Geoid);
            //    if (dsGetKothi.Tables.Count > 0)
            //    {
            //        DataRow allOption = dsGetKothi.Tables[0].NewRow();
            //        allOption["pk_kothiid"] = 0;
            //        allOption["kothiname"] = "Select All";
            //        dsGetKothi.Tables[0].Rows.InsertAt(allOption, 0);
            //        if (dsGetKothi.Tables[0].Rows.Count > 0)
            //        {
            //            // Set the dropdown list's data source and bind the data
            //            ddlKothi.DataSource = dsGetKothi.Tables[0];
            //            ddlKothi.DataTextField = "kothiname"; // Field to display as option text  
            //            ddlKothi.DataValueField = "pk_kothiid"; // Field to use as option value  
            //            ddlKothi.DataBind();
            //        }
            //    }
            //}
            //catch (Exception ex)
            //{
            //    Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
            //    Logfile.TraceService("LogData", "Messanger.cs >> Method PerformanceReports_BindDDLKothi()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
            //    Logfile.TraceService("LogData", "Message >> " + ex.Message);
            //    Logfile.TraceService("LogData", "Source >> " + ex.Source);
            //    Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
            //    Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
            //    Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
            //    Logfile.TraceService("LogData", ex.Message);
            //}
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
                grd_DriveSummary.Visible = false;
                grd_DailyOdometer.Visible = false;
                grid_Trip.Visible = false;
                grd_VehicleSummary.Visible = false;
                hheader.Visible = false;
                divExport.Visible = false;

                // Example dates (replace these with your actual dates)
                DateTime fromdate = DateTime.Parse(txtSdate.Text);
                DateTime todate = DateTime.Parse(txtEdate.Text);

                // Calculate the difference between the two dates
                TimeSpan difference = todate - fromdate;

                BalFeederSummaryReport bAL = new BalFeederSummaryReport();
                FeederSummaryReport mAP = new FeederSummaryReport();
                //==sp ref==//
                //"begin tran t
                //exec proc_ReportsDataBind @mode=2,@vehicleId=2,@AccId=11401,@ZoneId=0,@WardId=0,@startdate=N'2023-05-11 00:00',@enddate=N'2023-05-11 23:59',
                //@stime =default,@etime=default,@RptName=N'Daily Odometer',@Report=default,@Zone=default,@Ward=default,@WorkingType=default,@RouteId=0,@AdminID=0,@RoleID=0
                //rollback tran t"
                //==sp ref==//
                if (ddlReportsName.SelectedItem.Text == "Daily Odometer")
                {
                    //DataSet ds = bAL.GetPerformanceReports(2, 2, 11401, 0, 0, "2023-05-11", "2023-05-22", "", "", "Daily Odometer", "", "", "", "", "0", "0", "0");
                    DataSet ds = bAL.GetPerformanceReports(2, Convert.ToInt32(ddlVehicle.SelectedItem.Value), 11401, Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value)
                        , txtSdate.Text, txtEdate.Text, ddlSTime.SelectedItem.Text, ddlETime.SelectedItem.Text, ddlReportsName.SelectedItem.Text, "", "", "", "", "0", "0", "0");
                    if (ds.Tables.Count > 0)
                    {
                        if (difference.TotalDays > 31)
                        {
                            string script = "alert('Data exported successfully!');";
                            ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
                            GenerateExcelDirectly(ds.Tables[0], "PerformanceReport" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
                        }
                        else
                        {
                            if (ds.Tables[0].Rows.Count > 0)
                            {
                                grd_DailyOdometer.Visible = true;
                                hheader.Visible = true;
                                lblFromDate.Text = txtSdate.Text;
                                lblEndDate.Text = txtEdate.Text;
                                lblReportName.Text = ddlReportsName.SelectedItem.Text + " Report";

                                divExport.Visible = true;
                                // Assuming you have already populated your data source
                                // List<YourDataType> dataList = GetData();

                                // Clear existing columns
                                grd_DailyOdometer.Columns.Clear();
                                // Create new columns with modified header names
                                grd_DailyOdometer.Columns.Add(new BoundField
                                {
                                    DataField = "Date",
                                    HeaderText = "Date"
                                });

                                // Create new columns with modified header names
                                grd_DailyOdometer.Columns.Add(new BoundField
                                {
                                    DataField = "Vehicle",
                                    HeaderText = "Vehicle"
                                });
                                // Create new columns with modified header names
                                grd_DailyOdometer.Columns.Add(new BoundField
                                {
                                    DataField = "Distance Travelled(kms)",
                                    HeaderText = "Distance Travelled(kms)"
                                });
                                grd_DailyOdometer.DataSource = ds.Tables[0];
                                grd_DailyOdometer.DataBind();
                            }

                            else
                            {
                                divExport.Visible = false;
                                grd_DailyOdometer.DataSource = null;
                                grd_DailyOdometer.DataBind();
                            }
                        }
                    }
                }
                else if (ddlReportsName.SelectedItem.Text == "Drive Summary")
                {
                    DataSet ds = bAL.GetPerformanceReports(2, Convert.ToInt32(ddlVehicle.SelectedItem.Value), 11401, Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value)
                        , txtSdate.Text, txtEdate.Text, ddlSTime.SelectedItem.Text, ddlETime.SelectedItem.Text, ddlReportsName.SelectedItem.Text, "", "", "", "", "0", "0", "0");
                    if (ds.Tables.Count > 0)
                    {
                        if (difference.TotalDays > 31)
                        {
                            string script = "alert('Data exported successfully!');";
                            ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
                            GenerateExcelDirectly(ds.Tables[0], "PerformanceReport" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));

                        }
                        else
                        {
                            hheader.Visible = true;
                            grd_DriveSummary.Visible = true;

                            lblFromDate.Text = txtSdate.Text;
                            lblEndDate.Text = txtEdate.Text;
                            lblReportName.Text = ddlReportsName.SelectedItem.Text + " Report";
                            if (ds.Tables[0].Rows.Count > 0)
                            {
                                divExport.Visible = true;

                                grd_DriveSummary.DataSource = ds.Tables[0];
                                grd_DriveSummary.DataBind();
                            }

                            else
                            {
                                divExport.Visible = false;
                                grd_DriveSummary.DataSource = null;
                                grd_DriveSummary.DataBind();
                            }
                        }
                    }
                }
                else if (ddlReportsName.SelectedItem.Text == "Trip")
                {
                    DataSet ds = bAL.GetPerformanceReports(2, Convert.ToInt32(ddlVehicle.SelectedItem.Value), 11401, Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value)
                        , txtSdate.Text, txtEdate.Text, ddlSTime.SelectedItem.Text, ddlETime.SelectedItem.Text, ddlReportsName.SelectedItem.Text, "", "", "", "", "0", "0", "0");
                    if (ds.Tables.Count > 0)
                    {
                        if (difference.TotalDays > 31)
                        {
                            string script = "alert('Data exported successfully!');";
                            ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
                            GenerateExcelDirectly(ds.Tables[0], "PerformanceReport" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));

                        }
                        else
                        {
                            if (ds.Tables[0].Rows.Count > 0)
                            {
                                hheader.Visible = true;

                                grid_Trip.Visible = true;
                                lblFromDate.Text = txtSdate.Text;
                                lblEndDate.Text = txtEdate.Text;
                                lblReportName.Text = ddlReportsName.SelectedItem.Text + " Report";

                                divExport.Visible = true;

                                grid_Trip.DataSource = ds.Tables[0];
                                grid_Trip.DataBind();
                            }

                            else
                            {
                                divExport.Visible = false;
                                grid_Trip.DataSource = null;
                                grid_Trip.DataBind();
                            }
                        }
                    }
                }

                else if (ddlReportsName.SelectedItem.Text == "Vehicle Summary")
                {
                    DataSet ds = bAL.GetPerformanceReports(2, Convert.ToInt32(ddlVehicle.SelectedItem.Value), 11401, Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value)
                        , txtSdate.Text, txtEdate.Text, ddlSTime.SelectedItem.Text, ddlETime.SelectedItem.Text, ddlReportsName.SelectedItem.Text, "", "", "", "", "0", "0", "0");
                    if (ds.Tables.Count > 0)
                    {
                        if (difference.TotalDays > 31)
                        {
                            string script = "alert('Data exported successfully!');";
                            ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
                            GenerateExcelDirectly(ds.Tables[0], "PerformanceReport" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));

                        }
                        else
                        {
                            if (ds.Tables[0].Rows.Count > 0)
                            {
                                hheader.Visible = true;

                                grd_VehicleSummary.Visible = true;
                                lblFromDate.Text = txtSdate.Text;
                                lblEndDate.Text = txtEdate.Text;
                                lblReportName.Text = ddlReportsName.SelectedItem.Text + " Report";

                                divExport.Visible = true;

                                grd_VehicleSummary.DataSource = ds.Tables[0];
                                grd_VehicleSummary.DataBind();
                            }

                            else
                            {
                                divExport.Visible = false;
                                grd_VehicleSummary.DataSource = null;
                                grd_VehicleSummary.DataBind();
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "Messanger.cs >> Method PerformanceReports_GrdBind()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
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
        // Override the Render method to allow the GridView to be rendered
        public override void VerifyRenderingInServerForm(Control control)
        {
            // Required to avoid the "Control 'GridView1' must be placed inside a form tag with runat=server" error
        }
        void GenerateExcel(GridView grd_Report, string filename)
        {
            try
            {
                if (grd_Report.Rows.Count > 1)
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
                            // Render the GridView control to the HtmlTextWriter
                            grd_Report.RenderControl(htw);
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
                Logfile.TraceService("LogData", "Messanger.cs >> Method PerformanceReports_GenerateExcel()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
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
                Logfile.TraceService("LogData", "Messanger.cs >> Method PerformanceReports_GeneratePDF()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }

        protected void imgxls_Click(object sender, ImageClickEventArgs e)
        {
            if (ddlReportsName.SelectedItem.Text == "Daily Odometer")
            {
                GenerateExcel(grd_DailyOdometer, ddlReportsName.SelectedItem.Text + "Reports_" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
            }
            else if (ddlReportsName.SelectedItem.Text == "Drive Summary")
            {
                GenerateExcel(grd_DriveSummary, ddlReportsName.SelectedItem.Text + "Reports_" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
            }
            else if (ddlReportsName.SelectedItem.Text == "Trip")
            {
                GenerateExcel(grid_Trip, ddlReportsName.SelectedItem.Text + "Reports_" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
            }
            else if (ddlReportsName.SelectedItem.Text == "Vehicle Summary")
            {
                GenerateExcel(grd_VehicleSummary, ddlReportsName.SelectedItem.Text + "Reports_" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
            }
        }
        protected void imgpdf_Click(object sender, ImageClickEventArgs e)
        {
            //GeneratePDF(grd_DailyOdometer, ddlReportsName.SelectedItem.Text + "Reports_" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
            if (grd_DailyOdometer.Visible == true)
            {
                GeneratePDF(grd_DailyOdometer, ddlReportsName.SelectedItem.Text + "Reports_" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
            }
            else if (grd_DriveSummary.Visible == true)
            {
                GeneratePDF(grd_DriveSummary, ddlReportsName.SelectedItem.Text + "Reports_" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
            }
            else if (grid_Trip.Visible == true)
            {
                GeneratePDF(grid_Trip, ddlReportsName.SelectedItem.Text + "Reports_" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
            }
            else
            {
                GeneratePDF(grd_VehicleSummary, ddlReportsName.SelectedItem.Text + "Reports_" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
            }
        }

        protected void grd_DailyOdometer_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    int rowNumber = e.Row.RowIndex + 1;

                    // Find the Label control in the first cell
                    Label lblSrNo = e.Row.Cells[0].FindControl("lblSrNo") as Label;

                    if (lblSrNo != null)
                    {
                        // Set the value for the incrementing column
                        lblSrNo.Text = rowNumber.ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "Messanger.cs >> Method PerformanceReports_grd_DailyOdometer_RowDataBound()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
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
                    BindDDLVehicle(3, 0, Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value), txtSdate.Text, txtEdate.Text, 11401, 0, 0);
                    //BindDDLKothi(24, 11401, 0, Convert.ToInt32(ddlZone.SelectedItem.Value), 0, txtSdate.Text, txtEdate.Text);
                    BindDDLKothi(56, 11401, 0, 0, Convert.ToInt32(ddlVehicle.SelectedItem.Value), Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value),
                        txtSdate.Text, txtEdate.Text, 0, 0, 0, 0);

                }
                else
                {
                    BindLoad();
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "Messanger.cs >> Method PerformanceReports_ddlZone_SelectedIndexChanged()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
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
                    BindDDLKothi(56, 11401, 0, 0, Convert.ToInt32(ddlVehicle.SelectedItem.Value), Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value),
                      txtSdate.Text, txtEdate.Text, 0, 0, 0, 0);
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