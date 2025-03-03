//
//  EarningsRate.swift
//  Dashboard
//
//  Created by Sarfraz Basha on 16/2/2025.
//

import Foundation
import PKPrefs

extension Xero {
    public typealias EarningsRates = Array<EarningsRate>
    public struct EarningsRate: Codable {
        
        /// Unique Xero identifier of the earnings rate
        public var EarningsRateID:     String?
        /// Name of the earnings rate (max length = 100)
        public var Name:               String?
        public var AccountCode:        String?
        /// Type of units used to record earnings (max length = 50).
        /// Only When RateType is RATEPERUNIT
        public var TypeOfUnits:        String?
        /// Most payments are subject to tax, so you should only set this value if you are sure that a payment is exempt from PAYG withholding
        public var IsExemptFromTax:    Bool?
        /// See the [ATO website](https://www.ato.gov.au/business/super-for-employers) for details of which payments are exempt from SGC
        public var IsExemptFromSuper:  Bool?
        /// Boolean to determine if the earnings rate is reportable or exempt from W1
        public var IsReportableAsW1:   Bool?
        public var EarningsType:       EarningsType?
        
        public var RateType:           RateType?
        /// Default rate per unit (optional).
        /// Only applicable if RateType is RATEPERUNIT.
        public var RatePerUnit:        Double?
        /// This is the multiplier used to calculate the rate per unit, based on the employee’s ordinary earnings rate.
        /// For example, for time and a half enter 1.5.
        /// Only applicable if RateType is MULTIPLE
        public var Multiplier:         Double?
        /// Indicates that this earnings rate should accrue leave.
        /// Only applicable if RateType is MULTIPLE
        var AccrueLeave:        Bool?
        /// Optional Amount for FIXEDAMOUNT RateType EarningsRate
        public var Amount:             Double?
        /// Indicates whether an earning type is active
        public var CurrentRecord:      Bool?
        
//        var AllowanceType: AllowanceType?
//        var AllowanceCategory: AllowanceCategory?
//        var EmploymentTerminationPaymentType: ETPType?
        
        //--------------------------------------
        // MARK: - COMPUTED VARIABLES -
        //--------------------------------------
        public var shiftTypeName: String {
            switch Name {
            case "English Tutes": "EnglishTutes"
            case "Marking PPF": "MarkingPPF"
            default: Name ?? ""
            }
        }
        
        //--------------------------------------
        // MARK: - PREFERENCES -
        //--------------------------------------
        @Prefs("EarningsRatesArray")
        public static var All: Array<EarningsRate> = []
        
        /// A map of EarningsRateID to EarningsRate
        @Prefs("EarningsRatesDict")
        public static var Map: Dictionary<String, EarningsRate> = [:]
        
        /// A map of Name to EarningsRate
        @Prefs("EarningsRatesNameDict")
        public static var NameMap: Dictionary<String, EarningsRate> = [:]
    }
}
extension Xero.EarningsRate {
    public enum EarningsType: String, Codable {
        case ORDINARYTIMEEARNINGS
        case OVERTIMEEARNINGS
        /// EarningsRates with EarningsType ALLOWANCE also require an ALLOWANCETYPE value.
        case ALLOWANCE
        /// Earnings Rate with LumpSumA Type is a systems generated earnings rate and can only be used in final pays.
        /// It is used for payments of ATO mandated Lump sum A.
        case LUMPSUMA
        /// Earnings Rate with LumpSumB Type is a systems generated earnings rate and can only be used in final pays.
        /// It is used for payments of ATO mandated Lump sum B.
        case LUMPSUMB
        /// Earnings Rate with LumpSumD Type is a systems generated earnings rate and can only be used in final pays.
        /// It is used for payments of ATO mandated Lump sum D.
        case LUMPSUMD
        /// EarningsRate with LumpSumE Type is used for payments of ATO mandated Lump sum E.
        case LUMPSUME
        /// EarningsRates with EarningsType EMPLOYMENTTERMINATIONPAYMENT can only be used in final pays.
        case EMPLOYMENTTERMINATIONPAYMENT
        /// EarningsRates with EarningsType BONUSESANDCOMMISSIONS always subject to tax and reportable as W1
        case BONUSESANDCOMMISSIONS
        /// Earnings Rates with LUMPSUMW Type is used for payments made for return to work amounts given to employees.
        /// It is always subject to tax and reportable as W1.
        case LUMPSUMW
        /// Earnings Rates with DIRECTORSFEES Type is used for payments to director of a company or a person performing duties of a director.
        /// It is always subject to tax and reportable as W1.
        case DIRECTORSFEES
        /// Earnings Rates with PAIDPARENTALLEAVE Type is used for payments to eligible employees when they are on parental leave.
        /// It is always subject to tax and reportable as W1.
        case PAIDPARENTALLEAVE
        /// Earnings Rates with WORKERSCOMPENSATION Type is used for wage replacement and medical benefits to employees injured in the course of employment.
        /// It is always subject to tax and reportable as W1.
        case WORKERSCOMPENSATION
    }
}

extension Xero.EarningsRate {
    public enum RateType: String, Codable {
        case FIXEDAMOUNT
        /// Multiple of Employee’s Ordinary Earnings Rate: an earnings rate which is derived from an employee’s ordinary earnings rate
        case MULTIPLE
        /// An earnings rate allowing entry of a rate per unit
        case RATEPERUNIT
    }
}
extension Xero.EarningsRate: CustomStringConvertible {
    public var description: String {
        var desc: String = ""
        if let Name { desc += Name }
        if let EarningsRateID { desc += ", ID: \(EarningsRateID)"}
        return desc
    }
}
