//
//  Customer.swift
//  BankAPP
//
//  Created by Javidan on 04.11.24.
//

import Foundation
import RealmSwift


class Customer: Object {
    
    
    @Persisted(primaryKey: true) var customerID: String
    @Persisted var name: String
    @Persisted var lastName: String
    @Persisted var phoneNumber: String
    @Persisted var emailAddress: String
    @Persisted var customerPassword: String?
    
    
}
