using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;

namespace SWM
{
    public static class WebApiConfig
    {
        public static void Register(HttpConfiguration config)
        {
            // Web API configuration and services

            // Enable attribute routing
            config.MapHttpAttributeRoutes();

            // Optional: keep default route for convention-based controllers
            config.Routes.MapHttpRoute(
                name: "DefaultApi",
                routeTemplate: "api/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );

        }
    }
}
