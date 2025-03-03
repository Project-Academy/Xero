//
//  Xero+Secrets.swift
//  Xero
//
//  Created by Sarfraz Basha on 3/3/2025.
//

import Foundation
import PKAppInfo

internal extension Xero {
    
    struct Secrets {
        public var APIURL:          String
        public var ClientID:        String
        public var ClientSecret:    String
        
        init?(from dict: Dictionary<String, Any>?) {
            guard let dict,
                  let xero = dict["Xero"] as? Dictionary<String, Any>,
                  let APIURL          = xero["APIURL"] as? String,
                  let ClientID        = xero["ClientID"] as? String,
                  let ClientSecret    = xero["ClientSecret"] as? String
            else { return nil }
            
            self.APIURL          = APIURL
            self.ClientID        = ClientID
            self.ClientSecret    = ClientSecret
        }
    }
    
}
