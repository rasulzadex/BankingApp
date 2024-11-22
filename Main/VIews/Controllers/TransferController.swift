//
//  TransferController.swift
//  BankAPP
//
//  Created by Javidan on 15.11.24.
//

import UIKit

class TransferController: BaseViewController {

    private lazy var greenView: UILabel = {
        let l = UILabel()
        l.backgroundColor = .appGreen.withAlphaComponent(0.8)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
        
    }()
    
    private lazy var fromCard: ReusableLabel = {
        let l = ReusableLabel(text: "Transfer from card", textAlignment: .left, fontName: "", fontSize: 14, textColor: .appGreen, numberOfLines: 0, cornerRadius: 10)
        l.backgroundColor = .white.withAlphaComponent(0.9)
        l.setLeftPaddingForLabel(50)
        return l
    }()
    
    private lazy var toCard: ReusableLabel = {
        let l = ReusableLabel(text: "Transfer to card", textAlignment: .left, fontName: "", fontSize: 14, textColor: .appGreen, numberOfLines: 0, cornerRadius: 10)
        l.backgroundColor = .white.withAlphaComponent(0.9)
        l.setLeftPaddingForLabel(10)
        return l
        
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func configureView() {
        super.configureView()
        view.addViews(view: [greenView, fromCard, toCard])
    }
    
    override func configureConstraint() {
        super.configureConstraint()
        NSLayoutConstraint.activate([
            greenView.topAnchor.constraint(equalTo: view.topAnchor),
            greenView.leftAnchor.constraint(equalTo: view.leftAnchor),
            greenView.rightAnchor.constraint(equalTo: view.rightAnchor),
            greenView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
        NSLayoutConstraint.activate([
            fromCard.topAnchor.constraint(equalTo: view.topAnchor, constant: 144),
            fromCard.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            fromCard.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            fromCard.heightAnchor.constraint(equalToConstant: 40)
        ])
        NSLayoutConstraint.activate([
            toCard.topAnchor.constraint(equalTo: fromCard.topAnchor, constant: 100),
            toCard.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            toCard.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            toCard.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

}
