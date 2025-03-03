//
//  Xero-Access.swift
//  Sidekick
//
//  Created by Sarfraz Basha on 5/5/2024.
//

import Foundation
import Presto

//--------------------------------------
// MARK: - ACCESS TOKEN -
//--------------------------------------
extension Xero {
    public struct Access {
        public static var token: String?
    }
}
//--------------------------------------
// MARK: - HELPERS -
//--------------------------------------
extension Xero.Access {
    private typealias TokenTask = Task<Response, Error>
    private static var _task:   TokenTask?
    private static var _timer:  Timer?
    @discardableResult
    internal static func getToken() async throws -> String {
        
        // Check for Task (prevent double fetching)
        if let _task { return try await _task.value.access_token }
        
        print("Fetching new Xero Token")
        // Create Task + Reset Timer
        _timer?.invalidate(); _timer = nil
        _task = Task {
            let _url = "https://identity.xero.com/connect/token"
            guard let clientID  = Xero.ClientID,
                  let cSecret   = Xero.CliSecret,
                  let url       = URL(string: _url)
            else { throw PrestoError(name: "Invalid Secrets", nil) }
            let utf = "\(clientID):\(cSecret)".utf8
            let key = "Basic " + Data(utf).base64EncodedString()
            
            let request = REST.POST
                .url(url)
                .auth(key)
                .content(type: .Form)
                .params(["grant_type":"client_credentials",
                         "scope": scopes.join()],
                        type: .Form)
            let response: Response = try await Xero.send(request)
            return response
        }
        
        // Await Response
        let resp = try await _task!.value
        
        // Update Token
        token = resp.access_token
        guard let token else { fatalError() }
        
        // Remove Task
        _task = nil
        
        // Create Timer
        let timeInt = TimeInterval(resp.expires_in)
        _timer = .scheduledTimer(withTimeInterval: timeInt, repeats: false) { _ in self.token = nil }
        
        return token
    }
    static let scopes = [
        "payroll.employees",
        "payroll.payruns",
        "payroll.payslip",
        "payroll.settings",
        "payroll.timesheets"
    ]
}
//--------------------------------------
// MARK: - RESPONSE -
//--------------------------------------
extension Xero.Access {
    struct Response: Decodable, Equatable {
        var expires_in:     Int
        var access_token:   String
        var token_type:     String
        var scope:          String
    }
}
