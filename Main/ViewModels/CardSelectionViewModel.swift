//
//  CardSelectionViewModel.swift
//  BankAPP
//
//  Created by Javidan on 03.12.24.
//

import RealmSwift


final class CardSelectionViewModel {
    
    private let realm = try? Realm()
    var cardList: Results<CardModel>?
    
    var reloadCallback: (() -> Void)?
    
    init() {
        fetchCustomerList()
    }
    
    func fetchCustomerList() {
        self.cardList = realm?.objects(CardModel.self)
    }

    
    func getCard(at index: Int) -> CardModel? {
        return cardList?[index]
    }

}
