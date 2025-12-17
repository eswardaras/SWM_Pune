using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Http;

using System.Threading.Tasks;

namespace SWM
{
    public partial class JatayuHistoryMap : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            //http://34.208.38.238/JatayuHistoryMap.aspx?vid=1326&sdate=06-01-2023&flag=Jatayu
            //exec proc_jatayucoveragereport @Accid = 11401,@mode = 6,@zoneId = 0,@WardId = 0,@startdate = '2023-06-01 00:00:00',@enddate = '2023-06-01 00:00:00',@vehicleid = 1326

            Request.QueryString["sdate"].ToString();
            string queryString1 = "param1=" + Request.QueryString["vid"].ToString() 
                + "&param2=" + Request.QueryString["sdate"].ToString() + "&param3=" + Request.QueryString["flag"].ToString(); // The query string parameters




            ////----step 2----//
            //var parameters = new Dictionary<string, string>
            //{
            //    { "param1", "Abc" },
            //    { "param2", "value2" }
            //};

            //var queryString = string.Join("&", parameters.Select(p => $"{p.Key}={p.Value}"));

            //var url = $"http://localhost:8000/python_script_endpoint?{queryString}";

            //using (var httpClient = new HttpClient())
            //{
            //    var response = await httpClient.GetAsync(url);
            //    var responseBody = await response.Content.ReadAsStringAsync();

            //    // Handle the response from the Python script
            //    Console.WriteLine(responseBody);
            //}
            RegisterAsyncTask(new PageAsyncTask(CallPythonScriptAsync));
        }

        private async Task CallPythonScriptAsync()
        {
            var parameters = new Dictionary<string, string>
            {
                { "param1", "Abc" },
                { "param2", "value2" }
            };

            var queryString = string.Join("&", parameters.Select(p => $"{p.Key}={p.Value}"));

            var url = $"http://localhost:8000/python_script_endpoint?{queryString}";

            using (var httpClient = new HttpClient())
            {
                var response = await httpClient.GetAsync(url);
                var responseBody = await response.Content.ReadAsStringAsync();

                // Handle the response from the Python script
                Console.WriteLine(responseBody);
            }
        }
        private async Task CallPythonScriptAsync1()
        {
            var parameters = new Dictionary<string, string>
            {
                { "param1", "Abc" },
                { "param2", "value2" }
            };

            var queryString = string.Join("&", parameters.Select(p => $"{p.Key}={p.Value}"));

            var url = $"http://localhost:8000/python_script_endpoint?{queryString}";

            using (var httpClient = new HttpClient())
            {
                var response = await httpClient.GetAsync(url);
                var responseBody = await response.Content.ReadAsStringAsync();

                // Handle the response from the Python script
                Console.WriteLine(responseBody);
            }
        }
        static async System.Threading.Tasks.Task Main(string[] args)
        {
            var parameters = new Dictionary<string, string>
        {
            { "param1", "Abc" },
            { "param2", "value2" }
        };

            var queryString = string.Join("&", parameters.Select(p => $"{p.Key}={p.Value}"));

            var url = $"http://localhost:8000/python_script_endpoint?{queryString}";

            using (var httpClient = new HttpClient())
            {
                var response = await httpClient.GetAsync(url);
                var responseBody = await response.Content.ReadAsStringAsync();

                // Handle the response from the Python script
                Console.WriteLine(responseBody);
            }
        }
    }
}