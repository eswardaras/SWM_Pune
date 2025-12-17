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
    public partial class RampDataEntry : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            BindRamp();
        }
        private void BindRamp()
        {
            try
            {
                RampBAL bAL = new RampBAL();
                DatewiseWeightReport mAP = new DatewiseWeightReport();

                DataSet ds = bAL.GetRampLastDataEntry();
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        grdData.DataSource = ds.Tables[0];
                        grdData.DataBind();
                    }
                }
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[1].Rows.Count > 0)
                    {
                        grd_PlantData.DataSource = ds.Tables[1];
                        grd_PlantData.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "RampDataEntry.cs >> Method BindRamp()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
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
                // Assuming the date is in the second column of the GridView.
                // You might need to adjust the column index as per your actual data.
                DateTime dateValue;
                if (DateTime.TryParse(e.Row.Cells[2].Text, out dateValue))
                {
                    if (dateValue < DateTime.Today)
                    {
                        e.Row.BackColor = System.Drawing.Color.Red;
                        e.Row.ForeColor = System.Drawing.Color.White;
                    }
                }
            }
        }

        protected void grd_PlantData_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Assuming the date is in the second column of the GridView.
                // You might need to adjust the column index as per your actual data.
                DateTime dateValue;
                if (DateTime.TryParse(e.Row.Cells[2].Text, out dateValue))
                {
                    if (dateValue < DateTime.Today)
                    {
                        e.Row.BackColor = System.Drawing.Color.Red;
                        e.Row.ForeColor = System.Drawing.Color.White;
                    }
                }
            }
        }
    }
}