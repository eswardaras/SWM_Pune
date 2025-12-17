using SWM.BAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SWM
{
    public partial class VehicleMapViewHistory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {

                string FunName = Request.QueryString["FunName"];
                lblHeading.Text = FunName;
                if (FunName == "Jatayu")
                {
                    string latitudeString = Request.QueryString["latitudeString"];
                    string longitudeString = Request.QueryString["longitudeString"];
                    string vehicleName = Request.QueryString["vehicleName"];

                    string script = "showMap('" + vehicleName + "', " + latitudeString + ", " + longitudeString + ");";
                    ScriptManager.RegisterStartupScript(this, GetType(), "ShowPopupScript", script, true);
                }
                // LoadCurrentLocation();
                else if (FunName == "FeederSummaryReport")
                {
                    string fk_vehicleid = Request.QueryString["fk_vehicleid"];
                    string date = Request.QueryString["date"];
                    string route = Request.QueryString["route"];

                    // LoadData(date, Convert.ToInt32(fk_vehicleid));

                    BalFeederSummaryReport bAL = new BalFeederSummaryReport();

                    //===Feeder for Map===//
                    //exec proc_VehicleMapwithRoute @Mode=46,@RouteId=10010,@FK_VehicleID=11,@Startdate='2023-07-12 00:00:00',@FK_WardId=0
                    DataSet dsGetFeeder = bAL.GetFeeder(46, Convert.ToInt32(route), Convert.ToInt32(fk_vehicleid), date, 1020);

                    List<string[]> latLngList = new List<string[]>();

                    for (int i = 0; i < dsGetFeeder.Tables[0].Rows.Count; i++)
                    {
                        string latitude = Convert.ToString(dsGetFeeder.Tables[0].Rows[i]["sLat"]); //latitude longitude datetim	vehicleName
                        string longitude = Convert.ToString(dsGetFeeder.Tables[0].Rows[i]["SLong"]);
                        string Status = Convert.ToString(dsGetFeeder.Tables[0].Rows[i]["Status"]);
                        string AttendTime = Convert.ToString(dsGetFeeder.Tables[0].Rows[i]["AttendTime"]);
                        string WaitTime = Convert.ToString(dsGetFeeder.Tables[0].Rows[i]["WaitTime"]);
                        string feedername = Convert.ToString(dsGetFeeder.Tables[0].Rows[i]["feedername"]);
                        string expectedtime = Convert.ToString(dsGetFeeder.Tables[0].Rows[i]["expectedtime"]);
                        string logo = "Feeder";
                        string[] latLng = { latitude, longitude, Status, AttendTime, WaitTime, feedername, expectedtime, logo };
                        latLngList.Add(latLng);
                    }
                    //===vehicle for Map===//
                    DataSet dsGetVehicle = bAL.GetVehicle(4, Convert.ToInt32(fk_vehicleid), 0, 0, date.Split(' ')[0] + " 05:01", date.Split(' ')[0] + " 12:59:59.999", 11401, 0, 0);

                    for (int i = 0; i < dsGetVehicle.Tables[0].Rows.Count; i++)
                    {
                        string latitude = Convert.ToString(dsGetVehicle.Tables[0].Rows[i]["latitude"]); //latitude longitude datetim	vehicleName
                        string longitude = Convert.ToString(dsGetVehicle.Tables[0].Rows[i]["longitude"]);
                        string datetime = Convert.ToString(dsGetVehicle.Tables[0].Rows[i]["datetim"]);
                        string vehicleName = Convert.ToString(dsGetVehicle.Tables[0].Rows[i]["vehicleName"]);
                        string logo = "Vehicle";
                        string[] latLng = { latitude, longitude, "", datetime, "", vehicleName, "", logo };
                        latLngList.Add(latLng);
                    }

                    ViewState["latLngList"] = latLngList;

                    if (latLngList != null && latLngList.Count > 0)
                    {
                        string vehicleNamesJson = new JavaScriptSerializer().Serialize(latLngList.Select(l => l[5]).ToArray());
                        string coordinatesJson = new JavaScriptSerializer().Serialize(latLngList.Select(l => new[] { l[0], l[1] }).ToArray());
                        string DetailsJson = new JavaScriptSerializer().Serialize(latLngList.Select(l => new[] { l[6] }).ToArray());
                        string AttendTimeJson = new JavaScriptSerializer().Serialize(latLngList.Select(l => l[3]).ToArray());
                        string LogoJson = new JavaScriptSerializer().Serialize(latLngList.Select(l => l[7]).ToArray());

                        string latitude = new JavaScriptSerializer().Serialize(latLngList.Select(l => l[0]).ToArray());
                        string longitude = new JavaScriptSerializer().Serialize(latLngList.Select(l => l[1]).ToArray());
                        string Status = new JavaScriptSerializer().Serialize(latLngList.Select(l => l[2]).ToArray());
                        string AttendTime = new JavaScriptSerializer().Serialize(latLngList.Select(l => l[3]).ToArray());
                        string WaitTime = new JavaScriptSerializer().Serialize(latLngList.Select(l => l[4]).ToArray());
                        string feedername = new JavaScriptSerializer().Serialize(latLngList.Select(l => l[5]).ToArray());
                        string expectedtime = new JavaScriptSerializer().Serialize(latLngList.Select(l => l[6]).ToArray());
                        string logo = new JavaScriptSerializer().Serialize(latLngList.Select(l => l[7]).ToArray());

                        string script = $"showMapmultiple({vehicleNamesJson}, {coordinatesJson}, {DetailsJson}, {AttendTimeJson}, {LogoJson}, {Status}, {AttendTime}, {WaitTime}, {expectedtime});";
                        ScriptManager.RegisterStartupScript(this, GetType(), "ShowMapScript", script, true);
                    }
                    else
                    {
                        Response.Write("No Data Found");
                    }
                }
                else if (FunName == "MechanicalSweeperReport")
                {
                    string fk_vehicleid = Request.QueryString["fk_vehicleid"];
                    string date = Request.QueryString["date"];
                    string routeid = Request.QueryString["routeid"];
                    // LoadData(date, Convert.ToInt32(fk_vehicleid));

                    BalFeederSummaryReport bAL = new BalFeederSummaryReport();

                    //exec Proc_VehicleMapwithRoute @mode = 12,@Fk_accid = 11401,@Fk_ambcatId = 0,@Fk_divisionid = 0,@FK_VehicleID = 1312,@Fk_ZoneId = 0,@FK_WardId = 0,@Startdate = '2023-05-30 22:00:00',@Enddate = '2023-05-31 05:59:00',@Maxspeed = 0,@Minspeed = 0,@Fk_DistrictId = 0,@RouteId = 0,@GeoName = default
                    DataSet dsGetKothi = bAL.GetMechGps(4, 11401, Convert.ToInt32(fk_vehicleid), 0, 0, date + " 05:01", date + " 12:59:59.999");
                    if (dsGetKothi.Tables.Count > 0)
                    {
                        List<string[]> latLngList = new List<string[]>();
                        List<string[]> latLngListroute  = new List<string[]>();
                        for (int i = 0; i < dsGetKothi.Tables[0].Rows.Count; i++)
                        {
                            string latitude = Convert.ToString(dsGetKothi.Tables[0].Rows[i]["latitude"]); //datetim	vehicleName	speed	latitude	longitude
                            string longitude = Convert.ToString(dsGetKothi.Tables[0].Rows[i]["longitude"]);
                            string datetime = Convert.ToString(dsGetKothi.Tables[0].Rows[i]["datetim"]);
                            string vehicleName = Convert.ToString(dsGetKothi.Tables[0].Rows[i]["vehicleName"]);
                            string[] latLng = { latitude, longitude, datetime, vehicleName };
                            latLngList.Add(latLng);
                        }
                        #region add Route
                        DataSet dsGetRoute = bAL.GetRoute(12,routeid , 0, 0, Convert.ToInt32(fk_vehicleid), 0, 0, date + " 05:01", date + " 12:59:59.999", 0, 0, 0, 0);
                        for (int i = 0; i < dsGetRoute.Tables[0].Rows.Count; i++)
                        {
                            string latitude = Convert.ToString(dsGetRoute.Tables[0].Rows[i]["RouteLat"]); //datetim	vehicleName	speed	latitude	longitude
                            string longitude = Convert.ToString(dsGetRoute.Tables[0].Rows[i]["RouteLng"]);
                            //string datetime = Convert.ToString(dsGetRoute.Tables[0].Rows[i]["datetim"]);
                            //string vehicleName = Convert.ToString(dsGetRoute.Tables[0].Rows[i]["vehicleName"]);
                            string[] latLng = { latitude, longitude};
                            latLngListroute.Add(latLng);
                        }

                        #endregion


                        ViewState["latLngList"] = latLngList;
                        ViewState["latLngListroute"] = latLngListroute;

                        if (latLngList != null && latLngList.Count > 0)
                        {
                            string vehicleNamesJson = new JavaScriptSerializer().Serialize(latLngList.Select(l => l[3]).ToArray());
                            string coordinatesJson = new JavaScriptSerializer().Serialize(latLngList.Select(l => new[] { l[0], l[1] }).ToArray());
                            string coordinatesRouteJson = new JavaScriptSerializer().Serialize(latLngListroute.Select(l => new[] { l[0], l[1] }).ToArray());


                            string script = $"showMechanicalMapmultiple({vehicleNamesJson}, {coordinatesJson},{coordinatesRouteJson});";
                            ScriptManager.RegisterStartupScript(this, GetType(), "ShowMapScript", script, true);

                            //string script1 = $"showMechanicalMapRoute({vehicleNamesJson}, {coordinatesRouteJson});";
                            //ScriptManager.RegisterStartupScript(this, GetType(), "ShowMapScript1", script, true);
                        }
                        else
                        {
                            Response.Write("No Data Found");
                        }
                    }

                }
                else
                {
                    //===Yashwant code here===//
                    //string lat = Request.QueryString["lat"];
                    //string lon = Request.QueryString["lon"];
                    //string vehicleid = Request.QueryString["vehicleid"];
                    //string routeid = Request.QueryString["routeid"];

                    //HHComercialBAL bAL = new HHComercialBAL();
                    //DataSet dsPolygon = bAL.getpolygon(Convert.ToInt16(vehicleid), Convert.ToInt16(routeid));
                    //List<double[]> latLngList = new List<double[]>();
                    //// Populate the latLngList with the sequence of latitude and longitude
                    //// Assuming you have the latitudes and longitudes in separate lists or arrays, you can iterate over them and add them to latLngList
                    //for (int i = 0; i < dsPolygon.Tables[0].Rows.Count; i++)
                    //{
                    //    double latitude = Convert.ToDouble(dsPolygon.Tables[0].Rows[i]["latitude"]);
                    //    double longitude = Convert.ToDouble(dsPolygon.Tables[0].Rows[i]["longitude"]);
                    //    double[] latLng = { latitude, longitude };
                    //    latLngList.Add(latLng);
                    //}
                    //ViewState["latLngList"] = latLngList;

                    //string script1 = "initMap('" + lat + "', " + lon + ");";
                    //ScriptManager.RegisterStartupScript(this, GetType(), "initMap", script1, true);
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "VehicleMapViewHistory >> Method Page_Load()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }

        protected string GetLatLngListAsJavaScriptArray()
        {
            // Serialize the latLngList to a JSON string
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            string latLngListJson = serializer.Serialize(ViewState["latLngList"]);

            // Serialize the latLngList to a JavaScript array format
            string json = Newtonsoft.Json.JsonConvert.SerializeObject(ViewState["latLngList"]);
            return json;
        }

    }
}