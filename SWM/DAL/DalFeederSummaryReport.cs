using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using iTextSharp.text;
using iTextSharp.text.pdf;

namespace SWM.DAL
{
    public class DalFeederSummaryReport : BaseData
    {
        DataTable dt = new DataTable();
        SqlDataAdapter Sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        //Old procedure of feeder summary report
        //public DataSet GetFeederSummaryReport(int @mode, int @vehicleId, int @AccId, int @ZoneId, int @WardId, string @startdate, string @enddate,
        //   string @stime, string @etime, string @RptName, string @Report, string @Zone, string @Ward, string @WorkingType, int @RouteId, int @AdminID, int @RoleID)
        //{
        //    DataSet dataSet = new DataSet();
        //    dt = new DataTable();
        //    Sda = new SqlDataAdapter();
        //    SqlCommand scCommand = new SqlCommand();

        //    try
        //    {
        //        conn.Open();
        //        scCommand = new SqlCommand("proc_ReportsDataBind", conn);
        //        scCommand.CommandType = CommandType.StoredProcedure;
        //        scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = @mode;
        //        scCommand.Parameters.Add("@vehicleId", SqlDbType.Int, 50).Value = @vehicleId;
        //        scCommand.Parameters.Add("@AccId", SqlDbType.Int, 50).Value = @AccId;
        //        scCommand.Parameters.Add("@ZoneId", SqlDbType.Int, 50).Value = @ZoneId;
        //        scCommand.Parameters.Add("@WardId", SqlDbType.Int, 50).Value = @WardId;
        //        scCommand.Parameters.Add("@startdate ", SqlDbType.DateTime, 50).Value = @startdate;
        //        scCommand.Parameters.Add("@enddate", SqlDbType.DateTime, 50).Value = @enddate;

        //        scCommand.Parameters.Add("@stime", SqlDbType.VarChar, 50).Value = @stime;
        //        scCommand.Parameters.Add("@etime", SqlDbType.VarChar, 50).Value = @etime;
        //        scCommand.Parameters.Add("@RptName", SqlDbType.VarChar, 50).Value = @RptName;
        //        scCommand.Parameters.Add("@Report", SqlDbType.VarChar, 50).Value = @Report;
        //        scCommand.Parameters.Add("@Zone", SqlDbType.VarChar, 50).Value = @Zone;
        //        scCommand.Parameters.Add("@Ward", SqlDbType.VarChar, 50).Value = @Ward;
        //        scCommand.Parameters.Add("@WorkingType", SqlDbType.VarChar, 50).Value = @WorkingType;

        //        scCommand.Parameters.Add("@RouteId", SqlDbType.Int, 50).Value = @RouteId;
        //        scCommand.Parameters.Add("@AdminID", SqlDbType.Int, 50).Value = @AdminID;
        //        scCommand.Parameters.Add("@RoleID", SqlDbType.Int, 50).Value = @RoleID;


        //        scCommand.CommandType = CommandType.StoredProcedure;

        //        Sda.SelectCommand = scCommand;
        //        scCommand.CommandTimeout = 600;
        //        Sda.Fill(dataSet);
        //        return dataSet;
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //    finally
        //    {
        //        if (conn.State == ConnectionState.Open)
        //        {
        //            conn.Close();
        //        }
        //        scCommand.Dispose();
        //        dt.Dispose();
        //        Sda.Dispose();
        //    }
        //}


