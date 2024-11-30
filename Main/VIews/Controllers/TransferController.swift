//
//  TransferController.swift
//  BankAPP
//
//  Created by Javidan on 15.11.24.
//

import UIKit
import RealmSwift

class TransferController: BaseViewController {

    private let realm = try? Realm()
    var cardList: Results<CardModel>?
    
    var selectedFromCardRow: Int?
    var selectedToCardRow: Int?
    
    
    var selectedFromCard: CardModel?
        var selectedToCard: CardModel?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        fetchCustomerList()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fetchCustomerList() {
        self.cardList = realm?.objects(CardModel.self)
    }
    
    private lazy var greenView: UILabel = {
        let l = UILabel()
        l.backgroundColor = .appGreen.withAlphaComponent(0.8)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
        
    }()
    
    private lazy var fromCard: ReusableLabel = {
        let l = ReusableLabel(text: "Select a card transfer from", textAlignment: .left, fontName: "", fontSize: 14, textColor: .white, numberOfLines: 0, cornerRadius: 10)
        l.backgroundColor = .clear
        l.isUserInteractionEnabled = true
        return l
    }()
    
    private lazy var toCard: ReusableLabel = {
        let l = ReusableLabel(text: "Select a card to transfer", textAlignment: .left, fontName: "", fontSize: 14, textColor: .white, numberOfLines: 0, cornerRadius: 10)
        l.backgroundColor = .clear
        l.isUserInteractionEnabled = true
        return l
        
    }()
    
    private lazy var transferAmount: ReusableTextField = {
        let t = ReusableTextField(placeholder: "Transfer amount", placeholderColor: .appGreen, borderColor: .white, texttColor: .appGreen, bgColor: .white.withAlphaComponent(0.7))
        t.delegate = self
        t.textAlignment = .center
        return t
    }()
    
