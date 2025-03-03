//
//  PayRuns+API.swift
//  Dashboard
//
//  Created by Sarfraz Basha on 15/2/2025.
//

import Foundation

//--------------------------------------
// MARK: - CALLS -
//--------------------------------------
extension Xero.PayRun {
    
    /// Fetches all PayRuns on Xero.
    /// - warning: FIX FIX FIX Returns a maximum of 100 results.
    public static func fetchAll() async throws -> [Xero.PayRun]? {
        
        let req = Xero.Payroll.PayRuns.GET
        let resp: Response = try await Xero.send(req)
        
        // TODO: Account for Limit
        // All Xero fetches have a limit of 100 results.
        // There may be more than 100 PayRuns.
        // Refactor this code to account for more than 100 results.
        
        // Do further processing here.
        
        return resp.PayRuns
    }
    
    /// Fetches the PayRun matching the provided ID.
    public static func fetch(ID: String?) async throws -> Xero.PayRun? {
        
        guard let ID else { return nil }
        let url = Xero.Payroll.PayRuns.url?.appending(path: "/\(ID)")
        let req = Xero.Payroll.PayRuns.GET.url(url)
        let resp: Response = try await Xero.send(req)
        
        guard let payRuns = resp.PayRuns,
              payRuns.count == 1
        else {
            // TODO: THROW APPROPRIATE ERROR.
            fatalError()
        }
        
        return payRuns.first
    }
    
    /// Fetches all PayRuns that have a DRAFT status.
    public static func fetchDrafts() async throws -> [Xero.PayRun]? {
        
        var filter = URLComponents(string: Xero.Payroll.PayRuns.url!.absoluteString)!
        filter.queryItems = [
            .init(name: "where", value: "PayRunStatus==\"DRAFT\"")
        ]
        let req = Xero.Payroll.PayRuns.GET.url(filter.url)
        let resp: Response = try await Xero.send(req)
        
        guard let payRuns = resp.PayRuns,
              payRuns.count > 0
        else { return nil }
        return payRuns
    }
    
    ///
    public static func createPayRun(payrollCalendarID ID: String) async throws -> Xero.PayRun? {
        
        let request = Xero.Payroll.PayRuns.POST
            .paramsArray(["PayrollCalendarID": ID])
        let response: Response = try await Xero.send(request)
        
        guard let payRuns = response.PayRuns,
              payRuns.count == 1
        else {
            // TODO: THROW APPROPRIATE ERROR.
            fatalError()
        }
        
        return payRuns.first!
//        return nil
        
    }
    
}
//--------------------------------------
// MARK: - RESPONSE -
//--------------------------------------
extension Xero.PayRun {
    public struct Response: Decodable, Xero.Response {
        public var PayRuns: Array<Xero.PayRun>?
        public var Id:             String?
        public var Status:         String?
        public var ProviderName:   String?
        public var DateTimeUTC:    String?
    }
}
