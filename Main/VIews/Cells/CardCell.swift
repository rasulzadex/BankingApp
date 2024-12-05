//
//  CardCell.swift
//  BankAPP
//
//  Created by Javidan on 18.11.24.
//

import UIKit

class CardCell: UICollectionViewCell {
    
    
    lazy var cardImage: ReusableImageView = {
        let i = ReusableImageView(imageName: "cardBG", contentMode: .scaleAspectFill, cornerRadius: 0)
        return i
    }()
    
    lazy var cardNumber: ReusableLabel = {
        let l = ReusableLabel(text: "**** 1234", textAlignment: .left, fontName: "Downtown", fontSize: 20, textColor: .white, numberOfLines: 0)
        return l
    }()
    
    lazy var cardName: ReusableLabel = {
        let l = ReusableLabel(text: "JAVIDAN RASULZADE", textAlignment: .center, fontName: "Downtown", fontSize: 16, textColor: .white, numberOfLines: 0)
        return l
    }()
    
    lazy var cardExp: ReusableLabel = {
        let l = ReusableLabel(text: "01/2025", textAlignment: .center, fontName: "Downtown", fontSize: 16, textColor: .white, numberOfLines: 0)
        return l
    }()
    
    lazy var cardType: ReusableImageView = {
        let i = ReusableImageView(imageName: "visa", contentMode: .scaleAspectFill, cornerRadius: 0)
        return i
    }()
    
     lazy var balanceLabel: ReusableLabel = {
        let l = ReusableLabel(text: "124 AZN", textAlignment: .center, fontName: "Revue", fontSize: 20, textColor: .white, numberOfLines: 0, cornerRadius: 10)
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        addViews(view: [cardImage, cardNumber, cardExp, cardName,cardType, balanceLabel])
    }
    
    func configureCell(object: CardModel) {
        cardExp.text = object.cardExpiration
        cardName.text = object.cardName
        cardNumber.text = "**** " + object.cardNumber.suffix(4)
        balanceLabel.text = object.cardBalance
    }
    
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            cardImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            cardImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            cardImage.widthAnchor.constraint(equalToConstant: 385),
            cardImage.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            cardNumber.centerXAnchor.constraint(equalTo: cardImage.centerXAnchor),
            cardNumber.centerYAnchor.constraint(equalTo: cardImage.centerYAnchor, constant: 40),
            cardNumber.leadingAnchor.constraint(equalTo: cardImage.leadingAnchor, constant: 40),
            cardNumber.trailingAnchor.constraint(equalTo: cardImage.trailingAnchor, constant: -40),
            cardNumber.heightAnchor.constraint(equalToConstant: 32)
        ])
        NSLayoutConstraint.activate([
            
            cardName.centerYAnchor.constraint(equalTo: cardImage.centerYAnchor, constant: 88),
            cardName.leftAnchor.constraint(equalTo: cardImage.leftAnchor, constant: 24),
            cardName.heightAnchor.constraint(equalToConstant: 32),
            cardName.widthAnchor.constraint(equalToConstant: 144)
            
        ])
        NSLayoutConstraint.activate([
            
            cardType.centerYAnchor.constraint(equalTo: cardImage.centerYAnchor, constant: 80),
            cardType.rightAnchor.constraint(equalTo: cardImage.rightAnchor, constant: -24),
            cardType.heightAnchor.constraint(equalToConstant: 64),
            cardType.widthAnchor.constraint(equalToConstant: 64)
            
        ])
        
        NSLayoutConstraint.activate([
            cardExp.trailingAnchor.constraint(equalTo: cardImage.trailingAnchor, constant: -24),
            cardExp.centerYAnchor.constraint(equalTo: cardImage.centerYAnchor, constant: 40),
            cardExp.heightAnchor.constraint(equalToConstant: 24),
            cardExp.widthAnchor.constraint(equalToConstant: 64)
        ])
        
        NSLayoutConstraint.activate([
            balanceLabel.trailingAnchor.constraint(equalTo: cardImage.trailingAnchor, constant: -24),
            balanceLabel.centerYAnchor.constraint(equalTo: cardImage.centerYAnchor, constant: -80),
            balanceLabel.heightAnchor.constraint(equalToConstant: 64),
            balanceLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
        
    }
    
}
