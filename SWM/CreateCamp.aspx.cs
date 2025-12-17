using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using SWM.BAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SWM
{
    public partial class CreateCamp : System.Web.UI.Page
    {
        private static readonly HttpClient httpClient = new HttpClient();
        string lblResponse;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                //CallWcfService();
                BindDLL();
                BindGrid();
            }
        }
        protected void BindDLL()
        {
            BindDDLCampaignType();
            BindDDLActivity();
            BindDDLPenalityRules();
            //exec proc_CreateCampaign @mode = 1,@Type = 'Ward',@AccID = 11401
            BindDDLParticipants();
        }
        void BindDDLCampaignType()
        {
            try
            {
                BalFeederSummaryReport bAL = new BalFeederSummaryReport();
                //== sp ref==//
                // exec proc_CreateCampaign @mode = 3, @CampName = default, @FromDate = '2023-08-24 10:24:16.727', @ToDate = '2023-08-24 10:24:16.727',
                // @Type = default, @CampTypeID = 0, @AddCampType = default, @CampRuleID = default, @AddCampRule = default, @ActivityID = default,
                // @AddActivity = default, @CampFineID = default, @AddFine = default, @ParticipantsID = default, @Description = default,
                // @RewardParam = default, @location = default, @AccID = 0, @Objective = default, @pk_campid = 0, @URL = default,
                // @ParticipantName = default, @Contact = 0, @gender = default, @address = default, @img = default, @video = default,
                // @audio = default, @age = 0, @email = default, @grade = 0, @firstw = default, @secondw = default, @thirdw = default,
                // @broture = default, @GFURL = default, @RulePDF = default
                // == sp ref==//
                DataSet ds = bAL.GetCreateCamp(3);

                if (ds.Tables.Count > 0)
                {
                    //DataRow allOption = ds.Tables[0].NewRow();
                    //allOption["pk_camptypeid"] = 0;
                    //allOption["CampType"] = "Select All";
                    //ds.Tables[0].Rows.InsertAt(allOption, 0);
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        //Set the dropdown list's data source and bind the data
                        ddlCampaignType.DataSource = ds.Tables[0];
                        ddlCampaignType.DataTextField = "CampType"; // Field to display as option text  	
                        ddlCampaignType.DataValueField = "pk_camptypeid"; // Field to use as option value 
                        ddlCampaignType.DataBind();
                    }
                }

            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "CreateCamp.cs >> Method BindDDLCampaignType()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }
        void BindDDLActivity()
        {
            try
            {
                BalFeederSummaryReport bAL = new BalFeederSummaryReport();
                //== sp ref==//
                // exec proc_CreateCampaign @mode = 3, @CampName = default, @FromDate = '2023-08-24 10:24:16.727', @ToDate = '2023-08-24 10:24:16.727',
                // @Type = default, @CampTypeID = 0, @AddCampType = default, @CampRuleID = default, @AddCampRule = default, @ActivityID = default,
                // @AddActivity = default, @CampFineID = default, @AddFine = default, @ParticipantsID = default, @Description = default,
                // @RewardParam = default, @location = default, @AccID = 0, @Objective = default, @pk_campid = 0, @URL = default,
                // @ParticipantName = default, @Contact = 0, @gender = default, @address = default, @img = default, @video = default,
                // @audio = default, @age = 0, @email = default, @grade = 0, @firstw = default, @secondw = default, @thirdw = default,
                // @broture = default, @GFURL = default, @RulePDF = default
                // == sp ref==//
                DataSet ds = bAL.GetCreateCamp(2);

                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        //Set the dropdown list's data source and bind the data
                        ddlActivity.DataSource = ds.Tables[0];
                        ddlActivity.DataTextField = "activities"; // Field to display as option text  	
                        ddlActivity.DataValueField = "pk_activityid"; // Field to use as option value 
                        ddlActivity.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "CreateCamp.cs >> Method BindDDLActivity()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }
        void BindDDLPenalityRules()
        {
            try
            {
                BalFeederSummaryReport bAL = new BalFeederSummaryReport();
                //== sp ref==//
                // exec proc_CreateCampaign @mode = 3, @CampName = default, @FromDate = '2023-08-24 10:24:16.727', @ToDate = '2023-08-24 10:24:16.727',
                // @Type = default, @CampTypeID = 0, @AddCampType = default, @CampRuleID = default, @AddCampRule = default, @ActivityID = default,
                // @AddActivity = default, @CampFineID = default, @AddFine = default, @ParticipantsID = default, @Description = default,
                // @RewardParam = default, @location = default, @AccID = 0, @Objective = default, @pk_campid = 0, @URL = default,
                // @ParticipantName = default, @Contact = 0, @gender = default, @address = default, @img = default, @video = default,
                // @audio = default, @age = 0, @email = default, @grade = 0, @firstw = default, @secondw = default, @thirdw = default,
                // @broture = default, @GFURL = default, @RulePDF = default
                // == sp ref==//
                DataSet ds = bAL.GetCreateCamp(5);

                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        //Set the dropdown list's data source and bind the data
                        ddlPenalityRules.DataSource = ds.Tables[0];
                        ddlPenalityRules.DataTextField = "finerules"; // Field to display as option text 	 	
                        ddlPenalityRules.DataValueField = "pk_fineruleid"; // Field to use as option value 
                        ddlPenalityRules.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "CreateCamp.cs >> Method BindDDLPenalityRules()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }
        void BindDDLParticipants()
        {
            try
            {
                BalFeederSummaryReport bAL = new BalFeederSummaryReport();
                //== sp ref==//
                //exec proc_CreateCampaign @mode = 1,@Type = 'Ward',@AccID = 11401
                // == sp ref==//
                DataSet ds = bAL.GetCreateCamp(1, rdblist.SelectedItem.Value, 11401);

                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        //Set the dropdown list's data source and bind the data
                        ddlParticipants.DataSource = ds.Tables[0];
                        if (rdblist.SelectedItem.Value == "City")
                        {
                            ddlParticipants.DataTextField = "CityName"; // Field to display as option text 	 	
                            ddlParticipants.DataValueField = "CityId"; // Field to use as option value  ZoneName
                        }
                        if (rdblist.SelectedItem.Value == "Zone")
                        {
                            ddlParticipants.DataTextField = "ZoneName"; // Field to display as option text 	 	
                            ddlParticipants.DataValueField = "ZoneId"; // Field to use as option value  
                        }
                        if (rdblist.SelectedItem.Value == "Ward")
                        {
                            ddlParticipants.DataTextField = "wardName"; // Field to display as option text 	 	
                            ddlParticipants.DataValueField = "PK_wardId"; // Field to use as option value  
                        }
                        ddlParticipants.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "CreateCamp.cs >> Method BindDDLPenalityRules()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }
        void BindGrid()
        {
            try
            {
                BalFeederSummaryReport bAL = new BalFeederSummaryReport();
                //== sp ref==//
                // exec proc_CreateCampaign @mode = 3, @CampName = default, @FromDate = '2023-08-24 10:24:16.727', @ToDate = '2023-08-24 10:24:16.727',
                // @Type = default, @CampTypeID = 0, @AddCampType = default, @CampRuleID = default, @AddCampRule = default, @ActivityID = default,
                // @AddActivity = default, @CampFineID = default, @AddFine = default, @ParticipantsID = default, @Description = default,
                // @RewardParam = default, @location = default, @AccID = 0, @Objective = default, @pk_campid = 0, @URL = default,
                // @ParticipantName = default, @Contact = 0, @gender = default, @address = default, @img = default, @video = default,
                // @audio = default, @age = 0, @email = default, @grade = 0, @firstw = default, @secondw = default, @thirdw = default,
                // @broture = default, @GFURL = default, @RulePDF = default
                // == sp ref==//
                DataSet ds = bAL.GetCreateCamp(11);

                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        //Set the dropdown list's data source and bind the data
                        grdData.DataSource = ds.Tables[0];
                        grdData.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "CreateCamp.cs >> Method BindDDLPenalityRules()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }

        private async Task CallWcfService()
        {
            try
            {
                string apiUrl = "http://13.200.33.105/SWMServiceLive/SWMService.svc/CommonMethod";
                //string jsonContent = "{\r\n   \"storedProcedureName\": \"proc_CreateCampaign\",\r\n   \"parameters\": \"{\\\"mode\\\": 3, \\\"FromDate\\\": \\\"" + txtFromDate.Text + "\\" + '"' + ",\\\"@ToDate\\\": \\\"" + txtToDate.Text + "\\" + '"' + "}\"\r\n}";
                string jsonContent = "{\r\n   \"storedProcedureName\": \"proc_CreateCampaign\",\r\n   \"parameters\": \"{\\\"mode\\\": 3}\"\r\n}";

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

                    DataTable dataTable = new DataTable();
                    //pk_camptypeid CampType 1   Add New
                    dataTable.Columns.Add("pk_camptypeid", typeof(int));
                    dataTable.Columns.Add("CampType", typeof(string));
                    //dataTable.Columns.Add("FK_RoleID", typeof(int));
                    //dataTable.Columns.Add("Role", typeof(string));
                    //dataTable.Columns.Add("mobile", typeof(string));
                    //dataTable.Columns.Add("email", typeof(string));
                    //dataTable.Columns.Add("Password", typeof(string));
                    //dataTable.Columns.Add("isEnable", typeof(bool));
                    //dataTable.Columns.Add("expiryDate", typeof(string));
                    //dataTable.Columns.Add("paymentpopup", typeof(bool));
                    //dataTable.Columns.Add("AccID", typeof(int));
                    //dataTable.Columns.Add("LoginName", typeof(string));

                    // Populate the DataTable with data from the JArray
                    foreach (JObject report in reportArray)
                    {
                        DataRow row = dataTable.NewRow();
                        row["pk_camptypeid"] = report["pk_camptypeid"];
                        row["CampType"] = report["CampType"];
                        //row["FK_RoleID"] = report["FK_RoleID"];
                        //row["Role"] = report["Role"];
                        //row["mobile"] = report["mobile"];
                        //row["email"] = report["email"];
                        //row["Password"] = report["Password"];
                        //row["isEnable"] = report["isEnable"];
                        ////row["expiryDate"] = report["expiryDate"]?.ToObject<string>(); // Handle nullable DateTime
                        //row["expiryDate"] = report["expiryDate"]; // Handle nullable DateTime
                        //row["paymentpopup"] = report["paymentpopup"];
                        //row["AccID"] = report["AccID"];
                        //row["LoginName"] = report["LoginName"];
                        dataTable.Rows.Add(row);
                    }
                    if (dataTable.Rows.Count > 0)
                    {
                        DataRow allOption = dataTable.NewRow();
                        allOption["pk_camptypeid"] = 0;
                        allOption["CampType"] = "Select All";
                        dataTable.Rows.InsertAt(allOption, 0);

                        // Set the dropdown list's data source and bind the data
                        ddlCampaignType.DataSource = dataTable;
                        ddlCampaignType.DataTextField = "CampType"; // Field to display as option text  	
                        ddlCampaignType.DataValueField = "pk_camptypeid"; // Field to use as option value 
                        ddlCampaignType.DataBind();
                    }
                }
                else
                {
                    // Handle unsuccessful response
                    lblResponse = "No Data Found!!";
                }
            }
            catch (Exception ex)
            {
                // Handle exceptions
                lblResponse = "An error occurred: " + ex.Message;
            }

        }

        protected void rdblist_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindDDLParticipants();
        }

        protected void btnCampaign_Click(object sender, EventArgs e)
        {
            try
            {
                BalFeederSummaryReport bAL = new BalFeederSummaryReport();
                //== sp ref==//
                //exec proc_CreateCampaign @mode = 3, @CampName = default, @FromDate = '2023-08-24 10:24:16.727', @ToDate = '2023-08-24 10:24:16.727',
                // @Type = default, @CampTypeID = 0, @AddCampType = default, @CampRuleID = default, @AddCampRule = default, @ActivityID = default,
                // @AddActivity = default, @CampFineID = default, @AddFine = default, @ParticipantsID = default, @Description = default,
                // @RewardParam = default, @location = default, @AccID = 0, @Objective = default, @pk_campid = 0, @URL = default,
                // @ParticipantName = default, @Contact = 0, @gender = default, @address = default, @img = default, @video = default,
                // @audio = default, @age = 0, @email = default, @grade = 0, @firstw = default, @secondw = default, @thirdw = default,
                // @broture = default, @GFURL = default, @RulePDF = default
                // == sp ref==//
                DataSet dsSave = bAL.GetCreateCamp(10, txtCampaignName.Text, txtFromDate.Text, txtToDate.Text, rdblist.SelectedItem.Value, ddlCampaignType.SelectedValue, "",
                    txtCampaignRules.Text, "", ddlActivity.SelectedItem.Value, "", ddlPenalityRules.SelectedItem.Value, "", ddlParticipants.SelectedItem.Value, txtDescription.Text,
                    txtReward.Text, txtLocation.Text, 0, txtObjective.Text, 0, txtUploadGoogleFormLink.Text);
                if (dsSave.Tables.Count > 0)
                {
                    DataSet ds = bAL.GetCreateCamp(11);

                    if (ds.Tables.Count > 0)
                    {
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            //Set the dropdown list's data source and bind the data
                            grdData.DataSource = ds.Tables[0];
                            grdData.DataBind();
                            ClearControl();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "CreateCamp.cs >> Method BindDDLPenalityRules()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }

        void ClearControl()
        {
            txtCampaignName.Text = "";
            ddlCampaignType.ClearSelection();
            txtCampaignRules.Text = "";
            txtDescription.Text = "";
            txtObjective.Text = "";
            txtLocation.Text = "";
            ddlActivity.ClearSelection();
            ddlPenalityRules.ClearSelection();
            txtReward.Text = "";
            ddlParticipants.ClearSelection();
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            try
            {
                LinkButton clickedButton = (LinkButton)sender;
                string[] parameters = clickedButton.CommandArgument.Split('|');
                string fk_id = parameters[0];
                //string date = parameters[1];
                ViewState["id"] = fk_id;

                BalFeederSummaryReport bAL = new BalFeederSummaryReport();

                DataSet ds = bAL.GetCreateCampForEdit(12, Convert.ToInt32(ViewState["id"]));

                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        rdblist.Items.FindByValue(ds.Tables[0].Rows[0]["Type"].ToString()).Selected = true;
                        txtCampaignName.Text = ds.Tables[0].Rows[0]["CampName"].ToString();
                        txtFromDate.Text = ds.Tables[0].Rows[0]["fromdate"].ToString();
                        txtToDate.Text = ds.Tables[0].Rows[0]["todate"].ToString();
                        ddlCampaignType.ClearSelection();
                        ddlCampaignType.Items.FindByValue(ds.Tables[0].Rows[0]["fk_camptypeid"].ToString()).Selected = true;
                        //ddlCampaignType.Text = ds.Tables[0].Rows[0]["ContractPeriodFromDate"].ToString();
                        txtCampaignRules.Text = ds.Tables[0].Rows[0]["fk_campRuleid"].ToString();
                        txtDescription.Text = ds.Tables[0].Rows[0]["CampDescription"].ToString();
                        txtObjective.Text = ds.Tables[0].Rows[0]["CampObjective"].ToString();
                        txtLocation.Text = ds.Tables[0].Rows[0]["Location"].ToString();
                        if (ds.Tables[1].Rows.Count > 0)
                        {
                            ddlActivity.ClearSelection();
                            ddlActivity.Text = ds.Tables[1].Rows[0]["activity"].ToString();
                        }
                        if (ds.Tables[2].Rows.Count > 0)
                        {
                            ddlPenalityRules.ClearSelection();
                            ddlPenalityRules.Text = ds.Tables[2].Rows[0]["finerule"].ToString();
                        }
                        if (ds.Tables[3].Rows.Count > 0)
                        {
                            ddlParticipants.ClearSelection();
                            ddlParticipants.Items.FindByValue(ds.Tables[3].Rows[0]["participant"].ToString()).Selected = true;
                        }
                        txtReward.Text = ds.Tables[0].Rows[0]["RewardsParameter"].ToString();
                        txtUploadGoogleFormLink.Text = ds.Tables[0].Rows[0]["gf_link"].ToString();
                        btnCampaign.Text = "Update Campaign";
                    }
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "ContractCamp.cs >> Method btnEdit_Click()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }
    }
}