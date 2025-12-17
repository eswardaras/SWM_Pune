using DocumentFormat.OpenXml.Wordprocessing;
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
    public partial class AddBreakdown : System.Web.UI.Page
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
            BindDDLVehicle();
        }
        void BindDDLZone()
        {
            try
            {
                BalFeederSummaryReport bAL = new BalFeederSummaryReport();
                //FeederSummaryReport mAP = new FeederSummaryReport();
                //==sp ref==//
                //exec proc_AddBreakdown @Mode=1,@AccId=11401,@RoleID=0,@zoneId=0,@WardId=0,@FK_VehicleID=0,@vehiclename=default,@VBreakdownStatus=0,@Feedback=default,
                //@Fromdate ='2023-06-01 14:16:08.517',@todate='2023-06-01 14:16:08.517',@pk_id=0,@replacevehicleId=0
                //==sp ref==//
                DataSet ds = bAL.GetBreakdown(1, 11401, 0, 0, 0, 0, "", 0, "",
                    txtSdate.Text, txtEdate.Text, 0, 0);
                //DataSet ds = bAL.GetZone(11, 0, 11401);
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
                Logfile.TraceService("LogData", "Messanger.cs >> Method AddBreakdown_BindDDLZone()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
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
                //FeederSummaryReport mAP = new FeederSummaryReport();
                //==sp ref==//
                //exec proc_AddBreakdown @Mode = 2,@AccId = 11401,@RoleID = 0,@zoneId = 0,@WardId = 0,@FK_VehicleID = 0,@vehiclename = default,@VBreakdownStatus = 0,@Feedback = default,@Fromdate = '2023-06-01 14:16:16.857',@todate = '2023-06-01 14:16:16.857',@pk_id = 0,@replacevehicleId = 0
                //==sp ref==//
                DataSet dsGetWard = bAL.GetBreakdown(2, 11401, 0, Convert.ToInt32(ddlZone.SelectedItem.Value), 0, 0, "", 0, "",
                    txtSdate.Text, txtEdate.Text, 0, 0);

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
                Logfile.TraceService("LogData", "Messanger.cs >> Method AddBreakdown_BindDDLWard()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }

        void BindDDLVehicle()
        {
            try
            {
                BalFeederSummaryReport bAL = new BalFeederSummaryReport();
                FeederSummaryReport mAP = new FeederSummaryReport();
                //==sp ref==//
                //exec proc_AddBreakdown @Mode=3,@AccId=11401,@RoleID=0,@zoneId=0,@WardId=0,@FK_VehicleID=0,@vehiclename=default,@VBreakdownStatus=0,@Feedback=default,@Fromdate='2023-06-01 14:19:58.527',@todate='2023-06-01 14:19:58.527',@pk_id=0,@replacevehicleId=0
                //==sp ref==//
                DataSet dsGetVehicle = bAL.GetBreakdown(3, 11401, 0, Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value), 0, "", 0, "",
                    txtSdate.Text, txtEdate.Text, 0, 0);
                if (dsGetVehicle.Tables.Count > 0)
                {
                    DataRow allOption = dsGetVehicle.Tables[0].NewRow();
                    allOption["pk_vehicleid"] = 0;
                    allOption["Vehiclename"] = "Select All";
                    dsGetVehicle.Tables[0].Rows.InsertAt(allOption, 0);
                    if (dsGetVehicle.Tables[0].Rows.Count > 0)
                    {
                        // Set the dropdown list's data source and bind the data
                        ddlVehicle.DataSource = dsGetVehicle.Tables[0];
                        ddlVehicle.DataTextField = "Vehiclename"; // Field to display as option text 
                        ddlVehicle.DataValueField = "pk_vehicleid"; // Field to use as option value 
                        ddlVehicle.DataBind();
                    }
                }
                //==sp ref==//
                //exec proc_AddBreakdown @Mode=10,@AccId=11401,@RoleID=0,@zoneId=0,@WardId=0,@FK_VehicleID=0,@vehiclename=default,@VBreakdownStatus=0,@Feedback=default,@Fromdate='2023-06-01 14:20:03.103',@todate='2023-06-01 14:20:03.103',@pk_id=0,@replacevehicleId=0
                //==sp ref==//
                DataSet dsReplaceGetVehicle = bAL.GetBreakdown(10, 11401, 0, Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value), 0, "", 0, "",
                    txtSdate.Text, txtEdate.Text, 0, 0);
                if (dsReplaceGetVehicle.Tables.Count > 0)
                {
                    DataRow allOption = dsReplaceGetVehicle.Tables[0].NewRow();
                    allOption["pk_vehicleid"] = 0;
                    allOption["vehiclename"] = "Select All";
                    dsReplaceGetVehicle.Tables[0].Rows.InsertAt(allOption, 0);
                    if (dsReplaceGetVehicle.Tables[0].Rows.Count > 0)
                    {
                        ddlReplaceVehicle.DataSource = dsReplaceGetVehicle.Tables[0];
                        ddlReplaceVehicle.DataTextField = "vehiclename"; // Field to display as option text  	 	
                        ddlReplaceVehicle.DataValueField = "pk_vehicleid"; // Field to use as option value 
                        ddlReplaceVehicle.DataBind();
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
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            GrdBind();
            tableWrapper.Visible = true;

        }
        void GrdBind()
        {
            try
            {
                // Example dates (replace these with your actual dates)
                DateTime fromdate = DateTime.Parse(txtSdate.Text);
                DateTime todate = DateTime.Parse(txtEdate.Text);

                // Calculate the difference between the two dates
                TimeSpan difference = todate - fromdate;

                BalFeederSummaryReport bAL = new BalFeederSummaryReport();
                FeederSummaryReport mAP = new FeederSummaryReport();

                if (rbllist.SelectedItem.Text == "View_Report")
                {
                    //==sp ref==//
                    //exec proc_AddBreakdown @Mode = 9,@AccId = 0,@RoleID = 0,@zoneId = 0,@WardId = 0,@FK_VehicleID = 0,@vehiclename = default,@VBreakdownStatus = 0,@Feedback = default, @Fromdate = '2023-07-01 00:00:00',@todate = '2023-07-11 00:00:00',@pk_id = 0,@replacevehicleId = 0
                    //==sp ref==//
                    DataSet ds = bAL.GetBreakdown(9, 0, 0, Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value), Convert.ToInt32(ddlVehicle.SelectedItem.Value), "", 0, "",
                        txtSdate.Text, txtEdate.Text, 0, 0);
                    if (ds.Tables.Count > 0)
                    {
                        if (difference.TotalDays > 31)
                        {
                            string script = "alert('Data exported successfully!');";
                            ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
                            GenerateExcelDirectly(ds.Tables[0], "BreakdownReport_" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));

                        }
                        else
                        {
                            hheader.Visible = true;
                            lblFromDate.Text = txtSdate.Text;
                            lblEndDate.Text = txtEdate.Text;

                            if (ds.Tables[0].Rows.Count > 0)
                            {
                                grd_AddReport.Visible = false;
                                grd_Report1.Visible = true;
                                divExport.Visible = true;
                                grd_Report1.DataSource = ds.Tables[0];
                                grd_Report1.DataBind();
                            }
                            else
                            {
                                //divExport.Visible = false;
                                grd_Report1.DataSource = null;
                                grd_Report1.DataBind();
                            }
                        }
                        tableWrapper1.Visible = true;
                        tableWrapper2.Visible = true;
                    }


                }
                if (rbllist.SelectedItem.Text == "Mark_Breakdown")
                {
                    //exec proc_AddBreakdown @Mode = 14,@AccId = 11401,@RoleID = 0,@zoneId = 0,@WardId = 0,@FK_VehicleID = 0,@vehiclename = default,@VBreakdownStatus = 0,
                    //@Feedback = default,@Fromdate = '2023-06-01 14:20:02.667',@todate = '2023-06-01 14:20:02.667',@pk_id = 0,@replacevehicleId = 0
                    DataSet ds = bAL.GetBreakdown(14, 11401, 0, Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value), Convert.ToInt32(ddlVehicle.SelectedItem.Value), "", 0, "",
                        txtSdate.Text, txtEdate.Text, 0, 0);

                    if (ds.Tables.Count > 0)
                    {
                        if (difference.TotalDays > 31)
                        {
                            string script = "alert('Data exported successfully!');";
                            ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
                            GenerateExcelDirectly(ds.Tables[0], "FeederSummaryReport_" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));

                        }
                        else
                        {
                            hheader.Visible = true;
                            lblFromDate.Text = txtSdate.Text;
                            lblEndDate.Text = txtEdate.Text;

                            if (ds.Tables[0].Rows.Count > 0)
                            {
                                grd_AddReport.Visible = true;
                                grd_Report1.Visible = false;
                                divExport.Visible = true;
                                grd_AddReport.DataSource = ds.Tables[0];
                                grd_AddReport.DataBind();
                            }
                            else
                            {
                                //divExport.Visible = false;
                                grd_AddReport.DataSource = null;
                                grd_AddReport.DataBind();
                            }
                            tableWrapper2.Visible = true;
                            tableWrapper1.Visible = true;
                        }

                    }
                }


            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "Messanger.cs >> Method AddBreakdown_GrdBind()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
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

        protected void ddlZone_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindDDLWard(12, 0, 11401, Convert.ToInt32(ddlZone.SelectedItem.Value));
        }

        protected void imgxls_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                if (grd_AddReport.Visible == true)
                {
                    if (grd_AddReport.Rows.Count > 0)
                        GenerateExcel(grd_AddReport, "AddBreakdown" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
                }
                else if (grd_Report1.Visible == true)
                {
                    if (grd_Report1.Rows.Count > 0)
                        GenerateExcel(grd_Report1, "Breakdown" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "AddBreakdown.cs >> Method btnexcel_Click()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
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
                            System.Web.UI.WebControls.Table table = new System.Web.UI.WebControls.Table();
                            System.Web.UI.WebControls.TableRow headerRow = new System.Web.UI.WebControls.TableRow();
                            foreach (System.Web.UI.WebControls.TableCell cell in grd_Report.HeaderRow.Cells)
                            {
                                headerRow.Cells.Add(new System.Web.UI.WebControls.TableCell { Text = cell.Text });
                            }
                            table.Rows.Add(headerRow);

                            //foreach (TableCell cell in grd_Report.HeaderRow.Cells)
                            //{
                            //    table.Rows[0].Cells.Add(new TableCell { Text = cell.Text });
                            //}

                            // Add table data
                            foreach (GridViewRow row in grd_Report.Rows)
                            {
                                System.Web.UI.WebControls.TableRow tableRow = new System.Web.UI.WebControls.TableRow();
                                foreach (System.Web.UI.WebControls.TableCell cell in row.Cells)
                                {
                                    tableRow.Cells.Add(new System.Web.UI.WebControls.TableCell { Text = cell.Text });
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
                Logfile.TraceService("LogData", "AddBreakdown.cs >> Method GenerateExcel()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
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
                iTextSharp.text.Document document = new iTextSharp.text.Document();
                PdfWriter writer = PdfWriter.GetInstance(document, Response.OutputStream);
                document.Open();

                // Create a table with the same number of columns as the GridView
                PdfPTable table = new PdfPTable(grd_Report.Columns.Count == 0 ? grd_Report.Rows[0].Cells.Count : grd_Report.Columns.Count);


                // Set table width to 100% of page width
                table.WidthPercentage = 100;

                // Add table headers
                foreach (System.Web.UI.WebControls.TableCell cell in grd_Report.HeaderRow.Cells)
                {
                    table.AddCell(cell.Text);
                }

                // Add table data
                foreach (GridViewRow row in grd_Report.Rows)
                {
                    foreach (System.Web.UI.WebControls.TableCell cell in row.Cells)
                    {
                        // Check if the cell contains controls or nested elements
                        if (cell.Controls.Count > 0)
                        {
                            // Iterate through the cell controls to extract the inner text
                            foreach (System.Web.UI.Control control in cell.Controls)
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
                Logfile.TraceService("LogData", "DatewiseWeightReport.cs >> Method GeneratePDF()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }
        protected void imgpdf_Click(object sender, ImageClickEventArgs e)
        {
            if (grd_AddReport.Visible == true)
            {
                GeneratePDF(grd_AddReport, "AddBreakdown" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
                //GenerateExcel(grd_AddReport, "JatayuRouteCoverageReport_" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
            }
            else if (grd_Report1.Visible == true)
            {
                GeneratePDF(grd_Report1, "Breakdown" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
            }
        }

        protected void ddlWard_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindDDLVehicle();
        }

        protected void btnMarkBKD_Click(object sender, EventArgs e)
        {
            try
            {
                BalFeederSummaryReport bAL = new BalFeederSummaryReport();
                if (btnMarkBKD.Text == "Update")
                {
                    //===update===//
                    //==sp ref==//
                    //proc_AddBreakdown @Mode = 7, @AccId = 11401, @RoleID = 0, @zoneId = 105, @WardId = 1029, @FK_VehicleID = 0, @vehiclename = default, @VBreakdownStatus = 0, @Feedback = default, @Fromdate = '2023-05-11 00:00:00', @todate = '2023-05-11 00:00:00', @pk_id = 0, @replacevehicleId = 0
                    //==sp ref==//
                    DataSet insertds = bAL.GetBreakdown(7, 11401, 0, Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value), 0, "", 0, txtRemark.Text, txtSdate.Text, txtEdate.Text, Convert.ToInt32(ViewState["id"]), 0);
                    GrdBind();
                    ClearControl();

                }
                else
                {
                    //==Insert==//
                    //exec proc_AddBreakdown @Mode = 14,@AccId = 11401,@RoleID = 0,@zoneId = 0,@WardId = 0,@FK_VehicleID = 0,@vehiclename = default,@VBreakdownStatus = 0,
                    //@Feedback = default,@Fromdate = '2023-06-01 14:20:02.667',@todate = '2023-06-01 14:20:02.667',@pk_id = 0,@replacevehicleId = 0
                    DataSet ds = bAL.GetBreakdown(12, 11401, 0, Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value), Convert.ToInt32(ddlVehicle.SelectedItem.Value), Convert.ToString(ddlVehicle.SelectedItem.Text),
                        1, txtRemark.Text, txtSdate.Text, txtEdate.Text, 0, Convert.ToInt32(ddlReplaceVehicle.SelectedItem.Value));
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        GrdBind();
                    }
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "Messanger.cs >> Method AddBreakdown_btnMarkBKD_Click()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
            tableWrapper.Visible = true;
            tableWrapper1.Visible = true;
            tableWrapper2.Visible = true;
        }
        void ClearControl()
        {
            BindLoad();
            txtRemark.Text = "";
            btnMarkBKD.Text = "Mark_Breakdown";
            ddlZone.Enabled = true;
            ddlWard.Enabled = true;
            ddlVehicle.Enabled = true;
            ddlReplaceVehicle.Enabled = true;
        }
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ClearControl();
        }

        protected void btnRemoveBreakdown_Click(object sender, EventArgs e)
        {
            try
            {
                //code pending
                LinkButton clickedButton = (LinkButton)sender;
                string[] parameters = clickedButton.CommandArgument.Split('|');
                string fk_id = parameters[0];
                string date = parameters[1];
                BalFeederSummaryReport bAL = new BalFeederSummaryReport();
                FeederSummaryReport mAP = new FeederSummaryReport();

                //==sp ref==//
                //proc_AddBreakdown @Mode = 6, @AccId = 11401, @RoleID = 0, @zoneId = 105, @WardId = 1029, @FK_VehicleID = 0, @vehiclename = default, @VBreakdownStatus = 0, @Feedback = default, @Fromdate = '2023-05-11 00:00:00', @todate = '2023-05-11 00:00:00', @pk_id = 0, @replacevehicleId = 0
                //==sp ref==//
                DataSet ds = bAL.GetBreakdown(6, 11401, 0, Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value), 0, "", 0, "", txtSdate.Text, txtEdate.Text, Convert.ToInt32(fk_id), 0);
                GrdBind();
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "Messanger.cs >> Method AddBreakdown_btnRemoveBreakdown_Click()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }
        protected void btnEditBreakdown_Click(object sender, EventArgs e)
        {
            try
            {
                //code pending
                LinkButton clickedButton = (LinkButton)sender;
                string[] parameters = clickedButton.CommandArgument.Split('|');
                string fk_id = parameters[0];
                string date = parameters[1];
                ViewState["id"] = fk_id;
                BalFeederSummaryReport bAL = new BalFeederSummaryReport();
                //exec proc_AddBreakdown @Mode = 14,@AccId = 11401,@RoleID = 0,@zoneId = 0,@WardId = 0,@FK_VehicleID = 0,@vehiclename = default,@VBreakdownStatus = 0,
                //@Feedback = default,@Fromdate = '2023-06-01 14:20:02.667',@todate = '2023-06-01 14:20:02.667',@pk_id = 0,@replacevehicleId = 0
                DataSet ds = bAL.GetBreakdown(14, 11401, 0, Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value), 0, "", 0, "",
                        txtSdate.Text, txtEdate.Text, Convert.ToInt32(fk_id), 0);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    ddlZone.ClearSelection();
                    ddlZone.Items.FindByValue(Convert.ToString(ds.Tables[0].Rows[0]["fk_ZoneId"])).Selected = true;
                    ddlZone.Enabled = false;
                    ddlWard.ClearSelection();
                    ddlWard.Items.FindByValue(Convert.ToString(ds.Tables[0].Rows[0]["fk_WardId"])).Selected = true;
                    ddlWard.Enabled = false;
                    ddlVehicle.ClearSelection();
                    ddlVehicle.Items.Insert(0, new System.Web.UI.WebControls.ListItem(Convert.ToString(ds.Tables[0].Rows[0]["Vehiclename"]), Convert.ToString(ds.Tables[0].Rows[0]["Vehiclename"])));
                    ddlVehicle.Enabled = false;
                    ddlReplaceVehicle.ClearSelection();
                    ddlReplaceVehicle.Items.Insert(0, new System.Web.UI.WebControls.ListItem(Convert.ToString(ds.Tables[0].Rows[0]["ReplaceVehName"]), Convert.ToString(ds.Tables[0].Rows[0]["ReplaceVehName"])));
                    ddlReplaceVehicle.Enabled = false;
                    txtSdate.Text = Convert.ToString(ds.Tables[0].Rows[0]["Breakdown_Date"]);
                    txtEdate.Text = Convert.ToString(ds.Tables[0].Rows[0]["Breakdown_Date"]);
                    txtRemark.Text = Convert.ToString(ds.Tables[0].Rows[0]["Remark"]);
                    btnMarkBKD.Text = "Update";
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "Messanger.cs >> Method AddBreakdown_btnEditBreakdown_Click()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
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