using iTextSharp.text;
using iTextSharp.text.pdf;
using Newtonsoft.Json;
using OfficeOpenXml;
using SWM.BAL;
using SWM.MODEL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SWM
{
    public partial class SweeperAttendance : System.Web.UI.Page
    {
        List<MAP> mapModels = new List<MAP>();
        protected void Page_Load(object sender, EventArgs e)
        {
            //string loginId = Convert.ToInt32(Session["FK_Id"]);
            if (!IsPostBack)
            {
                BindLoad();
            }
        }
        void BindLoad()
        {
            //exec proc_SweepersAttendance @accid = 11401,@mode = 1,@zoneid = 0,@wardid = 0,@gisTypeId = 78,@kothiid = 0,@startdate = '2023-08-03 05:00:01',@endDate = '2023-08-03 14:00:01',@Month = default,@vehicleId = 0
            BindDDLZone();
            //exec proc_SweepersAttendance @accid = 11401,@mode = 2,@zoneid = 0,@wardid = 0,@gisTypeId = 78,@kothiid = 0,@startdate = '2023-08-03 05:00:01',@endDate = '2023-08-03 14:00:01',@Month = default,@vehicleId = 0
            BindDDLWard();
            //exec proc_SweepersAttendance @accid = 11401,@mode = 3,@zoneid = 0,@wardid = 0,@gisTypeId = 78,@kothiid = 0,@startdate = '2023-08-03 05:00:01',@endDate = '2023-08-03 14:00:01',@Month = default,@vehicleId = 0
            BindDDLKothi();

            BindGrid();
        }
        void BindDDLZone()
        {
            try
            {
                BalFeederSummaryReport bAL = new BalFeederSummaryReport();

                //==sp ref==//
                //exec proc_SweepersAttendance 
                //@accid = 11401,@mode = 1,@zoneid = 0,@wardid = 0,@gisTypeId = 78,@kothiid = 0,@startdate = '2023-08-03 17:30:29.207',@endDate = '2023-08-03 17:30:29.207',@Month = default,@vehicleId = 0
                //==sp ref==//
                DataSet ds = bAL.GetSweepersAttendance(Convert.ToInt32(Session["FK_Id"]), 1, 0, 0, 0, 0, txtSdate.Text, txtEdate.Text, "", 0, Convert.ToString(0));

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
                Logfile.TraceService("LogData", "SweeperAttendance.cs >> Method SweeperAttendance_BindDDLZone()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }
        void BindDDLWard()
        {
            try
            {
                BalFeederSummaryReport bAL = new BalFeederSummaryReport();
                //==sp ref==//
                //exec proc_SweepersAttendance 
                //@accid = 11401,@mode = 2,@zoneid = 0,@wardid = 0,@gisTypeId = 78,@kothiid = 0,@startdate = '2023-08-03 17:30:29.207',@endDate = '2023-08-03 17:30:29.207',@Month = default,@vehicleId = 0
                //==sp ref==//
                DataSet dsGetWard = bAL.GetSweepersAttendance(Convert.ToInt32(Session["FK_Id"]), 2, Convert.ToInt32(ddlZone.SelectedItem.Value), 0, 0, 0, txtSdate.Text, txtEdate.Text, "", 0, Convert.ToString(0));

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
                Logfile.TraceService("LogData", "SweeperAttendance.cs >> Method SweeperAttendance_BindDDLWard()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }

        void BindDDLKothi()
        {
            try
            {
                //BalFeederSummaryReport bAL = new BalFeederSummaryReport();

                BalFeederSummaryReport bAL = new BalFeederSummaryReport();
                FeederSummaryReport mAP = new FeederSummaryReport();
                //==sp ref==//
                //exec proc_SweepersAttendance 
                //@accid = 11401,@mode = 3,@zoneid = 0,@wardid = 0,@gisTypeId = 78,@kothiid = 0,@startdate = '2023-08-03 17:30:29.207',@endDate = '2023-08-03 17:30:29.207',@Month = default,@vehicleId = 0
                //==sp ref==//
                DataSet dsKothi = bAL.GetSweepersAttendance(Convert.ToInt32(Session["FK_Id"]), 3, Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value), 0, 0, txtSdate.Text, txtEdate.Text, "", 0, Convert.ToString(0));

                if (dsKothi.Tables.Count > 0)
                {
                    DataRow allOption = dsKothi.Tables[0].NewRow();
                    allOption["pk_kothiid"] = 0;
                    allOption["KothiName"] = "Select All";
                    dsKothi.Tables[0].Rows.InsertAt(allOption, 0);
                    if (dsKothi.Tables[0].Rows.Count > 0)
                    {
                        // Set the dropdown list's data source and bind the data
                        ddlKothi.DataSource = dsKothi.Tables[0];
                        ddlKothi.DataTextField = "KothiName"; // Field to display as option text  	
                        ddlKothi.DataValueField = "pk_kothiid"; // Field to use as option value 
                        ddlKothi.DataBind();
                    }
                }

                //DataSet dsGetKothi = bAL.GetKothi(356, 11401, 0, 0, Convert.ToInt32(Session["FK_Id"]), Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value), txtSdate.Text, txtEdate.Text, 0, 0, 0, 0);
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

            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "SweeperAttendance.cs >> Method SweeperAttendance_BindDDLVehicle()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
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
            BindGrid();
            //LoadCurrentLocation();
            //Bindchart();
            //tableWrapper1.Visible = true;
            //tableWrapper2.Visible = true;
            //tableWrapper3.Visible = true;
            //chartWrapper.Visible = true;

            if (rbtAttendance.SelectedItem.Text == "Mokadam")
            {
                chartWrapper.Visible = false;
                tableWrapper1.Visible = false;
                tableWrapper2.Visible = false;
            }
        }
        public void LoadCurrentLocation()
        {
            mapBAL bAL = new mapBAL();
            MAP mAP = new MAP();

            DataSet ds = bAL.GetSweeperAttendance();
            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[2].Rows.Count > 0)
                {
                    //grd_wardwiseattendance.DataSource = ds.Tables[2];
                    //grd_wardwiseattendance.DataBind();
                }
                if (ds.Tables[3].Rows.Count > 0)
                {
                    //grd_kothiWise.DataSource = ds.Tables[3];
                    //grd_kothiWise.DataBind();
                }
                //if (ds.Tables[3].Rows.Count > 0)
                //{
                //    grd_kothiWise.DataSource = ds.Tables[3];
                //    grd_kothiWise.DataBind();
                //}
            }

        }
        private void Bindchart()
        {
            //connection();
            //com = new SqlCommand("GetSaleData", con);
            //com.CommandType = CommandType.StoredProcedure;
            //SqlDataAdapter da = new SqlDataAdapter(com);
            //DataSet ds = new DataSet();
            //da.Fill(ds);

            //DataTable ChartData = ds.Tables[0];

            ////storing total rows count to loop on each Record  
            //string[] XPointMember = new string[ChartData.Rows.Count];
            //int[] YPointMember = new int[ChartData.Rows.Count];

            //for (int count = 0; count < ChartData.Rows.Count; count++)
            //{
            //    //storing Values for X axis  
            //    XPointMember[count] = ChartData.Rows[count]["Quarter"].ToString();
            //    //storing values for Y Axis  
            //    YPointMember[count] = Convert.ToInt32(ChartData.Rows[count]["SalesValue"]);

            //}
            ////binding chart control  
            //Chart1.Series[0].Points.DataBindXY(XPointMember, YPointMember);

            ////Setting width of line  
            //Chart1.Series[0].BorderWidth = 10;
            ////setting Chart type   
            //Chart1.Series[0].ChartType = SeriesChartType.Pie;


            //foreach (Series charts in Chart1.Series)
            //{
            //    foreach (DataPoint point in charts.Points)
            //    {
            //        switch (point.AxisLabel)
            //        {
            //            case "Q1": point.Color = Color.RoyalBlue; break;
            //            case "Q2": point.Color = Color.SaddleBrown; break;
            //            case "Q3": point.Color = Color.SpringGreen; break;
            //        }
            //        point.Label = string.Format("{0:0} - {1}", point.YValues[0], point.AxisLabel);

            //    }
            //}
            ////Enabled 3D  
            ////  Chart1.ChartAreas["ChartArea1"].Area3DStyle.Enable3D = true;  
            //con.Close();

        }
        void BindGrid()

        {
            //try
            //{
            if (!IsPostBack) return;
            // Example dates(replace these with your actual dates)
            DateTime fromdate = DateTime.Parse(txtSdate.Text);
            DateTime todate = DateTime.Parse(txtEdate.Text);

            // Calculate the difference between the two dates
            TimeSpan difference = todate - fromdate;

            BalFeederSummaryReport bAL = new BalFeederSummaryReport();
            FeederSummaryReport mAP = new FeederSummaryReport();
            //===for Sweeper
            //exec proc_SweepersAttendance @accid = 11401,@mode = 10,@zoneid = 0,@wardid = 0,@gisTypeId = 78,@kothiid = 0,@startdate = '2023-08-03 05:00:01',@endDate = '2023-08-03 14:00:01',@Month = default,@vehicleId = 0
            //===for Mokadam
            //exec proc_SweepersAttendance @accid = 11401,@mode = 16,@zoneid = 0,@wardid = 0,@gisTypeId = 78,@kothiid = 0,@startdate = '2023-08-04 05:00:01',@endDate = '2023-08-04 14:00:01',@Month = default,@vehicleId = 0
            int intmode = 10;
            if (rbtAttendance.SelectedItem.Text == "Mokadam")
            {
                intmode = 16;
            }
            else
            {
                intmode = 10;
            }

            DataSet ds = bAL.GetSweepersAttendance(Convert.ToInt32(Session["FK_Id"]), intmode, Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value), 0, Convert.ToInt32(ddlKothi.SelectedItem.Value), txtSdate.Text, txtEdate.Text, "", 0, Convert.ToString(0));

            if (ds.Tables.Count > 0)
            {
                if (difference.TotalDays > 5)
                {
                    string script = "alert('Data exported successfully!');";
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);

                    if(ddlReportType.SelectedValue == "0")
                    {
                        GenerateExcelDirectly(ds.Tables[0], "SweeperAttendanceReport " + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
                    } else if (ddlReportType.SelectedValue == "1")
                    {
                        GenerateExcelDirectly(ds.Tables[3], "SweeperAttendanceReport - ward wise " + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
                    } else
                    {
                        GenerateExcelDirectly(ds.Tables[4], "SweeperAttendanceReport - kothi wise " + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
                    }
                    return;
                }
                hheader.Visible = true;
                lblFromDate.Text = txtSdate.Text;
                lblEndDate.Text = txtEdate.Text;

                if (ddlReportType.SelectedValue == "0")                       //overall table
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        divExport.Visible = true;
                        ViewState["Table"] = ds.Tables[0];
                        grd_AttendanceReport.DataSource = ds.Tables[0];
                        grd_AttendanceReport.DataBind();

                        tableWrapper1.Visible = false;
                        tableWrapper2.Visible = false;
                        tableWrapper3.Visible = true;

                    }
                    else
                    {
                        ViewState["Table"] = null;
                        //divExport.Visible = false;
                        grd_AttendanceReport.DataSource = null;
                        grd_AttendanceReport.DataBind();
                        //Response.Write("No data found!!");
                    }
                }
                else if (ddlReportType.SelectedValue == "1")                  //wardwise table
                {
                    if (ds.Tables[3].Rows.Count > 0)
                    {
                        divExport.Visible = true;
                        grd_WardWise.DataSource = ds.Tables[3];
                        grd_WardWise.DataBind();

                        tableWrapper1.Visible = true;
                        tableWrapper2.Visible = false;
                        tableWrapper3.Visible = false;
                    }
                    else
                    {
                        //divExport.Visible = false;
                        grd_WardWise.DataSource = null;
                        grd_WardWise.DataBind();
                        //Response.Write("No data found!!");
                    }
                }
                else if (ddlReportType.SelectedValue == "2")                                                        //kothiwise table
                {
                    if (ds.Tables[4].Rows.Count > 0)
                    {
                        divExport.Visible = true;
                        grd_KothiWise.DataSource = ds.Tables[4];
                        grd_KothiWise.DataBind();

                        tableWrapper1.Visible = false;
                        tableWrapper2.Visible = true;
                        tableWrapper3.Visible = false;
                    }
                    else
                    {
                        //divExport.Visible = false;
                        grd_KothiWise.DataSource = null;
                        grd_KothiWise.DataBind();
                        //Response.Write("No data found!!");
                    }
                }

                if (rbtAttendance.SelectedItem.Text == "Mokadam")
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        divExport.Visible = true;
                        grd_WardWise.DataSource = ds.Tables[0];
                        grd_WardWise.DataBind();

                        totalBtn.Text = "Total :- " + ds.Tables[1].Rows[0]["Total"].ToString();
                        absentBtn.Text = "Absent :- " + ds.Tables[1].Rows[0]["Absent"].ToString();
                        presentBtn.Text = "Present :- " + ds.Tables[1].Rows[0]["Present"].ToString();
                        routeDeviatedBtn.Visible = false;
                        leaveHolidayBtn.Text = "Leave Holiday :- " + ds.Tables[1].Rows[0]["Leave/Holiday"].ToString();

                        return;
                    }
                    else
                    {
                        //divExport.Visible = false;
                        grd_WardWise.DataSource = null;
                        grd_WardWise.DataBind();
                        //Response.Write("No data found!!");
                    }
                }
                //total
                if (ds.Tables[1].Rows.Count > 0)
                {
                    string dataTableJsonCityWise = JsonConvert.SerializeObject(ds.Tables[1]);
                    hiddenFielddataTableJsonTotal.Value = dataTableJsonCityWise;
                    //lblTotal.Text = "Total :- " + ds.Tables[1].Rows[0]["Total"].ToString();
                    //lblAbsent.Text = "Absent :- " + ds.Tables[1].Rows[0]["Absent"].ToString();
                    //lblPresent.Text = "Present :- " + ds.Tables[1].Rows[0]["Present"].ToString();
                    //if (rbtAttendance.SelectedItem.Text == "Sweeper")
                    //{
                    //    lblRouteDeviated.Text = "Ping :- " + ds.Tables[1].Rows[0]["PING"].ToString();
                    //    lblLeave_Holiday.Text = "Leave Holiday :- " + ds.Tables[1].Rows[0]["Leave/Holiday"].ToString();
                    //    //lblRouteDeviated.Text = "Route Deviated :- " + 0;
                    //    //lblLeave_Holiday.Text = "Leave Holiday :- " + 0;
                    //}

                    totalBtn.Text = "Total :- " + ds.Tables[1].Rows[0]["Total"].ToString();
                    absentBtn.Text = "Absent :- " + ds.Tables[1].Rows[0]["Absent"].ToString();
                    presentBtn.Text = "Present :- " + ds.Tables[1].Rows[0]["Present"].ToString();
                    if (rbtAttendance.SelectedItem.Text == "Sweeper")
                    {
                        routeDeviatedBtn.Text = "Ping :- " + ds.Tables[1].Rows[0]["PING"].ToString();
                        leaveHolidayBtn.Text = "Leave Holiday :- " + ds.Tables[1].Rows[0]["Leave/Holiday"].ToString();
                        //lblRouteDeviated.Text = "Route Deviated :- " + 0;
                        //lblLeave_Holiday.Text = "Leave Holiday :- " + 0;
                    }

                }
                else
                {
                    //lblTotal.Text = "Total :- " + 0;
                    //lblAbsent.Text = "Absent :- " + 0;
                    //lblPresent.Text = "Present :- " + 0;
                    //if (rbtAttendance.SelectedItem.Text == "Sweeper")
                    //{
                    //    lblRouteDeviated.Text = "Route Deviated :- " + 0;
                    //    lblLeave_Holiday.Text = "Leave Holiday :- " + 0;
                    //}

                    totalBtn.Text = "Total :- " + ds.Tables[1].Rows[0]["Total"].ToString();
                    absentBtn.Text = "Absent :- " + ds.Tables[1].Rows[0]["Absent"].ToString();
                    presentBtn.Text = "Present :- " + ds.Tables[1].Rows[0]["Present"].ToString();
                    if (rbtAttendance.SelectedItem.Text == "Mokadam")
                    {
                        routeDeviatedBtn.Text = "Route Deviated :- " + 0;
                        leaveHolidayBtn.Text = "Leave Holiday :- " + ds.Tables[1].Rows[0]["Leave/Holiday"].ToString();
                    }

                    string dataTableJsonCityWise = JsonConvert.SerializeObject("");
                    hiddenFielddataTableJsonTotal.Value = dataTableJsonCityWise;
                }
                //zonewise
                if (ds.Tables[2].Rows.Count > 0)
                {
                    string dataTableJsonCityWise = JsonConvert.SerializeObject(ds.Tables[2]);
                    hiddenFielddataTableJsonZoneWise.Value = dataTableJsonCityWise;
                }
                else
                {
                    string dataTableJsonCityWise = JsonConvert.SerializeObject("");
                    hiddenFielddataTableJsonZoneWise.Value = dataTableJsonCityWise;
                }
            }
            //}
            //catch (Exception ex)
            //{
            //    Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
            //    Logfile.TraceService("LogData", "SweeperAttendance.cs >> Method SweeperAttendance_BindGrid()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
            //    Logfile.TraceService("LogData", "Message >> " + ex.Message);
            //    Logfile.TraceService("LogData", "Source >> " + ex.Source);
            //    Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
            //    Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
            //    Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
            //    Logfile.TraceService("LogData", ex.Message);
            //}

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
        protected void ImgExl_Click(object sender, ImageClickEventArgs e)
        {
            //GenerateExcel(grd_AttendanceReport, "AttendanceReport_" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
            DataTable dataTable = ViewState["Table"] as DataTable;
            GenerateExcelDirectly(dataTable, "AttendanceReport_" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));

        }

        protected void ImgPDF_Click(object sender, ImageClickEventArgs e)
        {
            GeneratePDF(grd_AttendanceReport, "AttendanceReport_" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
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
                dt = GetDataFromGridView(gridView);
                // Write DataTable content to Excel worksheet
                worksheet.Cells["A1"].LoadFromDataTable(dt, true);

                Response.Clear();
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AddHeader("content-disposition", "attachment;filename=" + fileName + ".xlsx");
                Response.BinaryWrite(package.GetAsByteArray());
                Response.End();
            }
        }
        protected DataTable GetDataFromGridView(GridView gridView)
        {
            DataTable dt = new DataTable();

            foreach (TableCell cell in gridView.HeaderRow.Cells)
            {
                dt.Columns.Add(cell.Text);
            }

            foreach (GridViewRow row in gridView.Rows)
            {
                DataRow dataRow = dt.NewRow();
                for (int i = 0; i < row.Cells.Count; i++)
                {
                    dataRow[i] = row.Cells[i].Text;
                }
                dt.Rows.Add(dataRow);
            }

            return dt;
        }

        protected void GeneratePDF(GridView gridView, string fileName)
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

            PdfPTable pdfTable = new PdfPTable(gridView.HeaderRow.Cells.Count);
            pdfTable.WidthPercentage = 100;

            // Add header cells to the PDF table
            foreach (TableCell headerCell in gridView.HeaderRow.Cells)
            {
                PdfPCell pdfCell = new PdfPCell(new Phrase(headerCell.Text));
                pdfTable.AddCell(pdfCell);
            }

            // Add data cells to the PDF table
            foreach (GridViewRow gridViewRow in gridView.Rows)
            {
                foreach (TableCell tableCell in gridViewRow.Cells)
                {
                    PdfPCell pdfCell = new PdfPCell(new Phrase(tableCell.Text));
                    pdfTable.AddCell(pdfCell);
                }
            }

            pdfDoc.Add(pdfTable);
            pdfDoc.Close();

            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=" + fileName + ".pdf");
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Write(pdfDoc);
            Response.End();
        }

        protected void ddlZone_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindDDLWard();
            BindDDLKothi();
        }

        protected void ddlWard_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindDDLKothi();
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

                //ddlWeek.SelectedValue = "0";
            }
            else
            {
                DateTime today = DateTime.Today;

                ViewState["firstDayOfMonth"] = DateTime.Today.ToString("yyyy-MM-dd");
                txtSdate.Text = DateTime.Today.ToString("yyyy-MM-dd");

                ViewState["lastDayOfMonth"] = DateTime.Today.ToString("yyyy-MM-dd");
                txtEdate.Text = DateTime.Today.ToString("yyyy-MM-dd");

                //ddlWeek.SelectedValue = "0";
            }
            //lastDayOfMonth1 = ddlYear.SelectedItem.Text + "-" + ddlMonth.SelectedValue + "-" + DateTime.DaysInMonth(Convert.ToInt32(ddlYear.SelectedItem.Text), Convert.ToInt32(ddlMonth.SelectedValue));
        }
    }
}