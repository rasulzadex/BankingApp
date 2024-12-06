//
//  TransferViewModel.swift
//  BankAPP
//
//  Created by Javidan on 27.11.24.
//
import RealmSwift

class TransferViewModel {
    
    enum ViewState {
        case success(String)
        case error(String)
    }
    
    private let realm = try? Realm()
    
    var cardList: Results<CardModel>?
    var listener: ((ViewState) -> Void)?

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
                    listener?(.error("Error processing card balances"))
                    return
                }

                fromCardBalance -= amount
                toCardBalance += amount

                fromCard.cardBalance = String(fromCardBalance)
                toCard.cardBalance = String(toCardBalance)

                realm?.add(fromCard, update: .modified)
                realm?.add(toCard, update: .modified)
               listener?(.success("Transfer handled successfully"))
            }
        } catch {
            print("An error occurred while processing the transfer.")
            listener?(.error("An error occurred while processing the transfer"))
        }
    }

}
