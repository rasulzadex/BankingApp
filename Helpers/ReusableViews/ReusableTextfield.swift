//
//  ReusableTextField.swift
//  BankAPP
//
//  Created by Javidan on 15.11.24.
//

import UIKit

class ReusableTextField: UITextField {
    private var placeholderText: String = ""
    private var placeholderColor: UIColor
    private var borderColor: UIColor
    private var texttColor: UIColor
    private var bgColor: UIColor
    
    init(placeholder: String, placeholderColor: UIColor, borderColor: UIColor, texttColor: UIColor, bgColor: UIColor) {
        self.placeholderText = placeholder
        self.placeholderColor = placeholderColor
        self.borderColor = borderColor
        self.texttColor = texttColor
        self.bgColor = bgColor
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = borderColor.cgColor
        textColor = texttColor
        backgroundColor = bgColor
        translatesAutoresizingMaskIntoConstraints = false
        setLeftPadding(10)
        setPlaceholder(text: placeholderText, color: placeholderColor, alpha: 0.5)
    }
}
