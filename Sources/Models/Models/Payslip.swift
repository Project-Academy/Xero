//
//  Payslip.swift
//  Dashboard
//
//  Created by Sarfraz Basha on 15/2/2025.
//

import Foundation

extension Xero {
    public struct Payslip: Codable {
        
        //--------------------------------------
        // MARK: - VARIABLES -
        //--------------------------------------
        /// Unique Identifiter for this Payslip
        public var PayslipID:              String?
        /// Unique Identifier for the Employee
        public var EmployeeID:             String?
        public var FirstName:              String?
        public var LastName:               String?
        public var EmployeeGroup:          String?
        
        //--------------------------------------
        // MARK: - LINE ITEMS -
        //--------------------------------------
        public var EarningsLines:          EarningsLines?
        
//        var TimesheetEarningsLines: Array<TimesheetEarningsLine>?
//        var DeductionLines:         Array<DeductionLine>?
//        var LeaveEarningsLines:     Array<LeaveEarningsLine>?
//        var LeaveAccrualLines:      Array<LeaveAccrualLine>?
//        var ReimbursementLines:     Array<ReimbursementLine>?
//        var SuperannuationLines:    Array<SuperannuationLine>?
//        var TaxLines:               Array<TaxLine>?
        
        //--------------------------------------
        // MARK: - SUMMARY -
        //--------------------------------------
        public var Wages:                  Double?
        public var Deductions:             Double?
        public var Tax:                    Double?
        public var Super:                  Double?
        public var Reimbursements:         Double?

        public var NetPay:                 Double?

//        @StringDate
//        var LastEdited:             Date?
        @StringDate
        var UpdatedDateUTC:         Date?
        
    }
}
