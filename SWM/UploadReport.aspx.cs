
using iTextSharp.text;
using iTextSharp.text.pdf;
using OfficeOpenXml;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SWM
{
    public partial class UploadReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void ProcessExcel(string filePath)
        {
            using (var package = new ExcelPackage(new FileInfo(filePath)))
            {

                OfficeOpenXml.ExcelPackage.LicenseContext = LicenseContext.NonCommercial; // Set the license context

                ExcelWorksheet worksheet = package.Workbook.Worksheets[0];

                int rowCount = worksheet.Dimension.Rows;
                int colCount = worksheet.Dimension.Columns;
                // Find the first non-empty row (assuming the header is in the first row)
                int startRow = 2;
                while (startRow <= rowCount && IsRowNullOrEmpty(worksheet, startRow))
                {
                    startRow++;
                }
                for (int row = startRow; row <= rowCount; row++)
                {
                    // Access data in each column of the current row
                    string value1 = worksheet.Cells[row, 1]?.Text;
                    string value2 = worksheet.Cells[row, 2]?.Text;
                    string value3 = worksheet.Cells[row, 3]?.Text;
                    string value4 = worksheet.Cells[row, 4]?.Text;
                    string value5 = worksheet.Cells[row, 5]?.Text;
                    string value6 = worksheet.Cells[row, 6]?.Text;
                    string value7 = worksheet.Cells[row, 7]?.Text;
                    string value8 = worksheet.Cells[row, 8]?.Text;
                    string value9 = worksheet.Cells[row, 9]?.Text;
                    string value10 = worksheet.Cells[row, 10]?.Text;
                    string value11 = worksheet.Cells[row, 11]?.Text;
                    string value12 = worksheet.Cells[row, 12]?.Text;
                    string value13 = worksheet.Cells[row, 13]?.Text;
                    string value14 = worksheet.Cells[row, 14]?.Text;
                    string value15 = worksheet.Cells[row, 15]?.Text;
                    string value16 = worksheet.Cells[row, 16]?.Text;
                    string value17 = worksheet.Cells[row, 17]?.Text;
                    string value18 = worksheet.Cells[row, 18]?.Text;
                    string value19 = worksheet.Cells[row, 19]?.Text;
                    string value20 = worksheet.Cells[row, 20]?.Text;
                    // string value2 = worksheet.Cells[row, 2]?.Text;
                    // ... repeat for all columns

                    // Call method to insert data into SQL Server
                    InsertDataIntoSQL(value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20);
                }

                //for (int row = startRow; row <= rowCount; row++)
                //{
                //// Your row processing code here
                //StringBuilder str;
                //    for (int colm = 1; colm <= colCount; colm++)
                //    {
                //        str.Append(worksheet.Cells[row, colm].Value.ToString());
                //        colm = colCount;
                //    }
                //    // Access data using worksheet.Cells[row, col].Value
                //    // Example: string value = worksheet.Cells[row, 1].Value.ToString();

                //    // Call method to insert data into SQL Server
                //    InsertDataIntoSQL(str);
                //}




                // ExcelWorksheet worksheet = package.Workbook.Worksheets[0]; // Assuming the data is in the first worksheet

                // Iterate through rows and columns to read data
                //int rowCount = worksheet.Dimension.Rows;
                //int colCount = worksheet.Dimension.Columns;

                // Assuming the first row contains column headers
                //for (int row = 2; row <= rowCount; row++)
                //{
                //    string str = "";
                //    for (int colm = 1; colm <= colCount; colm++)
                //    {
                //      str = worksheet.Cells[row, colm].Value.ToString();
                //        colm = colCount;
                //    }
                //        // Access data using worksheet.Cells[row, col].Value
                //        // Example: string value = worksheet.Cells[row, 1].Value.ToString();

                //        // Call method to insert data into SQL Server
                //        InsertDataIntoSQL(str);
                //}
            }
        }
        // Helper method to check if a row is entirely null or empty
        private bool IsRowNullOrEmpty(ExcelWorksheet worksheet, int row)
        {
            int colCount = worksheet.Dimension.Columns;
            for (int col = 1; col <= colCount; col++)
            {
                if (!string.IsNullOrEmpty(worksheet.Cells[row, col]?.Text))
                {
                    return false; // Row is not entirely null or empty
                }
            }
            return true; // Row is entirely null or empty
        }
        protected void InsertDataIntoSQL(string value1, string value2,string value3,string value4,string value5,string value6,string value7,string value8,string value9,string value10,string value11, string value12, string value13, string value14, string value15, string value16, string value17, string value18, string value19, string value20)
        {
            string connectionString = "Data Source = 52.66.47.55; Initial Catalog = SWMSystem; User ID = webadmin; Password = Admin@123!@#; Connect Timeout = 99999; ";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Use SqlCommand to execute SQL INSERT statement
                string insertQuery = "INSERT INTO YourTableName (SrNo,PMC_processing_plant_name_and_details_address_with_SrNo_Pno,Operating_agency,Plant_commissioning_date," +
                    "Plant_Capacity_in_MTD,Actual_operating_capacity_in_MTD,Technology,water_polltion_control_system_details_with_capacity_and_disposal_details," +
                    "Reject_quanity_MTD,Disposal_Details_with_qty,Auhtorization_granted_date_with_validity_and_copy,Consent_granted_date_with_validity_and_date,StartDate," +
                    "EndDate,Any_application_submitted_if_any_UAN_No,Bank_Guarantee_details,Court_Case_details,NGT_case_details," +
                    "Environemnt_Compenstion_imposed,Environemnt_Compenstion_paid_recovery,Createddate,Isdeleted,IsProcess)" +
                    " VALUES (@Value1,@Value2,@Value3,@Value4,@Value5,@Value6,@Value7,@Value8,@Value9,@Value10,@Value11,@Value12,@Value13,@Value14,@Value15,@Value16,@Value17,@Value18,@Value19,@Value20,getdate(),0,0)";
                using (SqlCommand command = new SqlCommand(insertQuery, connection))
                {
                    command.Parameters.AddWithValue("@Value1", value1);
                    command.Parameters.AddWithValue("@Value2", value2);
                    command.Parameters.AddWithValue("@Value3", value3);
                    command.Parameters.AddWithValue("@Value4", value4);
                    command.Parameters.AddWithValue("@Value5", value5);
                    command.Parameters.AddWithValue("@Value6", value6);
                    command.Parameters.AddWithValue("@Value7", value7);
                    command.Parameters.AddWithValue("@Value8", value8);
                    command.Parameters.AddWithValue("@Value9", value9);
                    command.Parameters.AddWithValue("@Value10", value10);
                    command.Parameters.AddWithValue("@Value11", value11);
                    command.Parameters.AddWithValue("@Value12", value12);
                    command.Parameters.AddWithValue("@Value13", value13);
                    command.Parameters.AddWithValue("@Value14", value14);
                    command.Parameters.AddWithValue("@Value15", value15);
                    command.Parameters.AddWithValue("@Value16", value16);
                    command.Parameters.AddWithValue("@Value17", value17);
                    command.Parameters.AddWithValue("@Value18", value18);
                    command.Parameters.AddWithValue("@Value19", value19);
                    command.Parameters.AddWithValue("@Value20", value20);

                    // Add parameters for other columns

                    command.ExecuteNonQuery();
                }
            }
        }
        protected void btnUpload_Click(object sender, EventArgs e)
        {
            if (fileUpload.HasFile)
            {
                string filePath = Server.MapPath("~/Uploads/" + fileUpload.FileName);
                fileUpload.SaveAs(filePath);
                // Call method to process the uploaded Excel file
                ProcessExcel(filePath);
            }
            //if (fileUpload.HasFile)
            //{
            //    //try
            //    //{
            //        string filePath = Server.MapPath("~/App_Data/" + Path.GetFileName(fileUpload.FileName));
            //        fileUpload.SaveAs(filePath);

            //        // Process the Excel file and upload to SQL Server
            //        string connectionString = "Data Source = 52.66.47.55; Initial Catalog = SWMSystem; User ID = webadmin; Password = Admin@123!@#; Connect Timeout = 99999; ";
            //        DataTable dataTable = ReadExcelFile(filePath, "Sheet1");
            //        UploadToSqlServer(dataTable, connectionString, "YourTableName");

            //        lblMessage.Text = "File uploaded successfully!";
            //    //}
            //    //catch (Exception ex)
            //    //{
            //    //    lblMessage.Text = "Error: " + ex.Message;
            //    //}
            //}
            //else
            //{
            //    lblMessage.Text = "Please choose a file.";
            //}
        }

        private DataTable ReadExcelFile(string filePath, string sheetName)
        {
            OfficeOpenXml.ExcelPackage.LicenseContext = LicenseContext.NonCommercial; // Set the license context
            using (var package = new ExcelPackage(new FileInfo(filePath)))
            {
                ExcelWorksheet worksheet = package.Workbook.Worksheets[sheetName];
                DataTable dataTable = new DataTable();

                foreach (var firstRowCell in worksheet.Cells[1, 1, 1, worksheet.Dimension.End.Column])
                {
                    dataTable.Columns.Add(firstRowCell.Text);
                }

                for (int rowNumber = 2; rowNumber <= worksheet.Dimension.End.Row; rowNumber++)
                {
                    var row = worksheet.Cells[rowNumber, 1, rowNumber, worksheet.Dimension.End.Column];
                    var newRow = dataTable.Rows.Add();
                    foreach (var cell in row)
                    {
                        newRow[cell.Start.Column - 1] = cell.Text;
                    }
                }

                return dataTable;
            }
        }

        //private void UploadToSqlServer(DataTable dataTable, string connectionString, string tableName)
        //{
        //    // Implement the logic to upload DataTable to SQL Server
        //    // (Refer to the previous example for uploading to SQL Server in C#)
        //    throw new NotImplementedException();
        //}
        private void UploadToSqlServer(DataTable dataTable, string connectionString, string tableName)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Create SQL Server table if not exists
                using (SqlCommand createTableCommand = new SqlCommand(GetCreateTableQuery(dataTable, tableName), connection))
                {
                    createTableCommand.ExecuteNonQuery();
                }

                // Bulk insert data into SQL Server table
                using (SqlBulkCopy bulkCopy = new SqlBulkCopy(connection))
                {
                    bulkCopy.DestinationTableName = tableName;
                    foreach (DataColumn column in dataTable.Columns)
                    {
                        bulkCopy.ColumnMappings.Add(column.ColumnName, column.ColumnName);
                        // bulkCopy.ColumnMappings.Add("SourceColumn1", "DestinationColumn1").SourceColumnNullMapping = true;
                    }
                    bulkCopy.WriteToServer(dataTable);
                }
            }
        }

        //private string GetCreateTableQuery(DataTable dataTable, string tableName)
        //{
        //    StringBuilder createTableQuery = new StringBuilder($"CREATE TABLE IF NOT EXISTS {tableName} (ID INT IDENTITY(1,1) PRIMARY KEY, ");

        //    foreach (DataColumn column in dataTable.Columns)
        //    {
        //        createTableQuery.Append($"{column.ColumnName} NVARCHAR(MAX), ");
        //    }

        //    createTableQuery.Length -= 2; // Remove the trailing comma and space
        //    createTableQuery.Append(")");

        //    return createTableQuery.ToString();
        //}
        private string GetCreateTableQuery(DataTable dataTable, string tableName)
        {
            StringBuilder createTableQuery = new StringBuilder($"IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '{tableName}') ");
            createTableQuery.Append($"begin CREATE TABLE {tableName} (ID INT IDENTITY(1,1) PRIMARY KEY, ");

            foreach (DataColumn column in dataTable.Columns)
            {
                createTableQuery.Append($"{column.ColumnName} NVARCHAR(MAX), ");
            }

            createTableQuery.Length -= 2; // Remove the trailing comma and space
            createTableQuery.Append(")end");

            return createTableQuery.ToString();
        }
    }
}