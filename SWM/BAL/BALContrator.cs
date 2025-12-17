using SWM.DAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace SWM.BAL
{
    public class BALContrator
    {

        //@mode = 3,@accid = 11401,@startdate = default,@enddate = default,@EmpId = 0,@roleid = 0,
        //        //@districtid = 332,@countryid = 1,@stateid = 21,@TypeOfCompany = N'LIMITED COMPANY',@NatureOfBusiness = N'test 16102023',
        //        //@YearOfEstablishment = N'2023-10-16',@AreaOfOption = N'Local',@NameOfContractor = N'test 16102023',
        //        //@FirmName = N'test 16102023',@Address = N'test 16102023',@MobileNo = N'test 16102',@LandlineNo = N'test 16102',
        //        //@GSTN = N'test 16102023',@PanNo = N'test 16102023',
        //        //@BankAccNo = N'test 16102023',@NameOfAccHolder = N'test 16102023',@ISFC = N'test 16102023',@Branch = N'test 16102023',@Pk_ContractorId = 0

        public DataSet InsertContractorRegistration(int @mode, int @accid, string @NameOfContractor, string @FirmName, string @VendorRegistrationNumber,
            string @Address, string @MobileNo, string @LandlineNo, string @GSTN, string @PanNo,
            string @BankAccNo, string @NameOfAccHolder, string @ISFC, string @Branch, int @Pk_ContractorId)
        {
            DALContractor dALContractor = new DALContractor();
            DataSet dataSet = new DataSet();

            dataSet = dALContractor.InsertContractorRegistration(@mode, @accid, @NameOfContractor, @FirmName,
             @VendorRegistrationNumber, @Address, @MobileNo, @LandlineNo, @GSTN, @PanNo, @BankAccNo, @NameOfAccHolder,
                  @ISFC, @Branch, @Pk_ContractorId);
            return dataSet;
        }
        public DataSet GetContractorRegistration(int @mode, int @Pk_ContractorId)
        {
            DALContractor dALContractor = new DALContractor();
            DataSet dataSet = new DataSet();

            dataSet = dALContractor.GetContractorRegistration(@mode, @Pk_ContractorId);
            return dataSet;
        }

        public DataSet InsertContractor(int @mode, int @accid, string @ContractName, string @TendorNo, int @ContractorId, string @TitalOfwork,
            string @ContractPeriodFrom, string @ContractPeriodTo, string @ExtensionFrom, string @ExtensionTo, int @BudgetdHeadId, string @BudgetAmount,
            string @PreviousSanctionValue, string @ActualTendorValue, string @BillValue, int @pk_ContractId, string @dpr_File)
        {
            DALContractor dALContractor = new DALContractor();
            DataSet dataSet = new DataSet();

            dataSet = dALContractor.InsertContractor(@mode, @accid, @ContractName, @TendorNo, @ContractorId, @TitalOfwork,
            @ContractPeriodFrom, @ContractPeriodTo, @ExtensionFrom, @ExtensionTo, @BudgetdHeadId, @BudgetAmount, @PreviousSanctionValue,
            @ActualTendorValue, @BillValue, @pk_ContractId, @dpr_File);
            return dataSet;
        }
        public DataSet GetContractor(int @mode, int @accid, int @pk_ContractId)
        {
            DALContractor dALContractor = new DALContractor();
            DataSet dataSet = new DataSet();

            dataSet = dALContractor.GetContractor(@mode, @accid, @pk_ContractId);
            return dataSet;
        }
        public DataSet GetBudgetHead(int @mode, int @accid, int @BudgetHeadId)
        {
            DALContractor dALContractor = new DALContractor();
            DataSet dataSet = new DataSet();

            dataSet = dALContractor.GetBudgetHead(@mode, @accid, @BudgetHeadId);
            return dataSet;
        }
        public DataSet InsertBudgetHead(int @mode, int @accid, string @BudgetHeadName, long @BudgetHeadCode, decimal @TotalBudgetValue,
            decimal @PrevSanctionedValue, string @PrevSanctionedYear, decimal @AvailableBudgetValue, string @AvailableBudgetYear,
            string @SanctioningAuthority, string @dateOfApproval, string @SanctionedNo, string @SanctionedByFinancialCommittee, int @BudgetHeadId)
        {
            DALContractor dALContractor = new DALContractor();
            DataSet dataSet = new DataSet();

            dataSet = dALContractor.InsertBudgetHead(@mode, @accid, @BudgetHeadName, @BudgetHeadCode, @TotalBudgetValue,
            @PrevSanctionedValue, @PrevSanctionedYear, @AvailableBudgetValue, @AvailableBudgetYear, @SanctioningAuthority,
             @dateOfApproval, @SanctionedNo, @SanctionedByFinancialCommittee, @BudgetHeadId);
            return dataSet;
        }

        public DataSet GetRevokeDetail(int @mode, string @revokeid, string @Status)
        {
            DALContractor dALContractor = new DALContractor();
            DataSet dataSet = new DataSet();

            dataSet = dALContractor.GetRevokeDetail(@mode, @revokeid, @Status);
            return dataSet;
        }
        public DataSet GetBillDetails(int @mode, int @contractId)
        {
            DALContractor dALContractor = new DALContractor();
            DataSet dataSet = new DataSet();

            dataSet = dALContractor.GetBillDetails(@mode, @contractId);
            return dataSet;
        }
        public DataSet GetGenerateBill(int @mode, int @contractId)
        {
            DALContractor dALContractor = new DALContractor();
            DataSet dataSet = new DataSet();

            dataSet = dALContractor.GetGenerateBill(@mode, @contractId);
            return dataSet;
        }
        public DataSet LockGenerateBill(int @mode, int @accid, string @contractId, string @BillForPeriod,
decimal @TotalBillAmount, string @budgetheadid, string @TendorNo, string @ContractorName, string @AddressOfContractor,
string @BudgetHead, string @BudgetCode, decimal @TotalBudgetValue, decimal @AvailableBudgetValue, string @ContractName)
        {
            DALContractor dALContractor = new DALContractor();
            DataSet dataSet = new DataSet();

            dataSet = dALContractor.LockGenerateBill(@mode, @accid, @contractId, @BillForPeriod,
 @TotalBillAmount, @budgetheadid, @TendorNo, @ContractorName, @AddressOfContractor,
 @BudgetHead, @BudgetCode, @TotalBudgetValue, @AvailableBudgetValue, @ContractName);
            return dataSet;
        }
        public DataSet GetRevokeForm(int @mode, string @contractid, string @remark)
        {
            DALContractor dALContractor = new DALContractor();
            DataSet dataSet = new DataSet();

            dataSet = dALContractor.GetRevokeForm(@mode, @contractid, @remark);
            return dataSet;
        }
    }

}