        public DataSet GetFeederSummaryReport(int @mode, int @vehicleId, int @AccId, int @ZoneId, int @WardId, string @startdate, string @enddate,
         int @RouteId)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand = new SqlCommand("sp_FEEDER_REPORT", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@MODE", SqlDbType.Int, 50).Value = @mode;
                scCommand.Parameters.Add("@vehicleId", SqlDbType.Int, 50).Value = @vehicleId;
                scCommand.Parameters.Add("@fkid", SqlDbType.Int, 50).Value = @AccId;
                scCommand.Parameters.Add("@zoneid", SqlDbType.Int, 50).Value = @ZoneId;
                scCommand.Parameters.Add("@wardid", SqlDbType.Int, 50).Value = @WardId;
                scCommand.Parameters.Add("@STARTDATE ", SqlDbType.DateTime, 50).Value = @startdate;
                scCommand.Parameters.Add("@ENDDATE", SqlDbType.DateTime, 50).Value = @enddate;
                scCommand.Parameters.Add("@RouteId", SqlDbType.Int, 50).Value = @RouteId;


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

        //Previous logic for feeder coverage report
        //public DataSet GetFeederCoverageReport(int @Mode, int @AccId, int @ZoneId, int @WardId, int @vehicleid, string @StartDate, string @EndDate)
        //{
        //    {
        //        DataSet dataSet = new DataSet();
        //        dt = new DataTable();
        //        Sda = new SqlDataAdapter();
        //        SqlCommand scCommand = new SqlCommand();

        //        try
        //        {
        //            conn.Open();
        //            scCommand.CommandTimeout = 1000;
        //            scCommand = new SqlCommand("proc_PerformanceVehicleReport", conn);
        //            scCommand.CommandType = CommandType.StoredProcedure;
        //            scCommand.Parameters.Add("@AccId", SqlDbType.Int, 50).Value = @AccId;
        //            scCommand.Parameters.Add("@Mode", SqlDbType.Int, 50).Value = @Mode;
        //            scCommand.Parameters.Add("@ZoneId", SqlDbType.Int, 50).Value = @vehicleid == 0 ? @ZoneId : 0;
        //            scCommand.Parameters.Add("@WardId", SqlDbType.Int, 50).Value = @vehicleid == 0 ? @WardId : 0;
        //            scCommand.Parameters.Add("@vehicleid", SqlDbType.Int, 50).Value = @vehicleid;

        //            scCommand.Parameters.Add("@StartDate ", SqlDbType.Date).Value = Convert.ToDateTime(@StartDate);
        //            scCommand.Parameters.Add("@EndDate", SqlDbType.Date).Value = Convert.ToDateTime(@EndDate);


        //            scCommand.CommandType = CommandType.StoredProcedure;

        //            Sda.SelectCommand = scCommand;
        //            scCommand.CommandTimeout = 600;
        //            Sda.Fill(dataSet);
        //            return dataSet;
        //        }
        //        catch (Exception ex)
        //        {
        //            throw ex;
        //        }
        //        finally
        //        {
        //            if (conn.State == ConnectionState.Open)
        //            {
        //                conn.Close();
        //            }
        //            scCommand.Dispose();
        //            dt.Dispose();
        //            Sda.Dispose();
        //        }
        //    }
        //}

        //exec proc_DailyWasteDashboard @mode=4,@zoneid=0,@wardid=0,@kothiid=0,@accid=11401,@sdate='2023-05-01 00:00:01',@edate='2023-05-29 23:59:59'

        public DataSet GetFeederCoverageReport(int @Mode, int @ZoneId, int @WardId, int @vehicleid, string @StartDate, string @EndDate)
        {
            {
                DataSet dataSet = new DataSet();
                dt = new DataTable();
                Sda = new SqlDataAdapter();
                SqlCommand scCommand = new SqlCommand();

                try
                {
                    conn.Open();
                    scCommand.CommandTimeout = 1000;
                    scCommand = new SqlCommand("sp_FEEDER_REPORT", conn);
                    scCommand.CommandType = CommandType.StoredProcedure;
                    scCommand.Parameters.Add("@MODE", SqlDbType.Int, 50).Value = @Mode;
                    scCommand.Parameters.Add("@zoneid", SqlDbType.Int, 50).Value = @vehicleid == 0 ? @ZoneId : 0;
                    scCommand.Parameters.Add("@wardid", SqlDbType.Int, 50).Value = @vehicleid == 0 ? @WardId : 0;
                    scCommand.Parameters.Add("@vehicleId", SqlDbType.Int, 50).Value = @vehicleid;

                    scCommand.Parameters.Add("@STARTDATE ", SqlDbType.Date).Value = Convert.ToDateTime(@StartDate);
                    scCommand.Parameters.Add("@ENDDATE", SqlDbType.Date).Value = Convert.ToDateTime(@EndDate);


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
        public DataSet GetDailyWasteDashboard(int @Mode, int @zoneid, int @WardId, int @kothiid, int @accid, string @sdate, string @edate)
        {
            {
                DataSet dataSet = new DataSet();
                dt = new DataTable();
                Sda = new SqlDataAdapter();
                SqlCommand scCommand = new SqlCommand();

                try
                {
                    conn.Open();
                    scCommand = new SqlCommand("proc_DailyWasteDashboard", conn);
                    scCommand.CommandType = CommandType.StoredProcedure;
                    //scCommand.Parameters.Add("@AccId", SqlDbType.Int, 50).Value = @AccId;
                    scCommand.Parameters.Add("@Mode", SqlDbType.Int, 50).Value = @Mode;
                    scCommand.Parameters.Add("@zoneid", SqlDbType.Int, 50).Value = @zoneid;
                    scCommand.Parameters.Add("@WardId", SqlDbType.Int, 50).Value = @WardId;
                    scCommand.Parameters.Add("@kothiid", SqlDbType.Int, 50).Value = @kothiid;
                    scCommand.Parameters.Add("@accid", SqlDbType.Int, 50).Value = @accid;
                    scCommand.Parameters.Add("@sdate ", SqlDbType.DateTime, 50).Value = @sdate;
                    scCommand.Parameters.Add("@edate", SqlDbType.DateTime, 50).Value = @edate;


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

        //exec proc_ReportsDataBind @mode=2,@vehicleId=2,@AccId=11401,@ZoneId=0,@WardId=0,@startdate=N'2023-05-11 00:00',@enddate=N'2023-05-11 23:59',
        //@stime =default,@etime=default,@RptName=N'Daily Odometer',@Report=default,@Zone=default,@Ward=default,@WorkingType=default,@RouteId=0,@AdminID=0,@RoleID=0
        public DataSet GetPerformanceReports(int @mode, int @vehicleId, int @AccId, int @ZoneId, int @WardId, string @startdate, string @enddate, string @stime, string @etime, string @RptName, string @Report,
           string @Zone, string @Ward, string @WorkingType, string @RouteId, string @AdminID, string @RoleID)
        {
            {
                DataSet dataSet = new DataSet();
                dt = new DataTable();
                Sda = new SqlDataAdapter();
                SqlCommand scCommand = new SqlCommand();

                try
                {
                    conn.Open();
                    scCommand = new SqlCommand("proc_ReportsDataBind", conn);
                    scCommand.CommandType = CommandType.StoredProcedure;

                    scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = @mode;
                    scCommand.Parameters.Add("@vehicleId", SqlDbType.Int, 50).Value = @vehicleId;
                    scCommand.Parameters.Add("@AccId", SqlDbType.Int, 50).Value = @AccId;
                    scCommand.Parameters.Add("@ZoneId", SqlDbType.Int, 50).Value = @ZoneId;
                    scCommand.Parameters.Add("@WardId", SqlDbType.Int, 50).Value = @WardId;
                    scCommand.Parameters.Add("@startdate ", SqlDbType.DateTime, 50).Value = @startdate;
                    scCommand.Parameters.Add("@enddate", SqlDbType.DateTime, 50).Value = @enddate;

                    scCommand.Parameters.Add("@stime", SqlDbType.VarChar, 50).Value = @stime;
                    scCommand.Parameters.Add("@etime", SqlDbType.VarChar, 50).Value = @etime;
                    scCommand.Parameters.Add("@RptName", SqlDbType.VarChar, 50).Value = @RptName;
                    scCommand.Parameters.Add("@Report", SqlDbType.VarChar, 50).Value = @Report;
                    scCommand.Parameters.Add("@Zone", SqlDbType.VarChar, 50).Value = @Zone;

                    scCommand.Parameters.Add("@Ward", SqlDbType.VarChar, 50).Value = @Ward;
                    scCommand.Parameters.Add("@WorkingType", SqlDbType.VarChar, 50).Value = @WorkingType;
                    scCommand.Parameters.Add("@RouteId", SqlDbType.VarChar, 50).Value = @RouteId;
                    scCommand.Parameters.Add("@AdminID", SqlDbType.VarChar, 50).Value = @AdminID;
                    scCommand.Parameters.Add("@RoleID", SqlDbType.VarChar, 50).Value = @RoleID;

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

        internal DataSet GetRouteMech(int v, object routeid)
        {
            {
                DataSet dataSet = new DataSet();
                dt = new DataTable();
                Sda = new SqlDataAdapter();
                SqlCommand scCommand = new SqlCommand();

                try
                {
                    conn.Open();
                    scCommand = new SqlCommand("proc_VehicleMapwithRoute", conn);
                    scCommand.CommandType = CommandType.StoredProcedure;

                    scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = v;
                    scCommand.Parameters.Add("@Fk_divisionid", SqlDbType.Int, 50).Value = routeid;
                    scCommand.Parameters.Add("@Fk_ZoneId", SqlDbType.Int, 50).Value = 0;
                    scCommand.Parameters.Add("@FK_WardId", SqlDbType.Int, 50).Value = 0;
                    scCommand.Parameters.Add("@Fk_accid ", SqlDbType.Int, 50).Value = 11401;

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

        public DataSet GetGroupReports(int @mode, int @vehicleId, int @AccId, int @ZoneId, int @WardId, string @startdate, string @enddate, string @stime, string @etime, string @RptName, string @Report,
          string @Zone, string @Ward, string @WorkingType, string @RouteId, string @AdminID, string @RoleID)
        {
            {
                DataSet dataSet = new DataSet();
                dt = new DataTable();
                Sda = new SqlDataAdapter();
                SqlCommand scCommand = new SqlCommand();

                try
                {
                    conn.Open();
                    scCommand = new SqlCommand("proc_ReportsDataBind", conn);
                    scCommand.CommandType = CommandType.StoredProcedure;

                    scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = @mode;
                    scCommand.Parameters.Add("@vehicleId", SqlDbType.Int, 50).Value = @vehicleId;
                    scCommand.Parameters.Add("@AccId", SqlDbType.Int, 50).Value = @AccId;
                    scCommand.Parameters.Add("@ZoneId", SqlDbType.Int, 50).Value = @ZoneId;
                    scCommand.Parameters.Add("@WardId", SqlDbType.Int, 50).Value = @WardId;
                    scCommand.Parameters.Add("@startdate ", SqlDbType.DateTime, 50).Value = @startdate;
                    scCommand.Parameters.Add("@enddate", SqlDbType.DateTime, 50).Value = @enddate;

                    scCommand.Parameters.Add("@stime", SqlDbType.VarChar, 50).Value = @stime;
                    scCommand.Parameters.Add("@etime", SqlDbType.VarChar, 50).Value = @etime;
                    scCommand.Parameters.Add("@RptName", SqlDbType.VarChar, 50).Value = @RptName;
                    scCommand.Parameters.Add("@Report", SqlDbType.VarChar, 50).Value = @Report;
                    scCommand.Parameters.Add("@Zone", SqlDbType.VarChar, 50).Value = @Zone;

                    scCommand.Parameters.Add("@Ward", SqlDbType.VarChar, 50).Value = @Ward;
                    scCommand.Parameters.Add("@WorkingType", SqlDbType.VarChar, 50).Value = @WorkingType;
                    scCommand.Parameters.Add("@RouteId", SqlDbType.VarChar, 50).Value = @RouteId;
                    scCommand.Parameters.Add("@AdminID", SqlDbType.VarChar, 50).Value = @AdminID;
                    scCommand.Parameters.Add("@RoleID", SqlDbType.VarChar, 50).Value = @RoleID;

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

        //exec proc_MechanicalSweeperRouteCoverage @mode=4,@AdminID=0,@RoleID=0,@AccId=11401,@ZoneId=0,@WardId=0,@startdate=N'2023-05-03',@enddate=N'2023-05-03',@MechSweeper=N'All'
        public DataSet GetMechanicalSweeperRouteCoverageReport(int @mode, int @AdminID, int @RoleID, int @AccId, int @ZoneId, int @WardId, string @startdate, string @enddate, string @MechSweeper)
        {
            {
                DataSet dataSet = new DataSet();
                dt = new DataTable();
                Sda = new SqlDataAdapter();
                SqlCommand scCommand = new SqlCommand();

                try
                {
                    conn.Open();
                    scCommand = new SqlCommand("proc_MechanicalSweeperRouteCoverage", conn);
                    scCommand.CommandType = CommandType.StoredProcedure;
                    scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = @mode;
                    scCommand.Parameters.Add("@AdminID", SqlDbType.Int, 50).Value = @AdminID;
                    scCommand.Parameters.Add("@RoleID", SqlDbType.Int, 50).Value = @RoleID;
                    scCommand.Parameters.Add("@AccId", SqlDbType.Int, 50).Value = @AccId;
                    scCommand.Parameters.Add("@ZoneId", SqlDbType.Int, 50).Value = @ZoneId;
                    scCommand.Parameters.Add("@WardId", SqlDbType.Int, 50).Value = @WardId;
                    scCommand.Parameters.Add("@startdate ", SqlDbType.VarChar, 50).Value = @startdate;
                    scCommand.Parameters.Add("@enddate", SqlDbType.VarChar, 50).Value = @enddate;
                    scCommand.Parameters.Add("@MechSweeper", SqlDbType.VarChar, 50).Value = @MechSweeper;


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

        //exec proc_jatayucoveragereport @mode=4,@AdminID=0,@RoleID=0,@AccId=11401,@ZoneId=103,@WardId=1020,@startdate=N'2023-05-29',@enddate=N'2023-05-29',@vehicleid=1326
        public DataSet GetJatayuCoverageReport(int @mode, int @AdminID, int @RoleID, int @AccId, int @ZoneId, int @WardId, string @startdate, string @enddate, int @vehicleid)
        {
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
                    scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = @mode;
                    scCommand.Parameters.Add("@AdminID", SqlDbType.Int, 50).Value = @AdminID;
                    scCommand.Parameters.Add("@RoleID", SqlDbType.Int, 50).Value = @RoleID;
                    scCommand.Parameters.Add("@AccId", SqlDbType.Int, 50).Value = @AccId;
                    scCommand.Parameters.Add("@ZoneId", SqlDbType.Int, 50).Value = @ZoneId;
                    scCommand.Parameters.Add("@WardId", SqlDbType.Int, 50).Value = @WardId;
                    scCommand.Parameters.Add("@startdate ", SqlDbType.VarChar, 50).Value = @startdate;
                    scCommand.Parameters.Add("@enddate", SqlDbType.VarChar, 50).Value = @enddate;
                    scCommand.Parameters.Add("@vehicleid", SqlDbType.VarChar, 50).Value = @vehicleid;


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
        //exec proc_SweeperRouteCoverageReportNew @mode = 11,@vehicleId = 0,@AccId = 11401
        public DataSet GetZone(int @mode, int @vehicleId, int @AccId)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_SweeperRouteCoverageReportNew", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = @mode;
                scCommand.Parameters.Add("@vehicleId", SqlDbType.Int, 50).Value = @vehicleId;
                scCommand.Parameters.Add("@AccId", SqlDbType.Int, 50).Value = @AccId;

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

        //exec proc_SweeperRouteCoverageReportNew @mode = 12,@vehicleId = 0,@AccId = 11401,@ZoneId = default
        public DataSet GetWard(int @mode, int @vehicleId, int @AccId, int @ZoneId)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_SweeperRouteCoverageReportNew", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = @mode;
                scCommand.Parameters.Add("@vehicleId", SqlDbType.Int, 50).Value = @vehicleId;
                scCommand.Parameters.Add("@AccId", SqlDbType.Int, 50).Value = @AccId;
                scCommand.Parameters.Add("@ZoneId", SqlDbType.Int, 50).Value = @ZoneId;
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

        //exec Proc_VehicleMap @mode=3,@FK_VehicleID=0,@zoneId=0,@WardId=0,@sDate=default,@eDate=default,@UserID=11401,@zoneName=default,@WardName=default
        public DataSet GetVehicle(int @mode, int @FK_VehicleID, int @zoneId, int @WardId, string @sDate, string @eDate, int @UserID, int @zoneName, int @WardName)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();
            try
            {
                conn.Open();
                scCommand.CommandTimeout = 10000;
                scCommand = new SqlCommand("Proc_VehicleMap", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = @mode;
                scCommand.Parameters.Add("@FK_VehicleID", SqlDbType.Int, 50).Value = @FK_VehicleID;
                scCommand.Parameters.Add("@zoneId", SqlDbType.Int, 50).Value = @zoneId;
                scCommand.Parameters.Add("@WardId", SqlDbType.Int, 50).Value = @WardId;
                scCommand.Parameters.Add("@sDate", SqlDbType.VarChar, 50).Value = @sDate;
                scCommand.Parameters.Add("@eDate", SqlDbType.VarChar, 50).Value = @eDate;
                scCommand.Parameters.Add("@UserID", SqlDbType.Int, 50).Value = @UserID;
                scCommand.Parameters.Add("@zoneName", SqlDbType.Int, 50).Value = @zoneName;
                scCommand.Parameters.Add("@WardName", SqlDbType.Int, 50).Value = @WardName;
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

        //exec Proc_VehicleMapwithRoute @mode=24,@Fk_accid=11401,@FK_VehicleID=0,@Fk_ZoneId=104,@FK_WardId=1026,@Startdate=default,@Enddate=default
        public DataSet GetRoute(int @mode, int @Fk_accid, int @FK_VehicleID, int @Fk_ZoneId, int @FK_WardId, string @Startdate, string @Enddate)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();
            try
            {
                conn.Open();
                scCommand = new SqlCommand("Proc_VehicleMapwithRoute", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = @mode;
                scCommand.Parameters.Add("@Fk_accid", SqlDbType.Int, 50).Value = @Fk_accid;
                scCommand.Parameters.Add("@FK_VehicleID", SqlDbType.Int, 50).Value = @FK_VehicleID;
                scCommand.Parameters.Add("@Fk_ZoneId", SqlDbType.Int, 50).Value = @Fk_ZoneId;
                scCommand.Parameters.Add("@FK_WardId", SqlDbType.Int, 50).Value = @FK_WardId;
                scCommand.Parameters.Add("@Startdate", SqlDbType.VarChar, 50).Value = @Startdate;
                scCommand.Parameters.Add("@Enddate", SqlDbType.VarChar, 50).Value = @Enddate;
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

        //exec Proc_VehicleMapwithRoute @mode=56,@Fk_accid=11401,@Fk_ambcatId=0,@Fk_divisionid=0,@FK_VehicleID=0,@Fk_ZoneId=0,@FK_WardId=1024,@Startdate=default,@Enddate=default,
        //@Maxspeed =0,@Minspeed=0,@Fk_DistrictId=0,@Geoid=0
        public DataSet GetKothi(int @mode, int @Fk_accid, int @Fk_ambcatId, int @Fk_divisionid, int @FK_VehicleID, int @Fk_ZoneId, int @FK_WardId, string @Startdate, string @Enddate,
            int @Maxspeed, int @Minspeed, int @Fk_DistrictId, int @Geoid)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();
            try
            {
                conn.Open();
                scCommand = new SqlCommand("Proc_VehicleMapwithRoute", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = @mode;
                scCommand.Parameters.Add("@Fk_accid", SqlDbType.Int, 50).Value = @Fk_accid;
                scCommand.Parameters.Add("@Fk_ambcatId", SqlDbType.Int, 50).Value = @Fk_ambcatId;
                scCommand.Parameters.Add("@Fk_divisionid", SqlDbType.Int, 50).Value = @Fk_divisionid;
                scCommand.Parameters.Add("@FK_VehicleID", SqlDbType.Int, 50).Value = 0;
                scCommand.Parameters.Add("@Fk_ZoneId", SqlDbType.Int, 50).Value = @Fk_ZoneId;
                scCommand.Parameters.Add("@FK_WardId", SqlDbType.Int, 50).Value = @FK_WardId;
                scCommand.Parameters.Add("@Startdate", SqlDbType.VarChar, 50).Value = "";
                scCommand.Parameters.Add("@Enddate", SqlDbType.VarChar, 50).Value = "";
                scCommand.Parameters.Add("@Maxspeed", SqlDbType.Int, 50).Value = @Maxspeed;
                scCommand.Parameters.Add("@Minspeed", SqlDbType.Int, 50).Value = @Minspeed;
                scCommand.Parameters.Add("@Fk_DistrictId", SqlDbType.Int, 50).Value = @Fk_DistrictId;
                scCommand.Parameters.Add("@Geoid", SqlDbType.Int, 50).Value = @Geoid;

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

        public DataSet GetMechGps(int @mode, int @UserID, int @FK_VehicleID, int @zoneId, int @WardId, string @sDate, string @eDate)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();
            try
            {
                conn.Open();
                scCommand = new SqlCommand("Proc_VehicleMap_1", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = @mode;
                scCommand.Parameters.Add("@UserID", SqlDbType.Int, 50).Value = @UserID;
                scCommand.Parameters.Add("@FK_VehicleID", SqlDbType.Int, 50).Value = @FK_VehicleID;
                scCommand.Parameters.Add("@zoneId", SqlDbType.Int, 50).Value = @zoneId;
                scCommand.Parameters.Add("@WardId", SqlDbType.Int, 50).Value = @WardId;
                scCommand.Parameters.Add("@sDate", SqlDbType.VarChar, 50).Value = @sDate;
                scCommand.Parameters.Add("@eDate", SqlDbType.VarChar, 50).Value = @eDate;

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

        //=====JAYATA=====//
        // exec proc_jatayucoveragereport @Accid = 11401,@mode = 3,@zoneId = 0,@WardId = 0,@startdate = '2023-06-01 00:00:00',@enddate = '2023-06-01 00:00:00',@vehicleid = 0
        public DataSet GetJayatu(int @Accid, int @mode, int @zoneId, int @WardId, string @startdate, string @enddate, int @vehicleid)
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
                scCommand.Parameters.Add("@WardId", SqlDbType.Int, 50).Value = @WardId;
                scCommand.Parameters.Add("@zoneId", SqlDbType.Int, 50).Value = @zoneId;
                scCommand.Parameters.Add("@startdate", SqlDbType.Char, 50).Value = @startdate;
                scCommand.Parameters.Add("@enddate", SqlDbType.Char, 50).Value = @enddate;
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

        //=====MechanicalSweeper=====//
        //exec proc_MechanicalSweeperRouteCoverage 3, 0, 0, 11401, Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value), txtSdate.Text, txtEdate.Text, "All"
        public DataSet GetMechanical(int @mode, int @AdminID, int @RoleID, int @AccId, int @ZoneId, int @WardId, string @startdate, string @enddate, string @MechSweeper)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();
            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_MechanicalSweeperRouteCoverage", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = @mode;
                scCommand.Parameters.Add("@AdminID", SqlDbType.Int, 50).Value = @AdminID;
                scCommand.Parameters.Add("@RoleID", SqlDbType.Int, 50).Value = @RoleID;
                //scCommand.Parameters.Add("@AccId", SqlDbType.Int, 50).Value = @ZoneId == 0 ? @AccId : 0;
                scCommand.Parameters.Add("@AccId", SqlDbType.Int, 50).Value = 11401;
                scCommand.Parameters.Add("@ZoneId", SqlDbType.Int, 50).Value = @ZoneId;
                scCommand.Parameters.Add("@WardId", SqlDbType.Int, 50).Value = @WardId;
                scCommand.Parameters.Add("@startdate", SqlDbType.VarChar, 50).Value = @startdate;
                scCommand.Parameters.Add("@enddate", SqlDbType.VarChar, 50).Value = @enddate;
                scCommand.Parameters.Add("@MechSweeper", SqlDbType.VarChar, 50).Value = @MechSweeper;

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

        //=====GetBreakdown=====//
        //exec proc_AddBreakdown @Mode = 9,@AccId = 0,@RoleID = 0,@zoneId = 0,@WardId = 0,@FK_VehicleID = 0,@vehiclename = default,@VBreakdownStatus = 0,@Feedback = default, @Fromdate = '2023-07-01 00:00:00',@todate = '2023-07-11 00:00:00',@pk_id = 0,@replacevehicleId = 0
        public DataSet GetBreakdown(int @Mode, int @AccId, int @RoleID, int @zoneId, int @WardId, int @FK_VehicleID, string @vehiclename, int @VBreakdownStatus, string @Feedback,
            string @Fromdate, string @todate, int @pk_id, int @replacevehicleId)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();
            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_AddBreakdown", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@Mode", SqlDbType.Int, 50).Value = @Mode;
                scCommand.Parameters.Add("@AccId", SqlDbType.Int, 50).Value = @AccId;
                scCommand.Parameters.Add("@RoleID", SqlDbType.Int, 50).Value = @RoleID;
                scCommand.Parameters.Add("@zoneId", SqlDbType.Int, 50).Value = @zoneId;
                scCommand.Parameters.Add("@WardId", SqlDbType.Int, 50).Value = @WardId;
                scCommand.Parameters.Add("@FK_VehicleID", SqlDbType.Int, 50).Value = @FK_VehicleID;
                scCommand.Parameters.Add("@vehiclename", SqlDbType.VarChar, 50).Value = @vehiclename;
                scCommand.Parameters.Add("@VBreakdownStatus", SqlDbType.Int, 50).Value = @VBreakdownStatus;
                scCommand.Parameters.Add("@Feedback", SqlDbType.VarChar, 50).Value = @Feedback;
                scCommand.Parameters.Add("@Fromdate", SqlDbType.VarChar, 50).Value = @Fromdate;
                scCommand.Parameters.Add("@todate", SqlDbType.VarChar, 50).Value = @todate;
                scCommand.Parameters.Add("@pk_id", SqlDbType.Int, 50).Value = @pk_id;
                scCommand.Parameters.Add("@replacevehicleId", SqlDbType.Int, 50).Value = @replacevehicleId;

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

        internal DataSet GetPrabhag(int mode, int fk_accid, int fk_ZoneId, int fK_WardId)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_collectionworkerAttendance", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@accid", SqlDbType.Int, 50).Value = 11401;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = 10;
                scCommand.Parameters.Add("@zoneid", SqlDbType.Int, 50).Value = fk_ZoneId;
                scCommand.Parameters.Add("@wardid", SqlDbType.Int, 50).Value = fK_WardId;

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

        //exec proc_VehicleMapwithRoute @Mode=46,@RouteId=10010,@FK_VehicleID=11,@Startdate='2023-07-12 00:00:00',@FK_WardId=0
        public DataSet GetFeeder(int @Mode, int @RouteId, int @FK_VehicleID, string @Startdate, int @FK_WardId)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();
            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_VehicleMapwithRoute", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@Mode", SqlDbType.Int, 50).Value = @Mode;
                scCommand.Parameters.Add("@RouteId", SqlDbType.Int, 50).Value = @RouteId;
                scCommand.Parameters.Add("@FK_VehicleID", SqlDbType.Int, 50).Value = @FK_VehicleID;
                scCommand.Parameters.Add("@Startdate", SqlDbType.VarChar, 50).Value = @Startdate;
                scCommand.Parameters.Add("@FK_WardId", SqlDbType.Int, 50).Value = @FK_WardId;

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

        //exec proc_SweepersAttendance @accid=11401,@mode=10,@zoneid=0,@wardid=0,@gisTypeId=78,@kothiid=0,@startdate='2023-08-03 17:30:29.207',@endDate='2023-08-03 17:30:29.207',@Month=default,@vehicleId=0
        public DataSet GetSweepersAttendance(int @accid, int @mode, int @zoneid, int @wardid, int @gisTypeId, int @kothiid, string @startdate, string @endDate, string @Month, int @vehicleId, string @emptype)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();
            try
            {
                conn.Open();
                scCommand.CommandTimeout = 100000;
                scCommand = new SqlCommand("proc_SweepersAttendance", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@accid", SqlDbType.Int, 50).Value = @accid;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = @mode;
                scCommand.Parameters.Add("@zoneid", SqlDbType.Int, 50).Value = @zoneid;
                scCommand.Parameters.Add("@wardid", SqlDbType.Int, 50).Value = @wardid;
                scCommand.Parameters.Add("@gisTypeId", SqlDbType.Int, 50).Value = @gisTypeId;
                scCommand.Parameters.Add("@kothiid", SqlDbType.Int, 50).Value = @kothiid;
                scCommand.Parameters.Add("@startdate", SqlDbType.VarChar, 50).Value = @startdate;
                scCommand.Parameters.Add("@endDate", SqlDbType.VarChar, 50).Value = @endDate;
                scCommand.Parameters.Add("@Month", SqlDbType.VarChar, 50).Value = @Month;
                scCommand.Parameters.Add("@vehicleId", SqlDbType.Int, 50).Value = @vehicleId;
                scCommand.Parameters.Add("@EmploymentType", SqlDbType.VarChar, 50).Value = @emptype;
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

        //exec proc_SweepersAttendance @accid=11401,@mode=1,@zoneid=0,@wardid=0,@gisTypeId=0,@kothiid=0,@startdate='2023-08-01 00:00:00',@endDate='2023-08-31 00:00:00',@Month=N'August',@vehicleId=0
        public DataSet GetSweepersAttendanceSummary(int @accid, int @mode, int @zoneid, int @wardid, int @gisTypeId, int @kothiid, string @startdate, string @endDate, string @Month, int @vehicleId)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();
            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_SweepersAttendance", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@accid", SqlDbType.Int, 50).Value = @accid;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = @mode;
                scCommand.Parameters.Add("@zoneid", SqlDbType.Int, 50).Value = @zoneid;
                scCommand.Parameters.Add("@wardid", SqlDbType.Int, 50).Value = @wardid;
                scCommand.Parameters.Add("@gisTypeId", SqlDbType.Int, 50).Value = @gisTypeId;
                scCommand.Parameters.Add("@kothiid", SqlDbType.Int, 50).Value = @kothiid;
                scCommand.Parameters.Add("@startdate", SqlDbType.VarChar, 50).Value = @startdate;
                scCommand.Parameters.Add("@endDate", SqlDbType.VarChar, 50).Value = @endDate;
                scCommand.Parameters.Add("@Month", SqlDbType.VarChar, 50).Value = @Month;
                scCommand.Parameters.Add("@vehicleId", SqlDbType.Int, 50).Value = @vehicleId;
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

        //== sp ref==//
        // exec proc_CreateCampaign @mode = 3, @CampName = default, @FromDate = '2023-08-24 10:24:16.727', @ToDate = '2023-08-24 10:24:16.727',
        // @Type = default, @CampTypeID = 0, @AddCampType = default, @CampRuleID = default, @AddCampRule = default, @ActivityID = default,
        // @AddActivity = default, @CampFineID = default, @AddFine = default, @ParticipantsID = default, @Description = default,
        // @RewardParam = default, @location = default, @AccID = 0, @Objective = default, @pk_campid = 0, @URL = default,
        // @ParticipantName = default, @Contact = 0, @gender = default, @address = default, @img = default, @video = default,
        // @audio = default, @age = 0, @email = default, @grade = 0, @firstw = default, @secondw = default, @thirdw = default,
        // @broture = default, @GFURL = default, @RulePDF = default
        // == sp ref==//
        //public DataSet GetCreateCamp(int @mode, string  @CampName ,string  @FromDate ,string  @ToDate ,
        //string @Type,int @CampTypeID,string  @AddCampType, int @CampRuleID,string  @AddCampRule, string  @ActivityID,
        //string  @AddActivity,int @CampFineID,string @AddFine,string @ParticipantsID,string @Description,
        //string @RewardParam, string @location,int @AccID,string  @Objective,int @pk_campid,string @URL,
        //string @ParticipantName, int @Contact, string  @gender,string @address,string @img,string @video,
        //string @audio,int @age,string @email,int @grade, string @firstw, string @secondw, string @thirdw,
        //string @broture, string  @GFURL, string @RulePDF)
        public DataSet GetCreateCamp(int @mode)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();
            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_CreateCampaign", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = @mode;
                //scCommand.Parameters.Add("@CampName", SqlDbType.VarChar, 50).Value = @CampName;
                //scCommand.Parameters.Add("@FromDate", SqlDbType.VarChar, 50).Value = @FromDate;
                //scCommand.Parameters.Add("@ToDate", SqlDbType.VarChar, 50).Value = @ToDate;
                //scCommand.Parameters.Add("@AddActivity", SqlDbType.VarChar, 50).Value = @AddActivity;
                //scCommand.Parameters.Add("@CampFineID", SqlDbType.Int, 50).Value = @CampFineID;
                //scCommand.Parameters.Add("@AddFine", SqlDbType.VarChar, 50).Value = @AddFine;
                //scCommand.Parameters.Add("@ParticipantsID", SqlDbType.VarChar, 50).Value = @ParticipantsID;
                //scCommand.Parameters.Add("@Description", SqlDbType.VarChar, 50).Value = @Description;
                //scCommand.Parameters.Add("@RewardParam", SqlDbType.VarChar, 50).Value = @RewardParam;
                //scCommand.Parameters.Add("@location", SqlDbType.VarChar, 50).Value = @location;
                //scCommand.Parameters.Add("@AccID", SqlDbType.Int, 50).Value = @AccID;
                //scCommand.Parameters.Add("@Objective", SqlDbType.VarChar, 50).Value = @Objective;
                //scCommand.Parameters.Add("@pk_campid", SqlDbType.VarChar, 50).Value = @pk_campid;
                //scCommand.Parameters.Add("@URL", SqlDbType.VarChar, 50).Value = @URL;
                //scCommand.Parameters.Add("@ParticipantName", SqlDbType.VarChar, 50).Value = @ParticipantName;
                //scCommand.Parameters.Add("@Contact", SqlDbType.VarChar, 50).Value = @Contact;
                //scCommand.Parameters.Add("@gender", SqlDbType.VarChar, 50).Value = @gender;
                //scCommand.Parameters.Add("@address", SqlDbType.VarChar, 50).Value = @address;
                //scCommand.Parameters.Add("@img", SqlDbType.VarChar, 50).Value = @img;
                //scCommand.Parameters.Add("@video", SqlDbType.VarChar, 50).Value = @video;
                //scCommand.Parameters.Add("@audio", SqlDbType.VarChar, 50).Value = @audio;
                //scCommand.Parameters.Add("@age", SqlDbType.Int, 50).Value = @age;
                //scCommand.Parameters.Add("@email", SqlDbType.VarChar, 50).Value = @email;
                //scCommand.Parameters.Add("@grade", SqlDbType.VarChar, 50).Value = @grade;
                //scCommand.Parameters.Add("@firstw", SqlDbType.VarChar, 50).Value = @firstw;
                //scCommand.Parameters.Add("@secondw", SqlDbType.VarChar, 50).Value = @secondw;
                //scCommand.Parameters.Add("@thirdw", SqlDbType.VarChar, 50).Value = @thirdw;
                //scCommand.Parameters.Add("@broture", SqlDbType.VarChar, 50).Value = @broture;
                //scCommand.Parameters.Add("@GFURL", SqlDbType.VarChar, 50).Value = @GFURL;
                //scCommand.Parameters.Add("@RulePDF", SqlDbType.VarChar, 50).Value = @RulePDF;

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

        public DataSet GetCreateCampForEdit(int @mode, int @pk_campid)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();
            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_CreateCampaign", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = @mode;

                scCommand.Parameters.Add("@pk_campid", SqlDbType.VarChar, 50).Value = @pk_campid;

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
        public DataSet GetCreateCamp(int @mode, string @Type, int @AccID)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();
            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_CreateCampaign", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = @mode;
                scCommand.Parameters.Add("@Type", SqlDbType.VarChar, 50).Value = @Type;
                //scCommand.Parameters.Add("@CampName", SqlDbType.VarChar, 50).Value = @CampName;
                //scCommand.Parameters.Add("@FromDate", SqlDbType.VarChar, 50).Value = @FromDate;
                //scCommand.Parameters.Add("@ToDate", SqlDbType.VarChar, 50).Value = @ToDate;
                //scCommand.Parameters.Add("@AddActivity", SqlDbType.VarChar, 50).Value = @AddActivity;
                //scCommand.Parameters.Add("@CampFineID", SqlDbType.Int, 50).Value = @CampFineID;
                //scCommand.Parameters.Add("@AddFine", SqlDbType.VarChar, 50).Value = @AddFine;
                //scCommand.Parameters.Add("@ParticipantsID", SqlDbType.VarChar, 50).Value = @ParticipantsID;
                //scCommand.Parameters.Add("@Description", SqlDbType.VarChar, 50).Value = @Description;
                //scCommand.Parameters.Add("@RewardParam", SqlDbType.VarChar, 50).Value = @RewardParam;
                //scCommand.Parameters.Add("@location", SqlDbType.VarChar, 50).Value = @location;
                scCommand.Parameters.Add("@AccID", SqlDbType.Int, 50).Value = @AccID;
                //scCommand.Parameters.Add("@Objective", SqlDbType.VarChar, 50).Value = @Objective;
                //scCommand.Parameters.Add("@pk_campid", SqlDbType.VarChar, 50).Value = @pk_campid;
                //scCommand.Parameters.Add("@URL", SqlDbType.VarChar, 50).Value = @URL;
                //scCommand.Parameters.Add("@ParticipantName", SqlDbType.VarChar, 50).Value = @ParticipantName;
                //scCommand.Parameters.Add("@Contact", SqlDbType.VarChar, 50).Value = @Contact;
                //scCommand.Parameters.Add("@gender", SqlDbType.VarChar, 50).Value = @gender;
                //scCommand.Parameters.Add("@address", SqlDbType.VarChar, 50).Value = @address;
                //scCommand.Parameters.Add("@img", SqlDbType.VarChar, 50).Value = @img;
                //scCommand.Parameters.Add("@video", SqlDbType.VarChar, 50).Value = @video;
                //scCommand.Parameters.Add("@audio", SqlDbType.VarChar, 50).Value = @audio;
                //scCommand.Parameters.Add("@age", SqlDbType.Int, 50).Value = @age;
                //scCommand.Parameters.Add("@email", SqlDbType.VarChar, 50).Value = @email;
                //scCommand.Parameters.Add("@grade", SqlDbType.VarChar, 50).Value = @grade;
                //scCommand.Parameters.Add("@firstw", SqlDbType.VarChar, 50).Value = @firstw;
                //scCommand.Parameters.Add("@secondw", SqlDbType.VarChar, 50).Value = @secondw;
                //scCommand.Parameters.Add("@thirdw", SqlDbType.VarChar, 50).Value = @thirdw;
                //scCommand.Parameters.Add("@broture", SqlDbType.VarChar, 50).Value = @broture;
                //scCommand.Parameters.Add("@GFURL", SqlDbType.VarChar, 50).Value = @GFURL;
                //scCommand.Parameters.Add("@RulePDF", SqlDbType.VarChar, 50).Value = @RulePDF;

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

        public DataSet GetCreateCamp(int @mode, string @CampName, string @FromDate, string @ToDate, string @Type, string @CampTypeID, string @AddCampType,
            string @CampRuleID, string @AddCampRule, string @ActivityID, string @AddActivity, string @CampFineID, string @AddFine, string @ParticipantsID, string @Description,
                 string @RewardParam, string @location, int @AccID, string @Objective, int @pk_campid, string @URL)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();
            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_CreateCampaign", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = @mode;
                scCommand.Parameters.Add("@CampName", SqlDbType.VarChar, 50).Value = @CampName;
                scCommand.Parameters.Add("@FromDate", SqlDbType.VarChar, 50).Value = @FromDate;
                scCommand.Parameters.Add("@ToDate", SqlDbType.VarChar, 50).Value = @ToDate;
                scCommand.Parameters.Add("@Type", SqlDbType.VarChar, 50).Value = @Type;

                scCommand.Parameters.Add("@CampTypeID", SqlDbType.VarChar, 50).Value = @CampTypeID;
                scCommand.Parameters.Add("@AddCampType", SqlDbType.VarChar, 50).Value = @AddCampType;
                scCommand.Parameters.Add("@CampRuleID", SqlDbType.VarChar, 50).Value = @CampRuleID;
                scCommand.Parameters.Add("@AddCampRule", SqlDbType.VarChar, 50).Value = @AddCampRule;
                scCommand.Parameters.Add("@ActivityID", SqlDbType.VarChar, 50).Value = @ActivityID;
                scCommand.Parameters.Add("@AddActivity", SqlDbType.VarChar, 50).Value = @AddActivity;
                scCommand.Parameters.Add("@CampFineID", SqlDbType.VarChar, 50).Value = @CampFineID;
                scCommand.Parameters.Add("@AddFine", SqlDbType.VarChar, 50).Value = @AddFine;
                scCommand.Parameters.Add("@ParticipantsID", SqlDbType.VarChar, 50).Value = @ParticipantsID;

                scCommand.Parameters.Add("@Description", SqlDbType.VarChar, 50).Value = @Description;
                scCommand.Parameters.Add("@RewardParam", SqlDbType.VarChar, 50).Value = @RewardParam;
                scCommand.Parameters.Add("@location", SqlDbType.VarChar, 50).Value = @location;
                scCommand.Parameters.Add("@AccID", SqlDbType.Int, 50).Value = @AccID;
                scCommand.Parameters.Add("@Objective", SqlDbType.VarChar, 50).Value = @Objective;
                scCommand.Parameters.Add("@pk_campid", SqlDbType.VarChar, 50).Value = @pk_campid;
                scCommand.Parameters.Add("@URL", SqlDbType.VarChar, 50).Value = @URL;

                //scCommand.Parameters.Add("@video", SqlDbType.VarChar, 50).Value = @video;
                //scCommand.Parameters.Add("@audio", SqlDbType.VarChar, 50).Value = @audio;
                //scCommand.Parameters.Add("@age", SqlDbType.Int, 50).Value = @age;
                //scCommand.Parameters.Add("@email", SqlDbType.VarChar, 50).Value = @email;
                //scCommand.Parameters.Add("@grade", SqlDbType.VarChar, 50).Value = @grade;
                //scCommand.Parameters.Add("@firstw", SqlDbType.VarChar, 50).Value = @firstw;
                //scCommand.Parameters.Add("@secondw", SqlDbType.VarChar, 50).Value = @secondw;
                //scCommand.Parameters.Add("@thirdw", SqlDbType.VarChar, 50).Value = @thirdw;
                //scCommand.Parameters.Add("@broture", SqlDbType.VarChar, 50).Value = @broture;
                //scCommand.Parameters.Add("@GFURL", SqlDbType.VarChar, 50).Value = @GFURL;
                //scCommand.Parameters.Add("@RulePDF", SqlDbType.VarChar, 50).Value = @RulePDF;

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


        ////exec proc_Tagregrestrationagdelhi_vehicles @mode=7,@accid=11401,@startdate=N'2023-09-08',@enddate=N'2023-09-28',@pk_vehicleid=0,@wardId=0,@zoneId=0        //
        public DataSet GetRFIDTagReadReport(int @mode, int @accid, string @startdate, string @endDate, int @pk_vehicleid, int @wardid, int @zoneid)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();
            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_Tagregrestrationagdelhi_vehicles", conn);
                scCommand.CommandTimeout = 1000;
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@accid", SqlDbType.Int, 50).Value = @accid;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = @mode;
                scCommand.Parameters.Add("@zoneid", SqlDbType.Int, 50).Value = @zoneid;
                scCommand.Parameters.Add("@wardid", SqlDbType.Int, 50).Value = @wardid;
                scCommand.Parameters.Add("@startdate", SqlDbType.VarChar, 50).Value = @startdate;
                scCommand.Parameters.Add("@endDate", SqlDbType.VarChar, 50).Value = @endDate;
                scCommand.Parameters.Add("@pk_vehicleid", SqlDbType.Int, 50).Value = @pk_vehicleid;
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