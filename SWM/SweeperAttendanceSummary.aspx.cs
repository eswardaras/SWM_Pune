using iTextSharp.text;
using iTextSharp.text.pdf;
using OfficeOpenXml;
using SWM.BAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SWM
{
    public partial class SweeperAttendanceSummary : System.Web.UI.Page
    {

        DateTime firstDayOfMonth, lastDayOfMonth;
        string todayFormatted = DateTime.Now.ToString("yyyy-MM-dd");
        string firstDayOfMonth1, lastDayOfMonth1;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PopulateYearDropdown();
                BindLoad();
                DateAssign();
            }
        }



        void DateAssign()
        {
            DateTime today = DateTime.Today;
            DateTime firstDayOfMonth = Convert.ToDateTime((ddlYear.SelectedItem.Text + "-" + ddlMonth.SelectedValue + "-" + 1));
            ViewState["firstDayOfMonth"] = firstDayOfMonth.ToString("yyyy-MM-dd");

            DateTime lastday = DateTime.Today;
            DateTime lastDayOfMonth = Convert.ToDateTime(ddlYear.SelectedItem.Text + "-" + ddlMonth.SelectedValue + "-" + DateTime.DaysInMonth(Convert.ToInt32(ddlYear.SelectedItem.Text), Convert.ToInt32(ddlMonth.SelectedValue)));// new DateTime(lastday.Year, lastday.Month, DateTime.DaysInMonth(lastday.Year, lastday.Month));
            ViewState["lastDayOfMonth"] = lastDayOfMonth.ToString("yyyy-MM-dd");

            //lastDayOfMonth1 = ddlYear.SelectedItem.Text + "-" + ddlMonth.SelectedValue + "-" + DateTime.DaysInMonth(Convert.ToInt32(ddlYear.SelectedItem.Text), Convert.ToInt32(ddlMonth.SelectedValue));
        }

        void BindLoad()
        {
            //exec proc_SweepersAttendance @accid=11401,@mode=1,@zoneid=0,@wardid=0,@gisTypeId=0,@kothiid=0,@startdate='2023-08-01 00:00:00',@endDate='2023-08-31 00:00:00',@Month=N'August',@vehicleId=0
            BindDDLZone();
            //exec proc_SweepersAttendance @accid = 11401,@mode = 2,@zoneid = 0,@wardid = 0,@gisTypeId = 78,@kothiid = 0,@startdate = '2023-08-03 05:00:01',@endDate = '2023-08-03 14:00:01',@Month = default,@vehicleId = 0
            BindDDLWard();
            //exec proc_SweepersAttendance @accid = 11401,@mode = 3,@zoneid = 0,@wardid = 0,@gisTypeId = 78,@kothiid = 0,@startdate = '2023-08-03 05:00:01',@endDate = '2023-08-03 14:00:01',@Month = default,@vehicleId = 0
            BindDDLKothi();
            //exec proc_SweepersAttendance @accid = 11401,@mode = 12,@zoneid = 0,@wardid = 0,@gisTypeId = 78,@kothiid = 0,@startdate = '2023-08-03 05:00:01',@endDate = '2023-08-03 14:00:01',@Month = default,@vehicleId = 0
            BindDDLSweeper();
        }
        void BindDDLZone()
        {
            try
            {
                BalFeederSummaryReport bAL = new BalFeederSummaryReport();

                //==sp ref==//
                //exec proc_SweepersAttendance 
                //exec proc_SweepersAttendance @accid=11401,@mode=1,@zoneid=0,@wardid=0,@gisTypeId=0,@kothiid=0,@startdate='2023-08-01 00:00:00',@endDate='2023-08-31 00:00:00',@Month=N'August',@vehicleId=0
                //==sp ref==//
                DataSet ds = bAL.GetSweepersAttendance(Convert.ToInt32(Session["FK_Id"]), 1, 0, 0, 0, 0, Convert.ToString(DateTime.Now.ToString("yyyy-MM-dd")), Convert.ToString(DateTime.Now.ToString("yyyy-MM-dd")), ddlMonth.SelectedItem.Text, 0, Convert.ToString(0));

                //DataSet ds = bAL.GetZone(11, 0, 11401);
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
                Logfile.TraceService("LogData", "SweeperAttendance.cs >> Method SweeperAttendance_BindDDLZone()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }
        void BindDDLWard()
        {
            try
            {
                BalFeederSummaryReport bAL = new BalFeederSummaryReport();
                //==sp ref==//
                //exec proc_SweepersAttendance 
                //@accid = 11401,@mode = 2,@zoneid = 0,@wardid = 0,@gisTypeId = 78,@kothiid = 0,@startdate = '2023-08-03 17:30:29.207',@endDate = '2023-08-03 17:30:29.207',@Month = default,@vehicleId = 0
                //==sp ref==//
                DataSet dsGetWard = bAL.GetSweepersAttendance(Convert.ToInt32(Session["FK_Id"]), 2, Convert.ToInt32(ddlZone.SelectedItem.Value), 0, 0, 0, Convert.ToString(DateTime.Now.ToString("yyyy-MM-dd")), Convert.ToString(DateTime.Now.ToString("yyyy-MM-dd")), ddlMonth.SelectedItem.Text, 0, Convert.ToString(0));

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
                Logfile.TraceService("LogData", "SweeperAttendance.cs >> Method SweeperAttendance_BindDDLWard()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }

        void BindDDLKothi()
        {
            try
            {
                BalFeederSummaryReport bAL = new BalFeederSummaryReport();
                //==sp ref==//
                //exec proc_SweepersAttendance 
                //@accid = 11401,@mode = 3,@zoneid = 0,@wardid = 0,@gisTypeId = 78,@kothiid = 0,@startdate = '2023-08-03 17:30:29.207',@endDate = '2023-08-03 17:30:29.207',@Month = default,@vehicleId = 0
                //==sp ref==//
                DataSet dsKothi = bAL.GetSweepersAttendance(Convert.ToInt32(Session["FK_Id"]), 3, Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value), 0, 0, Convert.ToString(DateTime.Now.ToString("yyyy-MM-dd")), Convert.ToString(DateTime.Now.ToString("yyyy-MM-dd")), ddlMonth.SelectedItem.Text, 0, Convert.ToString(0));

                if (dsKothi.Tables.Count > 0)
                {
                    DataRow allOption = dsKothi.Tables[0].NewRow();
                    allOption["pk_kothiid"] = 0;
                    allOption["KothiName"] = "Select All";
                    dsKothi.Tables[0].Rows.InsertAt(allOption, 0);
                    if (dsKothi.Tables[0].Rows.Count > 0)
                    {
                        // Set the dropdown list's data source and bind the data
                        ddlKothi.DataSource = dsKothi.Tables[0];
                        ddlKothi.DataTextField = "KothiName"; // Field to display as option text  	
                        ddlKothi.DataValueField = "pk_kothiid"; // Field to use as option value 
                        ddlKothi.DataBind();
                    }
                }

            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "SweeperAttendance.cs >> Method SweeperAttendance_BindDDLVehicle()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }
        void BindDDLSweeper()
        {
            try
            {
                BalFeederSummaryReport bAL = new BalFeederSummaryReport();
                //==sp ref==//
                //exec proc_SweepersAttendance 
                //@accid = 11401,@mode = 12,@zoneid = 0,@wardid = 0,@gisTypeId = 78,@kothiid = 0,@startdate = '2023-08-03 17:30:29.207',@endDate = '2023-08-03 17:30:29.207',@Month = default,@vehicleId = 0
                //==sp ref==//
                DataSet dsSweeper = bAL.GetSweepersAttendance(Convert.ToInt32(Session["FK_Id"]), 12, Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value), 0, Convert.ToInt32(ddlKothi.SelectedItem.Value), Convert.ToString(DateTime.Now.ToString("yyyy-MM-dd")), Convert.ToString(DateTime.Now.ToString("yyyy-MM-dd")), ddlMonth.SelectedItem.Text, 0, Convert.ToString(0));

                if (dsSweeper.Tables.Count > 0)
                {
                    DataRow allOption = dsSweeper.Tables[0].NewRow();
                    allOption["pk_vehicleid"] = 0;
                    allOption["Sweeper"] = "Select All";
                    dsSweeper.Tables[0].Rows.InsertAt(allOption, 0);
                    if (dsSweeper.Tables[0].Rows.Count > 0)
                    {
                        // Set the dropdown list's data source and bind the data
                        ddlSweeper.DataSource = dsSweeper.Tables[0];
                        ddlSweeper.DataTextField = "Sweeper"; // Field to display as option text  		
                        ddlSweeper.DataValueField = "pk_vehicleid"; // Field to use as option value 
                        ddlSweeper.DataBind();
                    }
                }

            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "SweeperAttendance.cs >> Method SweeperAttendance_BindDDLVehicle()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                Logfile.TraceService("LogData", "Message >> " + ex.Message);
                Logfile.TraceService("LogData", "Source >> " + ex.Source);
                Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
                Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
                Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
                Logfile.TraceService("LogData", ex.Message);
            }
        }

        protected void ddlMonth_SelectedIndexChanged(object sender, EventArgs e)
        {
            DateAssign();
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            GenerateExcel(grd_AttendanceSummary, "AttendanceSummaryReport_" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
        }

        protected void ImgPDF_Click(object sender, ImageClickEventArgs e)
        {
            GeneratePDF(grd_AttendanceSummary, "AttendanceSummaryReport_" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
        }
        protected void GenerateExcel(GridView gridView, string fileName)
        {
            ExcelPackage.LicenseContext = LicenseContext.NonCommercial; // Set the license context

            using (var package = new ExcelPackage())
            {
                var worksheet = package.Workbook.Worksheets.Add("Attendance Report");

                DataTable dt = new DataTable();
                // Populate dt with data from the GridView or your data source
                // For example: dt = GetDataFromGridView(gridView);
                dt = GetDataFromGridView(gridView);
                // Write DataTable content to Excel worksheet
                worksheet.Cells["A1"].LoadFromDataTable(dt, true);

                Response.Clear();
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AddHeader("content-disposition", "attachment;filename=" + fileName + ".xlsx");
                Response.BinaryWrite(package.GetAsByteArray());
                Response.End();
            }
        }
        protected DataTable GetDataFromGridView(GridView gridView)
        {
            DataTable dt = new DataTable();

            foreach (TableCell cell in gridView.HeaderRow.Cells)
            {
                dt.Columns.Add(cell.Text);
            }

            foreach (GridViewRow row in gridView.Rows)
            {
                DataRow dataRow = dt.NewRow();
                for (int i = 0; i < row.Cells.Count; i++)
                {
                    dataRow[i] = row.Cells[i].Text;
                }
                dt.Rows.Add(dataRow);
            }

            return dt;
        }

        protected void GeneratePDF(GridView gridView, string fileName)
        {
            Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 10f, 0f);
            PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
            pdfDoc.Open();

            // Add the logo to the header section
            string imagePath = Server.MapPath("~/Images/pmcsmart.png");
            iTextSharp.text.Image logo = iTextSharp.text.Image.GetInstance(imagePath);
            logo.Alignment = iTextSharp.text.Image.ALIGN_CENTER;
            pdfDoc.Add(logo);
            // Add any other content you want in the header section

            PdfPTable pdfTable = new PdfPTable(gridView.HeaderRow.Cells.Count);
            pdfTable.WidthPercentage = 100;

            // Add header cells to the PDF table
            foreach (TableCell headerCell in gridView.HeaderRow.Cells)
            {
                PdfPCell pdfCell = new PdfPCell(new Phrase(headerCell.Text));
                pdfTable.AddCell(pdfCell);
            }

            // Add data cells to the PDF table
            foreach (GridViewRow gridViewRow in gridView.Rows)
            {
                foreach (TableCell tableCell in gridViewRow.Cells)
                {
                    PdfPCell pdfCell = new PdfPCell(new Phrase(tableCell.Text));
                    pdfTable.AddCell(pdfCell);
                }
            }

            pdfDoc.Add(pdfTable);
            pdfDoc.Close();

            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=" + fileName + ".pdf");
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Write(pdfDoc);
            Response.End();
        }

        protected void ddlZone_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindDDLWard();
        }

        protected void ddlWard_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindDDLKothi();
        }

        protected void ddlKothi_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindDDLSweeper();
        }

        protected void PopulateYearDropdown()
        {
            ddlYear.Items.Clear();

            int currentYear = DateTime.Now.Year;

            ddlYear.Items.Add(new System.Web.UI.WebControls.ListItem((currentYear - 1).ToString()));
            ddlYear.Items.Add(new System.Web.UI.WebControls.ListItem(currentYear.ToString(), "1"));

            ddlYear.SelectedIndex = 1;
        }

     
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindGrid();
            tableWrapper.Visible = true;
        }
        void BindGrid()
        {
            try
            {
                BalFeederSummaryReport bAL = new BalFeederSummaryReport();
                FeederSummaryReport mAP = new FeederSummaryReport();
                //==sp ref==//
                //"begin tran t
                //exec proc_SweepersAttendance @accid = 11401,@mode = 15,@zoneid = 0,@wardid = 0,@gisTypeId = 78,@kothiid = 0,@startdate = '2023-08-03 05:00:01',@endDate = '2023-08-03 14:00:01',@Month = default,@vehicleId = 0
                //rollback tran t"
                //==sp ref==//
                DataSet ds = bAL.GetSweepersAttendance(Convert.ToInt32(Session["FK_Id"]), 15, Convert.ToInt32(ddlZone.SelectedItem.Value), Convert.ToInt32(ddlWard.SelectedItem.Value),0, Convert.ToInt32(ddlKothi.SelectedItem.Value), ViewState["firstDayOfMonth"].ToString(), ViewState["lastDayOfMonth"].ToString(), ddlMonth.SelectedItem.Text, Convert.ToInt32(ddlSweeper.SelectedItem.Value), ddlEmpType.SelectedItem.Value);

                if (ds.Tables.Count > 0)
                {
                    hheader.Visible = true;
                    lblFromDate.Text = ViewState["firstDayOfMonth"].ToString();
                    lblEndDate.Text = ViewState["lastDayOfMonth"].ToString();

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        divExport.Visible = true;
                       // grd_AttendanceSummary.AllowPaging = true;
                        grd_AttendanceSummary.DataSource = ds.Tables[0];
                        grd_AttendanceSummary.DataBind();
                        //if (ds.Tables[1].Rows.Count > 0)
                        //{
                        //    lblTotal.Text = "Total :- " + ds.Tables[1].Rows[0]["Total"].ToString();
                        //    lblAbsent.Text = "Absent :- " + ds.Tables[1].Rows[0]["Present"].ToString();
                        //    lblPresent.Text = "Present :- " + ds.Tables[1].Rows[0]["Absent"].ToString();
                        //}
                    }
                    else
                    {
                        //divExport.Visible = false;
                        grd_AttendanceSummary.DataSource = null;
                        grd_AttendanceSummary.DataBind();
                        //Response.Write("No data found!!");
                    }

                }
            }
            catch (Exception ex)
            {
                Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
                Logfile.TraceService("LogData", "SweeperAttendance.cs >> Method SweeperAttendance_BindGrid()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
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