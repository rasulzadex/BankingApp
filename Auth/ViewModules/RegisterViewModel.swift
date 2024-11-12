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
    
    private var emailCheck = false
    private var numberCheck = false
    private var finCheck = false
    private var nameCheck = false
    private var lastnameCheck = false
    private var passwordCheck = false
    
    var isAllValid: Bool {
        return numberCheck && nameCheck && lastnameCheck && finCheck && emailCheck && passwordCheck
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
    
    func validateEmail(_ email: String) -> Bool {
            if email.isValidEmail() {
                emailCheck = true
                return true
            }
            emailCheck = false
            return false
        }
    
    func validateName(_ name: String) -> Bool {
            if name.isValidName() {
                nameCheck = true
                return true
            }
            nameCheck = false
            return false
        }
    
    func validateLastname(_ lastname: String) -> Bool {
        if lastname.isValidLastname(){
            lastnameCheck = true
            return true
        }
            lastnameCheck = false
            return false
        
    }
    
    func validateFIN(_ fin: String) -> Bool {
        if fin.isValidFinCode(){
            finCheck = true
            return true
        }
        finCheck = false
        return false
    }
    
    func validatePhone(_ phone: String) -> Bool {
        if phone.isValidPhoneNumber(){
            numberCheck = true
            return true
        }
        numberCheck = false
        return false
    }
    
    func validatePassword(_ password: String) -> Bool {
        if password.isValidPass(){
            passwordCheck = true
            return true
        }
        passwordCheck = false
        return false
    }
    
    
}
