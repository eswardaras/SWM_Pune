using System;
using System.Configuration;

namespace SWM
{
    public partial class SweeperDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //myIframe.Src = ConfigurationManager.AppSettings["SweeperDashboardPath"];
                string mainDashboardPath = ConfigurationManager.AppSettings["SweeperDashboardPath"];
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