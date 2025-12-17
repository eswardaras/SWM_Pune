using SWM.MODEL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace SWM.DAL
{
    public class mapDAL : BaseData
    {
        public DataTable GetCurrentLocation(MAP maP)
        {
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand cmd = new SqlCommand();

            try
            {
                conn.Open();
                cmd = new SqlCommand("Proc_VehicleMap", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                //if (maP.mode != "default" && maP.mode != "0")

                if (maP.FK_VehicleID != "default" && maP.FK_VehicleID != "0")
                    cmd.Parameters.Add("@FK_VehicleID", SqlDbType.VarChar).Value = maP.FK_VehicleID;
                if (maP.userId != "default" && maP.userId != "0")
                    cmd.Parameters.Add("@UserID", SqlDbType.VarChar).Value = maP.userId;
                if (maP.ZoneId != "default" && maP.ZoneId != "0")
                    cmd.Parameters.Add("@zoneId", SqlDbType.VarChar).Value = maP.ZoneId;
                if (maP.PK_wardId != "default" && maP.PK_wardId != "0" && maP.PK_wardId != null)
                {
                    cmd.Parameters.Add("@WardId", SqlDbType.VarChar).Value = maP.PK_wardId;
                    cmd.Parameters.Add("@mode", SqlDbType.VarChar).Value = 10;
                }
                else
                {
                    cmd.Parameters.Add("@mode", SqlDbType.VarChar).Value = maP.mode;
                }
                Sda.SelectCommand = cmd;
                cmd.CommandTimeout = 600;
                Sda.Fill(dt);
                return dt;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (conn.State == ConnectionState.Open)
                {
                    conn.Close();
                }
                cmd.Dispose();
                dt.Dispose();
                Sda.Dispose();
            }
        }

        // exec proc_SweepersAttendance
        //@accid = 11401,@mode = 10,@zoneid = default,@wardid = default,@gisTypeId = default,@kothiid = default,
        //@startdate = '2023-05-08 05:00:01',@endDate = '2023-05-08 14:00:01',
        //@Month = default,@vehicleId = 0

        //exec proc_SweepersAttendance @accid=11401,@mode=10,@zoneid=0,@wardid=0,@gisTypeId=78,@kothiid=0,@startdate='2023-05-11 05:00:01',@endDate='2023-05-11 14:00:01',@Month=default,@vehicleId=0
        public DataSet GetSweeperAttendance(int @accid = 11401, int @mode = 10, string @startdate = "2023-05-11 05:00:01", string @endDate = "2023-05-14 14:00:01",
            int @vehicleId = 0, int @gisTypeId = 78)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand.CommandTimeout = 10000;
                scCommand= new SqlCommand("proc_SweepersAttendance", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@accid", SqlDbType.VarChar, 50).Value = @accid;
                scCommand.Parameters.Add("@mode", SqlDbType.NVarChar, 50).Value = @mode;
                scCommand.Parameters.Add("@startdate ", SqlDbType.DateTime, 50).Value = @startdate;
                scCommand.Parameters.Add("@endDate", SqlDbType.DateTime, 50).Value = @endDate;
                scCommand.Parameters.Add("@gisTypeId", SqlDbType.Int, 50).Value = @gisTypeId;

                scCommand.CommandType = CommandType.StoredProcedure;

                Sda.SelectCommand = scCommand;
                scCommand.CommandTimeout = 600;
                Sda.Fill(dataSet);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (conn.State == ConnectionState.Open)
                {
                    conn.Close();
                }
                scCommand.Dispose();
                dt.Dispose();
                Sda.Dispose();
            }
        }

        //exec proc_jatayucoveragereport @Accid=11401,@mode=6,@zoneId=0,@WardId=0,@startdate='2023-06-01 00:00:00',@enddate='2023-06-01 00:00:00',@vehicleid=1326
        public DataSet GetJatayucoveragereport(int @Accid,int @mode,int @zoneId,int @WardId,string @startdate,string @enddate,int @vehicleid)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_jatayucoveragereport", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@Accid", SqlDbType.Int, 50).Value = @Accid;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = @mode;
                scCommand.Parameters.Add("@startdate ", SqlDbType.VarChar, 50).Value = @startdate;
                scCommand.Parameters.Add("@enddate", SqlDbType.VarChar, 50).Value = @enddate;
                scCommand.Parameters.Add("@WardId", SqlDbType.Int, 50).Value = @WardId;
                scCommand.Parameters.Add("@vehicleid", SqlDbType.Int, 50).Value = @vehicleid;

                scCommand.CommandType = CommandType.StoredProcedure;

                Sda.SelectCommand = scCommand;
                scCommand.CommandTimeout = 600;
                Sda.Fill(dataSet);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (conn.State == ConnectionState.Open)
                {
                    conn.Close();
                }
                scCommand.Dispose();
                dt.Dispose();
                Sda.Dispose();
            }
        }
    }
}