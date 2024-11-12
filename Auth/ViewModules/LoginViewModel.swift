//
//  LoginViewModel.swift
//  BankAPP
//
//  Created by Javidan on 12.11.24.
//

import Foundation
import RealmSwift

final class LoginViewModel {
    
    
    private let realm = try? Realm()
     var customerList: Results<Customer>?
    
    init() {
            fetchCustomerList()
        }
    
    func fetchCustomerList() {
           self.customerList = realm?.objects(Customer.self)
       }
    
    
    func fetchCustomers() -> [Customer]? {
        guard let realm = realm else { 
            print("Error initializing Realm.")
            return nil
        }
        
        let customers = realm.objects(Customer.self)
        return Array(customers)
    }

    
}
