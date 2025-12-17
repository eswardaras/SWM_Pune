using System;
using System.Configuration;

namespace SWM
{
    public partial class SwpeerManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                myIframe.Src = ConfigurationManager.AppSettings["SwpeerManagementPath"];
            }
        }
    }
}