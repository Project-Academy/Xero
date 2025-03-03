//
//  EarningsLine.swift
//  Dashboard
//
//  Created by Sarfraz Basha on 15/2/2025.
//

import Foundation

extension Xero {
    public typealias EarningsLines = Array<EarningsLine>
    public struct EarningsLine: Codable {
        /// Xero identifier for payroll earnings rate.
        public var EarningsRateID:     String?
        /// Rate per unit for earnings rate.
        public var RatePerUnit:        Decimal?
        /// Earnings rate number of units.
        public var NumberOfUnits:      Decimal?
        /// Earnings rate amount.
        /// Only applicable if the EarningsRate RateType is Fixed
        public var FixedAmount:        Decimal?
        /// The Tax Year in which a Lump Sum E Earnings Line was accrued.
        /// Only applicable if the EarningsRate EarningsType is LUMPSUME
        var LumpSumETaxYear:    Double?
        
        //--------------------------------------
        // MARK: - COMPUTED -
        //--------------------------------------
        public var earningsRate: EarningsRate? {
            guard let EarningsRateID else { return nil }
            return Xero.EarningsRate.Map[EarningsRateID]
        }
        public var Name: String? { earningsRate?.Name }
        
        //--------------------------------------
        // MARK: - ONLY IN PAYTEMPLATE? -
        //--------------------------------------
        public var CalculationType: EarningsRateCalculationType?
        /// Hours per week for the EarningsLine.
        /// Applicable for ANNUALSALARY CalculationType
        var NumberOfUnitsPerWeek: Double?
        var AnnualSalary: Double?
        /// Normal number of units for EarningsLine. Applicable when RateType is "MULTIPLE"
        var NormalNumberOfUnits: Double?
        
    }
}
extension Xero.EarningsLine {
    public enum EarningsRateCalculationType: String, Codable {
        /// Use the rate per unit recorded for the earnings rate under Settings
        case USEEARNINGSRATE
        /// The rate per unit is be added manually to the earnings line
        case ENTEREARNINGSRATE
        /// If the employee receives a salary, the annual salary amount and units of
        ///  work per week are added to the earnings line
        case ANNUALSALARY
    }
}
public extension Xero.EarningsLine {
    static func Teaching(_ rate: Decimal) -> Xero.EarningsLine {
        guard let eRate = Xero.EarningsRate.NameMap["Teaching"]?.EarningsRateID
        else { fatalError() }
        return Xero.EarningsLine(EarningsRateID: eRate, RatePerUnit: rate,  CalculationType: .ENTEREARNINGSRATE)
    }
    static func Tutorial(_ rate: Decimal) -> Xero.EarningsLine {
        guard let eRate = Xero.EarningsRate.NameMap["Tutoring"]?.EarningsRateID
        else { fatalError() }
        return Xero.EarningsLine(EarningsRateID: eRate, RatePerUnit: rate,  CalculationType: .ENTEREARNINGSRATE)
    }
    static func Resourcing(_ rate: Decimal) -> Xero.EarningsLine {
        guard let eRate = Xero.EarningsRate.NameMap["Resourcing"]?.EarningsRateID
        else { fatalError() }
        return Xero.EarningsLine(EarningsRateID: eRate, RatePerUnit: rate,  CalculationType: .ENTEREARNINGSRATE)
    }
    static func Marking(_ rate: Decimal) -> Xero.EarningsLine {
        guard let eRate = Xero.EarningsRate.NameMap["Marking"]?.EarningsRateID
        else { fatalError() }
        return Xero.EarningsLine(EarningsRateID: eRate, RatePerUnit: rate,  CalculationType: .ENTEREARNINGSRATE)
    }
    static func Operations(_ rate: Decimal) -> Xero.EarningsLine {
        guard let eRate = Xero.EarningsRate.NameMap["Operations"]?.EarningsRateID
        else { fatalError() }
        return Xero.EarningsLine(EarningsRateID: eRate, RatePerUnit: rate,  CalculationType: .ENTEREARNINGSRATE)
    }
    static func Coding(_ rate: Decimal) -> Xero.EarningsLine {
        guard let eRate = Xero.EarningsRate.NameMap["Coding"]?.EarningsRateID
        else { fatalError() }
        return Xero.EarningsLine(EarningsRateID: eRate, RatePerUnit: rate,  CalculationType: .ENTEREARNINGSRATE)
    }
    static func ThinkTank(_ rate: Decimal) -> Xero.EarningsLine {
        guard let eRate = Xero.EarningsRate.NameMap["ThinkTank"]?.EarningsRateID
        else { fatalError() }
        return Xero.EarningsLine(EarningsRateID: eRate, RatePerUnit: rate,  CalculationType: .ENTEREARNINGSRATE)
    }
    static func English(_ rate: Decimal) -> Xero.EarningsLine {
        guard let eRate = Xero.EarningsRate.NameMap["English Tutes"]?.EarningsRateID
        else { fatalError() }
        return Xero.EarningsLine(EarningsRateID: eRate, RatePerUnit: rate,  CalculationType: .ENTEREARNINGSRATE)
    }
    static func Shadowing(_ rate: Decimal) -> Xero.EarningsLine {
        guard let eRate = Xero.EarningsRate.NameMap["Shadowing"]?.EarningsRateID
        else { fatalError() }
        return Xero.EarningsLine(EarningsRateID: eRate, RatePerUnit: rate,  CalculationType: .ENTEREARNINGSRATE)
    }
    static func Marketing(_ rate: Decimal) -> Xero.EarningsLine {
        guard let eRate = Xero.EarningsRate.NameMap["Marketing"]?.EarningsRateID
        else { fatalError() }
        return Xero.EarningsLine(EarningsRateID: eRate, RatePerUnit: rate,  CalculationType: .ENTEREARNINGSRATE)
    }
    static func MarkingPPF() -> Xero.EarningsLine {
        guard let eRate = Xero.EarningsRate.NameMap["Marking PPF"]?.EarningsRateID
        else { fatalError() }
        return Xero.EarningsLine(EarningsRateID: eRate, CalculationType: .ENTEREARNINGSRATE)
    }
}
extension Xero.EarningsLine: CustomStringConvertible {
    public var description: String {
        var text: String = "("
        if let EarningsRateID { text += "ID: \(EarningsRateID)" }
        if let RatePerUnit { text += ", RatePerUnit: \(RatePerUnit)" }
        if let NumberOfUnits { text += ", NumberOfUnits: \(NumberOfUnits)" }
        if let FixedAmount { text += ", FixedAmount: \(FixedAmount)" }
        if let LumpSumETaxYear { text += ", LumpSumETaxYear: \(LumpSumETaxYear)" }
        if let CalculationType { text += ", CalculationType: \(CalculationType)" }
        if let NumberOfUnitsPerWeek { text += ", NumberOfUnitsPerWeek: \(NumberOfUnitsPerWeek)" }
        if let AnnualSalary { text += ", AnnualSalary: \(AnnualSalary)" }
        if let NormalNumberOfUnits { text += ", NormalNumberOfUnits: \(NormalNumberOfUnits)" }
        text += ")"
        return text
    }
}
extension Xero.EarningsLine: Equatable {
    public static func == (lhs: Xero.EarningsLine, rhs: Xero.EarningsLine) -> Bool {
        lhs.EarningsRateID == rhs.EarningsRateID
        && lhs.RatePerUnit == rhs.RatePerUnit
        && lhs.NumberOfUnits == rhs.NumberOfUnits
    }
}
