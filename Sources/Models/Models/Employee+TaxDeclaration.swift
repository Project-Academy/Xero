//
//  Employee+TaxDeclaration.swift
//  Dashboard
//
//  Created by Sarfraz Basha on 16/2/2025.
//

import Foundation

extension Xero.Employee {
    public struct TaxDeclaration: Codable {
//        public init(EmployeeID: String? = nil, EmploymentBasis: Xero.Employee.TaxDeclaration.EmploymentBasis? = nil, TaxFileNumber: String? = nil, TaxFreeThresholdClaimed: Bool? = nil, HasLoanOrStudentDebt: Bool? = nil, UpdatedDateUTC: Date? = nil, TFNExemptionType: Xero.Employee.TaxDeclaration.TFNExemptionType? = nil, ResidencyStatus: Xero.Employee.TaxDeclaration.ResidencyStatus? = nil, AustralianResidentForTaxPurposes: Bool? = nil, EligibleToReceiveLeaveLoading: Bool? = nil, TaxOffsetEstimatedAmount: Double? = nil, UpwardVariationTaxWithholdingAmount: Double? = nil, ApprovedWithholdingVariationPercentage: Double? = nil, HasHELPDebt: Bool? = nil, HasSFSSDebt: Bool? = nil, HasStudentStartupLoan: Bool? = nil, HasTradeSupportLoanDebt: Bool? = nil) {
//            self.EmployeeID = EmployeeID
//            self.EmploymentBasis = EmploymentBasis
//            self.TaxFileNumber = TaxFileNumber
//            self.TaxFreeThresholdClaimed = TaxFreeThresholdClaimed
//            self.HasLoanOrStudentDebt = HasLoanOrStudentDebt
//            self.UpdatedDateUTC = UpdatedDateUTC
//            self.TFNExemptionType = TFNExemptionType
//            self.ResidencyStatus = ResidencyStatus
//            self.AustralianResidentForTaxPurposes = AustralianResidentForTaxPurposes
//            self.EligibleToReceiveLeaveLoading = EligibleToReceiveLeaveLoading
//            self.TaxOffsetEstimatedAmount = TaxOffsetEstimatedAmount
//            self.UpwardVariationTaxWithholdingAmount = UpwardVariationTaxWithholdingAmount
//            self.ApprovedWithholdingVariationPercentage = ApprovedWithholdingVariationPercentage
//        }
        
        
        //--------------------------------------
        // MARK: - IMPORTANT VARIABLES -
        //--------------------------------------
        public var EmployeeID:              String?
        public var EmploymentBasis:         EmploymentBasis?
        public var TaxFileNumber:           String?
        public var TaxFreeThresholdClaimed: Bool?
        public var TaxScaleType:            TaxScaleType?
        /// A boolean describing whether the employee has at least one Loan/Debts.
        /// See discussion for specific Loans/Debts.
        ///
        /// Loan/Debt List
        /// ----------
        /// 1. Higher Education Loan Program (HELP/HECS),
        /// 2. VET Student Loan (VSL)
        /// 3. Financial Supplement (FS)
        /// 4. Student Start-up Loan (SSL)
        /// 5. Trade Support Loan (TSL)
        ///
        /// - important: This property takes priority over any values set in
        /// ``HasHELPDebt``, ``HasSFSSDebt``, ``HasStudentStartupLoan``
        /// & ``HasTradeSupportLoanDebt``.
        ///
        /// - note: If ``HasLoanOrStudentDebt`` is explicitly set it will always take precedence over the four "legacy" debt fields (``HasHELPDebt``, ``HasSFSSDebt``, ``HasTradeSupportLoanDebt``, ``HasStudentStartupLoan``).
        /// - note: If ``HasLoanOrStudentDebt`` is set to false, it will override the four legacy fields – which will all be inferred to be false, regardless of their value in the payload.
        /// - note: If ``HasLoanOrStudentDebt`` is not explicitly set, and one or more of the four legacy fields are set to true, ``HasLoanOrStudentDebt`` will be inferred to be true.
        /// - note: If ``HasLoanOrStudentDebt`` is not explicitly set, and the four legacy fields are false in the resulting tax declaration, then ``HasLoanOrStudentDebt`` will be inferred to be false.
        public var HasLoanOrStudentDebt:        Bool?
        @StringDate
        public var UpdatedDateUTC: Date?
        
        //--------------------------------------
        // MARK: - OTHER VARIABLES -
        //--------------------------------------
        var TFNExemptionType:                       TFNExemptionType?
        var ResidencyStatus:                        ResidencyStatus?
        var AustralianResidentForTaxPurposes:       Bool?
        var EligibleToReceiveLeaveLoading:          Bool?
        var TaxOffsetEstimatedAmount:               Double?
        var UpwardVariationTaxWithholdingAmount:    Double?
        var ApprovedWithholdingVariationPercentage: Double?
        
        //--------------------------------------
        // MARK: - DEPRECATED VARS -
        //--------------------------------------
        @available(*, deprecated, renamed: "HasLoanOrStudentDebt")
        private var HasHELPDebt:                Bool?
        @available(*, deprecated, renamed: "HasLoanOrStudentDebt")
        private var HasSFSSDebt:                Bool?
        @available(*, deprecated, renamed: "HasLoanOrStudentDebt")
        private var HasStudentStartupLoan:      Bool?
        @available(*, deprecated, renamed: "HasLoanOrStudentDebt")
        private var HasTradeSupportLoanDebt:    Bool?
        
        
    }
}
extension Xero.Employee.TaxDeclaration {
    public enum EmploymentBasis: String, Codable {
        case FULLTIME
        case PARTTIME
        case CASUAL
        case LABOURHIRE
        case NONEMPLOYEE
    }
}
extension Xero.Employee.TaxDeclaration {
    public enum TFNExemptionType: String, Codable {
        /// Employee has not provided a TFN.
        /// TaxScaleType must not be set.
        case NOTQUOTED
        /// Employee has made a separate application or Enquiry to the ATO for a new or existing TFN.
        case PENDING
        /// Employee is claiming that they are in receipt of a pension, benefit or allowance.
        /// Employees with an Income Type of ‘Working Holiday Maker’ cannot have a TFN exemption of PENSIONER.
        case PENSIONER
        /// Employee is claiming an exemption as they are under the age of 18 and do not earn enough to pay tax.
        /// Employees with an Income Type of ‘Working Holiday Maker’ cannot have a TFN exemption of UNDER18.
        case UNDER18
    }
}
extension Xero.Employee.TaxDeclaration {
    public enum ResidencyStatus: String, Codable {
        /// Employee is an Australian resident for tax purposes.
        /// AustralianResidentForTaxPurposes must be true.
        case AUSTRALIANRESIDENT
        /// Employee is a foreign resident for tax purposes. AustralianResidentForTaxPurposes must be false.
        /// TaxScaleType must be one of HORTICULTURISTORSHEARER or FOREIGN.
        case FOREIGNRESIDENT
    }
}
