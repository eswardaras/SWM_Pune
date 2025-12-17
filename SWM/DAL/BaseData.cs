using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace SWM.DAL
{
    public class BaseData
    {
        #region "Ojects"
        protected DataSet dSet;
        protected SqlDataReader sread;
        protected SqlCommand dCmd;
        protected SqlDataAdapter Sda;
        protected SqlDataReader read;
        protected DataTable dt;
        protected DataTable dt1;
        protected DataTable dt2;
        protected SqlCommand Scmd;
        protected SqlConnection conn;
        protected DataSet ds;
        #endregion
        public BaseData()
        {
            //
            // TODO: Add constructor logic here
            //
            // string connnString1 = EncrptedConnectionString();

            //====172.16.1.114====//FDA server
            // string connnString = "Data Source = SRV-FDA; Initial Catalog = FDA_DEMO; User ID = sa; Password = scs@123; Connect Timeout = 99999;";// DecrptedConnectionString(); //"Data Source = SRV-TESTDB; Initial Catalog = FDA_DEMO; User ID = sa; Password = Admfb@100; Connect Timeout = 99999;"; //
            //string connnString =  DecrptedConnectionString(); //"Data Source = SRV-TESTDB; Initial Catalog = FDA_DEMO; User ID = sa; Password = Admfb@100; Connect Timeout = 99999;"; //

            //====34.208.38.238====//Live Server
            //string connnString = "Data Source = 34.208.38.238; Initial Catalog = SWMSystem; User ID = sa; Password = Think@123; Connect Timeout = 99999;";// DecrptedConnectionString(); //"Data Source = SRV-TESTDB; Initial Catalog = FDA_DEMO; User ID = sa; Password = Admfb@100; Connect Timeout = 99999;"; //
            //====192.168.0.100====//SCS Server
            //string connnString = "Data Source = SCS_SERVER\\SWMDEV_SCS,1435; Initial Catalog = SWMSystem; User ID = sa; Password = scs@123; Connect Timeout = 99999; ";
            //conn = new SqlConnection(connnString);

            //====3.108.6.242====//Cloud
            //string connnString = "Data Source = 3.108.6.242; Initial Catalog = SWMSystem; User ID = sa; Password = scs@1234; Connect Timeout = 99999; ";
            //conn = new SqlConnection(connnString);

            //====13.200.33.105====//Cloud new IP 19072023 (13.200.33.105)
            //string connnString = "Data Source = 13.200.33.105; Initial Catalog = SWMSystem; User ID = sa; Password = scs@1234; Connect Timeout = 99999; ";
            //conn = new SqlConnection(connnString);

            ////====52.66.47.55====//Cloud new IP 02082023 (52.66.47.55) live
            //string connnString = "Data Source = 52.66.47.55; Initial Catalog = SWMSystem; User ID = sa; Password = web123!@#server; Connect Timeout = 99999; ";
            //conn = new SqlConnection(connnString);

            //====52.66.47.55====//Cloud new IP 02082023 (52.66.47.55) live
            //string connnString = "Data Source = 52.66.47.55; Initial Catalog = SWMSystem; User ID = webadmin; Password = Admin@123!@#; Connect Timeout = 99999; ";
            //conn = new SqlConnection(connnString);

            //====52.66.47.55====//Cloud new IP 02082023 (52.66.47.55) live
            //string connnString = "Data Source = SCS_SERVER/SWMDEV_SCS; Initial Catalog = SWMSystem; User ID = sa; Password = scs@123; Connect Timeout = 99999; ";
            //conn = new SqlConnection(connnString);

            //====52.66.47.55====//Cloud new IP 02082023 (52.66.47.55) live
            //string connnString = "Data Source = 3.6.47.39; Initial Catalog = SWMSystemAUG; User ID = webadmin; Password = Admin@123!@#; Connect Timeout = 99999; ";
            //conn = new SqlConnection(connnString);

            //====52.66.47.55====//Cloud new IP 02082023 (52.66.47.55) live
            //string connnString = "Data Source = 3.6.47.39; Initial Catalog = SWMSystem; User ID = webadmin; Password = Admin@123!@#; Connect Timeout = 99999; ";
            //conn = new SqlConnection(connnString);

            //==== 52.66.47.55 ====//Cloud new IP 02082023 (52.66.47.55) live
            // string connnString = "Data Source = 10.0.170.75; Initial Catalog = SWMSystem; User ID = webadmin; Password = Admin@123!@#; Connect Timeout = 99999; ";
            //conn = new SqlConnection(connnString);

            //==== 52.66.47.55 ====//Cloud new IP 02082023 (52.66.47.55) live
            string connnString = "Data Source = con.iswmpune.in; Initial Catalog = SWMSystem; User ID = webadmin; Password = Admin@123!@#; Connect Timeout = 99999; ";
            conn = new SqlConnection(connnString);
        }
    }
}