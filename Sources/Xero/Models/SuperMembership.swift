//
//  SuperMembership.swift
//  Dashboard
//
//  Created by Sarfraz Basha on 17/2/2025.
//

import Foundation

extension Xero {
    public struct SuperMembership: Codable {
        public var SuperMembershipID:   String?
        public var SuperFundID:         String?
        public var EmployeeNumber:      String?
        
        public static let AusSuperFundID: String = "89fdb5a5-d22c-4c3b-9a5f-497481bb7dc3"
    }
}
extension Xero.SuperMembership {
    public static func AusSuper(withID ID: String) -> Xero.SuperMembership {
        Xero.SuperMembership(SuperFundID: AusSuperFundID, EmployeeNumber: ID)
    }
}
