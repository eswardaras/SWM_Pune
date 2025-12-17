using SWM.DAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace SWM.BAL
{
    public class BalFeederSummaryReport
    {
        public DataSet GetFeederSummaryReport(int @mode, int @vehicleId, int @AccId, int @ZoneId, int @WardId, string @startdate, string @enddate, int @RouteId)
        {
            DalFeederSummaryReport dalFeederSummaryReport = new DalFeederSummaryReport();
            DataSet dataSet = new DataSet();

            dataSet = dalFeederSummaryReport.GetFeederSummaryReport(@mode, @vehicleId, @AccId, @ZoneId, @WardId, @startdate, @enddate, @RouteId);
            return dataSet;


        }

        //@Mode=6,@Accid=11401,@zoneid=103,@wardid=0,@vehicleid=0,@StartDate=N'2023-05-17',@EndDate=N'2023-05-17'
        public DataSet GetFeederCoverageReport(int @Mode, int @ZoneId, int @WardId, int @vehicleid, string @StartDate, string @EndDate)
        {
            DalFeederSummaryReport dalFeederSummaryReport = new DalFeederSummaryReport();
            DataSet dataSet = new DataSet();

            dataSet = dalFeederSummaryReport.GetFeederCoverageReport(@Mode, @ZoneId, @WardId, @vehicleid, @StartDate, @EndDate);
            return dataSet;

        }
        public DataSet GetDailyWasteDashboard(int @Mode, int @zoneid, int @WardId, int @kothiid, int @accid, string @sdate, string @edate)
        {
            DalFeederSummaryReport dalFeederSummaryReport = new DalFeederSummaryReport();
            DataSet dataSet = new DataSet();

            dataSet = dalFeederSummaryReport.GetDailyWasteDashboard(@Mode, @zoneid, @WardId, @kothiid, @accid, @sdate, @edate);
            return dataSet;

        }

        //exec proc_ReportsDataBind @mode=2,@vehicleId=2,@AccId=11401,@ZoneId=0,@WardId=0,@startdate=N'2023-05-11 00:00',@enddate=N'2023-05-11 23:59',
        //@stime =default,@etime=default,@RptName=N'Daily Odometer',@Report=default,@Zone=default,@Ward=default,@WorkingType=default,@RouteId=0,@AdminID=0,@RoleID=0
        public DataSet GetPerformanceReports(int @mode, int @vehicleId, int @AccId, int @ZoneId, int @WardId, string @startdate, string @enddate, string @stime, string @etime, string @RptName, string @Report,
           string @Zone, string @Ward, string @WorkingType, string @RouteId, string @AdminID, string @RoleID)
        {
            DalFeederSummaryReport dalFeederSummaryReport = new DalFeederSummaryReport();
            DataSet dataSet = new DataSet();

            dataSet = dalFeederSummaryReport.GetPerformanceReports(@mode, @vehicleId, @AccId, @ZoneId, @WardId, @startdate, @enddate, @stime, @etime, @RptName, @Report, @Zone, @Ward, @WorkingType, @RouteId, @AdminID, @RoleID);
            return dataSet;
        }

        public DataSet GetGroupReports(int @mode, int @vehicleId, int @AccId, int @ZoneId, int @WardId, string @startdate, string @enddate, string @stime, string @etime, string @RptName, string @Report,
          string @Zone, string @Ward, string @WorkingType, string @RouteId, string @AdminID, string @RoleID)
        {
            DalFeederSummaryReport dalFeederSummaryReport = new DalFeederSummaryReport();
            DataSet dataSet = new DataSet();

            dataSet = dalFeederSummaryReport.GetGroupReports(@mode, @vehicleId, @AccId, @ZoneId, @WardId, @startdate, @enddate, @stime, @etime, @RptName, @Report, @Zone, @Ward, @WorkingType, @RouteId, @AdminID, @RoleID);
            return dataSet;

        }

        public DataSet GetMechanicalSweeperRouteCoverageReport(int @mode, int @AdminID, int @RoleID, int @AccId, int @ZoneId, int @WardId, string @startdate, string @enddate, string @MechSweeper)
        {
            DalFeederSummaryReport dalFeederSummaryReport = new DalFeederSummaryReport();
            DataSet dataSet = new DataSet();

            dataSet = dalFeederSummaryReport.GetMechanicalSweeperRouteCoverageReport(@mode, @AdminID, @RoleID, @AccId, @ZoneId, @WardId, @startdate, @enddate, @MechSweeper);
            return dataSet;

        }
        public DataSet GetJatayuCoverageReport(int @mode, int @AdminID, int @RoleID, int @AccId, int @ZoneId, int @WardId, string @startdate, string @enddate, int @vehicleid)
        {
            DalFeederSummaryReport dalFeederSummaryReport = new DalFeederSummaryReport();
            DataSet dataSet = new DataSet();

            dataSet = dalFeederSummaryReport.GetJatayuCoverageReport(@mode, @AdminID, @RoleID, @AccId, @ZoneId, @WardId, @startdate, @enddate, @vehicleid);
            return dataSet;

        }
        public DataSet GetZone(int @mode, int @vehicleId, int @AccId)
        {
            DalFeederSummaryReport dalFeederSummaryReport = new DalFeederSummaryReport();
            DataSet dataSet = new DataSet();

            dataSet = dalFeederSummaryReport.GetZone(@mode, @vehicleId, @AccId);
            return dataSet;

        }
        public DataSet GetWard(int @mode, int @vehicleId, int @AccId, int @ZoneId)
        {
            DalFeederSummaryReport dalFeederSummaryReport = new DalFeederSummaryReport();
            DataSet dataSet = new DataSet();

            dataSet = dalFeederSummaryReport.GetWard(@mode, @vehicleId, @AccId, @ZoneId);
            return dataSet;

        }
        public DataSet GetJayatu(int @Accid, int @mode, int @zoneId, int @WardId, string @startdate, string @enddate, int @vehicleid)
        {
            DalFeederSummaryReport dalFeederSummaryReport = new DalFeederSummaryReport();
            DataSet dataSet = new DataSet();

            dataSet = dalFeederSummaryReport.GetJayatu(@Accid, @mode, @zoneId, @WardId, @startdate, @enddate, @vehicleid);
            return dataSet;

        }

        //exec Proc_VehicleMapwithRoute @mode=24,@Fk_accid=11401,@FK_VehicleID=0,@Fk_ZoneId=104,@FK_WardId=1026,@Startdate=default,@Enddate=default
        public DataSet GetRoute(int @mode, int @Fk_accid, int @FK_VehicleID, int @Fk_ZoneId, int @FK_WardId, string @Startdate, string @Enddate)
        //public DataSet GetRoute(int @mode, int @vehicleId, int @AccId, int @ZoneId)
        {
            DalFeederSummaryReport dalFeederSummaryReport = new DalFeederSummaryReport();
            DataSet dataSet = new DataSet();

            dataSet = dalFeederSummaryReport.GetRoute(@mode, @Fk_accid, @FK_VehicleID, @Fk_ZoneId, @FK_WardId, @Startdate, @Enddate);
            return dataSet;

        }

        public DataSet GetVehicle(int @mode, int @FK_VehicleID, int @zoneId, int @WardId, string @sDate, string @eDate, int @UserID, int @zoneName, int @WardName)
        {
            DalFeederSummaryReport dalFeederSummaryReport = new DalFeederSummaryReport();
            DataSet dataSet = new DataSet();

            dataSet = dalFeederSummaryReport.GetVehicle(@mode, @FK_VehicleID, @zoneId, @WardId, @sDate, @eDate, @UserID, @zoneName, @WardName);
            return dataSet;

        }
        public DataSet GetKothi(int @mode, int @Fk_accid, int @Fk_ambcatId, int @Fk_divisionid, int @FK_VehicleID, int @Fk_ZoneId, int @FK_WardId, string @Startdate, string @Enddate,
            int @Maxspeed, int @Minspeed, int @Fk_DistrictId, int @Geoid)
        {
            DalFeederSummaryReport dalFeederSummaryReport = new DalFeederSummaryReport();
            DataSet dataSet = new DataSet();

            dataSet = dalFeederSummaryReport.GetKothi(@mode, @Fk_accid, @Fk_ambcatId, @Fk_divisionid, @FK_VehicleID, @Fk_ZoneId, @FK_WardId, @Startdate, @Enddate, @Maxspeed, @Minspeed, @Fk_DistrictId, @Geoid);
            return dataSet;

        }

        public DataSet GetMechGps(int @mode, int @UserID, int @FK_VehicleID, int @zoneId, int @WardId, string @sDate, string @eDate)
        {
            DalFeederSummaryReport dalFeederSummaryReport = new DalFeederSummaryReport();
            DataSet dataSet = new DataSet();

            dataSet = dalFeederSummaryReport.GetMechGps(@mode, @UserID, @FK_VehicleID, @zoneId, @WardId, @sDate, @eDate);
            return dataSet;

        }
        public DataSet GetMechanical(int @mode, int @AdminID, int @RoleID, int @AccId, int @ZoneId, int @WardId, string @startdate, string @enddate, string @MechSweeper)
        {
            DalFeederSummaryReport dalFeederSummaryReport = new DalFeederSummaryReport();
            DataSet dataSet = new DataSet();

            dataSet = dalFeederSummaryReport.GetMechanical(@mode, @AdminID, @RoleID, @AccId, @ZoneId, @WardId, @startdate, @enddate, @MechSweeper);
            return dataSet;

        }

        internal DataSet GetRoute(int v1, string v2, int v3, int v4, int v5, int v6, int v7, string v8, string v9, int v10, int v11, int v12, int v13)
        {
            DalFeederSummaryReport dalFeederSummaryReport = new DalFeederSummaryReport();
            DataSet dataSet = new DataSet();

            dataSet = dalFeederSummaryReport.GetRouteMech(28, v2);
            return dataSet;
        }

        public DataSet GetBreakdown(int @Mode, int @AccId, int @RoleID, int @zoneId, int @WardId, int @FK_VehicleID, string @vehiclename, int @VBreakdownStatus, string @Feedback,
            string @Fromdate, string @todate, int @pk_id, int @replacevehicleId)
        {
            DalFeederSummaryReport dalFeederSummaryReport = new DalFeederSummaryReport();
            DataSet dataSet = new DataSet();

            dataSet = dalFeederSummaryReport.GetBreakdown(@Mode, @AccId, @RoleID, @zoneId, @WardId, @FK_VehicleID, @vehiclename, @VBreakdownStatus, @Feedback, @Fromdate, @todate, @pk_id, @replacevehicleId);
            return dataSet;


        }
        internal DataSet GetPrabhag(int @mode, int @Fk_accid, int @Fk_ZoneId, int @FK_WardId)
        {
            DalFeederSummaryReport dalFeederSummaryReport = new DalFeederSummaryReport();
            DataSet dataSet = new DataSet();

            dataSet = dalFeederSummaryReport.GetPrabhag(@mode, @Fk_accid, @Fk_ZoneId, @FK_WardId);
            return dataSet;
        }

        public DataSet GetFeeder(int @Mode, int @RouteId, int @FK_VehicleID, string @Startdate, int @FK_WardId)
        {
            DalFeederSummaryReport dalFeederSummaryReport = new DalFeederSummaryReport();
            DataSet dataSet = new DataSet();

            dataSet = dalFeederSummaryReport.GetFeeder(@Mode, @RouteId, @FK_VehicleID, @Startdate, @FK_WardId);
            return dataSet;

        }
        public DataSet GetSweepersAttendance(int @accid, int @mode, int @zoneid, int @wardid, int @gisTypeId, int @kothiid, string @startdate, string @endDate,
            string @Month, int @vehicleId, string @emptype)
        {
            DalFeederSummaryReport dalFeederSummaryReport = new DalFeederSummaryReport();
            DataSet dataSet = new DataSet();

            dataSet = dalFeederSummaryReport.GetSweepersAttendance(@accid, @mode, @zoneid, @wardid, @gisTypeId, @kothiid, @startdate, @endDate, @Month, @vehicleId, @emptype);
            return dataSet;

        }
        public DataSet GetSweepersAttendanceSummary(int @accid, int @mode, int @zoneid, int @wardid, int @gisTypeId, int @kothiid, string @startdate, string @endDate,
            string @Month, int @vehicleId)
        {
            DalFeederSummaryReport dalFeederSummaryReport = new DalFeederSummaryReport();
            DataSet dataSet = new DataSet();

            dataSet = dalFeederSummaryReport.GetSweepersAttendanceSummary(@accid, @mode, @zoneid, @wardid, @gisTypeId, @kothiid, @startdate, @endDate, @Month, @vehicleId);
            return dataSet;

        }

        public DataSet GetCreateCamp(int @mode, string @CampName, string @FromDate, string @ToDate, string @Type, string @CampTypeID, string @AddCampType,
            string @CampRuleID, string @AddCampRule, string @ActivityID, string @AddActivity, string @CampFineID, string @AddFine, string @ParticipantsID, string @Description,
                 string @RewardParam, string @location, int @AccID, string @Objective, int @pk_campid, string @URL)
        {
            DalFeederSummaryReport dalFeederSummaryReport = new DalFeederSummaryReport();
            DataSet dataSet = new DataSet();

            dataSet = dalFeederSummaryReport.GetCreateCamp(@mode, @CampName, @FromDate, @ToDate, @Type, @CampTypeID, @AddCampType, @CampRuleID, @AddCampRule, @ActivityID,
                @AddActivity, @CampFineID, @AddFine, @ParticipantsID, @Description, @RewardParam, @location, @AccID, @Objective, @pk_campid, @URL);
            return dataSet;
        }

        public DataSet GetCreateCampForEdit(int @mode, int @pk_campid)
        {
            DalFeederSummaryReport dalFeederSummaryReport = new DalFeederSummaryReport();
            DataSet dataSet = new DataSet();

            dataSet = dalFeederSummaryReport.GetCreateCampForEdit(@mode, @pk_campid);
            return dataSet;
        }
        public DataSet GetCreateCamp(int @mode)
        {
            DalFeederSummaryReport dalFeederSummaryReport = new DalFeederSummaryReport();
            DataSet dataSet = new DataSet();

            //    dataSet = dalFeederSummaryReport.GetCreateCamp(
            //        @mode, @CampName, @FromDate, @ToDate, @Type, @CampTypeID, @AddCampType, @CampRuleID, @AddCampRule, @ActivityID,
            //@AddActivity, @CampFineID, @AddFine, @ParticipantsID, @Description, @RewardParam, @location, @AccID, @Objective, @pk_campid,
            //@URL, @ParticipantName, @Contact, @gender, @address, @img, @video, @audio, @age, @email, @grade, @firstw, @secondw, @thirdw,
            //@broture, @GFURL, @RulePDF);
            dataSet = dalFeederSummaryReport.GetCreateCamp(@mode);
            return dataSet;
        }
        public DataSet GetCreateCamp(int @mode, string @Type, int @AccID)
        {
            DalFeederSummaryReport dalFeederSummaryReport = new DalFeederSummaryReport();
            DataSet dataSet = new DataSet();

            //    dataSet = dalFeederSummaryReport.GetCreateCamp(
            //        @mode, @CampName, @FromDate, @ToDate, @Type, @CampTypeID, @AddCampType, @CampRuleID, @AddCampRule, @ActivityID,
            //@AddActivity, @CampFineID, @AddFine, @ParticipantsID, @Description, @RewardParam, @location, @AccID, @Objective, @pk_campid,
            //@URL, @ParticipantName, @Contact, @gender, @address, @img, @video, @audio, @age, @email, @grade, @firstw, @secondw, @thirdw,
            //@broture, @GFURL, @RulePDF);
            dataSet = dalFeederSummaryReport.GetCreateCamp(@mode, @Type, @AccID);
            return dataSet;
        }
        public DataSet GetRFIDTagReadReport(int @mode, int @accid, string @startdate, string @endDate, int @pk_vehicleid, int @wardid, int @zoneid)
        {
            DalFeederSummaryReport dalFeederSummaryReport = new DalFeederSummaryReport();
            DataSet dataSet = new DataSet();

            dataSet = dalFeederSummaryReport.GetRFIDTagReadReport(@mode, @accid, @startdate, @endDate, @pk_vehicleid, @wardid, @zoneid);
            return dataSet;

        }

    }
}