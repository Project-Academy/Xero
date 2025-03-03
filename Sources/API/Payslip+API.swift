//
//  Payslip+API.swift
//  Dashboard
//
//  Created by Sarfraz Basha on 16/2/2025.
//

import Foundation
import Presto

//--------------------------------------
// MARK: - CALLS -
//--------------------------------------
extension Xero.Payslip {
    
    ///
    public static func fetchSlip(ID: String) async throws -> Xero.Payslip? {
        
        let url = Xero.Payroll.Payslip.url?.appending(path: "/\(ID)")
        let request = Xero.Payroll.Payslip.GET.url(url)
        let response: Response = try await Xero.send(request)
        
        return response.Payslip
    }
    
    ///
    public static func update(ID: String?, with earningsLines: Xero.EarningsLines) async throws -> Xero.Payslip? {
        
        guard let ID else { fatalError("No PayslipID found.") }
        
//        let dataString = """
//[{
//      "EarningsLines": [
//          {
//          "EarningsRateID": "f476eb50-b046-4cc3-869e-1ef20001129f",
//          "RatePerUnit": 60,
//          "NumberOfUnits": 12
//          }
//      ]
//}]
//"""
//        let data = dataString.data(using: .utf8)!
        
        let url = Xero.Payroll.Payslip.url?.appending(path: "/\(ID)")
        let request = Xero.Payroll.Payslip.POST.url(url)
            .paramsArray(["EarningsLines": earningsLines.compactMap(\.json)])
        
        let response: Response = try await Xero.send(request)
        return response.Payslip
    }
    
}
//--------------------------------------
// MARK: - RESPONSE -
//--------------------------------------
extension Xero.Payslip {
    public struct Response: Decodable, Xero.Response {
        public var Payslip: Xero.Payslip?
        public var Id:             String?
        public var Status:         String?
        public var ProviderName:   String?
        public var DateTimeUTC:    String?
    }
}
fileprivate extension REST {
    func bodyData(data: Data) -> REST {
        var req = self.request
        req.httpBody = data
        return REST(req)
    }
}
