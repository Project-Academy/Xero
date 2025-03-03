//
//  Employee.swift
//  Dashboard
//
//  Created by Sarfraz Basha on 16/2/2025.
//

import Foundation

extension Xero {
    public struct Employee: Codable {
        
        //--------------------------------------
        // MARK: - PERSONAL DETAILS -
        //--------------------------------------
        public var Title:                       String?
        /// First name of employee
        public var FirstName:                   String?
        /// Middle name(s) of the employee (max length = 35)
        public var MiddleNames:                 String?
        /// Last name of employee
        public var LastName:                    String?
        /// Date of birth of the employee
        @StringDate
        public var DateOfBirth:                 Date?
        /// The employee’s gender.
        ///
        /// Possible values are `M`, `F`, `I` (Non-Binary) or `N` (Not Stated)
        public var Gender:                      Gender?
        
        //--------------------------------------
        // MARK: - CONTACT DETAILS -
        //--------------------------------------
        /// Employee home address
        public var HomeAddress:                 Address?
        /// The email address for the employee (max length = 100)
        public var Email:                       String?
        /// Employee phone number (max length = 50)
        public var Phone:                       String?
        /// Employee mobile number (max length = 50)
        public var Mobile:                      String?
        
        //--------------------------------------
        // MARK: - EMPLOYMENT DETAILS -
        //--------------------------------------
        public var EmployeeID:                  String?
        public var JobTitle:                    String?
        public var Classification:              String?
        public var OrdinaryEarningsRateID:      String?
        public var PayrollCalendarID:           String?
        public var EmployeeGroupName:           String?
        public var Status:                      Status?
        @StringDate
        public var StartDate:                   Date?
        @StringDate
        public var TerminationDate:             Date?
        public var TerminationReason:           TerminationReason?
        
        //--------------------------------------
        // MARK: - BANKING, TAX, SUPER -
        //--------------------------------------
        public var BankAccounts:                Array<BankAccount>?
        public var TaxDeclaration:              TaxDeclaration?
        public var PayTemplate:                 PayTemplate?
        public var SuperMemberships:            Array<SuperMembership>?

        public var IncomeType:                  IncomeType?
        public var EmploymentType:              EmploymentType?
        
        
        
        //--------------------------------------
        // MARK: - OTHER VARIABLES -
        //--------------------------------------
        /// Employee’s twitter name, entered as @twittername (max length = 50)
        var TwitterUserName:                    String?
        var IsAuthorisedToApproveLeave:         Bool?
        var IsAuthorisedToApproveTimesheets:    Bool?
        var IsSTP2Qualified:                    Bool?
        var CountryOfResidence:                 String?
//        var OpeningBalances:                    OpeningBalances?
//        var LeaveBalances:                      LeaveBalances?
        
        
        @StringDate
        public var UpdatedDateUTC:              Date?
    }
}
extension Xero.Employee {
    public struct Address: Codable {
        /// Address line 1 for employee home address
        public var AddressLine1:    String?
        /// Address line 2 for employee home address
        public var AddressLine2:    String?
        /// Suburb for employee home address
        public var City:            String?
        /// State abbreviation for employee home address
        public var Region:          AusState?
        /// Postcode for employee home address
        public var PostalCode:      String?
        /// Country of HomeAddress
        /// "AUSTRALIA"
        public var Country:         String?
    }
    
}
extension Xero.Employee.Address {
    public enum AusState: String, Codable {
        case ACT, NSW, NT, QLD, SA, TAS, VIC, WA
    }
}
extension Xero.Employee {
    public enum Gender: String, Codable {
        /// Not stated
        case N
        /// Male
        case M
        /// Female
        case F
        /// Non-Binary
        case I
    }
}
extension Xero.Employee {
    public struct BankAccount: Codable {
        /// The text that will appear on your employee's bank statement when they receive payment
        public var StatementText:   String?
        /// The name of the account
        public var AccountName:     String?
        /// The BSB number of the account
        public var BSB:             String?
        /// The account number
        public var AccountNumber:   String?
        /// If this account is the Remaining bank account
        public var Remainder:       Bool?
        /// Fixed amounts (for example, if an employee wants to have $100 of
        /// their salary transferred to one account, and the remaining amount
        /// to another)
        public var Amount:          Double?
        
    }
}
extension Xero.Employee {
    public init(FirstName: String, LastName: String, DateOfBirth: Date, HomeAddress: Address) {
        self.FirstName      = FirstName
        self.LastName       = LastName
        self.DateOfBirth    = DateOfBirth
        self.HomeAddress    = HomeAddress
    }
}
extension Xero.Employee {
    public enum Status: String, Codable {
        /// Employee with no Termination Date.
        case ACTIVE
        /// Employee with a Termination Date.
        case TERMINATED
    }
}
extension Xero.Employee {
    public enum EmploymentType: String, Codable {
        case EMPLOYEE
        case CONTRACTOR
    }
}
extension Xero.Employee {
    public enum IncomeType: String, Codable {
        case SALARYANDWAGES
        case WORKINGHOLIDAYMAKER
        case NONEMPLOYEE
        case CLOSELYHELDPAYEES
        case LABOURHIRE
    }
}
extension Xero.Employee {
    /// This is a new field which will be supported as of STP Phase 2 enablement for an organisation.
    /// If the TFN exemption is NOTQUOTED, this field may not be set.
    /// Additionally, if ApprovedWithholdingVariationPercentage is set, this field may not be set.
    /// Otherwise, this field must be set in order for an employee to be payable under STP Phase 2.
    ///
    /// See [ATO Documentation](https://www.ato.gov.au/Business/Single-Touch-Payroll/In-detail/Single-Touch-Payroll-Phase-2-employer-reporting-guidelines/?anchor=Howtoreportemploymentandtaxationinformat#Howtoreportemploymentandtaxationinformat) for the definition of these terms.
    public enum TaxScaleType: String, Codable {
        case REGULAR
        case ACTORSARTISTSENTERTAINERS
        case HORTICULTURISTORSHEARER
        case SENIORORPENSIONER
        case WORKINGHOLIDAYMAKER
        /// Only valid when ResidencyStatus is FOREIGNRESIDENT.
        case FOREIGN
    }
}
extension Xero.Employee {
    public enum TerminationReason: String, Codable {
        /// Voluntary cessation
        /// An employee resignation, retirement, domestic or pressing necessity or abandonment of employment
        case V
        /// Ill health
        /// An employee resignation due to medical condition that prevents the continuation of employment, such as for illness, ill-health, medical unfitness or total permanent disability
        case I
        /// Deceased
        /// The death of an employee
        case D
        /// Redundancy
        /// An employer-initiated termination of employment due to a genuine redundancy or approved early retirement scheme
        case R
        /// Dismissal
        /// An employer-initiated termination of employment due to dismissal, inability to perform the required work, misconduct or inefficiency
        case F
        /// Contract cessation
        /// The natural conclusion of a limited employment relationship due to contract/engagement duration or task completion, seasonal work completion, or to cease casuals that are no longer required
        case C
        /// Transfer
        /// The administrative arrangements performed to transfer employees across payroll systems, move them temporarily to another employer (machinery of government for public servants), transfer of business, move them to outsourcing arrangements or other such technical activities.
        case T
    }
}
