//
//  AddCardController.swift
//  BankAPP
//
//  Created by Javidan on 14.11.24.
//

import UIKit
import RealmSwift

class AddCardController: BaseViewController {
    
    private var cardList: Results<CardModel>?
    private let realm = try? Realm()

    init() {
        super.init(nibName: nil, bundle: nil)
            fetchCardList()
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fetchCardList() {
           self.cardList = realm?.objects(CardModel.self)
       }
    
    func saveCard(cardName: String, cardPan: String, cardExp: String, cardCVV: String, cardBalance:String) {
        let card = CardModel()
        card.cardCVV = cardCVV
        card.cardNumber = cardPan
        card.cardExpiration = cardExp
        card.cardName = cardName
        card.cardBalance = cardBalance
            do {
                try realm?.write {
                    realm?.add(card)
                }
            } catch {
                print("Error saving customer: \(error.localizedDescription)")
            }
        }
    
    private var isVisa = false
    private var isMaster = false
    
    
    private lazy var cardImage: ReusableImageView = {
        let i = ReusableImageView(imageName: "cardBG", contentMode: .scaleAspectFill, cornerRadius: 0)
        return i
    }()
   
    private lazy var cardType: ReusableImageView = {
        let i = ReusableImageView(imageName: "type", contentMode: .scaleAspectFill, cornerRadius: 0)
        return i
    }()
   
    private lazy var cardNumberTF: ReusableTextField = {
        let t = ReusableTextField(placeholder: "0000 0000 0000 0000", placeholderColor: .white, borderColor: .white, texttColor: .white, bgColor: .clear)
        t.setCardNumberFormatting()
        t.font = UIFont(name: "Downtown", size:20)
        t.setLeftPadding(52)
        t.delegate = self
        return t
    }()
    
    
    private lazy var cardExpiry: ReusableTextField = {
        let t = ReusableTextField(placeholder: "MM/YYYY", placeholderColor: .white, borderColor: .white, texttColor: .white, bgColor: .clear)
        t.setCardExpirationDateFormatting()
        t.font = UIFont(name: "Downtown", size: 14)
        t.delegate = self
        t.textAlignment = .center
        return t
    }()
    
    
    private lazy var cardCVV: ReusableTextField = {
        let t = ReusableTextField(placeholder: "CVV", placeholderColor: .white, borderColor: .white, texttColor: .white, bgColor: .clear)
        t.setCVVFormat()
        t.font = UIFont(name: "Downtown", size: 14)
        t.delegate = self
        t.textAlignment = .center
        return t
    }()
    
    private lazy var cardName: ReusableTextField = {
        let t = ReusableTextField(placeholder: "CARDNAME", placeholderColor: .white, borderColor: .white, texttColor: .white, bgColor: .clear)
    
        t.font = UIFont(name: "Downtown", size: 14)
        t.delegate = self
        t.textAlignment = .center
        return t
    }()
     
    private lazy var balanceTF: ReusableTextField = {
        let tf = ReusableTextField(placeholder: "Add your balance", placeholderColor: .appGreen.withAlphaComponent(0.5), borderColor: .appGreen, texttColor: .appGreen, bgColor: .clear)
        tf.font = UIFont(name: "Downtown", size: 16)
        tf.delegate = self
        return tf
    }()

    private lazy var addCardButton: ReusableButton = {
        let b = ReusableButton(title: "Add Card", buttonColor: .appGreen, onAction: {[weak self] in self?.submitButton()})
        return b
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        print("Realm path", realm.configuration.fileURL!)
        
    }
    
    @objc func submitButton() {
//        if phoneNumberTF.layer.borderColor == UIColor.green.cgColor && firstNameTF.layer.borderColor == UIColor.green.cgColor && lastNameTF.layer.borderColor == UIColor.green.cgColor && finCodeTF.layer.borderColor == UIColor.green.cgColor && emailTF.layer.borderColor == UIColor.green.cgColor && passwordTF.layer.borderColor == UIColor.green.cgColor && viewModel.isAllValid {
//            
            guard let name = cardName.text,
                  let number = cardNumberTF.text,
                  let exp = cardExpiry.text,
                  let cvv = cardCVV.text,
                  let balance = balanceTF.text
                   else {return}
        
        saveCard(cardName: name, cardPan: number, cardExp: exp, cardCVV: cvv, cardBalance: balance)

            navigationController?.popViewController(animated: true)
//        } else {
//            showAlert(on: self)
//        }
    }
    
    
    override func configureView() {
        super.configureView()
        view.addViews(view: [cardImage, cardNumberTF, cardName, cardExpiry, cardCVV, addCardButton, cardType, balanceTF])
 
        
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
            cardExpiry.widthAnchor.constraint(equalToConstant: 80)
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
            cardType.centerYAnchor.constraint(equalTo: cardImage.centerYAnchor, constant: -80),
            cardType.rightAnchor.constraint(equalTo: cardImage.rightAnchor, constant: -40),
            cardType.heightAnchor.constraint(equalToConstant: 64),
            cardType.widthAnchor.constraint(equalToConstant: 64)
        ])
        
