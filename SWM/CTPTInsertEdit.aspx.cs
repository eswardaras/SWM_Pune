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
    public partial class CTPTInsertEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid("C & D Waste");
                BindAllDropDown();
                BindDDLVehicle();
            }
        }

        private void BindAllDropDown()
        {
            BindDDLZone();
        //    BindSupervisorZone();
            bindMokadam();
            bindsi();
            bindDsi();
        }

        private void bindMokadam()
        {
            try
            {
                BALCTPT bAL = new BALCTPT();
                FeederSummaryReport mAP = new FeederSummaryReport();
                //=====ZONE=====//
                //"begin tran t
                //exec proc_SweeperRouteCoverageReportNew @mode = 11,@vehicleId = 0,@AccId = 11401,@ZoneId = 0,@WardId = 0,@startdate = default,@enddate = default,@stime = default,@etime = default,@RptName = default,@Report = default,@Zone = default,@Ward = default,@WorkingType = default,@RouteId = 0,@AdminID = 0,@RoleID = 0
                //rollback tran t"
                //==sp ref==//
                DataSet ds = bAL.GetMokadam();
                if (ds.Tables.Count > 0)
                {
                    // Add the "Select All" option to the DataTable
                    DataRow allOption = ds.Tables[0].NewRow();
                    allOption["pk_empid"] = 0;
                    allOption["EmpName"] = "Select All";
                    ds.Tables[0].Rows.InsertAt(allOption, 0);

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        // Set the dropdown list's data source and bind the data
                        ddlMukadam.DataSource = ds.Tables[0];
                        ddlMukadam.DataTextField = "EmpName"; // Field to display as option text
                        ddlMukadam.DataValueField = "pk_empid"; // Field to use as option value
                        ddlMukadam.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "Messanger.cs >> Method FeederSummaryReport_BindDDLZone()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }

        private void bindsi()
        {
            try
            {
                BALCTPT bAL = new BALCTPT();
                FeederSummaryReport mAP = new FeederSummaryReport();
                //=====ZONE=====//
                //"begin tran t
                //exec proc_SweeperRouteCoverageReportNew @mode = 11,@vehicleId = 0,@AccId = 11401,@ZoneId = 0,@WardId = 0,@startdate = default,@enddate = default,@stime = default,@etime = default,@RptName = default,@Report = default,@Zone = default,@Ward = default,@WorkingType = default,@RouteId = 0,@AdminID = 0,@RoleID = 0
                //rollback tran t"
                //==sp ref==//
                DataSet ds = bAL.GetSI();
                if (ds.Tables.Count > 0)
                {
                    // Add the "Select All" option to the DataTable
                    DataRow allOption = ds.Tables[0].NewRow();
                    allOption["pk_empid"] = 0;
                    allOption["EmpName"] = "Select All";
                    ds.Tables[0].Rows.InsertAt(allOption, 0);

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        // Set the dropdown list's data source and bind the data
                        ddlSI.DataSource = ds.Tables[0];
                        ddlSI.DataTextField = "EmpName"; // Field to display as option text
                        ddlSI.DataValueField = "pk_empid"; // Field to use as option value
                        ddlSI.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "Messanger.cs >> Method FeederSummaryReport_BindDDLZone()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }

        private void bindDsi()
        {
            try
            {
                BALCTPT bAL = new BALCTPT();
                FeederSummaryReport mAP = new FeederSummaryReport();
                //=====ZONE=====//
                //"begin tran t
                //exec proc_SweeperRouteCoverageReportNew @mode = 11,@vehicleId = 0,@AccId = 11401,@ZoneId = 0,@WardId = 0,@startdate = default,@enddate = default,@stime = default,@etime = default,@RptName = default,@Report = default,@Zone = default,@Ward = default,@WorkingType = default,@RouteId = 0,@AdminID = 0,@RoleID = 0
                //rollback tran t"
                //==sp ref==//
                DataSet ds = bAL.GetDSI();
                if (ds.Tables.Count > 0)
                {
                    // Add the "Select All" option to the DataTable
                    DataRow allOption = ds.Tables[0].NewRow();
                    allOption["pk_empid"] = 0;
                    allOption["EmpName"] = "Select All";
                    ds.Tables[0].Rows.InsertAt(allOption, 0);

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        // Set the dropdown list's data source and bind the data
                        ddlDSI.DataSource = ds.Tables[0];
                        ddlDSI.DataTextField = "EmpName"; // Field to display as option text
                        ddlDSI.DataValueField = "pk_empid"; // Field to use as option value
                        ddlDSI.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "Messanger.cs >> Method FeederSummaryReport_BindDDLZone()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }

        void BindDDLZone()
        {
            try
            {
                BalFeederSummaryReport bAL = new BalFeederSummaryReport();
                FeederSummaryReport mAP = new FeederSummaryReport();
                //=====ZONE=====//
                //"begin tran t
                //exec proc_SweeperRouteCoverageReportNew @mode = 11,@vehicleId = 0,@AccId = 11401,@ZoneId = 0,@WardId = 0,@startdate = default,@enddate = default,@stime = default,@etime = default,@RptName = default,@Report = default,@Zone = default,@Ward = default,@WorkingType = default,@RouteId = 0,@AdminID = 0,@RoleID = 0
                //rollback tran t"
                //==sp ref==//
                DataSet ds = bAL.GetZone(11, 0, 11401);
                if (ds.Tables.Count > 0)
                {
                    // Add the "Select All" option to the DataTable
                    DataRow allOption = ds.Tables[0].NewRow();
                    allOption["zoneid"] = 0;
                    allOption["zonename"] = "Select All";
                    ds.Tables[0].Rows.InsertAt(allOption, 0);

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        // Set the dropdown list's data source and bind the data
                        ddlZone.DataSource = ds.Tables[0];
                        ddlZone.DataTextField = "zonename"; // Field to display as option text
                        ddlZone.DataValueField = "zoneid"; // Field to use as option value
                        ddlZone.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "Messanger.cs >> Method FeederSummaryReport_BindDDLZone()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }
        private void BindGrid(string text)
        {
            BALCTPT bAL = new BALCTPT();
            DatewiseWeightReport mAP = new DatewiseWeightReport();
            //=====ZONE=====//
            //"begin tran t
            //exec proc_SweeperRouteCoverageReportNew @mode = 11,@vehicleId = 0,@AccId = 11401,@ZoneId = 0,@WardId = 0,@startdate = default,@enddate = default,@stime = default,@etime = default,@RptName = default,@Report = default,@Zone = default,@Ward = default,@WorkingType = default,@RouteId = 0,@AdminID = 0,@RoleID = 0
            //rollback tran t"
            //==sp ref==//
            DataSet ds = bAL.GetGridData();
            adhocTable.DataSource = null;
            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    adhocTable.DataSource = ds.Tables[0];
                    adhocTable.DataBind();
                }
            }
            ViewState["Data"] = ds.Tables[0];
            btSubmitt.Text = "Add CTPT";
            clearallcontrols();
        }

        private void clearallcontrols()
        {
            ddlZone.ClearSelection();
            ddlWard.ClearSelection();
            ddlKothi.ClearSelection();
            ddlCTPTType.ClearSelection();
            txboxCTPTName.Text = string.Empty;
            txtlongitude.Text = string.Empty;
            txtLattitude.Text = string.Empty;
            txtAddress.Text = string.Empty;
            ddlMukadam.ClearSelection();
            ddlDSI.ClearSelection();
            ddlSI.ClearSelection();
            txtNos.Text = string.Empty;

        }

        protected void RadioButton_CheckedChanged(object sender, EventArgs e)
        {
            BindGrid(((System.Web.UI.WebControls.CheckBox)sender).Text);
            // Handle the radio button selection change event
            // Logic to execute when the radio button selection changes
        }

        protected void btnWorkStatus_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            int rowIndex = row.RowIndex;

            DataRow d = ((DataTable)ViewState["Data"]).Rows[rowIndex];
            var Pk_RequestId = d["Pk_AdhocReqId"];
            var workstatus = btn.Text;
            string accid = "11401";

            BALAdhoc bAL = new BALAdhoc();
            //=====WARD=====//
            //exec Proc_VehicleMap @mode=3,@FK_VehicleID=0,@zoneId=0,@WardId=0,@sDate=default,@eDate=default,@UserID=11401,@zoneName=default,@WardName=default
            DataSet dsGetVehicle = bAL.updateworkstatus(Pk_RequestId, workstatus, accid);
            //if (dsGetVehicle.Tables.Count > 0)
            //{
            //    DataRow allOption = dsGetVehicle.Tables[0].NewRow();
            //    allOption["id"] = 0;
            //    allOption["name"] = "Select All";
            //    dsGetVehicle.Tables[0].Rows.InsertAt(allOption, 0);
            //    if (dsGetVehicle.Tables[0].Rows.Count > 0)
            //    {
            //        // Set the dropdown list's data source and bind the data
            //        ddlvehicle.DataSource = dsGetVehicle.Tables[0];
            //        ddlvehicle.DataTextField = "name"; // Field to display as option text  
            //        ddlvehicle.DataValueField = "id"; // Field to use as option value  
            //        ddlvehicle.DataBind();
            //    }
            //}




        }

        protected void ButtonSubmitt_Click(object sender, EventArgs e)
        {
            try
            {
                Button btn = (Button)sender;
                //GridViewRow row = (GridViewRow)btn.NamingContainer;
                //int rowIndex = row.RowIndex;

                //DataRow d = ((DataTable)ViewState["Data"]).Rows[rowIndex];
                //var Pk_RequestId = d["Pk_AdhocReqId"];
                //var workstatus = btn.Text;
                //string accid = "11401";

                BALCTPT bAL = new BALCTPT();

                //@Accid, @zoneid,@wardid,@Kothiid,@typeid,@name,@Long,@lat,@Address,  
                //@mokadum, @dsi, @SI, @nos,NULL,NULL,NULL,NULL,@Accid,NULL,NULL,getdate(),1

                string accid1 = "11401";
                string zoneid = ddlZone.SelectedValue;
                string wardid = ddlWard.SelectedValue;
                string kothiid = ddlKothi.SelectedValue;
                string typeid = ddlCTPTType.SelectedValue;
                string name = txboxCTPTName.Text;
                string Lon = txtlongitude.Text;
                string lat = txtLattitude.Text;
                string Address = txtAddress.Text;
                string mokadum = ddlMukadam.SelectedItem.Text;
                string dsi = ddlDSI.SelectedItem.Text;
                string SI = ddlSI.SelectedItem.Text;
                string nos = txtNos.Text;



                ////=====WARD=====//
                //// exec Proc_VehicleMap @mode = 3,@FK_VehicleID = 0,@zoneId = 0,@WardId = 0,@sDate = default,@eDate = default,@UserID = 11401,@zoneName = default,@WardName = default
                ///
                if (btSubmitt.Text == "Add CTPT")
                {
                    DataSet dsGetVehicle = bAL.insernewrequest(accid1, zoneid, wardid, kothiid, typeid, name, Lon, lat, Address, mokadum, dsi, SI, nos);
                    string script = "alert('New Request Created successful!');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "SuccessMessage", script, true);
                }
                else
                {
                    DataSet dsGetVehicle = bAL.updatedrequest(accid1, zoneid, wardid, kothiid, typeid, name, Lon, lat, Address, mokadum, dsi, SI, nos, ViewState["pk_Id"]);
                    string script = "alert('Request Updated successful!');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "SuccessMessage", script, true);
                }
                BindGrid(null);
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
        protected void btnSaveAssignment_Click(object sender, EventArgs e)
        {
            pnlAssign.Style["display"] = "block";


            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            int rowIndex = row.RowIndex;
            DataRow dr = ((DataTable)ViewState["Data"]).Rows[rowIndex];
            // Access the data from the selected row
            string workStatus = ((Button)row.FindControl("btnComplete")).Text;
            // Perform further operations based on the work status

            // Example: Update the work status in the database
            //string recordId = adhocTable.DataKeys[rowIndex].Value.ToString();
            //Updateassignment(recordId, workStatus);

            ViewState["SelectedDatarow"] = rowIndex;
        }



        private void BindRamp()
        {
            RampBAL bAL = new RampBAL();
            DatewiseWeightReport mAP = new DatewiseWeightReport();
            //=====ZONE=====//
            //"begin tran t
            //exec proc_SweeperRouteCoverageReportNew @mode = 11,@vehicleId = 0,@AccId = 11401,@ZoneId = 0,@WardId = 0,@startdate = default,@enddate = default,@stime = default,@etime = default,@RptName = default,@Report = default,@Zone = default,@Ward = default,@WorkingType = default,@RouteId = 0,@AdminID = 0,@RoleID = 0
            //rollback tran t"
            //==sp ref==//
            DataSet ds = bAL.GetRamp(11, 0, 11401);
            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    // Set the dropdown list's data source and bind the data


                    //ddlRamp.DataSource = ds.Tables[0];
                    //ddlRamp.DataTextField = "RMM_NAME"; // Field to display as option text
                    //ddlRamp.DataValueField = "RMM_ID"; // Field to use as option value
                    //ddlRamp.DataBind();
                }
            }
        }

        protected void ddlZone_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                if (Convert.ToInt32(ddlZone.SelectedItem.Value) >= 0)
                {
                    BindDDLWard(12, 0, 11401, Convert.ToInt32(ddlZone.SelectedItem.Value));
                    //BindDDLVehicle(3, 0, Convert.ToInt32(ddlZone.SelectedItem.Value), 0, txtSdate.Text, txtEdate.Text, 11401, 0, 0);
                    //BindDDLRoute(24, 11401, 0, Convert.ToInt32(ddlZone.SelectedItem.Value), 0, txtSdate.Text, txtEdate.Text);
                }
                else
                {
                    //BindLoad();
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "Messanger.cs >> Method FeederSummaryReport_ddlZone_SelectedIndexChanged()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }
        protected void ddlWard_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                if (Convert.ToInt32(ddlWard.SelectedItem.Value) >= 0)
                {
                    // BindDDLVehicle(3, 0, Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value), DateTime.Now.Date.ToString(), DateTime.Now.Date.ToString(), 11401, 0, 0);
                    BindDDLKothi(56, 11401, 0, 0, Convert.ToInt32(ddlWard.SelectedItem.Value), Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value),
                      DateTime.Now.Date.ToString(), DateTime.Now.Date.ToString(), 0, 0, 0, 0);
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "Messanger.cs >> Method PerformanceReports_ddlWard_SelectedIndexChanged()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }

        void BindDDLKothi(int @mode, int @Fk_accid, int @Fk_ambcatId, int @Fk_divisionid, int @FK_VehicleID, int @Fk_ZoneId, int @FK_WardId, string @Startdate, string @Enddate,
                int @Maxspeed, int @Minspeed, int @Fk_DistrictId, int @Geoid)
        {
            try
            {
                BalFeederSummaryReport bAL = new BalFeederSummaryReport();
                FeederSummaryReport mAP = new FeederSummaryReport();
                //=====WARD=====//
                //exec Proc_VehicleMapwithRoute @mode=56,@Fk_accid=11401,@Fk_ambcatId=0,@Fk_divisionid=0,@FK_VehicleID=0,@Fk_ZoneId=0,@FK_WardId=1024,@Startdate=default,@Enddate=default,
                //@Maxspeed =0,@Minspeed=0,@Fk_DistrictId=0,@Geoid=0
                DataSet dsGetKothi = bAL.GetKothi(@mode, @Fk_accid, @Fk_ambcatId, @Fk_divisionid, @FK_VehicleID, @Fk_ZoneId, @FK_WardId, @Startdate, @Enddate, @Maxspeed, @Minspeed, @Fk_DistrictId, @Geoid);
                if (dsGetKothi.Tables.Count > 0)
                {
                    DataRow allOption = dsGetKothi.Tables[0].NewRow();
                    allOption["pk_kothiid"] = 0;
                    allOption["kothiname"] = "Select All";
                    dsGetKothi.Tables[0].Rows.InsertAt(allOption, 0);
                    if (dsGetKothi.Tables[0].Rows.Count > 0)
                    {
                        // Set the dropdown list's data source and bind the data
                        ddlKothi.DataSource = dsGetKothi.Tables[0];
                        ddlKothi.DataTextField = "kothiname"; // Field to display as option text  
                        ddlKothi.DataValueField = "pk_kothiid"; // Field to use as option value  
                        ddlKothi.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "Messanger.cs >> Method PerformanceReports_BindDDLKothi()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }

        protected void ddlKothi_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                if (Convert.ToInt32(ddlKothi.SelectedItem.Value) >= 0)
                {
                    // BindDDLVehicle(3, 0, Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value), DateTime.Now.Date.ToString(), DateTime.Now.Date.ToString(), 11401, 0, 0);
                    BindDDLmukadam(8, Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value), Convert.ToInt32(ddlKothi.SelectedItem.Value),
                      DateTime.Now.Date.ToString(), DateTime.Now.Date.ToString());
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "Messanger.cs >> Method PerformanceReports_ddlWard_SelectedIndexChanged()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }


        void BindDDLmukadam(int @mode, int @Fk_ZoneId, int @FK_WardId, int @FK_KothiId, string @Startdate, string @Enddate)
        {
            try
            {
                BALAdhoc bAL = new BALAdhoc();
                //=====WARD=====//
                //exec proc_SweeperRouteCoverageReportNew @mode = 12,@vehicleId = 0,@AccId = 11401,@ZoneId = default
                DataSet dsGetWard = bAL.GetMukadam(@mode, @Fk_ZoneId, @FK_WardId, @FK_KothiId);
                if (dsGetWard.Tables.Count > 0)
                {
                    DataRow allOption = dsGetWard.Tables[0].NewRow();
                    allOption["PK_EmpId"] = 0;
                    allOption["EmpName"] = "Select All";
                    dsGetWard.Tables[0].Rows.InsertAt(allOption, 0);
                    if (dsGetWard.Tables[0].Rows.Count > 0)
                    {
                        // Set the dropdown list's data source and bind the data
                        ddlMukadam.DataSource = dsGetWard.Tables[0];
                        ddlMukadam.DataTextField = "EmpName"; // Field to display as option text 
                        ddlMukadam.DataValueField = "PK_EmpId"; // Field to use as option value 
                        ddlMukadam.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "Messanger.cs >> Method FeederSummaryReport_BindDDLWard()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }

        void BindDDLWard(int @mode, int @vehicleId, int @AccId, int @ZoneId)
        {
            try
            {
                BalFeederSummaryReport bAL = new BalFeederSummaryReport();
                FeederSummaryReport mAP = new FeederSummaryReport();
                //=====WARD=====//
                //exec proc_SweeperRouteCoverageReportNew @mode = 12,@vehicleId = 0,@AccId = 11401,@ZoneId = default
                DataSet dsGetWard = bAL.GetWard(@mode, @vehicleId, @AccId, @ZoneId);
                if (dsGetWard.Tables.Count > 0)
                {
                    DataRow allOption = dsGetWard.Tables[0].NewRow();
                    allOption["PK_wardId"] = 0;
                    allOption["wardName"] = "Select All";
                    dsGetWard.Tables[0].Rows.InsertAt(allOption, 0);
                    if (dsGetWard.Tables[0].Rows.Count > 0)
                    {
                        // Set the dropdown list's data source and bind the data
                        ddlWard.DataSource = dsGetWard.Tables[0];
                        ddlWard.DataTextField = "wardName"; // Field to display as option text 
                        ddlWard.DataValueField = "PK_wardId"; // Field to use as option value 
                        ddlWard.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "Messanger.cs >> Method FeederSummaryReport_BindDDLWard()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }
        void BindDDLRoute(int @mode, int @Fk_accid, int @FK_VehicleID, int @Fk_ZoneId, int @FK_WardId, string @Startdate, string @Enddate)
        {
            try
            {
                BalFeederSummaryReport bAL = new BalFeederSummaryReport();
                FeederSummaryReport mAP = new FeederSummaryReport();
                //=====WARD=====//
                //exec Proc_VehicleMapwithRoute @mode=24,@Fk_accid=11401,@FK_VehicleID=0,@Fk_ZoneId=104,@FK_WardId=1026,@Startdate=default,@Enddate=default
                // exec Proc_VehicleMapwithRoute @mode = 24,@Fk_accid = 11401,@FK_VehicleID = 0,@Fk_ZoneId = 104,@FK_WardId = 1026,@Startdate = default,@Enddate = default
                DataSet dsGetRoute = bAL.GetRoute(@mode, @Fk_accid, @FK_VehicleID, @Fk_ZoneId, @FK_WardId, @Startdate, @Enddate);
                if (dsGetRoute.Tables.Count > 0)
                {
                    DataRow allOption = dsGetRoute.Tables[0].NewRow();
                    allOption["RouteId"] = 0;
                    allOption["RouteName"] = "Select All";
                    dsGetRoute.Tables[0].Rows.InsertAt(allOption, 0);
                    if (dsGetRoute.Tables[0].Rows.Count > 0)
                    {
                        // Set the dropdown list's data source and bind the data
                        //ddlRoute.DataSource = dsGetRoute.Tables[0];
                        //ddlRoute.DataTextField = "RouteName"; // Field to display as option text  
                        //ddlRoute.DataValueField = "RouteId"; // Field to use as option value 
                        //ddlRoute.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "Messanger.cs >> Method FeederSummaryReport_BindDDLRoute()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }
        void BindDDLVehicle()
        {
            try
            {
                BALAdhoc bAL = new BALAdhoc();
                //=====WARD=====//
                //exec Proc_VehicleMap @mode=3,@FK_VehicleID=0,@zoneId=0,@WardId=0,@sDate=default,@eDate=default,@UserID=11401,@zoneName=default,@WardName=default
                DataSet dsGetVehicle = bAL.GetVehicle();
                if (dsGetVehicle.Tables.Count > 0)
                {
                    DataRow allOption = dsGetVehicle.Tables[0].NewRow();
                    allOption["id"] = 0;
                    allOption["name"] = "Select All";
                    dsGetVehicle.Tables[0].Rows.InsertAt(allOption, 0);
                    if (dsGetVehicle.Tables[0].Rows.Count > 0)
                    {
                        // Set the dropdown list's data source and bind the data
                        ddlvehicle.DataSource = dsGetVehicle.Tables[0];
                        ddlvehicle.DataTextField = "name"; // Field to display as option text  
                        ddlvehicle.DataValueField = "id"; // Field to use as option value  
                        ddlvehicle.DataBind();
                    }
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
        }

        protected void btnDeleteRequest_Click(object sender, EventArgs e)
        {
            try
            {
                //int i = (int)ViewState["SelectedDatarow"];

                Button btn = (Button)sender;
                GridViewRow row = (GridViewRow)btn.NamingContainer;
                int rowIndex = row.RowIndex;
                DataRow d = ((DataTable)ViewState["Data"]).Rows[rowIndex];


                var Pk_RequestId = d["Pk_AdhocReqId"];
                //var vehicleid = ddlvehicle.SelectedValue;
                string accid = "11401";

                BALAdhoc bAL = new BALAdhoc();
                //=====WARD=====//
                //exec Proc_VehicleMap @mode=3,@FK_VehicleID=0,@zoneId=0,@WardId=0,@sDate=default,@eDate=default,@UserID=11401,@zoneName=default,@WardName=default
                DataSet dsGetVehicle = bAL.deleteRequest(Pk_RequestId, accid);
                // Show success message
                string script = "alert('Delete successful!');";
                ScriptManager.RegisterStartupScript(this, GetType(), "SuccessMessage", script, true);
              //  BindGrid(rbCD.Checked ? "C & D Waste" : "Special Waste");
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


        protected void ButtonAssign_Click(object sender, EventArgs e)
        {
            try
            {
                int i = (int)ViewState["SelectedDatarow"];
                DataRow d = ((DataTable)ViewState["Data"]).Rows[i];
                var Pk_RequestId = d["Pk_AdhocReqId"];
                var vehicleid = ddlvehicle.SelectedValue;
                string accid = "11401";

                BALAdhoc bAL = new BALAdhoc();
                //=====WARD=====//
                //exec Proc_VehicleMap @mode=3,@FK_VehicleID=0,@zoneId=0,@WardId=0,@sDate=default,@eDate=default,@UserID=11401,@zoneName=default,@WardName=default
                DataSet dsGetVehicle = bAL.AssignVehicle(Pk_RequestId, vehicleid, accid);
                // Show success message
                string script = "alert('Assignment successful!');";
                ScriptManager.RegisterStartupScript(this, GetType(), "SuccessMessage", script, true);
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

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                clearallcontrols();
                //int i = (int)ViewState["SelectedDatarow"];
                
                Button btn = (Button)sender;
                GridViewRow row = (GridViewRow)btn.NamingContainer;
                int rowIndex = row.RowIndex;

                ViewState["SelectedDatarow"] = rowIndex;
                DataRow d1 = ((DataTable)ViewState["Data"]).Rows[rowIndex];
                ViewState["pk_Id"] = d1["pk_blockId"];

                BALCTPT bAL = new BALCTPT();
                DatewiseWeightReport mAP = new DatewiseWeightReport();
                //=====ZONE=====//
                //"begin tran t
                //exec proc_SweeperRouteCoverageReportNew @mode = 11,@vehicleId = 0,@AccId = 11401,@ZoneId = 0,@WardId = 0,@startdate = default,@enddate = default,@stime = default,@etime = default,@RptName = default,@Report = default,@Zone = default,@Ward = default,@WorkingType = default,@RouteId = 0,@AdminID = 0,@RoleID = 0
                //rollback tran t"
                //==sp ref==//
                DataSet ds = bAL.deletedata(d1["pk_blockid"]);
                BindGrid(null);

                string script = "alert('Delete successful!');";
                ScriptManager.RegisterStartupScript(this, GetType(), "SuccessMessage", script, true);
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

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            try
            {
                clearallcontrols();
                //int i = (int)ViewState["SelectedDatarow"];
                btSubmitt.Text = "Update";

                Button btn = (Button)sender;
                GridViewRow row = (GridViewRow)btn.NamingContainer;
                int rowIndex = row.RowIndex;

                ViewState["SelectedDatarow"] = rowIndex;
                DataRow d1 = ((DataTable)ViewState["Data"]).Rows[rowIndex];
                ViewState["pk_Id"] = d1["pk_blockId"];

                BALCTPT bAL = new BALCTPT();
                DatewiseWeightReport mAP = new DatewiseWeightReport();
                //=====ZONE=====//
                //"begin tran t
                //exec proc_SweeperRouteCoverageReportNew @mode = 11,@vehicleId = 0,@AccId = 11401,@ZoneId = 0,@WardId = 0,@startdate = default,@enddate = default,@stime = default,@etime = default,@RptName = default,@Report = default,@Zone = default,@Ward = default,@WorkingType = default,@RouteId = 0,@AdminID = 0,@RoleID = 0
                //rollback tran t"
                //==sp ref==//
                DataSet ds = bAL.GetEditData(d1["pk_blockid"]);
                DataRow d = null;
                adhocTable.DataSource = null;
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        d = ds.Tables[0].Rows[0];
                    }
                }

                ddlZone.SelectedValue = d["fk_zoneid"].ToString();
                ddlZone_SelectedIndexChanged(null,null);
                ddlWard.SelectedValue = d["fk_wardid"].ToString();
                ddlWard_SelectedIndexChanged(null, null);
                ddlKothi.SelectedValue = d["fk_kothiid"].ToString();
                ddlCTPTType.SelectedValue = d["type"].ToString();
                txboxCTPTName.Text = d["blockname"].ToString();
                txtlongitude.Text = d["longitude"].ToString();
                txtLattitude.Text = d["Latitude"].ToString();
                txtAddress.Text = d["address"].ToString();

                ListItem selectedItem = ddlMukadam.Items.FindByText(d["Mokadam"].ToString());
                if (selectedItem != null)
                {
                    selectedItem.Selected = true;
                }
                ListItem selectedItem1 = ddlDSI.Items.FindByText(d["dsi"].ToString());
                if (selectedItem1 != null)
                {
                    selectedItem1.Selected = true;
                }

                ListItem selectedItem2 = ddlSI.Items.FindByText(d["si"].ToString());
                if (selectedItem2 != null)
                {
                    selectedItem2.Selected = true;
                }

                //ddlMukadam.SelectedValue = d["Mokadam"].ToString();


                //ddlDSI.SelectedValue = d["dsi"].ToString();
                //ddlSI.SelectedValue = d["si"].ToString();
                txtNos.Text = d["NoOfSeats"].ToString();

                              

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

        protected void btncancel_Click(object sender, EventArgs e)

        {
            clearallcontrols();
            BindGrid(null);
        }
    }
}