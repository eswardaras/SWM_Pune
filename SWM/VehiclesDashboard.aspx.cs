using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SWM
{
    public partial class VehiclesDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //myIframe.Src = ConfigurationManager.AppSettings["VehiclesDashboardPath"];
                string mainDashboardPath = ConfigurationManager.AppSettings["VehicleDashboardPath"];
                string loginId = Session["FK_Id"]?.ToString();
                Random random = new Random();
                string randomPrefix = random.Next(10, 99).ToString();
                string randomSuffix = random.Next(10, 99).ToString();
                string queryParameters = $"?loginId={randomPrefix}{loginId}{randomSuffix}";

                myIframe.Src = mainDashboardPath + queryParameters;
            }
        }
    }
}