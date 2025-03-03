//
//  StringDate.swift
//  Xero
//
//  Created by Sarfraz Basha on 3/3/2025.
//

import Foundation

@propertyWrapper
public struct StringDate: Codable, Equatable, CustomStringConvertible {
    
    public var wrappedValue: Date?
    public init(wrappedValue: Date?) {
        self.wrappedValue = wrappedValue
    }
    var value: String? {
        set { wrappedValue = Date(newValue) }
        get {
            guard let date = wrappedValue else { return nil }
            // Normalize the date so that only the calendar day is used.
            let normalizedDate = date.APINormalized
            let unixMillis = Int(normalizedDate.timeIntervalSince1970 * 1000)
            return "/Date(\(unixMillis)+0000)/"
        }
    }
    // Add a projectedValue so you can access the string representation externally
    public var projectedValue: String? { value }
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        value = try container.decode(String?.self)
      }
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value)
    }
    public var description: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
        if let date = wrappedValue {
            return dateFormatter.string(from: date)
        } else { return "No Date" }
    }
}
//--------------------------------------
// MARK: - HANDLE NIL KEYS -
//--------------------------------------
extension KeyedDecodingContainer {
  func decode(_ type: StringDate.Type, forKey key: Key) throws -> StringDate {
    try decodeIfPresent(type, forKey: key) ?? StringDate(wrappedValue: nil)
  }
}
public typealias UnixTimestamp = Int
public extension Date {
    /// Date to Unix timestamp.
    var unix: UnixTimestamp {
        UnixTimestamp(self.timeIntervalSince1970)
    }
}
fileprivate extension Date {
    /// Initialize from an API string, and normalize to midnight UTC.
    /// This is for formatting Dates from Xero (which are in the format "/Date(1736121600000+0000)/")
    init?(_ dateString: String?) {
        guard let dateString,
              let index1 = dateString.firstIndex(of: "("),
              let index2 = dateString.firstIndex(where: { $0 == "+" || $0 == "-" }),
              let _ = dateString.firstIndex(of: ")")
        else { return nil }
        
        let millis = dateString[dateString.index(after: index1)..<index2]
        guard let milliseconds = Double(millis)
        else { return nil }
        
        let seconds = milliseconds / 1000.0
        let date = Date(timeIntervalSince1970: seconds)
        // Normalize to ensure we only keep the calendar day.
        self = date
    }
}
public extension Date {
    /// - returns: a new Date that represents the same calendar day as self,
    /// using the device’s local time zone for component extraction,
    /// but normalized to midnight in UTC.
    var APINormalized: Date {
        let calendar = Calendar(identifier: .gregorian)
        // Extract the components in the local time zone.
        let localComponents = calendar.dateComponents(in: TimeZone.current, from: self)
        // Now create a new date from those components in UTC.
        var utcCalendar = calendar
        utcCalendar.timeZone = TimeZone(secondsFromGMT: 0)!
        // We only care about year, month, and day.
        let normalizedDate = utcCalendar.date(from: DateComponents(
            year: localComponents.year,
            month: localComponents.month,
            day: localComponents.day
        ))!
        return normalizedDate
    }
}
