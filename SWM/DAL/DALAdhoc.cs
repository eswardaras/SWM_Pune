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
    public class DALAdhoc : BaseData
    {
        DataTable dt = new DataTable();
        SqlDataAdapter Sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();


        public DataSet GetFeederSummaryReport(int @mode, int @vehicleId, int @AccId, int @ZoneId, int @WardId, string @startdate, string @enddate,
           string @stime, string @etime, string @RptName, string @Report, string @Zone, string @Ward, string @WorkingType, int @RouteId, int @AdminID, int @RoleID)
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

                scCommand.Parameters.Add("@RouteId", SqlDbType.Int, 50).Value = @RouteId;
                scCommand.Parameters.Add("@AdminID", SqlDbType.Int, 50).Value = @AdminID;
                scCommand.Parameters.Add("@RoleID", SqlDbType.Int, 50).Value = @RoleID;


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

        internal DataSet getbatterystatus(int @zoneId, int @wardId, int @kothiId, string @dt1)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            SqlConnection newSqlConnection = new SqlConnection("Data Source=10.0.135.178,1433;Initial Catalog=SWMTracker;User ID=sa;Password=scs@1234;");

            SqlDataAdapter Sda1 = new SqlDataAdapter();

            SqlCommand scCommand = new SqlCommand();

            try
            {
                newSqlConnection.Open();
                scCommand = new SqlCommand("proc_getBatteryStat11", newSqlConnection);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@MODE", SqlDbType.Int, 50).Value = 1;
                scCommand.Parameters.Add("@ZONEID", SqlDbType.Int, 50).Value = @zoneId;
                scCommand.Parameters.Add("@WARDID", SqlDbType.Int, 50).Value = @wardId;
                scCommand.Parameters.Add("@KOTHIID", SqlDbType.Int, 50).Value = @kothiId;
                scCommand.Parameters.Add("@From_Date", SqlDbType.DateTime, 50).Value = @dt1;
                scCommand.CommandType = CommandType.StoredProcedure;

                Sda1.SelectCommand = scCommand;
                scCommand.CommandTimeout = 600;
                Sda1.Fill(dataSet);
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

        internal DataSet GetByProduct()
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_ByproductsGenerationAndSalesRevenue", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 1).Value = 2;
                scCommand.Parameters.Add("@pk_id", SqlDbType.Int, 1).Value = 0;
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

        internal DataSet insernewrequest(string typeOfWasteGenratedInTones, string typeOfByproductGenrated, string byProductsaleInTones, string revenueGenrated, string authorisedBy, string typeOfWasteGenrated)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();
            //@TypeOfWasteGenratedInTones,@TypeOfByproductGenrated,@ByProductsaleInTones,@RevenueGenrated,@AuthorisedBy,@TypeOfWasteGenrated,1,getdate()
            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_ByproductsGenerationAndSalesRevenue", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = 1;
                scCommand.Parameters.Add("@TypeOfWasteGenratedInTones", SqlDbType.VarChar, 300).Value = typeOfWasteGenratedInTones;
                scCommand.Parameters.Add("@TypeOfByproductGenrated", SqlDbType.VarChar, 300).Value = typeOfByproductGenrated;
                scCommand.Parameters.Add("@ByProductsaleInTones", SqlDbType.VarChar, 300).Value = byProductsaleInTones;
                scCommand.Parameters.Add("@RevenueGenrated", SqlDbType.VarChar, 300).Value = revenueGenrated;
                scCommand.Parameters.Add("@AuthorisedBy", SqlDbType.VarChar, 300).Value = authorisedBy;
                scCommand.Parameters.Add("@TypeOfWasteGenrated", SqlDbType.VarChar, 300).Value = typeOfWasteGenrated;
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

        internal DataSet deleteBy(int pk_RequestId, string accid)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_ByproductsGenerationAndSalesRevenue", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = 4;
                scCommand.Parameters.Add("@pk_id", SqlDbType.BigInt).Value = pk_RequestId;
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

        internal DataSet updatenewrequest(string typeOfWasteGenratedInTones, string typeOfByproductGenrated, string byProductsaleInTones, string revenueGenrated, string authorisedBy, string typeOfWasteGenrated, string pk_id)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();
            //@TypeOfWasteGenratedInTones,@TypeOfByproductGenrated,@ByProductsaleInTones,@RevenueGenrated,@AuthorisedBy,@TypeOfWasteGenrated,1,getdate()
            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_ByproductsGenerationAndSalesRevenue", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = 3;
                scCommand.Parameters.Add("@TypeOfWasteGenratedInTones", SqlDbType.VarChar, 300).Value = typeOfWasteGenratedInTones;
                scCommand.Parameters.Add("@TypeOfByproductGenrated", SqlDbType.VarChar, 300).Value = typeOfByproductGenrated;
                scCommand.Parameters.Add("@ByProductsaleInTones", SqlDbType.VarChar, 300).Value = byProductsaleInTones;
                scCommand.Parameters.Add("@RevenueGenrated", SqlDbType.VarChar, 300).Value = revenueGenrated;
                scCommand.Parameters.Add("@AuthorisedBy", SqlDbType.VarChar, 300).Value = authorisedBy;
                scCommand.Parameters.Add("@TypeOfWasteGenrated", SqlDbType.VarChar, 300).Value = typeOfWasteGenrated;
                scCommand.Parameters.Add("@pk_id", SqlDbType.BigInt).Value = pk_id;
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



        internal DataSet updateworkstatus(object pk_RequestId, string workstatus, string accid)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_AdhocRequestReport", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = 19;
                scCommand.Parameters.Add("@Pk_RequestId", SqlDbType.Int, 50).Value = pk_RequestId;
                scCommand.Parameters.Add("@remark", SqlDbType.VarChar, 50).Value = "web";
                scCommand.Parameters.Add("@accid", SqlDbType.Int, 50).Value = accid;
                scCommand.Parameters.Add("@workstatus", SqlDbType.VarChar, 50).Value = workstatus;
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

        internal DataSet delete(object pk_RequestId, string accid)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_AdhocRequestReport", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = 21;
                scCommand.Parameters.Add("@Pk_RequestId", SqlDbType.Int, 50).Value = pk_RequestId;
                scCommand.Parameters.Add("@remark", SqlDbType.VarChar, 50).Value = "web";
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

        internal DataSet getMukadam(int mode, int fk_ZoneId, int fK_WardId, int fK_KothiId)
        {

            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_AdhocRequestReport", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = mode;
                scCommand.Parameters.Add("@kothiid", SqlDbType.Int, 50).Value = fK_KothiId;
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

        internal DataSet insernewrequest(string accid1, string zoneid, string wardid, string kothiid, string starterid, string driverid, string name, string mobile, string entitytypename, string entityname, string reqtype, string assignstatus, string mukadamid)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_AdhocRequestReport", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = 7;
                scCommand.Parameters.Add("@accid", SqlDbType.Int, 50).Value = Convert.ToInt16(accid1);
                scCommand.Parameters.Add("@zoneid", SqlDbType.Int, 50).Value = Convert.ToInt16(zoneid);
                scCommand.Parameters.Add("@wardid", SqlDbType.Int, 50).Value = Convert.ToInt16(wardid);
                scCommand.Parameters.Add("@kothiid", SqlDbType.Int, 50).Value = Convert.ToInt16(kothiid);
                scCommand.Parameters.Add("@mokadamid", SqlDbType.Int, 50).Value = Convert.ToInt16(mukadamid);
                scCommand.Parameters.Add("@starterid", SqlDbType.Int, 50).Value = 0;
                scCommand.Parameters.Add("@name", SqlDbType.VarChar, 100).Value = name;
                scCommand.Parameters.Add("@mobile", SqlDbType.BigInt).Value = Convert.ToInt64(mobile);
                scCommand.Parameters.Add("@entitytypename", SqlDbType.VarChar, 300).Value = entitytypename;
                scCommand.Parameters.Add("@entityname", SqlDbType.VarChar, 50).Value = entityname;
                scCommand.Parameters.Add("@reqtype", SqlDbType.VarChar, 50).Value = reqtype;
                scCommand.Parameters.Add("@supervisorId", SqlDbType.Int, 50).Value = 0;

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

        internal DataSet assignvehicle(object pk_RequestId, string vehicleid, string accid)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_AdhocRequestReport", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = 12;
                scCommand.Parameters.Add("@Pk_RequestId", SqlDbType.Int, 50).Value = pk_RequestId;
                scCommand.Parameters.Add("@vehicleid", SqlDbType.Int, 50).Value = vehicleid;
                scCommand.Parameters.Add("@accid", SqlDbType.Int, 50).Value = accid;
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

        internal DataSet getVehicle()
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_AdhocRequestReport", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = 11;
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

        internal DataSet getsupervisor()
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_AdhocRequestReport", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = 26;
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