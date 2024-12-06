//
//  TransferController.swift
//  BankAPP
//
//  Created by Javidan on 15.11.24.
//

import UIKit
import RealmSwift

final class TransferController: BaseViewController {

    private let viewModel: TransferViewModel
    private var selectedFromCard: CardModel?
    private var selectedToCard: CardModel?
    
    
    weak var transferdelegate: CardControllerDelegate?

    
    init(viewModel: TransferViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        fetchCardList()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func fetchCardList() {
        viewModel.fetchCardList()
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
    private lazy var cardType: ReusableImageView = {
        let i = ReusableImageView(imageName: " ", contentMode: .scaleAspectFill)
        return i
    }()
    private lazy var cardTypeTo: ReusableImageView = {
        let i = ReusableImageView(imageName: " ", contentMode: .scaleAspectFill)
        return i
    }()
    private lazy var transferAmount: ReusableTextField = {
        let t = ReusableTextField(placeholder: "Transfer amount", placeholderColor: .appGreen, borderColor: .white, texttColor: .appGreen, bgColor: .white.withAlphaComponent(0.7))
        t.delegate = self
        t.textAlignment = .center
        return t
    }()
    private lazy var fromLabel: ReusableLabel = {
        let l = ReusableLabel(text: "Click to select", textAlignment: .center, fontName: "", fontSize: 12, textColor: .appGreen, numberOfLines: 0, cornerRadius: 10)
        
        l.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(fromCardAction))
        l.addGestureRecognizer(tapGesture)
        return l
    }()
    private lazy var fromView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white.withAlphaComponent(0.7)
        v.layer.cornerRadius = 10
        return v
    }()
    private lazy var toView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white.withAlphaComponent(0.7)
        v.layer.cornerRadius = 10
        return v
        
    }()
    private lazy var toLabel: ReusableLabel = {
        let l = ReusableLabel(text: "Click to select", textAlignment: .center, fontName: "", fontSize: 12, textColor: .appGreen, numberOfLines: 0, cornerRadius:  10)
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
    private lazy var fromBalance: ReusableLabel = {
        let l = ReusableLabel(text: "", textAlignment: .left, fontName: "", fontSize: 12, textColor: .appGreen, numberOfLines: 1, cornerRadius: 0)
        l.font = UIFont.systemFont(ofSize: 16)
        return l
    }()
    private lazy var toBalance: ReusableLabel = {
        let l = ReusableLabel(text: "", textAlignment: .left, fontName: "", fontSize: 12, textColor: .appGreen, numberOfLines: 1, cornerRadius: 0)
        l.font = UIFont.systemFont(ofSize: 16)
        return l
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func configureView() {
        super.configureView()
        view.addViews(view: [greenView,  fromView, toView, cardType, cardTypeTo, fromCard, toCard, fromLabel, toLabel, transferAmount, currencyLabel, transferButton, fromBalance, toBalance ])
        configureViewModel()
    }
    
    @objc private func transferAction() {
        guard let amountText = transferAmount.text,
              viewModel.validateTransferAmount(amountText: amountText, selectedFromCard: selectedFromCard) else {
            viewModel.listener?(.error("Please select correct amount"))
            
            return
        }
        
        guard let fromCard = selectedFromCard, let toCard = selectedToCard else {
            viewModel.listener?(.error("Please select both source and destination cards."))

            return
        }
        
        if fromCard == toCard {
            viewModel.listener?(.error("Cards cannot be same"))

        } else {
            guard let amountText = transferAmount.text, let amount = Double(amountText) else {
                viewModel.listener?(.error("Select valid transfer amount"))
                
                return
            }
            viewModel.executeTransfer(fromCard: fromCard, toCard: toCard, amount: amount)
            transferdelegate?.didAddCard()
            navigationController?.popViewController(animated: true)
            viewModel.listener?(.success("Transfer handled successfully"))
            showAlert(message: "Transfer successful!")
            
        }
    }
    
     private func resetUI() {
        fromLabel.text = "Click to select"
        toLabel.text = "Click to select"
        transferAmount.text = ""
        fromBalance.text = ""
        toBalance.text = ""
        cardTypeTo.image = UIImage(named: " ")
        cardType.image = UIImage(named: " ")
    }
    
    @objc private func fromCardAction() {
        let vc = CardSelectionController(viewModel: CardSelectionViewModel())
        
        vc.sendCardinfo = { [weak self] card in
            self?.selectedFromCard = card
            self?.fromLabel.text = card.cardNumber
            self?.fromBalance.text = card.cardBalance
            
        }
        
        
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        present(vc, animated: true)
        viewModel.listener?(.success("Card has been selected"))

    }
    
    @objc private func toCardAction() {
        let vc = CardSelectionController(viewModel: CardSelectionViewModel())
        
        vc.sendCardinfo = { [weak self] card in
            self?.selectedToCard = card
            self?.toLabel.text = card.cardNumber
            self?.toBalance.text = card.cardBalance
        }
        
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        present(vc, animated: true)
        viewModel.listener?(.success("Card has been selected"))
        
    }

    private func configureViewModel() {
        viewModel.listener = {[weak self] state in
            guard let self = self else { return }
            switch state {
            case .success(let message):
                DispatchQueue.main.async {
                    print(message)
                
                }
            case .error(let message):
                DispatchQueue.main.async {
                    self.showAlert(message: message)
                }
            }
        }
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
            fromView.topAnchor.constraint(equalTo: fromCard.bottomAnchor, constant: 0),
            fromView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            fromView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            fromView.heightAnchor.constraint(equalToConstant: 48)
        ])
        NSLayoutConstraint.activate([
        toCard.topAnchor.constraint(equalTo: fromView.bottomAnchor, constant: 32),
        toCard.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
        toCard.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
        toCard.heightAnchor.constraint(equalToConstant: 40)
    ])
        NSLayoutConstraint.activate([
            toView.topAnchor.constraint(equalTo: toCard.bottomAnchor, constant: 0),
            toView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            toView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            toView.heightAnchor.constraint(equalToConstant: 48)
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
        
        NSLayoutConstraint.activate([
            fromLabel.leftAnchor.constraint(equalTo: cardType.rightAnchor, constant: 0),
            fromLabel.rightAnchor.constraint(equalTo: fromBalance.leftAnchor, constant: 0),
            fromLabel.topAnchor.constraint(equalTo: fromView.topAnchor, constant: 2),
            fromLabel.heightAnchor.constraint(equalToConstant: 44),
            
            toLabel.leftAnchor.constraint(equalTo: cardTypeTo.rightAnchor, constant: 0),
            toLabel.rightAnchor.constraint(equalTo: toBalance.leftAnchor, constant: 0),
            toLabel.topAnchor.constraint(equalTo: toView.topAnchor, constant: 2),
            toLabel.heightAnchor.constraint(equalToConstant: 44),
            
        ])
        
        NSLayoutConstraint.activate([
            cardType.leftAnchor.constraint(equalTo: fromView.leftAnchor, constant: 16),
            cardType.rightAnchor.constraint(equalTo: fromLabel.leftAnchor, constant: 0),
            cardType.topAnchor.constraint(equalTo: fromView.topAnchor, constant: 2),
            cardType.heightAnchor.constraint(equalToConstant: 44),
            cardType.widthAnchor.constraint(equalToConstant: 44)
            
        ])
        
        
        NSLayoutConstraint.activate([
            cardTypeTo.leftAnchor.constraint(equalTo: toView.leftAnchor, constant: 16),
            cardTypeTo.rightAnchor.constraint(equalTo: toLabel.leftAnchor, constant: 0),
            cardTypeTo.topAnchor.constraint(equalTo: toView.topAnchor, constant: 2),
            cardTypeTo.heightAnchor.constraint(equalToConstant: 44),
            cardTypeTo.widthAnchor.constraint(equalToConstant: 44)
            
        ])
        
        
        NSLayoutConstraint.activate([
            fromBalance.leftAnchor.constraint(equalTo: fromLabel.rightAnchor, constant: 0),
            fromBalance.rightAnchor.constraint(equalTo: fromView.rightAnchor, constant: -16),
            fromBalance.topAnchor.constraint(equalTo: fromView.topAnchor, constant: 2),
            fromBalance.heightAnchor.constraint(equalToConstant: 44),
            fromBalance.widthAnchor.constraint(equalToConstant: 64)
            
        ])
        
        NSLayoutConstraint.activate([
            toBalance.leftAnchor.constraint(equalTo: toLabel.rightAnchor, constant: 0),
            toBalance.rightAnchor.constraint(equalTo: toView.rightAnchor, constant: -16),
            toBalance.topAnchor.constraint(equalTo: toView.topAnchor, constant: 2),
            toBalance.heightAnchor.constraint(equalToConstant: 44),
            toBalance.widthAnchor.constraint(equalToConstant: 64)
            
        ])
        
        
    }

}

extension TransferController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
    }
    
}
