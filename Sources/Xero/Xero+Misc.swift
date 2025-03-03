//
//  Xero+Misc.swift
//  Xero
//
//  Created by Sarfraz Basha on 3/3/2025.
//

import Foundation

extension Encodable {
    
    /// Converting object to postable dictionary
    public func toDictionary(_ encoder: JSONEncoder = JSONEncoder()) throws -> [String: Any] {
        let data = try encoder.encode(self)
        let object = try JSONSerialization.jsonObject(with: data)
        if let json = object as? [String: Any]  { return json }
        
        let context = DecodingError.Context(codingPath: [], debugDescription: "Deserialized object is not a dictionary")
        throw DecodingError.typeMismatch(type(of: object), context)
    }
    
    /// Converting object to postable JSON
    public var json: Dictionary<String, Any>? {
        guard let data = try? JSONEncoder().encode(self),
              let object = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
              let json = object as? [String: Any] else { return nil }
        return json
    }
}
extension Array where Element == String {
    public func join(sep: String = " ") -> String {
        self.joined(separator: sep)
    }
}
