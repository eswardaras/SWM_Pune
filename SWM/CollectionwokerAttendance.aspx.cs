using Newtonsoft.Json;
using SWM.BAL;
using SWM.MODEL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.IO.Compression;
using iTextSharp.text;
using iTextSharp.text.pdf;
using OfficeOpenXml;

namespace SWM
{
    public partial class CollectionwokerAttendance : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
                BindAllDropDown();
                //BindDDLVehicle();
            }
        }
        protected void YourGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string status = DataBinder.Eval(e.Row.DataItem, "status").ToString();
                Button btnComplete = (Button)e.Row.FindControl("btnComplete");

                // Disable the button if status is "Absent"
                if (status == "Absent")
                {
                    btnComplete.Enabled = false;
                    btnComplete.CssClass += " disabled"; // Optionally add a CSS class to style the disabled button
                }
            }
        }

        protected void OnPaging(object sender, GridViewPageEventArgs e)
        {
            gvAttendance.PageIndex = e.NewPageIndex;
            this.BindGrid();
        }
        private void BindGrid()
        {
            if (!IsPostBack) return;
            HHComercialBAL bAL = new HHComercialBAL();
            //=====ZONE=====//
            //"begin tran t
            //exec proc_SweeperRouteCoverageReportNew @mode = 11,@vehicleId = 0,@AccId = 11401,@ZoneId = 0,@WardId = 0,@startdate = default,@enddate = default,@stime = default,@etime = default,@RptName = default,@Report = default,@Zone = default,@Ward = default,@WorkingType = default,@RouteId = 0,@AdminID = 0,@RoleID = 0
            //rollback tran t"
            //==sp ref==//
            //txtFromDate.Text = DateTime.Now.Date.ToString();
            //txtToDate.Text = DateTime.Now.Date.ToString();
            DateTime fromdate = DateTime.Parse(txtFromDate.Text);
            DateTime todate = DateTime.Parse(txtToDate.Text);

            // Calculate the difference between the two dates
            TimeSpan difference = todate - fromdate;

            DataSet ds = bAL.GetBCAttendance(Convert.ToInt16(ddlZone.SelectedValue == "" ? "0" : ddlZone.SelectedValue), Convert.ToInt16(ddlWard.SelectedValue == "" ? "0" : ddlWard.SelectedValue), Convert.ToInt16(ddlKothi.SelectedValue == "" ? "0" : ddlKothi.SelectedValue), Convert.ToInt16(ddlPrabhag.SelectedValue == string.Empty ? "0" : ddlPrabhag.SelectedValue), Convert.ToDateTime(txtFromDate.Text), Convert.ToDateTime(txtToDate.Text));
            if (ds.Tables.Count > 0)
            {
                if (difference.TotalDays >= 30)
                {
                    GenerateExcelFilesAndDownload(ds);
                }
                else
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        gvwardwise.DataSource = ds.Tables[0];
                        gvwardwise.DataBind();
                    }
                    if (ds.Tables[1].Rows.Count > 0)
                    {
                        gvPrabhag.DataSource = ds.Tables[1];
                        gvPrabhag.DataBind();
                    }
                    if (ds.Tables[2].Rows.Count > 0)
                    {
                        gvAttendance.DataSource = ds.Tables[2];
                        gvAttendance.DataBind();
                    }

                    //#region hiddenchart field
                    //CitywisePresent.Value = ds.Tables[1].Rows[0]["Present"].ToString();
                    //CitywiseAbsent.Value = ds.Tables[1].Rows[0]["Absent"].ToString();
                    //ZonewisePresent.Value = ds.Tables[2].Rows[0]["Present"].ToString();
                    //ZonewiseAbsent.Value = ds.Tables[2].Rows[0]["Absent"].ToString();
                    //zonewisetable.Value = JsonConvert.SerializeObject(ds.Tables[2], Formatting.Indented);


                    //// //
                    //string cityWiseData = CitywisePresent.Value + "," + CitywiseAbsent.Value;
                    //string zoneWiseData = ZonewisePresent.Value + "," + ZonewiseAbsent.Value;

                    //cityWiseChartData.Value = cityWiseData;
                    //zoneWiseChartData.Value = zoneWiseData;
                    // //
                    //#endregion
                }
            }
            // ViewState["Data"] = ds;
        }

        //protected void GenerateExcelDirectly(DataTable dataTable, string fileName)
        //{
        //    ExcelPackage.LicenseContext = LicenseContext.NonCommercial; // Set the license context

        //    using (var package = new ExcelPackage())
        //    {
        //        var worksheet = package.Workbook.Worksheets.Add("Attendance Report");

        //        DataTable dt = new DataTable();
        //        // Populate dt with data from the GridView or your data source
        //        // For example: dt = GetDataFromGridView(gridView);
        //        dt = dataTable;//; GetDataFromGridView(gridView);
        //        // Write DataTable content to Excel worksheet
        //        worksheet.Cells["A1"].LoadFromDataTable(dt, true);

        //        Response.Clear();
        //        Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
        //        Response.AddHeader("content-disposition", "attachment;filename=" + fileName + ".xlsx");
        //        Response.BinaryWrite(package.GetAsByteArray());
        //        Response.End();
        //    }
        //}

        protected void GenerateExcelFilesAndDownload(DataSet dataSet)
        {
            // Set the license context for EPPlus
            ExcelPackage.LicenseContext = LicenseContext.NonCommercial;

            // Create a memory stream to hold the ZIP file
            using (var zipStream = new MemoryStream())
            {
                using (var archive = new ZipArchive(zipStream, ZipArchiveMode.Create, true))
                {
                    // Loop through each DataTable and create an Excel file for each
                    for (int i = 0; i < dataSet.Tables.Count; i++)
                    {
                        DataTable dataTable = dataSet.Tables[i];
                        string fileName = GetFileNameForTable(i);

                        // Create an Excel file for the current DataTable
                        using (var package = new ExcelPackage())
                        {
                            var worksheet = package.Workbook.Worksheets.Add("Sheet1");
                            worksheet.Cells["A1"].LoadFromDataTable(dataTable, true);

                            // Create a ZIP entry for the current Excel file
                            var zipEntry = archive.CreateEntry(fileName + ".xlsx");

                            using (var entryStream = zipEntry.Open())
                            using (var excelStream = new MemoryStream(package.GetAsByteArray()))
                            {
                                excelStream.CopyTo(entryStream);
                            }
                        }
                    }
                }

                // Send the ZIP file as the response
                Response.Clear();
                Response.ContentType = "application/zip";
                Response.AddHeader("content-disposition", "attachment;filename=AttendanceReports.zip");
                zipStream.Seek(0, SeekOrigin.Begin);
                Response.BinaryWrite(zipStream.ToArray());
                Response.End();
            }
        }

        private string GetFileNameForTable(int tableIndex)
        {
            string baseName = "Collection Worker Attendance Report";
            string dateSuffix = DateTime.Now.ToString("MM-dd-yyyy HH-mm");

            switch (tableIndex)
            {
                case 0:
                    return $"{baseName} - Ward wise {dateSuffix}";
                case 1:
                    return $"{baseName} - Prabhag wise {dateSuffix}";
                case 2:
                    return $"{baseName} {dateSuffix}";
                default:
                    return $"{baseName} {tableIndex} {dateSuffix}";
            }
        }
        protected void btnviewroute(object sender, EventArgs e)
        {
            LinkButton clickedButton = (LinkButton)sender;
            string[] parameters = clickedButton.CommandArgument.Split('|');
            string fk_vehicleid = parameters[0];
            string date = parameters[1];
            BalFeederSummaryReport bAL = new BalFeederSummaryReport();
            FeederSummaryReport mAP = new FeederSummaryReport();

            LoadJatayuLocation(date, Convert.ToInt32(fk_vehicleid));
            //=====JAYATA=====//
            // exec proc_jatayucoveragereport @Accid = 11401,@mode = 3,@zoneId = 0,@WardId = 0,@startdate = '2023-06-01 00:00:00',@enddate = '2023-06-01 00:00:00',@vehicleid = 0
            // exec proc_jatayucoveragereport @mode = 5,@AdminID = 0,@RoleID = 0,@AccId = 11401,@ZoneId = 103,@WardId = 1020,@startdate = N'2023-05-03',@enddate = N'2023-05-03',@vehicleid = 1326
            //DataSet dsGetJayata = bAL.GetJayatu(11401, 5, 103, 1020, date, date, Convert.ToInt32(fk_vehicleid));// pass the date... pending
            //if (dsGetJayata.Tables.Count > 0)
            //{
            //    // Bind the GridView with image data
            //    BindGridView(dsGetJayata.Tables[0]);
            //}

            //void BindGridView(DataTable dt)
            //{
            //    GridView1.DataSource = dt;
            //    GridView1.DataBind();
            //    ScriptManager.RegisterStartupScript(this, GetType(), "ShowPopupScript", "showPopupmap();", true);
            //}
            // ScriptManager.RegisterStartupScript(this, GetType(), "ShowPopupScript", "showPopupmap();", true);

        }
        protected void yourGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ViewRoute")
            {
                int rowIndex = 0;//Convert.ToInt32(e.CommandArgument);

                string[] arguments = e.CommandArgument.ToString().Split(',');

                string pk_vehicleid = arguments[0];
                string routeid = arguments[1];
                string kothi = arguments[2];
                string intime = arguments[3];
                string outtime = arguments[4];
                if (string.IsNullOrEmpty(pk_vehicleid) || string.IsNullOrEmpty(routeid) || string.IsNullOrEmpty(kothi) || string.IsNullOrEmpty(intime) || string.IsNullOrEmpty(outtime))
                    return;
                // Access the selected row using the rowIndex
                //DataRow selectedRow = ((DataSet)ViewState["Data"]).Tables[0].Rows[rowIndex];
                //string column2Value = gvAttendance.Rows[rowIndex].Cells[1].Text;
                #region fetch Polygon
                HHComercialBAL bAL = new HHComercialBAL();
                DataSet dsPolygon = bAL.getpolygon(Convert.ToInt16(pk_vehicleid), Convert.ToInt16(routeid));
                DataSet dsRoute = bAL.getKothiradiusroute(kothi.ToString().Trim());
                Showmap(dsPolygon, dsRoute, Convert.ToInt16(pk_vehicleid), Convert.ToInt16(routeid), string.IsNullOrEmpty(intime) ? null : intime, string.IsNullOrEmpty(outtime) ? null : outtime);
                #endregion
                // Access the selected row using the rowIndex


                // Access the data from the selected row
                // string columnName = selectedRow.Cells[columnIndex].Text;
                // ... access other cells or data as needed

                // Call your code logic or perform further operations with the selected row data
                // Example:
                // YourMethod(columnName);
            }
        }
        public void LoadJatayuLocation(string Date, int fk_vehicleid)
        {
            //exec proc_jatayucoveragereport @Accid = 11401,@mode = 6,@zoneId = 0,@WardId = 0,@startdate = '2023-06-01 00:00:00',@enddate = '2023-06-01 00:00:00',@vehicleid = 1326
            HHComercialBAL bAL = new HHComercialBAL();
            MAP mAP = new MAP();
            mAP.mode = "6";

            //DataSet dataSet = bAL.GetJatayucoveragereport(11401, 6, 0, 0, Date, Date, fk_vehicleid, "CurrentLocation");
            //ListtoDataTableConverter converter = new ListtoDataTableConverter();
            //DataTable dt = converter.ToDataTable(mapModels);

            //BindVehiclePath(dataSet.Tables[0]);
        }

        public void Showmap(DataSet dsPolygon, DataSet dskothiradius, short v, short v1, object v2, object v3)
        {
            try
            {

                // Call the JavaScript function in each iteration
                // Call the JavaScript function in each iteration
                ClientScriptManager cs = Page.ClientScript;

                string redirectUrl = "VehicleMapViewHistory1.aspx?lat=" + dskothiradius.Tables[0].Rows[0]["latitude"] +
                                     "&lon=" + dskothiradius.Tables[0].Rows[0]["longitude"] +
                                     "&vehicleid=" + v +
                                     "&sd=" + v2 +
                                     "&ed=" + v3 +
                                     "&routeid=" + v1;

                Response.Redirect(redirectUrl);
                //string script = "showPopupmap('" + vehicleName + "', " + latitudeString + ", " + longitudeString + ");";
                //ScriptManager.RegisterStartupScript(this, GetType(), "ShowPopupScript" + i.ToString(), script, true);


            }
            catch (Exception ex)
            {
                //clsCreateLogFile.TraceService("MessangerServiceLog", "\n-----------------------EXCEPTION START-----------------------");
                //clsCreateLogFile.TraceService("MessangerServiceLog", "Messanger.cs >> Method BindVehiclePath >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                //clsCreateLogFile.TraceService("MessangerServiceLog", "Message >> " + ex.Message);
                //clsCreateLogFile.TraceService("MessangerServiceLog", "Source >> " + ex.Source);
                //clsCreateLogFile.TraceService("MessangerServiceLog", "InnerException >> " + Convert.ToString(ex.InnerException));
                //clsCreateLogFile.TraceService("MessangerServiceLog", "StackTrace >> " + ex.StackTrace);
                //clsCreateLogFile.TraceService("MessangerServiceLog", "-----------------------EXCEPTION END-----------------------");
                // throw ex;
            }
        }

        public void BindVehiclePath(DataTable dataTable)
        {
            try
            {
                for (int i = 0; i < dataTable.Rows.Count; i++)
                {
                    string latitudeString = dataTable.Rows[i]["latitude"].ToString();
                    string longitudeString = dataTable.Rows[i]["longitude"].ToString();
                    string vehicleName = dataTable.Rows[i]["routename"].ToString();

                    // Call the JavaScript function in each iteration
                    ClientScriptManager cs = Page.ClientScript;

                    string redirectUrl = "VehicleMapViewHistory.aspx?vehicleName=" + vehicleName +
                                         "&latitudeString=" + latitudeString +
                                         "&longitudeString=" + longitudeString;

                    Response.Redirect(redirectUrl);
                    //string script = "showPopupmap('" + vehicleName + "', " + latitudeString + ", " + longitudeString + ");";
                    //ScriptManager.RegisterStartupScript(this, GetType(), "ShowPopupScript" + i.ToString(), script, true);
                }


            }
            catch (Exception ex)
            {
                //clsCreateLogFile.TraceService("MessangerServiceLog", "\n-----------------------EXCEPTION START-----------------------");
                //clsCreateLogFile.TraceService("MessangerServiceLog", "Messanger.cs >> Method BindVehiclePath >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                //clsCreateLogFile.TraceService("MessangerServiceLog", "Message >> " + ex.Message);
                //clsCreateLogFile.TraceService("MessangerServiceLog", "Source >> " + ex.Source);
                //clsCreateLogFile.TraceService("MessangerServiceLog", "InnerException >> " + Convert.ToString(ex.InnerException));
                //clsCreateLogFile.TraceService("MessangerServiceLog", "StackTrace >> " + ex.StackTrace);
                //clsCreateLogFile.TraceService("MessangerServiceLog", "-----------------------EXCEPTION END-----------------------");
                // throw ex;
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
            RampBAL bAL = new RampBAL();
            DatewiseWeightReport mAP = new DatewiseWeightReport();
            BindGrid();
            //=====ZONE=====//
            //"begin tran t
            //exec proc_SweeperRouteCoverageReportNew @mode = 11,@vehicleId = 0,@AccId = 11401,@ZoneId = 0,@WardId = 0,@startdate = default,@enddate = default,@stime = default,@etime = default,@RptName = default,@Report = default,@Zone = default,@Ward = default,@WorkingType = default,@RouteId = 0,@AdminID = 0,@RoleID = 0
            //rollback tran t"
            //==sp ref==//
            //DataSet ds = bAL.GetReqReport(Convert.ToInt16(ddlZone.SelectedValue), Convert.ToInt16(ddlKothi.SelectedValue), Convert.ToDateTime(txtFromDate.Text), Convert.ToDateTime(txtToDate.Text), rbCD.Checked ? "C & D Waste" : "Special waste");
            //if (ds.Tables.Count > 0) { }
            // {
            //    if (ds.Tables[0].Rows.Count > 0)
            //    {
            //        if (!rbCD.Checked)
            //        {
            //            var lst = new List<DataControlField>();
            //            foreach (DataControlField column in adhoctable.Columns)
            //            {
            //                if (column.HeaderText.Equals("mokadam", StringComparison.OrdinalIgnoreCase))
            //                {
            //                    // adhoctable.Columns.Remove(column);
            //                    lst.Add(column);
            //                }

            //                if (column.HeaderText.Equals("remark", StringComparison.OrdinalIgnoreCase))
            //                {
            //                    //adhoctable.Columns.Remove(column);
            //                    lst.Add(column);
            //                }
            //            }
            //            if (lst.Count() > 1)
            //            {
            //                adhoctable.Columns.Remove(lst[0]);
            //                adhoctable.Columns.Remove(lst[1]);
            //            }

            //        }
            //        else
            //        {
            //            if (!IsColumnExists("mokadam", adhoctable))
            //            {
            //                BoundField boundField = new BoundField();
            //                boundField.DataField = "mokadam";
            //                boundField.HeaderText = "Mokadam";
            //                adhoctable.Columns.Add(boundField);
            //            }

            //            if (!IsColumnExists("remark", adhoctable))
            //            {
            //                BoundField boundField = new BoundField();
            //                boundField.DataField = "remark";
            //                boundField.HeaderText = "remark";
            //                adhoctable.Columns.Add(boundField);
            //            }

            //        }
            //        adhoctable.DataSource = ds.Tables[0];
            //        adhoctable.DataBind();
            //        //ddlRamp.DataSource = ds.Tables[0];
            //        //ddlRamp.DataTextField = "RMM_NAME"; // Field to display as option text
            //        //ddlRamp.DataValueField = "RMM_ID"; // Field to use as option value
            //        //ddlRamp.DataBind();
            //    }
            //}
            chartWrapper.Visible = true;
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


        protected void SetCityWiseChartData()
        {
            // Simulate data retrieval from your data source
            List<string> labels = new List<string> { "Present", "Absent" };
            List<int> values = new List<int> { 19, 240 };

            // Serialize the data as JSON string
            string jsonData = JsonConvert.SerializeObject(new { labels, values });

            // Set the JSON data as a hidden field value
            cityWiseChartData.Value = jsonData;
        }

        protected void SetZoneWiseChartData()
        {
            // Simulate data retrieval from your data source
            List<string> labels = new List<string> { "Status" };
            List<int> presentValues = new List<int> { 19 };
            List<int> absentValues = new List<int> { 240 };

            // Serialize the data as JSON string
            zoneWiseChartData.Value = JsonConvert.SerializeObject(new { labels, presentValues, absentValues });
        }




        void BindDDLKothiPrabhag(int @mode, int @Fk_accid, int @Fk_ambcatId, int @Fk_divisionid, int @FK_VehicleID, int @Fk_ZoneId, int @FK_WardId, string @Startdate, string @Enddate,
        int @Maxspeed, int @Minspeed, int @Fk_DistrictId, int @Geoid)
        {
            try
            {
                BalFeederSummaryReport bAL = new BalFeederSummaryReport();
                FeederSummaryReport mAP = new FeederSummaryReport();
                //=====WARD=====//
                //exec Proc_VehicleMapwithRoute @mode=56,@Fk_accid=11401,@Fk_ambcatId=0,@Fk_divisionid=0,@FK_VehicleID=0,@Fk_ZoneId=0,@FK_WardId=1024,@Startdate=default,@Enddate=default,
                //@Maxspeed =0,@Minspeed=0,@Fk_DistrictId=0,@Geoid=0
                //DataSet dsGetKothi = bAL.GetKothi(@mode, @Fk_accid, @Fk_ambcatId, @Fk_divisionid, @FK_VehicleID, @Fk_ZoneId, @FK_WardId, @Startdate, @Enddate, @Maxspeed, @Minspeed, @Fk_DistrictId, @Geoid);
                //if (dsGetKothi.Tables.Count > 0)
                //{
                //    DataRow allOption = dsGetKothi.Tables[0].NewRow();
                //    allOption["pk_kothiid"] = 0;
                //    allOption["kothiname"] = "Select All";
                //    dsGetKothi.Tables[0].Rows.InsertAt(allOption, 0);
                //    if (dsGetKothi.Tables[0].Rows.Count > 0)
                //    {
                //        // Set the dropdown list's data source and bind the data
                //        ddlKothi.DataSource = dsGetKothi.Tables[0];
                //        ddlKothi.DataTextField = "kothiname"; // Field to display as option text  
                //        ddlKothi.DataValueField = "pk_kothiid"; // Field to use as option value  
                //        ddlKothi.DataBind();
                //    }
                //}

                DataSet dsGetPrabhag = bAL.GetPrabhag(@mode, @Fk_accid, @Fk_ZoneId, @FK_WardId);
                if (dsGetPrabhag.Tables.Count > 0)
                {
                    DataRow allOption = dsGetPrabhag.Tables[0].NewRow();
                    allOption["pk_prabhagid"] = 0;
                    allOption["prabhagname"] = "Select All";
                    dsGetPrabhag.Tables[0].Rows.InsertAt(allOption, 0);
                    if (dsGetPrabhag.Tables[0].Rows.Count > 0)
                    {
                        // Set the dropdown list's data source and bind the data
                        ddlPrabhag.DataSource = dsGetPrabhag.Tables[0];
                        ddlPrabhag.DataTextField = "prabhagname"; // Field to display as option text  
                        ddlPrabhag.DataValueField = "pk_prabhagid"; // Field to use as option value  
                        ddlPrabhag.DataBind();
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
                    BindDDLKothiPrabhag(56, 11401, 0, 0, Convert.ToInt32(ddlWard.SelectedItem.Value), Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value),

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
                if (gvAttendance.Rows.Count > 0)
                    GeneratePDF(gvAttendance, "Attendance_" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "DatewiseWeightReport.cs >> Method btnpdf_Click()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
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
                HHComercialBAL bAL = new HHComercialBAL();
                DataSet ds = bAL.GetBCAttendance(Convert.ToInt16(ddlZone.SelectedValue == "" ? "0" : ddlZone.SelectedValue), Convert.ToInt16(ddlWard.SelectedValue == "" ? "0" : ddlWard.SelectedValue), Convert.ToInt16(ddlKothi.SelectedValue == "" ? "0" : ddlKothi.SelectedValue), Convert.ToInt16(ddlPrabhag.SelectedValue == string.Empty ? "0" : ddlPrabhag.SelectedValue), Convert.ToDateTime(txtFromDate.Text), Convert.ToDateTime(txtToDate.Text));
                if (ds.Tables.Count > 0)
                {

                    if (ds.Tables[2].Rows.Count > 0)
                        GenerateExcel(ds.Tables[2], "Attendance_" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "DatewiseWeightReport.cs >> Method btnexcel_Click()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }

        void GenerateExcel(DataTable grd_Report, string filename)
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
                            foreach (DataColumn cell in grd_Report.Columns)
                            {
                                headerRow.Cells.Add(new TableCell { Text = cell.Caption });
                            }
                            table.Rows.Add(headerRow);

                            //foreach (TableCell cell in grd_Report.HeaderRow.Cells)
                            //{
                            //    table.Rows[0].Cells.Add(new TableCell { Text = cell.Text });
                            //}

                            // Add table data
                            foreach (DataRow row in grd_Report.Rows)
                            {
                                TableRow tableRow = new TableRow();
                                foreach (Object cell in row.ItemArray)
                                {
                                    tableRow.Cells.Add(new TableCell { Text = cell.ToString() });
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
                Logfile.TraceService("LogData", "DatewiseWeightReport.cs >> Method GenerateExcel()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
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

                HHComercialBAL bAL = new HHComercialBAL();
                DataSet ds = bAL.GetBCAttendance(Convert.ToInt16(ddlZone.SelectedValue == "" ? "0" : ddlZone.SelectedValue), Convert.ToInt16(ddlWard.SelectedValue == "" ? "0" : ddlWard.SelectedValue), Convert.ToInt16(ddlKothi.SelectedValue == "" ? "0" : ddlKothi.SelectedValue), Convert.ToInt16(ddlPrabhag.SelectedValue == string.Empty ? "0" : ddlPrabhag.SelectedValue), Convert.ToDateTime(txtFromDate.Text), Convert.ToDateTime(txtToDate.Text));
                if (ds.Tables.Count > 0)
                {
                    //if (ds.Tables[0].Rows.Count > 0)
                    //  GenerateExcel(ds.Tables[0], "Attendance_" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
                }

                // Create a table with the same number of columns as the GridView
                PdfPTable table = new PdfPTable(ds.Tables[0].Columns.Count);


                // Set table width to 100% of page width
                table.WidthPercentage = 100;

                // Add table headers
                foreach (DataColumn cell in ds.Tables[0].Columns)
                {
                    table.AddCell(cell.Caption);
                }

                // Add table data
                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    foreach (object cell in row.ItemArray)
                    {
                        // Check if the cell contains controls or nested elements
                        {
                            // If the cell doesn't contain controls, use the cell's text directly
                            table.AddCell(cell.ToString());
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

        protected void ww_Click(object sender, EventArgs e)
        {
            btnexcel_Click(null, null);
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