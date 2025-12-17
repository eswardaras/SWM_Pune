using DocumentFormat.OpenXml.Wordprocessing;
using Newtonsoft.Json;
using SWM.BAL;
using SWM.MODEL;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Table = System.Web.UI.WebControls.Table;
using TableCell = System.Web.UI.WebControls.TableCell;
using TableRow = System.Web.UI.WebControls.TableRow;
using iTextSharp.text;
using iTextSharp.text.pdf;
using OfficeOpenXml;
using System.Configuration;

namespace SWM
{
    public partial class DailyCheckingReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DateTime pageLoadStart = DateTime.Now;
            Logfile.TraceService("LogData", "=== DailyCheckingReport Page_Load START ===");
            Logfile.TraceService("LogData", "IsPostBack: " + IsPostBack.ToString());
            Logfile.TraceService("LogData", "Timestamp: " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss.fff"));
            
            if (!IsPostBack)
            {
                // VERIFIED: BindGrid() is NOT called on Page_Load - only on form submit
                Logfile.TraceService("LogData", "Page_Load: BindGrid() NOT called (initial page load)");
                
                // OPTIMIZED: Set default dates to today to avoid parsing errors
                if (string.IsNullOrEmpty(txtFromDate.Text))
                {
                    txtFromDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                }
                if (string.IsNullOrEmpty(txtToDate.Text))
                {
                    txtToDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                }
                
                DateTime dropdownStart = DateTime.Now;
                BindAllDropDown();
                TimeSpan dropdownTime = DateTime.Now - dropdownStart;
                Logfile.TraceService("LogData", "BindAllDropDown() completed in: " + dropdownTime.TotalMilliseconds + " ms");
                //BindDDLVehicle();
            }
            else
            {
                Logfile.TraceService("LogData", "Page_Load: PostBack detected");
            }
            
            TimeSpan pageLoadTime = DateTime.Now - pageLoadStart;
            Logfile.TraceService("LogData", "=== DailyCheckingReport Page_Load END - Total time: " + pageLoadTime.TotalMilliseconds + " ms ===");
        }

