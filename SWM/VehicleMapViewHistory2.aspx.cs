using Newtonsoft.Json;
using SWM.BAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SWM
{
    public partial class VehicleMapViewHistory2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string dat = Request.QueryString["dat"];
            //string lon = Request.QueryString["lon"];
            string vehicleid = Request.QueryString["vehicleid"];
            string routeid = Request.QueryString["routeid"];
            DateTime sd = Request.QueryString["sd"] == null ? DateTime.Now : Convert.ToDateTime(Request.QueryString["sd"]);
            DateTime ed = Request.QueryString["ed"] == null ? DateTime.Now : Convert.ToDateTime(Request.QueryString["ed"]);
            HHComercialBAL bAL = new HHComercialBAL();
            DataSet dsPolygon = bAL.getpolygon(Convert.ToInt16(vehicleid), Convert.ToInt16(routeid));
            List<double[]> latLngList = new List<double[]>();

            DataSet dsroute = bAL.getfeederlocation(Convert.ToInt16(vehicleid),Convert.ToDateTime(dat));

            string jsonData = JsonConvert.SerializeObject(dsroute.Tables[0]);
            ViewState["jsonData"] = jsonData;
            // Populate the latLngList with the sequence of latitude and longitude
            // Assuming you have the latitudes and longitudes in separate lists or arrays, you can iterate over them and add them to latLngList
            if (dsPolygon.Tables.Count > 0)
            {
                for (int i = 0; i < dsPolygon.Tables[0].Rows.Count; i++)
                {
                    double latitude = Convert.ToDouble(dsPolygon.Tables[0].Rows[i]["latitude"]);
                    double longitude = Convert.ToDouble(dsPolygon.Tables[0].Rows[i]["longitude"]);
                    double[] latLng = { latitude, longitude };
                    latLngList.Add(latLng);
                }

                ViewState["latLngList"] = latLngList;
            }
            string script = "initMap('" + 0 + "', " + 0 + ");";
            ScriptManager.RegisterStartupScript(this, GetType(), "initMap", script, true);

     

            //string script1 = "showPocketOnMap('" + lat + "', " + lon + ");";
            //ScriptManager.RegisterStartupScript(this, GetType(), "showPocketOnMap", script1, true);

            //DataTable dtPoints = dsroute.Tables[0];

            //foreach (DataRow row in dtPoints.Rows)
            //{
            //    string latitude = row["latitude"].ToString();
            //    string longitude = row["longitude"].ToString();
            //    string color = row["color"].ToString();

            //    string script3 = "addMarker({latitude}, {longitude}, '{color}');";
            //    ScriptManager.RegisterStartupScript(this, GetType(), "addMarker", script3, true);
            //}
            // LoadCurrentLocation();
        }

        protected string GetDataAsJson()
        {
            // Fetch the data from the DataTable


            // Convert the DataTable to a JSON string
            string jsonData = ViewState["jsonData"].ToString();

            return jsonData;
        }

        protected string GetLatLngListAsJavaScriptArray()
        {
            // Serialize the latLngList to a JavaScript array format
            string json = Newtonsoft.Json.JsonConvert.SerializeObject(ViewState["latLngList"]);
            return json;
        }
    }
}