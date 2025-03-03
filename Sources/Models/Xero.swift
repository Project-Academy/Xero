//
//  Xero.swift
//  Dashboard
//
//  Created by Sarfraz Basha on 15/2/2025.
//

import Foundation
import Presto
import PKAppInfo


public struct Xero: Presto {
    public static func response(_ req: REST) async throws -> REST.Response {
        
        // Access Token requests are already auth'd.
        guard req.request.value(forHTTPHeaderField: "Authorization") == nil
        else { return try await REST.send(req) }
        
        // Check Token
        guard let token = Xero.Access.token
        else {
            // Refresh Token & Re-try.
            try await Xero.Access.getToken()
            return try await response(req)
        }
        
        // Authorise Request + Send
        let request = req.auth("Bearer " + token)
        return try await REST.send(request)
    }
    public static func send(_ req: REST) async throws -> JSON {
        
        // Await Response
        let response = try await response(req)
        
        // Check Day Limit
        let limitKey = Headers.DayLimitRemaining
        if let remaining = response.header(forKey: limitKey) as? String {
            if Decimal(string: remaining) ?? 9999 < 1500 {
                print("Remaining Calls Left Today: \(remaining)")
            }
        }
        
        // Status Code
        // Successful Responses receive a code of 200.
        // Unsuccessful Responses have a code of 400 or higher.
        guard let statusCode = response.http?.statusCode
        else {
            // TODO: HANDLE THIS ERROR
            fatalError()
        }
        
        if statusCode != 200 {
            print("Status Code:", statusCode, response.json)
            switch statusCode {
            case 429:
                let retryKey = Headers.RetryAfter
                if let retryAfter = response.header(forKey: retryKey) as? String,
                   let seconds = Int(retryAfter) {
                    print("Hit Rate Limit, automatically retrying in \(retryAfter) seconds.")
                    try await Task.sleep(for: .seconds(seconds))
                    return try await send(req)
                }
            default: break
            }
        }
        
        return response.json
    }
}

extension Xero {
    struct Headers {
        static let DayLimitRemaining = "x-daylimit-remaining"
        static let RetryAfter = "retry-after"
    }
}

extension Xero {
    internal static var secrets:    Secrets? { Secrets(from: Info.secrets) }
    internal static var APIURL:     String? { secrets?.APIURL }
    internal static var ClientID:   String? { secrets?.ClientID }
    internal static var CliSecret:  String? { secrets?.ClientSecret }
}


