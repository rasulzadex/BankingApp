//
//  ProfileViewModel.swift
//  BankAPP
//
//  Created by Javidan on 02.12.24.
//

import RealmSwift

class ProfileViewModel {
    private let realm = try? Realm()
    var customerList: Results<Customer>?
    
    
    func fetchCardList() {
        self.customerList = realm?.objects(Customer.self)
    }
    
}
