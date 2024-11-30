//
//  TransferViewModel.swift
//  BankAPP
//
//  Created by Javidan on 27.11.24.
//

import Foundation
import RealmSwift

class TransferViewModel {
    private let realm = try? Realm()
    private(set) var cardList: [CardModel] = []
    var selectedFromCard: CardModel?
    var selectedToCard: CardModel?
    
    init() {
        fetchCardList()
    }
    
    private func fetchCardList() {
        if let results = realm?.objects(CardModel.self) {
            cardList = Array(results)
        }
    }
    
    func transferAmount(amount: Double) -> String {
        guard let fromCard = selectedFromCard, let toCard = selectedToCard else {
            return "No card selected"
        }
        
        guard let fromBalance = Double(fromCard.cardBalance), fromBalance >= amount else {
            return "Not available balance"
        }
        
        
        do {
            try realm?.write {
                fromCard.cardBalance = String(format: "%.2f", fromBalance - amount)
                toCard.cardBalance = String(format: "%.2f", Double(toCard.cardBalance)! + amount)
            }
            return "Transfer success"
        } catch {
            return "Transfer error"
        }
        
    }
}
