using Newtonsoft.Json;
using SWM.BAL;
using SWM.MODEL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SWM
{
    public partial class registernewdevice : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            Binddropdown();
        }

        private void Binddropdown()
        {
            try
            {
                BALOperation bAL = new BALOperation();
                DataSet ds = bAL.GetDropdown(1);
                if (ds.Tables.Count > 0)
                {
                    // Add the "Select All" option to the DataTable
                    //DataRow allOption = ds.Tables[0].NewRow();
                    //allOption["PK_Accid"] = 0;
                    //allOption["name"] = "Select All";
                    //ds.Tables[0].Rows.InsertAt(allOption, 0);

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        // Set the dropdown list's data source and bind the data
                        ddlAccountId.DataSource = ds.Tables[0];
                        ddlAccountId.DataTextField = "name"; // Field to display as option text
                        ddlAccountId.DataValueField = "PK_Accid"; // Field to use as option value
                        ddlAccountId.DataBind();
                    }
                }

                ds = bAL.GetDropdown(10);
                if (ds.Tables.Count > 0)
                {
                    // Add the "Select All" option to the DataTable
                    //DataRow allOption = ds.Tables[0].NewRow();
                    //allOption["PK_Accid"] = 0;
                    //allOption["name"] = "Select All";
                    //ds.Tables[0].Rows.InsertAt(allOption, 0);
                    
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        // Set the dropdown list's data source and bind the data
                        ddlVehicletype.DataSource = ds.Tables[0];
                        ddlVehicletype.DataTextField = "VTypeName"; // Field to display as option text
                        ddlVehicletype.DataValueField = "PK_VTypeId"; // Field to use as option value
                        ddlVehicletype.DataBind();
                    }
                }

                ds = bAL.GetDropdown(2);
                if (ds.Tables.Count > 0)
                {
                    // Add the "Select All" option to the DataTable
                    //DataRow allOption = ds.Tables[0].NewRow();
                    //allOption["PK_Accid"] = 0;
                    //allOption["name"] = "Select All";
                    //ds.Tables[0].Rows.InsertAt(allOption, 0);

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        // Set the dropdown list's data source and bind the data
                        ddlcompany.DataSource = ds.Tables[0];
                        ddlcompany.DataTextField = "DeviceCompName"; // Field to display as option text
                        ddlcompany.DataValueField = "PK_DeviceCompId"; // Field to use as option value
                        ddlcompany.DataBind();
                    }
                }

                ds = bAL.GetDropdown(12);
                if (ds.Tables.Count > 0)
                {

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        // Set the dropdown list's data source and bind the data
                        dllvendor.DataSource = ds.Tables[0];
                        dllvendor.DataTextField = "EmpName"; // Field to display as option text
                        dllvendor.DataValueField = "Pk_EmpId"; // Field to use as option value
                        dllvendor.DataBind();
                    }
                }

				ds = bAL.GetDropdown(13);
				if (ds.Tables.Count > 0)
				{

					if (ds.Tables[0].Rows.Count > 0)
					{
						// Set the dropdown list's data source and bind the data
						ddlWorkerType.DataSource = ds.Tables[0];
						ddlWorkerType.DataTextField = "Workname"; // Field to display as option text
						ddlWorkerType.DataValueField = "pkWorkId"; // Field to use as option value
						ddlWorkerType.DataBind();
					}
				}

				ds = bAL.GetDropdown(14);
				if (ds.Tables.Count > 0)
				{

					if (ds.Tables[0].Rows.Count > 0)
					{
						// Set the dropdown list's data source and bind the data
						ddlEmployeeType.DataSource = ds.Tables[0];
						ddlEmployeeType.DataTextField = "EmpTypeName"; // Field to display as option text
						ddlEmployeeType.DataValueField = "EmpTypeId"; // Field to use as option value
						ddlEmployeeType.DataBind();
					}
				}

				ds = bAL.GetDropdown(3);
                if (ds.Tables.Count > 0)
                {
                    // Add the "Select All" option to the DataTable
                    //DataRow allOption = ds.Tables[0].NewRow();
                    //allOption["PK_Accid"] = 0;
                    //allOption["name"] = "Select All";
                    //ds.Tables[0].Rows.InsertAt(allOption, 0);

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        // Set the dropdown list's data source and bind the data
                        ddlDevicetype.DataSource = ds.Tables[0];
                        ddlDevicetype.DataTextField = "DeviceModel"; // Field to display as option text
                        ddlDevicetype.DataValueField = "PK_DeviceModelId"; // Field to use as option value
                        ddlDevicetype.DataBind();
                    }
                }

                ds = bAL.GetDropdown(3);
                if (ds.Tables.Count > 0)
                {
                    // Add the "Select All" option to the DataTable
                    //DataRow allOption = ds.Tables[0].NewRow();
                    //allOption["PK_Accid"] = 0;
                    //allOption["name"] = "Select All";
                    //ds.Tables[0].Rows.InsertAt(allOption, 0);

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        // Set the dropdown list's data source and bind the data
                        ddlDevicetype.DataSource = ds.Tables[0];
                        ddlDevicetype.DataTextField = "DeviceModel"; // Field to display as option text
                        ddlDevicetype.DataValueField = "PK_DeviceModelId"; // Field to use as option value
                        ddlDevicetype.DataBind();
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

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack) return;

                BALOperation bAL = new BALOperation();
                //=====ZONE=====//
                //"begin tran t
                //exec proc_SweeperRouteCoverageReportNew @mode = 11,@vehicleId = 0,@AccId = 11401,@ZoneId = 0,@WardId = 0,@startdate = default,@enddate = default,@stime = default,@etime = default,@RptName = default,@Report = default,@Zone = default,@Ward = default,@WorkingType = default,@RouteId = 0,@AdminID = 0,@RoleID = 0
                //rollback tran t"
                //==sp ref==//
                //txtFromDate.Text = DateTime.Now.Date.ToString();
                //txtToDate.Text = DateTime.Now.Date.ToString();
                DataSet ds = bAL.GetUnassignedDevice(2,Convert.ToDateTime(txtFromDate.Text), Convert.ToDateTime(txtToDate.Text).AddHours(23.88), string.IsNullOrEmpty(txtimei.Text) ? "0" : txtimei.Text.ToString());
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        gvDevices.DataSource = ds.Tables[0];
                        gvDevices.DataBind();
                    }
                }
                ViewState["Data"] = ds;
            }
            catch (Exception)
            {


            }
            tableWrapper.Visible = true;
            formPanel.Visible = false;
        }
        protected void addDevice_Click(object sender, EventArgs e)
        {
            formPanel.Visible = true;
            tableWrapper.Visible = false;
            formPanel_main.Visible = false;
        }
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ClearAllcontrol();
            formPanel_main.Visible = true;
            formPanel.Visible = false;
            tableWrapper.Visible = false;
        }

        private void ClearAllcontrol()
        {
            txtSimPhone.Text = null;
            txtVehicleName.Text = null;
            // Set other controls to their default values as needed
            // For example:
            txexpirydate.Text = null;
            txtCurrentOdo.Text = null;
      
            txtFuelFactor.Text = null;
        
            txtFuelTank.Text = null;
            txtInputImei.Text = null;
            txInstallationdate.Text = null;
            txtVehicleothername.Text = null;
        }

        protected void BtnSaveDevice_Click(object sender, EventArgs e)
        {
            // @simno = N'7788996665',@vehiclname = N'10008000',@versionname = N'W_APIs',@servpro = N'AIRTEL',@expirydate = N'2024-07-31',@fk_modelId = 1,@cuodo = N'88554477',@vehiType = N'CAR',
            //@fulfact = N'1',@fulsub = N'No',@fulTank = N'',@voltageType = 0,@InstlDate = N'2023-07-31',@vehicleOtherName = N'',
            //= 11401,@pcbtype = N'5.4',@Mileage = N'',@HrMileage = N'',@FuelVoltage = 5,@imei = N'867994060570823'
            string @simno = txtSimPhone.Text;
            string @vehiclname = txtVehicleName.Text.ToString();
            string @versionname = "W_APIs";
            string @servpro = ddlOperator.SelectedValue.ToString();
            string @expirydate = txexpirydate.Text.ToString();
            string @cuodo = txtCurrentOdo.Text == string.Empty ? null: txtCurrentOdo.Text.ToString();
            string @vehiType = ddlVehicletype.SelectedItem.Text;
			      string @fulfact = txtFuelFactor.Text.ToString();
            string @fulsub = ddlYesNo.SelectedValue.ToString();
            string @fulTank = txtFuelTank.Text.ToString() == string.Empty? null: txtFuelTank.Text.ToString();
            string @voltageType = rbNormalRadioButton.Checked ? "0" : "1";
            string @InstlDate = txInstallationdate.Text.ToString();
            string @vehicleOtherName = txtVehicleothername.Text.ToString();
            string @pcbtype = ddlpcbtype.SelectedValue.ToString();
            string @Mileage = txtvehiclMileage.Text.ToString() == string.Empty ? "0" : txtvehiclMileage.Text.ToString();
            string @fk_AccId = "11401";
            string @HrMileage = txtvehiclMileage.Text.ToString() == string.Empty ? "0" : txtvehiclMileage.Text.ToString();
            string @FuelVoltage = rb5Volts.Checked ?"5":"9";
            string @imei = txtInputImei.Text;
            string @devicecompid = ddlcompany.SelectedValue.ToString();
            string @vendor = dllvendor.SelectedItem.Text;
			      string @EmploymentType = ddlEmployeeType.SelectedValue.ToString(); ;
			      string @fkWorkId = ddlWorkerType.SelectedValue.ToString();
			

	
		
			try
            {
                BALOperation bAL = new BALOperation();

                DataSet ds = bAL.InsertNewDevice(@vendor, @fkWorkId, @EmploymentType, @simno, @vehiclname, @devicecompid, @versionname, @servpro, @expirydate, @cuodo, @vehiType, @fulfact, @fulsub, @fulTank, @voltageType, @InstlDate, @vehicleOtherName, @pcbtype, @Mileage, @fk_AccId, @HrMileage, @FuelVoltage, @imei);
                if (ds.Tables.Count > 0)
            {
                // Add the "Select All" option to the DataTable
                //DataRow allOption = ds.Tables[0].NewRow();
                //allOption["PK_Accid"] = 0;
                //allOption["name"] = "Select All";
                //ds.Tables[0].Rows.InsertAt(allOption, 0);

                //if (ds.Tables[0].Rows.Count > 0)
                //{
                //    // Set the dropdown list's data source and bind the data
                //    ddlDevicetype.DataSource = ds.Tables[0];
                //    ddlDevicetype.DataTextField = "DeviceModel"; // Field to display as option text
                //    ddlDevicetype.DataValueField = "PK_DeviceModelId"; // Field to use as option value
                //    ddlDevicetype.DataBind();
                //}
            }

                string script = "alert('New Entry Created successful!');";
                ScriptManager.RegisterStartupScript(this, GetType(), "SuccessMessage", script, true);

                mainForm.Visible = true;
                formPanel.Visible = false;
                formPanel_main.Visible = true;
            }
            catch (Exception ex)
            {
                string script = "alert('Device with this IMEI/Sim/Vehicle Name already exists');";
                ScriptManager.RegisterStartupScript(this, GetType(), "ErrorMessage", script, true);
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

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            try
            {

            
            mainForm.Visible = false;
            newDeviceForm.Visible = true;

            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            int rowIndex = row.RowIndex;
            DataRow d = ((DataSet)ViewState["Data"]).Tables[0].Rows[rowIndex];


                txtInputImei.Text = d["imei"].ToString();
            }
            catch (Exception)
            {

               
            }
            tableWrapper.Visible = false;
            formPanel_main.Visible = false;
            formPanel.Visible = true;
        }

        protected void ddlMonth_SelectedIndexChanged(object sender, EventArgs e)
        {
            DateAssign();
        }

        void DateAssign()
        {
            if (Convert.ToInt32(ddlMonth.SelectedItem.Value) != 0)
            {
                DateTime today = DateTime.Today;
                DateTime firstDayOfMonth = Convert.ToDateTime((DateTime.Today.ToString("yyyy") + "-" + ddlMonth.SelectedValue + "-" + 1));
                ViewState["firstDayOfMonth"] = firstDayOfMonth.ToString("yyyy-MM-dd");
                txtFromDate.Text = firstDayOfMonth.ToString("yyyy-MM-dd");
                DateTime lastday = DateTime.Today;
                DateTime lastDayOfMonth = Convert.ToDateTime((DateTime.Today.ToString("yyyy") + "-" + ddlMonth.SelectedValue + "-" + DateTime.DaysInMonth(Convert.ToInt32(DateTime.Today.ToString("yyyy")), Convert.ToInt32(ddlMonth.SelectedValue))));// new DateTime(lastday.Year, lastday.Month, DateTime.DaysInMonth(lastday.Year, lastday.Month));
                ViewState["lastDayOfMonth"] = lastDayOfMonth.ToString("yyyy-MM-dd");
                txtToDate.Text = lastDayOfMonth.ToString("yyyy-MM-dd");
            }
            else
            {
                DateTime today = DateTime.Today;

                ViewState["firstDayOfMonth"] = DateTime.Today.ToString("yyyy-MM-dd");
                txtFromDate.Text = DateTime.Today.ToString("yyyy-MM-dd");

                ViewState["lastDayOfMonth"] = DateTime.Today.ToString("yyyy-MM-dd");
                txtToDate.Text = DateTime.Today.ToString("yyyy-MM-dd");
            }
            //lastDayOfMonth1 = ddlYear.SelectedItem.Text + "-" + ddlMonth.SelectedValue + "-" + DateTime.DaysInMonth(Convert.ToInt32(ddlYear.SelectedItem.Text), Convert.ToInt32(ddlMonth.SelectedValue));
        }
    }
}