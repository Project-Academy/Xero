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
        var PayslipID:              String?
        /// Unique Identifier for the Employee
        var EmployeeID:             String?
        var FirstName:              String?
        var LastName:               String?
        var EmployeeGroup:          String?
        
        //--------------------------------------
        // MARK: - LINE ITEMS -
        //--------------------------------------
        var EarningsLines:          EarningsLines?
        
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
        var Wages:                  Double?
        var Deductions:             Double?
        var Tax:                    Double?
        var Super:                  Double?
        var Reimbursements:         Double?

        var NetPay:                 Double?

//        @StringDate
//        var LastEdited:             Date?
        @StringDate
        var UpdatedDateUTC:         Date?
        
    }
}
