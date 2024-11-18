//
//  ReusableButton.swift
//  BankAPP
//
//  Created by Javidan on 15.11.24.
//

import UIKit


class ReusableButton: UIButton {
    private var title: String = ""
    private var buttonColor: UIColor
    private var onAction: () -> Void
    
    
    init(title: String, buttonColor: UIColor, onAction: @escaping () -> Void) {
        self.title = title
        self.onAction = onAction
        self.buttonColor = buttonColor
        super.init(frame: .zero)
        setupUI()
    }
    
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }
    
    
    func setupUI() {
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = buttonColor
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = buttonColor.cgColor
        
        addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
    }
    
    @objc func buttonClicked(){
        onAction()
    }
}
