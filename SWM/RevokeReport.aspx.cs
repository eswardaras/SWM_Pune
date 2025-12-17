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
    public partial class RevokeReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDDL();
                BindGrid();
            }
        }

        void BindDDL()
        {
            try
            {
                BALContrator bAL = new BALContrator();
                DataSet ds = bAL.GetRevokeDetail(1, "0", "0");

                if (ds.Tables.Count > 0)
                {
                    DataRow allOption = ds.Tables[0].NewRow();
                    allOption["pk_contractid"] = 0;
                    allOption["ContractName"] = "Select All";
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
                Logfile.TraceService("LogData", "RevokeReport.cs >> Method BindGrid()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }
        protected void btnSerch_Click(object sender, EventArgs e)
        {
            //exec proc_RevokeReport @mode = 2,@accid = 0,@EmpId = 0,@roleid = 0,@revokeid = 0,@Status = default
            BindGrid();
        }
        void BindGrid()
        {
            try
            {
                BALContrator bAL = new BALContrator();
                DataSet ds = bAL.GetRevokeDetail(2, ddlContractName.SelectedItem.Value, "");

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
                Logfile.TraceService("LogData", "RevokeReport.cs >> Method BindGrid()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }

        protected void btnRevoke_Click(object sender, EventArgs e)
        {
            try
            {
                LinkButton clickedButton = (LinkButton)sender;
                string[] parameters = clickedButton.CommandArgument.Split('|');
                string fk_id = parameters[0];
                //string date = parameters[1];
                ViewState["id"] = fk_id;
                BALContrator bAL = new BALContrator();
                DataSet ds = bAL.GetRevokeDetail(3, ViewState["id"].ToString(), Convert.ToString("Revoke"));

                if (ds.Tables.Count > 0)
                {
                    BindGrid();
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "RevokeReport.cs >> Method btnRevoke_Click()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }

        protected void btnTerminate_Click(object sender, EventArgs e)
        {
            try
            {
                LinkButton clickedButton = (LinkButton)sender;
                string[] parameters = clickedButton.CommandArgument.Split('|');
                string fk_id = parameters[0];
                //string date = parameters[1];
                ViewState["id"] = fk_id;
                BALContrator bAL = new BALContrator();
                DataSet ds = bAL.GetRevokeDetail(3, ViewState["id"].ToString(), Convert.ToString("Terminate"));

                if (ds.Tables.Count > 0)
                {
                    BindGrid();
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "RevokeReport.cs >> Method btnTerminate_Click()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }

        protected void grdData_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Assuming that the data source for the GridView is a DataTable
                DataRowView rowView = (DataRowView)e.Row.DataItem;
                string columnName = rowView["Status"].ToString();

                LinkButton btnRevoke = (LinkButton)e.Row.FindControl("btnRevoke");               
                LinkButton linkButton = (LinkButton)e.Row.FindControl("btnTerminate");
                if (columnName == "Revoke")
                {
                    btnRevoke.Visible = true;
                    btnRevoke.Enabled = false;
                    linkButton.Visible = false;
                }
                else if (columnName == "Terminate")
                {
                    btnRevoke.Visible = false;
                    linkButton.Visible = true;
                    linkButton.Enabled = false;
                }
                else if (columnName== "Pending")
                {
                    btnRevoke.Visible = true;
                    linkButton.Visible = true;
                }
                else
                {
                    btnRevoke.Visible = false;
                    linkButton.Visible = false;
                }
            }
        }
    }
}