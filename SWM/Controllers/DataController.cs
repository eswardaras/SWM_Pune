using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Security.Policy;
using System.Web.Http;
using static System.Net.Mime.MediaTypeNames;

namespace SWM.Controllers
{
    public class DataController : ApiController
    {
        string connnString = "Data Source = con.iswmpune.in; Initial Catalog = SWMSystem; User ID = webadmin; Password = Admin@123!@#; Connect Timeout = 99999; ";
        #region Master Dashboard
        //Example Chart Data - Eswar
        [HttpGet]
        [Route("api/chartdata")]
        [AllowAnonymous]
        public IHttpActionResult GetChartData()
        {
            try
            {

                DataSet dsAllData = new DataSet();

                // -------- Database Call --------
                using (SqlConnection con = new SqlConnection(connnString))
                {
                    SqlCommand cmd = new SqlCommand("proc_MainDashboard_python", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@mode", SqlDbType.Int).Value = 24;
                    cmd.Parameters.Add("@STARTDATE", SqlDbType.DateTime).Value = "2025-11-09";
                    cmd.Parameters.Add("@ENDDATE", SqlDbType.DateTime).Value = "2025-11-09";
                    cmd.Parameters.Add("@zoneid", SqlDbType.Int).Value = 0;
                    cmd.Parameters.Add("@AccId", SqlDbType.Int).Value = 11401;

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dsAllData);
                }

                // -------- Data Processing --------
                var labels = new List<string>();
                var values = new List<decimal>();

                if (dsAllData.Tables.Count > 2)
                {
                    foreach (DataRow row in dsAllData.Tables[2].Rows)
                    {
                        string zoneName = row[0].ToString();
                        string percentStr = row[9].ToString().Replace("%", "");

                        decimal pct = 0;
                        decimal.TryParse(percentStr, out pct);

                        labels.Add(zoneName);
                        values.Add(pct);
                    }
                }

                // -------- API JSON Response --------
                var response = new
                {
                    labels = labels,
                    values = values
                };
                return Ok(response);
            }
            catch (Exception ex)
            {
                return Ok(ex);
            }
            // Automatically converts to JSON
        }


        //API's Done by Tej & Ravi

        //Sweeper Beat Coverage - Pie Chart
        [HttpGet]
        [Route("api/SweeperBeatCoverage")]
        [AllowAnonymous]
        public IHttpActionResult GetSweeperBeatCoverage()
        {

            DataSet dsAllData = new DataSet();

            // -------- Database Call --------
            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("proc_MainDashboard_python", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@mode", SqlDbType.Int).Value = 3321;
                cmd.Parameters.Add("@STARTDATE", SqlDbType.DateTime).Value = "2025-11-09";
                cmd.Parameters.Add("@ENDDATE", SqlDbType.DateTime).Value = "2025-11-09";
                cmd.Parameters.Add("@zoneid", SqlDbType.Int).Value = 0;
                cmd.Parameters.Add("@fkId", SqlDbType.Int).Value = 11401;
                cmd.CommandTimeout = 300; // 5 minutes

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.SelectCommand.CommandTimeout = 300;
                
                da.Fill(dsAllData);
            }

            // -------- Data Processing --------
            var labels = new List<string>();
            var values = new List<decimal>();

            if (dsAllData.Tables.Count > 0 && dsAllData.Tables[0].Rows.Count > 0)
            {
                DataTable dt = dsAllData.Tables[0];
                int total = dt.AsEnumerable().Sum(r => Convert.ToInt32(r["SWEEPER_BEAT_COV"]));
                foreach (DataRow row in dt.Rows)
                {
                    string SW_BEAT_COV = row["SW_BEAT_COV"].ToString();
                    int count = Convert.ToInt32(row["SWEEPER_BEAT_COV"]);

                    //string percentStr = row[1].ToString().Replace("%", "");

                    decimal pct = Math.Round((decimal)count * 100 / total, 1);
                    //decimal.TryParse(percentStr, out pct);

                    labels.Add(SW_BEAT_COV);
                    values.Add(pct);
                }
            }

            // -------- API JSON Response --------
            var response = new
            {
                labels = labels,
                values = values
            };

            return Ok(response);  // Automatically converts to JSON
        }

        //Sweeper Beat Coverage Bar Chart
        [HttpGet]
        [Route("api/SweeperBeatCoverageKM")]
        [AllowAnonymous]
        public IHttpActionResult GetSweeperBeatCoverageKM()
        {

            DataSet dsAllData = new DataSet();

            // -------- Database Call --------
            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("proc_MainDashboard_python", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@mode", SqlDbType.Int).Value = 3311;
                cmd.Parameters.Add("@STARTDATE", SqlDbType.DateTime).Value = "2025-12-11";
                cmd.Parameters.Add("@ENDDATE", SqlDbType.DateTime).Value = "2025-12-11";
                cmd.Parameters.Add("@zoneid", SqlDbType.Int).Value = 0;
                cmd.Parameters.Add("@fkId", SqlDbType.Int).Value = 11401;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dsAllData);
            }

            // -------- Data Processing --------
            var labels = new List<string>();
            var values = new List<decimal>();

            if (dsAllData.Tables.Count > 0 && dsAllData.Tables[0].Rows.Count > 0)
            {
                DataRow row = dsAllData.Tables[0].Rows[0];

                labels.Add("COVERED");
                values.Add(row["COVERED"] == DBNull.Value ? 0 : Convert.ToDecimal(row["COVERED"]));

                labels.Add("UNCOVER");
                values.Add(row["UNCOVER"] == DBNull.Value ? 0 : Convert.ToDecimal(row["UNCOVER"]));

                labels.Add("UNCOVER DUE TO ROUTE DEVIATED");
                values.Add(row["UNCOVER DUE TO ROUTE DEVIATED"] == DBNull.Value ? 0 : Convert.ToDecimal(row["UNCOVER DUE TO ROUTE DEVIATED"]));

                labels.Add("UNCOVER DUE TO ABSENT");
                values.Add(row["UNCOVER DUE TO ABSENT"] == DBNull.Value ? 0 : Convert.ToDecimal(row["UNCOVER DUE TO ABSENT"]));
            }


            // -------- API JSON Response --------
            var response = new
            {
                labels = labels,
                values = values
            };

            return Ok(response);  // Automatically converts to JSON
        }
        //MAIN DASHBOARD CWAttendance Chart
        [HttpGet]
        [Route("api/CWAttendance")]
        [AllowAnonymous]
        public IHttpActionResult GetCWAttendance()
        {

            DataSet dsAllData = new DataSet();

            // -------- Database Call --------
            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("proc_MainDashboard_python", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@mode", SqlDbType.Int).Value = 4;
                cmd.Parameters.Add("@STARTDATE", SqlDbType.DateTime).Value = "2025-12-11";
                cmd.Parameters.Add("@ENDDATE", SqlDbType.DateTime).Value = "2025-12-11";
                //cmd.Parameters.Add("@zoneid", SqlDbType.Int).Value = 0;
                cmd.Parameters.Add("@AccId", SqlDbType.Int).Value = 11401;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dsAllData);
            }

            // -------- Data Processing --------
            var labels = new List<string>();
            var values = new List<decimal>();

            int total = 0, present = 0, absent = 0, ping = 0;

            if (dsAllData.Tables.Count > 0)
            {
                DataRow row = dsAllData.Tables[1].Rows[0];

                total = row["Total"] == DBNull.Value ? 0 : Convert.ToInt32(row["Total"]);
                present = row["Present"] == DBNull.Value ? 0 : Convert.ToInt32(row["Present"]);
                absent = row["Absent"] == DBNull.Value ? 0 : Convert.ToInt32(row["Absent"]);

                // If stored procedure returns PING column
                if (dsAllData.Tables[0].Columns.Contains("Ping"))
                    ping = row["Ping"] == DBNull.Value ? 0 : Convert.ToInt32(row["Ping"]);

                // Construct labels and values
                labels.Add("ABSENT");
                labels.Add("PRESENT");
                labels.Add("PING");
                values.Add(absent);
                values.Add(present);
                values.Add(ping);

            }

