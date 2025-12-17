using iTextSharp.text;
using iTextSharp.text.pdf;
using OfficeOpenXml;
using SWM.BAL;
using SWM.MODEL;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SWM
{
    public partial class JatayuRouteCoverage : System.Web.UI.Page
    {
        decimal sum = 0;
        decimal lTotalWaste = 0;
        List<MAP> mapModels = new List<MAP>();
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
            // exec proc_jatayucoveragereport @Accid = 11401,@mode = 3,@zoneId = 0,@WardId = 0,@startdate = '2023-06-01 00:00:00',@enddate = '2023-06-01 00:00:00',@vehicleid = 0
            BindDDLJayatu(11401, 3, Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value), txtSdate.Text, txtEdate.Text, 0);

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
                Logfile.TraceService("LogData", "Messanger.cs >> Method JatayuRouteCoverage_BindDDLZone()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
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
                Logfile.TraceService("LogData", "Messanger.cs >> Method JatayuRouteCoverage_BindDDLWard()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }

        void BindDDLJayatu(int @Accid, int @mode, int @zoneId, int @WardId, string @startdate, string @enddate, int @vehicleid)
        {
            try
            {
                BalFeederSummaryReport bAL = new BalFeederSummaryReport();
                FeederSummaryReport mAP = new FeederSummaryReport();
                //=====JAYATA=====//
                // exec proc_jatayucoveragereport @Accid = 11401,@mode = 3,@zoneId = 0,@WardId = 0,@startdate = '2023-06-01 00:00:00',@enddate = '2023-06-01 00:00:00',@vehicleid = 0

                DataSet dsGetJayata = bAL.GetJayatu(@Accid, @mode, @zoneId, @WardId, @startdate, @enddate, @vehicleid);
                if (dsGetJayata.Tables.Count > 0)
                {
                    DataRow allOption = dsGetJayata.Tables[0].NewRow();
                    allOption["pk_vehicleid"] = 0;
                    allOption["vehiclename"] = "Select All";
                    dsGetJayata.Tables[0].Rows.InsertAt(allOption, 0);
                    if (dsGetJayata.Tables[0].Rows.Count > 0)
                    {
                        // Set the dropdown list's data source and bind the data
                        ddlJatayu.DataSource = dsGetJayata.Tables[0];
                        ddlJatayu.DataTextField = "vehiclename"; // Field to display as option text vehiclename
                        ddlJatayu.DataValueField = "pk_vehicleid"; // Field to use as option value 
                        ddlJatayu.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "Messanger.cs >> Method JatayuRouteCoverage_BindDDLJayatu()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
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
                //==sp ref==//
                //"begin tran t
                //exec proc_jatayucoveragereport @mode=4,@AdminID=0,@RoleID=0,@AccId=11401,@ZoneId=103,@WardId=1020,@startdate=N'2023-05-29',@enddate=N'2023-05-29',@vehicleid=1326
                //rollback tran t"
                //==sp ref==//
                DataSet ds = bAL.GetJatayuCoverageReport(4, 0, 0, 11401, Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value), txtSdate.Text, txtEdate.Text, Convert.ToInt32(ddlJatayu.SelectedItem.Value));
                if (ds.Tables.Count > 0)
                {
                    if (difference.TotalDays > 31)
                    {
                        string script = "alert('Data exported successfully!');";
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
                        GenerateExcelDirectly(ds.Tables[0], "JatayuReport_" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));

                    }
                    else
                    {
                        divExport.Visible = true;
                        hheader.Visible = true;
                        lblFromDate.Text = txtSdate.Text;
                        lblEndDate.Text = txtEdate.Text;

                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            grd_Report.DataSource = ds.Tables[0];
                            grd_Report.DataBind();
                            divExport.Visible = true;
                            ViewState["GrdTable"] = ds.Tables[0];
                            lblTotalCount.Text = "TotalVisitedCronicSpot:- " + Convert.ToString(ds.Tables[0].Rows[0]["CronicSpotcnt"]);
                            lblTotalWaste.Text = "TotalWasteCollected:- " + Convert.ToString(ds.Tables[0].Rows[0]["WasteCnt"]);
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
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "Messanger.cs >> Method JatayuRouteCoverage_GrdBind()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
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
        protected void imgxls_Click(object sender, ImageClickEventArgs e)
        {
            GenerateExcel(grd_Report, "JatayuRouteCoverageReport_" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
        }

        // Override the Render method to allow the GridView to be rendered
        public override void VerifyRenderingInServerForm(Control control)
        {
            // Required to avoid the "Control 'GridView1' must be placed inside a form tag with runat=server" error
        }
        protected void imgpdf_Click(object sender, ImageClickEventArgs e)
        {
            GeneratePDF(grd_Report, "JatayuRouteCoverageReport_" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
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
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            GrdBind();
            tableWrapper.Visible = true;
        }

        protected void grd_Report_DataBound(object sender, EventArgs e)
        {

            //foreach (GridViewRow row in grd_Report.Rows)
            //{
            //    if (row.RowType == DataControlRowType.DataRow)
            //    {
            //        // Find the label control within the GridView cell
            //        Label lblVisitedCronicSpot = row.FindControl("lblVisitedCronicSpot") as Label;
            //        Label TotalWaste = row.FindControl("TotalWaste") as Label;

            //        if (lblVisitedCronicSpot != null)
            //        {
            //            // Parse the label text as a decimal and add it to the sum
            //            decimal value;
            //            if (decimal.TryParse(lblVisitedCronicSpot.Text, out value))
            //            {
            //                sum += value;
            //            }
            //        }
            //        if (TotalWaste != null)
            //        {
            //            // Parse the label text as a decimal and add it to the sum
            //            decimal value;
            //            if (decimal.TryParse(TotalWaste.Text, out value))
            //            {
            //                lTotalWaste += value;
            //            }
            //        }
            //    }
            //}
            //lblTotalCount.Text = Convert.ToString(sum);
            //lblTotalWaste.Text = Convert.ToString(lTotalWaste);
        }


        protected void ddlZone_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                if (Convert.ToInt32(ddlZone.SelectedItem.Value) >= 0)
                {
                    BindDDLWard(12, 0, 11401, Convert.ToInt32(ddlZone.SelectedItem.Value));
                    BindDDLJayatu(11401, 3, Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value), txtSdate.Text, txtEdate.Text, 0);
                }
                else
                {
                    BindLoad();
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "Messanger.cs >> Method JatayuRouteCoverage_ddlZone_SelectedIndexChanged()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
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
                    BindDDLJayatu(11401, 3, Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value), txtSdate.Text, txtEdate.Text, 0);
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "Messanger.cs >> Method JatayuRouteCoverage_ddlWard_SelectedIndexChanged()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }

        protected void grd_Report_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //if (e.Row.RowType == DataControlRowType.DataRow)
            //{
            //    ImageButton imgBtn = (ImageButton)e.Row.FindControl("ImageButton1");
            //    string imageUrl = DataBinder.Eval(e.Row.DataItem, "ImageUrl").ToString();
            //    imgBtn.Attributes["onclick"] = "showPopup('" + imageUrl + "'); return false;";
            //}
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            LinkButton clickedButton = (LinkButton)sender;
            string[] parameters = clickedButton.CommandArgument.Split('|');
            //string commandArgument = e.CommandArgument.ToString();
            //string[] parameters = commandArgument.Split('|');
            string fk_vehicleid = parameters[0];
            string date = parameters[1];
            int Wardid = Convert.ToInt32(parameters[2]);
            // Handle the parameters as needed
            // For example:
            //ShowPopup(fk_vehicleid, date);
            //LinkButton linkBtn = (LinkButton)e.Row.FindControl("LinkButton1");
            //string imageUrls = DataBinder.Eval(e.Row.DataItem, "ImageUrls").ToString();

            //BindDDLJayatu(11401, 3, Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value), txtSdate.Text, txtEdate.Text, 0);
            BalFeederSummaryReport bAL = new BalFeederSummaryReport();
            FeederSummaryReport mAP = new FeederSummaryReport();
            //=====JAYATA=====//
            // exec proc_jatayucoveragereport @Accid = 11401,@mode = 3,@zoneId = 0,@WardId = 0,@startdate = '2023-06-01 00:00:00',@enddate = '2023-06-01 00:00:00',@vehicleid = 0
            // exec proc_jatayucoveragereport @mode = 5,@AdminID = 0,@RoleID = 0,@AccId = 11401,@ZoneId = 103,@WardId = 1020,@startdate = N'2023-05-03',@enddate = N'2023-05-03',@vehicleid = 1326
            DataSet dsGetJayata = bAL.GetJayatu(11401, 5, 0, Wardid, date, date, Convert.ToInt32(fk_vehicleid));// pass the date... pending
            if (dsGetJayata.Tables.Count > 0)
            {
                // Bind the GridView with image data
                BindGridView(dsGetJayata.Tables[0]);
            }

            void BindGridView(DataTable dt)
            {
                GridView1.DataSource = dt;
                GridView1.DataBind();
                ScriptManager.RegisterStartupScript(this, GetType(), "ShowPopupScript", "showPopup();", true);
            }
        }
        private void ShowPopup(string parameter1, string parameter2)
        {
            // Handle the parameters
            // Display the popup or perform any desired actions
        }

        protected string GetCustomImageUrl(string imageUrl)
        {
            string picFineCollectionPrefix = ConfigurationManager.AppSettings["PicFineCollection"];
            if (!string.IsNullOrEmpty(imageUrl))
            {
                Uri uri = new Uri(imageUrl);
                string fileName = System.IO.Path.GetFileName(uri.LocalPath);
                return $"{picFineCollectionPrefix}{fileName}";
            }
            return string.Empty;
        }

        protected void LnkView_Click(object sender, EventArgs e)
        {
            try
            {
                //code pending
                LinkButton clickedButton = (LinkButton)sender;
                string[] parameters = clickedButton.CommandArgument.Split('|');
                string fk_vehicleid = parameters[0];
                string date = parameters[1];
                BalFeederSummaryReport bAL = new BalFeederSummaryReport();
                FeederSummaryReport mAP = new FeederSummaryReport();

                LoadJatayuLocation(date, Convert.ToInt32(fk_vehicleid));
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "Messanger.cs >> Method LnkView_Click()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }

        }
        public void LoadJatayuLocation(string Date, int fk_vehicleid)
        {
            //exec proc_jatayucoveragereport @Accid = 11401,@mode = 6,@zoneId = 0,@WardId = 0,@startdate = '2023-06-01 00:00:00',@enddate = '2023-06-01 00:00:00',@vehicleid = 1326
            mapBAL bAL = new mapBAL();
            MAP mAP = new MAP();
            mAP.mode = "6";

            DataSet dataSet = bAL.GetJatayucoveragereport(11401, 6, 0, 0, Date, Date, fk_vehicleid, "CurrentLocation");
            BindVehiclePath(dataSet.Tables[0]);
        }
        public class ListtoDataTableConverter
        {
            public DataTable ToDataTable<T>(List<T> items)
            {
                DataTable dataTable = new DataTable(typeof(T).Name);
                //Get all the properties
                PropertyInfo[] Props = typeof(T).GetProperties(BindingFlags.Public | BindingFlags.Instance);
                foreach (PropertyInfo prop in Props)
                {
                    //Setting column names as Property names
                    dataTable.Columns.Add(prop.Name);
                }
                foreach (T item in items)
                {
                    var values = new object[Props.Length];
                    for (int i = 0; i < Props.Length; i++)
                    {
                        //inserting property values to datatable rows
                        values[i] = Props[i].GetValue(item, null);
                    }
                    dataTable.Rows.Add(values);
                }
                //put a breakpoint here and check datatable
                return dataTable;
            }
        }

        public void BindVehiclePath(DataTable dataTable)
        {
            try
            {
                for (int i = 0; i < dataTable.Rows.Count; i++)
                {
                    string latitudeString = dataTable.Rows[i]["lat"].ToString();
                    string longitudeString = dataTable.Rows[i]["long"].ToString();
                    string vehicleName = dataTable.Rows[i]["optime"].ToString();

                    // Call the JavaScript function in each iteration
                    ClientScriptManager cs = Page.ClientScript;

                    string redirectUrl = "VehicleMapViewHistory.aspx?vehicleName=" + vehicleName +
                                         "&latitudeString=" + latitudeString +
                                         "&longitudeString=" + longitudeString +
                                         "&FunName=" + "Jatayu";

                    Response.Redirect(redirectUrl);
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "Messanger.cs >> Method BindVehiclePath()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
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