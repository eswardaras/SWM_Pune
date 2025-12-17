using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using SWM.MODEL;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Net.Http;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SWM
{
    public partial class Login : System.Web.UI.Page
    {// Create an instance of the client proxy
        //var client = new YourServiceClient();
        private static readonly HttpClient httpClient = new HttpClient();
        string lblResponse;
        string captcha = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Load();
            }
        }
        void Load()
        {
            Session["LoginName"] = "";
            captcha = GenerateRandomString(4);
            captchaContainer.InnerText = captcha;
        }
        protected async void btnLogin_Click(object sender, EventArgs e)
        {
            string enteredCaptcha = captchaTxt.Text.Trim();
            string expectedCaptcha = captchaContainer.InnerText.Trim();

            if (enteredCaptcha == expectedCaptcha)
            {
                CallWcfService();
                CsrfTokenManager.GenerateCsrfToken();
            }
            else
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "InvalidCaptchaAlert", "alert('CAPTCHA incorrect.');", true);
            }
        }

        private async void CallWcfService()
        {
            //Response.Redirect("maindashboard.aspx");

            try
            {
                //string apiUrl = "https://iswmpune.in/swmservice.svc/CommonMethod"; http://13.200.33.105/SWMServiceLive/SWMService.svc/CommonMethod
                //string apiUrl = "http://13.200.33.105/SWMServiceLive/SWMService.svc/CommonMethod";
                string apiUrl = ConfigurationManager.AppSettings["CommonApiUrl"];

                //string jsonContent = "{\r\n   \"storedProcedureName\": \"proc_Login\",\r\n   \"parameters\": \"{\\\"Mode\\\": 1, \\\"Fk_id\\\": 0, \\\"RoleId\\\": 0, \\\"Pk_LoginId\\\": 0, \\\"Username\\\": \\\"" + txtUser.Text + "\\" + '"' + ", \\\"Password\\\": \\\"" + txtPassward.Text + "\\" + '"' + ",\\\"sms\\\": \\\"default\\\"}\"\r\n}";
                string jsonContent = "{\r\n   \"storedProcedureName\": \"proc_Login\",\r\n   \"parameters\": \"{\\\"Mode\\\": 101, \\\"Fk_id\\\": 0, \\\"RoleId\\\": 0, \\\"Pk_LoginId\\\": 0, \\\"Username\\\": \\\"" + txtUser.Text + "\\" + '"' + ", \\\"Password\\\": \\\"" + txtPassward.Text + "\\" + '"' + ",\\\"sms\\\": \\\"default\\\"}\"\r\n}";

                var content = new StringContent(jsonContent, System.Text.Encoding.UTF8, "application/json");
                HttpResponseMessage response = await httpClient.PostAsync(apiUrl, content);

                if (response.IsSuccessStatusCode)
                {
                    string responseContent = await response.Content.ReadAsStringAsync();

                    // Deserialize the JSON response
                    dynamic jsonResponse = JsonConvert.DeserializeObject<dynamic>(responseContent);

                    // Extract the string representation of the array
                    string returnValueJson = jsonResponse.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

                    // Parse the string representation into a JArray
                    JArray reportArray = JArray.Parse(returnValueJson);

                    //// Convert JSON array to DataTable
                    //DataTable dataTable = new DataTable();
                    //dataTable.Columns.Add("name");

                    //foreach (JToken report in reportArray)
                    //{
                    //    dataTable.Rows.Add(report["name"].ToString());
                    //}
                    // Create a DataTable and define columns

                    DataTable dataTable = new DataTable();
                    dataTable.Columns.Add("ID", typeof(int));
                    dataTable.Columns.Add("FK_Id", typeof(int));
                    dataTable.Columns.Add("FK_RoleID", typeof(int));
                    dataTable.Columns.Add("Role", typeof(string));
                    dataTable.Columns.Add("mobile", typeof(string));
                    dataTable.Columns.Add("email", typeof(string));
                    //dataTable.Columns.Add("Password", typeof(string));
                    dataTable.Columns.Add("isEnable", typeof(bool));
                    dataTable.Columns.Add("expiryDate", typeof(string));
                    dataTable.Columns.Add("paymentpopup", typeof(bool));
                    dataTable.Columns.Add("AccID", typeof(int));
                    dataTable.Columns.Add("LoginName", typeof(string));

                    // Populate the DataTable with data from the JArray
                    foreach (JObject report in reportArray)
                    {
                        DataRow row = dataTable.NewRow();
                        row["ID"] = report["ID"];
                        row["FK_Id"] = report["FK_Id"];
                        row["FK_RoleID"] = report["FK_RoleID"];
                        row["Role"] = report["Role"];
                        row["mobile"] = report["mobile"];
                        row["email"] = report["email"];
                        //row["Password"] = report["Password"];
                        row["isEnable"] = report["isEnable"];
                        //row["expiryDate"] = report["expiryDate"]?.ToObject<string>(); // Handle nullable DateTime
                        row["expiryDate"] = report["expiryDate"]; // Handle nullable DateTime
                        row["paymentpopup"] = report["paymentpopup"];
                        row["AccID"] = report["AccID"];
                        row["LoginName"] = report["LoginName"];
                        dataTable.Rows.Add(row);
                    }
                    Session["LoginName"] = dataTable.Rows[0]["LoginName"].ToString();
                    Session["FK_Id"] = dataTable.Rows[0]["FK_Id"].ToString();
                    Session["FK_RoleID"] = dataTable.Rows[0]["FK_RoleID"].ToString();
                    // Now 'dataTable' contains your extracted data from the JSON
                    Response.Redirect("Dashboard_Main_SWM.aspx");
                }
                else
                {
                    // Handle unsuccessful response
                    lblResponse = "User name password incorrect.";
                }
            }
            catch (Exception ex)
            {
                // Handle exceptions
                lblResponse = "An error occurred: " + ex.Message;
            }

        }

        private string GenerateRandomString(int length)
        {
            Random random = new Random();
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
            return new string(Enumerable.Repeat(chars, length)
              .Select(s => s[random.Next(s.Length)]).ToArray());
        }

        //protected string CsrfToken
        //{
        //    get { return CsrfTokenManager.GenerateCsrfToken(); }
        //}


        class Program
        {
            static void Main(string[] args)
            {
                string captcha = GenerateRandomString(4);
                Console.WriteLine("CAPTCHA Code: " + captcha);
            }

            static string GenerateRandomString(int length)
            {
                Random random = new Random();
                const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
                return new string(Enumerable.Repeat(chars, length)
                  .Select(s => s[random.Next(s.Length)]).ToArray());
            }
        }

        protected void ReloadCaptcha_Click(object sender, EventArgs e)
        {
            Load();
        }
    }
}