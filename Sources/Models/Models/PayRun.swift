//
//  PayRun.swift
//  Dashboard
//
//  Created by Sarfraz Basha on 15/2/2025.
//

import Foundation

extension Xero {
    public struct PayRun: Codable {
        
        //--------------------------------------
        // MARK: - VARIABLES -
        //--------------------------------------
        /// Unique Identifiter for this PayRun
        public var PayRunID:               String?
        /// Payroll Calendar for this PayRun
        public var PayrollCalendarID:      String?
        /// PayRun Status. Either "DRAFT", or "POSTED"
        public var PayRunStatus:           Status?
        /// Payment Date for the PayRun
        @StringDate
        public var PaymentDate:            Date?
        /// Period Start Date for the PayRun
        @StringDate
        public var PayRunPeriodStartDate:  Date?
        /// Period End Date for the PayRun
        @StringDate
        public var PayRunPeriodEndDate:    Date?
        /// Payslip message for the PayRun
        public var PayslipMessage:         String?
        
        //--------------------------------------
        // MARK: - TOTALS -
        //--------------------------------------
        /// Total Wages for the PayRun
        public var Wages:                  Double?
        /// Total Deductions for the PayRun
        public var Deductions:             Double?
        /// Total Tax for the PayRun
        public var Tax:                    Double?
        /// Total Super for the PayRun
        public var Super:                  Double?
        /// Total Reimbursement for the PayRun
        public var Reimbursement:          Double?
        /// Total NetPay for the PayRun
        public var NetPay:                 Double?
        
        /// Array of Payslips included in this PayRun.
        /// - note: this field is ONLY populated when fetching a specific PayRun.
        var Payslips:               Array<Payslip>?
        
        
        @StringDate
        var UpdatedDateUTC:         Date?
    }
}

//--------------------------------------
// MARK: - CALENDAR TYPE -
//--------------------------------------
extension Xero.PayRun {
    public enum Status: String, Codable {
        case DRAFT, POSTED
    }
}
