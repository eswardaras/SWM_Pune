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
    public partial class ByproductsGenerationAndSalesRevenue : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
                adhocTable.RowEditing += adhocTable_RowEditing;
            }
        }

        protected void adhocTable_RowEditing(object sender, GridViewEditEventArgs e)
        {
            //// Set the EditIndex property of the GridView to the index of the row being edited
            //adhocTable.EditIndex = e.NewEditIndex;
            //// Rebind the GridView to display the editable row
            //BindGridView();
        }
        private void BindGrid()
        {
            RampBAL bAL = new RampBAL();
            DatewiseWeightReport mAP = new DatewiseWeightReport();
            //=====ZONE=====//
            //"begin tran t
            //exec proc_SweeperRouteCoverageReportNew @mode = 11,@vehicleId = 0,@AccId = 11401,@ZoneId = 0,@WardId = 0,@startdate = default,@enddate = default,@stime = default,@etime = default,@RptName = default,@Report = default,@Zone = default,@Ward = default,@WorkingType = default,@RouteId = 0,@AdminID = 0,@RoleID = 0
            //rollback tran t"
            //==sp ref==//
            adhocTable.DataSource = null;
            adhocTable.DataBind();
            DataSet ds = bAL.GetByProduct();
            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    adhocTable.DataSource = ds.Tables[0];
                    adhocTable.DataBind();
                }
            }
            ViewState["Data"] = ds.Tables[0];
        }
        protected void ButtonSubmitt_Click(object sender, EventArgs e)
        {
            try
            {

                if (ViewState["pk_Id"] == null)
                {

                    Button btn = (Button)sender;
                    //GridViewRow row = (GridViewRow)btn.NamingContainer;
                    //int rowIndex = row.RowIndex;

                    //DataRow d = ((DataTable)ViewState["Data"]).Rows[rowIndex];
                    //var Pk_RequestId = d["Pk_AdhocReqId"];
                    //var workstatus = btn.Text;
                    //string accid = "11401";

                    BALAdhoc bAL = new BALAdhoc();
                    //@TypeOfWasteGenratedInTones,@TypeOfByproductGenrated,@ByProductsaleInTones,@RevenueGenrated,@AuthorisedBy,@TypeOfWasteGenrated,1,getdate()
                    string TypeOfWasteGenratedInTones = txtTypeofwasteInTones.Text;
                    string TypeOfByproductGenrated = txtTypeOfByproductGenrated.Text;
                    string ByProductsaleInTones = txtByProductsaleInTones.Text;
                    string RevenueGenrated = txtRevenueGenerated.Text;
                    string AuthorisedBy = txtAuthorisedBy.Text;
                    string TypeOfWasteGenrated = txtTypeofWasteGenerated.Text;


                    //=====WARD=====//
                    // exec Proc_VehicleMap @mode = 3,@FK_VehicleID = 0,@zoneId = 0,@WardId = 0,@sDate = default,@eDate = default,@UserID = 11401,@zoneName = default,@WardName = default
                    DataSet dsGetVehicle = bAL.insernewByproductsGeneration(TypeOfWasteGenratedInTones, TypeOfByproductGenrated, ByProductsaleInTones, RevenueGenrated, AuthorisedBy, TypeOfWasteGenrated);

                    string script = "alert('New Request Created successful!');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "SuccessMessage", script, true);
                    BindGrid();
                }
                else
                {
                    

                        Button btn = (Button)sender;
                        //GridViewRow row = (GridViewRow)btn.NamingContainer;
                        //int rowIndex = row.RowIndex;

                        //DataRow d = ((DataTable)ViewState["Data"]).Rows[rowIndex];
                        //var Pk_RequestId = d["Pk_AdhocReqId"];
                        //var workstatus = btn.Text;
                        //string accid = "11401";

                        BALAdhoc bAL = new BALAdhoc();
                        //@TypeOfWasteGenratedInTones,@TypeOfByproductGenrated,@ByProductsaleInTones,@RevenueGenrated,@AuthorisedBy,@TypeOfWasteGenrated,1,getdate()
                        string TypeOfWasteGenratedInTones = txtTypeofwasteInTones.Text;
                        string TypeOfByproductGenrated = txtTypeOfByproductGenrated.Text;
                        string ByProductsaleInTones = txtByProductsaleInTones.Text;
                        string RevenueGenrated = txtRevenueGenerated.Text;
                        string AuthorisedBy = txtAuthorisedBy.Text;
                        string TypeOfWasteGenrated = txtTypeofWasteGenerated.Text;


                        //=====WARD=====//
                        // exec Proc_VehicleMap @mode = 3,@FK_VehicleID = 0,@zoneId = 0,@WardId = 0,@sDate = default,@eDate = default,@UserID = 11401,@zoneName = default,@WardName = default
                        DataSet dsGetVehicle = bAL.updateByproductsGeneration(TypeOfWasteGenratedInTones, TypeOfByproductGenrated, ByProductsaleInTones, RevenueGenrated, AuthorisedBy, TypeOfWasteGenrated, ViewState["pk_Id"].ToString());

                        string script = "alert('Request Updated successful!');";
                        ScriptManager.RegisterStartupScript(this, GetType(), "SuccessMessage", script, true);
                        ViewState["pk_Id"] = null;
                }

            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "Messanger.cs >> Method FeederSummaryReport_BindDDLVehicle()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
            tableWrapper.Visible = true;


        }

        protected void btnEditRequest_Click(object sender, EventArgs e)
        {
            try
            {
                //int i = (int)ViewState["SelectedDatarow"];


                Button btn = (Button)sender;
                GridViewRow row = (GridViewRow)btn.NamingContainer;
                int rowIndex = row.RowIndex;
                
                ViewState["SelectedDatarow"] = rowIndex;
                DataRow d = ((DataTable)ViewState["Data"]).Rows[rowIndex];
                ViewState["pk_Id"] = d["pk_Id"];


                txtAuthorisedBy.Text = d["AuthorisedBy"].ToString();
                txtTypeofWasteGenerated.Text = d["TypeOfWasteGenrated"].ToString();
                txtRevenueGenerated.Text = d["RevenueGenrated"].ToString();
                txtByProductsaleInTones.Text = d["ByProductsaleInTones"].ToString();
                txtTypeOfByproductGenrated.Text = d["TypeOfByproductGenrated"].ToString();
                txtTypeofwasteInTones.Text = d["TypeOfWasteGenratedInTones"].ToString();

                

             
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "Messanger.cs >> Method FeederSummaryReport_BindDDLVehicle()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }

        protected void ButtonCancel_Click(object sender, EventArgs e)
        {
            try
            {
                //int i = (int)ViewState["SelectedDatarow"];


                
                ViewState["SelectedDatarow"] = null;
                ViewState["pk_Id"] = null;
                BindGrid();
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "Messanger.cs >> Method FeederSummaryReport_BindDDLVehicle()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }


        protected void ButtonDelete_Click(object sender, EventArgs e)
        {
            try
            {
                //int i = (int)ViewState["SelectedDatarow"];



                List<GridViewRow> selectedRows = new List<GridViewRow>();

                foreach (GridViewRow row in adhocTable.Rows)
                {
                    CheckBox checkBoxSelect = row.FindControl("CheckBoxSelect") as CheckBox;

                    if (checkBoxSelect != null && checkBoxSelect.Checked)
                    {
                        selectedRows.Add(row);
                    }
                }

                // Process the selected rows as needed
                foreach (GridViewRow selectedRow in selectedRows)
                {

                    var Pk_RequestId = Convert.ToInt16(selectedRow.Cells[1].Text);//selectedRow["pk_Id"];
                    //var vehicleid = ddlvehicle.SelectedValue;
                    string accid = "11401";

                    BALAdhoc bAL = new BALAdhoc();
                    //=====WARD=====//
                    //exec Proc_VehicleMap @mode=3,@FK_VehicleID=0,@zoneId=0,@WardId=0,@sDate=default,@eDate=default,@UserID=11401,@zoneName=default,@WardName=default
                    DataSet dsGetVehicle = bAL.deleteRequestBY(Pk_RequestId, accid);
                    // Show success message
                 
                }

                // Refresh the GridView or perform any other necessary actions
                string script = "alert('Delete successful!');";
                ScriptManager.RegisterStartupScript(this, GetType(), "SuccessMessage", script, true);
                BindGrid();
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "Messanger.cs >> Method FeederSummaryReport_BindDDLVehicle()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
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