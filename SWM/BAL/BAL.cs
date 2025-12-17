using SWM.DAL;
using SWM.MODEL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace SWM.BAL
{
    public class mapBAL
    {
        public List<MAP> GetCurrentLocation(MAP maP, string Callfrom)
        {
            mapDAL annotationDAL = new mapDAL();
            DataTable dt = new DataTable();

            try
            {
                List<MAP> videoAnnotationModels = new List<MAP>();

                dt = annotationDAL.GetCurrentLocation(maP);

                if (dt != null && dt.Rows.Count > 0)
                {

                    foreach (DataRow dr in dt.Rows)
                    {
                        MAP model = new MAP();
                        if (Callfrom == "Zone")
                        {
                            model.ZoneId = Convert.ToString(dr["ZoneId"]);
                            model.ZoneName = Convert.ToString(dr["ZoneName"]);
                        }
                        else if (Callfrom == "Ward")
                        {
                            model.PK_wardId = Convert.ToString(dr["PK_wardId"]);
                            model.wardName = Convert.ToString(dr["wardName"]);

                        }
                        else if (Callfrom == "Vehicle")
                        {
                            model.PK_VehicleId = Convert.ToString(dr["PK_VehicleId"]);
                            model.vehicleName = Convert.ToString(dr["vehicleName"]);
                        }
                        else if (Callfrom == "CurrentLocation")
                        {
                            model.counts = Convert.ToString(dr["counts"]);
                            model.datetim = Convert.ToString(dr["datetim"]);
                            model.vehicleName = Convert.ToString(dr["vehicleName"]);
                            model.speed = Convert.ToString(dr["speed"]);
                            model.latitude = Convert.ToString(dr["latitude"]);
                            model.longitude = Convert.ToString(dr["longitude"]);
                            model.color = Convert.ToString(dr["color"]);
                            model.vehicletype = Convert.ToString(dr["vehicletype"]);
                            model.distance = Convert.ToString(dr["distance"]);
                            model.TIME = Convert.ToString(dr["TIME"]);
                            model.LstRunIdletime = Convert.ToString(dr["LstRunIdletime"]);
                            model.LstDrive = Convert.ToString(dr["LstDrive"]);
                            model.TodaysODO = Convert.ToString(dr["TodaysODO"]);
                            model.branch = Convert.ToString(dr["branch"]);
                            model.branchshow = Convert.ToString(dr["branchshow"]);
                            model.Direction = Convert.ToString(dr["Direction"]);
                        }
                        videoAnnotationModels.Add(model);
                    }
                }

                return videoAnnotationModels;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public DataSet GetSweeperAttendance()
        {
            mapDAL annotationDAL = new mapDAL();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = annotationDAL.GetSweeperAttendance();
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public DataSet GetJatayucoveragereport(int @Accid, int @mode, int @zoneId, int @WardId, string @startdate, string @enddate, int @vehicleid, string Callfrom)
        {
            mapDAL annotationDAL = new mapDAL();
            DataTable dt = new DataTable();
            try
            {
                DataSet ds = annotationDAL.GetJatayucoveragereport(@Accid, @mode, @zoneId, @WardId, @startdate, @enddate, @vehicleid);

                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}