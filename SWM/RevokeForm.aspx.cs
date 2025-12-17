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
    public partial class RevokeForm : System.Web.UI.Page
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
                DataSet ds = bAL.GetRevokeForm(1, "0", "0");

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
                Logfile.TraceService("LogData", "RevokeForm.cs >> Method BindGrid()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
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
            BindGrid();
        }
        void BindGrid()
        {
            try
            {
                BALContrator bAL = new BALContrator();
                DataSet ds = bAL.GetRevokeForm(2, ddlContractName.SelectedItem.Value, "");

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
                Logfile.TraceService("LogData", "RevokeForm.cs >> Method BindGrid()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }

        protected void grdData_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "AddRemark")
            {
                // Find the GridViewRow containing the LinkButton
                GridViewRow row = (GridViewRow)((Control)e.CommandSource).NamingContainer;

                // Access and manipulate the row as needed
                int rowIndex = row.RowIndex;

                string command= e.CommandArgument.ToString();
                
                GridViewRow row1 = grdData.Rows[rowIndex];

                TextBox txtValue = (TextBox)row1.FindControl("txtValue");
                string newValue = txtValue.Text;

                ViewState["id"] = rowIndex;
                BALContrator bAL = new BALContrator(); //bAL.GetRevokeForm(2, ddlContractName.SelectedItem.Value, "");
                DataSet ds = bAL.GetRevokeForm(3, command, txtValue.Text);

                if (ds.Tables.Count > 0)
                {
                    BindGrid();
                }
            }
        }

        protected void grdData_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Assuming that the data source for the GridView is a DataTable
                DataRowView rowView = (DataRowView)e.Row.DataItem;
                string columnName = rowView["Remark"].ToString();

                Label lblValue = (Label)e.Row.FindControl("lblValue");
                TextBox txtValue = (TextBox)e.Row.FindControl("txtValue");
                LinkButton linkButton = (LinkButton)e.Row.FindControl("btnRemark");
                if (string.IsNullOrEmpty(columnName))
                {
                    lblValue.Visible = false;
                    txtValue.Visible = true;
                    linkButton.Visible = true;
                }
                else
                {
                    lblValue.Visible = true;
                    txtValue.Visible = false;
                    linkButton.Visible = false;
                }
            }
        }

        protected void btnRemark_Click(object sender, EventArgs e)
        {
            //try
            //{
            //    //code pending
            //    // Find the GridViewRow containing the LinkButton
            //    GridViewRow row = (GridViewRow)((Control)e.CommandSource).NamingContainer;

            //    // Access and manipulate the row as needed
            //    int rowIndex = row.RowIndex;
            //    LinkButton clickedButton = (LinkButton)sender;
            //    string[] parameters = clickedButton.CommandArgument.Split('|');
            //    int fk_vehicleid = Convert.ToInt32(parameters[0]);
            //    string date = parameters[1];
            //    int route = Convert.ToInt32(parameters[2]);
            //    BalFeederSummaryReport bAL = new BalFeederSummaryReport();
            //    FeederSummaryReport mAP = new FeederSummaryReport();
            //    string redirectUrl = "VehicleMapViewHistory.aspx?fk_vehicleid=" + fk_vehicleid +
            //                           "&date=" + date + "&route=" + route +
            //                            "&FunName=" + "FeederSummaryReport";

            //    Response.Redirect(redirectUrl, false);
            //    //LoadData(date, Convert.ToInt32(fk_vehicleid));
            //}
            //catch (Exception ex)
            //{
            //    Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
            //    Logfile.TraceService("LogData", "Messanger >> Method LnkView_Click()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
            //    Logfile.TraceService("LogData", "Message >> " + ex.Message);
            //    Logfile.TraceService("LogData", "Source >> " + ex.Source);
            //    Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
            //    Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
            //    Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
            //    Logfile.TraceService("LogData", ex.Message);
            //}
        }
    }
}