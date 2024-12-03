//
//  TransferViewModel.swift
//  BankAPP
//
//  Created by Javidan on 27.11.24.
//
import RealmSwift

class TransferViewModel {
    private let realm = try? Realm()
    
    var cardList: Results<CardModel>?

    func fetchCardList() {
        self.cardList = realm?.objects(CardModel.self)
    }
    
    func validateTransferAmount(amountText: String?, selectedFromCard: CardModel?) -> Bool {
        guard let amountText = amountText, let amount = Double(amountText), amount > 0 else {
            return false
        }

        guard let fromCard = selectedFromCard else {
            return false
        }

        guard let fromCardBalance = Double(fromCard.cardBalance) else {
            return false
        }

        if fromCardBalance < amount {
            return false
        }

        return true
    }
    
    func executeTransfer(fromCard: CardModel, toCard: CardModel, amount: Double) {
        do {
            try realm?.write {
                guard var fromCardBalance = Double(fromCard.cardBalance),
                      var toCardBalance = Double(toCard.cardBalance) else {
                    return
                }

                fromCardBalance -= amount
                toCardBalance += amount

                fromCard.cardBalance = String(fromCardBalance)
                toCard.cardBalance = String(toCardBalance)

                realm?.add(fromCard, update: .modified)
                realm?.add(toCard, update: .modified)
            }
        } catch {
            print("An error occurred while processing the transfer.")
        }
    }
}
