//
//  PayrollCalendar.swift
//  Dashboard
//
//  Created by Sarfraz Basha on 15/2/2025.
//

import Foundation

extension Xero {
    public struct PayrollCalendar: Codable {
        
        /// Name of the Payroll Calendar
        public var Name:                           String?
        /// Unique Identifier for this Payroll Calendar
        public var PayrollCalendarID:              String?
        /// An enum describing the frequency of payments
        public var CalendarType:                   CalendarType?
        
        
        /// The start date of the upcoming pay period.
        /// - note: if a draft payrun exists for this calendar, this value will show the StartDate of what the next non-draft instance would be.
        @StringDate
        public var StartDate:          Date?
        /// The date on which employees will be paid for the upcoming pay period.
        @StringDate
        public var PaymentDate:        Date?
        /// The start date of the first pay period for the calendar.
        @StringDate
        public var ReferenceDate:      Date?
        @StringDate var UpdatedDateUTC:     Date?
        
        
        static public let Group1: String = "7c74461d-ba91-4260-9e6a-7654ae94e048"
        static public let Group2: String = "c1a37522-bad9-4e2a-8b88-0d3895ebabad"
        
    }
}

//--------------------------------------
// MARK: - CALENDAR TYPE -
//--------------------------------------
extension Xero.PayrollCalendar {
    public enum CalendarType: String, Codable, CustomStringConvertible {
        case WEEKLY, FORTNIGHTLY, FOURWEEKLY, MONTHLY, TWICEMONTHLY, QUARTERLY
        
        public var description: String { rawValue.capitalized }
    }
}


