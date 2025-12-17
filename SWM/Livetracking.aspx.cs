using SWM.BAL;
using SWM.MODEL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Timers;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace SWM
{
    public partial class Livetracking : System.Web.UI.Page
    {
        //private System.Timers.Timer aTimer;
        //public System.Timers.Timer aTimer;
        private static System.Timers.Timer aTimer;
        List<MAP> mapModels = new List<MAP>();
        //private Timer timer;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                LoadDDl();
                ScriptManager.GetCurrent(this).RegisterPostBackControl(btnlivetracking);
            }

        }
        void LoadDDl()
        {
            //=====Bind Zone=====//
            BindZone();
            //=====Bind Zone=====//
            //=====Bind Ward=====//
            BindWard("default");
            //=====Bind Ward=====//
            //=====Bind Vehicle=====//
            BindVehicle("default");
            //=====Bind Vehicle=====//

        }

        void BindZone()
        {
            //=====Bind Zone=====//
            mapBAL bAL = new mapBAL();
            MAP mAP = new MAP();
            mAP.mode = "1";
            mAP.userId = "11401";// "1014";
            mapModels = bAL.GetCurrentLocation(mAP, "Zone");
            ddlZone.DataSource = mapModels;
            //ddlZone.Items.Insert(0, new ListItem("All Zone", "default")); //updated code

            ddlZone.DataTextField = "ZoneName";
            ddlZone.DataValueField = "ZoneId";
            ddlZone.DataBind();
            ddlZone.Items.Insert(0, new ListItem("All Zone", "default")); //updated code

            //=====Bind Zone=====//
        }
        void BindWard(string zoneId)
        {
            //=====Bind Ward=====//
            ddlWard.ClearSelection();
            mapBAL bAL = new mapBAL();
            MAP mAP = new MAP();
            mAP.mode = "2";
            mAP.userId = "11401";// "1014";
            if (zoneId != "default")
            {
                mAP.ZoneId = zoneId;
            }
            mapModels = bAL.GetCurrentLocation(mAP, "Ward");
            ddlWard.DataSource = mapModels;
            ddlWard.DataTextField = "wardName";
            ddlWard.DataValueField = "PK_wardId";
            //ddlWard.Items.Insert(0, new ListItem("All Ward", "default")); //updated code

            ddlWard.DataBind();
            ddlWard.Items.Insert(0, new ListItem("All Ward", "default")); //updated code

            //=====Bind Ward=====//
        }

        void BindVehicle(string wardId)
        {
            //=====Bind Vehicle=====//
            ddlVehicle.ClearSelection();
            mapBAL bAL = new mapBAL();
            MAP mAP = new MAP();
            mAP.mode = "9";
            mAP.userId = "11401";// "1014";
            if (wardId != "default")
            {
                mAP.PK_wardId = wardId;
            }
            mapModels = bAL.GetCurrentLocation(mAP, "Vehicle");
            ddlVehicle.DataSource = mapModels;
            ddlVehicle.DataTextField = "vehicleName";
            ddlVehicle.DataValueField = "PK_VehicleId";
            ddlVehicle.DataBind();
            //=====Bind Vehicle=====//
        }
        public void LoadCurrentLocation()
        {
            mapBAL bAL = new mapBAL();
            MAP mAP = new MAP();
            mAP.mode = "6";
            mAP.FK_VehicleID = Convert.ToString(ddlVehicle.SelectedValue);// "1411";// "1014";
            mapModels = bAL.GetCurrentLocation(mAP, "CurrentLocation");
            ListtoDataTableConverter converter = new ListtoDataTableConverter();
            DataTable dt = converter.ToDataTable(mapModels);
            BindVehiclePath(dt);
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
                //*
                //ClientScript.RegisterStartupScript(GetType(), "Javascript", "javascript:ClearMap(); ", true);
                //ClientScript.RegisterStartupScript(GetType(), "Javascript", "javascript:Clearboundries(); ", true);
                ////*

                for (int i = 0; i < dataTable.Rows.Count; i++)
                {
                    string latitudeString = dataTable.Rows[i]["latitude"].ToString();
                    string longitudeString = dataTable.Rows[i]["longitude"].ToString();
                    string vehicleName = dataTable.Rows[i]["vehicleName"].ToString();
                    //System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "addMarker", "addMarker(" + latitudeString + ", " + longitudeString + ", " + vehicleName + ");", true);
                    //ScriptManager.RegisterStartupScript(this, GetType(), "addMarker", "addMarker(" + latitudeString + ", " + longitudeString + ", " + vehicleName + ");", true);
                    // Call the JavaScript function in each iteration
                    ClientScriptManager cs = Page.ClientScript;
                    cs.RegisterStartupScript(this.GetType(), "addMarker" + i.ToString(), "addMarker(" + latitudeString + ", " + longitudeString + ", " + vehicleName + ");", true);

                }
                //this.webBrowser1.InvokeScript("DrawMap");
                // ClientScript.RegisterStartupScript(GetType(), "Javascript", "javascript:DrawMap(); ", true);

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

        protected void Unnamed1_Click(object sender, EventArgs e)
        {

        }

        protected void btnClick_Click(object sender, EventArgs e)
        {
            LoadCurrentLocation();
        }

        protected void btnlivetracking_Click(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            LoadCurrentLocation();
            //// Get the user input for the area to highlight or color
            //string userInput = txtInput.Text;

            //// Use Leaflet to update the map with the highlighted area
            //string script = @"var map = L.map('mapid').setView([51.505, -0.09], 13);var polygon = L.polygon([ [51.509, -0.08], [51.503, -0.06], [51.51, -0.047] ]).addTo(map); polygon.setStyle({fillColor: '" + userInput + "', fillOpacity: 0.7, color: 'black', weight: 2});";
            //ScriptManager.RegisterStartupScript(Page, GetType(), "HighlightMapArea", script, true);

        }

        protected void btnCurrentlocation_Click(object sender, EventArgs e)
        {
            string script = "showPopupmap('" + 72.8777 + "', " + 19.0760 + ", " + 72.8777 + ");";
            ScriptManager.RegisterStartupScript(this, GetType(), "ShowPopupScript", script, true);
            // LoadCurrentLocation();
        }

        protected void RegisterClientScript()
        {
            mapBAL bAL = new mapBAL();
            MAP mAP = new MAP();
            mAP.mode = "6";
            mAP.FK_VehicleID = "1411";// "1014";
            mapModels = bAL.GetCurrentLocation(mAP, "LiveTracking");
            ListtoDataTableConverter converter = new ListtoDataTableConverter();
            DataTable dt = converter.ToDataTable(mapModels);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                string latitudeString = dt.Rows[i]["latitude"].ToString();
                string longitudeString = dt.Rows[i]["longitude"].ToString();

                string script = "addMarker(" + latitudeString + ", " + longitudeString + ");";
                ScriptManager.RegisterStartupScript(this, GetType(), "AddMarkerScript", script, true);
            }
        }
        protected void btnlivetracking_Click1(object sender, EventArgs e)
        {
            //if (btnlivetracking.Text == "Stop Live Tracking")
            //{
            //    btnlivetracking.Text = "Start Live Tracking";
            //}
            //else
            //{
            //    //LoadCurrentLocation();
            //    StartTimer();
            //    btnlivetracking.Text = "Stop Live Tracking";
            //}
        }
        public void StartTimer()
        {

            //timer = new System.Timers.Timer(30000); // 5000 milliseconds = 5 seconds
            //timer.Elapsed += new ElapsedEventHandler(OnTimerElapsed);
            //timer.AutoReset = true;
            //timer.Enabled = true;
        }
        private void OnTimerElapsed(object source, ElapsedEventArgs e)
        {
            // This method will be called every 5 seconds
            // Put your code here
            LoadCurrentLocation();
        }

        public void StopTimer()
        {
            // timer.Enabled = false;
        }

        protected void ddlZone_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindWard(Convert.ToString(ddlZone.SelectedValue));
            BindVehicle(Convert.ToString(ddlWard.SelectedValue));
        }

        protected void ddlWard_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindVehicle(Convert.ToString(ddlWard.SelectedValue));
        }

        protected void btnlivetracking_Click2(object sender, EventArgs e)
        {
            if (btnlivetracking.Text == "Start Live Tracking")
            {
                //btnCurrentlocation_Click(null, null);
                SetTimer();
                //LoadCurrentLocation();
                btnlivetracking.Text = "Stop Live Tracking";
            }
            else
            {
                btnlivetracking.Text = "Start Live Tracking";
                aTimer.Enabled = false;
            }
        }
        private void SetTimer()
        {
            // Create a timer with a two second interval.
            aTimer = new System.Timers.Timer(15000);
            // Hook up the Elapsed event for the timer. 
            aTimer.Elapsed += OnTimedEvent;
            aTimer.AutoReset = true;
            aTimer.Enabled = true;
        }

        private void OnTimedEvent(Object source, ElapsedEventArgs e)
        {
            Console.WriteLine("The Elapsed event was raised at {0:HH:mm:ss.fff}", e.SignalTime);
            LoadCurrentLocation();
            //btnCurrentlocation_Click(null, null);
        }
        //public void InitTimer()
        //{
        //    timer1 = new System.Web.UI.Timer();
        //    timer1.Tick += new EventHandler(timer1_Tick);
        //    timer1.Interval = 2000; // in miliseconds
        //    timer1.Start();
        //}

        //private void timer1_Tick(object sender, EventArgs e)
        //{
        //    LoadCurrentLocation();
        //}

    }
}