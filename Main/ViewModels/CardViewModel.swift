//
//  CardViewModel.swift
//  BankAPP
//
//  Created by Javidan on 02.12.24.
//

import RealmSwift

class CardViewModel {
    
    enum ViewState {
        case success(String)
        case error(String)
    }
    
    
    private let realm = try? Realm()
    var cardList: Results<CardModel>?
    
    var cardVMlistener: ((ViewState) -> Void)?

    
    func fetchCardList() {
            self.cardList = realm?.objects(CardModel.self)
        cardList?.count ?? 0 > 0 ? cardVMlistener?(.success("Fetch card success")) : cardVMlistener?(.error("Please add at least one card"))
        }
    
    
    func deleteCard(at index: Int) {
            guard let card = cardList?[index] else { return }
            do {
                try realm?.write {
                    realm?.delete(card)
                }
                cardVMlistener?(.success("Card deleted successfully"))

            } catch {
                cardVMlistener?(.error("Error deleting card: \(error)"))
            }
        }
    
}
