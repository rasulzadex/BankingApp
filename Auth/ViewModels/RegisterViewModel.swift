//
//  AuthViewModel.swift
//  BankAPP
//
//  Created by Javidan on 11.11.24.
//

import Foundation
import RealmSwift
final class RegisterViewModel {
    
    private var customerList: Results<Customer>?
    private let realm = try? Realm()
    
    
    private var checker: [ValidationType: Bool] = [
            .email: false,
            .fin: false,
            .lastname: false,
            .name: false,
            .password: false,
            .phone: false
    ]
    
    var isAllValid: Bool {
        return !checker.values.contains(false)
    }

    
    init() {
            fetchCustomerList()
        }
    
    func fetchCustomerList() {
           self.customerList = realm?.objects(Customer.self)
       }
    
    
    
    
    
    func saveCustomer(name: String, lastName: String, customerID: String, email: String, phoneNumber: String, password: String) {
            let customer = Customer()
            customer.name = name
            customer.lastName = lastName
            customer.customerID = customerID
            customer.emailAddress = email
            customer.customerPassword = password
            customer.phoneNumber = phoneNumber

            do {
                try realm?.write {
                    realm?.add(customer)
                }
            } catch {
                print("Error saving customer: \(error.localizedDescription)")
            }
        }
    
    enum ValidationType {
        case email, name, lastname, password, phone, fin
    }
    
    func validate(value: String, type: ValidationType) -> Bool{
        let isValid: Bool

        switch type {
        
        case .email:
            isValid = value.isValidEmail()
        case .name:
            isValid = value.isValidName()
        case .lastname:
            isValid = value.isValidLastname()
        case .password:
            isValid = value.isValidPass()
        case .phone:
            isValid = value.isValidPhoneNumber()
        case .fin:
            isValid = value.isValidFinCode()
        }
        
        checker[type] = isValid
        return isValid
    }
    
}
