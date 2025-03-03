//
//  PayrollCalendars+API.swift
//  Dashboard
//
//  Created by Sarfraz Basha on 15/2/2025.
//

import Foundation

//--------------------------------------
// MARK: - CALLS -
//--------------------------------------
extension Xero.PayrollCalendar {
    
    /// Fetches all PayRuns on Xero.
    /// - warning: FIX FIX FIX Returns a maximum of 100 results.
    public static func fetchAll() async throws -> [Xero.PayrollCalendar]? {
        let request = Xero.Payroll.PayrollCalendars.GET
        let response: Response = try await Xero.send(request)
        
        // Do further processing here
        
        return response.PayrollCalendars
    }
    
}
//--------------------------------------
// MARK: - RESPONSE -
//--------------------------------------
extension Xero.PayrollCalendar {
    public struct Response: Decodable, Xero.Response {
        public var PayrollCalendars: Array<Xero.PayrollCalendar>?
        public var Id:             String?
        public var Status:         String?
        public var ProviderName:   String?
        public var DateTimeUTC:    String?
    }
}
