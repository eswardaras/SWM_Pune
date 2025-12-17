using SWM.BAL;
using SWM.MODEL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SWM
{
    public partial class test : System.Web.UI.Page
    {
        List<MAP> mapModels = new List<MAP>();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnCurrentLocation_Click(object sender, EventArgs e)
        {
            LoadCurrentLocation();
        }
        public void LoadCurrentLocation()
        {
            mapBAL bAL = new mapBAL();
            MAP mAP = new MAP();
            mAP.mode = "6";
            mAP.FK_VehicleID = "1014";
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
                ClientScript.RegisterStartupScript(GetType(), "Javascript", "javascript:ClearMap(); ", true);
                ClientScript.RegisterStartupScript(GetType(), "Javascript", "javascript:Clearboundries(); ", true);
                //*

                for (int i = 0; i < dataTable.Rows.Count; i++)
                {
                    string latitudeString = dataTable.Rows[i]["latitude"].ToString();
                    string longitudeString = dataTable.Rows[i]["longitude"].ToString();
                    string script = string.Format("Addboundries({0}, {1})", latitudeString, longitudeString);

                    // string script = string.Format("myFunction('{0}', {1})", param1, param2);
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "Addboundries", script, true);

                    //this.webBrowser1.InvokeScript("Addboundries", new Object[] { Convert.ToDouble(dataTable.Rows[i]["latitude_t"]), Convert.ToDouble(dataTable.Rows[i]["longitude_t"]) });
                }
                //this.webBrowser1.InvokeScript("DrawMap");
                ClientScript.RegisterStartupScript(GetType(), "Javascript", "javascript:DrawMap(); ", true);

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
    }
}