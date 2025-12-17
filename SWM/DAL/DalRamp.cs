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
    public class DalRamp : BaseData
    {
        DataTable dt = new DataTable();
        SqlDataAdapter Sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();


  

        internal DataSet GetReport(object rampid, DateTime v2, DateTime v3)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_DayWiseWeight", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 1).Value = 2;
                scCommand.Parameters.Add("@rampid", SqlDbType.Int, 1).Value = rampid;
                scCommand.Parameters.Add("@date1", SqlDbType.DateTime, 1).Value = v2;
                scCommand.Parameters.Add("@date2", SqlDbType.DateTime, 1).Value = v3;

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

        internal DataSet GetAdhocReqReport(short v1, short v3, short v2, DateTime dateTime1, DateTime dateTime2, string v)
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
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 1).Value = v == "C & D Waste" ? 30 :29;
                scCommand.Parameters.Add("@zoneid", SqlDbType.BigInt).Value = v1;
                scCommand.Parameters.Add("@wardid", SqlDbType.BigInt, 1).Value =  v3;
                scCommand.Parameters.Add("@kothiid", SqlDbType.BigInt).Value = v2;//v2;
                scCommand.Parameters.Add("@accid", SqlDbType.BigInt).Value = 11401;
                scCommand.Parameters.Add("@sdate", SqlDbType.DateTime, 1).Value = dateTime1;
                scCommand.Parameters.Add("@edate", SqlDbType.DateTime, 1).Value = dateTime2;

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

        internal DataSet GetRampPlant(object mode, object vehicleId, object accId)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_VehicleDayWiseWeightMIS", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 1).Value = 11;

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

        internal DataSet GetPlant(int v1, int v2, int v3)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_RampDashboard", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 1).Value = 111;

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

        internal DataSet GetTripReport(short v1, short v2, short v3, DateTime dateTime1, DateTime dateTime2 )
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_TripReportForCandDaandSpecialWaste", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 1).Value = 4;
                scCommand.Parameters.Add("@accid", SqlDbType.Int, 1).Value = 11401;
                scCommand.Parameters.Add("@sdate", SqlDbType.DateTime, 1).Value = dateTime1;
                scCommand.Parameters.Add("@edate", SqlDbType.DateTime, 1).Value = dateTime2;
                scCommand.Parameters.Add("@zoneid", SqlDbType.BigInt).Value = v1;
                scCommand.Parameters.Add("@wardid", SqlDbType.BigInt).Value = v2;
                scCommand.Parameters.Add("@kothiid", SqlDbType.BigInt).Value = v3;

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

        internal DataSet GetOnlyplantReport(int v, DateTime dateTime1, DateTime dateTime2)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_IncomingTransaction", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 1).Value = 222;
                scCommand.Parameters.Add("@rampid", SqlDbType.Int, 1).Value = v;
                scCommand.Parameters.Add("@date1", SqlDbType.DateTime, 1).Value = dateTime1;
                scCommand.Parameters.Add("@date2", SqlDbType.DateTime, 1).Value = dateTime2;

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

        internal DataSet GetAdhoc(string v = null)
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
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 1).Value = 27;
                scCommand.Parameters.Add("@sdate", SqlDbType.DateTime, 1).Value = DateTime.Now.Date;
                scCommand.Parameters.Add("@edate", SqlDbType.DateTime, 1).Value = DateTime.Now.Date;
                scCommand.Parameters.Add("@reqtype", SqlDbType.VarChar, 30).Value = v == null ? "Special-Waste" :v;

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

        internal DataSet GetVehicleReport(int v, DateTime dateTime1, DateTime dateTime2)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_VehicleDayWiseWeightMIS", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 1).Value = 2;
                scCommand.Parameters.Add("@rampid", SqlDbType.Int, 1).Value = v;
                scCommand.Parameters.Add("@date1", SqlDbType.DateTime, 1).Value = dateTime1;
                scCommand.Parameters.Add("@date2", SqlDbType.DateTime, 1).Value = dateTime2;

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

        internal DataSet GetVehicletypewiseReport(int v, DateTime dateTime1, DateTime dateTime2)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_IncomingTransaction", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 1).Value = 2;
                scCommand.Parameters.Add("@rampid", SqlDbType.Int, 1).Value = v;
                scCommand.Parameters.Add("@date1", SqlDbType.DateTime, 1).Value = dateTime1;
                scCommand.Parameters.Add("@date2", SqlDbType.DateTime, 1).Value = dateTime2;

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

        internal DataSet GetVehicletripReport(short v, DateTime dateTime1, DateTime dateTime2)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_VehicleDayWiseTripsMIS", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 1).Value = 2;
                scCommand.Parameters.Add("@rampid", SqlDbType.Int, 1).Value = v;
                scCommand.Parameters.Add("@date1", SqlDbType.DateTime, 1).Value = dateTime1;
                scCommand.Parameters.Add("@date2", SqlDbType.DateTime, 1).Value = dateTime2;

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

        internal DataSet GetPlantReport(short v, DateTime dateTime1, DateTime dateTime2)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_IncomingTransaction", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 1).Value = 2;
                scCommand.Parameters.Add("@rampid", SqlDbType.Int, 1).Value = v;
                scCommand.Parameters.Add("@date1", SqlDbType.DateTime, 1).Value = dateTime1;
                scCommand.Parameters.Add("@date2", SqlDbType.DateTime, 1).Value = dateTime2;

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

        internal DataSet GetRamp(int mode, int vehicleId, int accId)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_RampDashboard", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 1).Value = 1;

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

        internal DataSet GetRampLastDataEntry()
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand = new SqlCommand("Sp_RampLastDataEntry", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                
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

        internal DataSet GetSweeperDetails()
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_myvehiclescs", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 1).Value = 3;
                scCommand.Parameters.Add("@accid", SqlDbType.Int, 1).Value = 11401;

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

        internal DataSet GetVehiclewiseTripReport(int v, DateTime dateTime1, DateTime dateTime2)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_VehicleDayWiseTripsMIS", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 1).Value = 2;
                scCommand.Parameters.Add("@rampid", SqlDbType.Int, 1).Value = v;
                scCommand.Parameters.Add("@date1", SqlDbType.DateTime, 1).Value = dateTime1;
                scCommand.Parameters.Add("@date2", SqlDbType.DateTime, 1).Value = dateTime2;

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