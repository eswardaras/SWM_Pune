using SWM.DAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace SWM.BAL
{
    public class RampBAL

    {

        public DataSet GetRamp(int @mode, int @vehicleId, int @AccId)
        {
            DalRamp dalFeederSummaryReport = new DalRamp();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.GetRamp(@mode, @vehicleId, @AccId);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal DataSet GetReport(int v1, DateTime v2, DateTime v3)
        {
            DalRamp dalFeederSummaryReport = new DalRamp();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.GetReport(v1, v2, v3);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal DataSet getbatterystatus(int @zoneId, int @wardId, int @kothiId, string @dt)
        {
            DALAdhoc dalFeederSummaryReport = new DALAdhoc();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.getbatterystatus(@zoneId, @wardId, @kothiId, @dt);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal DataSet GetByProduct()
        {
            DALAdhoc dalFeederSummaryReport = new DALAdhoc();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.GetByProduct();
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal DataSet GetReqReport(short v1, short v3, short v2, DateTime dateTime1, DateTime dateTime2, string v)
        {
            DalRamp dalFeederSummaryReport = new DalRamp();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.GetAdhocReqReport(v1,v3,v2, dateTime1, dateTime2,v);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal DataSet GetRampPlant(int v1, int v2, int v3)
        {
            DalRamp dalFeederSummaryReport = new DalRamp();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.GetRampPlant(v1, v2, v3);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal DataSet GetPlant(int v1, int v2, int v3)
        {
            DalRamp dalFeederSummaryReport = new DalRamp();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.GetPlant(v1, v2, v3);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal DataSet GetTripReport(short v1, short v2, short v3, DateTime dateTime1, DateTime dateTime2)
        {
            DalRamp dalFeederSummaryReport = new DalRamp();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.GetTripReport(v1, v2,v3, dateTime1, dateTime2);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal DataSet GetADHOC(string v = null)
        {
            DalRamp dalFeederSummaryReport = new DalRamp();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.GetAdhoc(v);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal DataSet GetVehicleReport(int v, DateTime dateTime1, DateTime dateTime2)
        {
            DalRamp dalFeederSummaryReport = new DalRamp();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.GetVehicleReport(v, dateTime1, dateTime2);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal DataSet GetplantReport(short v, DateTime dateTime1, DateTime dateTime2)
        {
            DalRamp dalFeederSummaryReport = new DalRamp();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.GetPlantReport(v, dateTime1, dateTime2);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal DataSet GetOnlyplantReport(int v, DateTime dateTime1, DateTime dateTime2)
        {
            DalRamp dalFeederSummaryReport = new DalRamp();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.GetOnlyplantReport(v, dateTime1, dateTime2);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal DataSet GetPrabhagReport(short v, DateTime dateTime1, DateTime dateTime2)
        {
            DalRamp dalFeederSummaryReport = new DalRamp();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.GetPlantReport(v, dateTime1, dateTime2);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal DataSet GetVehicleTypeWiseReport(int v, DateTime dateTime1, DateTime dateTime2)
        {
            DalRamp dalFeederSummaryReport = new DalRamp();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.GetVehicletypewiseReport(v, dateTime1, dateTime2);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal DataSet GetVehicleTripReport(short v, DateTime dateTime1, DateTime dateTime2)
        {
            DalRamp dalFeederSummaryReport = new DalRamp();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.GetVehicletripReport(v, dateTime1, dateTime2);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public DataSet GetRampLastDataEntry()
        {
            DalRamp dalFeederSummaryReport = new DalRamp();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.GetRampLastDataEntry();
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public DataSet GetSweeperDetails()
        {
            DalRamp dalFeederSummaryReport = new DalRamp();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.GetSweeperDetails();
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        internal DataSet GetVehiclewiseTripReport(int v, DateTime dateTime1, DateTime dateTime2)
        {
            DalRamp dalFeederSummaryReport = new DalRamp();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.GetVehiclewiseTripReport(v, dateTime1, dateTime2);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}