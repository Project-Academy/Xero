//
//  SuperFunds+API.swift
//  Dashboard
//
//  Created by Sarfraz Basha on 17/2/2025.
//

import Foundation

//--------------------------------------
// MARK: - CALLS -
//--------------------------------------
extension Xero.SuperFund {
    
    /// Fetches all PayRuns on Xero.
    /// - warning: FIX FIX FIX Returns a maximum of 100 results.
    public static func fetchAll() async throws -> [Xero.SuperFund]? {
        let request = Xero.Payroll.SuperFunds.GET
        let response: Response = try await Xero.send(request)
        
        // Do further processing here
        
        return response.SuperFunds
    }
    
    public func create() async throws -> Xero.SuperFund? {
        guard let json else { return nil }
        let request = Xero.Payroll.SuperFunds.POST
            .paramsArray(json)
        let response: Response = try await Xero.send(request)
        
        // Do further processing here
        guard let funds = response.SuperFunds,
              funds.count == 1,
              let superFund = funds.first
        else { return nil }
        return superFund
    }
    
}
//--------------------------------------
// MARK: - RESPONSE -
//--------------------------------------
extension Xero.SuperFund {
    public struct Response: Decodable, Xero.Response {
        public var SuperFunds: Array<Xero.SuperFund>?
        public var Id:             String?
        public var Status:         String?
        public var ProviderName:   String?
        public var DateTimeUTC:    String?
    }
}
