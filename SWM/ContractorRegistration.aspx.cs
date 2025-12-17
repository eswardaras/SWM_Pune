using SWM.BAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SWM
{
    public partial class ContractorRegistration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }
        protected void btnContractor_Click1(object sender, EventArgs e)
        {
            try
            {
                int @mode;
                int @Pk_ContractorId;
                if (ViewState["id"] != null && Convert.ToString(ViewState["id"]) != "")
                {
                    @mode = 4;
                    @Pk_ContractorId =Convert.ToInt32(ViewState["id"].ToString());
                }
                else
                {
                    @mode = 3;
                    @Pk_ContractorId = 0;
                }
                BALContrator bAL = new BALContrator();
                //== sp ref==//
                //exec proc_ContractorRegistration @mode = 3,@accid = 11401,@startdate = default,@enddate = default,@EmpId = 0,@roleid = 0,
                //@districtid = 332,@countryid = 1,@stateid = 21,@TypeOfCompany = N'LIMITED COMPANY',@NatureOfBusiness = N'test 16102023',
                //@YearOfEstablishment = N'2023-10-16',@AreaOfOption = N'Local',@NameOfContractor = N'test 16102023',
                //@FirmName = N'test 16102023',@Address = N'test 16102023',@MobileNo = N'test 16102',@LandlineNo = N'test 16102',
                //@GSTN = N'test 16102023',@PanNo = N'test 16102023',
                //@BankAccNo = N'test 16102023',@NameOfAccHolder = N'test 16102023',@ISFC = N'test 16102023',@Branch = N'test 16102023',@Pk_ContractorId = 0
                // == sp ref==//
                DataSet dsSave = bAL.InsertContractorRegistration(@mode, 11401, txtContractorName.Text, txtFirmContractorOwnerName.Text,
                    txtVendorRegistrationNumber.Text, txtContractorRegisteredAddress.Text, txtMobile.Text, txtLandline.Text, txtGSTN.Text, txtPANNo.Text, txtBankAccountNo.Text,
                    txtNameOfAccountHolder.Text, txtISFC.Text, txtBranch.Text, @Pk_ContractorId);
                if (dsSave.Tables.Count > 0)
                {
                    BindGrid();
                    ClearControl();
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "ContractorRegistration.cs >> Method BindGrid()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
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
            txtContractorName.Text = "";
            txtFirmContractorOwnerName.Text = "";
            txtVendorRegistrationNumber.Text = "";
            txtContractorRegisteredAddress.Text = "";
            txtMobile.Text = "";
            txtLandline.Text = "";
            txtGSTN.Text = "";
            txtPANNo.Text = "";
            txtBankAccountNo.Text = "";
            txtNameOfAccountHolder.Text = "";
            txtISFC.Text = "";
            txtBranch.Text = "";
        }
        void BindGrid()
        {
            try
            {
                BALContrator bAL = new BALContrator();
                DataSet ds = bAL.GetContractorRegistration(7, 0);

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
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "ContractorRegistration.cs >> Method BindGrid()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
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

                BALContrator bAL = new BALContrator();
                DataSet ds = bAL.GetContractorRegistration(5, Convert.ToInt32(ViewState["id"]));

                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        txtContractorName.Text = ds.Tables[0].Rows[0]["ContractorName"].ToString();
                        txtFirmContractorOwnerName.Text = ds.Tables[0].Rows[0]["FirmName"].ToString();
                        txtContractorRegisteredAddress.Text = ds.Tables[0].Rows[0]["Address"].ToString();
                        txtMobile.Text = ds.Tables[0].Rows[0]["MobileNo"].ToString();
                        txtLandline.Text = ds.Tables[0].Rows[0]["LandlineNo"].ToString();
                        txtGSTN.Text = ds.Tables[0].Rows[0]["GSTN"].ToString();
                        txtPANNo.Text = ds.Tables[0].Rows[0]["PanNo"].ToString();
                        txtBankAccountNo.Text = ds.Tables[0].Rows[0]["BankAccountNo"].ToString();
                        txtNameOfAccountHolder.Text = ds.Tables[0].Rows[0]["NameOfAccountHolder"].ToString();
                        txtISFC.Text = ds.Tables[0].Rows[0]["ISFC_Code"].ToString();
                        txtBranch.Text = ds.Tables[0].Rows[0]["Branch"].ToString();
                        txtVendorRegistrationNumber.Text = ds.Tables[0].Rows[0]["VendorRegistrationNumber"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "ContractorRegistration.cs >> Method btnEdit_Click()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                LinkButton clickedButton = (LinkButton)sender;
                string[] parameters = clickedButton.CommandArgument.Split('|');
                string fk_id = parameters[0];
                //string date = parameters[1];
                ViewState["id"] = fk_id;

                BALContrator bAL = new BALContrator();
                DataSet ds = bAL.GetContractorRegistration(6, Convert.ToInt32(ViewState["id"]));

                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        BindGrid();
                        ClearControl();
                    }
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "ContractorRegistration.cs >> Method btnDelete_Click()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
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