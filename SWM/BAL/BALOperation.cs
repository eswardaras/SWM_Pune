using SWM.DAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace SWM.BAL
{
    public class BALOperation

    {

        public DataSet GetUnassignedDevice(int @mode, DateTime dateTime1, DateTime dateTime2,string imei)
        {
            DalOperation dalFeederSummaryReport = new DalOperation();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.GetUnassignedDevice(@mode, dateTime1, dateTime2,imei);
                return dataSet;
            }
            catch (Exception ex)
            {
                return new DataSet();
                //throw ex;
            }
        }

        internal DataSet GetDropdown(int v)
        {
            DalOperation dalFeederSummaryReport = new DalOperation();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.GetDropdown(v);
                return dataSet;
            }
            catch (Exception ex)
            {
                return new DataSet();
                //  throw ex;
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

        internal DataSet GetReqReport(short v1, short v2, DateTime dateTime1, DateTime dateTime2, string v)
        {
            DalRamp dalFeederSummaryReport = new DalRamp();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.GetAdhocReqReport(v1, 0 , v2, dateTime1, dateTime2, v);
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

        internal DataSet GetVehicleTypeWiseReport(short v, DateTime dateTime1, DateTime dateTime2)
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

        internal DataSet InsertNewDevice(string vendor,string fkWorkId, string EmploymentType, string simno, string vehiclname,string  devicecompid, string versionname, string servpro, string expirydate, string cuodo, string vehiType, string fulfact, string fulsub, string fulTank, string voltageType, string instlDate, string vehicleOtherName, string pcbtype, string mileage, string fk_AccId, string hrMileage, string fuelVoltage, string imei)
        {
            DalOperation dalFeederSummaryReport = new DalOperation();
            DataSet dataSet = new DataSet();

            try
            {


                if (dalFeederSummaryReport.CheckIfDeviceExists(imei, simno, vehiclname))
                {
                    throw new Exception("IMEI/ Sim No/ Vehicle No already exists");
                }

                dataSet = dalFeederSummaryReport.InsertNewDevice(vendor, fkWorkId, EmploymentType, simno, vehiclname, devicecompid, versionname, servpro, expirydate, cuodo, vehiType, fulfact, fulsub, fulTank, voltageType, instlDate, vehicleOtherName, pcbtype, mileage, fk_AccId, hrMileage, fuelVoltage, imei);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}