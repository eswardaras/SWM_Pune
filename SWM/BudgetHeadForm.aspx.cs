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
    public partial class BudgetHeadForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }

        protected void btnBudgetHead_Click(object sender, EventArgs e)
        {
            try
            {
                int @mode;
                int @BudgetHeadId;
                if (ViewState["id"] != null && Convert.ToString(ViewState["id"]) != "")
                {
                    @mode = 3;
                    @BudgetHeadId = Convert.ToInt32(ViewState["id"].ToString());
                }
                else
                {
                    @mode = 1;
                    @BudgetHeadId = 0;
                }
                BALContrator bAL = new BALContrator();
                //== sp ref==//
                //exec proc_ContractorRegistration @mode = 1,@BudgetHeadName,@BudgetHeadCode,@TotalBudgetValue,@PrevSanctionedValue,@PrevSanctionedYear,  
                //@AvailableBudgetValue,@AvailableBudgetYear,@SanctioningAuthority,@dateOfApproval,@SanctionedNo,  
                //@SanctionedByFinancialCommittee,1,getdate()
                // == sp ref==//
                DataSet dsSave = bAL.InsertBudgetHead(@mode, 11401, txtBudgetHead.Text, Convert.ToInt64(txtBudgetHeadCode.Text), Convert.ToDecimal(txtTotalBudgetValue.Text),
                    Convert.ToDecimal(txtPreviousSanctionedValue.Text), txtPreviousSanctionedYear.Text, Convert.ToDecimal(txtAvailableBudgetValue.Text), txtAvailableBudgetYear.Text,
                    ddlSanctioningAuthority.SelectedItem.Text, txtDateofApproval.Text, txtSanctionNo.Text, rbtSanctionedByFinanceComittee.SelectedItem.Text, @BudgetHeadId);
                if (dsSave.Tables.Count > 0)
                {
                    BindGrid();
                    ClearControl();
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "BudgetHeadForm.cs >> Method btnBudgetHead_Click()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
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
            txtAvailableBudgetValue.Text = "";
            txtAvailableBudgetYear.Text = "";
            txtBudgetHead.Text = "";
            txtBudgetHeadCode.Text = "";
            txtDateofApproval.Text = "";
            txtPreviousSanctionedValue.Text = "";
            txtPreviousSanctionedYear.Text = "";
            txtSanctionNo.Text = "";
            txtTotalBudgetValue.Text = "";
        }
        void BindGrid()
        {
            try
            {
                BALContrator bAL = new BALContrator();
                DataSet ds = bAL.GetBudgetHead(5, 11401,0);

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
                Logfile.TraceService("LogData", "BudgetHeadForm.cs >> Method BindGrid()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
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
                DataSet ds = bAL.GetBudgetHead(4,11401, Convert.ToInt32(ViewState["id"]));

                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        txtBudgetHead.Text = ds.Tables[0].Rows[0]["BudgetHeadName"].ToString();
                        txtBudgetHeadCode.Text = ds.Tables[0].Rows[0]["BudgetCode"].ToString();
                        txtTotalBudgetValue.Text = ds.Tables[0].Rows[0]["TotalBudgetValue"].ToString();
                        txtPreviousSanctionedValue.Text = ds.Tables[0].Rows[0]["PrevSanctionedValue"].ToString();
                        txtPreviousSanctionedYear.Text = ds.Tables[0].Rows[0]["PrevSanctionedYear"].ToString();
                        txtAvailableBudgetValue.Text = ds.Tables[0].Rows[0]["AvailableBudgetValue"].ToString();
                        txtAvailableBudgetYear.Text = ds.Tables[0].Rows[0]["AvailableBudgetYear"].ToString();
                        txtSanctionNo.Text = ds.Tables[0].Rows[0]["SanctioningAuthority"].ToString();
                        txtDateofApproval.Text = ds.Tables[0].Rows[0]["dateOfApproval"].ToString();
                        txtSanctionNo.Text = ds.Tables[0].Rows[0]["SanctionedNo"].ToString();
                        rbtSanctionedByFinanceComittee.SelectedItem.Text = ds.Tables[0].Rows[0]["SanctionedByFinancialCommittee"].ToString();
                        
                    }
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "BudgetHeadForm.cs >> Method btnEdit_Click()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
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
                DataSet ds = bAL.GetBudgetHead(2,11401, Convert.ToInt32(ViewState["id"]));

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
                Logfile.TraceService("LogData", "BudgetHeadForm.cs >> Method btnDelete_Click()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
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