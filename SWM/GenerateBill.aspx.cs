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
    public partial class GenerateBill : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDDL();
                //BindGrid();
            }
        }

        protected void btnSerch_Click(object sender, EventArgs e)
        {
            if (ddlContractName.SelectedItem != null && ddlContractName.SelectedItem.Value != "0")
            {
                BindGrid();
                tableWrapper.Visible = true;
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please select a contract name');", true);
            }
        }
        void BindDDL()
        {
            try
            {
                BALContrator bAL = new BALContrator();
                DataSet ds = bAL.GetGenerateBill(1, 0);

                if (ds.Tables.Count > 0)
                {
                    DataRow allOption = ds.Tables[0].NewRow();
                    allOption["pk_contractid"] = 0;
                    allOption["ContractName"] = "Select";
                    ds.Tables[0].Rows.InsertAt(allOption, 0);
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        ddlContractName.DataSource = ds.Tables[0];
                        ddlContractName.DataTextField = "ContractName"; // Field to display as option text
                        ddlContractName.DataValueField = "pk_contractid"; // Field to use as option value 
                        ddlContractName.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "GenerateBill.cs >> Method BindDLL()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
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
                BALContrator bAL = new BALContrator();
                DataSet ds = bAL.GetGenerateBill(2, Convert.ToInt32(ddlContractName.SelectedItem.Value));

                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        txtTendorNo.Text = ds.Tables[0].Rows[0]["TendorNo"].ToString();
                        txtContractorName.Text = ds.Tables[0].Rows[0]["ContractorName"].ToString();
                        txtAddressOfContractor.Text = ds.Tables[0].Rows[0]["Address"].ToString();
                        txtBudgetHead.Text = ds.Tables[0].Rows[0]["BudgetHeadName"].ToString();
                        txtBudgetCode.Text = ds.Tables[0].Rows[0]["BudgetCode"].ToString();
                        txtTotalBudgetValue.Text = ds.Tables[0].Rows[0]["TotalBudgetValue"].ToString();
                        txtAvailablebudgetValue.Text = ds.Tables[0].Rows[0]["AvailableBudgetValue"].ToString();
                        //txt.Text = ds.Tables[0].Rows[0]["BalanceBillValue"].ToString();
                        //txtAddressOfContractor.Text = ds.Tables[0].Rows[0][""].ToString();
                        ViewState["Pk_ContractId"] = ds.Tables[0].Rows[0]["Pk_ContractId"].ToString();
                        ViewState["pk_BudgetHeadId"] = ds.Tables[0].Rows[0]["pk_BudgetHeadId"].ToString();

                    }
                    else
                    {
                       
                    }

                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "BillDetails.cs >> Method BindControl()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }

        protected void btnLockBudget_Click(object sender, EventArgs e)
        {      
            BALContrator bAL = new BALContrator();
            DataSet ds = bAL.LockGenerateBill(3, 11401, ViewState["Pk_ContractId"].ToString(), txtBillForPeriodfromto.Text, Convert.ToDecimal(txtTotalBillAmount.Text), ViewState["pk_BudgetHeadId"].ToString(),txtTendorNo.Text, txtContractorName.Text, txtAddressOfContractor.Text, txtBudgetHead.Text, txtBudgetCode.Text,Convert.ToDecimal(txtTotalBudgetValue.Text),Convert.ToDecimal(txtAvailablebudgetValue.Text), txtContractorName.Text);
            if (ds.Tables[0].Rows.Count > 0)
            {
                ClearControl();
            }
            tableWrapper.Visible = false;
        }
        void ClearControl()
        {
            txtAddressOfContractor.Text = "";
            txtAvailablebudgetValue.Text = "";
            txtBillForPeriodfromto.Text = "";
            txtBudgetCode.Text = "";
            txtBudgetHead.Text = "";
            txtContractorName.Text = "";
            txtTendorNo.Text = "";
            txtTotalBillAmount.Text = "";
            txtTotalBudgetValue.Text = "";            
        }
    }
}