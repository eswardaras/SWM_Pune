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
    public class DALCTPT : BaseData
    {
        internal DataSet dalGetBCAttendance(short zoneid, short wardid, short kothiid, short prabhagid, DateTime dateTime1, DateTime dateTime2)
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
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = 8;
                scCommand.Parameters.Add("@accid", SqlDbType.Int, 50).Value = 11401;
                scCommand.Parameters.Add("@ZoneId", SqlDbType.Int, 50).Value = zoneid;
                scCommand.Parameters.Add("@WardId", SqlDbType.Int, 50).Value = wardid;
                scCommand.Parameters.Add("@kothiId", SqlDbType.Int, 50).Value = kothiid;
                scCommand.Parameters.Add("@prabhagid", SqlDbType.Int, 50).Value = prabhagid;
                scCommand.Parameters.Add("@gisTypeId", SqlDbType.Int, 50).Value = 78;
                scCommand.Parameters.Add("@startdate ", SqlDbType.DateTime, 50).Value = dateTime1;
                scCommand.Parameters.Add("@enddate", SqlDbType.DateTime, 50).Value = dateTime2;

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

        internal DataSet GetMokadam()
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_CTPTInsertEdit", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = 4;
                scCommand.Parameters.Add("@Accid", SqlDbType.Int, 50).Value = 11401;
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

        internal DataSet GetFineReport(short v1, short v2, short v3, DateTime dateTime1, DateTime dateTime2)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_FineCollection", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = 4;
                scCommand.Parameters.Add("@Accid", SqlDbType.Int, 50).Value = 11401;
                scCommand.Parameters.Add("@zoneid", SqlDbType.Int, 50).Value = v1;
                scCommand.Parameters.Add("@wardid", SqlDbType.Int, 50).Value = v2;
                scCommand.Parameters.Add("@fk_finetypeid", SqlDbType.Int, 50).Value = v3;
                scCommand.Parameters.Add("@startdate", SqlDbType.DateTime).Value = dateTime1;
                scCommand.Parameters.Add("@enddate", SqlDbType.DateTime).Value = dateTime2;
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

        internal DataSet GetFineType()
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_FineCollection", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = 3;
                scCommand.Parameters.Add("@Accid", SqlDbType.Int, 50).Value = 11401;
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

        internal DataSet GetDSI()
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_CTPTInsertEdit", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = 6;
                scCommand.Parameters.Add("@Accid", SqlDbType.Int, 50).Value = 11401;
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

        internal DataSet GetFineoffender(short v, int v1)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_FineCollection", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = v1;
                scCommand.Parameters.Add("@Accid", SqlDbType.Int, 50).Value = 0;
                scCommand.Parameters.Add("@pk_FineId", SqlDbType.Int, 50).Value = Convert.ToInt16(v);
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

        internal DataSet GetEditData(object v)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_CTPTInsertEdit", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = 8;
                scCommand.Parameters.Add("@Accid", SqlDbType.Int, 50).Value = 11401;
                scCommand.Parameters.Add("@pk_id", SqlDbType.Int, 50).Value = Convert.ToInt16(v);
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

        internal DataSet deletedata(object v)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();

                scCommand = new SqlCommand("proc_CTPTInsertEdit", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = 11;
                scCommand.Parameters.Add("@pk_id", SqlDbType.Int, 50).Value = Convert.ToInt16(v);
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

        internal DataSet updaterequest(string accid1, string zoneid, string wardid, string kothiid, string typeid, string name, string lon, string lat, string address, string mokadum, string dsi, string sI, string nos, object v)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();

                scCommand = new SqlCommand("proc_CTPTInsertEdit", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = 10;
                scCommand.Parameters.Add("@Accid", SqlDbType.Int, 50).Value = 11401;
                scCommand.Parameters.Add("@zoneid", SqlDbType.Int, 50).Value = Convert.ToInt16(zoneid);
                scCommand.Parameters.Add("@wardid", SqlDbType.Int, 50).Value = Convert.ToInt16(wardid);
                scCommand.Parameters.Add("@Kothiid", SqlDbType.Int, 50).Value = Convert.ToInt16(kothiid);
                scCommand.Parameters.Add("@typeid", SqlDbType.Int, 50).Value = Convert.ToInt16(typeid);
                scCommand.Parameters.Add("@name", SqlDbType.VarChar, 50).Value = name;
                scCommand.Parameters.Add("@Long", SqlDbType.Decimal).Value = Convert.ToDouble(lon);
                scCommand.Parameters.Add("@lat", SqlDbType.Decimal).Value = Convert.ToDouble(lat);
                scCommand.Parameters.Add("@Address", SqlDbType.VarChar, 500).Value = address;
                scCommand.Parameters.Add("@mokadum", SqlDbType.VarChar, 100).Value = Convert.ToString(mokadum);
                scCommand.Parameters.Add("@dsi", SqlDbType.VarChar, 100).Value = Convert.ToString(dsi);
                scCommand.Parameters.Add("@SI", SqlDbType.VarChar, 100).Value = Convert.ToString(sI);
                scCommand.Parameters.Add("@nos", SqlDbType.Int, 50).Value = Convert.ToInt16(nos);
                scCommand.Parameters.Add("@pk_id", SqlDbType.Int, 50).Value = Convert.ToInt16(v);
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

        internal DataSet insernewrequest(string accid1, string zoneid, string wardid, string kothiid, string typeid, string name, string lon, string lat, string address, string mokadum, string dsi, string sI, string nos)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_CTPTInsertEdit", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = 9;
                scCommand.Parameters.Add("@Accid", SqlDbType.Int, 50).Value = 11401;
                scCommand.Parameters.Add("@zoneid", SqlDbType.Int, 50).Value = Convert.ToInt16(zoneid);
                scCommand.Parameters.Add("@wardid", SqlDbType.Int, 50).Value = Convert.ToInt16(wardid);
                scCommand.Parameters.Add("@Kothiid", SqlDbType.Int, 50).Value = Convert.ToInt16(kothiid);
                scCommand.Parameters.Add("@typeid", SqlDbType.Int, 50).Value = Convert.ToInt16(typeid);
                scCommand.Parameters.Add("@name", SqlDbType.VarChar, 50).Value = name;
                scCommand.Parameters.Add("@Long", SqlDbType.Decimal).Value = Convert.ToDouble(lon);
                scCommand.Parameters.Add("@lat", SqlDbType.Decimal).Value = Convert.ToDouble(lat);
                scCommand.Parameters.Add("@Address", SqlDbType.VarChar, 500).Value = address;
                scCommand.Parameters.Add("@mokadum", SqlDbType.Int, 50).Value = Convert.ToInt16(mokadum);
                scCommand.Parameters.Add("@dsi", SqlDbType.Int, 50).Value = Convert.ToInt16(dsi);
                scCommand.Parameters.Add("@SI", SqlDbType.Int, 50).Value = Convert.ToInt16(sI);
                scCommand.Parameters.Add("@nos", SqlDbType.Int, 50).Value = Convert.ToInt16(nos);
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

        internal DataSet GetGridData()
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_CTPTInsertEdit", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = 8;
                scCommand.Parameters.Add("@Accid", SqlDbType.Int, 50).Value = 11401;
                scCommand.Parameters.Add("@zoneid", SqlDbType.Int, 50).Value = 0;
                scCommand.Parameters.Add("@wardid", SqlDbType.Int, 50).Value = 0;
                scCommand.Parameters.Add("@Kothiid", SqlDbType.Int, 50).Value = 0;
                scCommand.Parameters.Add("@pk_id", SqlDbType.Int, 50).Value = 0;
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

        internal DataSet GetSI()
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_CTPTInsertEdit", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = 5;
                scCommand.Parameters.Add("@Accid", SqlDbType.Int, 50).Value = 11401;
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

        internal DataSet GetWard(int mode, int v)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_CTPTAssigned", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = 2;
                scCommand.Parameters.Add("@fk_accid", SqlDbType.Int, 50).Value = 11401;
                scCommand.Parameters.Add("@fk_zoneid", SqlDbType.Int, 50).Value = v;
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

        internal DataSet GetCTPTAssignReport(short v1, short v2)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_CTPTAssigned", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = 3;
                scCommand.Parameters.Add("@fk_accid", SqlDbType.Int, 50).Value = 11401;
                scCommand.Parameters.Add("@fk_zoneid", SqlDbType.Int, 50).Value = v1;
                scCommand.Parameters.Add("@fk_wardid", SqlDbType.Int, 50).Value = v2;
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

        internal List<DataSet> GetCTPTDailyCheckinReport(short v1, short v2, short v3, short v4, DateTime dateTime1, DateTime dateTime2)
        {
            DataSet dataSet1 = new DataSet();
            DataSet dataSet2 = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand.CommandTimeout = 1000;
                scCommand = new SqlCommand("proc_CTPTDailyChecking", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = 5;
                scCommand.Parameters.Add("@accid", SqlDbType.Int, 50).Value = 11401;
                scCommand.Parameters.Add("@ZoneId", SqlDbType.Int, 50).Value = v1;
                scCommand.Parameters.Add("@WardId", SqlDbType.Int, 50).Value = v2;
                scCommand.Parameters.Add("@kothiId", SqlDbType.Int, 50).Value = v3;
                scCommand.Parameters.Add("@blocktypeid", SqlDbType.Int, 50).Value = v4;
                scCommand.Parameters.Add("@fromdate ", SqlDbType.DateTime, 50).Value = dateTime1;
                scCommand.Parameters.Add("@todate", SqlDbType.DateTime, 50).Value = dateTime2;

                scCommand.CommandType = CommandType.StoredProcedure;

                Sda.SelectCommand = scCommand;
                scCommand.CommandTimeout = 600;
                Sda.Fill(dataSet1);

                scCommand = new SqlCommand("proc_CTPTDailyChecking", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = 11;
                scCommand.Parameters.Add("@accid", SqlDbType.Int, 50).Value = 11401;
                scCommand.Parameters.Add("@ZoneId", SqlDbType.Int, 50).Value = v1;
                scCommand.Parameters.Add("@WardId", SqlDbType.Int, 50).Value = v2;
                scCommand.Parameters.Add("@kothiId", SqlDbType.Int, 50).Value = v3;
                scCommand.Parameters.Add("@blocktypeid", SqlDbType.Int, 50).Value = v4;
                scCommand.Parameters.Add("@fromdate ", SqlDbType.DateTime, 50).Value = dateTime1;
                scCommand.Parameters.Add("@todate", SqlDbType.DateTime, 50).Value = dateTime2;

                scCommand.CommandType = CommandType.StoredProcedure;

                Sda.SelectCommand = scCommand;
                scCommand.CommandTimeout = 600;
                Sda.Fill(dataSet2);

                List<DataSet> result = new List<DataSet>();
                result.Add(dataSet1);
                result.Add(dataSet2);
                return result;

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