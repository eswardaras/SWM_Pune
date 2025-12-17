using SWM.DAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace SWM.BAL
{
    public class HHComercialBAL
    {
        internal DataSet GetBCAttendance(short v1, short v2, short v3, short v4, DateTime dateTime1, DateTime dateTime2)
        {
            HHComercialDAL dalFeederSummaryReport = new HHComercialDAL();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.dalGetBCAttendance(v1,  v2,  v3,  v4,  dateTime1,  dateTime2);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal DataSet getpolygon(short v1, short v2)
        {
            HHComercialDAL dalFeederSummaryReport = new HHComercialDAL();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.getpolygon(v1, v2);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal DataSet getroute(short v1, short v2,DateTime s1, DateTime e1)
        {
            HHComercialDAL dalFeederSummaryReport = new HHComercialDAL();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.dalgetroute(v1, v2,s1,e1);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal DataSet getKothiradiusroute(string v)
        {
            HHComercialDAL dalFeederSummaryReport = new HHComercialDAL();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.getKothiradiusroute(v);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal DataSet GetCWReport(short v1, short v2, short v3, DateTime dateTime1, DateTime dateTime2,short v4)
        {
            HHComercialDAL dalFeederSummaryReport = new HHComercialDAL();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.GetCWReport(v1, v2, v3, dateTime1, dateTime2, v4);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal DataSet getfeederlocation(short v, DateTime dateTime)
        {
            HHComercialDAL dalFeederSummaryReport = new HHComercialDAL();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.getfeederlocation(v, dateTime);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}