            return Ok(new
            {
                labels = labels,
                values = values
            });
        }
        //MAIN DASHBOARD CTPT Chart

        [HttpGet]
        [Route("api/CTPT")]
        [AllowAnonymous]
        public IHttpActionResult GetCTPT()
        {

            DataSet dsAllData = new DataSet();

            // -------- Database Call --------
            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("proc_MainDashboard_python", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@mode", SqlDbType.Int).Value = 39;
                cmd.Parameters.Add("@STARTDATE", SqlDbType.DateTime).Value = "2025-12-12";
                cmd.Parameters.Add("@ENDDATE", SqlDbType.DateTime).Value = "2025-12-12";
                //cmd.Parameters.Add("@zoneid", SqlDbType.Int).Value = 0;
                cmd.Parameters.Add("@AccId", SqlDbType.Int).Value = 11401;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dsAllData);
            }

            // -------- Data Processing --------
            var labels = new List<string>();
            var values = new List<decimal>();

            if (dsAllData.Tables.Count > 0 && dsAllData.Tables[0].Rows.Count > 0)
            {
                DataRow row = dsAllData.Tables[0].Rows[0];

                // ----------- CT -----------
                decimal ctTotal = row["CTTotal"] == DBNull.Value ? 0 : Convert.ToDecimal(row["CTTotal"]);
                decimal ctCover = row["CTCover"] == DBNull.Value ? 0 : Convert.ToDecimal(row["CTCover"]);
                decimal ctUncover = row["CTUnCover"] == DBNull.Value ? 0 : Convert.ToDecimal(row["CTUnCover"]);

                decimal ctCoverPct = ctTotal == 0 ? 0 : Math.Round((ctCover / ctTotal) * 100, 1);
                decimal ctUncoverPct = ctTotal == 0 ? 0 : Math.Round((ctUncover / ctTotal) * 100, 1);

                labels.Add("CT Covered");
                values.Add(ctCoverPct);

                labels.Add("CT Uncovered");
                values.Add(ctUncoverPct);

                // ----------- PT -----------
                decimal ptTotal = row["PTTotal"] == DBNull.Value ? 0 : Convert.ToDecimal(row["PTTotal"]);
                decimal ptCover = row["PTCover"] == DBNull.Value ? 0 : Convert.ToDecimal(row["PTCover"]);
                decimal ptUncover = row["PTUnCover"] == DBNull.Value ? 0 : Convert.ToDecimal(row["PTUnCover"]);

                decimal ptCoverPct = ptTotal == 0 ? 0 : Math.Round((ptCover / ptTotal) * 100, 1);
                decimal ptUncoverPct = ptTotal == 0 ? 0 : Math.Round((ptUncover / ptTotal) * 100, 1);

                labels.Add("PT Covered");
                values.Add(ptCoverPct);

                labels.Add("PT Uncovered");
                values.Add(ptUncoverPct);

                // ----------- URINALS -----------
                decimal urTotal = row["UrinalTotal"] == DBNull.Value ? 0 : Convert.ToDecimal(row["UrinalTotal"]);
                decimal urCover = row["UrinalCover"] == DBNull.Value ? 0 : Convert.ToDecimal(row["UrinalCover"]);
                decimal urUncover = row["UrinalUnCover"] == DBNull.Value ? 0 : Convert.ToDecimal(row["UrinalUnCover"]);

                decimal urCoverPct = urTotal == 0 ? 0 : Math.Round((urCover / urTotal) * 100, 1);
                decimal urUncoverPct = urTotal == 0 ? 0 : Math.Round((urUncover / urTotal) * 100, 1);

                labels.Add("Urinal Covered");
                values.Add(urCoverPct);

                labels.Add("Urinal Uncovered");
                values.Add(urUncoverPct);
            }

            return Ok(new
            {
                labels = labels,
                values = values
            });

        }

        //NEWLY ADDED ON 15.12.2025
        // Main DASHBOARD COLLECTION Pocket

        [HttpGet]
        [Route("api/CollectionWorkerPocket")]
        [AllowAnonymous]
        public IHttpActionResult GetCollectionWorkerPocket()
        {

            DataSet dsAllData = new DataSet();

            // -------- Database Call --------
            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("proc_MainDashboard_python", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@mode", SqlDbType.Int).Value = 23;
                cmd.Parameters.Add("@startdate", SqlDbType.DateTime).Value = "2025-12-12";
                cmd.Parameters.Add("@enddate", SqlDbType.DateTime).Value = "2025-12-12";
                cmd.Parameters.Add("@zoneid", SqlDbType.Int).Value = 0;
                cmd.Parameters.Add("@AccId", SqlDbType.Int).Value = 11401;

                cmd.CommandTimeout = 300; // 5 minutes

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.SelectCommand.CommandTimeout = 300;

                //DataSet ds = new DataSet();
                da.Fill(dsAllData);
            }

            // -------- Data Processing --------
            var labels = new List<string>();
            var parents = new List<string>();
            var values = new List<decimal>();

            if (dsAllData.Tables.Count > 0 && dsAllData.Tables[1].Rows.Count > 0)
            {
                DataRow row = dsAllData.Tables[1].Rows[0];

                // -------- TOTAL COUNTS --------
                decimal totalDTDC = Convert.ToDecimal(row["TotalDTDC"] == DBNull.Value ? 0 : row["TotalDTDC"]);
                decimal coverDTDC = Convert.ToDecimal(row["CoverDTDC"] == DBNull.Value ? 0 : row["CoverDTDC"]);
                decimal uncoverDTDC = Convert.ToDecimal(row["UnCoverDTDC"] == DBNull.Value ? 0 : row["UnCoverDTDC"]);

                decimal totalComm = Convert.ToDecimal(row["TotalCommertial"] == DBNull.Value ? 0 : row["TotalCommertial"]);
                decimal coverComm = Convert.ToDecimal(row["CoverCommertial"] == DBNull.Value ? 0 : row["CoverCommertial"]);
                decimal uncoverComm = Convert.ToDecimal(row["UnCoverCommertial"] == DBNull.Value ? 0 : row["UnCoverCommertial"]);

                decimal totalSlum = Convert.ToDecimal(row["TotalSlum"] == DBNull.Value ? 0 : row["TotalSlum"]);
                decimal coverSlum = Convert.ToDecimal(row["CoverSlum"] == DBNull.Value ? 0 : row["CoverSlum"]);
                decimal uncoverSlum = Convert.ToDecimal(row["UnCoverSlum"] == DBNull.Value ? 0 : row["UnCoverSlum"]);

                decimal totalGate = Convert.ToDecimal(row["TotalGetCollection"] == DBNull.Value ? 0 : row["TotalGetCollection"]);
                decimal coverGate = Convert.ToDecimal(row["CoverGetCollection"] == DBNull.Value ? 0 : row["CoverGetCollection"]);
                decimal uncoverGate = Convert.ToDecimal(row["UnCoverGetCollection"] == DBNull.Value ? 0 : row["UnCoverGetCollection"]);

                decimal totalSRA = Convert.ToDecimal(row["TotalSRA"] == DBNull.Value ? 0 : row["TotalSRA"]);
                decimal coverSRA = Convert.ToDecimal(row["CoverSRA"] == DBNull.Value ? 0 : row["CoverSRA"]);
                decimal uncoverSRA = Convert.ToDecimal(row["UnCoverSRA"] == DBNull.Value ? 0 : row["UnCoverSRA"]);

                decimal grandTotal =
                    totalDTDC + totalComm + totalSlum + totalGate + totalSRA;

                // -------- INNER RING --------
                labels.Add("DTDC"); parents.Add(""); values.Add(totalDTDC);
                labels.Add("Commercial"); parents.Add(""); values.Add(totalComm);
                labels.Add("Slum"); parents.Add(""); values.Add(totalSlum);
                labels.Add("Gate Collection"); parents.Add(""); values.Add(totalGate);
                labels.Add("SRA"); parents.Add(""); values.Add(totalSRA);

                // -------- OUTER RING (DTDC) --------
                labels.Add("Covered"); parents.Add("DTDC"); values.Add(coverDTDC);
                labels.Add("Uncovered"); parents.Add("DTDC"); values.Add(uncoverDTDC);

                // -------- Commercial --------
                labels.Add("Covered"); parents.Add("Commercial"); values.Add(coverComm);
                labels.Add("Uncovered"); parents.Add("Commercial"); values.Add(uncoverComm);

                // -------- Slum --------
                labels.Add("Covered"); parents.Add("Slum"); values.Add(coverSlum);
                labels.Add("Uncovered"); parents.Add("Slum"); values.Add(uncoverSlum);

                // -------- Gate Collection --------
                labels.Add("Covered"); parents.Add("Gate Collection"); values.Add(coverGate);
                labels.Add("Uncovered"); parents.Add("Gate Collection"); values.Add(uncoverGate);

                // -------- SRA --------
                labels.Add("Covered"); parents.Add("SRA"); values.Add(coverSRA);
                labels.Add("Uncovered"); parents.Add("SRA"); values.Add(uncoverSRA);
            }

            return Ok(new
            {
                labels,
                parents,
                values
            });


        }

        //MAIN DASHBOARD VehicleStatus Chart
        [HttpGet]
        [Route("api/VehicleStatus")]
        [AllowAnonymous]
        public IHttpActionResult VehicleStatus()
        {



            DataSet dsAllData = new DataSet();

            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("Proc_VehicleMap_1", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@mode", SqlDbType.Int).Value = 14;
                //cmd.Parameters.Add("@STARTDATE", SqlDbType.DateTime).Value = "2025-11-10";
                //cmd.Parameters.Add("@ENDDATE", SqlDbType.DateTime).Value = "2025-11-10";
                cmd.Parameters.Add("@zoneid", SqlDbType.Int).Value = 0;
                cmd.Parameters.Add("@wardID", SqlDbType.Int).Value = 0;
                cmd.Parameters.Add("@RoleID", SqlDbType.Int).Value = 4;
                cmd.Parameters.Add("@UserId", SqlDbType.Int).Value = 11401;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dsAllData);
            }

            // ------------------------------------------------------------------
            // TABLE 0 : Vehicle level rows (ZoneName + LstRunIdletime)
            // ------------------------------------------------------------------

            var labels = new List<string>();
            var values = new List<decimal>();

            // Read Zone wise Vehicle Status table
            if (dsAllData.Tables.Count > 1 && dsAllData.Tables[1].Rows.Count > 0)
            {
                DataRow row = dsAllData.Tables[1].Rows[0];

                decimal idle = row["Idle"] == DBNull.Value ? 0 : Convert.ToDecimal(row["Idle"]);
                decimal running = row["Running"] == DBNull.Value ? 0 : Convert.ToDecimal(row["Running"]);
                decimal inactive = row["InActive"] == DBNull.Value ? 0 : Convert.ToDecimal(row["InActive"]);
                decimal breakdown = row["Breakdown"] == DBNull.Value ? 0 : Convert.ToDecimal(row["Breakdown"]);
                decimal powercut = row["Powercut"] == DBNull.Value ? 0 : Convert.ToDecimal(row["Powercut"]);

                labels.Add("Idle");
                values.Add(idle);

                labels.Add("Running");
                values.Add(running);

                labels.Add("InActive");
                values.Add(inactive);

                labels.Add("Breakdown");
                values.Add(breakdown);

                labels.Add("Powercut");
                values.Add(powercut);
            }

            return Ok(new
            {
                labels = labels,
                values = values
            });
        }

        //MAIN DASHBOARD FeederCoverage Chart
        [HttpGet]
        [Route("api/FeederCoverage")]
        [AllowAnonymous]
        public IHttpActionResult GetFeederCoverage()
        {

            DataSet dsAllData = new DataSet();

            // -------- Database Call --------
            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("sp_FEEDER_REPORT", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@mode", SqlDbType.Int).Value = 1;
                //cmd.Parameters.Add("@fkid", SqlDbType.Int).Value = 11401;
                cmd.Parameters.Add("@startdate", SqlDbType.DateTime).Value = "2025-12-09";
                cmd.Parameters.Add("@enddate", SqlDbType.DateTime).Value = "2025-12-09";


                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dsAllData);
            }

            var zoneMap = new Dictionary<string, (int cover, int uncover, int unattended)>();

            DataTable dt = dsAllData.Tables[0];

            foreach (DataRow row in dt.Rows)
            {
                string zone = row["ZONE"].ToString();

                int cover = row["COVER_FEEDER"] == DBNull.Value ? 0 : Convert.ToInt32(row["COVER_FEEDER"]);
                int uncover = row["UNCOVER_FEEDER"] == DBNull.Value ? 0 : Convert.ToInt32(row["UNCOVER_FEEDER"]);
                int unattended = row["UNATTENDED_FEEDER"] == DBNull.Value ? 0 : Convert.ToInt32(row["UNATTENDED_FEEDER"]);

                if (!zoneMap.ContainsKey(zone))
                {
                    zoneMap[zone] = (0, 0, 0);
                }

                zoneMap[zone] = (
                    zoneMap[zone].cover + cover,
                    zoneMap[zone].uncover + uncover,
                    zoneMap[zone].unattended + unattended
                );
            }

            // ---------- Totals ----------
            int totalFeeder = 0;
            int totalCover = 0;

            if (dsAllData.Tables.Count > 1 && dsAllData.Tables[1].Rows.Count > 0)
            {
                DataRow totalRow = dsAllData.Tables[1].Rows[0];

                totalFeeder = totalRow["TOTAL_FEEDER"] == DBNull.Value ? 0 : Convert.ToInt32(totalRow["TOTAL_FEEDER"]);
                totalCover = totalRow["COVER_FEEDER"] == DBNull.Value ? 0 : Convert.ToInt32(totalRow["COVER_FEEDER"]);
            }
            var labels = zoneMap.Keys
                    .OrderBy(z => z)
                    .ToList();

            var coverValues = labels.Select(z => zoneMap[z].cover).ToList();
            var uncoverValues = labels.Select(z => zoneMap[z].uncover).ToList();
            var unattendedValues = labels.Select(z => zoneMap[z].unattended).ToList();

            return Ok(new
            {
                labels = labels,
                datasets = new[]
                {
        new {
            label = "COVER_FEEDER",
            data = coverValues
        },
        new {
            label = "UNCOVER_FEEDER",
            data = uncoverValues
        },
        new {
            label = "UNATTENDED_FEEDER",
            data = unattendedValues
        }
    },
                totalFeeder = totalFeeder,
                totalCover = totalCover
            });


        }

        //MAIN DASHBOARD MechanicalSweeperCoverage Chart
        [HttpGet]
        [Route("api/MechanicalSweeperCoverage")]
        [AllowAnonymous]
        public IHttpActionResult GetMechanicalSweeperCoverage()
        {

            DataSet dsAllData = new DataSet();

            // -------- Database Call --------
            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("proc_MainDashboard_python", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@mode", SqlDbType.Int).Value = 25;
                cmd.Parameters.Add("@fkid", SqlDbType.Int).Value = 11401;
                cmd.Parameters.Add("@startdate", SqlDbType.DateTime).Value = "2025-12-09";
                cmd.Parameters.Add("@enddate", SqlDbType.DateTime).Value = "2025-12-09";


                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dsAllData);
            }
            DataTable dt = dsAllData.Tables[0];
            // -------- Process Data EXACTLY as per SP output --------
            int total = 0, cover = 0, uncover = 0, partially = 0;

            if (dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];

                total = row["Total"] == DBNull.Value ? 0 : Convert.ToInt32(row["Total"]);
                cover = row["Cover"] == DBNull.Value ? 0 : Convert.ToInt32(row["Cover"]);
                uncover = row["UnCover"] == DBNull.Value ? 0 : Convert.ToInt32(row["UnCover"]);
                partially = row["PartiallyCover"] == DBNull.Value ? 0 : Convert.ToInt32(row["PartiallyCover"]);
            }

            // ----- Return JSON for Chart.js Horizontal Bar -----
            return Ok(new
            {
                labels = new[] { "Cover", "UnCover", "PartiallyCover", "Total" },

                datasets = new[]
                {
        new {
            label = "Coverage",
            data = new[] { cover, uncover, partially, total }
        }
    }
            });


        }
        //MAIN DASHBOARD Rampwisegarbage Chart
        [HttpGet]
        [Route("api/Rampwisegarbage")]
        [AllowAnonymous]
        public IHttpActionResult GetRampwisegarbage()
        {

            DataSet dsAllData = new DataSet();

            // -------- Database Call --------
            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("proc_IncomingTransaction", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@mode", SqlDbType.Int).Value = 3;
                cmd.Parameters.Add("@date1", SqlDbType.DateTime).Value = "2025-11-10";
                cmd.Parameters.Add("@date2", SqlDbType.DateTime).Value = "2025-11-10";

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dsAllData);
            }

            // -------- Data Processing --------
            var labels = new List<string>();

            // Prepare dictionary for datasets
            Dictionary<string, List<decimal>> datasets = new Dictionary<string, List<decimal>>();

            // Define garbage types in fixed order
            string[] garbageTypes = new string[]
            {
               "Dry Waste",
               "Wet Waste",
               "Garden Waste",
               "Dry and Wet Waste",
               "Legacy Waste"
            };

            // Select correct table (SP result)
            DataTable dt = dsAllData.Tables[0];  // OR Tables[1] if your SP returns two tables

            // Get unique ramp names
            var ramps = dt.AsEnumerable()
                          .Select(r => r["RMM_NAME"].ToString())
                          .Distinct()
                          .ToList();

            labels = ramps;

            // Initialize dataset lists with zeros for each ramp
            foreach (var gtype in garbageTypes)
            {
                datasets[gtype] = new List<decimal>(new decimal[ramps.Count]);
            }

            // Fill data from rows
            foreach (DataRow row in dt.Rows)
            {
                string ramp = row["RMM_NAME"].ToString();
                string gtype = row["Garbage_Type_name"].ToString();
                decimal weight = row["NET_WEIGHT"] == DBNull.Value ? 0 : Convert.ToDecimal(row["NET_WEIGHT"]);

                int rampIndex = ramps.IndexOf(ramp);

                if (datasets.ContainsKey(gtype))
                {
                    datasets[gtype][rampIndex] = weight;
                }
            }

            // Final Output Format
            var response = new
            {
                labels = labels,
                datasets = garbageTypes.Select(g => new
                {
                    label = g,
                    data = datasets[g]
                }).ToList()
            };

            return Ok(response);

        }

        //MAIN DASHBOARD Processingplant Chart
        [HttpGet]
        [Route("api/Processingplant")]
        [AllowAnonymous]
        public IHttpActionResult GetProcessingplant()
        {

            DataSet dsAllData = new DataSet();

            // -------- Database Call --------
            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("proc_MainDashboard_python", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@mode", SqlDbType.Int).Value = 18;
                cmd.Parameters.Add("@AccId", SqlDbType.Int).Value = 11401;
                cmd.Parameters.Add("@STARTDATE", SqlDbType.DateTime).Value = "2025-11-10";
                cmd.Parameters.Add("@ENDDATE", SqlDbType.DateTime).Value = "2025-11-10";


                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dsAllData);
            }

            // -------- Correct Data Processing for Plant Chart --------
            var labels = new List<string>();
            var incomingValues = new List<decimal>();
            var capacityValues = new List<decimal>();

            // Plant data always comes in Table[0]
            DataTable dt = dsAllData.Tables[0];

            foreach (DataRow row in dt.Rows)
            {
                string plantName = row["PLANT_NAME"].ToString();

                decimal incoming = row["Incoming"] == DBNull.Value ? 0 : Convert.ToDecimal(row["Incoming"]);
                decimal capacity = row["PlantCapacity"] == DBNull.Value ? 0 : Convert.ToDecimal(row["PlantCapacity"]);

                labels.Add(plantName);
                incomingValues.Add(incoming);
                capacityValues.Add(capacity);
            }

            // -------- Return JSON Response --------
            return Ok(new
            {
                labels = labels,
                datasets = new[]
                {
        new {
            label = "Plant Capacity",
            data = capacityValues
        },
        new {
            label = "Incoming",
            data = incomingValues
        }
    }
            });

        }

        //MAIN DASHBOARD PostProcessing Chart
        [HttpGet]
        [Route("api/PostProcessing")]
        [AllowAnonymous]
        public IHttpActionResult GetPostProcessing()
        {

            DataSet dsAllData = new DataSet();

            // -------- Database Call --------
            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("proc_MainDashboard_python", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@mode", SqlDbType.Int).Value = 16;
                cmd.Parameters.Add("@AccId", SqlDbType.Int).Value = 11401;
                cmd.Parameters.Add("@STARTDATE", SqlDbType.DateTime).Value = "2025-11-10";
                cmd.Parameters.Add("@ENDDATE", SqlDbType.DateTime).Value = "2025-11-10";


                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dsAllData);
            }
            // -------- Data Processing --------
            var labels = new List<string>();
            var incomingValues = new List<decimal>();
            var capacityValues = new List<decimal>();

            DataTable dt = dsAllData.Tables[0];  // Table 0 contains plant data

            if (dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];

                string plantName = row["PLANT_NAME"].ToString();

                // IMPORTANT: Correct column name = InComing
                decimal incoming = row["InComing"] == DBNull.Value ? 0 : Convert.ToDecimal(row["InComing"]);
                decimal capacity = row["PlantCapacity"] == DBNull.Value ? 0 : Convert.ToDecimal(row["PlantCapacity"]);

                labels.Add(plantName);
                incomingValues.Add(incoming);
                capacityValues.Add(capacity);
            }
            else
            {
                labels.Add("No Data Found");
                incomingValues.Add(0);
                capacityValues.Add(0);
            }

            // -------- RETURN JSON --------
            return Ok(new
            {
                labels = labels,
                datasets = new[]
                {
        new {
            label = "Plant Capacity",
            data = capacityValues
        },
        new {
            label = "Incoming",
            data = incomingValues
        }
    }
            });
        }


        //MAIN DASHBOARD Wetwasteprocessing Chart
        [HttpGet]
        [Route("api/Wetwasteprocessing")]
        [AllowAnonymous]
        public IHttpActionResult GetWetwasteprocessing()
        {

            DataSet dsAllData = new DataSet();

            // -------- Database Call --------
            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("proc_MainDashboard_python", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@mode", SqlDbType.Int).Value = 103;
                cmd.Parameters.Add("@AccId", SqlDbType.Int).Value = 11401;
                cmd.Parameters.Add("@STARTDATE", SqlDbType.DateTime).Value = "2025-11-10";
                //cmd.Parameters.Add("@ENDDATE", SqlDbType.DateTime).Value = "2025-11-10";


                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dsAllData);
            }

            // -------- Correct Data Processing for Wet Waste Chart --------
            var labels = new List<string>();
            var incomingValues = new List<decimal>();
            var capacityValues = new List<decimal>();

            DataTable dt = dsAllData.Tables[0];

            foreach (DataRow row in dt.Rows)
            {
                // ❗ Only include GARBAGE_TYPE = 1 (Wet Waste)
                if (row["GARBAGE_TYPE"] == DBNull.Value || Convert.ToInt32(row["GARBAGE_TYPE"]) != 1)
                    continue;

                string plantName = row["PLANT_NAME"].ToString();

                decimal incoming = row["InComing"] == DBNull.Value ? 0 : Convert.ToDecimal(row["InComing"]);
                decimal capacity = row["PlantCapacity"] == DBNull.Value ? 0 : Convert.ToDecimal(row["PlantCapacity"]);

                labels.Add(plantName);
                incomingValues.Add(incoming);
                capacityValues.Add(capacity);
            }

            // -------- Return JSON Response --------
            return Ok(new
            {
                labels = labels,
                datasets = new[]
                {
        new {
            label = "Plant Capacity",
            data = capacityValues
        },
        new {
            label = "Incoming",
            data = incomingValues
        }
    }
            });


        }


        //MAIN DASHBOARD BiogasProcessing Chart
        [HttpGet]
        [Route("api/BiogasProcessing")]
        [AllowAnonymous]
        public IHttpActionResult GetBiogasProcessing()
        {

            DataSet dsAllData = new DataSet();

            // -------- Database Call --------
            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("proc_MainDashboard_python", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@mode", SqlDbType.Int).Value = 555;
                cmd.Parameters.Add("@fkid", SqlDbType.Int).Value = 11401;
                cmd.Parameters.Add("@STARTDATE", SqlDbType.DateTime).Value = "2025-11-09";
                cmd.Parameters.Add("@ENDDATE", SqlDbType.DateTime).Value = "2025-11-09";


                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dsAllData);
            }

            // -------- Process Data EXACTLY as per SP output --------
            var labels = new List<string>();
            var incomingValues = new List<decimal>();
            var capacityValues = new List<decimal>();

            DataTable dt = dsAllData.Tables[0];

            foreach (DataRow row in dt.Rows)
            {
                string plantName = row["PLANT_NAME"].ToString();

                decimal incoming = row["InComing"] == DBNull.Value ? 0 : Convert.ToDecimal(row["InComing"]);
                decimal capacity = row["PlantCapacity"] == DBNull.Value ? 0 : Convert.ToDecimal(row["PlantCapacity"]);

                labels.Add(plantName);
                incomingValues.Add(incoming);
                capacityValues.Add(capacity);
            }

            // -------- Return JSON for Chart.js --------
            return Ok(new
            {
                labels = labels,
                datasets = new[]
                {
        new {
            label = "Plant Capacity",
            data = capacityValues
        },
        new {
            label = "Incoming",
            data = incomingValues
        }
    }
            });


        }

        //MAIN DASHBOARD AdhocSpecialWasteCD Chart
        [HttpGet]
        [Route("api/AdhocSpecialWasteCD")]
        [AllowAnonymous]
        public IHttpActionResult GetAdhocSpecialWasteCD()
        {

            DataSet dsAllData = new DataSet();

            // -------- Database Call --------
            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("proc_MainDashboard_python", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@mode", SqlDbType.Int).Value = 20;
                cmd.Parameters.Add("@fkid", SqlDbType.Int).Value = 11401;
                cmd.Parameters.Add("@STARTDATE", SqlDbType.DateTime).Value = "2025-12-10";
                cmd.Parameters.Add("@ENDDATE", SqlDbType.DateTime).Value = "2025-12-10";


                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dsAllData);
            }

            // -------- Process Data EXACTLY as per SP output --------
            DataTable dt = dsAllData.Tables[1];

            var labels = new List<string>();
            var values = new List<decimal>();

            if (dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];

                labels.Add("Habitable Waste Collected");
                values.Add(row["CDTotal"] == DBNull.Value ? 0 : Convert.ToDecimal(row["CDTotal"]));

                labels.Add("Medical Waste Collected");
                values.Add(row["PMCProject_Assign"] == DBNull.Value ? 0 : Convert.ToDecimal(row["PMCProject_Assign"]));

                labels.Add("Garden Waste Collected");
                values.Add(row["PMCProject_Pending"] == DBNull.Value ? 0 : Convert.ToDecimal(row["PMCProject_Pending"]));

                labels.Add("Dead Animals Collected");
                values.Add(row["PMCProject_Completed"] == DBNull.Value ? 0 : Convert.ToDecimal(row["PMCProject_Completed"]));

                labels.Add("Hazardous Waste Collected");
                values.Add(row["GovernmentProjectAgency_Assign"] == DBNull.Value ? 0 : Convert.ToDecimal(row["GovernmentProjectAgency_Assign"]));
            }


            // -------- Return JSON for Chart.js --------
            return Ok(new
            {
                labels = labels,
                datasets = new[]
    {
        new
        {
            label = "Waste Collected",
            data = values
        }
    }
            });


        }

        //MAIN DASHBOARD AdhocSpecialWaste Chart
        [HttpGet]
        [Route("api/AdhocSpecialWaste")]
        [AllowAnonymous]
        public IHttpActionResult GetAdhocSpecialWaste()
        {

            DataSet dsAllData = new DataSet();

            // -------- Database Call --------
            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("proc_MainDashboard_python", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@mode", SqlDbType.Int).Value = 15;
                cmd.Parameters.Add("@fkid", SqlDbType.Int).Value = 11401;
                cmd.Parameters.Add("@STARTDATE", SqlDbType.DateTime).Value = "2025-12-10";
                cmd.Parameters.Add("@ENDDATE", SqlDbType.DateTime).Value = "2025-12-10";


                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dsAllData);
            }

            // -------- Process Data EXACTLY as per SP output --------
            DataTable dt = dsAllData.Tables[1];

            var labels = new List<string>();
            var values = new List<decimal>();

            if (dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];

                labels.Add("Total");
                values.Add(row["SWTotal"] == DBNull.Value ? 0 : Convert.ToDecimal(row["SWTotal"]));

                labels.Add("Hotel Assign");
                values.Add(row["Hotel_Assign"] == DBNull.Value ? 0 : Convert.ToDecimal(row["Hotel_Assign"]));

                labels.Add("Hotel Pending");
                values.Add(row["Hotel_Pending"] == DBNull.Value ? 0 : Convert.ToDecimal(row["Hotel_Pending"]));

                labels.Add("Hotel Completed");
                values.Add(row["Hotel_Completed"] == DBNull.Value ? 0 : Convert.ToDecimal(row["Hotel_Completed"]));

                labels.Add("Garden Assign");
                values.Add(row["Garden_Assign"] == DBNull.Value ? 0 : Convert.ToDecimal(row["Garden_Assign"]));

                labels.Add("Garden Pending");
                values.Add(row["Garden_Pending"] == DBNull.Value ? 0 : Convert.ToDecimal(row["Garden_Pending"]));

                labels.Add("Garden Completed");
                values.Add(row["Garden_Completed"] == DBNull.Value ? 0 : Convert.ToDecimal(row["Garden_Completed"]));

                labels.Add("SlaughterHouse Assign");
                values.Add(row["SlaughterHouse_Assign"] == DBNull.Value ? 0 : Convert.ToDecimal(row["SlaughterHouse_Assign"]));

                labels.Add("SlaughterHouse Pending");
                values.Add(row["SlaughterHouse_Pending"] == DBNull.Value ? 0 : Convert.ToDecimal(row["SlaughterHouse_Pending"]));

                labels.Add("SlaughterHouse Completed");
                values.Add(row["SlaughterHouse_Completed"] == DBNull.Value ? 0 : Convert.ToDecimal(row["SlaughterHouse_Completed"]));

                labels.Add("Bio Waste Assign");
                values.Add(row["BioWaste_Assign"] == DBNull.Value ? 0 : Convert.ToDecimal(row["BioWaste_Assign"]));

                labels.Add("Bio Waste Pending");
                values.Add(row["BioWaste_Pending"] == DBNull.Value ? 0 : Convert.ToDecimal(row["BioWaste_Pending"]));

                labels.Add("Bio Waste Completed");
                values.Add(row["BioWaste_Completed"] == DBNull.Value ? 0 : Convert.ToDecimal(row["BioWaste_Completed"]));
            }

            return Ok(new
            {
                labels = labels,
                datasets = new[]
    {
        new
        {
            label = "Adhoc Special Waste",
            data = values
        }
    }
            });



        }

        //MAIN DASHBOARD FineCollection Chart
        [HttpGet]
        [Route("api/FineCollection")]
        [AllowAnonymous]
        public IHttpActionResult GetFineCollection()
        {

            DataSet dsAllData = new DataSet();

            // -------- Database Call --------
            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("proc_MainDashboard_python", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@mode", SqlDbType.Int).Value = 22;
                cmd.Parameters.Add("@fkid", SqlDbType.Int).Value = 11401;
                cmd.Parameters.Add("@STARTDATE", SqlDbType.DateTime).Value = "2025-12-10";
                cmd.Parameters.Add("@ENDDATE", SqlDbType.DateTime).Value = "2025-12-10";


                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dsAllData);
            }

            // -------- Process Data EXACTLY as per SP output --------
            // 🔹 Fine Name vs Count
            Dictionary<string, int> fineCounts = new Dictionary<string, int>(StringComparer.OrdinalIgnoreCase);

            decimal totalFineAmount = 0;

            // 🔁 Loop ALL 4 DataTables
            foreach (DataTable dt in dsAllData.Tables)
            {
                // Safety check (only tables having Finename column)
                if (!dt.Columns.Contains("Finename"))
                    continue;

                foreach (DataRow row in dt.Rows)
                {
                    string fineName = row["Finename"].ToString();

                    decimal fineAmount =
                        dt.Columns.Contains("Actual_Fine_taken") && row["Actual_Fine_taken"] != DBNull.Value
                        ? Convert.ToDecimal(row["Actual_Fine_taken"])
                        : 0;

                    // Count offender
                    if (!fineCounts.ContainsKey(fineName))
                        fineCounts[fineName] = 0;

                    fineCounts[fineName] += 1;

                    // Sum amount
                    totalFineAmount += fineAmount;
                }
            }
            var labels = fineCounts.Keys.ToList();
            var values = fineCounts.Values.ToList();
            return Ok(new
            {
                labels = labels,
                datasets = new[]
    {
        new
        {
            label = "Fine Count",
            data = values,

        }
    },
                totalAmount = totalFineAmount
            });



        }
        #endregion

        #region FeederDashboard

        //start FeederDashboard pavanpasupleti

        /// <summary>
        /// //FeederDashboard pavan pasupuleti total--5
        /// </summary>
        /// <returns></returns>
        /// 
        //Pavan pasupuleti total--5
        [HttpGet]
        [Route("api/FeederCoverageOverall")]
        [AllowAnonymous]
        public IHttpActionResult GetFeederCoverageOverall()
        {


            DataSet ds = new DataSet();

            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("SP_FEEDER_ATTENDANCE", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@mode", SqlDbType.Int).Value = 1;
                cmd.Parameters.Add("@FKID", SqlDbType.Int).Value = 11401;
                cmd.Parameters.Add("@STARTDATE", SqlDbType.Date).Value = "2025-01-01";

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
            }

            DataTable dt = ds.Tables[0];

            // ---------- COUNT STATUSES ----------
            int covered = dt.AsEnumerable()
                            .Count(r => r["STATUS"].ToString().ToUpper() == "COVERED");

            int uncovered = dt.AsEnumerable()
                              .Count(r => r["STATUS"].ToString().ToUpper() == "UNCOVERED");

            int unattended = dt.AsEnumerable()
                               .Count(r => r["STATUS"].ToString().ToUpper().Contains("UN ATTENDED")
                                        || r["STATUS"].ToString().ToUpper() == "UNATTENDED");

            // ---------- RETURN JSON EXACT FORMAT ----------
            return Ok(new
            {
                labels = new[] { "COVERED", "UN ATTENDED", "UNCOVERED" },
                values = new[] { covered, unattended, uncovered }
            });
        }


        [HttpGet]
        [Route("api/FeederCoverageZoneWise")]
        [AllowAnonymous]
        public IHttpActionResult GetFeederCoverageZoneWise()
        {

            DataSet ds = new DataSet();

            // ----------- DB CALL -----------
            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("SP_FEEDER_ATTENDANCE", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@mode", SqlDbType.Int).Value = 1;
                cmd.Parameters.Add("@FKID", SqlDbType.Int).Value = 11401;
                cmd.Parameters.Add("@STARTDATE", SqlDbType.Date).Value = "2025-01-01";

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
            }

            DataTable dt = ds.Tables[0];

            // ---------- GROUP BY ZONE ----------
            var zoneGroups = dt.AsEnumerable()
                .GroupBy(r => r["ZONE"].ToString())
                .OrderBy(g => g.Key)
                .ToList();

            // ---------- BUILD OUTPUT ----------
            var labels = new List<string>();
            var values = new List<object>();

            foreach (var zone in zoneGroups)
            {
                string zoneName = zone.Key;

                int covered = zone.Count(r => r["STATUS"].ToString().ToUpper() == "COVERED");
                int uncovered = zone.Count(r => r["STATUS"].ToString().ToUpper() == "UNCOVERED");
                int unattended = zone.Count(r => r["STATUS"].ToString().ToUpper().Contains("UN ATTENDED")
                                             || r["STATUS"].ToString().ToUpper() == "UNATTENDED");

                labels.Add(zoneName);

                values.Add(new
                {
                    covered = covered,
                    uncovered = uncovered,
                    unattended = unattended
                });
            }

            // ---------- RETURN SIMPLE JSON ----------
            return Ok(new
            {
                labels = labels,
                values = values
            });
        }
        [HttpGet]
        [Route("api/FeederCoverageWardWise")]
        [AllowAnonymous]
        public IHttpActionResult GetFeederCoverageWardWise()
        {

            DataSet ds = new DataSet();

            // ----------- DB CALL -----------
            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("SP_FEEDER_ATTENDANCE", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@mode", SqlDbType.Int).Value = 1;
                cmd.Parameters.Add("@FKID", SqlDbType.Int).Value = 11401;
                cmd.Parameters.Add("@STARTDATE", SqlDbType.Date).Value = "2025-01-01";

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
            }

            DataTable dt = ds.Tables[0];

            // ---------- GROUP BY WARD ----------
            var wardGroups = dt.AsEnumerable()
                .GroupBy(r => r["WARD"].ToString())
                .OrderBy(g => g.Key)
                .ToList();

            // ---------- BUILD OUTPUT ----------
            var labels = new List<string>();
            var values = new List<object>();

            foreach (var ward in wardGroups)
            {
                string wardName = ward.Key;

                int covered = ward.Count(r => r["STATUS"].ToString().ToUpper() == "COVERED");
                int uncovered = ward.Count(r => r["STATUS"].ToString().ToUpper() == "UNCOVERED");
                int unattended = ward.Count(r => r["STATUS"].ToString().ToUpper().Contains("UN ATTENDED")
                                             || r["STATUS"].ToString().ToUpper() == "UNATTENDED");

                labels.Add(wardName);

                values.Add(new
                {
                    covered = covered,
                    uncovered = uncovered,
                    unattended = unattended
                });
            }

            // ---------- RETURN SIMPLE JSON ----------
            return Ok(new
            {
                labels = labels,
                values = values
            });
        }

        [HttpGet]
        [Route("api/FeederCoverageSummary")]
        [AllowAnonymous]
        public IHttpActionResult GetFeederCoverageSummary()
        {


            DataSet ds = new DataSet();

            // --- DB CALL ---
            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("SP_FEEDER_ATTENDANCE", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@mode", SqlDbType.Int).Value = 1;
                cmd.Parameters.Add("@FKID", SqlDbType.Int).Value = 11401;
                cmd.Parameters.Add("@STARTDATE", SqlDbType.Date).Value = "2025-01-01";

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
            }

            DataTable dt = ds.Tables[0];

            // ------------ BUILD BAR CHART DATA ------------
            var labels = new List<string>();
            var values = new List<int>();   // 1 = COVERED, 0 = UNCOVERED

            foreach (DataRow row in dt.Rows)
            {
                string feederName = row["FEEDERNAME"].ToString();
                string status = row["STATUS"].ToString().ToUpper();

                labels.Add(feederName);

                values.Add(status == "COVERED" ? 1 : 0);
            }

            // ------------ RETURN JSON ------------
            return Ok(new
            {
                labels = labels,
                values = values
            });
        }

        [HttpGet]
        [Route("api/FeederPointsCoverageDistribution")]
        [AllowAnonymous]
        public IHttpActionResult GetFeederPointsCoverageDistribution()
        {

            DataSet ds = new DataSet();

            // ---------- DB CALL ----------
            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("SP_FEEDER_ATTENDANCE", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@mode", SqlDbType.Int).Value = 2;
                cmd.Parameters.Add("@FKID", SqlDbType.Int).Value = 11401;
                cmd.Parameters.Add("@STARTDATE", SqlDbType.Date).Value = "2025-01-01";

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
            }

            DataTable dt = ds.Tables[0];

            // ---------- GROUP COUNTERS ----------
            int g0_20 = 0;
            int g21_40 = 0;
            int g41_60 = 0;
            int g61_80 = 0;
            int g81_100 = 0;

            // ---------- CALCULATE COVERAGE GROUPS ----------
            foreach (DataRow row in dt.Rows)
            {
                decimal percent = Convert.ToDecimal(row["PERCENTAGE"]);

                if (percent <= 20)
                    g0_20++;
                else if (percent <= 40)
                    g21_40++;
                else if (percent <= 60)
                    g41_60++;
                else if (percent <= 80)
                    g61_80++;
                else
                    g81_100++;
            }

            // ---------- RETURN JSON ----------
            return Ok(new
            {
                labels = new[] { "0–20%", "21–40%", "41–60%", "61–80%", "81–100%" },
                values = new[] { g0_20, g21_40, g41_60, g61_80, g81_100 }
            });
        }




        //// End FeederDashboard pavan pasupuleti 



        #endregion

        #region RampDashboard
        //Start RampDashboard pavan pasupuleti 

        /// <summary>
        /// /RampDashboard pavan pasupuleti total--9
        /// </summary>
        /// <returns></returns>

        //pavan pasupuleti total--9
        private DateTime FixDate(DateTime date)
        {
            return (date == DateTime.MinValue) ? DateTime.Today : date.Date;
        }

        private DataSet Execute(string connnString, string sp, params SqlParameter[] prms)
        {
            var ds = new DataSet();
            using (SqlConnection con = new SqlConnection(connnString))
            using (SqlCommand cmd = new SqlCommand(sp, con))
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddRange(prms);
                da.Fill(ds);
            }
            return ds;
        }

        private decimal GetValue(DataRow row, string col)
        {
            return row[col] == DBNull.Value ? 0 : Convert.ToDecimal(row[col]);
        }

        [HttpGet]
        [Route("api/RampGarbageSummaryMT")]
        public IHttpActionResult RampGarbageSummaryMT(DateTime startDate, DateTime endDate)
        {
            //string conn = "Data Source=con.iswmpune.in; Initial Catalog=SWMSystem; User ID=webadmin; Password=Admin@123!@#; Connect Timeout=99999;";

            startDate = FixDate(startDate);
            endDate = FixDate(endDate);

            DataSet ds = Execute(connnString, "proc_MainDashboard_python",
                new SqlParameter("@mode", 21),
                new SqlParameter("@AccId", 11401),
                new SqlParameter("@STARTDATE", startDate),
                new SqlParameter("@ENDDATE", endDate)
            );

            var dt = ds.Tables[0];

            List<string> labels = new List<string>();
            List<decimal> incoming = new List<decimal>();
            List<decimal> outgoing = new List<decimal>();
            List<decimal> capacity = new List<decimal>();

            foreach (DataRow r in dt.Rows)
            {
                labels.Add(r["RampName"].ToString());
                incoming.Add(GetValue(r, "InComing"));
                outgoing.Add(GetValue(r, "OutGoing"));
                capacity.Add(GetValue(r, "AverageIncomingCapacity"));
            }

            return Ok(new
            {
                labels = labels,
                datasets = new[] {
            new { label = "Average Incoming Capacity", data = capacity },
            new { label = "Outgoing", data = outgoing },
            new { label = "Incoming", data = incoming }
        }
            });
        }
        [HttpGet]
        [Route("api/ProcessingplantfordryGarbage")]
        public IHttpActionResult ProcessingplantfordryGarbage(DateTime startDate, DateTime endDate)
        {
            //string conn = "Data Source=con.iswmpune.in; Initial Catalog=SWMSystem; User ID=webadmin; Password=Admin@123!@#; Connect Timeout=99999;";

            startDate = FixDate(startDate);
            endDate = FixDate(endDate);

            DataSet ds = Execute(connnString, "proc_MainDashboard_python",
                new SqlParameter("@mode", 18),
                new SqlParameter("@AccId", 11401),
                new SqlParameter("@STARTDATE", startDate),
                new SqlParameter("@ENDDATE", endDate)
            );

            var dt = ds.Tables[0];

            List<string> labels = new List<string>();
            List<decimal> incoming = new List<decimal>();
            List<decimal> capacity = new List<decimal>();

            foreach (DataRow r in dt.Rows)
            {
                labels.Add(r["PLANT_NAME"].ToString());
                incoming.Add(GetValue(r, "InComing"));
                capacity.Add(GetValue(r, "PlantCapacity"));
            }

            return Ok(new
            {
                labels = labels,
                datasets = new[] {
            new { label = "Plant Capacity", data = capacity },
            new { label = "Incoming", data = incoming }
        }
            });
        }
        [HttpGet]
        [Route("api/PostprocessingPlantMT")]
        public IHttpActionResult PostprocessingPlantMT(DateTime startDate, DateTime endDate)
        {
            // string conn = "Data Source=con.iswmpune.in; Initial Catalog=SWMSystem; User ID=webadmin; Password=Admin@123!@#; Connect Timeout=99999;";

            startDate = FixDate(startDate);
            endDate = FixDate(endDate);

            DataSet ds = Execute(connnString, "proc_MainDashboard_python",
                new SqlParameter("@mode", 16),
                new SqlParameter("@AccId", 11401),
                new SqlParameter("@STARTDATE", startDate),
                new SqlParameter("@ENDDATE", endDate)
            );

            var dt = ds.Tables[0];

            List<string> labels = new List<string>();
            List<decimal> incoming = new List<decimal>();
            List<decimal> capacity = new List<decimal>();

            foreach (DataRow r in dt.Rows)
            {
                labels.Add(r["PLANT_NAME"].ToString());
                incoming.Add(GetValue(r, "InComing"));
                capacity.Add(GetValue(r, "PlantCapacity"));
            }

            return Ok(new
            {
                labels = labels,
                datasets = new[] {
            new { label = "Plant Capacity", data = capacity },
            new { label = "Incoming", data = incoming }
        }
            });
        }

        [HttpGet]
        [Route("api/BioGasProcessingPlantKG")]
        public IHttpActionResult BioGasProcessingPlantKG(DateTime startDate, DateTime endDate)
        {
            //string conn = "Data Source=con.iswmpune.in; Initial Catalog=SWMSystem; User ID=webadmin; Password=Admin@123!@#; Connect Timeout=99999;";

            startDate = FixDate(startDate);
            endDate = FixDate(endDate);

            DataSet ds = Execute(connnString, "proc_MainDashboard_python",
                new SqlParameter("@mode", 555),
                new SqlParameter("@STARTDATE", startDate),
                new SqlParameter("@ENDDATE", endDate)
            );

            var dt = ds.Tables[0];

            List<string> labels = new List<string>();
            List<decimal> incoming = new List<decimal>();
            List<decimal> capacity = new List<decimal>();

            foreach (DataRow r in dt.Rows)
            {
                labels.Add(r["PLANT_NAME"].ToString());
                incoming.Add(GetValue(r, "InComing"));
                capacity.Add(GetValue(r, "PlantCapacity"));
            }

            return Ok(new
            {
                labels = labels,
                datasets = new[] {
            new { label = "Plant Capacity", data = capacity },
            new { label = "Incoming", data = incoming }
        }
            });
        }

        [HttpGet]
        [Route("api/WetWasteProcessingPlantMT")]
        public IHttpActionResult WetWasteProcessingPlantMT(DateTime startDate, DateTime endDate)
        {
            //string conn = "Data Source=con.iswmpune.in; Initial Catalog=SWMSystem; User ID=webadmin; Password=Admin@123!@#; Connect Timeout=99999;";

            startDate = FixDate(startDate);
            endDate = FixDate(endDate);

            DataSet ds = Execute(connnString, "proc_MainDashboard_python",
                new SqlParameter("@mode", 103),
                new SqlParameter("@AccId", 11401),
                new SqlParameter("@STARTDATE", startDate),
                new SqlParameter("@ENDDATE", endDate)
            );

            var dt = ds.Tables[0];

            List<string> labels = new List<string>();
            List<decimal> incoming = new List<decimal>();
            List<decimal> capacity = new List<decimal>();

            foreach (DataRow r in dt.Rows)
            {
                labels.Add(r["PLANT_NAME"].ToString());
                incoming.Add(GetValue(r, "InComing"));
                capacity.Add(GetValue(r, "PlantCapacity"));
            }

            return Ok(new
            {
                labels = labels,
                datasets = new[] {
            new { label = "Plant Capacity", data = capacity },
            new { label = "Incoming", data = incoming }
        }
            });
        }

        [HttpGet]
        [Route("api/RampWiseGarbageTypeSplit")]
        public IHttpActionResult RampWiseGarbageTypeSplit(DateTime startDate, DateTime endDate)
        {
            //  string conn = "Data Source=con.iswmpune.in; Initial Catalog=SWMSystem; User ID=webadmin; Password=Admin@123!@#; Connect Timeout=99999;";
            startDate = FixDate(startDate);
            endDate = FixDate(endDate);

            DataSet ds = Execute(connnString, "proc_IncomingTransaction",
                new SqlParameter("@mode", 3),
                new SqlParameter("@Date1", startDate),
                new SqlParameter("@Date2", endDate),
                new SqlParameter("@RampId", "")
            );

            var dt = ds.Tables[0];

            Dictionary<string, decimal[]> dict = new Dictionary<string, decimal[]>();
            // 0 = Dry, 1 = Wet, 2 = Garden, 3 = Dry+Wet

            foreach (DataRow r in dt.Rows)
            {
                string ramp = r["RMM_NAME"].ToString();
                string type = r["Garbage_Type_name"].ToString();
                decimal wt = GetValue(r, "NET_WEIGHT");

                if (!dict.ContainsKey(ramp))
                    dict[ramp] = new decimal[4];

                if (type.Contains("Dry and Wet"))
                    dict[ramp][3] += wt;
                else if (type.Contains("Dry"))
                    dict[ramp][0] += wt;
                else if (type.Contains("Wet"))
                    dict[ramp][1] += wt;
                else if (type.Contains("Garden"))
                    dict[ramp][2] += wt;
            }

            return Ok(new
            {
                labels = dict.Keys.ToList(),
                datasets = new[] {
            new { label = "Dry Waste", data = dict.Values.Select(v => v[0]).ToList() },
            new { label = "Wet Waste", data = dict.Values.Select(v => v[1]).ToList() },
            new { label = "Garden Waste", data = dict.Values.Select(v => v[2]).ToList() },
            new { label = "Dry and Wet Waste", data = dict.Values.Select(v => v[3]).ToList() }
        }
            });
        }

        [HttpGet]
        [Route("api/DailyWasteCollectionMT")]
        public IHttpActionResult DailyWasteCollectionMT(DateTime startDate, DateTime endDate)
        {
            //   string conn = "Data Source=con.iswmpune.in; Initial Catalog=SWMSystem; User ID=webadmin; Password=Admin@123!@#; Connect Timeout=99999;";

            startDate = FixDate(startDate);
            endDate = FixDate(endDate);

            DataSet ds = Execute(connnString, "proc_MainDashboard_python",
                new SqlParameter("@mode", 102),
                new SqlParameter("@AccId", 11401),
                new SqlParameter("@startdate", startDate),
                new SqlParameter("@enddate", endDate)
            );

            var dt = ds.Tables[0];

            List<string> labels = new List<string>();
            List<decimal> values = new List<decimal>();

            foreach (DataRow r in dt.Rows)
            {
                labels.Add(r["Garbage_Type_name"].ToString());
                values.Add(GetValue(r, "Total Waste (MT)"));
            }

            return Ok(new
            {
                labels = labels,
                datasets = new[] {
            new { label = "Daily Waste Collection", data = values }
        }
            });
        }

        [HttpGet]
        [Route("api/LegacyWasteMT")]
        [AllowAnonymous]
        public IHttpActionResult GetLegacyWasteMT(DateTime startDate, DateTime endDate)
        {
            if (startDate == DateTime.MinValue) startDate = DateTime.Today;
            if (endDate == DateTime.MinValue) endDate = DateTime.Today;

            //   string connString = "Data Source=con.iswmpune.in; Initial Catalog=SWMSystem; User ID=webadmin; Password=Admin@123!@#;";

            DataSet ds = new DataSet();

            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("proc_IncomingTransaction", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@mode", SqlDbType.Int).Value = 333;
                cmd.Parameters.Add("@Date1", SqlDbType.DateTime).Value = startDate;
                cmd.Parameters.Add("@Date2", SqlDbType.DateTime).Value = endDate;
                cmd.Parameters.Add("@RampId", SqlDbType.NVarChar).Value = "";

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
            }

            // Find the table that contains TOTAL_WEIGHT
            DataTable dt = null;
            foreach (DataTable t in ds.Tables)
            {
                if (t.Columns.Contains("TOTAL_WEIGHT"))
                {
                    dt = t;
                    break;
                }
            }

            if (dt == null)
            {
                return Ok(new
                {
                    labels = new[] { "Plant Capacity", "Daily Processing" },
                    datasets = new[] {
                new { label = "Legacy Waste (MT)", data = new[] { 0m, 0m } }
            },
                    error = "TOTAL_WEIGHT column not found"
                });
            }

            decimal plantCapacity = 0;
            decimal dailyProcessing = 0;

            foreach (DataRow row in dt.Rows)
            {
                string name = row["PLANT_NAME"].ToString();
                decimal weight = row["TOTAL_WEIGHT"] == DBNull.Value ? 0 : Convert.ToDecimal(row["TOTAL_WEIGHT"]);

                // TOTAL row contains summary values
                if (name.IndexOf("Total", StringComparison.OrdinalIgnoreCase) >= 0)
                {
                    plantCapacity = weight;
                    dailyProcessing = weight;
                }
            }

            return Ok(new
            {
                labels = new[] { "Plant Capacity", "Daily Processing" },
                datasets = new[]
                {
            new {
                label = "Legacy Waste (MT)",
                data = new[] { plantCapacity, dailyProcessing }
            }
        }
            });
        }

        [HttpGet]
        [Route("api/LegacyWasteSummaryMT")]
        [AllowAnonymous]
        public IHttpActionResult GetLegacyWasteSummaryMT(DateTime startDate, DateTime endDate)
        {
            startDate = FixDate(startDate);
            endDate = FixDate(endDate);

            var ds = Execute(connnString, "proc_IncomingTransaction",
               new SqlParameter("@mode", 333),
               new SqlParameter("@Date1", startDate),
               new SqlParameter("@Date2", endDate),
               new SqlParameter("@RampId", "")
            );

            // find table with TOTAL_WEIGHT
            DataTable dt = null;
            foreach (DataTable t in ds.Tables)
            {
                if (t.Columns.Contains("TOTAL_WEIGHT"))
                {
                    dt = t;
                    break;
                }
            }

            if (dt == null)
                return Ok(new { labels = new[] { "Processed Waste", "Balanced Waste" }, values = new[] { 0m, 0m }, error = "TOTAL_WEIGHT missing" });

            decimal processed = 0;

            foreach (DataRow row in dt.Rows)
            {
                if (row["TOTAL_WEIGHT"] != DBNull.Value)
                    processed += Convert.ToDecimal(row["TOTAL_WEIGHT"]);
            }

            decimal tenderCapacity = 2000000m; // based on your chart 2,000,000
            decimal balanced = tenderCapacity - processed;
            if (balanced < 0) balanced = 0;

            return Ok(new
            {
                labels = new[] { "Processed Waste", "Balanced Waste" },
                values = new[] { processed, balanced }
            });
        }


        //END RmpDashboard pavan pasupuleti

        #endregion

        #region Mokadam

        //Mokadam Attendence    start rahul  need to test and add based on chat
        //rahul

        [HttpGet]
        [Route("api/MokadamAttendence")]
        [AllowAnonymous]
        public IHttpActionResult GetMokadamAttendence()
        {

            DataSet dsAllData = new DataSet();

            // -------- Database Call --------

            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("GetMokadamAttendance_AT", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@dateFrom", SqlDbType.DateTime).Value = "2025-12-11";
                cmd.Parameters.Add("@dateTo", SqlDbType.DateTime).Value = "2025-12-11";
                cmd.Parameters.Add("@fk_id", SqlDbType.Int).Value = 11401;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dsAllData);
            }
            // -------- Correct Data Processing for Plant Chart --------
            int absentCount = 0;
            int presentCount = 0;

            DataTable dt = dsAllData.Tables[0];

            foreach (DataRow row in dt.Rows)
            {
                string attendance = row["ATTENDANCE"] == DBNull.Value
                    ? ""
                    : row["ATTENDANCE"].ToString().ToUpper();

                if (attendance == "ABSENT")
                {
                    absentCount++;
                }
                else if (attendance.StartsWith("PRESENT"))
                {
                    presentCount++;
                }
            }

            int total = absentCount + presentCount;


            // -------- Return JSON Response --------
            return Ok(new
            {
                total = total,
                labels = new[] { "ABSENT", "PRESENT" },
                datasets = new[]
    {
        new
        {
            data = new[] { absentCount, presentCount },

        }
    }
            });

        }

        //  Mokadam Attendance Zone Wise
        //rahul

        [HttpGet]
        [Route("api/MokadamAttendanceZoneWise")]
        [AllowAnonymous]
        public IHttpActionResult GetMokadamAttendanceZoneWise()
        {

            DataSet dsAllData = new DataSet();

            // -------- Database Call --------
            using (SqlConnection con = new SqlConnection(connnString))
            {

                SqlCommand cmd = new SqlCommand("GetMokadamAttendance_AT", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@dateFrom", SqlDbType.DateTime).Value = "2025-12-11";
                cmd.Parameters.Add("@dateTo", SqlDbType.DateTime).Value = "2025-12-11";
                cmd.Parameters.Add("@fk_id", SqlDbType.Int).Value = 11401;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dsAllData);
            }

            // -------- Correct Data Processing for Plant Chart --------
            DataTable dt = dsAllData.Tables[0];

            // Zone-wise aggregation
            var zoneSummary = new Dictionary<string, (int Absent, int Present)>();

            foreach (DataRow row in dt.Rows)
            {
                string zone = row["ZONE"] == DBNull.Value
                    ? "UNKNOWN"
                    : row["ZONE"].ToString();

                string attendance = row["ATTENDANCE"] == DBNull.Value
                    ? ""
                    : row["ATTENDANCE"].ToString().ToUpper();

                if (!zoneSummary.ContainsKey(zone))
                    zoneSummary[zone] = (0, 0);

                if (attendance == "ABSENT")
                {
                    zoneSummary[zone] = (
                        zoneSummary[zone].Absent + 1,
                        zoneSummary[zone].Present
                    );
                }
                else if (attendance.StartsWith("PRESENT"))
                {
                    zoneSummary[zone] = (
                        zoneSummary[zone].Absent,
                        zoneSummary[zone].Present + 1
                    );
                }
            }

            var labels = new List<string>();
            var absentValues = new List<int>();
            var presentValues = new List<int>();

            int grandTotal = 0;

            foreach (var z in zoneSummary)
            {
                labels.Add(z.Key);
                absentValues.Add(z.Value.Absent);
                presentValues.Add(z.Value.Present);
                grandTotal += z.Value.Absent + z.Value.Present;
            }
            return Ok(new
            {
                total = grandTotal,

                zones = labels,

                datasets = new[]
    {
        new
        {
            label = "ABSENT",
            data = absentValues
        },
        new
        {
            label = "PRESENT",
            data = presentValues
        }
    }
            });
        }

        // Mokadam Attendance Ward Wise
        // rahul

        [HttpGet]
        [Route("api/MokadamAttendanceWardWise")]
        [AllowAnonymous]
        public IHttpActionResult GetMokadamAttendanceWardWise()
        {

            DataSet dsAllData = new DataSet();

            // -------- Database Call --------
            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("GetMokadamAttendance_AT", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@dateFrom", SqlDbType.DateTime).Value = "2025-12-11";
                cmd.Parameters.Add("@dateTo", SqlDbType.DateTime).Value = "2025-12-11";
                cmd.Parameters.Add("@fk_id", SqlDbType.Int).Value = 11401;



                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dsAllData);
            }

            // -------- Correct Data Processing for Plant Chart --------
            DataTable dt = dsAllData.Tables[0];

            // ✅ Ward-wise aggregation
            var wardSummary = new Dictionary<string, (int Absent, int Present)>();

            foreach (DataRow row in dt.Rows)
            {
                string ward = row["WARD"] == DBNull.Value
                    ? "UNKNOWN"
                    : row["WARD"].ToString();

                string attendance = row["ATTENDANCE"] == DBNull.Value
                    ? ""
                    : row["ATTENDANCE"].ToString().ToUpper();

                if (!wardSummary.ContainsKey(ward))
                    wardSummary[ward] = (0, 0);

                if (attendance == "ABSENT")
                {
                    wardSummary[ward] = (
                        wardSummary[ward].Absent + 1,
                        wardSummary[ward].Present
                    );
                }
                else if (attendance.StartsWith("PRESENT"))
                {
                    wardSummary[ward] = (
                        wardSummary[ward].Absent,
                        wardSummary[ward].Present + 1
                    );
                }
            }

            // ✅ Prepare response arrays
            var labels = new List<string>();
            var absentValues = new List<int>();
            var presentValues = new List<int>();

            int grandTotal = 0;

            foreach (var w in wardSummary)
            {
                labels.Add(w.Key);
                absentValues.Add(w.Value.Absent);
                presentValues.Add(w.Value.Present);
                grandTotal += w.Value.Absent + w.Value.Present;
            }

            // ✅ Final JSON response (WARD-WISE)
            return Ok(new
            {
                total = grandTotal,

                wards = labels,

                datasets = new[]
                {
        new
        {
            label = "ABSENT",
            data = absentValues
        },
        new
        {
            label = "PRESENT",
            data = presentValues
        }
    }
            });

        }


        /// end Rahul mokadam 
        #endregion

        #region DrainageDashboard

        // DrainageWorkerDashboard
        //Drainage worker Attendence
        //vamshi

        [HttpGet]
        [Route("api/DrainageworkerAttendence")]
        [AllowAnonymous]
        public IHttpActionResult GetDrainageWorkerAttendance()
        {

            DataSet dsAllData = new DataSet();

            // -------- Database Call --------
            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("GetDrainageWorkerAttendance_AT", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@dateFrom", SqlDbType.DateTime).Value = "2025-08-10";
                cmd.Parameters.Add("@dateTo", SqlDbType.DateTime).Value = "2025-08-10";
                cmd.Parameters.Add("@wardID", SqlDbType.Int).Value = 0;
                cmd.Parameters.Add("@zoneid", SqlDbType.Int).Value = 0;
                cmd.Parameters.Add("@fk_id", SqlDbType.Int).Value = 11401;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dsAllData);
            }

            // -------- Count Attendance --------
            int absent = 0, present = 0, lop = 0, ml = 0, cl = 0, el = 0, wo = 0, outDuty = 0, compoff = 0;

            if (dsAllData.Tables.Count > 0 && dsAllData.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow row in dsAllData.Tables[0].Rows)
                {
                    string status = row["ATTENDANCE"]?.ToString().Trim().ToUpper();

                    switch (status)
                    {
                        case "ABSENT": absent++; break;
                        case "PRESENT": present++; break;
                        case "LOP": lop++; break;
                        case "ML": ml++; break;
                        case "CL": cl++; break;
                        case "EL": el++; break;
                        case "WO": wo++; break;
                        case "OUT DUTY": outDuty++; break;
                        case "COMPOFF": compoff++; break;
                    }
                }
            }

            var labels = new List<string>
{
    "ABSENT", "PRESENT", "LOP", "ML", "CL", "EL", "WO", "Out Duty", "Compoff"
};

            var values = new List<int>
{
    absent, present, lop, ml, cl, el, wo, outDuty, compoff
};

            return Ok(new
            {
                labels = labels,
                values = values,
                Total = values.Sum()
            });
        }

        //Drainage Attendance Zone Wise
        //vamshi

        [HttpGet]
        [Route("api/DrainageAttendanceZoneWise")]
        [AllowAnonymous]
        public IHttpActionResult GetDrainageAttendanceZoneWise()
        {

            DataSet ds = new DataSet();

            using (SqlConnection conx = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("GetDrainageWorkerAttendance_AT", conx);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@dateFrom", SqlDbType.DateTime).Value = "2025-12-10";
                cmd.Parameters.Add("@dateTo", SqlDbType.DateTime).Value = "2025-12-10";
                cmd.Parameters.Add("@wardID", SqlDbType.Int).Value = 0;
                cmd.Parameters.Add("@zoneid", SqlDbType.Int).Value = 0;
                cmd.Parameters.Add("@fk_id", SqlDbType.Int).Value = 11401;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
            }

            DataTable dt = ds.Tables[0];

            // zone-wise grouping
            var zoneGroups = dt.AsEnumerable()
                               .GroupBy(r => Convert.ToInt32(r["ZONE"]))
                               .Select(g => new
                               {
                                   Zone = "Zone " + g.Key,
                                   Total = g.Count()
                               })
                               .OrderBy(x => x.Zone)
                               .ToList();

            // Build response for Plotly
            var labels = zoneGroups.Select(x => x.Zone).ToList();
            var values = zoneGroups.Select(x => x.Total).ToList();

            return Json(new
            {
                labels = labels,
                values = values
            });
        }


        //Drainage Attendance Ward Wise
        //vamshi

        [HttpGet]
        [Route("api/DrainageAttendanceWardWise")]
        [AllowAnonymous]
        public IHttpActionResult GetDrainageAttendanceWardWise()
        {
            DataSet ds = new DataSet();


            // -------- Database Call --------
            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("GetDrainageWorkerAttendance_AT", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@dateFrom", SqlDbType.DateTime).Value = "2025-12-10";
                cmd.Parameters.Add("@dateTo", SqlDbType.DateTime).Value = "2025-12-10";
                cmd.Parameters.Add("@wardID", SqlDbType.Int).Value = 0;
                cmd.Parameters.Add("@zoneid", SqlDbType.Int).Value = 0;
                cmd.Parameters.Add("@fk_id", SqlDbType.Int).Value = 11401;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
            }

            // -------- Safety Validation --------
            if (ds == null || ds.Tables.Count == 0)
            {
                return Ok(new
                {
                    labels = new List<string>(),
                    values = new List<int>(),
                    message = "No table returned from stored procedure."
                });
            }

            DataTable table = ds.Tables[0];

            if (table.Rows.Count == 0)
            {
                return Ok(new
                {
                    labels = new List<string>(),
                    values = new List<int>(),
                    message = "No attendance data available."
                });
            }

            if (!table.Columns.Contains("WARD"))
            {
                return Ok(new
                {
                    labels = new List<string>(),
                    values = new List<int>(),
                    message = "WARD column missing in database result."
                });
            }

            // -------- Group Ward-wise --------
            var wardGroups = table.AsEnumerable()
                                  .GroupBy(r => r["WARD"].ToString())
                                  .Select(g => new
                                  {
                                      Ward = g.Key,
                                      Total = g.Count()
                                  })
                                  .OrderBy(x => x.Ward)
                                  .ToList();

            var labels = wardGroups.Select(x => x.Ward).ToList();
            var values = wardGroups.Select(x => x.Total).ToList();

            // -------- Return JSON --------
            return Ok(new
            {
                labels = labels,
                values = values,
                message = "Success"
            });
        }

        #endregion


        #region CTPTDashboard

        //CTPTDashboard
        //Overall Coverage  need to test based on chat 
        //vamshi

        [HttpGet]
        [Route("api/OverallCoverage")]
        [AllowAnonymous]
        public IHttpActionResult GetOverallCoverage()
        {

            DataSet dsAllData = new DataSet();

            // -------- Database Call --------
            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("SP_CTPT_COVERAGE_REPORT", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@mode", SqlDbType.Int).Value = 1;
                cmd.Parameters.Add("@todate", SqlDbType.DateTime).Value = "2025-12-12";
                //cmd.Parameters.Add("@ENDDATE", SqlDbType.DateTime).Value = "2025-11-10";
                //cmd.Parameters.Add("@zoneid", SqlDbType.Int).Value = 0;
                //cmd.Parameters.Add("@wardID", SqlDbType.Int).Value = 0;
                //cmd.Parameters.Add("@RoleID", SqlDbType.Int).Value = 4;
                //cmd.Parameters.Add("@UserId", SqlDbType.Int).Value = 11401;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dsAllData);
            }

            // -------- Data Processing --------
            var blockLabels = new List<string>();          // CT, PT, UT
            var blockTotals = new List<int>();             // Total per block

            var statusLabels = new List<string>();         // Visited, Invalid, Unvisited
            var statusValues = new List<int>();            // Aggregated values

            int visitedTotal = 0;
            int invalidTotal = 0;
            int unvisitedTotal = 0;

            DataTable dt = dsAllData.Tables[0];

            // ---------- Block-wise aggregation ----------
            var blockSummary = new Dictionary<string, int>();

            foreach (DataRow row in dt.Rows)
            {
                string block = row["BLOCK"].ToString();

                int total = row["TOTAL"] == DBNull.Value ? 0 : Convert.ToInt32(row["TOTAL"]);
                int visited = row["VISITED"] == DBNull.Value ? 0 : Convert.ToInt32(row["VISITED"]);
                int invalid = row["INVALID"] == DBNull.Value ? 0 : Convert.ToInt32(row["INVALID"]);
                int unvisited = row["UNVISITED"] == DBNull.Value ? 0 : Convert.ToInt32(row["UNVISITED"]);

                // ---- Inner ring (Block totals) ----
                if (!blockSummary.ContainsKey(block))
                    blockSummary[block] = 0;

                blockSummary[block] += total;

                // ---- Outer ring (Status totals) ----
                visitedTotal += visited;
                invalidTotal += invalid;
                unvisitedTotal += unvisited;
            }

            // ---------- Prepare Inner Ring ----------
            foreach (var item in blockSummary)
            {
                blockLabels.Add(item.Key);       // CT, PT, UT
                blockTotals.Add(item.Value);
            }

            // ---------- Prepare Outer Ring ----------
            statusLabels.Add("Visited");
            statusValues.Add(visitedTotal);

            statusLabels.Add("Invalid");
            statusValues.Add(invalidTotal);

            statusLabels.Add("Unvisited");
            statusValues.Add(unvisitedTotal);

            // ---------- Return JSON ----------
            return Ok(new
            {
                innerRing = new
                {
                    labels = blockLabels,
                    values = blockTotals
                },
                outerRing = new
                {
                    labels = statusLabels,
                    values = statusValues
                }
            });


        }

        //CTPTDashboard
        //Zone Wise Coverage Split
        //vamshi

        [HttpGet]
        [Route("api/ZoneWiseCoverageSplit")]
        [AllowAnonymous]
        public IHttpActionResult GetZoneWiseCoverageSplit()
        {

            DataSet dsAllData = new DataSet();

            // -------- Database Call --------
            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("SP_CTPT_COVERAGE_REPORT", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@mode", SqlDbType.Int).Value = 2;
                cmd.Parameters.Add("@todate", SqlDbType.DateTime).Value = "2025-12-12";

                cmd.Parameters.Add("@fk_id", SqlDbType.Int).Value = 11401;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dsAllData);
            }

            // -------- Data Processing --------
            var zoneSummary = new Dictionary<string, (int Total, int Visited, int Unvisited, int Invalid)>();

            DataTable dt = dsAllData.Tables[0];

            foreach (DataRow row in dt.Rows)
            {
                string zone = row["ZONENAME"].ToString(); // or ZONE_NO

                int total = row["TOTAL"] == DBNull.Value ? 0 : Convert.ToInt32(row["TOTAL"]);
                int visited = row["VISITED"] == DBNull.Value ? 0 : Convert.ToInt32(row["VISITED"]);
                int unvisited = row["UNVISITED"] == DBNull.Value ? 0 : Convert.ToInt32(row["UNVISITED"]);
                int invalid = row["INVALID"] == DBNull.Value ? 0 : Convert.ToInt32(row["INVALID"]);

                if (!zoneSummary.ContainsKey(zone))
                {
                    zoneSummary[zone] = (0, 0, 0, 0);
                }

                zoneSummary[zone] = (
                    zoneSummary[zone].Total + total,
                    zoneSummary[zone].Visited + visited,
                    zoneSummary[zone].Unvisited + unvisited,
                    zoneSummary[zone].Invalid + invalid
                );
            }

            var innerLabels = new List<string>();
            var innerValues = new List<int>();

            var outerLabels = new List<string>();
            var outerValues = new List<int>();

            foreach (var zone in zoneSummary)
            {
                string zoneName = zone.Key;
                var data = zone.Value;

                // -------- INNER RING (Zone Totals) --------
                innerLabels.Add(zoneName);
                innerValues.Add(data.Total);

                // -------- OUTER RING (Split) --------
                outerLabels.Add($"{zoneName} - Visited");
                outerValues.Add(data.Visited);

                outerLabels.Add($"{zoneName} - Unvisited");
                outerValues.Add(data.Unvisited);

                outerLabels.Add($"{zoneName} - Invalid");
                outerValues.Add(data.Invalid);
            }


            return Ok(new
            {
                innerRing = new
                {
                    labels = innerLabels,
                    values = innerValues
                },
                outerRing = new
                {
                    labels = outerLabels,
                    values = outerValues
                }
            });




        }

        //CTPTDashboard
        //Ward Wise Coverage Split
        //vamshi

        [HttpGet]
        [Route("api/WardWiseCoverageSplit")]
        [AllowAnonymous]
        public IHttpActionResult GetWardWiseCoverageSplit()
        {

            DataSet dsAllData = new DataSet();

            // -------- Database Call --------
            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("SP_CTPT_COVERAGE_REPORT", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@mode", SqlDbType.Int).Value = 2;
                cmd.Parameters.Add("@todate", SqlDbType.DateTime).Value = "2025-12-12";

                cmd.Parameters.Add("@fk_id", SqlDbType.Int).Value = 11401;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dsAllData);
            }

            // -------- Data Processing --------
            var wardSummary = new Dictionary<string, (int Total, int Visited, int Unvisited, int Invalid)>();

            DataTable dt = dsAllData.Tables[0];

            foreach (DataRow row in dt.Rows)
            {
                string ward = row["WARDNAME"].ToString();   // ✅ CHANGE HERE

                int total = row["TOTAL"] == DBNull.Value ? 0 : Convert.ToInt32(row["TOTAL"]);
                int visited = row["VISITED"] == DBNull.Value ? 0 : Convert.ToInt32(row["VISITED"]);
                int unvisited = row["UNVISITED"] == DBNull.Value ? 0 : Convert.ToInt32(row["UNVISITED"]);
                int invalid = row["INVALID"] == DBNull.Value ? 0 : Convert.ToInt32(row["INVALID"]);

                if (!wardSummary.ContainsKey(ward))
                {
                    wardSummary[ward] = (0, 0, 0, 0);
                }

                wardSummary[ward] = (
                    wardSummary[ward].Total + total,
                    wardSummary[ward].Visited + visited,
                    wardSummary[ward].Unvisited + unvisited,
                    wardSummary[ward].Invalid + invalid
                );
            }
            var innerLabels = new List<string>();   // Wards
            var innerValues = new List<int>();

            var outerLabels = new List<string>();
            var outerValues = new List<int>();

            foreach (var ward in wardSummary)
            {
                string wardName = ward.Key;
                var data = ward.Value;

                // -------- INNER RING (Ward Total) --------
                innerLabels.Add(wardName);
                innerValues.Add(data.Total);

                // -------- OUTER RING (Split) --------
                outerLabels.Add($"{wardName} - Visited");
                outerValues.Add(data.Visited);

                outerLabels.Add($"{wardName} - Unvisited");
                outerValues.Add(data.Unvisited);

                outerLabels.Add($"{wardName} - Invalid");
                outerValues.Add(data.Invalid);
            }


            return Ok(new
            {
                innerRing = new
                {
                    labels = innerLabels,
                    values = innerValues
                },
                outerRing = new
                {
                    labels = outerLabels,
                    values = outerValues
                }
            });


        }

        //CTPTDashboard
        //Montly CTPT Coverage Status
        //vamshi

        [HttpGet]
        [Route("api/MonthlyCTPTCoverageStatus")]
        [AllowAnonymous]
        public IHttpActionResult GetMonthlyCTPTCoverageStatus()
        {

            DataSet dsAllData = new DataSet();

            // -------- Database Call --------
            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("SP_CTPT_COVERAGE_REPORT", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@mode", SqlDbType.Int).Value = 2;
                cmd.Parameters.Add("@todate", SqlDbType.DateTime).Value = "2025-12-12";

                cmd.Parameters.Add("@fk_id", SqlDbType.Int).Value = 11401;


                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dsAllData);
            }

            // -------- Data Processing --------
            try
            {
                DataTable dt = dsAllData.Tables[0];

                var tableData = dt.AsEnumerable()
                    .Select(r => new
                    {
                        BLOCK = r["BLOCK"] == DBNull.Value ? "" : r["BLOCK"].ToString(),
                        MOKADAM = r["MOKADAM"] == DBNull.Value ? "" : r["MOKADAM"].ToString(),
                        ZONENAME = r["ZONENAME"] == DBNull.Value ? "" : r["ZONENAME"].ToString(),
                        WARDNAME = r["WARDNAME"] == DBNull.Value ? "" : r["WARDNAME"].ToString(),
                        KOTHINAME = r["KOTHINAME"] == DBNull.Value ? "" : r["KOTHINAME"].ToString(),

                        TOTAL = r["TOTAL"] == DBNull.Value ? 0 : Convert.ToInt32(r["TOTAL"]),
                        VISITED = r["VISITED"] == DBNull.Value ? 0 : Convert.ToInt32(r["VISITED"]),
                        INVALID = r["INVALID"] == DBNull.Value ? 0 : Convert.ToInt32(r["INVALID"]),
                        UNVISITED = r["UNVISITED"] == DBNull.Value ? 0 : Convert.ToInt32(r["UNVISITED"]),

                        PERCENT_VISITED = r["PERCENT_VISITED"] == DBNull.Value
                        ? 0
                        : Math.Round(Convert.ToDecimal(r["PERCENT_VISITED"]), 2)
                    }).ToList();

                return Json(tableData);

            }
            catch (Exception ex)
            {
                // 👇 THIS WILL SHOW REAL ERROR IN BROWSER
                return InternalServerError(ex);
            }


        }
        #endregion

        #region SWEEPERRouteCoveraage
        //Sweeper Route Coverage Ravikrishna

        [HttpGet]
        [Route("api/SWCoverage")]
        [AllowAnonymous]
        public IHttpActionResult GetSWCoveragen()
        {

            DataSet dsAllData = new DataSet();

            // -------- Database Call --------
            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("GetSweeperAttendance_at", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@dateFrom", SqlDbType.DateTime).Value = "2025-12-11";
                cmd.Parameters.Add("@dateTo", SqlDbType.DateTime).Value = "2025-12-11";
                cmd.Parameters.Add("@fk_id", SqlDbType.Int).Value = 11401;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dsAllData);
            }

            // -------- Coverage Buckets --------
            List<string> labels = new List<string>
{
    "0-30%",
    "31-70%",
    "71-100%"
};

            // values → EXACTLY what donut uses
            int zeroTo30 = 0;
            int thirtyOneTo70 = 0;
            int seventyOneTo100 = 0;

            DataTable dt = dsAllData.Tables[0];

            foreach (DataRow row in dt.Rows)
            {
                if (row["ROUTE_DIST"] == DBNull.Value)
                    continue;

                decimal routeDist = Convert.ToDecimal(row["ROUTE_DIST"]);
                if (routeDist <= 0)
                    continue;

                decimal coveredDist = row["COVERED_DIST"] == DBNull.Value
                    ? 0
                    : Convert.ToDecimal(row["COVERED_DIST"]);

                decimal coveragePercent = (coveredDist / routeDist) * 100;

                if (coveragePercent <= 30)
                    zeroTo30++;
                else if (coveragePercent <= 70)
                    thirtyOneTo70++;
                else
                    seventyOneTo100++;
            }

            // -------- FINAL RESPONSE (MATCHES CHART) --------
            return Ok(new
            {
                labels = labels,
                datasets = new[]
                {
        new
        {
            data = new[] { zeroTo30, thirtyOneTo70, seventyOneTo100 }
        }
    }
            });


        }

        [HttpGet]
        [Route("api/SweeperCoverageZoneWise")]
        [AllowAnonymous]
        public IHttpActionResult GetSweeperCoverageZoneWise()
        {

            DataSet dsAllData = new DataSet();

            // -------- Database Call --------
            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("GetSweeperAttendance_at", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@dateFrom", SqlDbType.DateTime).Value = "2025-12-11";
                cmd.Parameters.Add("@dateTo", SqlDbType.DateTime).Value = "2025-12-11";
                cmd.Parameters.Add("@fk_id", SqlDbType.Int).Value = 11401;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dsAllData);
            }

            DataTable dt = dsAllData.Tables[0];

            // Zone → coverage buckets
            Dictionary<int, int[]> zoneCoverage = new Dictionary<int, int[]>();

            foreach (DataRow row in dt.Rows)
            {
                if (row["ZONE"] == DBNull.Value ||
                    row["ROUTE_DIST"] == DBNull.Value ||
                    Convert.ToDecimal(row["ROUTE_DIST"]) == 0)
                    continue;

                int zone = Convert.ToInt32(row["ZONE"]);
                decimal routeDist = Convert.ToDecimal(row["ROUTE_DIST"]);
                decimal coveredDist = row["COVERED_DIST"] == DBNull.Value
                    ? 0
                    : Convert.ToDecimal(row["COVERED_DIST"]);

                decimal percent = (coveredDist / routeDist) * 100;

                if (!zoneCoverage.ContainsKey(zone))
                    zoneCoverage[zone] = new int[3]; // 0-30, 31-70, 71-100

                if (percent <= 30)
                    zoneCoverage[zone][0]++;
                else if (percent <= 70)
                    zoneCoverage[zone][1]++;
                else
                    zoneCoverage[zone][2]++;
            }

            // 🔹 Build EXACT Sunburst-ready response
            var zones = zoneCoverage
                .OrderBy(z => z.Key)
                .Select(z => new
                {
                    zone = z.Key,
                    total = z.Value.Sum(),
                    buckets = new[]
                    {
            new { range = "0-30%", count = z.Value[0] },
            new { range = "31-70%", count = z.Value[1] },
            new { range = "71-100%", count = z.Value[2] }
                    }
                })
                .ToList();

            return Ok(new
            {
                title = "Sweeper Coverage Zone Wise",
                zones = zones
            });
        }


        [HttpGet]
        [Route("api/SweeperCoverageWardWise")]
        [AllowAnonymous]
        public IHttpActionResult GetSweeperCoverageWardWise()
        {

            DataSet dsAllData = new DataSet();

            // -------- Database Call --------


            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("GetSweeperAttendance_at", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@dateFrom", SqlDbType.DateTime).Value = "2025-12-11";
                cmd.Parameters.Add("@dateTo", SqlDbType.DateTime).Value = "2025-12-11";
                cmd.Parameters.Add("@fk_id", SqlDbType.Int).Value = 11401;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dsAllData);
            }

            // -------- Ward-Wise Coverage Processing --------
            DataTable dt = dsAllData.Tables[0];

            // Coverage buckets (ORDER MUST NOT CHANGE)
            List<string> labels = new List<string>
{
    "0-30%",
    "31-70%",
    "71-100%"
};

            // Ward -> [0-30, 31-70, 71-100]
            Dictionary<string, int[]> wardCoverage = new Dictionary<string, int[]>();

            foreach (DataRow row in dt.Rows)
            {
                if (row["WARD"] == DBNull.Value ||
                    row["ROUTE_DIST"] == DBNull.Value ||
                    Convert.ToDecimal(row["ROUTE_DIST"]) == 0)
                    continue;

                string ward = row["WARD"].ToString().Trim();

                decimal routeDist = Convert.ToDecimal(row["ROUTE_DIST"]);
                decimal coveredDist = row["COVERED_DIST"] == DBNull.Value
                    ? 0
                    : Convert.ToDecimal(row["COVERED_DIST"]);

                decimal coveragePercent = (coveredDist / routeDist) * 100;

                if (!wardCoverage.ContainsKey(ward))
                    wardCoverage[ward] = new int[3]; // FIXED SIZE

                if (coveragePercent <= 30)
                    wardCoverage[ward][0]++;
                else if (coveragePercent <= 70)
                    wardCoverage[ward][1]++;
                else
                    wardCoverage[ward][2]++;
            }

            // -------- Build FINAL Dataset (DO NOT CHANGE KEYS) --------
            var dataset = wardCoverage
                .Where(w => w.Value.Sum() > 0) // remove empty wards
                .Select(w => new
                {
                    ward = w.Key,
                    data = new int[]
                    {
            w.Value[0], // 0-30%
            w.Value[1], // 31-70%
            w.Value[2]  // 71-100%
                    }
                })
                .ToList();

            // -------- FINAL JSON RESPONSE (EXACT MATCH FOR SUNBURST) --------
            return Ok(new
            {
                labels = labels,
                dataset = dataset
            });
        }

        [HttpGet]
        [Route("api/Top10Sweepers")]
        [AllowAnonymous]
        public IHttpActionResult GetTop10Sweepers()
        {

            DataSet dsAllData = new DataSet();

            // ================= DATABASE CALL =================


            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("GetSweeperAttendance_at", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@dateFrom", SqlDbType.DateTime).Value = "2025-12-11";
                cmd.Parameters.Add("@dateTo", SqlDbType.DateTime).Value = "2025-12-11";
                cmd.Parameters.Add("@fk_id", SqlDbType.Int).Value = 11401;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dsAllData);
            }

            // ================= TOP 10 LOGIC =================
            DataTable dt = dsAllData.Tables[0];

            var top10Sweepers = dt.AsEnumerable()
    .Where(r =>
        r["ROUTE_DIST"] != DBNull.Value &&
        Convert.ToDecimal(r["ROUTE_DIST"]) > 0)
    .Select(r =>
    {
        decimal totalDist = Convert.ToDecimal(r["ROUTE_DIST"]);
        decimal coveredDist = r["COVERED_DIST"] == DBNull.Value
            ? 0
            : Convert.ToDecimal(r["COVERED_DIST"]);

        decimal percent = Math.Round((coveredDist / totalDist) * 100, 2);

        return new
        {
            SweeperName = r["SWEEPERNAM"].ToString(), // ✅ FIXED
            Zone = Convert.ToInt32(r["ZONE"]),
            Ward = r["WARD"].ToString(),
            Kothi = r["KOTHI"].ToString(),
            Date = Convert.ToDateTime(r["DATE_CLEAN_NEW"]).ToString("yyyy-MM-dd"),
            TotalDistanceInMeter = totalDist,
            CoveredDistance = coveredDist,
            CoveredPercentage = percent
        };
    })
    .OrderByDescending(x => x.CoveredPercentage)
    .ThenByDescending(x => x.CoveredDistance)
    .Take(10)
    .ToList();

            return Json(top10Sweepers);

        }


        [HttpGet]
        [Route("api/Bottom10Sweepers")]
        [AllowAnonymous]
        public IHttpActionResult GetBottom10Sweepers()
        {

            DataSet dsAllData = new DataSet();

            // ================= DATABASE CALL =================
            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("GetSweeperAttendance_at", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@dateFrom", SqlDbType.DateTime).Value = "2025-12-11";
                cmd.Parameters.Add("@dateTo", SqlDbType.DateTime).Value = "2025-12-11";
                cmd.Parameters.Add("@fk_id", SqlDbType.Int).Value = 11401;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dsAllData);
            }

            // ================= BOTTOM 10 (LOWEST ROUTE DISTANCE COVERAGE) =================
            DataTable dt = dsAllData.Tables[0];

            var bottom10Sweepers = dt.AsEnumerable()
                .Where(r =>
                    r["ROUTE_DIST"] != DBNull.Value &&
                    Convert.ToDecimal(r["ROUTE_DIST"]) > 0)
                .Select(r =>
                {
                    decimal totalDist = Convert.ToDecimal(r["ROUTE_DIST"]);
                    decimal coveredDist = r["COVERED_DIST"] == DBNull.Value
                        ? 0
                        : Convert.ToDecimal(r["COVERED_DIST"]);

                    decimal percent = Math.Round((coveredDist / totalDist) * 100, 2);

                    return new
                    {
                        SweeperName = r["SWEEPERNAM"].ToString(),
                        Zone = Convert.ToInt32(r["ZONE"]),
                        Ward = r["WARD"].ToString(),
                        Kothi = r["KOTHI"].ToString(),
                        Date = Convert.ToDateTime(r["DATE_CLEAN_NEW"]).ToString("yyyy-MM-dd"),
                        TotalDistanceInMeter = totalDist,
                        CoveredDistance = coveredDist,
                        CoveredPercentage = percent
                    };
                })
                // 🔽 EXACT AS IMAGE: LOWEST % FIRST
                .OrderBy(x => x.CoveredPercentage)
                .ThenBy(x => x.CoveredDistance)
                .Take(10)
                .ToList();

            return Json(bottom10Sweepers);

        }







        #endregion

        #region SweeperDashboard
        //Sweeper Dashboard Ravikrishna


        [HttpGet]
        [Route("api/SweeperAttendance")]
        [AllowAnonymous]
        public IHttpActionResult GetSweeperAttendance()
        {

            DataSet dsAllData = new DataSet();

            // -------- Database Call --------
            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("GetSweeperAttendance_at", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@dateFrom", SqlDbType.DateTime).Value = "2025-11-10";
                cmd.Parameters.Add("@dateTo", SqlDbType.DateTime).Value = "2025-11-10";
                cmd.Parameters.Add("@fk_id", SqlDbType.Int).Value = 11401;


                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dsAllData);
            }


            // -------- Attendance Chart Data Processing --------
            DataTable dt = dsAllData.Tables[0];

            var attendanceCounts = new Dictionary<string, int>(StringComparer.OrdinalIgnoreCase)
{
    { "PRESENT", 0 },
    { "ABSENT", 0 },
    { "PING", 0 },
    { "WO", 0 },
    { "OUT DUTY", 0 },
    { "EL", 0 },
    { "LOP", 0 },
    { "ML", 0 },
    { "CL", 0 },
    { "COMPOFF", 0 }
};

            foreach (DataRow row in dt.Rows)
            {
                string status = row["ATTENDANCE"]?.ToString()?.Trim()?.ToUpper() ?? "";

                if (attendanceCounts.ContainsKey(status))
                    attendanceCounts[status]++;
            }

            // Total sweepers for donut chart center
            int totalSweepers = attendanceCounts.Values.Sum();

            // -------- Return JSON Response --------
            return Ok(new
            {
                labels = attendanceCounts.Keys.ToList(),
                data = attendanceCounts.Values.ToList(),
                total = totalSweepers
            });

        }


        [HttpGet]
        [Route("api/SweeperAttendanceZoneWise")]
        [AllowAnonymous]
        public IHttpActionResult GetSweeperAttendanceZoneWise()
        {
            // Connection Details (Note: Using the second, explicit connection string)

            DataSet dsAllData = new DataSet();

            // The single, artificial root label required by Plotly Sunburst
            const string ROOT_LABEL = "Total Attendance";

            // -------- Database Call --------
            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("GetSweeperAttendance_at", con);
                cmd.CommandType = CommandType.StoredProcedure;

                // NOTE: These dates are hardcoded. In a production app, they should come from parameters.
                cmd.Parameters.Add("@dateFrom", SqlDbType.DateTime).Value = "2025-12-01";
                cmd.Parameters.Add("@dateTo", SqlDbType.DateTime).Value = "2025-12-01";
                cmd.Parameters.Add("@fk_id", SqlDbType.Int).Value = 11401;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dsAllData);
            }

            // -------- Build Zone-wise Attendance Data (Same as before) --------
            var zones = new Dictionary<int, Dictionary<string, int>>();

            if (dsAllData.Tables.Count == 0 || dsAllData.Tables[0].Rows.Count == 0)
            {
                // Handle case where no data is returned
                return Ok(new { labels = new List<string>(), parents = new List<string>(), values = new List<int>() });
            }

            DataTable dt = dsAllData.Tables[0];

            foreach (DataRow row in dt.Rows)
            {
                if (row["ZONE"] == DBNull.Value || row["ATTENDANCE"] == DBNull.Value)
                    continue;

                int zone = Convert.ToInt32(row["ZONE"]);
                string attendance = row["ATTENDANCE"].ToString().Trim();

                if (!zones.ContainsKey(zone))
                    zones[zone] = new Dictionary<string, int>();

                if (!zones[zone].ContainsKey(attendance))
                    zones[zone][attendance] = 0;

                zones[zone][attendance]++;
            }

            // -------- Prepare Sunburst Chart Data (FIX APPLIED HERE) --------
            var labels = new List<string>();
            //var parents = new List<string>();
            //var values = new List<int>();

            // 1. Add the artificial single root node
            labels.Add(ROOT_LABEL);
            //parents.Add(""); // The single root has no parent (empty string)
            //values.Add(0);   // Set value to 0 so Plotly calculates total sum

            foreach (var zoneEntry in zones)
            {
                string zoneName = "Zone " + zoneEntry.Key;

                // 2. Add Zone node, making the ROOT_LABEL its parent
                labels.Add(zoneName);
                //parents.Add(ROOT_LABEL); // CRITICAL FIX: Parent is the single root
                //values.Add(0);           // Zone node value = 0 so Plotly calculates the sum of its children (statuses)

                // 3. Add Attendance Status nodes, making the Zone their parent
                foreach (var att in zoneEntry.Value)
                {
                    // Only add nodes with a positive count
                    if (att.Value > 0)
                    {
                        // Format label as "STATUS (Count)"
                        labels.Add(att.Key + " (" + att.Value + ")");
                        //parents.Add(zoneName);
                        //values.Add(att.Value);
                    }
                }
            }

            // -------- Return JSON Response --------
            return Ok(new
            {
                labels = labels,
                //parents = parents,
                //values = values
            });
        }


        [HttpGet]
        [Route("api/SweeperAttendanceWardWise")]
        [AllowAnonymous]
        public IHttpActionResult GetSweeperAttendanceWardWise()
        {

            DataSet dsAllData = new DataSet();

            // -------- Database Call --------
            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("GetSweeperAttendance_at", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@dateFrom", SqlDbType.DateTime).Value = "2025-11-11";
                cmd.Parameters.Add("@dateTo", SqlDbType.DateTime).Value = "2025-11-11";
                cmd.Parameters.Add("@fk_id", SqlDbType.Int).Value = 11401;


                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dsAllData);
            }

            // -------- Ward-wise Attendance Processing --------
            DataTable dt = dsAllData.Tables[0];

            var wardGroups = dt.AsEnumerable()
                .GroupBy(r => r["WARD"].ToString())
                .Select(g => new
                {
                    Ward = g.Key,
                    Present = g.Count(r => r["ATTENDANCE"].ToString() == "PRESENT"),
                    Absent = g.Count(r => r["ATTENDANCE"].ToString() == "ABSENT"),
                    Lop = g.Count(r => r["ATTENDANCE"].ToString() == "LOP"),
                    Other = g.Count(r =>
                        r["ATTENDANCE"].ToString() != "PRESENT" &&
                        r["ATTENDANCE"].ToString() != "ABSENT" &&
                        r["ATTENDANCE"].ToString() != "LOP")
                })
                .ToList();

            // -------- Prepare JSON for Sunburst Chart --------
            return Ok(new
            {
                labels = wardGroups.Select(x => x.Ward),

                datasets = new[]
                {
        new {
            label = "Present",
            data = wardGroups.Select(x => x.Present)
        },
        new {
            label = "Absent",
            data = wardGroups.Select(x => x.Absent)
        },
        new {
            label = "LOP",
            data = wardGroups.Select(x => x.Lop)
        },
        new {
            label = "Other",
            data = wardGroups.Select(x => x.Other)
        }
    }
            });


        }

        [HttpGet]
        [Route("api/SweeperAttendanceTrend")]
        [AllowAnonymous]
        public IHttpActionResult GetSweeperAttendanceTrend()
        {

            DataSet dsAllData = new DataSet();

            // -------- Database Call --------
            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("GetSweeperAttendance_at", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@dateFrom", SqlDbType.DateTime).Value = "2025-12-01";
                cmd.Parameters.Add("@dateTo", SqlDbType.DateTime).Value = "2025-12-11";
                cmd.Parameters.Add("@fk_id", SqlDbType.Int).Value = 11401;


                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dsAllData);
            }

            DataTable dt = dsAllData.Tables[0];

            var attendanceStatuses = new List<string>
{
    "PRESENT", "ABSENT", "CL", "ML", "LOP", "WO", "PING", "OUT DUTY", "COMPOFF"
};

            var grouped = dt.AsEnumerable()
                .GroupBy(r => Convert.ToDateTime(r["DATE_CLEAN_NEW"]).ToString("yyyy-MM-dd"))
                .Select(g => new
                {
                    Date = g.Key,
                    StatusCounts = attendanceStatuses.ToDictionary(
                        s => s,
                        s => g.Count(r => r["ATTENDANCE"] != DBNull.Value &&
                                          r["ATTENDANCE"].ToString().ToUpper() == s)
                    )
                })
                .OrderBy(x => x.Date)
                .ToList();

            // ---------- Build JSON response ----------
            var labels = grouped.Select(x => x.Date).ToList();

            var datasets = attendanceStatuses.Select(status => new
            {
                label = status,
                data = grouped.Select(x => x.StatusCounts[status]).ToList()
            }).ToList();

            return Ok(new
            {
                labels = labels,
                datasets = datasets
            });

        }

        #endregion

        #region IMEIPingStatus

        // IMEIPingStatus Ravikrishna

        [HttpGet]
        [Route("api/DevicesLastPing")]
        [AllowAnonymous]
        public IHttpActionResult GetDevicesLastPing(string IMEI = null)
        {

            DataSet dsAllData = new DataSet();

            // -------- Database Call --------
            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("GetLastConnectedTimes_SR", con);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dsAllData);
            }

            // -------- Correct Data Processing for Wet Waste Chart --------
            var summary = new Dictionary<string, int>();

            DataTable dt = dsAllData.Tables[0];

            foreach (DataRow row in dt.Rows)
            {
                // ✅ IMEI FILTER (without SP change)
                if (!string.IsNullOrEmpty(IMEI))
                {
                    if (row["IMEI"] == DBNull.Value ||
                        row["IMEI"].ToString() != IMEI)
                        continue;
                }
                if (row["DATE_DIFFERENCE_BINS"] == DBNull.Value)
                    continue;

                string bucket = row["DATE_DIFFERENCE_BINS"].ToString().Trim();

                // Optional: filter by Vendor
                // if (row["Vendor"].ToString() != "PMC") continue;
                if (!summary.ContainsKey(bucket))
                    summary[bucket] = 0;   // ✅ initialize first
                summary[bucket]++;

            }
            string[] order =
                {
                "TODAY",
    "YESTERDAY",
    "2 DAYS AGO",
    "3 DAYS AGO",
    "4 DAYS AGO",
    "5 DAYS AGO",
    "6 DAYS AGO",
    "7 DAYS AGO",
    "8-30 DAYS AGO",
    "31-60 DAYS AGO",
    "61-90 DAYS AGO",
    "MORE THAN 90 DAYS AGO"

            };

            var labels = new List<string>();
            var values = new List<int>();

            foreach (string key in order)
            {
                if (summary.ContainsKey(key))
                {
                    labels.Add(key);
                    values.Add(summary[key]);
                }
            }
            // -------- Return JSON Response --------
            return Ok(new
            {
                labels = labels,
                datasets = new[]
    {
        new
        {
            label = "IMEI Counts",
            data = values
        }
    }
            });



        }


        [HttpGet]
        [Route("api/HourWisePingforToday")]
        [AllowAnonymous]
        public IHttpActionResult GetHourWisePingforToday(string IMEI = null)
        {

            DataSet dsAllData = new DataSet();

            // -------- Database Call --------
            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("GetLastConnectedTimes_SR", con);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dsAllData);
            }

            // -------- Correct Data Processing for Wet Waste Chart --------
            var summary = new Dictionary<int, int>();

            DataTable dt = dsAllData.Tables[0];

            foreach (DataRow row in dt.Rows)
            {
                // ✅ IMEI FILTER (without SP change)
                if (!string.IsNullOrEmpty(IMEI))
                {
                    if (row["IMEI"] == DBNull.Value ||
                        row["IMEI"].ToString() != IMEI)
                        continue;
                }
                // ✅ Only TODAY data
                if (row["DATE_DIFFERENCE_BINS"] == DBNull.Value ||
                    row["DATE_DIFFERENCE_BINS"].ToString().Trim().ToUpper() != "TODAY")
                    continue;

                if (row["HOUR_OF_DAY"] == DBNull.Value)
                    continue;

                int hour = Convert.ToInt32(row["HOUR_OF_DAY"]);

                if (!summary.ContainsKey(hour))
                    summary[hour] = 0;

                summary[hour]++;
            }
            var labels = new List<int>();
            var values = new List<int>();

            for (int hour = 0; hour <= 23; hour++)
            {
                labels.Add(hour);
                values.Add(summary.ContainsKey(hour) ? summary[hour] : 0);
            }

            // -------- Return JSON Response --------
            return Ok(new
            {
                labels = labels,
                datasets = new[]
    {
        new
        {
            label = "IMEI Counts",
            data = values
        }
    }
            });



        }

        #endregion

        #region CollectionWorkerDashboard

        //C W Attendence Dashboard

        [HttpGet]
        [Route("api/CWAttendanceChart")]
        [AllowAnonymous]
        public IHttpActionResult GetCWAttendanceChart()
        {


            DataSet dsAllData = new DataSet();

            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("Get_CW_Attendance_AT", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@dateFrom", SqlDbType.DateTime).Value = "2025-12-15";
                cmd.Parameters.Add("@dateTo", SqlDbType.DateTime).Value = "2025-12-15";
                cmd.Parameters.Add("@fk_id", SqlDbType.Int).Value = 11401;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dsAllData);
            }

            DataTable dt = dsAllData.Tables[0];

            // -------- Group exactly as chart --------
            var summary = dt.AsEnumerable()
                .GroupBy(r =>
                {
                    string att = r.Field<string>("ATTENDANCE");

                    if (att == "ABSENT") return "ABSENT";
                    if (att == "PING") return "PING";
                    if (att == "DEVICE AT CC") return "Device at CC";
                    if (att == "PRESENT") return "PRESENT (ON ROUTE)";

                    return null;
                })
                .Where(g => g.Key != null)
                .Select(g => new { Status = g.Key, Count = g.Count() })
                .ToList();

            string[] labels =
            {
    "ABSENT",
    "PING",
    "Device at CC",
    "PRESENT (ON ROUTE)"
};

            int[] data = labels
                .Select(l => summary.FirstOrDefault(x => x.Status == l)?.Count ?? 0)
                .ToArray();

            return Ok(new
            {
                labels = labels,
                datasets = new[]
                {
        new
        {
            label = "CW Attendance",
            data = data
        }
    }
            });
        }



        [HttpGet]
        [Route("api/CWAttendanceZoneWise")]
        [AllowAnonymous]
        public IHttpActionResult GetCWAttendanceZoneWise()
        {

            DataSet ds = new DataSet();

            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("Get_CW_Attendance_AT", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@dateFrom", SqlDbType.DateTime).Value = "2025-12-15";
                cmd.Parameters.Add("@dateTo", SqlDbType.DateTime).Value = "2025-12-15";
                cmd.Parameters.Add("@fk_id", SqlDbType.Int).Value = 11401;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
            }

            if (ds.Tables.Count == 0 || ds.Tables[0].Rows.Count == 0)
            {
                return Ok(new { labels = new string[] { }, parents = new string[] { }, values = new int[] { } });
            }

            DataTable dt = ds.Tables[0];

            List<string> labels = new List<string>();
            List<string> parents = new List<string>();
            List<int> values = new List<int>();

            // 🔹 GROUP BY ZONE (NULL SAFE)
            var zoneGroups = dt.AsEnumerable()
                .Where(r => r["ZONE"] != DBNull.Value)
                .GroupBy(r => Convert.ToInt32(r["ZONE"]))
                .OrderBy(g => g.Key);

            foreach (var zone in zoneGroups)
            {
                string zoneLabel = "Zone " + zone.Key;
                int zoneTotal = zone.Count();

                // ---- INNER RING ----
                labels.Add(zoneLabel);
                parents.Add("");
                values.Add(zoneTotal);

                // ---- OUTER RING (ATTENDANCE) ----
                var attGroups = zone
                    .Where(r => r["ATTENDANCE"] != DBNull.Value)
                    .GroupBy(r => r["ATTENDANCE"].ToString());

                foreach (var att in attGroups)
                {
                    labels.Add(att.Key);
                    parents.Add(zoneLabel);
                    values.Add(att.Count());
                }
            }

            return Ok(new
            {
                labels = labels,
                parents = parents,
                values = values
            });
        }




        // C W Attendence Ward Wise
        // Rahul

        [HttpGet]
        [Route("api/CWAttendanceWardWise")]
        [AllowAnonymous]
        public IHttpActionResult GeCWAttendanceWardWise()
        {

            DataSet dsAllData = new DataSet();

            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("Get_CW_Attendance_AT", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@dateFrom", SqlDbType.DateTime).Value = "2025-12-15";
                cmd.Parameters.Add("@dateTo", SqlDbType.DateTime).Value = "2025-12-15";
                cmd.Parameters.Add("@fk_id", SqlDbType.Int).Value = 11401;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dsAllData);
            }

            if (dsAllData.Tables.Count == 0 || dsAllData.Tables[0].Rows.Count == 0)
            {
                return Ok(new
                {
                    labels = new string[] { },
                    parents = new string[] { },
                    values = new int[] { }
                });
            }

            DataTable dt = dsAllData.Tables[0];

            List<string> labels = new List<string>();
            List<string> parents = new List<string>();
            List<int> values = new List<int>();

            // -------- INNER RING : WARDS --------
            var wardGroups = dt.AsEnumerable()
                .GroupBy(r => r.Field<string>("WARD"))
                .OrderBy(g => g.Key);

            foreach (var ward in wardGroups)
            {
                string wardLabel = ward.Key ?? "UNKNOWN";
                int wardTotal = ward.Count();

                labels.Add(wardLabel);
                parents.Add("");          // root
                values.Add(wardTotal);

                // -------- OUTER RING : ATTENDANCE --------
                var attGroups = ward.GroupBy(r => r.Field<string>("ATTENDANCE"));

                foreach (var att in attGroups)
                {
                    labels.Add($"{wardLabel} {att.Key}");
                    parents.Add(wardLabel);
                    values.Add(att.Count());
                }
            }

            return Ok(new
            {
                labels = labels,
                parents = parents,
                values = values
            });
        }


        #endregion

        #region VehicleDashboard

        //Bharath Edited(12-12-25)


        // start Rahul 
        // Vehicle status
        //Rahul 

        //vechile stautus  and sweeper vehicle status are same

        // Zone Wise Vehicle Status
        //Rahul 

        [HttpGet]
        [Route("api/ZoneWiseVehicleStatus")]
        [AllowAnonymous]
        public IHttpActionResult GetZoneWiseVehicleStatus()
        {

            DataSet dsAllData = new DataSet();

            // -------- Database Call --------
            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("Proc_VehicleMap_1", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@mode", SqlDbType.Int).Value = 14;
                //cmd.Parameters.Add("@STARTDATE", SqlDbType.DateTime).Value = "2025-11-10";
                //cmd.Parameters.Add("@ENDDATE", SqlDbType.DateTime).Value = "2025-11-10";
                cmd.Parameters.Add("@zoneid", SqlDbType.Int).Value = 0;
                cmd.Parameters.Add("@wardID", SqlDbType.Int).Value = 0;
                cmd.Parameters.Add("@RoleID", SqlDbType.Int).Value = 4;
                cmd.Parameters.Add("@UserId", SqlDbType.Int).Value = 11401;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dsAllData);
            }

            // -------- Data Processing --------
            var labels = new List<string>();
            var values = new List<decimal>();

            // Read Zone wise Vehicle Status table
            if (dsAllData.Tables.Count > 1 && dsAllData.Tables[1].Rows.Count > 0)
            {
                DataRow row = dsAllData.Tables[1].Rows[0];

                decimal idle = row["Idle"] == DBNull.Value ? 0 : Convert.ToDecimal(row["Idle"]);
                decimal running = row["Running"] == DBNull.Value ? 0 : Convert.ToDecimal(row["Running"]);
                decimal inactive = row["InActive"] == DBNull.Value ? 0 : Convert.ToDecimal(row["InActive"]);
                decimal breakdown = row["Breakdown"] == DBNull.Value ? 0 : Convert.ToDecimal(row["Breakdown"]);
                decimal powercut = row["Powercut"] == DBNull.Value ? 0 : Convert.ToDecimal(row["Powercut"]);

                labels.Add("Idle");
                values.Add(idle);

                labels.Add("Running");
                values.Add(running);

                labels.Add("InActive");
                values.Add(inactive);

                labels.Add("Breakdown");
                values.Add(breakdown);

                labels.Add("Powercut");
                values.Add(powercut);
            }

            return Ok(new
            {
                labels = labels,
                values = values
            });


        }

        // Vendor wise Vehicle Status
        //Rahul 

        [HttpGet]
        [Route("api/VendorwiseVehicleStatus")]
        [AllowAnonymous]
        public IHttpActionResult GetVendorwiseVehicleStatus()
        {

            DataSet dsAllData = new DataSet();

            // -------- Database Call --------
            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("Proc_VehicleMap_1", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@mode", SqlDbType.Int).Value = 14;
                //cmd.Parameters.Add("@STARTDATE", SqlDbType.DateTime).Value = "2025-11-10";
                //cmd.Parameters.Add("@ENDDATE", SqlDbType.DateTime).Value = "2025-11-10";
                cmd.Parameters.Add("@zoneid", SqlDbType.Int).Value = 0;
                cmd.Parameters.Add("@wardID", SqlDbType.Int).Value = 0;
                cmd.Parameters.Add("@RoleID", SqlDbType.Int).Value = 4;
                cmd.Parameters.Add("@UserId", SqlDbType.Int).Value = 11401;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dsAllData);
            }

            // -------- Data Processing --------
            var labels = new List<string>();
            var values = new List<decimal>();

            // Read vendor wise Vehicle Status table
            if (dsAllData.Tables.Count > 1 && dsAllData.Tables[1].Rows.Count > 0)
            {
                DataRow row = dsAllData.Tables[1].Rows[0];

                decimal idle = row["Idle"] == DBNull.Value ? 0 : Convert.ToDecimal(row["Idle"]);
                decimal running = row["Running"] == DBNull.Value ? 0 : Convert.ToDecimal(row["Running"]);
                decimal inactive = row["InActive"] == DBNull.Value ? 0 : Convert.ToDecimal(row["InActive"]);
                decimal breakdown = row["Breakdown"] == DBNull.Value ? 0 : Convert.ToDecimal(row["Breakdown"]);
                decimal powercut = row["Powercut"] == DBNull.Value ? 0 : Convert.ToDecimal(row["Powercut"]);

                labels.Add("Idle");
                values.Add(idle);

                labels.Add("Running");
                values.Add(running);

                labels.Add("InActive");
                values.Add(inactive);

                labels.Add("Breakdown");
                values.Add(breakdown);

                labels.Add("Powercut");
                values.Add(powercut);
            }

            return Ok(new
            {
                labels = labels,
                values = values
            });


        }

        // Vehicle Type wise Status
        //Rahul 
        [HttpGet]
        [Route("api/VehicleTypewiseStatus")]
        [AllowAnonymous]
        public IHttpActionResult GetVehicleTypewiseStatus()
        {

            DataSet dsAllData = new DataSet();

            // -------- Database Call --------
            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("Proc_VehicleMap_1", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@mode", SqlDbType.Int).Value = 14;
                //cmd.Parameters.Add("@STARTDATE", SqlDbType.DateTime).Value = "2025-11-10";
                //cmd.Parameters.Add("@ENDDATE", SqlDbType.DateTime).Value = "2025-11-10";
                cmd.Parameters.Add("@zoneid", SqlDbType.Int).Value = 0;
                cmd.Parameters.Add("@wardID", SqlDbType.Int).Value = 0;
                cmd.Parameters.Add("@RoleID", SqlDbType.Int).Value = 4;
                cmd.Parameters.Add("@UserId", SqlDbType.Int).Value = 11401;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dsAllData);
            }

            // -------- Data Processing --------
            DataTable dt = dsAllData.Tables[0];

            var labels = new List<string>();
            var running = new List<int>();
            var idle = new List<int>();
            var inactive = new List<int>();
            var breakdown = new List<int>();
            var powercut = new List<int>();

            var groups = dt.AsEnumerable()
                .GroupBy(r => SafeGet(r, "vehicleType"));

            foreach (var grp in groups)
            {
                if (string.IsNullOrWhiteSpace(grp.Key))
                    continue;

                labels.Add(grp.Key);

                running.Add(grp.Count(r =>
                    SafeGet(r, "LstRunIdletime").Equals("Running", StringComparison.OrdinalIgnoreCase)));

                idle.Add(grp.Count(r =>
                    SafeGet(r, "LstRunIdletime").Equals("Idle", StringComparison.OrdinalIgnoreCase)));

                // Treat RED as Breakdown
                breakdown.Add(grp.Count(r =>
                    SafeGet(r, "color").Equals("Red", StringComparison.OrdinalIgnoreCase)));

                // Optional logic (adjust if needed)
                inactive.Add(0);
                powercut.Add(0);
            }

            return Ok(new
            {
                labels = labels,
                datasets = new[]
                {
            new { label = "Running", data = running },
            new { label = "Idle", data = idle },
            new { label = "Breakdown", data = breakdown },
            new { label = "InActive", data = inactive },
            new { label = "Powercut", data = powercut }
        }
            });

        }
        private string SafeGet(DataRow row, string columnName)
        {
            return row.Table.Columns.Contains(columnName) && row[columnName] != DBNull.Value
                ? row[columnName].ToString()
                : "";
        }

        private int SafeCount(IEnumerable<DataRow> rows, Func<DataRow, bool> predicate)
        {
            return rows.Count(predicate);
        }
        // end rahul
        #endregion

        #region Masters
      
        [HttpGet]
        [Route("api/GetzoneAPI")]
        [AllowAnonymous]
        public IHttpActionResult Getzone()
        {
            try
            {
                DataSet dsAllData = new DataSet();

                // -------- Database Call --------
                using (SqlConnection con = new SqlConnection(connnString))
                {
                    SqlCommand cmd = new SqlCommand("proc_GetZones_Dashboard", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@Accid", SqlDbType.Int).Value = 11401;
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dsAllData);
                }

                // -------- Data Processing --------
                var labels = new List<string>();
                var values = new List<int>();

                if (dsAllData.Tables.Count > 0)
                {
                    foreach (DataRow row in dsAllData.Tables[0].Rows)
                    {
                        string zoneName = row["zonename"] == DBNull.Value
                            ? "UNKNOWN"
                            : row["zonename"].ToString();

                        int zoneId = row["zoneid"] == DBNull.Value
                            ? 0
                            : Convert.ToInt32(row["zoneid"]);

                        labels.Add(zoneName);
                        values.Add(zoneId);
                    }
                }

                // -------- API JSON Response --------
                return Ok(new
                {
                    labels = labels,
                    values = values
                });

            }
            catch (Exception ex)
            {
                return Ok(ex);
            }
            // Automatically converts to JSON
        }

        [HttpGet]
        [Route("api/GetWardAPI")]
        [AllowAnonymous]
        public IHttpActionResult GetWard( int Zoneid)
        {
            try
            {
                //int Zoneid = 102;
                DataSet dsAllData = new DataSet();

                // -------- Database Call --------
                using (SqlConnection con = new SqlConnection(connnString))
                {
                    SqlCommand cmd = new SqlCommand("proc_GetWards_Dashboard", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@Accid", SqlDbType.Int).Value = 11401;
                    cmd.Parameters.Add("@ZoneId", SqlDbType.Int).Value = Zoneid;
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dsAllData);
                }

                // -------- Data Processing --------
                var labels = new List<string>();
                var values = new List<int>();

                if (dsAllData.Tables.Count > 0)
                {
                    foreach (DataRow row in dsAllData.Tables[0].Rows)
                    {
                        string WardName = row["wardName"] == DBNull.Value
                            ? "UNKNOWN"
                            : row["wardName"].ToString();

                        int WardId = row["PK_wardId"] == DBNull.Value
                            ? 0
                            : Convert.ToInt32(row["PK_wardId"]);

                        labels.Add(WardName);
                        values.Add(WardId);
                    }
                }

                // -------- API JSON Response --------
                return Ok(new
                {
                    labels = labels,
                    values = values
                });

            }
            catch (Exception ex)
            {
                return Ok(ex);
            }
            // Automatically converts to JSON
        }

        [HttpGet]
        [Route("api/GetKothiAPI")]
        [AllowAnonymous]
        public IHttpActionResult GetKothi(int Wardid)
        {
            try
            {
                //int Wardid = 1023;
                DataSet dsAllData = new DataSet();

                // -------- Database Call --------
                using (SqlConnection con = new SqlConnection(connnString))
                {
                    SqlCommand cmd = new SqlCommand("proc_GetKothi_Dashboard", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@Accid", SqlDbType.Int).Value = 11401;
                    cmd.Parameters.Add("@WardId", SqlDbType.Int).Value = Wardid;
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dsAllData);
                }

                // -------- Data Processing --------
                var labels = new List<string>();
                var values = new List<int>();

                if (dsAllData.Tables.Count > 0)
                {
                    foreach (DataRow row in dsAllData.Tables[0].Rows)
                    {
                        string KothiName = row["KothiName"] == DBNull.Value
                            ? "UNKNOWN"
                            : row["KothiName"].ToString();

                        int kothiId = row["pk_kothiid"] == DBNull.Value
                            ? 0
                            : Convert.ToInt32(row["pk_kothiid"]);

                        labels.Add(KothiName);
                        values.Add(kothiId);
                    }
                }

                // -------- API JSON Response --------
                return Ok(new
                {
                    labels = labels,
                    values = values
                });

            }
            catch (Exception ex)
            {
                return Ok(ex);
            }
            // Automatically converts to JSON
        }

        [HttpGet]
        [Route("api/GetsweeperNameAPI")]
        [AllowAnonymous]
        public IHttpActionResult GetSweepers(int zoneId, int wardId, int kothiId)
        {
            //zoneId = 102;
            //wardId = 1023;
            //kothiId = 155;
            DataTable dt = new DataTable();

            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("SP_GetSweeperByZoneWardKothi_Dashboard", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@ZoneId", zoneId);
                cmd.Parameters.AddWithValue("@WardId", wardId);
                cmd.Parameters.AddWithValue("@KothiId", kothiId);
                cmd.Parameters.Add("@Fk_EmpId", SqlDbType.Int).Value = 11401;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
            }

            var sweepers = dt.AsEnumerable()
        .Where(r => r["SWEEPERNAM"] != DBNull.Value)
        .Select(r => r["SWEEPERNAM"].ToString())
        .Distinct()   // optional but recommended
        .ToList();

            return Ok(new
            {
                labels = sweepers,
                values = sweepers   // ✅ Same as labels (no SweeperId)
            });
        }


        [HttpGet]
        [Route("api/GetIMENameAPI")]
        [AllowAnonymous]
        public IHttpActionResult GetNameIME()
        {
            DataSet dsAllData = new DataSet();

            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("GetLastConnectedTimes_SR", con);
                cmd.CommandType = CommandType.StoredProcedure;

                //cmd.Parameters.AddWithValue("@Mode", 4);
                //cmd.Parameters.AddWithValue("@UserID", 11401);
                cmd.CommandTimeout = 300; // 5 minutes

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.SelectCommand.CommandTimeout = 300;
                da.Fill(dsAllData);
            }

            var data = dsAllData.Tables[0]
         .AsEnumerable()
         .Where(r => r["VEHICLENAME"] != DBNull.Value && r["vehicle_iid"] != DBNull.Value)
         .Select(r => new
         {
             VehicleId = Convert.ToInt32(r["vehicle_iid"]),
             VehicleName = r["VEHICLENAME"].ToString()
         })
         .GroupBy(x => new { x.VehicleId, x.VehicleName })
         .Select(g => g.Key)
         .OrderBy(x => x.VehicleName)
         .ToList();

            var labels = data.Select(x => x.VehicleName).ToList();
            var values = data.Select(x => x.VehicleId).ToList();

            // ✅ EXACT FORMAT YOU WANT
            return Ok(new
            {
                labels = labels,
                values = values
            });

        }

        [HttpGet]
        [Route("api/GetIMEVehicleTypeAPI")]
        [AllowAnonymous]
        public IHttpActionResult GetIMEVehicleType()
        {
            DataSet dsAllData = new DataSet();

            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("GetLastConnectedTimes_SR", con);
                cmd.CommandType = CommandType.StoredProcedure;

                //cmd.Parameters.AddWithValue("@Mode", 4);
                //cmd.Parameters.AddWithValue("@UserID", 11401);
                cmd.CommandTimeout = 300; // 5 minutes

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.SelectCommand.CommandTimeout = 300;
                da.Fill(dsAllData);
            }

            var data = dsAllData.Tables[0]
         .AsEnumerable()
         .Where(r => r["VEHICLETYPE"] != DBNull.Value)
         .Select(r => r["VEHICLETYPE"].ToString().Trim())
         .Distinct()
         .OrderBy(x => x)
         .ToList();

            var labels = data;
            var values = data;

            // ✅ REQUIRED RESPONSE FORMAT
            return Ok(new
            {
                labels = labels,
                values = values
            });
        }

        [HttpGet]
        [Route("api/GetIMENoAPI")]
        [AllowAnonymous]
        public IHttpActionResult GetIMENO()
        {
            DataSet dsAllData = new DataSet();

            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("GetLastConnectedTimes_SR", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 300;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dsAllData);
            }

            // ✅ DISTINCT IMEI NO
            var data = dsAllData.Tables[0]
                .AsEnumerable()
                .Where(r => r["IMEI"] != DBNull.Value)
                .Select(r => r["IMEI"].ToString().Trim())
                .Distinct()
                .OrderBy(x => x)
                .ToList();

            var labels = data;   // IMEI shown
            var values = data;   // IMEI value

            return Ok(new
            {
                labels = labels,
                values = values
            });
        }

        [HttpGet]
        [Route("api/GetVehicleFeederAPI")]
        [AllowAnonymous]
        public IHttpActionResult GetVehicleFeeder()
        {
            DataSet dsAllData = new DataSet();

            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("GetLastConnectedTimes_SR", con);
                cmd.CommandType = CommandType.StoredProcedure;

                //cmd.Parameters.AddWithValue("@Mode", 12);
                //cmd.Parameters.AddWithValue("@UserID", 11401);
                cmd.CommandTimeout = 300; // 5 minutes

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.SelectCommand.CommandTimeout = 300;
                da.Fill(dsAllData);
            }

            var data = dsAllData.Tables[0]
         .AsEnumerable()
         .Where(r => r["VEHICLENAME"] != DBNull.Value && r["vehicle_iid"] != DBNull.Value)
         .Select(r => new
         {
             VehicleId = Convert.ToInt32(r["vehicle_iid"]),
             VehicleName = r["VEHICLENAME"].ToString()
         })
         .GroupBy(x => new { x.VehicleId, x.VehicleName })
         .Select(g => g.Key)
         .OrderBy(x => x.VehicleName)
         .ToList();

            var labels = data.Select(x => x.VehicleName).ToList();
            var values = data.Select(x => x.VehicleId).ToList();

            // ✅ EXACT FORMAT YOU WANT
            return Ok(new
            {
                labels = labels,
                values = values
            });

        }

        [HttpGet]
        [Route("api/GetVendorAPI")]
        [AllowAnonymous]
        public IHttpActionResult GetStatus()
        {
            DataSet dsAllData = new DataSet();

            using (SqlConnection con = new SqlConnection(connnString))
            {
                SqlCommand cmd = new SqlCommand("GetLastConnectedTimes_SR", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 300;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dsAllData);
            }

            // ✅ DISTINCT IMEI NO
            var data = dsAllData.Tables[0]
                .AsEnumerable()
                .Where(r => r["Vendor"] != DBNull.Value)
                .Select(r => r["Vendor"].ToString().Trim())
                .Distinct()
                .OrderBy(x => x)
                .ToList();

            var labels = data;   // IMEI shown
            var values = data;   // IMEI value

            return Ok(new
            {
                labels = labels,
                values = values
            });
        }
        #endregion
    }

}