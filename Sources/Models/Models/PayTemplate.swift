//
//  PayTemplate.swift
//  Dashboard
//
//  Created by Sarfraz Basha on 17/2/2025.
//

import Foundation

extension Xero {
    public struct PayTemplate: Codable {
        var EarningsLines: EarningsLines?
//        var DeductionLines: DeductionLines?
        var SuperLines: SuperLines?
//        var ReimbursementLines: ReimbursementLines?
//        var LeaveLines: LeaveLines?
    }
}
