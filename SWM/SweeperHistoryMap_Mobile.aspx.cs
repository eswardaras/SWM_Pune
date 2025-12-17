using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SWM
{
    public partial class SweeperHistoryMap_Mobile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                string loginId = Request.QueryString["loginId"];
                // Check if loginId is not null and has more than 4 characters (to ensure it can be trimmed)
                if (!string.IsNullOrEmpty(loginId) && loginId.Length > 4)
                {
                    // Trim the loginId
                    loginId = loginId.Substring(2, loginId.Length - 4);
                }
                else
                {
                    // Redirect to login page if loginId is null or empty
                    Response.Redirect("Login.aspx");
                }

                Page.ClientScript.RegisterStartupScript(this.GetType(), "UrlScript", $@"
                const commonApi = '{System.Configuration.ConfigurationManager.AppSettings["CommonApiUrl"]}';
                const zoneApi = '{System.Configuration.ConfigurationManager.AppSettings["ZoneApiUrl"]}';
                const wardApi = '{System.Configuration.ConfigurationManager.AppSettings["WardApiUrl"]}';
                const kothiApi = '{System.Configuration.ConfigurationManager.AppSettings["KothiApiUrl"]}';
                const routeApi = '{System.Configuration.ConfigurationManager.AppSettings["RouteApiUrl"]}';
                ", true);
            }
            catch (Exception ex)
            {
                // Log the exception if needed
                Console.WriteLine("An error occurred: " + ex.Message);
                // Redirect to the login page
                Response.Redirect("Login.aspx");
            }
        }
    }
}