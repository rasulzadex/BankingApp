//
//  AddCardController.swift
//  BankAPP
//
//  Created by Javidan on 14.11.24.
//

import UIKit

class AddCardController: BaseViewController {
    
    private lazy var cardImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "cardBG")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    
    
    
    
    private lazy var cardNumberTF: UITextField = {
        let tf = UITextField()
        tf.layer.cornerRadius = 10
        tf.layer.borderWidth = 2
        tf.setPlaceholder(text: "0000 0000 0000 0000", color: .white, alpha: 0.6)
        tf.layer.borderColor = UIColor.white.cgColor
        tf.adjustsFontSizeToFitWidth = true
        tf.delegate = self
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textAlignment = .left
        tf.setLeftPadding(52)
        tf.textColor = .white
        tf.backgroundColor = .clear
        tf.font = UIFont(name: "Downtown", size:20)
        tf.setCardNumberFormatting()
        return tf
        
    }()
    
    
    private lazy var cardExpiry: UITextField = {
        let tf = UITextField()
        tf.layer.cornerRadius = 10
        tf.layer.borderWidth = 2
        tf.setPlaceholder(text: "01/20", color: .white, alpha: 0.6)
        tf.layer.borderColor = UIColor.white.cgColor
        tf.adjustsFontSizeToFitWidth = true
        tf.delegate = self
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textAlignment = .center
        tf.textColor = .white
        tf.backgroundColor = .clear
        tf.font = UIFont(name: "Downtown", size:16)
        return tf
        
    }()
    
    
    private lazy var cardCVV: UITextField = {
        let tf = UITextField()
        tf.layer.cornerRadius = 10
        tf.layer.borderWidth = 2
        tf.setPlaceholder(text: "CVV", color: .white, alpha: 0.6)
        tf.layer.borderColor = UIColor.white.cgColor
        tf.adjustsFontSizeToFitWidth = true
        tf.delegate = self
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textAlignment = .center
        tf.textColor = .white
        tf.backgroundColor = .clear
        tf.font = UIFont(name: "Downtown", size:16)
        return tf
        
    }()
    
    
    private lazy var cardName: UITextField = {
        let tf = UITextField()
        tf.layer.cornerRadius = 10
        tf.layer.borderWidth = 2
        tf.setPlaceholder(text: "CARDNAME", color: .white, alpha: 0.6)
        tf.layer.borderColor = UIColor.white.cgColor
        tf.delegate = self
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textAlignment = .center
        tf.textColor = .white
        tf.backgroundColor = .clear
        tf.font = UIFont(name: "Downtown", size:16)
        return tf
        
    }()
    
    private lazy var addCardButton: ReusableButton = {
        let b = ReusableButton(title: "Add Card", buttonColor: .appGreen, onAction: {[weak self] in self?.addCardClick()})
        return b
    }()
    
    
    @objc func addCardClick() {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configureView() {
        super.configureView()
        view.addSubview(cardImage)
        view.addSubview(cardNumberTF)
        view.addSubview(cardName)
        view.addSubview(cardExpiry)
        view.addSubview(cardCVV)
        view.addSubview(addCardButton)
    }
    
    override func configureConstraint() {
        super.configureConstraint()
        NSLayoutConstraint.activate([
            cardImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardImage.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 0.05),
            cardImage.widthAnchor.constraint(equalToConstant: 385),
            cardImage.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            cardNumberTF.centerXAnchor.constraint(equalTo: cardImage.centerXAnchor),
            cardNumberTF.centerYAnchor.constraint(equalTo: cardImage.centerYAnchor, constant: 20),
            cardNumberTF.leadingAnchor.constraint(equalTo: cardImage.leadingAnchor, constant: 56),
            cardNumberTF.trailingAnchor.constraint(equalTo: cardImage.trailingAnchor, constant: -56),
            cardNumberTF.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        NSLayoutConstraint.activate([
//            cardExpiry.leadingAnchor.constraint(equalTo: cardImage.leadingAnchor, constant: 56),
            cardExpiry.trailingAnchor.constraint(equalTo: cardImage.trailingAnchor, constant: -56),
            cardExpiry.centerYAnchor.constraint(equalTo: cardImage.centerYAnchor, constant: 56),
            cardExpiry.heightAnchor.constraint(equalToConstant: 24),
            cardExpiry.widthAnchor.constraint(equalToConstant: 64)
        ])
        
        NSLayoutConstraint.activate([
            cardCVV.trailingAnchor.constraint(equalTo: cardImage.trailingAnchor, constant: -56),
            cardCVV.centerYAnchor.constraint(equalTo: cardImage.centerYAnchor, constant: 88),
            cardCVV.heightAnchor.constraint(equalToConstant: 24),
            cardCVV.widthAnchor.constraint(equalToConstant: 64)
        ])

        NSLayoutConstraint.activate([
            
            cardName.centerYAnchor.constraint(equalTo: cardImage.centerYAnchor, constant: 88),
            cardName.leftAnchor.constraint(equalTo: cardImage.leftAnchor, constant: 56),
            cardName.heightAnchor.constraint(equalToConstant: 32),
            cardName.widthAnchor.constraint(equalToConstant: 144)
            
        ])

        NSLayoutConstraint.activate([
            addCardButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            addCardButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            addCardButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            addCardButton.heightAnchor.constraint(equalToConstant: 40)
            
        
        ])
    
    }
}


extension AddCardController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == cardName {
            return true
        } else {
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)

        }
    }
}
