using SWM.MODEL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SWM
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_PreInit(object sender, EventArgs e)
        {
            MasterPageFile = "~/Site.Master";
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Generate and store CSRF token in session
                string csrfToken = Guid.NewGuid().ToString();
                Session["CSRFToken"] = csrfToken;

                // Assign CSRF token to a hidden field for form submission
                //csrfTokenInput.Value = csrfToken;

                if (Session["LoginName"] != null && Session["LoginName"].ToString() != "")
                {
                    if (Session["CsrfToken"] != null && Session["CsrfToken"].ToString() != "")
                    {
                        csrfTokenInput.Value = Session["CsrfToken"].ToString();
                        if (Session["CsrfToken"].ToString() == csrfTokenInput.Value)
                        {
                            lblUserName.Text = Convert.ToString(Session["LoginName"]);
                        }
                        else
                        {
                            Response.Redirect("Login.aspx");
                        }
                    }
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
                if (Session["FK_Id"] != null && Session["FK_Id"].ToString() != "")
                {
                    string fkId = Session["FK_Id"].ToString();
                    string fkRoleId = Session["FK_RoleID"].ToString();
                    if (fkRoleId == "4") /*User*/
                    {
                        masterDBWrapper.Visible = true;
                        analyticsWrapper.Visible = true;
                        gisDbWrapper.Visible = true;
                        fleetMngtWrapper.Visible = true;
                        sweeperModuleWrapper.Visible = true;
                        hhCommercialWrapper.Visible = true;
                        rampProcessingWrapper.Visible = true;
                        spCdWRapper.Visible = true;
                        ctPtWrapper.Visible = true;
                        litterBinWrapper.Visible = true;
                        campaignMngtWrapper.Visible = true;
                        fineMngtWrapper.Visible = true;
                        contBillWrapper.Visible = true;
                        shiftMngtWrapper.Visible = true;
                        geofenceMngtWrapper.Visible = true;
                        opMngtSection.Visible = true;
                        empMngtWrapper.Visible = true;
                    }

                    else if (fkRoleId == "1")  /*admin*/
                    {
                        masterDBWrapper.Visible = true;   /*1*/
                        analyticsWrapper.Visible = true; /*1*/
                        gisDbWrapper.Visible = true;      /*2*/
                        fleetMngtWrapper.Visible = true;  /*3*/
                        sweeperModuleWrapper.Visible = true;   /*4*/
                        hhCommercialWrapper.Visible = true;     /*5*/
                        rampProcessingWrapper.Visible = true;    /*6*/
                        RampWaitTimeWrapper.Visible = true;      /*6*/
                        spCdWRapper.Visible = true;              /*7*/
                        ctPtWrapper.Visible = true;            /*8*/
                        litterBinWrapper.Visible = true;           /*9*/
                        campaignMngtWrapper.Visible = true;        /*10*/
                        fineMngtWrapper.Visible = true;         /*11*/
                        contBillWrapper.Visible = true;           /*12*/
                        shiftMngtWrapper.Visible = true;         /*13*/
                        geofenceMngtWrapper.Visible = true;      /*14*/
                        opMngtSection.Visible = true;        /*15*/
                        empMngtWrapper.Visible = true;     /*16*/
                    }

                    else if (fkRoleId == "45")    /*DMC*/
                    {
                        masterDBWrapper.Visible = true;   /*1*/
                        analyticsWrapper.Visible = true; /*1*/
                        gisDbWrapper.Visible = true;      /*2*/
                        fleetMngtWrapper.Visible = true;  /*3*/
                        sweeperModuleWrapper.Visible = true;   /*4*/
                        hhCommercialWrapper.Visible = true;     /*5*/
                        rampProcessingWrapper.Visible = true;    /*6*/
                        RampWaitTimeWrapper.Visible = true;      /*6*/
                        spCdWRapper.Visible = true;              /*7*/
                        ctPtWrapper.Visible = true;            /*8*/
                        litterBinWrapper.Visible = true;           /*9*/
                        campaignMngtWrapper.Visible = true;        /*10*/
                        fineMngtWrapper.Visible = true;         /*11*/
                        contBillWrapper.Visible = true;           /*12*/

                    }
                    else if (fkRoleId == "20")    /*Zonal Head*/
                    {
                        masterDBWrapper.Visible = true;   /*1*/
                        analyticsWrapper.Visible = true; /*1*/
                        gisDbWrapper.Visible = true;      /*2*/
                        fleetMngtWrapper.Visible = true;  /*3*/
                        sweeperModuleWrapper.Visible = true;   /*4*/
                        hhCommercialWrapper.Visible = true;     /*5*/
                        rampProcessingWrapper.Visible = true;    /*6*/
                        RampWaitTimeWrapper.Visible = true;      /*6*/
                        spCdWRapper.Visible = true;              /*7*/
                        ctPtWrapper.Visible = true;            /*8*/
                        litterBinWrapper.Visible = true;           /*9*/
                        campaignMngtWrapper.Visible = true;        /*10*/
                        fineMngtWrapper.Visible = true;         /*11*/
                        contBillWrapper.Visible = true;           /*12*/

                    }
                    else if (fkRoleId == "37") /*Ward officer*/
                    {
                        masterDBWrapper.Visible = true;   /*1*/
                        analyticsWrapper.Visible = true; /*1*/
                        gisDbWrapper.Visible = true;      /*2*/
                        fleetMngtWrapper.Visible = true;  /*3*/
                        sweeperModuleWrapper.Visible = true;   /*4*/
                        hhCommercialWrapper.Visible = true;     /*5*/
                        rampProcessingWrapper.Visible = true;    /*6*/
                        RampWaitTimeWrapper.Visible = true;      /*6*/
                        spCdWRapper.Visible = true;              /*7*/
                        ctPtWrapper.Visible = true;            /*8*/
                        litterBinWrapper.Visible = true;           /*9*/
                        campaignMngtWrapper.Visible = true;        /*10*/
                        fineMngtWrapper.Visible = true;         /*11*/
                        contBillWrapper.Visible = true;           /*12*/
                    }

                    else if (fkRoleId == "34") /*Executive engineer*/
                    {
                        masterDBWrapper.Visible = true;   /*1*/
                        analyticsWrapper.Visible = true; /*1*/
                        gisDbWrapper.Visible = true;      /*2*/
                        fleetMngtWrapper.Visible = true;  /*3*/
                        sweeperModuleWrapper.Visible = true;   /*4*/
                        hhCommercialWrapper.Visible = true;     /*5*/
                        rampProcessingWrapper.Visible = true;    /*6*/
                        RampWaitTimeWrapper.Visible = true;      /*6*/
                        spCdWRapper.Visible = true;              /*7*/
                        ctPtWrapper.Visible = true;            /*8*/
                        litterBinWrapper.Visible = true;           /*9*/
                        campaignMngtWrapper.Visible = true;        /*10*/
                        fineMngtWrapper.Visible = true;         /*11*/
                        contBillWrapper.Visible = true;           /*12*/
                    }
                    else if (fkRoleId == "29") /*DSI*/
                    {
                        masterDBWrapper.Visible = true;   /*1*/
                        analyticsWrapper.Visible = true; /*1*/
                        gisDbWrapper.Visible = true;      /*2*/
                        fleetMngtWrapper.Visible = true;  /*3*/
                        sweeperModuleWrapper.Visible = true;   /*4*/
                        hhCommercialWrapper.Visible = true;     /*5*/
                        rampProcessingWrapper.Visible = true;    /*6*/
                        RampWaitTimeWrapper.Visible = true;      /*6*/
                        spCdWRapper.Visible = true;              /*7*/
                        ctPtWrapper.Visible = true;            /*8*/
                        litterBinWrapper.Visible = true;           /*9*/
                        campaignMngtWrapper.Visible = true;        /*10*/
                        fineMngtWrapper.Visible = true;         /*11*/
                        contBillWrapper.Visible = true;           /*12*/
                        shiftMngtWrapper.Visible = true;         /*13*/
                    }
                    else if (fkRoleId == "28") /*SI*/
                    {
                        masterDBWrapper.Visible = true;   /*1*/
                        analyticsWrapper.Visible = true; /*1*/
                        gisDbWrapper.Visible = true;      /*2*/
                        fleetMngtWrapper.Visible = true;  /*3*/
                        sweeperModuleWrapper.Visible = true;   /*4*/
                        hhCommercialWrapper.Visible = true;     /*5*/
                        rampProcessingWrapper.Visible = true;    /*6*/
                        RampWaitTimeWrapper.Visible = true;      /*6*/
                        spCdWRapper.Visible = true;              /*7*/
                        ctPtWrapper.Visible = true;            /*8*/
                        litterBinWrapper.Visible = true;           /*9*/
                        campaignMngtWrapper.Visible = true;        /*10*/
                        fineMngtWrapper.Visible = true;         /*11*/
                        contBillWrapper.Visible = true;           /*12*/

                    }
                    else if (fkRoleId == "56") /*Asst.Mokadam*/
                    {
                        masterDBWrapper.Visible = true;   /*1*/
                        analyticsWrapper.Visible = true; /*1*/
                        gisDbWrapper.Visible = true;      /*2*/
                        fleetMngtWrapper.Visible = true;  /*3*/
                        sweeperModuleWrapper.Visible = true;   /*4*/
                        ctPtWrapper.Visible = true;            /*8*/


                    }
                    else if (fkRoleId == "39") /*DEPO_ExecutiveEngineer*/
                    {
                        masterDBWrapper.Visible = true;   /*1*/
                        analyticsWrapper.Visible = true; /*1*/

                        fleetMngtWrapper.Visible = true;  /*3*/

                        rampProcessingWrapper.Visible = true;    /*6*/
                        RampWaitTimeWrapper.Visible = true;      /*6*/


                    }
                    else if (fkRoleId == "40") /*DEPO_JuniorEngineer */
                    {
                        masterDBWrapper.Visible = true;   /*1*/
                        analyticsWrapper.Visible = true; /*1*/
                        fleetMngtWrapper.Visible = true;  /*3*/
                        rampProcessingWrapper.Visible = true;    /*6*/
                        RampWaitTimeWrapper.Visible = true;      /*6*/


                    }


                    else if (fkRoleId == "35") /*Deputy Engineer*/
                    {
                        masterDBWrapper.Visible = true;   /*1*/
                        analyticsWrapper.Visible = true; /*1*/
                        gisDbWrapper.Visible = true;      /*2*/
                        fleetMngtWrapper.Visible = true;  /*3*/
                        sweeperModuleWrapper.Visible = true;   /*4*/
                        hhCommercialWrapper.Visible = true;     /*5*/
                        rampProcessingWrapper.Visible = true;    /*6*/
                        RampWaitTimeWrapper.Visible = true;      /*6*/
                        spCdWRapper.Visible = true;              /*7*/
                        ctPtWrapper.Visible = true;            /*8*/
                        litterBinWrapper.Visible = true;           /*9*/
                        campaignMngtWrapper.Visible = true;        /*10*/
                        fineMngtWrapper.Visible = true;         /*11*/
                        contBillWrapper.Visible = true;           /*12*/

                    }
                    else if (fkRoleId == "36") /*Ward Coordinato*/
                    {
                        masterDBWrapper.Visible = true;   /*1*/
                        analyticsWrapper.Visible = true; /*1*/
                        gisDbWrapper.Visible = true;      /*2*/
                        hhCommercialWrapper.Visible = true;     /*5*/

                    }

                    else if (fkRoleId == "8") /*Supervisor*/
                    {
                        masterDBWrapper.Visible = true;   /*1*/
                        analyticsWrapper.Visible = true; /*1*/
                        fleetMngtWrapper.Visible = true;  /*3*/
                        rampProcessingWrapper.Visible = true;    /*6*/
                        RampWaitTimeWrapper.Visible = true;      /*6*/

                    }

                    else if (fkRoleId == "7") /*Vendor*/
                    {
                        fleetMngtWrapper.Visible = true;  /*3*/
                    }

                    else if (fkRoleId == "32")  /*STARTER*/
                    {
                        masterDBWrapper.Visible = true;   /*1*/
                        analyticsWrapper.Visible = true; /*1*/
                        fleetMngtWrapper.Visible = true;  /*3*/
                        spCdWRapper.Visible = true;              /*7*/
                        shiftMngtWrapper.Visible = true;         /*13*/
                    }

                    else if (fkRoleId == "9")  /*Driver*/
                    {

                        fleetMngtWrapper.Visible = true;  /*3*/

                    }
                    else if (fkRoleId == "54") /*Jatayu User*/
                    {
                        fleetMngtWrapper.Visible = true;  /*3*/
                    }
                    else if (fkRoleId == "23")  /*Mokadam*/
                    {
                        masterDBWrapper.Visible = true;   /*1*/
                        analyticsWrapper.Visible = true; /*1*/
                        gisDbWrapper.Visible = true;      /*2*/
                        fleetMngtWrapper.Visible = true;  /*3*/
                        sweeperModuleWrapper.Visible = true;   /*4*/
                        hhCommercialWrapper.Visible = true;     /*5*/
                        spCdWRapper.Visible = true;              /*7*/
                        ctPtWrapper.Visible = true;            /*8*/
                        litterBinWrapper.Visible = true;           /*9*/
                        campaignMngtWrapper.Visible = true;        /*10*/
                        fineMngtWrapper.Visible = true;         /*11*/

                    }
                    else if (fkRoleId == "27")  /*Prabhag Coordinator*/
                    {
                        masterDBWrapper.Visible = true;   /*1*/
                        analyticsWrapper.Visible = true; /*1*/
                        gisDbWrapper.Visible = true;      /*2*/
                        hhCommercialWrapper.Visible = true;     /*5*/


                    }

                    else if (fkRoleId == "55") /*RampUser*/
                    {

                        rampProcessingWrapper.Visible = true;    /*6*/
                        RampWaitTimeWrapper.Visible = true;      /*6*/
                    }
                    else if (fkRoleId == "67")
                    {
                        masterDBWrapper.Visible = true;
                        analyticsWrapper.Visible = true;
                        gisDbWrapper.Visible = true;
                        fleetMngtWrapper.Visible = true;
                        sweeperModuleWrapper.Visible = true;
                        hhCommercialWrapper.Visible = true;
                        rampProcessingWrapper.Visible = true;
                        spCdWRapper.Visible = true;
                        ctPtWrapper.Visible = true;
                        litterBinWrapper.Visible = true;
                        campaignMngtWrapper.Visible = true;
                        fineMngtWrapper.Visible = true;
                        contBillWrapper.Visible = true;
                        shiftMngtWrapper.Visible = true;
                        geofenceMngtWrapper.Visible = true;
                        opMngtSection.Visible = true;
                        empMngtWrapper.Visible = true;
                        RampWaitTimeWrapper.Visible = true;
                    }

                    else
                    {
                        opMngtSection.Visible = false;
                    }
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "LoginIdScript", $"const loginId = '{Session["FK_Id"]}';", true);
                }
                Page.ClientScript.RegisterStartupScript(this.GetType(), "UrlScript", $@"
            const commonApi = '{System.Configuration.ConfigurationManager.AppSettings["CommonApiUrl"]}';
            const zoneApi = '{System.Configuration.ConfigurationManager.AppSettings["ZoneApiUrl"]}';
            const wardApi = '{System.Configuration.ConfigurationManager.AppSettings["WardApiUrl"]}';
            const kothiApi = '{System.Configuration.ConfigurationManager.AppSettings["KothiApiUrl"]}';
            const routeApi = '{System.Configuration.ConfigurationManager.AppSettings["RouteApiUrl"]}';
            const vehicleApi = '{System.Configuration.ConfigurationManager.AppSettings["VehicleApiUrl"]}';
            ", true);
            }

        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Validate CSRF token before logging out
            /*string submittedCSRFToken = Request.Form["csrfTokenInput"];*/ // Assuming hfCSRFToken is the hidden field
            string submittedCSRFToken = csrfTokenInput.Value.ToString();
            string storedCSRFToken = Session["CSRFToken"] as string;

            if (submittedCSRFToken == storedCSRFToken)
            {
                // CSRF token matches, proceed with logout
                FormsAuthentication.SignOut();
                Session.Clear();
                Session.Abandon();

                // Store CSRF token in a cookie
                HttpCookie csrfCookie = new HttpCookie("CSRFToken", storedCSRFToken)
                {
                    HttpOnly = true,
                    Secure = true // Ensure the cookie is sent over HTTPS
                };
                Response.Cookies.Add(csrfCookie);

                // Clear all hidden fields
                ClearHiddenFields(this.Page.Controls);
                Response.Redirect("~/Login.aspx");
            }
            else
            {
                // CSRF token mismatch, handle error (e.g., show error message or redirect to error page)
                Response.Redirect("~/ErrorPage.aspx");
            }
        }

        private void ClearHiddenFields(ControlCollection controls)
        {
            foreach (Control control in controls)
            {
                if (control is HiddenField hiddenField)
                {
                    hiddenField.Value = string.Empty;
                }
                else if (control.HasControls())
                {
                    ClearHiddenFields(control.Controls);
                }
            }
        }
    }


}