        private void BindGrid()
        {
            DateTime bindGridStart = DateTime.Now;
            TimeSpan totalTime; // Declare once at method level to avoid scope conflicts
            Logfile.TraceService("LogData", "=== BindGrid() START ===");
            Logfile.TraceService("LogData", "Timestamp: " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss.fff"));
            Logfile.TraceService("LogData", "IsPostBack: " + IsPostBack.ToString());
            
            try
            {
                if (!IsPostBack)
                {
                    Logfile.TraceService("LogData", "BindGrid() EXIT: Not a PostBack - returning early");
                    return;
                }

                int zoneId = Convert.ToInt16(ddlZone.SelectedValue);
                int wardId = Convert.ToInt16(ddlWard.SelectedValue == string.Empty ? "0" : ddlWard.SelectedValue);
                int kothiId = Convert.ToInt16(ddlKothi.SelectedValue == string.Empty ? "0" : ddlKothi.SelectedValue);
                bool noFiltersSelected = (zoneId == 0 && wardId == 0 && kothiId == 0);
                
                Logfile.TraceService("LogData", "BindGrid() Parameters:");
                Logfile.TraceService("LogData", "  Zone: " + zoneId + (zoneId == 0 ? " (ALL - NO FILTER)" : ""));
                Logfile.TraceService("LogData", "  Ward: " + wardId + (wardId == 0 ? " (ALL - NO FILTER)" : ""));
                Logfile.TraceService("LogData", "  Kothi: " + kothiId + (kothiId == 0 ? " (ALL - NO FILTER)" : ""));
                Logfile.TraceService("LogData", "  Options: " + ddlOptions.SelectedValue);
                Logfile.TraceService("LogData", "  FromDate: " + txtFromDate.Text);
                Logfile.TraceService("LogData", "  ToDate: " + txtToDate.Text);
                Logfile.TraceService("LogData", "  *** PERFORMANCE WARNING: No filters selected = Fetching ALL data ***");

                DateTime parseStart = DateTime.Now;
                BALCTPT bAL = new BALCTPT();

                DateTime fromdate = DateTime.Parse(txtFromDate.Text);
                DateTime todate = DateTime.Parse(txtToDate.Text);
                TimeSpan parseTime = DateTime.Now - parseStart;
                Logfile.TraceService("LogData", "Date parsing completed in: " + parseTime.TotalMilliseconds + " ms");

                // Calculate the difference between the two dates
                TimeSpan difference = todate - fromdate;
                Logfile.TraceService("LogData", "Date range: " + difference.TotalDays + " days");

                DateTime dbCallStart = DateTime.Now;
                List<DataSet> ds = bAL.GetCTPTDailyCheckinReport(Convert.ToInt16(ddlZone.SelectedValue), Convert.ToInt16(ddlWard.SelectedValue == string.Empty ? "0" : ddlWard.SelectedValue), Convert.ToInt16(ddlKothi.SelectedValue == string.Empty ? "0" : ddlKothi.SelectedValue), Convert.ToInt16(ddlOptions.SelectedValue), Convert.ToDateTime(txtFromDate.Text), Convert.ToDateTime(txtToDate.Text));
                TimeSpan dbCallTime = DateTime.Now - dbCallStart;
                Logfile.TraceService("LogData", "*** DATABASE CALL (GetCTPTDailyCheckinReport) completed in: " + dbCallTime.TotalSeconds + " seconds (" + dbCallTime.TotalMilliseconds + " ms) ***");

                if (difference.TotalDays > 30)
                {
                    Logfile.TraceService("LogData", "Date range > 30 days - generating Excel export");
                    string script = "alert('Data exported successfully!');";
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);

                    DateTime excelStart = DateTime.Now;
                    // Generate both Excel files
                    GenerateExcelDirectly(ds[0].Tables[0], "Daily Checking Report " + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
                    TimeSpan excelTime = DateTime.Now - excelStart;
                    Logfile.TraceService("LogData", "Excel generation completed in: " + excelTime.TotalMilliseconds + " ms");
                    //GenerateExcelDirectly(ds[1].Tables[0], "Daily Checking Report - Kothi wise" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));

                    // End the function execution here
                    totalTime = DateTime.Now - bindGridStart;
                    Logfile.TraceService("LogData", "=== BindGrid() END - Total time: " + totalTime.TotalSeconds + " seconds (" + totalTime.TotalMilliseconds + " ms) ===");
                    return;
                }

                DateTime gridBindStart = DateTime.Now;
                // Bind data to GridView controls
                if (ds[0].Tables.Count > 0 && ds[0].Tables[0].Rows.Count > 0)
                {
                    Logfile.TraceService("LogData", "Binding GridView - Rows: " + ds[0].Tables[0].Rows.Count);
                    DateTime gv1Start = DateTime.Now;
                    gvdailychein.DataSource = ds[0].Tables[0];
                    gvdailychein.DataBind();
                    TimeSpan gv1Time = DateTime.Now - gv1Start;
                    Logfile.TraceService("LogData", "gvdailychein.DataBind() completed in: " + gv1Time.TotalMilliseconds + " ms");

                    DateTime summaryStart = DateTime.Now;
                    SummaryTable.DataSource = ds[0].Tables[1];
                    SummaryTable.DataBind();
                    TimeSpan summaryTime = DateTime.Now - summaryStart;
                    Logfile.TraceService("LogData", "SummaryTable.DataBind() completed in: " + summaryTime.TotalMilliseconds + " ms");
                }

                if (ds[1].Tables.Count > 0 && ds[1].Tables[0].Rows.Count > 0)
                {
                    Logfile.TraceService("LogData", "Binding Kothi/Ward tables - Rows: " + ds[1].Tables[0].Rows.Count);
                    DateTime kothiStart = DateTime.Now;
                    gvkothiwise.DataSource = ds[1].Tables[0];
                    gvkothiwise.DataBind();
                    TimeSpan kothiTime = DateTime.Now - kothiStart;
                    Logfile.TraceService("LogData", "gvkothiwise.DataBind() completed in: " + kothiTime.TotalMilliseconds + " ms");

                    DateTime wardStart = DateTime.Now;
                    WardWiseTable.DataSource = ds[1].Tables[1];
                    WardWiseTable.DataBind();
                    TimeSpan wardTime = DateTime.Now - wardStart;
                    Logfile.TraceService("LogData", "WardWiseTable.DataBind() completed in: " + wardTime.TotalMilliseconds + " ms");
                }
                TimeSpan gridBindTime = DateTime.Now - gridBindStart;
                Logfile.TraceService("LogData", "All GridView binding completed in: " + gridBindTime.TotalMilliseconds + " ms");

                // OPTIMIZED: Calculate counts more efficiently using DataTable.Select instead of LINQ
                DateTime countStart = DateTime.Now;
                if (ds[0].Tables.Count > 0 && ds[0].Tables[0].Rows.Count > 0)
                {
                    DataTable dt = ds[0].Tables[0];
                    int totalCount = dt.Rows.Count;
                    
                    // OPTIMIZED: Use DataTable.Select instead of LINQ for better performance
                    int visitedCount = dt.Select("Status = 'Visited'").Length;
                    int invalidCount = dt.Select("Status = 'Invalid'").Length;
                    int unvisitedCount = dt.Select("Status = 'Unvisited'").Length;

                    btnAll.Text = "All " + totalCount;
                    btnVisited.Text = "Visited " + visitedCount;
                    btnInvalid.Text = "Invalid " + invalidCount;
                    btnUnvisited.Text = "Unvisited " + unvisitedCount;
                }
                TimeSpan countTime = DateTime.Now - countStart;
                Logfile.TraceService("LogData", "Button count calculations completed in: " + countTime.TotalMilliseconds + " ms");

                totalTime = DateTime.Now - bindGridStart;
                Logfile.TraceService("LogData", "=== BindGrid() END - Total time: " + totalTime.TotalSeconds + " seconds (" + totalTime.TotalMilliseconds + " ms) ===");
                Logfile.TraceService("LogData", "  - Database call: " + dbCallTime.TotalSeconds + " seconds (" + (dbCallTime.TotalMilliseconds / totalTime.TotalMilliseconds * 100).ToString("F2") + "% of total)");
                Logfile.TraceService("LogData", "  - GridView binding: " + gridBindTime.TotalMilliseconds + " ms (" + (gridBindTime.TotalMilliseconds / totalTime.TotalMilliseconds * 100).ToString("F2") + "% of total)");

            }
            catch (Exception ex)
            {
                totalTime = DateTime.Now - bindGridStart;
                Logfile.TraceService("LogData", "=== BindGrid() ERROR after " + totalTime.TotalMilliseconds + " ms ===");
                Logfile.TraceService("LogData", "Exception: " + ex.Message);
                Logfile.TraceService("LogData", "StackTrace: " + ex.StackTrace);
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


        public void Showmap(DataSet dsPolygon, DataSet dskothiradius, short v, short v1)
        {
            try
            {

                // Call the JavaScript function in each iteration
                ClientScriptManager cs = Page.ClientScript;

                string redirectUrl = "VehicleMapViewHistory1.aspx?lat=" + dskothiradius.Tables[0].Rows[0]["latitude"] +
                                     "&lon=" + dskothiradius.Tables[0].Rows[0]["longitude"] +
                                     "&vehicleid=" + v +
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
            DateTime submitStart = DateTime.Now;
            Logfile.TraceService("LogData", "=== ButtonSubmitt_Click() START ===");
            Logfile.TraceService("LogData", "Timestamp: " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss.fff"));
            
            try
            {
                // Example dates (replace these with your actual dates)
                DateTime fromdate = DateTime.Parse(txtFromDate.Text);
                DateTime todate = DateTime.Parse(txtToDate.Text);

                // Calculate the difference between the two dates
                TimeSpan difference = todate - fromdate;
                
                // PERFORMANCE OPTIMIZATION: Validate filters to prevent fetching ALL data
                int zoneId = Convert.ToInt16(ddlZone.SelectedValue);
                int wardId = Convert.ToInt16(ddlWard.SelectedValue == string.Empty ? "0" : ddlWard.SelectedValue);
                int kothiId = Convert.ToInt16(ddlKothi.SelectedValue == string.Empty ? "0" : ddlKothi.SelectedValue);
                
                bool noFiltersSelected = (zoneId == 0 && wardId == 0 && kothiId == 0);
                
                Logfile.TraceService("LogData", "ButtonSubmitt_Click: Filter Status - Zone:" + zoneId + ", Ward:" + wardId + ", Kothi:" + kothiId);
                Logfile.TraceService("LogData", "ButtonSubmitt_Click: No filters selected: " + noFiltersSelected);
                
                // PERFORMANCE WARNING: When no filters are selected, limit date range to prevent slow queries
                if (noFiltersSelected)
                {
                    // Limit to maximum 7 days when fetching ALL zones/wards/kothis
                    if (difference.TotalDays > 7)
                    {
                        string warningScript = "alert('Warning: Fetching data for ALL zones/wards/kothis is limited to 7 days for performance. Please select a Zone, Ward, or Kothi to fetch longer date ranges.');";
                        ClientScript.RegisterStartupScript(this.GetType(), "FilterWarning", warningScript, true);
                        Logfile.TraceService("LogData", "ButtonSubmitt_Click: WARNING - Date range > 7 days with no filters - limiting to 7 days");
                        
                        // Auto-adjust todate to 7 days from fromdate
                        todate = fromdate.AddDays(7);
                        txtToDate.Text = todate.ToString("yyyy-MM-dd");
                        difference = todate - fromdate;
                        Logfile.TraceService("LogData", "ButtonSubmitt_Click: Auto-adjusted ToDate to: " + txtToDate.Text);
                    }
                    else if (difference.TotalDays > 3)
                    {
                        // Warn user but allow up to 7 days
                        string infoScript = "alert('Fetching data for ALL zones/wards/kothis may take longer. Consider selecting a Zone, Ward, or Kothi for faster results.');";
                        ClientScript.RegisterStartupScript(this.GetType(), "FilterInfo", infoScript, true);
                        Logfile.TraceService("LogData", "ButtonSubmitt_Click: INFO - Date range > 3 days with no filters - user warned");
                    }
                }
                
                RampBAL bAL = new RampBAL();
                DatewiseWeightReport mAP = new DatewiseWeightReport();
                
                Logfile.TraceService("LogData", "ButtonSubmitt_Click: Calling BindGrid()");
                BindGrid();
                
                TimeSpan submitTime = DateTime.Now - submitStart;
                Logfile.TraceService("LogData", "=== ButtonSubmitt_Click() END - Total time: " + submitTime.TotalMilliseconds + " ms ===");
            }
            catch (Exception ex)
            {
                TimeSpan submitTime = DateTime.Now - submitStart;
                Logfile.TraceService("LogData", "=== ButtonSubmitt_Click() ERROR after " + submitTime.TotalMilliseconds + " ms ===");
                Logfile.TraceService("LogData", "Exception: " + ex.Message);
                Logfile.TraceService("LogData", "StackTrace: " + ex.StackTrace);
                throw;
            }
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
            tableWrapper.Visible = true;
        }

        protected void ShowImage_Click(object sender, EventArgs e)
        {
            ImageButton btnImage = (ImageButton)sender;
            string imageUrl = btnImage.ImageUrl;

            // Show the image using the imageUrl (e.g., in a modal popup, new page, etc.)
        }
        void BindDDLZone()
        {
            DateTime zoneStart = DateTime.Now;
            Logfile.TraceService("LogData", "=== BindDDLZone() START ===");
            
            try
            {
                // OPTIMIZED: Check cache first to avoid database call on every page load
                string cacheKey = "ZoneDropdown_11401_DailyChecking";
                DateTime cacheCheckStart = DateTime.Now;
                DataSet ds = HttpContext.Current.Cache[cacheKey] as DataSet;
                TimeSpan cacheCheckTime = DateTime.Now - cacheCheckStart;
                
                if (ds == null)
                {
                    Logfile.TraceService("LogData", "BindDDLZone: Cache MISS - fetching from database");
                    DateTime dbStart = DateTime.Now;
                    BalFeederSummaryReport bAL = new BalFeederSummaryReport();
                    FeederSummaryReport mAP = new FeederSummaryReport();
                    //=====ZONE=====//
                    //"begin tran t
                    //exec proc_SweeperRouteCoverageReportNew @mode = 11,@vehicleId = 0,@AccId = 11401,@ZoneId = 0,@WardId = 0,@startdate = default,@enddate = default,@stime = default,@etime = default,@RptName = default,@Report = default,@Zone = default,@Ward = default,@WorkingType = default,@RouteId = 0,@AdminID = 0,@RoleID = 0
                    //rollback tran t"
                    //==sp ref==//
                    ds = bAL.GetZone(11, 0, 11401);
                    TimeSpan dbTime = DateTime.Now - dbStart;
                    Logfile.TraceService("LogData", "BindDDLZone: Database call (GetZone) completed in: " + dbTime.TotalMilliseconds + " ms");
                    
                    // OPTIMIZED: Cache for 30 minutes (zones don't change frequently)
                    if (ds != null && ds.Tables.Count > 0)
                    {
                        HttpContext.Current.Cache.Insert(cacheKey, ds, null, 
                            DateTime.Now.AddMinutes(30), System.Web.Caching.Cache.NoSlidingExpiration);
                        Logfile.TraceService("LogData", "BindDDLZone: Data cached for 30 minutes");
                    }
                }
                else
                {
                    Logfile.TraceService("LogData", "BindDDLZone: Cache HIT - using cached data (saved " + cacheCheckTime.TotalMilliseconds + " ms)");
                }
                
                DateTime bindStart = DateTime.Now;
                if (ds != null && ds.Tables.Count > 0)
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
                        Logfile.TraceService("LogData", "BindDDLZone: Dropdown bound with " + ds.Tables[0].Rows.Count + " items");
                    }
                }
                TimeSpan bindTime = DateTime.Now - bindStart;
                Logfile.TraceService("LogData", "BindDDLZone: Dropdown binding completed in: " + bindTime.TotalMilliseconds + " ms");
                
                TimeSpan totalTime = DateTime.Now - zoneStart;
                Logfile.TraceService("LogData", "=== BindDDLZone() END - Total time: " + totalTime.TotalMilliseconds + " ms ===");
            }
            catch (Exception ex)
            {
                TimeSpan totalTime = DateTime.Now - zoneStart;
                Logfile.TraceService("LogData", "=== BindDDLZone() ERROR after " + totalTime.TotalMilliseconds + " ms ===");
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


        //protected void SetCityWiseChartData()
        //{
        //    // Simulate data retrieval from your data source
        //    List<string> labels = new List<string> { "Present", "Absent" };
        //    List<int> values = new List<int> { 19, 240 };

        //    // Serialize the data as JSON string
        //    string jsonData = JsonConvert.SerializeObject(new { labels, values });

        //    // Set the JSON data as a hidden field value
        //    cityWiseChartData.Value = jsonData;
        //}

        //protected void SetZoneWiseChartData()
        //{
        //    // Simulate data retrieval from your data source
        //    List<string> labels = new List<string> { "Status" };
        //    List<int> presentValues = new List<int> { 19 };
        //    List<int> absentValues = new List<int> { 240 };

        //    // Serialize the data as JSON string
        //    zoneWiseChartData.Value = JsonConvert.SerializeObject(new { labels, presentValues, absentValues });
        //}

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

        protected void gvdailychein_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvdailychein.PageIndex = e.NewPageIndex;
            // Bind your data here
            BindGrid();
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

        protected void btnpdf_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                if (gvdailychein.Rows.Count > 0)
                    GeneratePDF(gvdailychein, "Attendance_" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
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
                BALCTPT bAL = new BALCTPT();
                List<DataSet> dsList = bAL.GetCTPTDailyCheckinReport(Convert.ToInt16(ddlZone.SelectedValue), Convert.ToInt16(ddlWard.SelectedValue == string.Empty ? "0" : ddlWard.SelectedValue), Convert.ToInt16(ddlKothi.SelectedValue == string.Empty ? "0" : ddlKothi.SelectedValue), Convert.ToInt16(ddlOptions.SelectedValue), Convert.ToDateTime(txtFromDate.Text), Convert.ToDateTime(txtToDate.Text));

                foreach (DataSet ds in dsList)
                {
                    if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                    {
                        GenerateExcel(ds.Tables[0], "Attendance_" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
                    }
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
                iTextSharp.text.Document document = new iTextSharp.text.Document();
                PdfWriter writer = PdfWriter.GetInstance(document, Response.OutputStream);
                document.Open();

                //HHComercialBAL bAL = new HHComercialBAL();
                //DataSet ds = bAL.GetBCAttendance(Convert.ToInt16(ddlZone.SelectedValue == "" ? "0" : ddlZone.SelectedValue), Convert.ToInt16(ddlWard.SelectedValue == "" ? "0" : ddlWard.SelectedValue), Convert.ToInt16(ddlKothi.SelectedValue == "" ? "0" : ddlKothi.SelectedValue), Convert.ToInt16(ddlPrabhag.SelectedValue == string.Empty ? "0" : ddlPrabhag.SelectedValue), Convert.ToDateTime(txtFromDate.Text), Convert.ToDateTime(txtToDate.Text));
                BALCTPT bAL = new BALCTPT();
                List<DataSet> dsList = bAL.GetCTPTDailyCheckinReport(Convert.ToInt16(ddlZone.SelectedValue), Convert.ToInt16(ddlWard.SelectedValue == string.Empty ? "0" : ddlWard.SelectedValue), Convert.ToInt16(ddlKothi.SelectedValue == string.Empty ? "0" : ddlKothi.SelectedValue), Convert.ToInt16(ddlOptions.SelectedValue), Convert.ToDateTime(txtFromDate.Text), Convert.ToDateTime(txtToDate.Text));
                foreach (DataSet ds in dsList)
                {
                    if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                    {
                        // Create a table with the same number of columns as the DataSet
                        PdfPTable table = new PdfPTable(ds.Tables[0].Columns.Count);

                        // Set table width to 100% of page width
                        table.WidthPercentage = 100;

                        // Add table headers
                        foreach (DataColumn column in ds.Tables[0].Columns)
                        {
                            table.AddCell(column.ColumnName);
                        }

                        // Add table data
                        foreach (DataRow row in ds.Tables[0].Rows)
                        {
                            foreach (object cell in row.ItemArray)
                            {
                                table.AddCell(cell.ToString());
                            }
                        }

                        // Add the table to the document
                        document.Add(table);
                    }
                }

                document.Close();
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
        protected string GetModifiedImageUrl(object imageUrlObj)
        {
            if (imageUrlObj?.ToString() == "NA")
            {
                return "Images/placeholderDailyChecking.jpeg";
            }
            // Check if imageUrlObj is not null and convert it to string
            string imageUrl = imageUrlObj?.ToString();

            if (!string.IsNullOrEmpty(imageUrl))
            {
                // Parse the URL
                Uri uri = new Uri(imageUrl);

                // Get the filename from the URL
                string filename = System.IO.Path.GetFileName(uri.LocalPath);

                // Get the base URL from AppSettings
                string PicFineCollection = Convert.ToString(ConfigurationManager.AppSettings["PicFineCollection"]);

                // Combine the base URL with the filename
                string modifiedImageUrl = PicFineCollection + filename;

                return modifiedImageUrl;
            }
            else
            {
                return string.Empty; // or you can return a default image URL if needed
            }
        }
    }
}