    private lazy var fromLabel: ReusableLabel = {
        let l = ReusableLabel(text: "Click to select", textAlignment: .center, fontName: "", fontSize: 12, textColor: .appGreen, numberOfLines: 0, cornerRadius: 10)
        l.backgroundColor = .white.withAlphaComponent(0.7)
        l.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(fromCardAction))
        l.addGestureRecognizer(tapGesture)
        return l
    }()
    
    private lazy var toLabel: ReusableLabel = {
        let l = ReusableLabel(text: "Click to select", textAlignment: .center, fontName: "", fontSize: 12, textColor: .appGreen, numberOfLines: 0, cornerRadius:  10)
        l.backgroundColor = .white.withAlphaComponent(0.7)
        l.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toCardAction))
        l.addGestureRecognizer(tapGesture)
        return l
    }()
    
    private lazy var currencyLabel: ReusableLabel = {
        let l = ReusableLabel(text: "AZN", textAlignment: .center, fontName: "", fontSize: 14, textColor: .appGreen, numberOfLines: 0, cornerRadius: 10)
        l.backgroundColor  = .white.withAlphaComponent(0.7)
        l.layer.borderColor = UIColor.white.withAlphaComponent(0.7).cgColor
        l.layer.borderWidth = 1
        return l
    }()
    
    
    private lazy var transferButton: ReusableButton = {
        let b = ReusableButton(title: "Transfer", buttonColor: .appYellow) {
            [weak self] in self?.transferAction()
        }
        return b
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func configureView() {
        super.configureView()
        view.addViews(view: [greenView, fromCard, toCard, fromLabel, toLabel, transferAmount, currencyLabel, transferButton])
    }
    
    @objc func transferAction() {
        executeTransfer()
//        navigationController?.popViewController(animated: true)
        
    }

    @objc func fromCardAction() {
        let vc = CardSelectionController()
        
        vc.sendCardinfo = { [weak self] card in
                 self?.selectedFromCard = card
                 self?.fromLabel.text = card.cardNumber
             }
        
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        present(vc, animated: true)
    }

    @objc func toCardAction() {
        let vc = CardSelectionController()
        
        vc.sendCardinfo = { [weak self] card in
                 self?.selectedToCard = card
                 self?.toLabel.text = card.cardNumber
             }
        
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        present(vc, animated: true)
    }
    
    func validateTransferAmount() -> Bool {
        guard let amountText = transferAmount.text, let amount = Double(amountText), amount > 0 else {
            showAlert(message: "Please enter a valid transfer amount.")
            return false
        }

        guard let fromCard = selectedFromCard else {
            showAlert(message: "Please select the 'from' card.")
            return false
        }

        guard let fromCardBalance = Double(fromCard.cardBalance) else {
            showAlert(message: "Invalid card balance.")
            return false
        }

        if fromCardBalance < amount {
            showAlert(message: "Insufficient balance on the selected card.")
            return false
        }

        return true
    }

    
    func executeTransfer() {
        guard validateTransferAmount() else { return }
        guard let fromCard = selectedFromCard, let toCard = selectedToCard else {
            showAlert(message: "Please select both source and destination cards.")
            return
        }
        if fromCard == toCard {
            showAlert(message: "You cannot transfer between same card")
        }else{
            
            guard let amountText = transferAmount.text, let amount = Double(amountText) else {
                showAlert(message: "Please enter a valid transfer amount.")
                return
            }
            
            do {
                try realm?.write {
                    guard var fromCardBalance = Double(fromCard.cardBalance),
                          var toCardBalance = Double(toCard.cardBalance) else {
                        showAlert(message: "Invalid card balance.")
                        return
                    }
                    
                    fromCardBalance -= amount
                    toCardBalance += amount
                    
                    fromCard.cardBalance = String(fromCardBalance)
                    toCard.cardBalance = String(toCardBalance)
                    
                    realm?.add(fromCard, update: .modified)
                    realm?.add(toCard, update: .modified)
                }
                
                showAlert(message: "Transfer successful!")
                
                fromLabel.text = "Click to select"
                toLabel.text = "Click to select"
                transferAmount.text = ""
                
            } catch {
                showAlert(message: "An error occurred while processing the transfer.")
            }
        }
    }


    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
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
            fromCard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            fromCard.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            fromCard.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            fromCard.heightAnchor.constraint(equalToConstant: 40)
        ])
        NSLayoutConstraint.activate([
            fromLabel.topAnchor.constraint(equalTo: fromCard.bottomAnchor, constant: 0),
            fromLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            fromLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            fromLabel.heightAnchor.constraint(equalToConstant: 48)
        ])
        NSLayoutConstraint.activate([
        toCard.topAnchor.constraint(equalTo: fromLabel.bottomAnchor, constant: 32),
        toCard.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
        toCard.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
        toCard.heightAnchor.constraint(equalToConstant: 40)
    ])
        NSLayoutConstraint.activate([
            toLabel.topAnchor.constraint(equalTo: toCard.bottomAnchor, constant: 0),
            toLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            toLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            toLabel.heightAnchor.constraint(equalToConstant: 48)
        ])
        NSLayoutConstraint.activate([
            transferAmount.topAnchor.constraint(equalTo: toLabel.bottomAnchor, constant: 32),
            transferAmount.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            transferAmount.rightAnchor.constraint(equalTo: currencyLabel.leftAnchor, constant: -16),
            transferAmount.heightAnchor.constraint(equalToConstant: 40)
        ])
        NSLayoutConstraint.activate([
            currencyLabel.topAnchor.constraint(equalTo: toLabel.bottomAnchor, constant: 32),
            currencyLabel.leftAnchor.constraint(equalTo: transferAmount.rightAnchor, constant: 16),
            currencyLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            currencyLabel.heightAnchor.constraint(equalToConstant: 40),
            currencyLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
        NSLayoutConstraint.activate([
            transferButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            transferButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            transferButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            transferButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

}

extension TransferController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
    }
    
}
