//
//  AddCardViewModel.swift
//  BankAPP
//
//  Created by Javidan on 19.11.24.
//
import Foundation
import RealmSwift

class AddCardViewModel {
    
    enum ViewState {
        case error(String)
        case success(String)
    }
    
    private let realm = try? Realm()
    
    var cardName: String?
    var cardNumber: String?
    var cardExpiry: String?
    var cardCVV: String?
    var balance: String?
        
    var addCardListener: ((ViewState)->Void)?
    
    var isCardNameValid: Bool {
        return cardName?.isValidName() ?? false
    }
    
    var isCardNumberValid: Bool {
        guard let cardNumber = cardNumber?.replacingOccurrences(of: " ", with: "") else { return false }
        return cardNumber.isVisaCard() || cardNumber.isMasterCard()
    }
    
    var isCardExpiryValid: Bool {
        return cardExpiry?.isValidExpirationDate() ?? false
    }
    
    var isCardCVVValid: Bool {
        return cardCVV?.isValidCVV() ?? false
    }
    
    var isBalanceValid: Bool {
        return !(balance?.isEmpty ?? true)
    }
    
  

    func saveCard() {
        guard isCardNameValid, isCardNumberValid, isCardExpiryValid, isCardCVVValid, isBalanceValid else { return }
        let card = CardModel()
        card.cardName = cardName ?? ""
        card.cardNumber = cardNumber ?? ""
        card.cardExpiration = cardExpiry ?? ""
        card.cardCVV = cardCVV ?? ""
        card.cardBalance = balance ?? ""
        
        do {
            try realm?.write {
                realm?.add(card)
            }  
            addCardListener?(.success("Card info is valid"))
        } catch {
            addCardListener?(.error("ERror localized ......"))
        }
    }
    
}
