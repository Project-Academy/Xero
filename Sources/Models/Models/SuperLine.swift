//
//  SuperLine.swift
//  Dashboard
//
//  Created by Sarfraz Basha on 17/2/2025.
//

import Foundation

extension Xero {
    public typealias SuperLines = Array<SuperLine>
    public struct SuperLine: Codable {
        /// Xero superannuation fund membership identifier
        public var SuperMembershipID: String?
        public var ContributionType: ContributionType?
        public var CalculationType: CalculationType?
        /// Account code for the Expense Account
        public var ExpenseAccountCode: String?
        /// Account code for the Liability Account
        public var LiabilityAccountCode: String?
        /// The percentage of the SuperLine. Applies on Percentage of Earnings CalculationType.
        public var Percentage: Double?
        
        //--------------------------------------
        // MARK: - DEPRECATED VARS -
        //--------------------------------------
        /// Minimum monthly earnings. Applies for Percentage of Earnings calculation type only.
        /// This field has been deprecated.
        /// It will only apply to Pay Runs with a payment date prior to 1st July 2022.
        @available(*, deprecated, message: "This field has been deprecated. It will only apply to Pay Runs with a payment date prior to 1st July 2022.")
        private var MinimumMonthlyEarnings: Double?
    }
}
extension Xero.SuperLine {
    public enum ContributionType: String, Codable {
        /// Mandatory employer contribution
        case SGC
        /// Pre-tax reportable employer superannuation contribution, which is displayed separately on payment summaries
        case SALARYSACRIFICE
        /// Additional employer superannuation contribution, which is displayed as RESC on payment summaries
        case EMPLOYERADDITIONAL
        /// Post-tax employee superannuation contribution
        case EMPLOYEE
    }
}
extension Xero.SuperLine {
    public enum CalculationType: String, Codable {
        /// For voluntary superannuation, the contribution amount can be a fixed rate or a percentage of earnings.
        /// For SGC contributions it must be a percentage
        case FIXEDAMOUNT
        case PERCENTAGEOFEARNINGS
        case STATUTORY
    }
}
extension Xero.SuperLine {
    public static func StatutorySuper(membershipID: String?) -> Xero.SuperLine {
        Xero.SuperLine(SuperMembershipID: membershipID,
                       ContributionType: .SGC,
                       CalculationType: .STATUTORY,
                       ExpenseAccountCode: "Wages S",
                       LiabilityAccountCode: "Wages S P")
    }
}
