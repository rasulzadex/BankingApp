//
//  CardCell.swift
//  BankAPP
//
//  Created by Javidan on 18.11.24.
//

import UIKit

class CardCell: UICollectionViewCell {
    
    
    private lazy var cardImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "cardBG")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var cardNumber: UILabel = {
        
        let l = UILabel()
        l.text = "**** **** **** 0000"
        l.textAlignment = .center
        l.numberOfLines = 0
        l.font = UIFont(name: "Downtown", size: 26)
        l.textColor = .white
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
        
        
    }()
    
    
    private lazy var cardName: UILabel = {
        
        let l = UILabel()
        l.text = "NAME LASTNAME"
        l.textAlignment = .center
        l.numberOfLines = 0
        l.font = UIFont(name: "Downtown", size: 26)
        l.textColor = .white
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
        
        
    }()
    
    
    private lazy var cardExp: UILabel = {
        
        let l = UILabel()
        l.text = "01/25"
        l.textAlignment = .center
        l.numberOfLines = 0
        l.font = UIFont(name: "Downtown", size: 26)
        l.textColor = .white
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
        
        
    }()
    
    
    private lazy var cardCVV: UILabel = {
        
        let l = UILabel()
        l.text = "***"
        l.textAlignment = .center
        l.numberOfLines = 0
        l.font = UIFont(name: "Downtown", size: 26)
        l.textColor = .white
        l.translatesAutoresizingMaskIntoConstraints = false
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
        addSubview(cardImage)
        addSubview(cardNumber)
//        addSubview(cardExp)
//        addSubview(cardCVV)

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
    cardNumber.centerYAnchor.constraint(equalTo: cardImage.centerYAnchor, constant: 20),
    cardNumber.leadingAnchor.constraint(equalTo: cardImage.leadingAnchor, constant: 56),
    cardNumber.trailingAnchor.constraint(equalTo: cardImage.trailingAnchor, constant: -56),
    cardNumber.heightAnchor.constraint(equalToConstant: 32)
])
        
//        NSLayoutConstraint.activate([
//            cardExp.trailingAnchor.constraint(equalTo: cardImage.trailingAnchor, constant: -56),
//            cardExp.centerYAnchor.constraint(equalTo: cardImage.centerYAnchor, constant: 56),
//            cardExp.heightAnchor.constraint(equalToConstant: 24),
//            cardExp.widthAnchor.constraint(equalToConstant: 64)
//        ])
//        
//        NSLayoutConstraint.activate([
//            cardCVV.trailingAnchor.constraint(equalTo: cardImage.trailingAnchor, constant: -56),
//            cardCVV.centerYAnchor.constraint(equalTo: cardImage.centerYAnchor, constant: 88),
//            cardCVV.heightAnchor.constraint(equalToConstant: 24),
//            cardCVV.widthAnchor.constraint(equalToConstant: 64)
//        ])

//        NSLayoutConstraint.activate([
//            
//            cardName.centerYAnchor.constraint(equalTo: cardImage.centerYAnchor, constant: 88),
//            cardName.leftAnchor.constraint(equalTo: cardImage.leftAnchor, constant: 56),
//            cardName.heightAnchor.constraint(equalToConstant: 32),
//            cardName.widthAnchor.constraint(equalToConstant: 144)
//            
//        ])


        
    }
    
}
