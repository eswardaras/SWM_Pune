using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using iTextSharp.text;
using iTextSharp.text.pdf;
using SWM.DAL;

namespace SWM.BAL
{
    public class BALAdhoc
    {
        public DataSet GetFeederSummaryReport(int @mode, int @vehicleId, int @AccId, int @ZoneId, int @WardId, string @startdate, string @enddate,
           string @stime, string @etime, string @RptName, string @Report, string @Zone, string @Ward, string @WorkingType, int @RouteId, int @AdminID, int @RoleID)
        {
            DALAdhoc dalFeederSummaryReport = new DALAdhoc();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.GetFeederSummaryReport(@mode, @vehicleId, @AccId, @ZoneId, @WardId, @startdate, @enddate,
           @stime, @etime, @RptName, @Report, @Zone, @Ward, @WorkingType, @RouteId, @AdminID, @RoleID);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal DataSet GetSupervisor()
        {
            DALAdhoc dalFeederSummaryReport = new DALAdhoc();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.getsupervisor();
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }



        internal DataSet GetVehicle()
        {
            DALAdhoc dalFeederSummaryReport = new DALAdhoc();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.getVehicle();
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal DataSet insernewByproductsGeneration(string typeOfWasteGenratedInTones, string typeOfByproductGenrated, string byProductsaleInTones, string revenueGenrated, string authorisedBy, string typeOfWasteGenrated)
        {
            DALAdhoc dalFeederSummaryReport = new DALAdhoc();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.insernewrequest(typeOfWasteGenratedInTones, typeOfByproductGenrated, byProductsaleInTones, revenueGenrated, authorisedBy, typeOfWasteGenrated);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal DataSet AssignVehicle(object pk_RequestId, string vehicleid, string accid)
        {
            DALAdhoc dalFeederSummaryReport = new DALAdhoc();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.assignvehicle(pk_RequestId,  vehicleid,  accid);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal DataSet updateworkstatus(object pk_RequestId, string workstatus, string accid)
        {
            DALAdhoc dalFeederSummaryReport = new DALAdhoc();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.updateworkstatus(pk_RequestId, workstatus, accid);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal DataSet insernewrequest(string accid1, string zoneid, string wardid, string kothiid, string starterid, string driverid, string name, string mobile, string entitytypename, string entityname, string reqtype, string assignstatus, string mukadamid)
        {
            DALAdhoc dalFeederSummaryReport = new DALAdhoc();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.insernewrequest(accid1, zoneid, wardid, kothiid, starterid, driverid, name, mobile, entitytypename, entityname, @reqtype, assignstatus, mukadamid);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal DataSet GetMukadam(int mode, int fk_ZoneId, int fK_WardId, int fK_KothiId)
        {
            DALAdhoc dalFeederSummaryReport = new DALAdhoc();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.getMukadam(mode,fk_ZoneId, fK_WardId,  fK_KothiId);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal DataSet updateByproductsGeneration(string typeOfWasteGenratedInTones, string typeOfByproductGenrated, string byProductsaleInTones, string revenueGenrated, string authorisedBy, string typeOfWasteGenrated,string pk_id)
        {
            DALAdhoc dalFeederSummaryReport = new DALAdhoc();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.updatenewrequest(typeOfWasteGenratedInTones, typeOfByproductGenrated, byProductsaleInTones, revenueGenrated, authorisedBy, typeOfWasteGenrated, pk_id);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal DataSet deleteRequest(object pk_RequestId, string accid)
        {
            DALAdhoc dalFeederSummaryReport = new DALAdhoc();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.delete(pk_RequestId, accid);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal DataSet deleteRequestBY(int pk_RequestId, string accid)
        {
            DALAdhoc dalFeederSummaryReport = new DALAdhoc();
            DataSet dataSet = new DataSet();

            try
            {
                dataSet = dalFeederSummaryReport.deleteBy(pk_RequestId, accid);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }



        //@Mode=6,@Accid=11401,@zoneid=103,@wardid=0,@vehicleid=0,@StartDate=N'2023-05-17',@EndDate=N'2023-05-17'

    }
}