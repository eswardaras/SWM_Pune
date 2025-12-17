using SWM.BAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;

namespace SWM
{
    public partial class ContractForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
                BindContractor();
                BindBudgetHead();
            }
        }

        protected void btnContractor_Click(object sender, EventArgs e)
        {
            try
            {
                string savePath = "", fullPath = "";
                BALContrator bAL = new BALContrator();
                //== sp ref==//
                //exec proc_ContractorRegistration @mode = 1,@ContractName,@TendorNo,@ContractorId,@TitalOfwork,@ContractPeriodFrom,@ContractPeriodTo,@ExtensionFrom,  
                // @ExtensionTo,@BudgetdHeadId,@BudgetAmount,@PreviousSanctionValue,@ActualTendorValue,@BillValue,  
                //(isnull(@ActualTendorValue, 0) - isnull(@BillValue, 0)),@dpr_File,1,getdate()
                // == sp ref==//
                int @mode;
                int @pk_ContractId = 0;
                if (ViewState["id"] != null && Convert.ToString(ViewState["id"]) != "")
                {
                    @mode = 3;
                    @pk_ContractId = Convert.ToInt32(ViewState["id"].ToString());
                }
                else
                {
                    @mode = 1;
                    @pk_ContractId = 0;
                }
                if (fileUpload.HasFile)
                {
                    // Get the uploaded file's name and save path
                    string fileName = Path.GetFileName(fileUpload.FileName);
                    string fileExtension = Path.GetExtension(fileName);

                    if (fileExtension.ToLower() == ".pdf")
                    {
                        try
                        {
                            savePath = Server.MapPath("~/Uploads/");// + fileName; // Specify the directory to save the file
                            fullPath = savePath + fileName;
                            if (!Directory.Exists(savePath))
                            {
                                Directory.CreateDirectory(savePath);
                            }

                            // Save the file to the server
                            fileUpload.SaveAs(fullPath);
                        }
                        catch (Exception ex)
                        {

                        }
                    }


                    // Optionally, you can perform additional processing here
                }
                DataSet dsSave = bAL.InsertContractor(@mode, 11401, txtContractName.Text, txtTendorNo.Text, Convert.ToInt32(ddlContractorName.SelectedItem.Value),
                    txtTitleOfWork.Text, txtContractPeriodFrom.Text, txtContractPeriodTo.Text, txtExtensionFrom.Text,
                    txtExtensionTo.Text, Convert.ToInt32(ddlBudgetHeadName.SelectedItem.Value), txtBudgetAmount.Text, txtPreviousSanctionedValue.Text, txtActualTendorValue.Text, txtBillValue.Text, @pk_ContractId, fullPath);
                if (dsSave.Tables.Count > 0)
                {
                    ViewState["id"] = "";
                    BindGrid();
                    ClearControl();
                }
            }
            catch (Exception ex)
            {
                //throw( ex);
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "ContractForm.cs >> Method BindGrid()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
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
            txtContractName.Text = "";
            txtTendorNo.Text = "";
            txtTitleOfWork.Text = "";
            txtContractPeriodFrom.Text = "";
            txtContractPeriodTo.Text = "";
            txtExtensionFrom.Text = "";
            txtExtensionTo.Text = "";
            txtBudgetAmount.Text = "";
            txtPreviousSanctionedValue.Text = "";
            txtActualTendorValue.Text = "";
            txtBillValue.Text = "";
            ddlContractorName.ClearSelection();
            ddlContractorName.Items.FindByValue("0").Selected = true;
            ddlBudgetHeadName.ClearSelection();
            //ddlBudgetHeadName.Items.FindByValue("0").Selected = true;
        }
        void BindGrid()
        {
            try
            {
                int @mode;
                int @pk_ContractId;
                if (ViewState["id"] != null && Convert.ToString(ViewState["id"]) != "")
                {
                    @mode = 4;
                    @pk_ContractId = Convert.ToInt32(ViewState["id"].ToString());
                }
                else
                {
                    @mode = 5;
                    @pk_ContractId = 0;
                }
                BALContrator bAL = new BALContrator();
                DataSet ds = bAL.GetContractor(@mode, 11401, @pk_ContractId);

                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        //Set the dropdown list's data source and bind the data
                        grdData.DataSource = ds.Tables[0];
                        grdData.DataBind();
                        //ClearControl();
                    }
                }
            }
            catch (Exception ex)
            {

                // throw (ex);
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "ContractForm.cs >> Method BindGrid()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }

        void BindContractor()
        {
            try
            {
                BALContrator bAL = new BALContrator();
                DataSet ds = bAL.GetContractor(8, 11401, 0);

                if (ds.Tables.Count > 0)
                {
                    DataRow allOption = ds.Tables[0].NewRow();
                    allOption["Pk_ContractorId"] = 0;
                    allOption["ContractorName"] = "Select All";
                    ds.Tables[0].Rows.InsertAt(allOption, 0);
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        //Set the dropdown list's data source and bind the data
                        ddlContractorName.DataSource = ds.Tables[0];
                        ddlContractorName.DataTextField = "ContractorName"; // Field to display as option text
                        ddlContractorName.DataValueField = "Pk_ContractorId"; // Field to use as option value
                        ddlContractorName.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "ContractForm.cs >> Method BindContractor()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }
        void BindBudgetHead()
        {
            try
            {
                BALContrator bAL = new BALContrator();
                DataSet ds = bAL.GetContractor(9, 11401, 0);

                if (ds.Tables.Count > 0)
                {
                    DataRow allOption = ds.Tables[0].NewRow();
                    allOption["pk_BudgetHeadId"] = 0;
                    allOption["BudgetHeadName"] = "Select All";
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        //Set the dropdown list's data source and bind the data
                        ddlBudgetHeadName.DataSource = ds.Tables[0];
                        ddlBudgetHeadName.DataTextField = "BudgetHeadName"; // Field to display as option text
                        ddlBudgetHeadName.DataValueField = "pk_BudgetHeadId"; // Field to use as option value
                        ddlBudgetHeadName.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "ContractForm.cs >> Method BindBudgetHead()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
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
                DataSet ds = bAL.GetContractor(2, 11401, Convert.ToInt32(ViewState["id"]));

                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        ViewState["id"] = "";
                        BindGrid();
                        ClearControl();
                    }
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "ContractForm.cs >> Method btnDelete_Click()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
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
                DataSet ds = bAL.GetContractor(4, 11401, Convert.ToInt32(ViewState["id"]));

                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        txtContractName.Text = ds.Tables[0].Rows[0]["ContractName"].ToString();
                        txtTendorNo.Text = ds.Tables[0].Rows[0]["TendorNo"].ToString();
                        txtTitleOfWork.Text = ds.Tables[0].Rows[0]["TitalOfwork"].ToString();
                        txtContractPeriodFrom.Text = ds.Tables[0].Rows[0]["ContractPeriodFromDate"].ToString();
                        txtContractPeriodTo.Text = ds.Tables[0].Rows[0]["ContractPeriodToDate"].ToString();
                        txtExtensionFrom.Text = ds.Tables[0].Rows[0]["ExtensionFromDate"].ToString();
                        txtExtensionTo.Text = ds.Tables[0].Rows[0]["ExtensionToDate"].ToString();
                        txtBudgetAmount.Text = ds.Tables[0].Rows[0]["BudgetAmount"].ToString();
                        txtPreviousSanctionedValue.Text = ds.Tables[0].Rows[0]["PreviousSanctionValue"].ToString();
                        txtActualTendorValue.Text = ds.Tables[0].Rows[0]["ActualTendorValue"].ToString();
                        txtBillValue.Text = ds.Tables[0].Rows[0]["BillValue"].ToString();
                        ddlContractorName.ClearSelection();
                        ddlContractorName.Items.FindByValue(ds.Tables[0].Rows[0]["fk_ContractorId"].ToString()).Selected = true;
                        ddlBudgetHeadName.ClearSelection();
                        ddlBudgetHeadName.Items.FindByValue(ds.Tables[0].Rows[0]["fk_BudgetdHeadId"].ToString()).Selected = true;

                        //.Text = ds.Tables[0].Rows[0]["BalanceBillValue"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "ContractForm.cs >> Method btnEdit_Click()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }

        public class InputSanitizer
        {
            public static string SanitizeInput(string input)
            {
                return Regex.Replace(input, @"<[^>]*>", string.Empty);
            }
        }
    }
}