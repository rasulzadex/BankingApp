//
//  Extensions.swift
//  BankAPP
//
//  Created by Javidan on 05.11.24.
//

import Foundation
import UIKit

extension UITextField {
    
    func setCardNumberFormatting() {
        self.keyboardType = .numberPad
        self.addTarget(self, action: #selector(formatCardNumber), for: .editingChanged)
    }
    
    @objc private func formatCardNumber() {
        guard var text = self.text?.replacingOccurrences(of: " ", with: "") else { return }
        
        if text.count > 16 {
            text = String(text.prefix(16))
        }
        
        let formattedText = text.enumerated().map { index, character in
            return index % 4 == 0 && index > 0 ? " \(character)" : "\(character)"
        }.joined()
        
        self.text = formattedText
    }

    
    func setCardExpirationDateFormatting() {
        self.keyboardType = .numberPad
        self.addTarget(self, action: #selector(formatExpirationDate), for: .editingChanged)
    }
    
    @objc private func formatExpirationDate() {
        guard var text = self.text?.replacingOccurrences(of: "/", with: "") else { return }
        
        if text.count > 6 {
            text = String(text.prefix(6))
        }
        
        if text.count > 2 {
            text.insert("/", at: text.index(text.startIndex, offsetBy: 2))
        }
        
        self.text = text
    }
    
    func setCVVFormat() {
        self.keyboardType = .numberPad
        self.addTarget(self, action: #selector(formatCVV), for: .editingChanged)
    }
    
    @objc private func formatCVV() {
        guard var text = self.text else { return }
        
        if text.count > 3 {
            text = String(text.prefix(3))
        }
        self.text = text
    }
}

extension UIImage {
    func resize(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
}



extension UITextField {
    func setLeftPadding(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}


extension String {
    func isValidEmail() -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
    
    func isValidName() -> Bool {
        let nameRegex = "^[A-Za-z]{3,}$"
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return namePredicate.evaluate(with: self)
    }
    
    
    func isValidLastname() -> Bool {
        let nameRegex = "^[A-Za-z]{3,}$"
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return namePredicate.evaluate(with: self)
    }
    
    func isValidFinCode() -> Bool {
           let finCodeRegex = "^[A-Z0-9]{7}$"
           let finCodePredicate = NSPredicate(format: "SELF MATCHES %@", finCodeRegex)
           return finCodePredicate.evaluate(with: self)
       }
    
  
        func isValidPhoneNumber() -> Bool {
            let phoneRegex = "^(99450|99451|99410|99455|99499|99470|99477)[0-9]{7}$"
            let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            return phonePredicate.evaluate(with: self)
        }
    
    func isValidPass() -> Bool {

                return self.count >= 8
    }
    
    func isValidCVV() -> Bool {

                return self.count == 3
    }
    
    
    func isVisaCard() -> Bool {
        let visaRegex = "^4[0-9]{12,15}$"
        let visaPredicate = NSPredicate(format: "SELF MATCHES %@", visaRegex)
        return visaPredicate.evaluate(with: self.trimmingCharacters(in: .whitespacesAndNewlines))
    }

        
        func isMasterCard() -> Bool {
            let masterCardRegex = "^5[1-5][0-9]{14}$"
            let masterCardPredicate = NSPredicate(format: "SELF MATCHES %@", masterCardRegex)
            return masterCardPredicate.evaluate(with: self)
        }
        
        func isValidPAN() -> Bool {
            let panRegex = "^[0-9]{16}$" // PANs are typically 16 digits long
            let panPredicate = NSPredicate(format: "SELF MATCHES %@", panRegex)
            return panPredicate.evaluate(with: self)
        }
    
    func isValidExpirationDate() -> Bool {
        let dateRegex = "^(0[1-9]|1[0-2])/\\d{4}$" // Format MM/YYYY
        let datePredicate = NSPredicate(format: "SELF MATCHES %@", dateRegex)
        
        guard datePredicate.evaluate(with: self) else {
            return false // Does not match MM/YYYY format
        }
        
        let components = self.split(separator: "/")
        guard components.count == 2,
              let month = Int(components[0]),
              let year = Int(components[1]) else {
            return false
        }
        
        let currentDate = Date()
        let calendar = Calendar.current
        
        let currentYear = calendar.component(.year, from: currentDate)
        let currentMonth = calendar.component(.month, from: currentDate)
        
        if year > currentYear || (year == currentYear && month >= currentMonth) {
            return true
        } else {
            return false
        }
    }
    
}





extension UILabel {
    func setLeftPaddingForLabel(_ amount: CGFloat) {
        let padding = UIEdgeInsets(top: 0, left: amount, bottom: 0, right: 0)
        self.drawText(in: self.bounds.inset(by: padding))
    }
}



extension UIButton {
    func setUnderlinedTitle(_ title: String, color: UIColor = .systemBlue) {
        let attributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .foregroundColor: color
        ]
        let attributedTitle = NSAttributedString(string: title, attributes: attributes)
        self.setAttributedTitle(attributedTitle, for: .normal)
    }
}



extension UITextField {
    func setPlaceholder(text: String, color: UIColor, alpha: CGFloat = 1) {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color.withAlphaComponent(alpha)
        ]
        self.attributedPlaceholder = NSAttributedString(string: text, attributes: attributes)
    }
}


extension UIView {
    func addViews(view:[UIView]){
        view.forEach {self.addSubview($0)}
    }
}


extension UIViewController {
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }

}

