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
    public class HHComercialDAL : BaseData
    {
        private DataTable dt;

        public SqlDataAdapter Sda { get; private set; }

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
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = 8;//8;
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

        internal DataSet dalgetroute(short v1, short v2,DateTime s1, DateTime e1)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand = new SqlCommand("Proc_SweepersGroupMap", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = 4; 
                scCommand.Parameters.Add("@sDate", SqlDbType.DateTime).Value = s1;
                scCommand.Parameters.Add("@eDate", SqlDbType.DateTime).Value = e1;
                scCommand.Parameters.Add("@FK_SweeperId", SqlDbType.Int, 50).Value = v1;

                //scCommand.Parameters.Add("@FK_SweeperId", SqlDbType.Int, 50).Value = v1;

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

        internal DataSet getfeederlocation(short v, DateTime dateTime)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_VehicleMapwithRoute", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = 67;
                scCommand.Parameters.Add("@RouteId", SqlDbType.Int, 50).Value = 0;
                scCommand.Parameters.Add("@FK_VehicleID", SqlDbType.Int, 50).Value = v;
                scCommand.Parameters.Add("@startdate ", SqlDbType.DateTime, 50).Value = dateTime;
    

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

        internal DataSet GetCWReport(short v1, short v2, short v3, DateTime dateTime1, DateTime dateTime2, short v4)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_CollectionRouteCoverageReport", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = 4;
                scCommand.Parameters.Add("@accid", SqlDbType.Int, 50).Value = 11401;
                scCommand.Parameters.Add("@ZoneId", SqlDbType.Int, 50).Value = v1;
                scCommand.Parameters.Add("@WardId", SqlDbType.Int, 50).Value = v2;
                scCommand.Parameters.Add("@kothiId", SqlDbType.Int, 50).Value = v3;
                scCommand.Parameters.Add("@startdate ", SqlDbType.DateTime, 50).Value = dateTime1;
                scCommand.Parameters.Add("@enddate", SqlDbType.DateTime, 50).Value = dateTime2;
                scCommand.Parameters.Add("@prabhagId", SqlDbType.Int, 50).Value = v4;

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

        internal DataSet getKothiradiusroute(string v)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_VehicleMapwithRoute", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = 51;
                scCommand.Parameters.Add("@fk_accid", SqlDbType.Int, 50).Value = 0;
                scCommand.Parameters.Add("@GeoName", SqlDbType.VarChar, 50).Value = v;


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

        internal DataSet getpolygon(short v1, short v2)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();

            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_VehicleMapwithRoute", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = 66;
                scCommand.Parameters.Add("@Fk_accid", SqlDbType.Int, 50).Value = 11401;
                scCommand.Parameters.Add("@routeid", SqlDbType.Int, 50).Value = v2;
                scCommand.Parameters.Add("@FK_VehicleID", SqlDbType.Int, 50).Value = v1;


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