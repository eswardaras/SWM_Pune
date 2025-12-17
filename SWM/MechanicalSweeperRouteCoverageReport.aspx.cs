using iTextSharp.text;
using iTextSharp.text.pdf;
using Newtonsoft.Json;
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
    public partial class MechanicalSweeperRouteCoverageReport : System.Web.UI.Page
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
            //exec proc_MechanicalSweeperRouteCoverage @mode=4,@AdminID=0,@RoleID=0,@AccId=11401,@ZoneId=0,@WardId=0,@startdate=N'2023-05-03',@enddate=N'2023-05-03',@MechSweeper=N'All'
            BindDDLMechanical(3, 0, 0, 11401, Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value), txtSdate.Text, txtEdate.Text, "All");
            
        }
        void BindDDLZone()
        {
            try
            {
                BalFeederSummaryReport bAL = new BalFeederSummaryReport();
                FeederSummaryReport mAP = new FeederSummaryReport();
                //=====ZONE=====//
                //"begin tran t
                //exec proc_MechanicalSweeperRouteCoverage @mode=4,@AdminID=0,@RoleID=0,@AccId=11401,@ZoneId=0,@WardId=0,@startdate=N'2023-05-03',@enddate=N'2023-05-03',@MechSweeper=N'All'
                DataSet dsGetMechanical = bAL.GetMechanical(1, 0, 0, 11401, 0, 0, txtSdate.Text, txtSdate.Text, "All");
                //rollback tran t"
                //==sp ref==//
                DataSet ds = dsGetMechanical;// bAL.GetZone(11, 0, 11401);
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
                Logfile.TraceService("LogData", "Messanger.cs >> Method MechanicalSweeperRouteCoverageReport_BindDDLZone()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
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
                //exec proc_MechanicalSweeperRouteCoverage @mode=4,@AdminID=0,@RoleID=0,@AccId=11401,@ZoneId=0,@WardId=0,@startdate=N'2023-05-03',@enddate=N'2023-05-03',@MechSweeper=N'All'

                DataSet dsGetMechanical = bAL.GetMechanical(2, 0, 0, 11401,Convert.ToInt32(ddlZone.SelectedItem.Value), 0, txtSdate.Text, txtSdate.Text, "All");
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
                Logfile.TraceService("LogData", "Messanger.cs >> Method MechanicalSweeperRouteCoverageReport_BindDDLWard()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }
        void BindDDLMechanical(int @mode, int @AdminID, int @RoleID, int @AccId, int @ZoneId, int @WardId, string @startdate, string @enddate, string @MechSweeper)
        {
            try
            {
                BalFeederSummaryReport bAL = new BalFeederSummaryReport();
                FeederSummaryReport mAP = new FeederSummaryReport();
                //=====MechanicalSweeper=====//
                //exec proc_MechanicalSweeperRouteCoverage @mode=4,@AdminID=0,@RoleID=0,@AccId=11401,@ZoneId=0,@WardId=0,@startdate=N'2023-05-03',@enddate=N'2023-05-03',@MechSweeper=N'All'
                DataSet dsGetMechanical = bAL.GetMechanical(@mode, @AdminID, @RoleID, @AccId, @ZoneId, @WardId, @startdate, @enddate, @MechSweeper);
                if (dsGetMechanical.Tables.Count > 0)
                {
                    DataRow allOption = dsGetMechanical.Tables[0].NewRow();
                    allOption["pk_vehicleid"] = 0;
                    allOption["vehiclename"] = "Select All";
                    dsGetMechanical.Tables[0].Rows.InsertAt(allOption, 0);
                    if (dsGetMechanical.Tables[0].Rows.Count > 0)
                    {
                        // Set the dropdown list's data source and bind the data
                        ddlMechanical.DataSource = dsGetMechanical.Tables[0];
                        ddlMechanical.DataTextField = "vehiclename"; // Field to display as option text 
                        ddlMechanical.DataValueField = "pk_vehicleid"; // Field to use as option value  
                        ddlMechanical.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "Messanger.cs >> Method MechanicalSweeperRouteCoverageReport_BindDDLMechanical()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }

        void BindChart1(int @mode, int @AdminID, int @RoleID, int @AccId, int @ZoneId, int @WardId, string @startdate, string @enddate, string @MechSweeper)
        {
            try
            {
                BalFeederSummaryReport bAL = new BalFeederSummaryReport();
                FeederSummaryReport mAP = new FeederSummaryReport();
                //=====1.City Wise 2.Zone Wise=====//
                //exec proc_MechanicalSweeperRouteCoverage @mode = 5,@AdminID = 0,@RoleID = 0,@AccId = 11401,@ZoneId = 0,@WardId = 0,@startdate = N'2023-05-03',@enddate = N'2023-05-03',@MechSweeper = N'All'
                DataSet dsGetMechanical = bAL.GetMechanical(@mode, @AdminID, @RoleID, @AccId, @ZoneId, @WardId, @startdate, @enddate, @MechSweeper);
                if (dsGetMechanical.Tables.Count > 0)
                {
                    //citywise
                    if (dsGetMechanical.Tables[0].Rows.Count > 0)
                    {
                        string dataTableJsonCityWise = JsonConvert.SerializeObject(dsGetMechanical.Tables[0]);
                        hiddenFielddataTableJsonCityWise.Value = dataTableJsonCityWise;
                    }
                    //ZoneWise
                    if (dsGetMechanical.Tables[1].Rows.Count > 0)
                    {
                        string dataTableJsonZoneWise = JsonConvert.SerializeObject(dsGetMechanical.Tables[1]);
                        hiddenFielddataTableJsonZoneWise.Value = dataTableJsonZoneWise;
                    }
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "Messanger.cs >> Method MechanicalSweeperRouteCoverageReport_BindChart1()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }
        void BindChart2(int @mode, int @AdminID, int @RoleID, int @AccId, int @ZoneId, int @WardId, string @startdate, string @enddate, string @MechSweeper)
        {
            try
            {
                BalFeederSummaryReport bAL = new BalFeederSummaryReport();
                FeederSummaryReport mAP = new FeederSummaryReport();
                //=====1.City Wise Route Covered(KM) 2.Zone Wise Route Covered(KM)=====//
                //exec proc_MechanicalSweeperRouteCoverage @mode = 6,@AdminID = 0,@RoleID = 0,@AccId = 11401,@ZoneId = 0,@WardId = 0,@startdate = N'2023-05-03',@enddate = N'2023-05-03',@MechSweeper = N'All'
                DataSet dsGetMechanical = bAL.GetMechanical(@mode, @AdminID, @RoleID, @AccId, @ZoneId, @WardId, @startdate, @enddate, @MechSweeper);
                if (dsGetMechanical.Tables.Count > 0)
                {
                    //citywise
                    if (dsGetMechanical.Tables[0].Rows.Count > 0)
                    {
                        string dataTableJsonCityWiseRouteCovered = JsonConvert.SerializeObject(dsGetMechanical.Tables[0]);
                        hiddenFielddataTableJsonCityWiseRouteCovered.Value = dataTableJsonCityWiseRouteCovered;
                    }
                    //ZoneWise
                    if (dsGetMechanical.Tables[1].Rows.Count > 0)
                    {
                        string dataTableJsonZoneWiseRouteCovered = JsonConvert.SerializeObject(dsGetMechanical.Tables[1]);
                        hiddenFielddataTableJsonZoneWiseRouteCovered.Value = dataTableJsonZoneWiseRouteCovered;
                    }
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "Messanger.cs >> Method MechanicalSweeperRouteCoverageReport_BindChart2()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
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
            BindChart1(5, 0, 0, 11401, Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value), txtSdate.Text, txtEdate.Text, "All");
            BindChart2(6, 0, 0, 11401, Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value), txtSdate.Text, txtEdate.Text, "All");
            tableWrapper.Visible = true;
            chartWrapper.Visible = true;
        }
        void GrdBind()
        {
            try
            {
                BalFeederSummaryReport bAL = new BalFeederSummaryReport();
                FeederSummaryReport mAP = new FeederSummaryReport();
                //==sp ref==//
                //"begin tran t
                //exec proc_MechanicalSweeperRouteCoverage @mode=4,@AdminID=0,@RoleID=0,@AccId=11401,@ZoneId=0,@WardId=0,@startdate=N'2023-05-03',@enddate=N'2023-05-03',@MechSweeper=N'All'
                //rollback tran t"
                //==sp ref==//
                DataSet ds = bAL.GetMechanicalSweeperRouteCoverageReport(4, 0, 0, 11401, Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value), txtSdate.Text, txtEdate.Text, "All");
                if (ds.Tables.Count > 0)
                {
                    divExport.Visible = true;
                    hheader.Visible = true;
                    lblFromDate.Text = txtSdate.Text;
                    lblEndDate.Text = txtEdate.Text;

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        grd_Report.DataSource = ds.Tables[0];
                        grd_Report.DataBind();
                        ViewState["GrdTable"] = ds.Tables[0];
                        divExport.Visible = true;
                    }
                    else
                    {
                        grd_Report.DataSource = null;
                        grd_Report.DataBind();
                        ViewState["GrdTable"] = null;
                        divExport.Visible = false;
                    }
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "Messanger.cs >> Method MechanicalSweeperRouteCoverageReport_GrdBind()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
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
            GenerateExcel(grd_Report, "MechanicalSweeperRouteCoverageReport_" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
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
                dt = ViewState["GrdTable"] as DataTable;//; GetDataFromGridView(gridView);
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
            DataTable dt = ViewState["GrdTable"] as DataTable;

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
            GeneratePDF(grd_Report, "MechanicalSweeperRouteCoverageReport_" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
        }
        protected void ddlZone_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                if (Convert.ToInt32(ddlZone.SelectedItem.Value) >= 0)
                {
                    BindDDLWard(12, 0, 11401, Convert.ToInt32(ddlZone.SelectedItem.Value));
                    BindDDLMechanical(3, 0, 0, 11401, Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value), txtSdate.Text, txtEdate.Text, "All");

                }
                else
                {
                    BindLoad();
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "Messanger.cs >> Method MechanicalSweeperRouteCoverageReport_ddlZone_SelectedIndexChanged()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
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
                    BindDDLMechanical(3, 0, 0, 11401, Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value), txtSdate.Text, txtEdate.Text, "All");
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "Messanger.cs >> Method MechanicalSweeperRouteCoverageReport_ddlWard_SelectedIndexChanged()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }

        protected void LnkView_Click(object sender, EventArgs e)
        {
            //try
            //{
                //code pending
                LinkButton clickedButton = (LinkButton)sender;
                string[] parameters = clickedButton.CommandArgument.Split('|');
                string Pk_Vehicleid = parameters[0];
                string date = parameters[1];
                DataTable u = (DataTable)ViewState["GrdTable"];
                string routeid = u.AsEnumerable().Where(x => x["pk_vehicleid"].ToString() == Pk_Vehicleid).FirstOrDefault()["routeid"].ToString();

            BalFeederSummaryReport bAL = new BalFeederSummaryReport();
                FeederSummaryReport mAP = new FeederSummaryReport();
                string redirectUrl = "VehicleMapViewHistory.aspx?fk_vehicleid=" + Pk_Vehicleid +
                                       "&date=" + date +
                                       "&routeid=" + routeid +
                                        "&FunName=" + "MechanicalSweeperReport";

                Response.Redirect(redirectUrl);
                //LoadData(date, Convert.ToInt32(fk_vehicleid));
            //}
            //catch (Exception ex)
            //{
            //    Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
            //    Logfile.TraceService("LogData", "Messanger.cs >> Method LnkView_Click()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
            //    Logfile.TraceService("LogData", "Message >> " + ex.Message);
            //    Logfile.TraceService("LogData", "Source >> " + ex.Source);
            //    Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
            //    Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
            //    Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
            //    Logfile.TraceService("LogData", ex.Message);
            //}


        }
    }
}