//
//  Card.swift
//  BankAPP
//
//  Created by Javidan on 15.11.24.
//

import Foundation
import RealmSwift

class CardModel: Object {
   
    @Persisted var cardName: String
    @Persisted var cardNumber: String
    @Persisted var cardExpiration: String
    @Persisted var cardCVV: String
    @Persisted var cardBalance: String

    
    
}
