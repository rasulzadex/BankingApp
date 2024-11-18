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