        NSLayoutConstraint.activate([
            balanceTF.topAnchor.constraint(equalTo: cardImage.bottomAnchor, constant: 4),
            balanceTF.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            balanceTF.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            balanceTF.heightAnchor.constraint(equalToConstant: 40)
      
        ])
        
        NSLayoutConstraint.activate([
            addCardButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            addCardButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            addCardButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            addCardButton.heightAnchor.constraint(equalToConstant: 40)

        ])
        
    }
    
    private func checkExpiration(){
        guard let exp = cardExpiry.text else {return}
        
        if exp.isValidExpirationDate(){
            cardExpiry.layer.borderColor = UIColor.green.cgColor
            cardExpiry.textColor = .green
        } else {
            cardExpiry.layer.borderColor = UIColor.red.cgColor
            cardExpiry.textColor = .red
        }
        
    }
    
    private func checkName(){
        guard let name = cardName.text else {return}
        if name.isValidName(){
            cardName.layer.borderColor = UIColor.green.cgColor
            cardName.textColor = .green
        } else {
            cardName.layer.borderColor = UIColor.red.cgColor
            cardName.textColor = .red
        }
        
    }

    private func checkCVV(){
        guard let cvv = cardCVV.text else {return}
        
        if cvv.isValidCVV(){
            cardCVV.layer.borderColor = UIColor.green.cgColor
            cardCVV.textColor = .green
        } else {
            cardCVV.layer.borderColor = UIColor.red.cgColor
            cardCVV.textColor = .red
        }
        
    }
    
    private func updateCardTypeImage() {
        guard let pan = cardNumberTF.text?
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: " ", with: "") else {
            cardType.image = UIImage(named: "")
            return
        }
        
        if pan.isVisaCard() {
            cardNumberTF.layer.borderColor = UIColor.green.cgColor
            cardNumberTF.textColor = .green
            cardType.image = UIImage(named: "visa")
            isVisa = true
            isMaster = false
        } else if pan.isMasterCard() {
            cardNumberTF.layer.borderColor = UIColor.green.cgColor
            cardNumberTF.textColor = .green
            cardType.image = UIImage(named: "master")
            isVisa = false
            isMaster = true
        } else {
            cardNumberTF.layer.borderColor = UIColor.red.cgColor
            cardNumberTF.textColor = .red

            cardType.image = UIImage(named: "type")
            isVisa = false
            isMaster = false
        }
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

        func textFieldDidChangeSelection(_ textField: UITextField) {
            switch textField {
            case cardNumberTF:
                updateCardTypeImage()
            case cardExpiry:
                checkExpiration()
            case cardCVV:
                checkCVV()
            case cardName:
                checkName()
            default: return
                
            }
        }
    }

    

