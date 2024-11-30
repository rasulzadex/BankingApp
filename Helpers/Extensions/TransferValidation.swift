//
//  TransferValidation.swift
//  BankAPP
//
////  Created by Javidan on 29.11.24.
////
//
//import Foundation
//
//extension String {
//    func validateTransferAmount() -> Bool {
//        guard let amountText = transferAmount.text, let amount = Double(amountText), amount > 0 else {
//            showAlert(message: "Please enter a valid transfer amount.")
//            return false
//        }
//        
//        guard let fromCard = selectedFromCard else {
//            showAlert(message: "Please select the 'from' card.")
//            return false
//        }
//        
//        guard let fromCardBalance = Double(fromCard.cardBalance) else {
//            showAlert(message: "Invalid card balance.")
//            return false
//        }
//        
//        if fromCardBalance < amount {
//            showAlert(message: "Insufficient balance on the selected card.")
//            return false
//        }
//        
//        return true
//    }
//}
