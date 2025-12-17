using System;
using System.Configuration;

namespace SWM
{
    public partial class maindashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["LoginName"] != null && Session["LoginName"].ToString() != "")
            {
                if (!IsPostBack)
                {
                    //string mainDashboardPath = ConfigurationManager.AppSettings["maindashboardPath"];
                    //string loginId = Session["FK_Id"]?.ToString();
                    //Random random = new Random();
                    //string randomPrefix = random.Next(10, 99).ToString(); 
                    //string randomSuffix = random.Next(10, 99).ToString(); 
                    //string queryParameters = $"?loginId={randomPrefix}{loginId}{randomSuffix}";
                    ////string queryParameters = $"?loginId={loginId}";

                    ////myIframe.Src = mainDashboardPath + queryParameters;
                    //myIframe.Src = mainDashboardPath;
                    ////myIframe.Src = ConfigurationManager.AppSettings["maindashboardPath"];

                    //string mainDashboardPath = ConfigurationManager.AppSettings["maindashboardPath"];
                    //string loginId = Session["FK_Id"]?.ToString();
                    //Random random = new Random();
                    //string randomPrefix = random.Next(10, 99).ToString();
                    //string randomSuffix = random.Next(10, 99).ToString();
                    //string queryParameters = $"?loginId={randomPrefix}{loginId}{randomSuffix}";

                    //myIframe.Src = mainDashboardPath + queryParameters;
                }
            }
        }
    }
}