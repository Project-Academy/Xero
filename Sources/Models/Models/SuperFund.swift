//
//  SuperFund.swift
//  Dashboard
//
//  Created by Sarfraz Basha on 17/2/2025.
//

import Foundation
import PKPrefs

extension Xero {
    public struct SuperFund: Codable {
        //--------------------------------------
        // MARK: - COMMON VARIABLES -
        //--------------------------------------
        /// Xero identifier
        public var SuperFundID: String?
        /// Name of the super fund
        public var Name: String?
        public var `Type`: SuperFundType?
        /// ABN of the self managed super fund OR Regulated SuperFund
        public var ABN: String?
        /// Some funds assign a unique number to each employer
        public var EmployerNumber: String?
        
        //--------------------------------------
        // MARK: - SMSF VARIABLES -
        //--------------------------------------
        /// The account name for the self managed super fund
        public var AccountName: String?
        /// The electronic service address for the self managed super fund
        public var ElectronicServiceAddress: String?
        /// BSB of the self managed super fund.
        public var BSB: String?
        /// The account number for the self managed super fund.
        public var AccountNumber: String?
        
        //--------------------------------------
        // MARK: - REGULATED SUPER VARS -
        //--------------------------------------
        /// The USI of the Regulated SuperFund
        public var USI: String?
        
        //--------------------------------------
        // MARK: - DEPRECATED VARS -
        //--------------------------------------
        /// The SPIN of the Regulated SuperFund. This field has been deprecated.
        /// It will only be present for legacy superfunds.
        /// New superfunds will not have a SPIN value.
        /// The USI field should be used instead of SPIN
        var SPIN: String?
        
        @Prefs("SuperFundsList")
        public static var List: [SuperFund] = []
    }
}
extension Xero.SuperFund {
    public enum SuperFundType: String, Codable {
        case REGULATED
        case SMSF
    }
}
