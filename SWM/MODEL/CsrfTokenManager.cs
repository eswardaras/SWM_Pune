using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SWM.MODEL
{
    public class CsrfTokenManager
    {
        public static string GenerateCsrfToken()
        {
            string token = Guid.NewGuid().ToString();
            HttpContext.Current.Session["CsrfToken"] = token;
            return token;
        }

        public static bool ValidateCsrfToken(string token)
        {
            if (HttpContext.Current.Session["CsrfToken"] == null)
                return false;

            return token.Equals(HttpContext.Current.Session["CsrfToken"].ToString());
        }
    }
}