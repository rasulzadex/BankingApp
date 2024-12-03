//
//  CardViewModel.swift
//  BankAPP
//
//  Created by Javidan on 02.12.24.
//

import RealmSwift

class CardViewModel {
    private let realm = try? Realm()
    var cardList: Results<CardModel>?
    
    
    func fetchCardList() {
            self.cardList = realm?.objects(CardModel.self)
        }
    
    
    func deleteCard(at index: Int) {
            guard let card = cardList?[index] else { return }
            do {
                try realm?.write {
                    realm?.delete(card)
                }
            } catch {
                print("Error deleting card: \(error)")
            }
        }
    
}
