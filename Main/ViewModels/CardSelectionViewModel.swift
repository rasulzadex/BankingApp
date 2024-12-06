//
//  CardSelectionViewModel.swift
//  BankAPP
//
//  Created by Javidan on 03.12.24.
//

import RealmSwift


final class CardSelectionViewModel {
    
    enum ViewState {
        case success(String)
        case error(String)
    }

    var listener: ((ViewState) -> Void)?
    
    private let realm = try? Realm()
    var cardList: Results<CardModel>?
    
    
    init() {
        fetchCustomerList()
    }
    
    func fetchCustomerList() {
        self.cardList = realm?.objects(CardModel.self)
        cardList?.count ?? 0 > 1 ? listener?(.success("You can select a card")) : listener?(.error("You dont have enough card"))
    }

    
    func getCard(at index: Int) -> CardModel? {
        return cardList?[index]
    }

}
