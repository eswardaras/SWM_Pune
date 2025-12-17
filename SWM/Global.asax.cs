using System;
using System.Web;
using System.Web.Http;
using System.Web.Optimization;
using System.Web.Routing;
 
namespace SWM
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            GlobalConfiguration.Configure(WebApiConfig.Register);


        }

        protected void Application_BeginRequest(Object sender, EventArgs e)
        {
            HttpContext context = HttpContext.Current;

            if (context.Request.HttpMethod == "OPTIONS" || context.Request.HttpMethod == "HEAD")
            {
                context.Response.StatusCode = 405; // Method Not Allowed
                context.Response.StatusDescription = "Method Not Allowed";
                context.Response.End();
            }
        }
    }
}
