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
    public class DalOperation : BaseData
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
                scCommand = new SqlCommand("[proc_fetchUnassignedDeviceforscs]", conn);
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

        internal DataSet GetDropdown(int v)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_RegisterDeviceforscs", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 1).Value = v;
                scCommand.Parameters.Add("@devicecompid", SqlDbType.Int, 1).Value = 1;

                
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

 

        internal DataSet GetUnassignedDevice(int mode, DateTime dateTime1, DateTime dateTime2,string imei)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand = new SqlCommand("[proc_fetchUnassignedDeviceforscs]", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 1).Value = 2;
                scCommand.Parameters.Add("@accid", SqlDbType.Int, 1).Value = 0;
                scCommand.Parameters.Add("@fromDate", SqlDbType.DateTime).Value = dateTime1;
                scCommand.Parameters.Add("@toDate", SqlDbType.DateTime).Value = dateTime2;
                scCommand.Parameters.Add("@imei", SqlDbType.BigInt).Value = imei;

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



        internal bool CheckIfDeviceExists(string imei, string sim, string vehicleName)
        {
            using (SqlCommand cmd = new SqlCommand("sp_CheckDeviceExists", conn))
            {
                try
                {
                    conn.Open();
                    cmd.CommandType = CommandType.StoredProcedure;

                    // Input parameters
                    cmd.Parameters.AddWithValue("@imei", imei);
                    cmd.Parameters.AddWithValue("@sim", sim);
                    cmd.Parameters.AddWithValue("@vehicleName", vehicleName);

                    // Output parameter
                    SqlParameter matchScoreParam = new SqlParameter("@MatchScore", SqlDbType.Int)
                    {
                        Direction = ParameterDirection.Output
                    };
                    cmd.Parameters.Add(matchScoreParam);

                    // Execute the procedure
                    cmd.ExecuteNonQuery();

                    int matchScore = (int)matchScoreParam.Value;

                    // If any one of IMEI, SIM, or VehicleName exists, restrict
                    return matchScore > 0;
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    if (conn.State == ConnectionState.Open)
                        conn.Close();
                }
            }
        }


        internal DataSet GetAdhocReqReport(short v1, short v2, DateTime dateTime1, DateTime dateTime2, string v)
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
                scCommand.Parameters.Add("@wardid", SqlDbType.BigInt, 1).Value = 0;
                scCommand.Parameters.Add("@kothiid", SqlDbType.BigInt).Value = 0;//v2;
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

        internal DataSet InsertNewDevice(string vendor,string fkWorkId, string EmploymentType, string simno, string vehiclname, string devicecompid, string versionname, string servpro, string expirydate, string cuodo, string vehiType, string fulfact, string fulsub, string fulTank, string voltageType, string instlDate, string vehicleOtherName, string pcbtype, string mileage, string fk_AccId, string hrMileage, string fuelVoltage, string imei)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_RegisterDeviceforscs", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 1).Value = 8;
                scCommand.Parameters.Add("@accid", SqlDbType.BigInt).Value = fk_AccId;
                scCommand.Parameters.Add("@devicecompid", SqlDbType.BigInt).Value = devicecompid;
                scCommand.Parameters.Add("@vendor", SqlDbType.NVarChar, 50).Value = vendor;
				        scCommand.Parameters.Add("@simno", SqlDbType.NVarChar).Value = simno;
                scCommand.Parameters.Add("@vehiclname", SqlDbType.NVarChar).Value = vehiclname;
                scCommand.Parameters.Add("@versionname", SqlDbType.NVarChar).Value = versionname;
                scCommand.Parameters.Add("@servpro", SqlDbType.NVarChar).Value = servpro;
                scCommand.Parameters.Add("@expirydate ", SqlDbType.DateTime).Value = expirydate;
                scCommand.Parameters.Add("@fk_modelId ", SqlDbType.BigInt).Value = 1;
                scCommand.Parameters.Add("@cuodo ", SqlDbType.NVarChar).Value = cuodo;
                scCommand.Parameters.Add("@vehiType ", SqlDbType.NVarChar).Value = vehiType;
                scCommand.Parameters.Add("@fulfact ", SqlDbType.NVarChar).Value = fulfact;
                scCommand.Parameters.Add("@fulsub ", SqlDbType.NVarChar).Value = fulsub;
                scCommand.Parameters.Add("@fulTank ", SqlDbType.NVarChar).Value = fulTank;
                scCommand.Parameters.Add("@voltageType ", SqlDbType.Int).Value = voltageType;
                scCommand.Parameters.Add("@InstlDate ", SqlDbType.DateTime).Value = instlDate;
                scCommand.Parameters.Add("@vehicleOtherName", SqlDbType.NVarChar).Value = vehicleOtherName;
                scCommand.Parameters.Add("@fk_AccId ", SqlDbType.BigInt).Value = fk_AccId;
                scCommand.Parameters.Add("@pcbtype ", SqlDbType.NVarChar).Value = pcbtype;
                scCommand.Parameters.Add("@Mileage ", SqlDbType.Float).Value = mileage;
                scCommand.Parameters.Add("@HrMileage ", SqlDbType.Float).Value = hrMileage;
                scCommand.Parameters.Add("@FuelVoltage ", SqlDbType.Int).Value = fuelVoltage;
                scCommand.Parameters.Add("@imei ", SqlDbType.NVarChar).Value = imei;
			        	scCommand.Parameters.Add("@fkWorkId", SqlDbType.BigInt).Value = fkWorkId;
			        	scCommand.Parameters.Add("@EmploymentType", SqlDbType.Int).Value = EmploymentType;
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

        internal DataSet GetVehicletypewiseReport(short v, DateTime dateTime1, DateTime dateTime2)
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

      
    }
}