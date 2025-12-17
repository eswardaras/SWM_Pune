using iTextSharp.text;
using iTextSharp.text.pdf;
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
    public partial class GroupReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        protected void btnSearch_Click(object sender, EventArgs e)
        {
            GrdBind();
        }
        void GrdBind()
        {
            try
            {
                BalFeederSummaryReport bAL = new BalFeederSummaryReport();
                FeederSummaryReport mAP = new FeederSummaryReport();
                //==sp ref==//
                //"begin tran t
                //exec proc_ReportsDataBind @mode=3,@vehicleId=0,@AccId=11401,@ZoneId=0,@WardId=0,@startdate=N'2023-05-11 00:00',@enddate=N'2023-05-11 23:59',@stime=default,@etime=default,
                // @RptName =N'Breakdown',@Report=default,@Zone=N'All',@Ward=N'All',@WorkingType=N'All',@RouteId=0,@AdminID=0,@RoleID=0
                //rollback tran t"
                //==sp ref==//
                if (ddlReportsName.SelectedItem.Text == "Odometer")
                {
                    DataSet ds = bAL.GetPerformanceReports(3, 0, 11401, 0, 0, "2023-05-11 00:00", "2023-05-22 00:00", "default", "default", "Odometer", "default", "All", "All", "All", "0", "0", "0");
                    if (ds.Tables.Count > 0)
                    {
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            grd_Odometer.Visible = true;
                            grd_Breakdown.Visible = false;
                            //grid_Trip.Visible = false;
                            hheader.Visible = true;
                            lblFromDate.Text = "2023-05-22";
                            lblEndDate.Text = "2023-05-22";
                            lblReportName.Text = ddlReportsName.SelectedItem.Text + " Report";
                            divExport.Visible = true;
                            // Assuming you have already populated your data source
                            // List<YourDataType> dataList = GetData();

                            // Clear existing columns
                            grd_Odometer.Columns.Clear();
                            // Create new columns with modified header names
                            grd_Odometer.Columns.Add(new BoundField
                            {
                                DataField = "Date",
                                HeaderText = "Date"
                            });
                            // Create new columns with modified header names
                            grd_Odometer.Columns.Add(new BoundField
                            {
                                DataField = "Vehicle",
                                HeaderText = "Vehicle"
                            });
                            // Create new columns with modified header names
                            grd_Odometer.Columns.Add(new BoundField
                            {
                                DataField = "Distance Travelled  ( Todays Kms )",
                                HeaderText = "Distance Travelled  ( Todays Kms )"
                            });
                            grd_Odometer.Columns.Add(new BoundField
                            {
                                DataField = "Distance Travelled( Total kms )",
                                HeaderText = "Distance Travelled( Total kms )"
                            });
                            grd_Odometer.DataSource = ds.Tables[0];
                            grd_Odometer.DataBind();
                        }

                        else
                        {
                            Response.Write("No data found!!");
                        }
                    }
                }
                else if (ddlReportsName.SelectedItem.Text == "Breakdown")
                {
                    DataSet ds = bAL.GetPerformanceReports(3, 0, 11401, 0, 0, "2023-05-11 00:00", "2023-05-22 00:00", "default", "default", "Breakdown", "default", "All", "All", "All", "0", "0", "0");
                    if (ds.Tables.Count > 0)
                    {
                        hheader.Visible = true;
                        grd_Odometer.Visible = false;
                        grd_Breakdown.Visible = true;

                        lblFromDate.Text = "2023-05-22";
                        lblEndDate.Text = "2023-05-22";
                        lblReportName.Text = ddlReportsName.SelectedItem.Text + " Report";

                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            divExport.Visible = true;

                            grd_Breakdown.DataSource = ds.Tables[0];
                            grd_Breakdown.DataBind();
                        }

                        else
                        {
                            Response.Write("No data found!!");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "Messanger.cs >> Method GroupReport_GrdBind()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
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
            if (grd_Breakdown.Visible == true)
            {
                GenerateExcel(grd_Breakdown, ddlReportsName.SelectedItem.Text + "Reports_" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
            }
            else
            {
                GenerateExcel(grd_Odometer, ddlReportsName.SelectedItem.Text + "Reports_" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
            }
            //GenerateExcel(grd_DailyOdometer, ddlReportsName.SelectedItem.Text + "Reports_" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
        }

        // Override the Render method to allow the GridView to be rendered
        public override void VerifyRenderingInServerForm(Control control)
        {
            // Required to avoid the "Control 'GridView1' must be placed inside a form tag with runat=server" error
        }
        void GenerateExcel(GridView grd_Report, string filename)
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
        void GeneratePDF(GridView grd_Report, string filename)
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


        protected void imgpdf_Click(object sender, ImageClickEventArgs e)
        {
            if (grd_Breakdown.Visible == true)
            {
                GenerateExcel(grd_Breakdown, ddlReportsName.SelectedItem.Text + "Reports_" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
            }
            else
            {
                GenerateExcel(grd_Odometer, ddlReportsName.SelectedItem.Text + "Reports_" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
            }
        }
    }
}