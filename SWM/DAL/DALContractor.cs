using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace SWM.DAL
{
    public class DALContractor :BaseData
    {
        DataTable dt = new DataTable();
        SqlDataAdapter Sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        public DataSet InsertContractorRegistration(int @mode, int @accid, string @NameOfContractor, string @FirmName, string @VendorRegistrationNumber,
            string @Address, string @MobileNo, string @LandlineNo, string @GSTN, string @PanNo,
            string @BankAccNo, string @NameOfAccHolder, string @ISFC, string @Branch, int @Pk_ContractorId = 0)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();
            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_ContractorRegistration", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = @mode;
                scCommand.Parameters.Add("@accid", SqlDbType.VarChar, 50).Value = @accid;
                scCommand.Parameters.Add("@NameOfContractor", SqlDbType.VarChar, 50).Value = @NameOfContractor;
                scCommand.Parameters.Add("@FirmName", SqlDbType.VarChar, 50).Value = @FirmName;
                scCommand.Parameters.Add("@VendorRegistrationNumber", SqlDbType.VarChar, 50).Value = @VendorRegistrationNumber;
                scCommand.Parameters.Add("@Address", SqlDbType.VarChar, 50).Value = @Address;
                scCommand.Parameters.Add("@MobileNo", SqlDbType.VarChar, 50).Value = @MobileNo;
                scCommand.Parameters.Add("@LandlineNo", SqlDbType.VarChar, 50).Value = @LandlineNo;
                scCommand.Parameters.Add("@GSTN", SqlDbType.VarChar, 50).Value = @GSTN;
                scCommand.Parameters.Add("@PanNo", SqlDbType.VarChar, 50).Value = @PanNo;
                scCommand.Parameters.Add("@BankAccNo", SqlDbType.VarChar, 50).Value = @BankAccNo;
                scCommand.Parameters.Add("@NameOfAccHolder", SqlDbType.VarChar, 50).Value = @NameOfAccHolder;
                scCommand.Parameters.Add("@ISFC", SqlDbType.VarChar, 50).Value = @ISFC;
                scCommand.Parameters.Add("@Branch", SqlDbType.VarChar, 50).Value = @Branch;
                scCommand.Parameters.Add("@Pk_ContractorId", SqlDbType.VarChar, 50).Value = @Pk_ContractorId;
                
                scCommand.CommandType = CommandType.StoredProcedure;

                Sda.SelectCommand = scCommand;
                scCommand.CommandTimeout = 600;
                Sda.Fill(dataSet);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (conn.State == ConnectionState.Open)
                {
                    conn.Close();
                }
                scCommand.Dispose();
                dt.Dispose();
                Sda.Dispose();
            }
        }

        public DataSet GetContractorRegistration(int @mode, int @Pk_ContractorId)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();
            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_ContractorRegistration", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = @mode;
                scCommand.Parameters.Add("@Pk_ContractorId", SqlDbType.Int, 50).Value = @Pk_ContractorId;

                scCommand.CommandType = CommandType.StoredProcedure;

                Sda.SelectCommand = scCommand;
                scCommand.CommandTimeout = 600;
                Sda.Fill(dataSet);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (conn.State == ConnectionState.Open)
                {
                    conn.Close();
                }
                scCommand.Dispose();
                dt.Dispose();
                Sda.Dispose();
            }
        }

        public DataSet InsertContractor(int @mode, int @accid, string @ContractName, string @TendorNo, int @ContractorId, string @TitalOfwork,
            string @ContractPeriodFrom, string @ContractPeriodTo, string @ExtensionFrom, string @ExtensionTo, int @BudgetdHeadId, string @BudgetAmount,
            string @PreviousSanctionValue, string @ActualTendorValue, string @BillValue, int @pk_ContractId, string @dpr_File)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();
            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_ContractForm", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = @mode;
                scCommand.Parameters.Add("@accid", SqlDbType.VarChar, 50).Value = @accid;
                scCommand.Parameters.Add("@ContractName", SqlDbType.VarChar, 50).Value = @ContractName;
                scCommand.Parameters.Add("@TendorNo", SqlDbType.VarChar, 50).Value = @TendorNo;
                scCommand.Parameters.Add("@ContractorId", SqlDbType.Int).Value = @ContractorId;
                scCommand.Parameters.Add("@TitalOfwork", SqlDbType.VarChar, 500).Value = @TitalOfwork;
                scCommand.Parameters.Add("@ContractPeriodFrom", SqlDbType.VarChar, 50).Value = @ContractPeriodFrom;
                scCommand.Parameters.Add("@ContractPeriodTo", SqlDbType.VarChar, 50).Value = @ContractPeriodTo;
                scCommand.Parameters.Add("@ExtensionFrom", SqlDbType.VarChar, 50).Value = @ExtensionFrom;
                scCommand.Parameters.Add("@ExtensionTo", SqlDbType.VarChar, 50).Value = @ExtensionTo;
                scCommand.Parameters.Add("@BudgetdHeadId", SqlDbType.Int).Value = @BudgetdHeadId;
                scCommand.Parameters.Add("@BudgetAmount", SqlDbType.VarChar, 50).Value = @BudgetAmount;
                scCommand.Parameters.Add("@PreviousSanctionValue", SqlDbType.VarChar, 50).Value = @PreviousSanctionValue;
                scCommand.Parameters.Add("@ActualTendorValue", SqlDbType.VarChar, 50).Value = @ActualTendorValue;
                scCommand.Parameters.Add("@BillValue", SqlDbType.VarChar, 50).Value = @BillValue;
                scCommand.Parameters.Add("@pk_ContractId", SqlDbType.Int).Value = @pk_ContractId;
                scCommand.Parameters.Add("@dpr_File", SqlDbType.VarChar, 50).Value = @dpr_File;

                scCommand.CommandType = CommandType.StoredProcedure;

                Sda.SelectCommand = scCommand;
                scCommand.CommandTimeout = 600;
                Sda.Fill(dataSet);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (conn.State == ConnectionState.Open)
                {
                    conn.Close();
                }
                scCommand.Dispose();
                dt.Dispose();
                Sda.Dispose();
            }
        }

        public DataSet GetContractor(int @mode, int @accid, int @pk_ContractId)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();
            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_ContractForm", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = @mode;
                scCommand.Parameters.Add("@accid", SqlDbType.Int, 50).Value = @accid;
                scCommand.Parameters.Add("@pk_ContractId", SqlDbType.Int, 50).Value = @pk_ContractId;

                scCommand.CommandType = CommandType.StoredProcedure;

                Sda.SelectCommand = scCommand;
                scCommand.CommandTimeout = 600;
                Sda.Fill(dataSet);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (conn.State == ConnectionState.Open)
                {
                    conn.Close();
                }
                scCommand.Dispose();
                dt.Dispose();
                Sda.Dispose();
            }
        }

        public DataSet GetBudgetHead(int @mode, int @accid, int @BudgetHeadId)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();
            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_BudgetHead", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = @mode;
                scCommand.Parameters.Add("@accid", SqlDbType.Int, 50).Value = @accid;
                scCommand.Parameters.Add("@BudgetHeadId", SqlDbType.Int, 50).Value = @BudgetHeadId;
                scCommand.CommandType = CommandType.StoredProcedure;

                Sda.SelectCommand = scCommand;
                scCommand.CommandTimeout = 600;
                Sda.Fill(dataSet);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (conn.State == ConnectionState.Open)
                {
                    conn.Close();
                }
                scCommand.Dispose();
                dt.Dispose();
                Sda.Dispose();
            }
        }

        public DataSet InsertBudgetHead(int @mode, int @accid, string @BudgetHeadName, long @BudgetHeadCode, decimal @TotalBudgetValue,
            decimal @PrevSanctionedValue, string @PrevSanctionedYear, decimal @AvailableBudgetValue, string @AvailableBudgetYear,
            string @SanctioningAuthority, string @dateOfApproval, string @SanctionedNo, string @SanctionedByFinancialCommittee, int @BudgetHeadId)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();
            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_BudgetHead", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = @mode;
                scCommand.Parameters.Add("@accid", SqlDbType.Int, 50).Value = @accid;
                scCommand.Parameters.Add("@BudgetHeadName", SqlDbType.VarChar, 50).Value = @BudgetHeadName;
                scCommand.Parameters.Add("@BudgetHeadCode", SqlDbType.BigInt).Value = @BudgetHeadCode;
                scCommand.Parameters.Add("@TotalBudgetValue", SqlDbType.BigInt).Value = @TotalBudgetValue;
                scCommand.Parameters.Add("@PrevSanctionedValue", SqlDbType.BigInt).Value = @PrevSanctionedValue;
                scCommand.Parameters.Add("@PrevSanctionedYear", SqlDbType.VarChar, 500).Value = @PrevSanctionedYear;
                scCommand.Parameters.Add("@AvailableBudgetValue", SqlDbType.BigInt).Value = @AvailableBudgetValue;
                scCommand.Parameters.Add("@AvailableBudgetYear", SqlDbType.VarChar, 50).Value = @AvailableBudgetYear;
                scCommand.Parameters.Add("@SanctioningAuthority", SqlDbType.VarChar, 50).Value = @SanctioningAuthority;
                scCommand.Parameters.Add("@dateOfApproval", SqlDbType.VarChar, 50).Value = @dateOfApproval;
                scCommand.Parameters.Add("@SanctionedNo", SqlDbType.VarChar, 50).Value = @SanctionedNo;
                scCommand.Parameters.Add("@SanctionedByFinancialCommittee", SqlDbType.VarChar, 50).Value = @SanctionedByFinancialCommittee;
                scCommand.Parameters.Add("@BudgetHeadId", SqlDbType.Int).Value = @BudgetHeadId;

                scCommand.CommandType = CommandType.StoredProcedure;

                Sda.SelectCommand = scCommand;
                scCommand.CommandTimeout = 600;
                Sda.Fill(dataSet);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (conn.State == ConnectionState.Open)
                {
                    conn.Close();
                }
                scCommand.Dispose();
                dt.Dispose();
                Sda.Dispose();
            }
        }

        public DataSet GetRevokeDetail(int @mode, string @revokeid, string @Status)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();
            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_RevokeReport", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = @mode;
                scCommand.Parameters.Add("@revokeid", SqlDbType.VarChar, 50).Value = @revokeid;
                scCommand.Parameters.Add("@Status", SqlDbType.VarChar, 50).Value = @Status;

                scCommand.CommandType = CommandType.StoredProcedure;

                Sda.SelectCommand = scCommand;
                scCommand.CommandTimeout = 600;
                Sda.Fill(dataSet);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (conn.State == ConnectionState.Open)
                {
                    conn.Close();
                }
                scCommand.Dispose();
                dt.Dispose();
                Sda.Dispose();
            }
        }

        public DataSet GetBillDetails(int @mode, int @contractId)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();
            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_BillDetails", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = @mode;
                scCommand.Parameters.Add("@contractId", SqlDbType.Int, 50).Value = @contractId;

                scCommand.CommandType = CommandType.StoredProcedure;

                Sda.SelectCommand = scCommand;
                scCommand.CommandTimeout = 600;
                Sda.Fill(dataSet);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (conn.State == ConnectionState.Open)
                {
                    conn.Close();
                }
                scCommand.Dispose();
                dt.Dispose();
                Sda.Dispose();
            }
        }

        public DataSet GetGenerateBill(int @mode, int @contractId)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();
            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_ContractGenerateBill", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = @mode;
                scCommand.Parameters.Add("@contractId", SqlDbType.Int, 50).Value = @contractId;

                scCommand.CommandType = CommandType.StoredProcedure;

                Sda.SelectCommand = scCommand;
                scCommand.CommandTimeout = 600;
                Sda.Fill(dataSet);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (conn.State == ConnectionState.Open)
                {
                    conn.Close();
                }
                scCommand.Dispose();
                dt.Dispose();
                Sda.Dispose();
            }
        }

        public DataSet LockGenerateBill(int @mode, int @accid, string @contractId, string @BillForPeriod,
decimal @TotalBillAmount, string @budgetheadid, string @TendorNo, string @ContractorName, string @AddressOfContractor,
string @BudgetHead, string @BudgetCode, decimal @TotalBudgetValue, decimal @AvailableBudgetValue, string @ContractName)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();
            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_ContractGenerateBill", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = @mode;
                scCommand.Parameters.Add("@accid", SqlDbType.Int, 50).Value = @accid;
                scCommand.Parameters.Add("@contractId", SqlDbType.VarChar, 50).Value = @contractId;
                scCommand.Parameters.Add("@BillForPeriod", SqlDbType.VarChar, 50).Value = @BillForPeriod;
                scCommand.Parameters.Add("TotalBudgetValue", SqlDbType.Decimal).Value = @TotalBudgetValue;
                scCommand.Parameters.Add("@TotalBillAmount", SqlDbType.Decimal).Value = @TotalBillAmount;
                scCommand.Parameters.Add("@budgetheadid", SqlDbType.VarChar, 500).Value = @budgetheadid;
                scCommand.Parameters.Add("AvailableBudgetValue", SqlDbType.Decimal).Value = @AvailableBudgetValue;
                scCommand.Parameters.Add("@TendorNo", SqlDbType.VarChar, 50).Value = @TendorNo;
                scCommand.Parameters.Add("@ContractorName", SqlDbType.VarChar, 50).Value = @ContractorName;
                scCommand.Parameters.Add("@AddressOfContractor", SqlDbType.VarChar, 50).Value = @AddressOfContractor;
                scCommand.Parameters.Add("@BudgetHead", SqlDbType.VarChar, 50).Value = @BudgetHead;
                scCommand.Parameters.Add("@BudgetCode", SqlDbType.VarChar, 50).Value = @BudgetCode;
                
                scCommand.Parameters.Add("@ContractName", SqlDbType.VarChar, 50).Value = @ContractName;
                scCommand.CommandType = CommandType.StoredProcedure;

                Sda.SelectCommand = scCommand;
                scCommand.CommandTimeout = 600;
                Sda.Fill(dataSet);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (conn.State == ConnectionState.Open)
                {
                    conn.Close();
                }
                scCommand.Dispose();
                dt.Dispose();
                Sda.Dispose();
            }
        }

        public DataSet GetRevokeForm(int @mode, string @contractid, string @remark)
        {
            DataSet dataSet = new DataSet();
            dt = new DataTable();
            Sda = new SqlDataAdapter();
            SqlCommand scCommand = new SqlCommand();
            try
            {
                conn.Open();
                scCommand = new SqlCommand("proc_RevokeForm", conn);
                scCommand.CommandType = CommandType.StoredProcedure;
                scCommand.Parameters.Add("@mode", SqlDbType.Int, 50).Value = @mode;
                scCommand.Parameters.Add("@contractid", SqlDbType.VarChar, 50).Value = @contractid;
                scCommand.Parameters.Add("@remark", SqlDbType.VarChar, 50).Value = @remark;

                scCommand.CommandType = CommandType.StoredProcedure;

                Sda.SelectCommand = scCommand;
                scCommand.CommandTimeout = 600;
                Sda.Fill(dataSet);
                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (conn.State == ConnectionState.Open)
                {
                    conn.Close();
                }
                scCommand.Dispose();
                dt.Dispose();
                Sda.Dispose();
            }
        }

    }
}