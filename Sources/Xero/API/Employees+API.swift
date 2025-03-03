//
//  Employees+API.swift
//  Dashboard
//
//  Created by Sarfraz Basha on 16/2/2025.
//

import Foundation
import Presto

//--------------------------------------
// MARK: - CALLS -
//--------------------------------------
extension Xero.Employee {
    
    /// Fetches all Employees on Xero
    @discardableResult
    public static func getAll() async throws -> Array<Xero.Employee>? {
        
        let request = Xero.Payroll.Employees.GET
        let response: Response = try await Xero.send(request)
        return response.Employees
        
    }
    
    public static func get(ID: String?) async throws -> Xero.Employee? {
        
        guard let ID else { return nil }
        let url = Xero.Payroll.Employees.url?.appending(path: "/\(ID)")
        let request = Xero.Payroll.Employees.GET.url(url)
        let response: Response = try await Xero.send(request)
        
        guard let employees = response.Employees,
              employees.count == 1,
              let employee = employees.first
        else { return nil }
        return employee
        
    }
    
    public func createOnXero() async throws -> Xero.Employee? {
        
        guard let json else { return nil }
        let request = Xero.Payroll.Employees.POST
            .paramsArray(json)
        let response: Response = try await Xero.send(request)
        
        guard let employees = response.Employees,
              employees.count == 1,
              let employee = employees.first
        else { return nil }
        
        return employee
    }
    
    public static func update(_ employee: Xero.Employee?) async throws -> Xero.Employee? {
        guard let json = employee?.json else { return nil }
        
        let request = Xero.Payroll.Employees.POST
            .paramsArray(json)
        let response: Response = try await Xero.send(request)
        
        guard let employees = response.Employees,
              employees.count == 1,
              let employee = employees.first
        else { return nil }
        
        return employee
        
    }
    
}
//--------------------------------------
// MARK: - RESPONSE -
//--------------------------------------
extension Xero.Employee {
    public struct Response: Decodable, Xero.Response {
        public var Employees: Array<Xero.Employee>?
        public var Id:             String?
        public var Status:         String?
        public var ProviderName:   String?
        public var DateTimeUTC:    String?
    }
    
    
}
