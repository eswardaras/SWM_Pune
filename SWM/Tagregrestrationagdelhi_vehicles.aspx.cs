using iTextSharp.text;
using iTextSharp.text.pdf;
using OfficeOpenXml;
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
	public partial class Tagregrestrationagdelhi_vehicles : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
				BindLoad();
				//DateAssign();
			}
		}
		//void DateAssign()
		//{
		//    DateTime today = DateTime.Today;
		//    DateTime firstDayOfMonth = Convert.ToDateTime((ddlYear.SelectedItem.Text + "-" + ddlMonth.SelectedValue + "-" + 1));
		//    ViewState["firstDayOfMonth"] = firstDayOfMonth.ToString("yyyy-MM-dd");

		//    DateTime lastday = DateTime.Today;
		//    DateTime lastDayOfMonth = Convert.ToDateTime(ddlYear.SelectedItem.Text + "-" + ddlMonth.SelectedValue + "-" + DateTime.DaysInMonth(Convert.ToInt32(ddlYear.SelectedItem.Text), Convert.ToInt32(ddlMonth.SelectedValue)));// new DateTime(lastday.Year, lastday.Month, DateTime.DaysInMonth(lastday.Year, lastday.Month));
		//    ViewState["lastDayOfMonth"] = lastDayOfMonth.ToString("yyyy-MM-dd");

		//    //lastDayOfMonth1 = ddlYear.SelectedItem.Text + "-" + ddlMonth.SelectedValue + "-" + DateTime.DaysInMonth(Convert.ToInt32(ddlYear.SelectedItem.Text), Convert.ToInt32(ddlMonth.SelectedValue));
		//}
		//protected void ddlMonth_SelectedIndexChanged(object sender, EventArgs e)
		//{
		//    DateAssign();
		//}
		void BindLoad()
		{
			//exec proc_Tagregrestrationagdelhi_vehicles @mode = 4,@accid = 11401,@startdate = N'2023-09-08',@enddate = N'2023-09-28',@pk_vehicleid = 0,@wardId = 0,@zoneId = 0        //
			BindDDLZone();
			BindDDLWard(4, 11401, txtSdate.Text, txtEdate.Text, 0, 0, 0);
			BindDDLVehicle(6, 11401, txtSdate.Text, txtEdate.Text, 0, 0, 0);

			//BindGrid();
		}
		void BindDDLZone()
		{
			try
			{
				BalFeederSummaryReport bAL = new BalFeederSummaryReport();

				//==sp ref==//
				////exec proc_Tagregrestrationagdelhi_vehicles @mode=3,@accid=11401,@startdate=N'2023-09-08',@enddate=N'2023-09-28',@pk_vehicleid=0,@wardId=0,@zoneId=0        //
				//==sp ref==//
				DataSet ds = bAL.GetRFIDTagReadReport(3, 11401, txtSdate.Text, txtEdate.Text, 0, 0, 0);

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
				Logfile.TraceService("LogData", "Tagregrestrationagdelhi_vehicles.cs >> Method BindDDLZone()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
				Logfile.TraceService("LogData", "Message >> " + ex.Message);
				Logfile.TraceService("LogData", "Source >> " + ex.Source);
				Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
				Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
				Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
				Logfile.TraceService("LogData", ex.Message);
			}
		}
		void BindDDLWard(int @mode, int @accid, string @startdate, string @enddate, int @pk_vehicleid, int @wardId, int @zoneId)
		{
			try
			{
				BalFeederSummaryReport bAL = new BalFeederSummaryReport();
				//==sp ref==//
				//==sp ref==//
				////exec proc_Tagregrestrationagdelhi_vehicles @mode=4,@accid=11401,@startdate=N'2023-09-08',@enddate=N'2023-09-28',@pk_vehicleid=0,@wardId=0,@zoneId=0        //
				//==sp ref==//
				DataSet dsGetWard = bAL.GetRFIDTagReadReport(mode, accid, startdate, enddate, pk_vehicleid, wardId, zoneId);

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
				Logfile.TraceService("LogData", "Tagregrestrationagdelhi_vehicles.cs >> Method BindDDLWard()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
				Logfile.TraceService("LogData", "Message >> " + ex.Message);
				Logfile.TraceService("LogData", "Source >> " + ex.Source);
				Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
				Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
				Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
				Logfile.TraceService("LogData", ex.Message);
			}
		}

		void BindDDLVehicle(int @mode, int @accid, string @startdate, string @enddate, int @pk_vehicleid, int @wardId, int @zoneId)
		{
			try
			{
				BalFeederSummaryReport bAL = new BalFeederSummaryReport();

				//==sp ref==//
				////exec proc_Tagregrestrationagdelhi_vehicles @mode=6,@accid=11401,@startdate=N'2023-09-08',@enddate=N'2023-09-28',@pk_vehicleid=0,@wardId=0,@zoneId=0        //
				//==sp ref==//
				DataSet dsGetVehicle = bAL.GetRFIDTagReadReport(mode, accid, startdate, enddate, pk_vehicleid, wardId, zoneId);

				if (dsGetVehicle.Tables.Count > 0)
				{
					DataRow allOption = dsGetVehicle.Tables[0].NewRow();
					allOption["pk_vehicleid"] = 0;
					allOption["vehiclename"] = "Select All";
					dsGetVehicle.Tables[0].Rows.InsertAt(allOption, 0);
					if (dsGetVehicle.Tables[0].Rows.Count > 0)
					{
						// Set the dropdown list's data source and bind the data
						ddlVehicle.DataSource = dsGetVehicle.Tables[0];
						ddlVehicle.DataTextField = "vehiclename"; // Field to display as option text  	
						ddlVehicle.DataValueField = "pk_vehicleid"; // Field to use as option value 
						ddlVehicle.DataBind();
					}
				}

			}
			catch (Exception ex)
			{
				Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
				Logfile.TraceService("LogData", "Tagregrestrationagdelhi_vehicles.cs >> Method BindDDLVehicle()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
				Logfile.TraceService("LogData", "Message >> " + ex.Message);
				Logfile.TraceService("LogData", "Source >> " + ex.Source);
				Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
				Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
				Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
				Logfile.TraceService("LogData", ex.Message);
			}
		}
		protected void ddlZone_SelectedIndexChanged(object sender, EventArgs e)
		{
			BindDDLWard(4, 11401, txtSdate.Text, txtEdate.Text, 0, 0, Convert.ToInt32(ddlZone.SelectedValue));
		}

		protected void ddlWard_SelectedIndexChanged(object sender, EventArgs e)
		{
			BindDDLVehicle(6, 11401, txtSdate.Text, txtEdate.Text, 0, Convert.ToInt32(ddlWard.SelectedValue), Convert.ToInt32(ddlZone.SelectedValue));
		}

		protected void btnSearch_Click(object sender, EventArgs e)
		{
			BindGrid();
			tableWrapper1.Visible = true;
			tableWrapper2.Visible = true;
			tableWrapper3.Visible = true;
			tableWrapper4.Visible = true;
		}
		void BindGrid()

		{
			try
			{
				// Example dates (replace these with your actual dates)
				DateTime fromdate = DateTime.Parse(txtSdate.Text);
				DateTime todate = DateTime.Parse(txtEdate.Text);

				// Calculate the difference between the two dates
				TimeSpan difference = todate - fromdate;

				BalFeederSummaryReport bAL = new BalFeederSummaryReport();
				FeederSummaryReport mAP = new FeederSummaryReport();
				//==sp ref==//
				////exec proc_Tagregrestrationagdelhi_vehicles @mode=7,@accid=11401,@startdate=N'2023-09-08',@enddate=N'2023-09-28',@pk_vehicleid=0,@wardId=0,@zoneId=0        //
				//==sp ref==//

				DataSet ds = bAL.GetRFIDTagReadReport(7, 11401, txtSdate.Text, txtEdate.Text, Convert.ToInt32(ddlVehicle.SelectedValue), Convert.ToInt32(ddlWard.SelectedValue), Convert.ToInt32(ddlZone.SelectedValue));
				if (ds.Tables.Count > 0)
				{
					if (difference.TotalDays > 31)
					{
						string script = "alert('New Request Created successful!');";
						ScriptManager.RegisterStartupScript(this, GetType(), "SuccessMessage", script, true);
						GenerateExcelDirectly(ds.Tables[0], "RFIDTagReaderReport" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
					}
					else
					{
						hheader.Visible = true;
						lblFromDate.Text = txtSdate.Text;
						lblEndDate.Text = txtEdate.Text;

						if (ds.Tables[1].Rows.Count > 0)
						{
							divExport.Visible = true;
							grd_Tripcount.DataSource = ds.Tables[1];
							grd_Tripcount.DataBind();
						}
						else
						{
							//divExport.Visible = false;
							grd_Tripcount.DataSource = null;
							grd_Tripcount.DataBind();

							//Response.Write("No data found!!");
						}
						if (ds.Tables[2].Rows.Count > 0)
						{
							divExport.Visible = true;
							grd_TripcountVehicle.DataSource = ds.Tables[2];
							grd_TripcountVehicle.DataBind();
						}
						else
						{
							//divExport.Visible = false;
							grd_TripcountVehicle.DataSource = null;
							grd_TripcountVehicle.DataBind();

							//Response.Write("No data found!!");
						}


						if (ds.Tables[0].Rows.Count > 0)
						{
							divExport.Visible = true;
							grd_TagReport.DataSource = ds.Tables[0];
							grd_TagReport.DataBind();

						}
						else
						{
							//divExport.Visible = false;
							grd_TagReport.DataSource = null;
							grd_TagReport.DataBind();
							//Response.Write("No data found!!");
						}
						if (ds.Tables[3].Rows.Count > 0)
						{
							divExport.Visible = true;
							grd_PrimaryVehicleTripCount.DataSource = ds.Tables[3];
							grd_PrimaryVehicleTripCount.DataBind();
						}
						else
						{
							grd_PrimaryVehicleTripCount.DataSource = null;
							grd_PrimaryVehicleTripCount.DataBind();
						}


					}
				}
			}
			catch (Exception ex)
			{
				Logfile.TraceService("LogData", "\n-----------------------EXCEPTION START-----------------------");
				Logfile.TraceService("LogData", "Tagregrestrationagdelhi_vehicles.cs >> Method BindGrid()  >> TimeStamp - " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
				Logfile.TraceService("LogData", "Message >> " + ex.Message);
				Logfile.TraceService("LogData", "Source >> " + ex.Source);
				Logfile.TraceService("LogData", "InnerException >> " + Convert.ToString(ex.InnerException));
				Logfile.TraceService("LogData", "StackTrace >> " + ex.StackTrace);
				Logfile.TraceService("LogData", "-----------------------EXCEPTION END-----------------------");
				Logfile.TraceService("LogData", ex.Message);
			}

		}

		protected void GenerateExcelDirectly(DataTable dataTable, string fileName)
		{
			ExcelPackage.LicenseContext = LicenseContext.NonCommercial; // Set the license context

			using (var package = new ExcelPackage())
			{
				var worksheet = package.Workbook.Worksheets.Add("Attendance Report");

				DataTable dt = new DataTable();
				// Populate dt with data from the GridView or your data source
				// For example: dt = GetDataFromGridView(gridView);
				dt = dataTable;//; GetDataFromGridView(gridView);
											 // Write DataTable content to Excel worksheet
				worksheet.Cells["A1"].LoadFromDataTable(dt, true);

				Response.Clear();
				Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
				Response.AddHeader("content-disposition", "attachment;filename=" + fileName + ".xlsx");
				Response.BinaryWrite(package.GetAsByteArray());
				Response.End();
			}
		}
		protected void ImgExl_Click(object sender, ImageClickEventArgs e)
		{
			GenerateExcel(grd_TagReport, "TagReport_" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
		}

		protected void ImgPDF_Click(object sender, ImageClickEventArgs e)
		{
			GeneratePDF(grd_TagReport, "TagReport_" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
		}
		protected void GenerateExcel(GridView gridView, string fileName)
		{
			ExcelPackage.LicenseContext = LicenseContext.NonCommercial; // Set the license context

			using (var package = new ExcelPackage())
			{
				var worksheet = package.Workbook.Worksheets.Add("Tag Report");

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

		protected void ImageEXl1_Click(object sender, ImageClickEventArgs e)
		{
			GenerateExcel(grd_Tripcount, "TripReport_" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
		}

		protected void ImagePDF1_Click(object sender, ImageClickEventArgs e)
		{
			GeneratePDF(grd_Tripcount, "TripReport_" + Convert.ToString(DateTime.Now.ToString("MM/dd/yyyy HH:mm")));
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
				txtSdate.Text = firstDayOfMonth.ToString("yyyy-MM-dd");
				DateTime lastday = DateTime.Today;
				DateTime lastDayOfMonth = Convert.ToDateTime((DateTime.Today.ToString("yyyy") + "-" + ddlMonth.SelectedValue + "-" + DateTime.DaysInMonth(Convert.ToInt32(DateTime.Today.ToString("yyyy")), Convert.ToInt32(ddlMonth.SelectedValue))));// new DateTime(lastday.Year, lastday.Month, DateTime.DaysInMonth(lastday.Year, lastday.Month));
				ViewState["lastDayOfMonth"] = lastDayOfMonth.ToString("yyyy-MM-dd");
				txtEdate.Text = lastDayOfMonth.ToString("yyyy-MM-dd");

				ddlWeek.SelectedValue = "0";
			}
			else
			{
				DateTime today = DateTime.Today;

				ViewState["firstDayOfMonth"] = DateTime.Today.ToString("yyyy-MM-dd");
				txtSdate.Text = DateTime.Today.ToString("yyyy-MM-dd");

				ViewState["lastDayOfMonth"] = DateTime.Today.ToString("yyyy-MM-dd");
				txtEdate.Text = DateTime.Today.ToString("yyyy-MM-dd");

				ddlWeek.SelectedValue = "0";
			}
			//lastDayOfMonth1 = ddlYear.SelectedItem.Text + "-" + ddlMonth.SelectedValue + "-" + DateTime.DaysInMonth(Convert.ToInt32(ddlYear.SelectedItem.Text), Convert.ToInt32(ddlMonth.SelectedValue));
		}

		protected void ddlWeek_SelectedIndexChanged(object sender, EventArgs e)
		{
			DateTime firstDayOfMonth = DateTime.Now;
			DateTime lastDayOfMonth = DateTime.Now;
			if (ddlWeek.SelectedValue != "0")
			{
				if (ddlMonth.SelectedValue != "0")
				{
					int selectedMonth = Convert.ToInt32(ddlMonth.SelectedValue);
					int selectedYear = DateTime.Today.Year; // You might want to get the selected year from another dropdown or source

					firstDayOfMonth = new DateTime(selectedYear, selectedMonth, 1);

					if (ddlWeek.SelectedValue == "1")
					{
						lastDayOfMonth = firstDayOfMonth.AddDays(6);
					}
					else if (ddlWeek.SelectedValue == "2")
					{
						firstDayOfMonth = firstDayOfMonth.AddDays(7);
						lastDayOfMonth = firstDayOfMonth.AddDays(6);
					}
					else if (ddlWeek.SelectedValue == "3")
					{
						firstDayOfMonth = firstDayOfMonth.AddDays(14);
						lastDayOfMonth = firstDayOfMonth.AddDays(6);
					}
					else if (ddlWeek.SelectedValue == "4")
					{
						firstDayOfMonth = firstDayOfMonth.AddDays(21);
						lastDayOfMonth = new DateTime(firstDayOfMonth.Year, firstDayOfMonth.Month, DateTime.DaysInMonth(firstDayOfMonth.Year, firstDayOfMonth.Month));
					}
				}
				else
				{
					// Handle the case when no month is selected
					//firstDayOfMonth = DateTime.Today;
					//lastDayOfMonth = DateTime.Today;

					int currentMonth = DateTime.Now.Month;
					int currentYear = DateTime.Now.Year;

					firstDayOfMonth = new DateTime(currentYear, currentMonth, 1);

					if (ddlWeek.SelectedValue == "1")
					{
						lastDayOfMonth = firstDayOfMonth.AddDays(6);
					}
					else if (ddlWeek.SelectedValue == "2")
					{
						firstDayOfMonth = firstDayOfMonth.AddDays(7);
						lastDayOfMonth = firstDayOfMonth.AddDays(6);
					}
					else if (ddlWeek.SelectedValue == "3")
					{
						firstDayOfMonth = firstDayOfMonth.AddDays(14);
						lastDayOfMonth = firstDayOfMonth.AddDays(6);
					}
					else if (ddlWeek.SelectedValue == "4")
					{
						firstDayOfMonth = firstDayOfMonth.AddDays(21);
						lastDayOfMonth = new DateTime(firstDayOfMonth.Year, firstDayOfMonth.Month, DateTime.DaysInMonth(firstDayOfMonth.Year, firstDayOfMonth.Month));
					}
				}

				ViewState["firstDayOfMonth"] = firstDayOfMonth.ToString("yyyy-MM-dd");
				txtSdate.Text = firstDayOfMonth.ToString("yyyy-MM-dd");

				ViewState["lastDayOfMonth"] = lastDayOfMonth.ToString("yyyy-MM-dd");
				txtEdate.Text = lastDayOfMonth.ToString("yyyy-MM-dd");
			}
			else
			{
				DateTime today = DateTime.Today;

				ViewState["firstDayOfMonth"] = DateTime.Today.ToString("yyyy-MM-dd");
				txtSdate.Text = DateTime.Today.ToString("yyyy-MM-dd");

				ViewState["lastDayOfMonth"] = DateTime.Today.ToString("yyyy-MM-dd");
				txtEdate.Text = DateTime.Today.ToString("yyyy-MM-dd");
			}
		}

		protected void ddlQuarterYearly_SelectedIndexChanged(object sender, EventArgs e)
		{
			DateTime startDate = DateTime.Today;
			DateTime endDate = DateTime.Today;

			if (ddlQuarterYearly.SelectedValue != "0")
			{
				int selectedYear = DateTime.Today.Year; // You might want to get the selected year from another dropdown or source

				if (ddlQuarterYearly.SelectedValue == "1")
				{
					startDate = new DateTime(selectedYear, 1, 1);
					endDate = new DateTime(selectedYear, 3, 31);
				}
				else if (ddlQuarterYearly.SelectedValue == "2")
				{
					startDate = new DateTime(selectedYear, 4, 1);
					endDate = new DateTime(selectedYear, 6, 30);
				}
				else if (ddlQuarterYearly.SelectedValue == "3")
				{
					startDate = new DateTime(selectedYear, 7, 1);
					endDate = new DateTime(selectedYear, 9, 30);
				}
				else if (ddlQuarterYearly.SelectedValue == "4")
				{
					startDate = new DateTime(selectedYear, 10, 1);
					endDate = new DateTime(selectedYear, 12, 31);
				}
				else if (ddlQuarterYearly.SelectedValue == "5")
				{
					startDate = new DateTime(selectedYear, 1, 1);
					endDate = new DateTime(selectedYear, 6, 30);
				}
				else if (ddlQuarterYearly.SelectedValue == "6")
				{
					startDate = new DateTime(selectedYear, 7, 1);
					endDate = new DateTime(selectedYear, 12, 31);
				}
				else if (ddlQuarterYearly.SelectedValue == "7")
				{
					startDate = new DateTime(selectedYear, 1, 1);
					endDate = new DateTime(selectedYear, 12, 31);
				}

				txtSdate.Text = startDate.ToString("yyyy-MM-dd");
				txtEdate.Text = endDate.ToString("yyyy-MM-dd");
			}
			else
			{
				DateTime today = DateTime.Today;

				txtSdate.Text = DateTime.Today.ToString("yyyy-MM-dd");
				txtEdate.Text = DateTime.Today.ToString("yyyy-MM-dd");
			}
		}
	}
}