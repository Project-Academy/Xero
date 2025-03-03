//
//  Xero-Response.swift
//  Sidekick
//
//  Created by Sarfraz Basha on 7/5/2024.
//

import Foundation

extension Xero {
    public protocol Response {
        var Id:             String? { get set }
        var Status:         String? { get set }
        var ProviderName:   String? { get set }
        var DateTimeUTC:    String? { get set }
    }
}
