//
//  PayItems+API.swift
//  Dashboard
//
//  Created by Sarfraz Basha on 16/2/2025.
//

import Foundation

//--------------------------------------
// MARK: - CALLS -
//--------------------------------------
extension Xero.PayItems {
    
    /// Fetches all PayItems on Xero, and saves the EarningsRates to a dictionary.
    @discardableResult
    public static func getAll() async throws -> Xero.PayItems? {
        
        let request = Xero.Payroll.PayItems.GET
        let response: Response = try await Xero.send(request)

        // Save to Preferences.
        if let earningsRates = response.PayItems?.EarningsRates {
            let all = earningsRates.filter {
                $0.EarningsRateID != nil && $0.CurrentRecord == true
            }
            Xero.EarningsRate.All = all
            let values = all.compactMap { ($0.EarningsRateID!, $0) }
            let map = Dictionary(uniqueKeysWithValues: values)
            Xero.EarningsRate.Map = map
            
            let names = all.compactMap { ($0.Name!, $0) }
            let nameMap = Dictionary(uniqueKeysWithValues: names)
            Xero.EarningsRate.NameMap = nameMap
        }
        
        return response.PayItems
    }
    
}
//--------------------------------------
// MARK: - RESPONSE -
//--------------------------------------
extension Xero.PayItems {
    public struct Response: Decodable, Xero.Response {
        public var PayItems: Xero.PayItems?
        public var Id:             String?
        public var Status:         String?
        public var ProviderName:   String?
        public var DateTimeUTC:    String?
    }
}
