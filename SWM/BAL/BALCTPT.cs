using SWM.DAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace SWM.BAL
{
    public class BALCTPT
    {
        internal DataSet GetBCAttendance(short v1, short v2, short v3, short v4, DateTime dateTime1, DateTime dateTime2)
        {
            DALCTPT dalFeederSummaryReport = new DALCTPT();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.dalGetBCAttendance(v1, v2, v3, v4, dateTime1, dateTime2);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal List<DataSet> GetCTPTDailyCheckinReport(short v1, short v2, short v3, short v, DateTime dateTime1, DateTime dateTime2)
        {
            DALCTPT dalFeederSummaryReport = new DALCTPT();
            List<DataSet> result = new List<DataSet>();

            try
            {
                result = dalFeederSummaryReport.GetCTPTDailyCheckinReport(v1, v2, v3, v, dateTime1, dateTime2);
                return result;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal DataSet GetCTPTAssignReport(short v1, short v2)
        {
            DALCTPT dalFeederSummaryReport = new DALCTPT();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.GetCTPTAssignReport(v1, v2);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal DataSet GetMokadam()
        {
            DALCTPT dalFeederSummaryReport = new DALCTPT();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.GetMokadam();
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal DataSet GetFineReport(short v1, short v2, short v3, DateTime dateTime1, DateTime dateTime2)
        {
            DALCTPT dalFeederSummaryReport = new DALCTPT();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.GetFineReport(v1, v2,v3, dateTime1, dateTime2);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

  

        internal DataSet GetWard(int mode, int v)
        {
            DALCTPT dalFeederSummaryReport = new DALCTPT();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.GetWard(mode, v);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal DataSet GetSI()
        {
            DALCTPT dalFeederSummaryReport = new DALCTPT();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.GetSI();
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal DataSet GetDSI()
        {
            DALCTPT dalFeederSummaryReport = new DALCTPT();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.GetDSI();
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal DataSet GetGridData()
        {
            DALCTPT dalFeederSummaryReport = new DALCTPT();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.GetGridData();
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal DataSet insernewrequest(string accid1, string zoneid, string wardid, string kothiid, string typeid, string name, string lon, string lat, string address, string mokadum, string dsi, string sI, string nos)
        {
            DALCTPT dalFeederSummaryReport = new DALCTPT();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.insernewrequest(accid1, zoneid, wardid, kothiid, typeid, name, lon, lat, address, mokadum, dsi, sI, nos);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal DataSet Getfinetype(int v1, int v2, int v3)
        {
            DALCTPT dalFeederSummaryReport = new DALCTPT();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.GetFineType();
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal DataSet GetEditData(object v)
        {
            DALCTPT dalFeederSummaryReport = new DALCTPT();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.GetEditData(v);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal DataSet updatedrequest(string accid1, string zoneid, string wardid, string kothiid, string typeid, string name, string lon, string lat, string address, string mokadum, string dsi, string sI, string nos, object v)
        {
            DALCTPT dalFeederSummaryReport = new DALCTPT();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.updaterequest(accid1, zoneid, wardid, kothiid, typeid, name, lon, lat, address, mokadum, dsi, sI, nos,v);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal DataSet deletedata(object v)
        {
            DALCTPT dalFeederSummaryReport = new DALCTPT();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.deletedata(v);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal DataSet GetFineoffender(short v, int v1)
        {
            DALCTPT dalFeederSummaryReport = new DALCTPT();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.GetFineoffender(v,v1);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}