using Newtonsoft.Json;
using OfficeOpenXml;
using SWM.BAL;
using SWM.MODEL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SWM
{
    public partial class Collectionworkerroutecoveregereport : System.Web.UI.Page
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

        private void BindGrid()
        {
            try
            {
                if (!IsPostBack) return;

                // Example dates (replace these with your actual dates)
                DateTime fromdate = DateTime.Parse(txtFromDate.Text);
                DateTime todate = DateTime.Parse(txtToDate.Text);

                // Calculate the difference between the two dates
                TimeSpan difference = todate - fromdate;

                HHComercialBAL bAL = new HHComercialBAL();
                //=====ZONE=====//
                //"begin tran t
                //exec proc_SweeperRouteCoverageReportNew @mode = 11,@vehicleId = 0,@AccId = 11401,@ZoneId = 0,@WardId = 0,@startdate = default,@enddate = default,@stime = default,@etime = default,@RptName = default,@Report = default,@Zone = default,@Ward = default,@WorkingType = default,@RouteId = 0,@AdminID = 0,@RoleID = 0
                //rollback tran t"
                //==sp ref==//
                //txtFromDate.Text = DateTime.Now.Date.ToString();
                //txtToDate.Text = DateTime.Now.Date.ToString();
                DataSet ds = bAL.GetCWReport(Convert.ToInt16(ddlZone.SelectedValue == string.Empty ? "0" : ddlZone.SelectedValue), Convert.ToInt16(ddlWard.SelectedValue == string.Empty ? "0" : ddlWard.SelectedValue), Convert.ToInt16(ddlKothi.SelectedValue == string.Empty ? "0" : ddlKothi.SelectedValue), Convert.ToDateTime(txtFromDate.Text), Convert.ToDateTime(txtToDate.Text), Convert.ToInt16(ddlPrabhag.SelectedValue == string.Empty ? "0" : ddlPrabhag.SelectedValue));
                if (ds.Tables.Count > 0)
                {
                    if (difference.TotalDays > 20)
                    {
                        string script = "alert('Data exported successfully!');";
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
                        GenerateExcelDirectly(ds.Tables[0], "CollectionWorkerRouteCoverage" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));

                    }
                    else
                    {
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            lblFromDate.Text = txtFromDate.Text;
                            lblEndDate.Text = txtToDate.Text;
                            gvwardwise.DataSource = ds.Tables[0];
                            gvwardwise.DataBind();
                        }
                    }
                }
                ViewState["Data"] = ds;
            }
            catch (Exception)
            {


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
            if (e.CommandName == "ViewPocket")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                DataTable dt = (DataTable)gvwardwise.DataSource;

                // Access the selected row using the rowIndex
                DataRow selectedRow = ((DataSet)ViewState["Data"]).Tables[0].Rows[rowIndex];

                #region fetch Polygon
                HHComercialBAL bAL = new HHComercialBAL();
                DataSet dsPolygon = bAL.getpolygon(Convert.ToInt16(selectedRow["pk_vehicleid"]), Convert.ToInt16(selectedRow["routeid"]));

                DataSet dsLocation = bAL.getfeederlocation(Convert.ToInt16(selectedRow["pk_vehicleid"]), Convert.ToDateTime(selectedRow["Date"]));

                if (dsLocation.Tables.Count == 0)
                {
                    string script = "alert('No data found.');";
                    ClientScript.RegisterStartupScript(this.GetType(), "NoDataFound", script, true);
                    //Showmap(dsPolygon, dsLocation, Convert.ToInt16(selectedRow["pk_vehicleid"]), Convert.ToInt16(selectedRow["routeid"]));
                    return;
                }
                Showmap(dsPolygon, dsLocation, Convert.ToInt16(selectedRow["pk_vehicleid"]), Convert.ToDateTime(selectedRow["Date"]), Convert.ToInt16(selectedRow["pk_vehicleid"]));
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

        public void Showmap(DataSet dsPolygon, DataSet dskothiradius, short vehicleid, DateTime v1, short v)
        {
            try
            {

                // Call the JavaScript function in each iteration
                ClientScriptManager cs = Page.ClientScript;

                string redirectUrl = "VehicleMapViewHistory2.aspx?dat=" + v1 +
                                     "&lon=" + 0 +
                                     "&vehicleid=" + vehicleid +
                                     "&routeid=" + v;

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
            //cityWiseChartData.Value = jsonData;
        }

        protected void SetZoneWiseChartData()
        {
            // Simulate data retrieval from your data source
            List<string> labels = new List<string> { "Status" };
            List<int> presentValues = new List<int> { 19 };
            List<int> absentValues = new List<int> { 240 };

            // Serialize the data as JSON string
            // zoneWiseChartData.Value = JsonConvert.SerializeObject(new { labels, presentValues, absentValues });
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