using System;
using System.Web;

namespace SWM
{
    public partial class ObtainIp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Any initial setup can be done here
        }

        protected void btnFetch_Click(object sender, EventArgs e)
        {
            string clientIpAddress = GetClientIpAddress();
            ClientScript.RegisterStartupScript(this.GetType(), "showIp", $"alert('Your IP Address: {clientIpAddress}');", true);
        }

        private string GetClientIpAddress()
        {
            // First, check the 'HTTP_X_FORWARDED_FOR' header
            string ip = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

            // If it contains multiple IPs, take the first one
            if (!string.IsNullOrEmpty(ip))
            {
                var ipArray = ip.Split(',');
                ip = ipArray[0].Trim();
            }

            // Fallback to 'REMOTE_ADDR' if 'HTTP_X_FORWARDED_FOR' is empty
            if (string.IsNullOrEmpty(ip))
            {
                ip = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
            }

            return ip;
        }
    }
}
