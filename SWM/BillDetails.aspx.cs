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
    public partial class BillDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDDL();
                BindGrid();
            }

        }

        protected void btnSerch_Click(object sender, EventArgs e)
        {
            BindGrid();
        }
        void BindDDL()
        {
            try
            {
                BALContrator bAL = new BALContrator();
                DataSet ds = bAL.GetBillDetails(3, 0);

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
                DataSet ds1 = bAL.GetBillDetails(1,Convert.ToInt32(ddlContractName.SelectedItem.Value));

                if (ds1.Tables.Count > 0)
                {
                    DataRow allOption = ds1.Tables[0].NewRow();
                    allOption["pk_BillInfoId"] = 0;
                    allOption["ContractName"] = "Select All";
                    ds1.Tables[0].Rows.InsertAt(allOption, 0);
                    if (ds1.Tables[0].Rows.Count > 0)
                    {
                        ddlContractWiseBill.DataSource = ds1.Tables[0];
                        ddlContractWiseBill.DataTextField = "ContractName"; // Field to display as option text
                        ddlContractWiseBill.DataValueField = "pk_BillInfoId"; // Field to use as option value 
                        ddlContractWiseBill.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "BillDetails.cs >> Method BindGrid()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
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
                DataSet ds = bAL.GetBillDetails(2, Convert.ToInt32(ddlContractName.SelectedItem.Value));

                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        //Set the dropdown list's data source and bind the data
                        grdData.DataSource = ds.Tables[0];
                        grdData.DataBind();
                    }
                   else
                    {
                        grdData.DataSource = null;
                        grdData.DataBind();
                    }
                    
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "BillDetails.cs >> Method BindGrid()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
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