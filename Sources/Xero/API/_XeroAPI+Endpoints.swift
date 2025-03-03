//
//  XeroAPI+Endpoints.swift
//  Dashboard
//
//  Created by Sarfraz Basha on 15/2/2025.
//

import Foundation
import Presto

internal extension Xero {
    
    /*
     Endpoints should always remain private/internal.
     Functions that need to access these endpoints should be written and placed
     inside the relevant objects e.g. Payslip, PayRun, PayrollCalendar etc.
     */
    
    //--------------------------------------
    // MARK: - PAYROLL ENDPOINTS -
    //--------------------------------------
    enum Payroll: String, Codable, Xero.Endpoints {
        case PayrollCalendars
        case PayRuns
        case Payslip
        case PayItems
        case Employees
        case SuperFunds
    }
    
    
}
//--------------------------------------
// MARK: - ENDPOINT IMPLEMENTATION -
//--------------------------------------
extension Xero {
    protocol Endpoints: Endpoint {}
}
extension Xero.Endpoints {
    static var baseURL: String { "https://api.xero.com/payroll.xro/1.0" }
    var url: URL? { URL(string: "\(Self.baseURL)/\(rawValue)") }
}
